# Keyboard layout
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/keylayout/mtk-kpd.kl:system/usr/keylayout/mtk-kpd.kl \
	$(LOCAL_PATH)/configs/keylayout/ACCDET.kl:system/usr/keylayout/ACCDET.kl \
	$(LOCAL_PATH)/configs/keylayout/Generic.kl:system/usr/keylayout/Generic.kl

# Keyhandler
# PRODUCT_PACKAGES += \
#	com.cyanogenmod.keyhandler
#
# PRODUCT_SYSTEM_SERVER_JARS += com.cyanogenmod.keyhandler
#
# Never dexopt the keyhandler
# $(call add-product-dex-preopt-module-config,com.cyanogenmod.keyhandler,disable)
