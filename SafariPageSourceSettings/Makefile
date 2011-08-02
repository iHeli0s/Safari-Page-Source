include ../framework/makefiles/common.mk

BUNDLE_NAME = SafariPageSourceSettings
SafariPageSourceSettings_FILES = SafariPageSourceSettings.mm
SafariPageSourceSettings_INSTALL_PATH = /Library/PreferenceBundles
SafariPageSourceSettings_FRAMEWORKS = UIKit
SafariPageSourceSettings_PRIVATE_FRAMEWORKS = Preferences

include ../framework/makefiles/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SafariPageSourceSettings.plist$(ECHO_END)
