default: build

build:
	agda --compile ./main.agda --library="standard-library-1.7.1"
check: 
	agda --include-path "$(STD_LIB)" ./main.agda
