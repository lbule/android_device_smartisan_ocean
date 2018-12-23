
# Inherit from our custom product configuration
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit language packages
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Device identifier. This must come after all inclusions
PRODUCT_NAME := omni_ocean
PRODUCT_DEVICE := ocean
PRODUCT_BRAND := Smartisan
PRODUCT_MODEL := Smartisan Pro2s
PRODUCT_MANUFACTURER := Smartisan

# Charger
PRODUCT_PACKAGES += \
	charger_res_images \
	charger

# Encryption
PRODUCT_PACKAGES += \
    libcryptfs_hw

# If needed to overide these props
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT="Smartisan/ocean/ocean:8.1.0/OPM1.171019.026/1530636824:user/dev-keys" \
    PRIVATE_BUILD_DESC="ocean-user 8.1.0 OPM1.171019.026 44 dev-keys"

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.treble.enabled=true \
    sys.usb.controller=a600000.dwc3 \
    persist.sys.usb.config=mtp \
    persist.service.adb.enable=1 \
    persist.service.debuggable=1

TARGET_VENDOR_PRODUCT_NAME := ocean
TARGET_VENDOR_DEVICE_NAME := ocean
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=ocean PRODUCT_NAME=ocean


