export ARCHS = arm64 arm64e
export SYSROOT = $(THEOS)/sdks/iPhoneOS14.4.sdk

ifneq ($(THEOS_PACKAGE_SCHEME), rootless)
export TARGET = iphone:clang:14.4:12.0
export PREFIX = $(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/
else
export TARGET = iphone:clang:14.4:15.0
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = libkitten
libkitten_FILES = Library/libKitten.m
libkitten_CFLAGS = -fobjc-arc -DTHEOS_LEAN_AND_MEAN
libkitten_FRAMEWORKS = UIKit

ifeq ($(THEOS_PACKAGE_SCHEME), rootless)
libkitten_LDFLAGS += -install_name @rpath/libkitten.dylib
endif

include $(THEOS_MAKE_PATH)/library.mk

after-package::
	$(ECHO_NOTHING)mkdir -p $(THEOS)/include/Kitten/$(ECHO_END)
	$(ECHO_NOTHING)mkdir -p $(THEOS)/lib/iphone/rootless/$(ECHO_END)
	$(ECHO_NOTHING)rsync -a ./Library/libKitten.h $(THEOS)/include/Kitten$(ECHO_END)
	$(ECHO_NOTHING)cp ./Library/_module.modulemap $(THEOS)/include/Kitten/module.modulemap$(ECHO_END)

ifeq ($(THEOS_PACKAGE_SCHEME), rootless)
after-package::
	$(ECHO_NOTHING)cp $(THEOS_STAGING_DIR)/var/jb/usr/lib/libkitten.dylib $(THEOS)/lib/iphone/rootless/libkitten.dylib$(ECHO_END)
else
after-package::
	$(ECHO_NOTHING)cp $(THEOS_STAGING_DIR)/usr/lib/libkitten.dylib $(THEOS)/lib/libkitten.dylib$(ECHO_END)
endif
