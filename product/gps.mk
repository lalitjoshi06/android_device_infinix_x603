# GPS
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl \
	gps.mt6757 \
    libcurl \
    libepos \
    YGPS

PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/configs/gps/agps_profiles_conf2.xml:system/vendor/etc/agps_profiles_conf2.xml

