# Ramdisk
PRODUCT_PACKAGES += \
    enableswap.sh \
    factory_init.project.rc \
    factory_init.rc \
    fstab.mt6757 \
	init.aee.rc \
	init.common_svc.rc \
	init.connectivity.rc \
	init.environ.rc \
	init.microtrust.rc \
    init.modem.rc \
    init.mt6757.rc \
    init.mt6757.usb.rc \
	init.project.rc \
	init.recovery.mt6757.rc \
	init.rilproxy.rc \
	init.sensor.rc \
	init.usb.configfs.rc \
	init.usb.rc \
	init.volte.rc \
	init.zygote32.rc \
	init.zygote64_32.rc \
	meta_init.connectivity.rc \
	meta_init.modem.rc \
	meta_init.project.rc \
	meta_init.rc \
    multi_init.rc \
    recovery.fstab \
    ueventd.mt6757.rc \
    ueventd.rc \
	init.epdg.rc
	
# Properly input of int.rc
PRODUCT_COPY_FILES := \
	$(LOCAL_PATH)/rootdir/etc/init.rc:root/init.rc
