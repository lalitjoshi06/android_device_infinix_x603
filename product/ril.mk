# RIL
PRODUCT_PACKAGES += \
    libccci_util \
    librilmtk \
	librilmtkmd2 \
	mtkrild
# Configurations
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/apns-conf.xml:system/etc/apns-conf.xml

PRODUCT_PACKAGES += \
Stk
# Radio dependencies
PRODUCT_PACKAGES += \
	muxreport \
	terservice