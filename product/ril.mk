# RIL
PRODUCT_PACKAGES += \
    libccci_util \
    librilmtk \
    mtkrild \
	rilproxy \
	librilproxy \
	mtkrildmd2 \
	mtk-rilmd2 \
	viarild \
	libviatelecom-withuim-ril


# Configurations
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/apns-conf.xml:system/etc/apns-conf.xml

PRODUCT_PACKAGES += \
Stk
# Radio dependencies
PRODUCT_PACKAGES += \
	muxreport \
	terservice \
	gsm0710muxd \
	gsm0710muxdmd2