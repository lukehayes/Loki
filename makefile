
build_dir = "build"
bin_name = "bin/app"
odin_dir = "."

release:
	odin $(build_dir) $(odin_dir) -out=$(bin_name) -o=speed

debug:
	odin $(build_dir) $(odin_dir) -out=$(bin_name) -o=none -debug
