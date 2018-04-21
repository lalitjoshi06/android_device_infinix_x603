# rootdir
PRODUCT_COPY_FILES += \
	$(DEVICE_PATH)/rootdir/enableswap.sh:root/enableswap.sh \
	$(DEVICE_PATH)/rootdir/factory_init.project.rc:root/factory_init.project.rc \
	$(DEVICE_PATH)/rootdir/factory_init.rc:root/factory_init.rc \
	$(DEVICE_PATH)/rootdir/fstab.mt6757:root/fstab.mt6757 \
	$(DEVICE_PATH)/rootdir/init.microtrust.rc:root/init.microtrust.rc \
	$(DEVICE_PATH)/rootdir/init.modem.rc:root/init.modem.rc \
	$(DEVICE_PATH)/rootdir/init.mt6757.rc:root/init.mt6757.rc \
	$(DEVICE_PATH)/rootdir/init.mt6757.usb.rc:root/init.mt6757.usb.rc \
	$(DEVICE_PATH)/rootdir/init.project.rc:root/init.project.rc \
	$(DEVICE_PATH)/rootdir/init.rilproxy.rc:root/init.rilproxy.rc \
	$(DEVICE_PATH)/rootdir/init.volte.rc:root/init.volte.rc \
	$(DEVICE_PATH)/rootdir/recovery.fstab:root/recovery.fstab \
	$(DEVICE_PATH)/rootdir/ueventd.mt6757.rc:root/ueventd.mt6757.rc