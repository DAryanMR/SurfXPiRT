#! /bin/sh -e

# Load Drivers
echo "Loading modules..."
for module in \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/bluetooth/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/gpu/drm/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/gpu/drm/i2c/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/gpu/drm/ttm/ttm.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/i2c/busses/i2c-cros-ec-tunnel.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/input/mouse/elan_i2c.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/media/dvb-frontends/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/media/dvb-frontends/cxd2880/cxd2880.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/media/dvb-frontends/drx39xyj/drx39xyj.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/media/spi/cxd2880-spi.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/media/tuners/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/net/wireless/broadcom/brcm80211/brcmutil/brcmutil.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/platform/chrome/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/thermal/tegra/*.ko
do
    insmod $module
    echo "Loaded module: $(basename $module)"
done

echo ""
echo "All Drivers loaded." 

exit 0
