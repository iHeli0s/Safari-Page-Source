ifeq ($(shell [ -f ./framework/makefiles/common.mk ] && echo 1 || echo 0),0)
all clean package install::
	git submodule update --init
	./framework/git-submodule-recur.sh init
	$(MAKE) $(MAKEFLAGS) MAKELEVEL=0 $@
else
GO_EASY_ON_ME = 1

TWEAK_NAME = SafariPageSource
SafariPageSource_FILES = Tweak.xm
SafariPageSource_FRAMEWORKS = UIKit
SUBPROJECTS = SafariPageSourceSettings
include framework/makefiles/common.mk
include framework/makefiles/tweak.mk
include framework/makefiles/aggregate.mk

endif
