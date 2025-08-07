init:
	mkdir -v -p dist/

install:
	wget --hsts-file /dev/null -O /tmp/nvim.tgz ${URL}
	cd /tmp && mkdir ./nvim
	cd /tmp/nvim && tar -xvf nvim.tgz
	cp -rf /tmp/nvim/nvim-linux-*/bin/* /usr/bin/
	cp -rf /tmp/nvim/nvim-linux-*/lib/* /usr/lib/
	cp -rf /tmp/nvim/nvim-linux-*/share/* /usr/share/
	rm -fv /tmp/nvim/

clean:
	rm -fv /tmp/nvim
