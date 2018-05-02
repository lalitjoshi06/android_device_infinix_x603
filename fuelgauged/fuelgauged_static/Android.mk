LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	fgauge_main_2.cpp \
	fg_log.cpp 

LOCAL_CFLAGS += $(MTK_CDEFS)
LOCAL_FORCE_STATIC_EXECUTABLE := true

LOCAL_STATIC_LIBRARIES := libfgauge_static libcutils liblog libc

LOCAL_MODULE:= fuelgauged_static
#bobule workaround pdk build error,  needing review
LOCAL_MULTILIB := 32
LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)/sbin
include $(BUILD_EXECUTABLE)




