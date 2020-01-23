include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = tempusromanumprefs

tempusromanumprefs_FILES = TRPRootListController.m
tempusromanumprefs_INSTALL_PATH = /Library/PreferenceBundles
tempusromanumprefs_PRIVATE_FRAMEWORKS = Preferences

ARCHS = arm64 arm64e

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/tempusromanumprefs.plist$(ECHO_END)
