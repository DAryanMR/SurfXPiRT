# SurfXPiRT (Stable Debian 12 + XFCE for the Surface RT )

Updates:
- Added one-command-installer (SurfUpXplosion), check walkthrough.txt
- Desktop environment has been changed from LXDE to XFCE due to it's more modern nature and touch friendlier env.

I attempted to install Vanilla Debian with XFCE Desktop environment on Microsoft's legendary Surface RT, 
and hopefully tried to take the opensurface project one step further. 

Supported features: WiFi, Bluetooth, HWA, Audio Output, VLC, WebGL, Responsive Touchscreen, thermal management, optimized resource usage management, insane battery life, etc. (Overall standalone usability)

Pre-requisites: Golden Keys & Yahallo Installed (Secure boot disabled)

Debian 12 Installation Tutorial: https://www.youtube.com/watch?v=RKzyT7Vtjrs
(This is almost like a really how to install linux on surface rt, it'd be best to run SurfUpXplosion (one-command-installer, mentioned in walkthrough.txt) as you don't have to modify anything, you can simply boot from your eMMC afterwards) ;)

Official Debian 12 (Bookworm) Raspberry Pi Image: https://raspi.debian.net/tested/20230102_raspi_2_bookworm.img.xz

I do not own any of the files except for the custom scripts (opt folder).  
You can check the introductory video below in the tutorial's description, I've talked about where I got inspired from and how I got rest of the files.

You might notice some bugs here and there as the scripts were written on a rush, but I'm constantly working on their improvements. In the meanwhile, use it to discover what it can do. I even played Chocolate Doom for a while. 

A lot of tweaks are still left undone, I'll find some of which are  to be tweaked and put them on a video or text-form.
- Install and setup xcompmgr to start on boot (If you download the boot files now you won't have to install it, the scripts have been updated to do it automatically, just enable it to run on startup and set it up as default composition manager)
- Run 'xinput_calibrator' without quotes and setup touchscreen calibration 
- Open and configure Onboard (On screen keyboard)
- Enable virtual keyboard for xscreensaver lock   (Still not implemented) Screen can be brought back from locked state without physical keyboard but if you suspend the system then you'll need a keyboard to unlock it again. :(
- libwidevine installation to test out how Netflix performs. (will do that soon hopefully)

Open chromium-lightweight, go to chrome://flags, enable these flags:
![Screenshot from 2023-05-07 19-45-50](https://user-images.githubusercontent.com/132191670/236684295-49e6aadc-6dc5-4d8a-9579-7dbcf1b4f9d0.png)

try using it in windowed mode because it provides stable fps.


Pro Tip: Use it in portrait mode for best standalone performance:
Open arandr, click on Layout,open,standalone-portrait.sh, open, hit apply

Notes: 
1. Navigate to Menu -> Internet , open chromium-lightweight, I've highly optimized it to deliver the best performance, it runs websites on Android 9's platform, which helps it easily render them. Minimising it suspends the browser which makes other tasks smoother. There should also be a directory in your Desktop named standalone-apps, where you'll find the desktop apps including the modified browser, try them out. You can type in "chromium-lightweight" without the quotes from anywhere in the terminal and it'll run as well. Let me know how it performs ;) 
2. It's best to run videos on youtube using windowed mode of chromium-lightweight with default playback quality, it performs pretty well and I'm planning on tweaking it to do even better. 
3. On startup, open the rt-wifi-client and click on 'Auto-connect', choose yes & you should be connected to the internet. Or if you're a terminal person, then run 'sudo rc-local' and it'll do the same.
4. Use the rt-wifi-client's 'Scan' & 'Connect' option only to connect to new wifi ssids when your default wifi is down or if you're away from it.
If you're already connected to a network then tapping on scan one time might not pop up other ssids, keep slamming the scan button until you see the ssids popping up, while selecting, slam your wifi ssid too if you dont see 'psk for: your_ssid' popping above the password prompt. Tap on connect after you see that.
If the wifi client doesn't connect you to the internet reboot to check if you can normally connect.
5. If video streaming is the one & only thing in your life then this might not be the most perfect distro for you, but if it's one of all the things you want to do, then go ahead give it a try.
