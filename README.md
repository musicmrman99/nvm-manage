# NVM Manager
Another way to manage NVM.

# Installation
## Under `bashctl`
To use it under [`bashctl`](https://github.com/musicmrman99/bashctl "bashctl on GitHub") (recommended if you use `bashctl`):
```sh
# Or whatever component you want to install it to
git clone https://github.com/musicmrman99/nvm-manage.git "$BASH_LIB_COMPONENT_ROOT"/nvm-manage
bashctl --update-symlinks
```
... then add the following to your `.bashrc`:
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
if [ -f "[INSTALL LOCATION]/nvm-manage/nvm-manage-def.def.sh" ]; then
    . "[INSTALL LOCATION]/nvm-manage/nvm-manage-def.def.sh"
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
