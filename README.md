## Nitheesh Chandra's dotfiles

Bootstrap your Ubuntu in a single command!

![Screenshot]()

This dotfiles repository is currently aimed for [**Ubuntu on WSL**](https://uuntu.com/wsl), [**Ubuntu Server**](https://ubuntu.com/server), and [**Ubuntu Desktop**](https://ubuntu.com/desktop), tested aganist versions **18.04**, **20.04**, and **22.04**. See how to get started with WSL [here](https://docs.microsoft.com/en-us/windows/wsl/install)

Its also suitable for use in [**Github CodeSpaces**](ghttps://docs.github.com/codespaces/customizing-your-codespace/personalizing-codespaces-for-your-account#dotfiles), [**Gitpod**](https://www.gitpod.io/docs/config-dotfiles), [**VS Code Remote - Containers**](https://code.visualstudio.com/docs/remote/containers#_personalzing-with-dotfile-repositories), or even on Linux distribution that are not Ubuntu, through the [**minimum node**](#minimum-node).

Managed with [`chezmoi`](https://chezmoi.io), a great dotfiles manager.

## Getting started

you can use the [convenience script](./scripts/install_doctfiles.sh) to install the dotfiles on any machine with a single command. Simple run the following command in your terminals:

```bash
sh -c "$(get -q0- https://git.io/nitheesh-dotfiles)"
```

> 💡 We use `wget` here because it comes preinstalled with most Ubuntu versions. But you can also use `curl`:
>
> ```bash
>  sh -c "$(curl -fsSL https://git.io/nitheesh-dotfiles)"
> ```

### Demo

Video...

