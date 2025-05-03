# How to bootstrap

## SSH

Generate a new SSH key:

```
% ssh-keygen -t ed25519
```

Register the pubkey (id_ed25519.pub) to GitHub:

- https://github.com/settings/keys

## Homebrew

Install [Homebrew](https://brew.sh).

## chezmoi

Install [chezmoi](https://www.chezmoi.io).

```
brew install chezmoi
```

Apply configurations:

```
chezmoi init --apply $GITHUB_USERNAME
```

## Podman

https://podman.io

```
% podman machine init
```

## GNU Emacs

https://emacsformacosx.com

- M-x package-install magit
