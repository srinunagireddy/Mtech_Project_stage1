# only to check if the tb compiles ok.
#gcc -o COMPILE_TEST_ONLY  -I $AHIR_RELEASE/include testbench.c -L $AHIR_RELEASE/lib -lPipeHandler -lBitVectors -lpthread -DAA2C -DCOMPILE_TEST_ONLY
#gcc -o compile_test_only  -I $AHIR_RELEASE/include testbench.c -L $AHIR_RELEASE/lib -lPipeHandler -lBitVectors -lpthread -DAA2C -DCOMPILE_TEST_ONLY

gcc -o bin/tb_compile_test_only -I $AHIR_RELEASE/include -I hw/ testbench/testbench.c -L $AHIR_RELEASE/lib -lPipeHandler -lBitVectors -lpthread -DCOMPILE_TEST_ONLY

