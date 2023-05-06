# SurfXPiRT (Stable Debian 12 + LXDE for the Surface RT )

I attempted to install Vanilla Debian with LXDE Desktop environment on Microsoft's legendary Surface RT, 
and hopefully tried to take the opensurface project one step further. 

Supported features: WiFi, Bluetooth, HWA, Audio Output, VLC, WebGL, Responsive Touchscreen, thermal management, etc.

Pre-requisites: Golden Keys & Yahallo Installed (Secure boot disabled)

Debian 12 Installation Tutorial: https://www.youtube.com/watch?v=RKzyT7Vtjrs

Official Debian 12 (Bookworm) Raspberry Pi Image: https://raspi.debian.net/tested/20230102_raspi_2_bookworm.img.xz

I do not own any of the files except for the custom scripts (opt folder).  
You can check the introductory video below in the tutorial's description, I've talked about where I got inspired from and how I got rest of the files.

You might notice some bugs here and there as the scripts were written on a rush, but I'm constantly working on their improvements. In the meanwhile, use it to discover what it can do. I even played Chocolate Doom for a while. 

Update: Now you can run 'sudo update-surfxpirt' (after cloning to eMMC) to get latest updates of custom scripts and configs.

A lot of tweaks are still left undone, I'll find some of which are  to be tweaked and put them on a video or text-form.
- Install and setup xcompmgr to start on boot (If you download the boot files now you won't have to install it, the scripts have been updated to do it automatically, just enable it to run on startup and set it up as default composition manager)
- Run 'xinput_calibrator' without quotes and setup touchscreen calibration 
- Open and configure Onboard (On screen keyboard)
- Enable virtual keyboard for xscreensaver lock   (Still not implemented) Screen can be brought back from locked state without physical keyboard but if you suspend the system then you'll need a keyboard to unlock it again. :(

Run lsmod and make sure output looks like this otherwise modules didn't load properly: 
![lsmod-1](https://user-images.githubusercontent.com/132191670/236254854-3aaf69a1-4932-4f20-81d5-a6caaea52e48.png)
![lsmod-2](https://user-images.githubusercontent.com/132191670/236254880-ad106af5-62c0-4caf-8a9c-cbedfe4595f2.png)
![lsmod-3](https://user-images.githubusercontent.com/132191670/236254945-736edd07-89aa-49b9-915c-6d9577b54b74.png)

Pro Tip: Use it in portrait mode for best standalone performance:
Open arandr, click on Layout,open,standalone-portrait.sh, open, hit apply

Notes: 
1. Navigate to menu -> Internet , open chromium-lightweight, type in chrome://flags, enable vulkan.
 I've highly optimized it to deliver the best performance, it runs websites on Android 7's platform, which helps it easily render them. There should also be a directory in your Desktop named standalone-apps, where you'll find the desktop apps including the modified browser, try them out. You can type in "chromium-lightweight" without the quotes from anywhere in the terminal and it'll run as well. Let me know how it performs ;)    [Pending: libwidevine installation to test out how Netflix performs. (will do that soon hopefully) ]
2. Use chromium-lightweight to stream videos on youtube, use the default quality set by youtube for best performance. Videos can be streamed at 360p max, however, 240p reduces stress substantially. Looking for workarounds..and working on improvements.  
3. Open the rt-wifi-client and click on 'Auto-connect', choose yes & you should be connected to default network.
4. Use the rt-wifi-client's 'Scan' & 'Connect' option only to connect to new wifi ssids when your default wifi is down or if you're away from it.
If you're already connected to a network then tapping on scan one time might not pop up other ssids, keep slamming the scan button until you see the ssids popping up, while selecting, slam your wifi ssid too if you dont see 'psk for: your_ssid' popping above the password prompt. Tap on connect after you see that on the password prompt.
If the wifi client doesn't connect you to the internet reboot to check if you can normally connect.
5. Do not turn on the device with any usb devices plugged in, plug usb devices after the kernel starts loading up if you notice your touchscreen throwing tantrums or eventually stop functioning until next reboot.
