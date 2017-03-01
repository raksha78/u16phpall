#!/bin/bash -e

apt-get clean
mv /var/lib/apt/lists/* /tmp
mkdir -p /var/lib/apt/lists/partial
apt-get clean


# Install dependencies
echo "=========== Installing dependencies ============"
#apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`
apt-get update
apt-get install php7.0-dev php7.1-dev
add-apt-repository -y ppa:ondrej/php

apt-get update
apt-get install php5.6
apt-get install php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml

apt-get install -y git wget cmake libmcrypt-dev libreadline-dev libzmq-dev
apt-get install -y libxml2-dev     \
                libjpeg-dev     \
                libpng-dev      \
                libtidy-dev     \
                libxml2-dev     \
                libpcre3-dev    \
                libbz2-dev      \
                libcurl4-openssl-dev    \
                libminiupnpc-dev\
                libdb5.3-dev    \
                libpng12-dev    \
                libxpm-dev      \
                libfreetype6-dev        \
                libgd2-xpm-dev  \
                libgmp-dev      \
                libsasl2-dev    \
                libmhash-dev    \
                unixodbc-dev    \
                freetds-dev     \
                libpspell-dev   \
                libsnmp-dev     \
                libxslt1-dev    \
                libmcrypt-dev   \
                php5.6-dev

# fixes for ubuntu 16.04. create soft links as header files have been
# renamed
ln -s /usr/include/tidy/tidybuffio.h /usr/include/tidy/buffio.h
ln -s /usr/include/tidy/tidyplatform.h /usr/include/tidy/platform.h


# Install php-build
echo "============ Installing php-build =============="
git clone git://github.com/php-build/php-build.git $HOME/php-build
$HOME/php-build/install.sh
rm -rf $HOME/php-build

#Download pickle
git clone https://github.com/FriendsOfPHP/pickle.git /tmp/pickle
ln -s /tmp/pickle/bin/pickle /usr/bin/

# Install phpenv
git clone git://github.com/CHH/phpenv.git $HOME/phpenv
$HOME/phpenv/bin/phpenv-install.sh
echo 'export PATH=$PHPENV_PATH/.phpenv/bin:$PATH' >> $HOME/.bashrc
echo 'eval "$(phpenv init -)"' >> $HOME/.bashrc
rm -rf $HOME/phpenv

# Activate phpenv
export PATH=$HOME/.phpenv/bin:$PATH
#echo "PATH=$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

cd /

/u16phpall/version/5_4.sh
/u16phpall/version/7_0.sh
/u16phpall/version/7_1.sh
#for file in /u16phpall/version/*.sh;
#do
#  . $file
#done

# Cleaning package lists
echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
