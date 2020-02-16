all:
	ls -a
	git submodule update --init
	make -C gwion
