### Debian 12 (Bookworm) for the Surface RT | Walkthrough
### In dept shown in video tutorial

After initially booting from the usb, follow some preliminary steps: 
  resize the filesystem;
  update fstab values to mount:
    /dev/mmcblk1p2  as   /
    /dev/mmcblk1p1  as   /boot/firmware 
  update hostname && hosts;
  create user 'pi'; get sudo rights for pi; (must name it pi for the scripts to work!)

then: 
  move to /opt/custom-scripts/ 
    make all .sh && .py files executable;
    run the scripts serialwise:
      load-drivers;
      wifi-setup;
      install-packages;
      install-vulkan;
      clone-disk;

Voila! Your device is ready for daily use.