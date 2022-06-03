# NixOS System Configurations

nixos development environment using the vmware fusion hypervisor

- supports host/guest copy-paste and folder sharing

some stuff that is installed:

- git
- i3wm
- kitty
- tmux
- docker
- btm
- nix-index (command not found support)

configures user 'orpheus' on machine with hostname 'dreamdev'

- installs and configures some stuff using home-manager

## Credits

project adapted for personal use from https://github.com/mitchellh/nixos-config

## Setup

Recommended vm settings:

  * ISO: NixOS 22.05 or later.
  * Disk: SATA 150 GB+
  * CPU/Memory: I give at least half my cores and half my RAM, as much as you can.
  * Graphics: Full acceleration, full resolution, maximum graphics RAM.
  * Network: Shared with my Mac.
  * Remove sound card, remove video camera.
  * Profile: Disable almost all keybindings

Boot the VM, and using the graphical console, change the root password to "root":

```
$ sudo su
$ passwd
# change to root
```

Run `ifconfig` and get the IP address of the first device. It is probably
`192.168.58.XXX`, but it can be anything. In a terminal with this repository
set this to the `NIXADDR` env var:

```
$ export NIXADDR=<VM ip address>
```


Perform the initial bootstrap. This will install NixOS on the VM disk image
but will not setup any other configurations yet. This prepares the VM for
any NixOS customization:

The Makefile assumes an intel processor for the hypervisor.

```
$ make vm/bootstrap0
```

After the VM reboots, run the full bootstrap, this will finalize the
NixOS customization using this configuration:

```
$ make vm/bootstrap
```

You should have a graphical functioning dev VM.

To run the command-not-found stuff:

```
$ make vm/nixindex
```
