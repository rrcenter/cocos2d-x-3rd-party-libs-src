# nghttp2 

VERSION := 1.62.0
VERSION := 1.58.0
# https://github.com/nghttp2/nghttp2/releases/download/v1.58.0/nghttp2-1.58.0.tar.gz
URL := https://github.com/nghttp2/nghttp2/releases/download/v$(VERSION)/nghttp2-$(VERSION).tar.gz

$(TARBALLS)/nghttp2-$(VERSION).tar.gz:
	$(call download,$(URL))

.sum-curl: nghttp2-$(VERSION).tar.gz

nghttp2: nghttp2-$(VERSION).tar.gz #.sum-curl
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

DEPS_nghttp2 = zlib $(DEPS_zlib)

DEPS_nghttp2 = openssl $(DEPS_openssl)

ifdef HAVE_LINUX
configure_option=--without-libidn --without-librtmp
endif

ifdef HAVE_TVOS
configure_option+=--disable-ntlm-wb
endif

.nghttp2: nghttp2 .zlib .openssl
	$(RECONF)
	cd $< && $(HOSTVARS_PIC) ./configure $(HOSTCONF) \
		--with-openssl \
		$(configure_option)

	cd $< && $(MAKE) install
	touch $@
