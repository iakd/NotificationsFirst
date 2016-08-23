ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:9.2:8.0
DEBUG = 0

include theos/makefiles/common.mk

TWEAK_NAME = NotificationsFirst
NotificationsFirst_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
