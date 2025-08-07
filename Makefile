init:
	mkdir -v -p dist/

install:
	mkdir -pv /tmp/nvim
	wget --hsts-file /dev/null -O /tmp/nvim.tgz ${URL}
	ln -s /tmp/nvim.tgz /usr/nvim.tgz
	cd /usr && tar -xvf nvim.tgz
	rm -fv /usr/nvim.tgz
	rm -fv /tmp/nvim.tgz

clean:
	rm -fv /usr/nvim.tgz
	rm -fv /tmp/nvim.tgz
