init:
	mkdir -v -p dist/

install:
	mkdir -pv /opt/nvim/{bin,lib,share}
	wget --hsts-file /dev/null -O /opt/nvim.tgz ${URL}
	cd /opt/nvim && tar -m -xzvf nvim.tgz
	rm -rf /opt/nvim/nvim.tgz
	cp -rf /opt/nvim/nvim-linux-*/bin/* /opt/nvim/bin/
	cp -rf /opt/nvim/nvim-linux-*/lib/* /opt/nvim/lib/
	cp -rf /opt/nvim/nvim-linux-*/share/* /opt/nvim/share/
	rm -rf /opt/nvim/nvim-linux-*

clean:
	rm -rf /opt/nvim/nvim.tgz
	rm -rf /opt/nvim/nvim-linux-*
