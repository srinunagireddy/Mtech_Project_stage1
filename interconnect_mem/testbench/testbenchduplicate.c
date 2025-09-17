#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>

#ifndef COMPILE_TEST_ONLY
#ifndef AA2C
	#include "vhdlCStubs.h"
#else
	#include "aa_c_model.h"
#endif
#endif

// Software model of the memory (65536 entries for 16-bit address)
uint32_t memory_model[65536];

void user_core(int user_id)
{
	char req_pipe_name[256];
	char res_pipe_name[256];

	sprintf(req_pipe_name, "tb_memory_access_%d", user_id);
	sprintf(res_pipe_name, "memory_response_%d", user_id);

	while(1)
	{
		uint8_t rwbar = (rand() % 2); 
		uint16_t addr = rand() % 65536; // Full 16-bit address space
		uint32_t wdata = (rand() << 16) | rand();

		uint64_t request_packet = 0;
		request_packet = wdata;
		request_packet = (request_packet << 16) | addr;
		request_packet = (request_packet << 1)  | rwbar;

		write_uint64(req_pipe_name, request_packet);
		
		if(rwbar == 1) // Read
		{
			uint32_t read_data = read_uint32(res_pipe_name);
			if(read_data != memory_model[addr])
			{
				fprintf(stderr, "Error: User %d, Address %d, Read data %x != Expected %x\n",
						user_id, addr, read_data, memory_model[addr]);
			}
			else
			{
				fprintf(stdout, "Info: User %d, Address %d, Read data %x OK\n",
						user_id, addr, read_data);
			}
		}
		else // Write
		{
			memory_model[addr] = wdata;
			fprintf(stdout, "Info: User %d, Address %d, Wrote data %x\n", user_id, addr, wdata);
		}
	}
}

void user_0() { user_core(0); } DEFINE_THREAD(user_0);
void user_1() { user_core(1); } DEFINE_THREAD(user_1);
void user_2() { user_core(2); } DEFINE_THREAD(user_2);
void user_3() { user_core(3); } DEFINE_THREAD(user_3);

int main(int argc, char* argv[])
{
	PTHREAD_DECL(user_0); PTHREAD_CREATE(user_0);
	PTHREAD_DECL(user_1); PTHREAD_CREATE(user_1);
	PTHREAD_DECL(user_2); PTHREAD_CREATE(user_2);
	PTHREAD_DECL(user_3); PTHREAD_CREATE(user_3);
	PTHREAD_JOIN(user_0); PTHREAD_JOIN(user_1);
	PTHREAD_JOIN(user_2); PTHREAD_JOIN(user_3);
	return(0);
}