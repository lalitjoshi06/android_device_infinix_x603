# this is BRM release config
# you should migrate turnkey alps/device/mediatek/common/device.mk to this file in correct way

# VoLTE Process
PRODUCT_PACKAGES += Gba
PRODUCT_PACKAGES += volte_xdmc
PRODUCT_PACKAGES += volte_core
PRODUCT_PACKAGES += volte_ua
PRODUCT_PACKAGES += volte_stack
PRODUCT_PACKAGES += volte_imcb
PRODUCT_PACKAGES += libipsec_ims

# MAL
PRODUCT_PACKAGES += libmdfx
PRODUCT_PACKAGES += mtkmal
PRODUCT_PACKAGES += libmal_mdmngr
PRODUCT_PACKAGES += libmal_rilproxy
PRODUCT_PACKAGES += libmal_simmngr
PRODUCT_PACKAGES += libmal_datamngr
PRODUCT_PACKAGES += libmal_rds
PRODUCT_PACKAGES += libmal_epdga
PRODUCT_PACKAGES += libmal_imsmngr
PRODUCT_PACKAGES += libmal

PRODUCT_PACKAGES += volte_imsm
PRODUCT_PACKAGES += volte_imspa

#WVDRM_SUPPORT
  #both L1 and L3 library
  PRODUCT_PACKAGES += com.google.widevine.software.drm.xml
  PRODUCT_PACKAGES += com.google.widevine.software.drm
  PRODUCT_PACKAGES += libdrmmtkutil

  #Mock modular drm plugin for cts
  #both L1 and L3 library
  PRODUCT_PACKAGES += libwvdrmengine
  #package depended by libwvdrmengine
  PRODUCT_PACKAGES += libcdm
  PRODUCT_PACKAGES += libcdm_utils
  PRODUCT_PACKAGES += libwvlevel3
  PRODUCT_PACKAGES += libwvdrmcryptoplugin
  PRODUCT_PACKAGES += libwvdrmdrmplugin
  PRODUCT_PACKAGES += libcdm_protos
  #package depended by libdrmwvmplugin
  PRODUCT_PACKAGES += libdrmwvmcommon
  PRODUCT_PACKAGES += liboemcrypto_static


#MTK_AGPS_APP
  PRODUCT_PACKAGES += LocationEM2 \
                      mtk_agpsd \
                      libssladp

#TODO: libepos is built via MTK_GPS_SUPPORT
#   but we don't know how
  PRODUCT_PACKAGES += libepos

#TODO: check why jpeg library built in some case
  PRODUCT_PACKAGES += libSwJpgCodec
  PRODUCT_PACKAGES += libJpgDecDrv_plat
  PRODUCT_PACKAGES += libJpgDecPipe
  PRODUCT_PACKAGES += libmhalImageCodec
