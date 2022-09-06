#!python3
"""
mjpeg http server
provides mjpeg stream from a changing jpeg on disk, for use with ffmpeg etc
originally based on https://gist.github.com/G33kDude/84fed88a5b62ef189501d14a256a233b
- lotuspar, 2022
"""
import argparse
import os
import time
import shutil
from http.server import SimpleHTTPRequestHandler
from threading import Thread
from socketserver import ThreadingTCPServer

args: argparse.Namespace = None

class FrameRequestHandler(SimpleHTTPRequestHandler):
    """
    HTTP handler: provides stream of frames from a changing file on disk
    """
    def __get_frame(self):
        # copy file first so we don't impede
        output = args.path + ".outbuf"
        data = None
        try:
            shutil.copyfile(args.path, output)
            f = open(output, "rb")
            data = f.read()
            f.close()
            if os.path.exists(output):
                os.unlink(output)
        except:
            print("failed to open frame! sleeping to calibrate")
            time.sleep(args.ct)
        return data

    def do_GET(self):
        """Serve a GET request."""
        self.send_response(200)
        self.send_header('Content-Type', 'multipart/x-mixed-replace;boundary=boundarydonotcross')
        self.end_headers()

        while True:
            jpg = self.__get_frame()
            if jpg is not None:
                self.wfile.write(b'--boundarydonotcross\r\n')
                self.send_header('Content-Type', 'image/jpeg')
                self.send_header('Content-Length', len(jpg))
                self.end_headers()
                self.wfile.write(jpg + b'\r\n')
            time.sleep(1.0 / args.framerate)

parser = argparse.ArgumentParser(description="start outputting a JPEG to a web stream")
parser.add_argument("path")
parser.add_argument("-p", "--port", dest="port", required=True, help="HTTP server port", type=int)
parser.add_argument("--host", dest="host", default="0.0.0.0", help="HTTP server host")
parser.add_argument("-f", "--framerate",
                    dest="framerate", default=15, help="Rate to output images to", type=int)
parser.add_argument("-ct", "--calibration-time",
                    dest="ct", default=0.1,
                    help="Time to sleep after encountering an error", type=float)

args = parser.parse_args()

httpd = ThreadingTCPServer((args.host, args.port), FrameRequestHandler)
print(f"server starting on port {args.port}!")
server_thread = Thread(target=httpd.serve_forever)
server_thread.start()
print("now running!")
server_thread.join()
