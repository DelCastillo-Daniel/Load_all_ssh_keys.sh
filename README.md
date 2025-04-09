# Lazy SSH key loader

## What's this?
This script starts the ssh-agent, checks if there are any ssh keys, loads them with ssh-add and voilá! You can do whatever you wanted to do with ssh.

## Who's this for?
If you are a lazy person, you value your convenience before security, then this script is for you

## Important Notice

This script uses **Expect**, so go do the whole:

Debian
```bash
sudo apt install expect
```
Arch
```bash
sudo pacman -S expect
```
Fedora
```bash
sudo dnf install expect
```

Don't **expect** the script to install that for you. And go read the documentation just in case.

Now, this script will only work successfully if you use the same password for all the private key files. I haven't found a way to add an exception in case the passphrase is incorrect, sorry.

I'm a complete noob and I'm still learning bash, so don't judge much, thanks.

Consider contributing if you've got the time
