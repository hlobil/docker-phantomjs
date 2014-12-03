set -o pipefail

echo "deb http://archive.canonical.com/ubuntu trusty partner" > /etc/apt/sources.list.d/partner.list

apt-get update
apt-get upgrade -qqy
apt-get install -qqy wget bzip2
apt-get install -qqy --no-install-recommends adobe-flashplugin libfreetype6 libfontconfig1 python


# phantomjs
mkdir -p /srv/var/phantomjs


wget -qO- ${PHANTOMJS_URL} | tar -C /srv/var/phantomjs --strip-components=1 -xjv > /dev/null
# cat <<\EOF > /srv/var/slimerjs/slimerjs.sh
# #!/usr/bin/env bash
# xvfb-run /srv/var/slimerjs/slimerjs $*
# EOF
# chmod 755 /srv/var/slimerjs/slimerjs.sh
ln -s /srv/var/phantomjs/bin/phantomjs /usr/bin/phantomjs


# casperjs
mkdir -p /srv/var/casperjs
wget -qO- ${CASPERJS_URL} | tar -C /srv/var/casperjs --strip-components=1 -xzv > /dev/null
cat <<\EOF > /srv/var/casperjs/casperjs.sh
#!/usr/bin/env bash
/srv/var/casperjs/bin/casperjs --engine=phantomjs $*
EOF
chmod 755 /srv/var/casperjs/casperjs.sh
ln -s /srv/var/casperjs/casperjs.sh /usr/bin/casperjs


# clean up
apt-get purge -y --auto-remove wget bzip2
apt-get autoremove -qqy
apt-get clean all
rm -rf /var/lib/apt/lists/*
