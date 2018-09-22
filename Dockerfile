FROM phusion/baseimage
MAINTAINER rix1337


ENV DEBIAN_FRONTEND=noninteractive HOME="/root" TERM=xterm

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
 && apt install --no-install-recommends xserver-xorg -y \
 && apt-get install -y openbox lightdm tightvncserver sudo xterm \
 && adduser vnc \
 && gpasswd -a vnc sudo \
 && su - vnc \
 && touch ~/.Xresources
 
COPY google-musicmanager-wrapper /

CMD ["/google-musicmanager-wrapper", "-s", "/music"]
