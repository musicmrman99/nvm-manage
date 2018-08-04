# NVM Manager
Another way to manage NVM.

# Installation
## Under `bashctl`
To use it under [`bashctl`](https://github.com/musicmrman99/bashctl "bashctl on GitHub") (recommended if you use `bashctl`):
```sh
install_component="functions" # The component to install it to
install_group="nvm-manage" # The group to install it to (the bit you actually `src`)
install_prefix="$BASH_LIB_COMPONENT_ROOT/$install_component/$install_group" # The full path to the group

mkdir "$BASH_LIB_COMPONENT_ROOT/$install_component" # If it doesn't exist
git clone https://github.com/musicmrman99/nvm-manage.git "$install_prefix"
sed -i "s/{group}/$install_group/" "$install_prefix"/nvm-manage.def.sh # Set the location to source from
bashctl --update-symlinks
```
... assuming that this will be sourced by a 'source-all-my-stuff' command in your `.bashrc`. If this isn't true, then add the following to your `.bashrc` (for easy copy-paste):
```sh
src nvm-manage:nvm-manage
```

## Without `bashctl`
Clone the repo somewhere:
```sh
git clone https://github.com/musicmrman99/nvm-manage.git "[INSTALL LOCATION]"
```

Then add the following to your (Bourne-compatible) shell's init file:
```sh
if [ -f "[INSTALL LOCATION]/nvm-manage-def.def.sh" ]; then
    . "[INSTALL LOCATION]/nvm-manage-def.def.sh"
fi
```

# Usage
## Common commands
Set the NVM root directory:
```sh
nvm-manage set-dir ~/new/dir
```

Install/Remove/Update NVM:
```sh
nvm-manage install
nvm-manage remove
nvm-manage update
```

To begin using NVM (per-shell session, unless added to shell init):
```sh
nvm-manage start
```
Arguments to `nvm.sh` are passed on:
```sh
nvm-manage start --no-use
```

## Help
Full help is available:
```sh
nvm-manage -h
```
