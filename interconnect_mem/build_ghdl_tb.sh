
rm -rf obj_vhdl bin
mkdir -p obj_vhdl bin

gcc -g -c testbench/testbench.c -I hw/ -I $AHIR_RELEASE/include -o obj_vhdl/testbench.o
gcc -g -c hw/vhdlCStubs.c -I hw/ -I $AHIR_RELEASE/include -o obj_vhdl/vhdlCStubs.o

ghdl --bind -o bin/ahir_system ahir_system
ghdl --list-link ahir_system > obj_vhdl/vhdl_object_files.txt

gcc -g -o bin/testbench_vhdl obj_vhdl/vhdlCStubs.o obj_vhdl/testbench.o \
	-L$AHIR_RELEASE/lib -lBitVectors -lSockPipes -lPipeHandler -lpthread \
	-Wl,-rpath,/usr/local/lib/ghdl/v08

