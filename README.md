# Google Play Music Manager for Docker

The [Google Play Music Manager](https://support.google.com/googleplaymusic/answer/1075570?hl=en)
is becoming increasingly hard to run, depending on deprecated libraries with
known security vulnerabilities, like QtWebKit.  This Docker image is inteded to
keep Music Manager alive in a stable and semi-isolated environment long after
distros have removed its dependencies.

This image is based on [`iamjamestl/docker-google-musicmanager/`](https://github.com/iamjamestl/docker-google-musicmanager/) that is loosely modeled after
[`ruippeixotog/google-musicmanager`](https://hub.docker.com/r/ruippeixotog/google-musicmanager/).

This version relies on an included VNC server.
## Installation

```
docker create \
  --name=google-musicmanager \
  --net=host \
  -e PORT=5900 \
  -e PASSWORD=GoogleMusic \
  -v </path/to/config>:/config \
  -v </path/to/music>:/music \
  rix1337/docker-google-musicmanager
```

Be aware that Google Play Music does some form of client tracking by MAC address, which will cause trouble when not using `--net=host`. This is why no port mapping is used. If you need to change the port, use the environment variable.

### Volumes

* `/config`: This is where the Music Manager will store files for preserving
  its configuration between runs.  It also logs to this directory.  In the
  example shown, Docker will map the default configuration directory from your
  host, which is great if you want to migrate from running the app on the host
  into this container.  Otherwise, you can specify any directory you want.
* `/music`: This is the location Music Manager will scan for music to upload to
  Google Play Music.  Map your music library to this volume.  You can map
  multiple music volumes into the container, but you must manually configure
  Music Manager to read from them.
