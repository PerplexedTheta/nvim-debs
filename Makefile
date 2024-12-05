init:
	mkdir -v -p dist/

install:
	wget --hsts-file /dev/null -O /tmp/nvim.appimage https://github.com/neovim/neovim/releases/download/v${VERSION}/nvim.appimage
	chmod +x /tmp/nvim.appimage
	cd /tmp && /tmp/nvim.appimage --appimage-extract
	rsync -av /tmp/squashfs-root/usr/ /usr
	rm -fv /tmp/nvim.appimage
	rm -rfv /tmp/squashfs-root/

clean:
	rm -fv /tmp/nvim.appimage
	rm -rfv /tmp/squashfs-root/
