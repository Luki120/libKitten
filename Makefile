export TARGET = iphone:clang:14.5:14.0

LIBRARY_NAME = libkitten

libkitten_FILES = Library/libKitten.m
libkitten_CFLAGS = -fobjc-arc
libkitten_LDFLAGS += -install_name @rpath/libkitten.dylib
libkitten_FRAMEWORKS = UIKit

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/library.mk

after-package::
	@mkdir -p $(THEOS)/include/Kitten/
	@mkdir -p $(THEOS)/lib/iphone/rootless/
	@rsync ./Library/libKitten.h $(THEOS)/include/Kitten
	@cp ./Library/_module.modulemap $(THEOS)/include/Kitten/module.modulemap

ifeq ($(THEOS_PACKAGE_SCHEME), rootless)
after-package::
	@cp $(THEOS_STAGING_DIR)/var/jb/usr/lib/libkitten.dylib $(THEOS)/lib/iphone/rootless/libkitten.dylib
else
after-package::
	@cp $(THEOS_STAGING_DIR)/usr/lib/libkitten.dylib $(THEOS)/lib/libkitten.dylib
endif
