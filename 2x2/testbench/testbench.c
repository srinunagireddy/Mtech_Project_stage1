#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
//
// AHIR release utilities
//
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

// The effective packet length is 32 32-bit words
#define EFFECTIVE_PACKET_LENGTH_IN_32BIT_WORDS 32
// To produce 32 words, the testbench must send 32 words of 64-bit data.
#define PACKET_LENGTH_IN_64BIT_WORDS 32


typedef struct _TbConfig {
	int input_port_1_active;
	int input_port_1_random_dest_flag;
	int input_port_1_destination_port;
	int input_port_2_active;
	int input_port_2_random_dest_flag;
	int input_port_2_destination_port;
} TbConfig;
TbConfig tb_config;

int __err_flag__ = 0;

void input_port_core(int port_id)
{
	uint64_t send_buffer_64[PACKET_LENGTH_IN_64BIT_WORDS];	
	uint32_t packet_32bit_words[PACKET_LENGTH_IN_64BIT_WORDS * 2]; // Buffer for full 64 words to be safe

	int i;
	// Generate a simple 0, 1, 2, 3... payload
	for(i = 0; i < (PACKET_LENGTH_IN_64BIT_WORDS * 2); i++)
	{
		packet_32bit_words[i] = i;
	}

	uint8_t seq_id = (port_id == 1) ? 1 : 0;
	while(1)
	{
		int dest_port =  -1;
		if(port_id == 1)
		{
			dest_port = (tb_config.input_port_1_random_dest_flag ? ((rand() & 0x1)+1) : tb_config.input_port_1_destination_port);
		}
		else if(port_id == 2)
		{
			dest_port = (tb_config.input_port_2_random_dest_flag ? ((rand() & 0x1)+1) : tb_config.input_port_2_destination_port);
		}

		if((dest_port == 1) || (dest_port == 2))
		{
			// The header correctly declares a packet length of 32
			packet_32bit_words[0] = (dest_port << 24) | (EFFECTIVE_PACKET_LENGTH_IN_32BIT_WORDS << 8) | seq_id;

			// Pack the data into 32 64-bit words
			for(i = 0; i < PACKET_LENGTH_IN_64BIT_WORDS; i++)
			{
				uint32_t lower_word = packet_32bit_words[2*i];
				// The upper word will be ignored by hardware, but we still pack it.
				uint32_t upper_word = packet_32bit_words[2*i + 1];
				send_buffer_64[i] = ((uint64_t)upper_word << 32) | lower_word;
			}
			
			// Send the 32-word (64-bit) packet
			if(port_id == 1)
				write_uint64_n ("in_data_1_64", send_buffer_64, PACKET_LENGTH_IN_64BIT_WORDS);
			else
				write_uint64_n ("in_data_2_64", send_buffer_64, PACKET_LENGTH_IN_64BIT_WORDS);

			seq_id += 2;
		}
	}
}

void input_port_1_sender () { input_port_core(1); }
DEFINE_THREAD(input_port_1_sender);

void input_port_2_sender () { input_port_core(2); }
DEFINE_THREAD(input_port_2_sender);

void output_port_core(int port_id)
{
	int PCOUNT = 0;
	int err = 0;

	while(1)
	{
		// The receiver expects a 32-word packet
		uint32_t packet[EFFECTIVE_PACKET_LENGTH_IN_32BIT_WORDS];

		if(port_id == 1)
			read_uint32_n ("out_data_1", packet, EFFECTIVE_PACKET_LENGTH_IN_32BIT_WORDS);
		else
			read_uint32_n ("out_data_2", packet, EFFECTIVE_PACKET_LENGTH_IN_32BIT_WORDS);
		
		PCOUNT++;

		int dest = (packet[0] >> 24);
		int input_port = ((packet[0] & 0x1) ? 1 : 2);

		if(dest != port_id)
		{
			fprintf(stderr,"Error: at port %d, packet number %d from input port %d, destination mismatch!\n", port_id, PCOUNT, input_port);
			err = 1;
		}
		else
		{
			fprintf(stderr,"\nRx[%d] at output port %d from input port %d\n", PCOUNT, port_id, input_port);
		}

		// Verify the truncated payload.
		int I; 
		for(I=1; I < EFFECTIVE_PACKET_LENGTH_IN_32BIT_WORDS; I++)
		{
			uint32_t expected_word = 2*I;
			if (packet[I] != expected_word)
			{
				fprintf(stderr,"\nError: packet[%d]=%d, expected %d.\n", I, packet[I], expected_word);
				err = 1;
			}
		}

		if(err)
		{
			__err_flag__ = 1;
			break;
		}
	}
}

void output_port_1_receiver () { output_port_core(1); }
DEFINE_THREAD(output_port_1_receiver);

void output_port_2_receiver () { output_port_core(2); }
DEFINE_THREAD(output_port_2_receiver);

int main(int argc, char* argv[])
{
	if(argc < 3) { fprintf(stderr,"Usage: %s [trace-file] [test_type] \n trace-file=null for no trace, stdout for stdout\n" "test_type = 1to1/1to2/1toBoth/2to1/2to2/2toBoth/BothtoBoth\n", argv[0]); return(1); }
	FILE* fp = NULL;
	if(strcmp(argv[1],"stdout") == 0) { fp = stdout; }
	else if(strcmp(argv[1], "null") != 0) { fp = fopen(argv[1],"w"); if(fp == NULL) { fprintf(stderr,"Error: could not open trace file %s\n", argv[1]); return(1); } }
	int __1to1 = (strcmp(argv[2],"1to1") == 0);
	int __1to2 = (strcmp(argv[2],"1to2") == 0);
	int __1toBoth = (strcmp(argv[2],"1toBoth") == 0);
	int __2to1 = (strcmp(argv[2],"2to1") == 0);
	int __2to2 = (strcmp(argv[2],"2to2") == 0);
	int __2toBoth = (strcmp(argv[2],"2toBoth") == 0);
	int __BothtoBoth = (strcmp(argv[2],"BothtoBoth") == 0);
#ifndef COMPILE_TEST_ONLY
#ifdef AA2C
	init_pipe_handler();
	start_daemons (fp,0);
#endif
#endif
	tb_config.input_port_1_active = (__1to1 || __1to2 || __1toBoth || __BothtoBoth);
	tb_config.input_port_1_random_dest_flag = (__1toBoth || __BothtoBoth);
	tb_config.input_port_1_destination_port = (__1to1 ? 1 : (__1to2 ? 2 : -1));
	tb_config.input_port_2_active = (__2to1 || __2to2 || __2toBoth || __BothtoBoth);
	tb_config.input_port_2_random_dest_flag = (__2toBoth || __BothtoBoth);
	tb_config.input_port_2_destination_port = (__2to1 ? 1 : (__2to2 ? 2 : -1));
	PTHREAD_DECL(output_port_1_receiver);
	PTHREAD_CREATE(output_port_1_receiver);
	PTHREAD_DECL(output_port_2_receiver);
	PTHREAD_CREATE(output_port_2_receiver);
	PTHREAD_DECL(input_port_1_sender);
	PTHREAD_CREATE(input_port_1_sender);
	PTHREAD_DECL(input_port_2_sender);
	PTHREAD_CREATE(input_port_2_sender);
	PTHREAD_JOIN(output_port_1_receiver);
	PTHREAD_JOIN(output_port_2_receiver);
	if(__err_flag__) { fprintf(stderr,"\nFAILURE.. there were errors\n"); }
	return(0);
}
