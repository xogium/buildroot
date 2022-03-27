################################################################################
#
# irssi-git
#
################################################################################

IRSSI_GIT_VERSION = f57dcfe90dad9843cebb0155f8839d4c75c26457
IRSSI_GIT_SITE = $(call github,irssi,irssi,$(IRSSI_GIT_VERSION))
IRSSI_GIT_LICENSE = GPL-2.0+
IRSSI_GIT_LICENSE_FILES = COPYING
IRSSI_GIT_DEPENDENCIES = host-pkgconf libglib2 ncurses openssl

IRSSI_GIT_CONF_OPTS = \
	-Dinstall-glib=no

ifeq ($(BR2_PACKAGE_IRSSI_GIT_PERL),y)
IRSSI_GIT_DEPENDENCIES += perl
IRSSI_GIT_CONF_OPTS += -Dwith-perl=yes \
	-Dwith-perl-lib=site
IRSSI_GIT_MESON_EXTRA_BINARIES += perl=['$(STAGING_DIR)/usr/bin/miniperl','-I$(STAGING_DIR)/usr/lib/perl5/$(PERL_VERSION)/$(PERL_ARCHNAME)','-I$(STAGING_DIR)/usr/lib/perl5/$(PERL_VERSION)']
else
IRSSI_GIT_CONF_OPTS += -Dwith-perl=no
endif # perl

ifeq ($(BR2_PACKAGE_IRSSI_GIT_PROXY),y)
IRSSI_GIT_CONF_OPTS += -Dwith-proxy=yes
else
IRSSI_GIT_CONF_OPTS += -Dwith-proxy=no
endif # proxy

ifeq ($(BR2_PACKAGE_IRSSI_GIT_TRUE_COLOR),y)
IRSSI_GIT_CONF_OPTS += -Denable-true-color=yes
else
IRSSI_GIT_CONF_OPTS += -Denable-true-color=no
endif

$(eval $(meson-package))
