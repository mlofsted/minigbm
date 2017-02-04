# Copyright (C) 2016 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

SUBDIRS := \
	cros_gralloc

LOCAL_SHARED_LIBRARIES := \
	libdrm \
	liblog \
	libcutils \
	libutils \
	libdrm_intel


LOCAL_C_INCLUDES := \
	external/libdrm \
	external/libdrm/include/drm \
	vendor/intel/external/android_ia/minigbm/cros_gralloc

LOCAL_SRC_FILES := \
        cirrus.c \
	drv.c \
        evdi.c \
	helpers.c \
	i915.c \
        virtio_gpu.c \
        vgem.c \
        udl.c \
        gma500.c \
	nouveau.c

ifeq ($(strip $(BOARD_DISABLE_EXPLICIT_SYNC)),true)
LOCAL_CPPFLAGS += -DDISABLE_EXPLICIT_SYNC
endif

include vendor/intel/external/android_ia/minigbm/Android_cc.mk

LOCAL_CPPFLAGS += -std=c++11 -DDRV_I915 -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
LOCAL_CFLAGS += -Wall -Wsign-compare -Wpointer-arith \
		-Wcast-qual -Wcast-align \
		-isystem vendor/intel/external/android_ia/hwcomposer \
		-DDRV_I915 -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include

LOCAL_MODULE := gralloc.android_ia
LOCAL_MODULE_TAGS := optional
#Preffered paths for all vendor hals /vendor/lib/hw
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := $(TARGET_SHLIB_SUFFIX)
include $(BUILD_SHARED_LIBRARY)
