FINALPACKAGE=1

INSTALL_TARGET_PROCESSES = SpringBoard

export TARGET = iphone:13.0

export ADDITIONAL_CFLAGS = -DTHEOS_LEAN_AND_MEAN -fobjc-arc

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TempusRomanum

TempusRomanum_FILES = Tweak.xm

ARCHS = arm64 arm64e

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += tempusromanumprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
