# BTRFS + SystemD hibernation script

_It does not work with LUKS_

## Features

- Automatic swap configuration
- Automatic turn on/off swap
- Support hibernate and sleep-then-hibernate
- Close laptop lid to suspend then hibernate
- EFI support

## Installation

```sh
./hibernation.sh
```

## Customize it

You can change the `sleep.conf` file and reinstall it with `./hibernation.sh` as you will:

Change `HibernateDelaySec` to increase/decrease the delay between sleep and hibernation

---

To change the "lid" behaviour, just edit `login.conf` and reinstall it.

## Hibernate Gnome Menu

I am currently using https://extensions.gnome.org//extension/755/hibernate-status-button/

---

Fork of https://github.com/pietryszak/fedora-hibernation

Based on @jorp solution and information on this [gist](https://gist.github.com/eloylp/b0d64d3c947dbfb23d13864e0c051c67) provided by @eloylp and comment by @miXwui.
