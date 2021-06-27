# This makefile is based on https://openwrt.org/docs/guide-developer/helloworld/chapter3
include $(TOPDIR)/rules.mk

PKG_NAME:=emax-em3371-decoder
PKG_VERSION:=0.1
PKG_RELEASE:=1
PKG_LICENSE:=GPL-2.0-or-later

SOURCE_DIR:=/home/mateusz/Modyfikacje/stacja_pogody_meteo_SP73/program

include $(INCLUDE_DIR)/package.mk

define Package/emax-em3371-decoder
	SECTION:=examples
	CATEGORY:=Examples
	#DEPENDS:=+libm +libmariadb
	DEPENDS:=+libmariadb
	TITLE:="Handler for EMAX EM3371 (and branded versions) weather stations"
endef

define Package/emax-em3371-decoder/description
	Handler for EMAX EM3371 (and branded versions) weather stations
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	cp -a $(SOURCE_DIR)/* $(PKG_BUILD_DIR)
	$(Build/Patch)
endef

define Build/Compile
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) -DHAVE_MYSQL -Wall -Wextra -o $(PKG_BUILD_DIR)/$1 $(PKG_BUILD_DIR)/src/main.c $(PKG_BUILD_DIR)/src/emax_em3371.c $(PKG_BUILD_DIR)/src/psychrometrics.c $(PKG_BUILD_DIR)/src/output_json.c $(PKG_BUILD_DIR)/src/output_csv.c $(PKG_BUILD_DIR)/src/output_sql.c $(PKG_BUILD_DIR)/src/output_raw_sql.c $(PKG_BUILD_DIR)/src/output_mysql.c $(PKG_BUILD_DIR)/src/output_mysql_buffer.c -lmariadb
endef

define Package/emax-em3371-decoder/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/emax_em3371_decoder $(1)/usr/sbin
endef

$(eval $(call BuildPackage,emax-em3371-decoder))
