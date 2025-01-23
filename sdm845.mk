#
# Copyright (C) 2017-2018 The LineageOS Project
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

# Add common definitions for Qualcomm
$(call inherit-product, hardware/qcom-caf/common/common.mk)

# Common device tree path
COMMON_PATH := device/lge/sdm845-common

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(COMMON_PATH)/overlay \
    $(COMMON_PATH)/overlay-lineage

PRODUCT_ENFORCE_RRO_TARGETS := *
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    $(COMMON_PATH)/overlay-lineage/lineage-sdk

# Properties
TARGET_ODM_PROP += $(COMMON_PATH)/odm.prop
TARGET_SYSTEM_PROP += $(COMMON_PATH)/system.prop
TARGET_VENDOR_PROP += $(COMMON_PATH)/vendor.prop

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := 560dpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

# Additional native libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# A/B support
PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_verifier

PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti \
    android.hardware.boot@1.1-impl-qti.recovery \
    android.hardware.boot@1.1-service

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# The following modules are included in debuggable builds only.
PRODUCT_PACKAGES_DEBUG += \
    update_engine_client \
    update_engine_sideload

# Audio
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    audio.bluetooth.default \
    audio.usb.default

PRODUCT_PACKAGES += \
    android.hardware.audio.effect@6.0-impl \
    android.hardware.audio.service \
    android.hardware.audio@6.0-impl \
    android.hardware.bluetooth.audio-impl \
    audio.primary.sdm845 \
    audio_amplifier.lge \
    liba2dpoffload \
    libbatterylistener \
    libcomprcapture \
    libexthwplugin \
    libhdmiedid \
    libhfp \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libsndmonitor \
    libspkrprot \
    libtinycompress \
    libvolumelistener \
    tinymix

PRODUCT_PACKAGES += \
    android.hardware.soundtrigger@2.2-impl \
    sound_trigger.primary.sdm845

PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/audio/audio_io_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_io_policy.conf \
    $(COMMON_PATH)/configs/audio/audio_output_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_output_policy.conf \
    $(COMMON_PATH)/configs/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    $(COMMON_PATH)/configs/audio/audio_tuning_mixer_tavil.txt:$(TARGET_COPY_OUT_VENDOR)/etc/audio_tuning_mixer_tavil.txt \
    $(COMMON_PATH)/configs/audio/bluetooth_hearing_aid_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_hearing_aid_audio_policy_configuration.xml \
    $(COMMON_PATH)/configs/audio/graphite_ipc_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/graphite_ipc_platform_info.xml \
    $(COMMON_PATH)/configs/audio/listen_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/listen_platform_info.xml

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

# ANT+
PRODUCT_PACKAGES += \
    AntHalService-Soong

# Boot animation
TARGET_BOOTANIMATION_HALF_RES := true
TARGET_SCREEN_HEIGHT := 3120
TARGET_SCREEN_WIDTH := 1440

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service \
    vendor.qti.hardware.camera.device@1.0

# Cgroup and task profiles
PRODUCT_COPY_FILES += \
    system/core/libprocessgroup/profiles/cgroups_28.json:$(TARGET_COPY_OUT_VENDOR)/etc/cgroups.json \
    system/core/libprocessgroup/profiles/task_profiles_28.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json

# Context Hub
PRODUCT_PACKAGES += \
    android.hardware.contexthub@1.0-impl.generic \
    android.hardware.contexthub@1.0-service

# ConfigStore
PRODUCT_PACKAGES += \
    disable_configstore

# DAC
PRODUCT_PACKAGES += \
    QuadDACPanel \
    vendor.lge.hardware.audio.dac.control@2.0-service

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.3-service \
    android.hardware.graphics.mapper@2.0-impl-qti-display \
    gralloc.sdm845 \
    hwcomposer.qcom \
    vendor.qti.hardware.display.allocator@1.0-service \
    vendor.qti.hardware.display.config-V5-ndk \
    vendor.qti.hardware.display.mapper@3.0.vendor \
    vendor.qti.hardware.display.mapperextensions@1.0.vendor \
    vendor.qti.hardware.memtrack-service

# Doze
PRODUCT_PACKAGES += \
    LGEDoze

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Fingerprint
ifneq ($(filter caymanslm judypn judyln,$(DEVICE_NAME)),)
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.lge
endif

# FM packages
PRODUCT_PACKAGES += \
    FM2 \
    libqcomfm_jni \
    qcom.fmradio

# GPS
PRODUCT_PACKAGES += \
    flp.conf \
    gps.conf \
    izat.conf \
    lowi.conf \
    sap.conf \
    xtwifi.conf

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# Hotword Enrollement
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/permissions/product_privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml

# Init
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/rootdir/etc/fstab.hardware:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.$(DEVICE_NAME)

PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/rootdir/etc/fstab.hardware:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(DEVICE_NAME) \
    $(COMMON_PATH)/rootdir/etc/init.hardware.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(DEVICE_NAME).rc \
    $(COMMON_PATH)/rootdir/etc/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc

$(foreach f,$(wildcard $(COMMON_PATH)/rootdir/etc/init/hw/*.rc),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/$(notdir $f)))
$(foreach f,$(wildcard $(COMMON_PATH)/rootdir/etc/init/*.rc),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/etc/init/$(notdir $f)))
$(foreach f,$(wildcard $(COMMON_PATH)/rootdir/bin/*.sh),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/bin/$(notdir $f)))

# IPA
PRODUCT_PACKAGES += \
    ipacm \
    IPACM_cfg.xml

# IRQ balance
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# Keylayout
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/keylayout/gpio-keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/gpio-keys.kl

# Light
PRODUCT_PACKAGES += \
    android.hardware.light-service.lge

# LiveDisplay
PRODUCT_PACKAGES += \
    vendor.lineage.livedisplay@2.0-service.lge

# Lineage Health
PRODUCT_PACKAGES += \
    vendor.lineage.health-service.default

# Media
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/media/media_codecs_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(COMMON_PATH)/configs/media/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(COMMON_PATH)/configs/media/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles.xml \
    $(COMMON_PATH)/configs/media/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    $(COMMON_PATH)/configs/media/media_profiles_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml \
    $(COMMON_PATH)/configs/system_properties.xml:$(TARGET_COPY_OUT_VENDOR)/etc/system_properties.xml

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_video.xml

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2-service \
    com.android.nfc_extras \
    NfcNci \
    SecureElement \
    Tag \
    vendor.nxp.nxpese@1.0.vendor:64 \
    vendor.nxp.nxpnfc@1.0.vendor:64

ifneq ($(filter judypn judyln judyp,$(DEVICE_NAME)),)
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/nfc/pn547/libnfc-nci.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci.conf \
    $(COMMON_PATH)/configs/nfc/pn547/libnfc-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf
endif

# OMX
PRODUCT_PACKAGES += \
    libOmxCore \
    libOmxVdec \
    libOmxVenc \
    libc2dcolorconvert \
    libcodec2_hidl@1.0.vendor \
    libcodec2_vndk.vendor \
    libmm-omxcore \
    libstagefright_softomx.vendor \
    libstagefrighthw

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml

# Power
PRODUCT_PACKAGES += \
    libqti-perfd-client \
    android.hardware.power-service.lineage-libperfmgr

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Protobuf
PRODUCT_PACKAGES += \
    libprotobuf-cpp-lite-vendorcompat

# QMI
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/qmi_fw.conf:$(TARGET_COPY_OUT_VENDOR)/etc/qmi_fw.conf

# Permissions
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/permissions/privapp-permissions-qti.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-qti.xml \
    $(COMMON_PATH)/configs/permissions/privapp-permissions-lge_sdm845.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-lge_sdm845.xml \
    $(COMMON_PATH)/configs/permissions/telephony_product_privapp-permissions-qti.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/telephony_product_privapp-permissions-qti.xml \
    $(COMMON_PATH)/configs/permissions/telephony_system-ext_privapp-permissions-qti.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/telephony_system-ext_privapp-permissions-qti.xml

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.hardware.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.$(DEVICE_NAME).rc

# Radio
PRODUCT_PACKAGES += \
    android.hardware.radio@1.4-service.lge

# Seccomp policy
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/seccomp/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    $(LOCAL_PATH)/configs/seccomp/mediaextractor.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl \
    android.hardware.sensors@1.0-service

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(COMMON_PATH) \
    hardware/lge \
    hardware/google/interfaces \
    hardware/google/pixel \
    hardware/lineage/interfaces/power-libperfmgr \
    hardware/qcom-caf/common/libqti-perfd-client

# Telephony
PRODUCT_PACKAGES += \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine-845.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-845.conf

# Touch
PRODUCT_PACKAGES += \
    vendor.lineage.touch@1.0-service.lge_sdm845

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.3-service.dual_role_usb

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator-service.lge

# Vintf
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := true

# WiFi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    hostapd \
    libwifi-hal-qcom \
    libwpa_client \
    WifiOverlay \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \
    $(COMMON_PATH)/configs/wifi/wifi_concurrency_cfg.txt:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wifi_concurrency_cfg.txt \
    $(COMMON_PATH)/configs/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(COMMON_PATH)/configs/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini

# WiFi firmware symlinks
PRODUCT_PACKAGES += \
    firmware_WCNSS_qcom_cfg.ini_symlink \
    firmware_wlan_mac.bin_symlink

# Inherit proprietary blobs
$(call inherit-product, vendor/lge/sdm845-common/sdm845-common-vendor.mk)
