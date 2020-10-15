# Description

A simple shell script to make new server comfortable.

# Compatibility

Tested on Ubuntu 20.04 only. Other Debian based system should work.

# Guarantee

There is not any guarantee. Use at your own risk.

# Usage

```
wget -nv -O- https://raw.githubusercontent.com/maptile/install-server/main/install.sh | sudo sh /dev/stdin
```

# Extras

## Create user ubuntu

If the server doesn't have ubuntu user, it's better to create it.

```
sudo useradd -m -s /bin/bash ubuntu
```

If you don't want to type password when using sudo, append the following lines to /etc/sudoers.d/90-cloud-init-users

```
ubuntu ALL=(ALL) NOPASSWD:ALL
```

Add the coresponding pub keys to ~/.ssh/authorized_keys

## Change sshd config

```
sudo vim /etc/ssh/sshd_config
```

change PermitRootLogin to no and PasswordAuthentication no

Restart sshd server by

```
sudo systemctl restart sshd.service
```

# Look Inside

This script will do basic system update and upgrade first. And will install the following components.

## apt-transport-https

**transitional package for https support**

This package enables the usage of 'deb https://foo distro main' lines in the /etc/apt/sources.list so that all package managers using the libapt-pkg library can access metadata and packages available in sources accessible over https (Hypertext Transfer Protocol Secure).

This transport supports server as well as client authentication with certificates.

## ca-certificates

**Common CA certificates**

Contains the certificate authorities shipped with Mozilla's browser to allow SSL-based applications to check for the authenticity of SSL connections.

## curl

**command line tool for transferring data with URL syntax**

curl is a command line tool for transferring data with URL syntax, supporting DICT, FILE, FTP, FTPS, GOPHER, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP, SCP, SFTP, SMTP, SMTPS, TELNET and TFTP.

## gpg-agent

**GNU privacy guard - cryptographic agent**

GnuPG is GNU's tool for secure communication and data storage. It can be used to encrypt data and to create digital signatures. It includes an advanced key management facility and is compliant with the proposed OpenPGP Internet standard as described in RFC4880.

## software-properties-common

**manage the repositories that you install software from**

This software provides an abstraction of the used apt repositories. It allows you to easily manage your distribution and independent software vendor software sources.

## stow

**Organizer for /usr/local software packages**

GNU Stow is a software installation manager for /usr/local. Using symbolic links, GNU Stow helps you keep the installations separate (/usr/local/stow/emacs vs. /usr/local/stow/perl, for example) while maintaining the illusion that they are all under /usr/local.

## tmux

**terminal multiplexer**

tmux enables a number of terminals (or windows) to be accessed and controlled from a single terminal like screen. tmux runs as a server-client system. A server is created automatically when necessary and holds a number of sessions, each of which may have a number of windows linked to it. Any number of clients may connect to a session, or the server may be controlled by issuing commands with tmux. Communication takes place through a socket, by default placed in /tmp. Moreover tmux provides a consistent and well-documented command interface, with the same syntax whether used interactively, as a key binding, or from the shell. It offers a choice of vim or Emacs key layouts.

## vim

**Vi IMproved - enhanced vi editor**

Vim is an almost compatible version of the UNIX editor Vi.

## Docker Community Edition

[Docker](https://docs.docker.com/get-docker/) is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly.

## Docker Compose

[Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container Docker applications.

## snap core

**snapd runtime environment**

The core runtime environment for [snapd](https://snapcraft.io/).

## certbot

[Certbot](https://certbot.eff.org) is a free, open source software tool for automatically using Let’s Encrypt certificates on manually-administrated websites to enable HTTPS.

## dotfiles

[A simple tuning](https://github.com/maptile/dotfiles) for git and tmux.

# License

Licensed under MIT License.
