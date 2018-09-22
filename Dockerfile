FROM phusion/baseimage
MAINTAINER rix1337

# GMM setup created by James T. Lee (2017)
RUN apt-get update \
 && apt-get install -y wget \
 && wget https://dl.google.com/linux/direct/google-musicmanager-beta_current_amd64.deb \
 && apt install -y ./google-musicmanager-beta_current_amd64.deb \
 && rm -f google-musicmanager-beta_current_amd64.deb \
 && apt-get remove --purge --auto-remove -y wget \
 && rm -rf /var/cache/apt/lists/* \
 && mkdir -p /root/.config \
 && ln -sf /config /root/.config/google-musicmanager \
 && ln -sf /music /root/Music

# Setup VNC
RUN apt-get install -y x11vnc xvfb
 
COPY google-musicmanager-wrapper /

CMD ["/google-musicmanager-wrapper"]
