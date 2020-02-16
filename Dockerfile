FROM jazzmantest/archlinux:latest
ENV PHP_INI_FILE="/etc/php/php.ini"
ADD php-ini.patch /
RUN sudo pacman -S redis \
    php php-{apcu,apcu-bc,dblib,embed,enchant,gd,igbinary,imagick,imap,intl,odbc,phpdbg,pspell,sqlite,tidy,xsl,pgsql,snmp,memcached} \
    composer $NOCONFIRM \
    && yay -S php-pear $NOCONFIRM \
    && sudo pecl channel-update pecl.php.net \
    && sudo pear channel-update pear.php.net \
    && yes | sudo pecl install redis -a \
    && sudo patch -p0 $PHP_INI_FILE php-ini.patch
