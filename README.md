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
  -v $HOME/.config/google-musicmanager:/config \
  -v </path/to/music>:/music \
  rix1337/docker-google-musicmanager
```

Be aware that Google Play Music does some form of client tracking by MAC address, which will cause trouble when not using `--net=host`.

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

## Starting

Start the container with `docker start google-musicmanager`.  The first time
you start the container with an empty config directory, the application will
launch a Google login screen.  Every time thereafter, the application will
launch hidden. You can get the main window to show by
running:

```
docker exec google-musicmanager google-musicmanager
```

## Stopping

When you are done uploading your music, you can keep the container running to
monitor your music library for changes, or stop the container with `docker stop
google-musicmanager`.

## Removing

Run `docker rm google-musicmanager`.  You can always restore the container by
specifying the same `/config` and `/music` volumes that you used before.
