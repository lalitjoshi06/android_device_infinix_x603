#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, $(LOCAL_PATH)/device_x603.mk)
$(call inherit-product, device/infinix/x603/prop.mk)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Release name
PRODUCT_RELEASE_NAME := x603

# Device display
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

## Device identifier. This must come after all inclusions
PRODUCT_BRAND := INFINIX
PRODUCT_DEVICE := x603
PRODUCT_MANUFACTURER := INFINIX
PRODUCT_MODEL := ZERO 5
PRODUCT_NAME := lineage_x603
PRODUCT_RELEASE_NAME := x603
PRODUCT_RESTRICT_VENDOR_FILES := false

# SDcard
PRODUCT_CHARACTERISTICS := nosdcard

# Google client ID property.
PRODUCT_GMS_CLIENTID_BASE := android-infinix

# Build fingerprint from Indian variant.
PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=x603 \
    PRODUCT_NAME=lineage_x603 \
	PRIVATE_BUILD_DESC="full_rlk6757_66_n-user 7.0 NRD90M 1524172887 release-keys"
BUILD_FINGERPRINT := Infinix/H575/Infinix-X603:7.0/NRD90M/X603-H575A-N-IN-180420V205:user/release-keys
