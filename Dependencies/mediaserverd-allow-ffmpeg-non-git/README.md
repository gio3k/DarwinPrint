This dynamic library / MobileLoader tweak allows executables *named* ffmpeg the permission to use the camera in the background.

## Where's the source code?
#####  (or "will the source code be released?")
The source code is left private for now on purpose to keep a little barrier up from people who want to use this code for evil.
While it's *technically* possible to patch the library to remove the alert / change the allowed executable name, a developer that's proficient enough to do that could just make their own library (this method *is* [public](https://blog.zecops.com/research/how-ios-malware-can-spy-on-users-silently/), but please don't) 
I've done my best to make this library as forward as possible about what it does (see next section)

## This seems like a privacy risk!
Well, yes!
I've done what I can to lessen the privacy risk / help me sleep at night:
 - it makes an on-screen alert every time FFmpeg starts using the camera
 - it isn't open source so it's not *too* easy to be evil (see above section)
 - iOS keeps a green dot in the corner *the whole time* the camera is used

While it's not perfect, it's as much as I can reasonably do.

## Credits
I used code / information from these people / resources:
https://blog.zecops.com/research/how-ios-malware-can-spy-on-users-silently/
https://stackoverflow.com/a/15455596
