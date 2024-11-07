# To disable ipv6 cos it's being a b****
- create file in /etc/sysctl.d/sysctl.conf, add these lines
	```
	net.ipv6.conf.all.disable_ipv6 = 1
	net.ipv6.conf.default.disable_ipv6 = 1
	net.ipv6.conf.lo.disable_ipv6 = 1
	```
- sudo sysctl -p

# Early EOF error git clone
- git clone --depth=1 <link>
- cd <repo>
- `git fetch --unshallow` (or) `git fetch --all`

# Recursive fetch submodules
- `git clone --recursive <url>`

# Missing option to add search engines to firefox
- in about:config
- make browser.urlbar.update2.engineAliasRefresh as true

# Corrupted memory so format and assign file system
- `mkfs.ext4 /dev/sda1`

# Copy huge file to disk
- `sudo bmaptool copy --nobmap <file_name>.wic /dev/<mount point>`
