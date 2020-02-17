FROM jazzmantest/archlinux:latest
ENV PHP_INI_FILE="/etc/php/php.ini"
ARG CG="composer global"
ARG CGR="$CG require"
ARG CGC="$CG config"
ARG CC="composer config -g"
ADD php-ini.patch /
RUN sudo pacman -S redis \
    php php-{apcu,apcu-bc,dblib,embed,enchant,gd,igbinary,imagick,imap,intl,odbc,phpdbg,pspell,sqlite,tidy,xsl,pgsql,snmp,memcached} \
    composer $NOCONFIRM \
    && $CGC apcu-autoloader true \
    && $CGC sort-packages true \
    && $CGC optimize-autoloader true \
    && $CGC classmap-authoritative true \
    && $CC apcu-autoloader true \
    && $CC sort-packages true \
    && $CC optimize-autoloader true \
    && $CC classmap-authoritative true \
    && $CGR hirak/prestissimo \
    && yay -S php-pear codecept-bin wp-cli $NOCONFIRM \
    && sudo pecl channel-update pecl.php.net \
    && sudo pear channel-update pear.php.net \
    && yes | sudo pecl install redis -a \
    && sudo patch -p0 $PHP_INI_FILE php-ini.patch
