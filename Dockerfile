FROM ubuntu-debootstrap:14.04

# Env
ENV DEBIAN_FRONTEND     noninteractive
ENV PHANTOMJS_VER       1.9.8
ENV PHANTOMJS_URL       https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VER}-linux-x86_64.tar.bz2
ENV CASPERJS_VER        1.1-beta3
ENV CASPERJS_URL        https://github.com/n1k0/casperjs/tarball/${CASPERJS_VER}


# Install
COPY install.sh /
RUN bash -xe /install.sh


# Default command
CMD ["/usr/bin/slimerjs"]
