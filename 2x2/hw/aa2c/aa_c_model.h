#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <stdio.h>
#include <BitVectors.h>
#include <pipeHandler.h>
void _set_trace_file(FILE* fp);
void __init_aa_globals__(); 
void converter_1_Daemon();
void _converter_1_Daemon_();
void converter_2_Daemon();
void _converter_2_Daemon_();
void global_storage_initializer_();
void _global_storage_initializer__();
void inputPort_1_Daemon();
void _inputPort_1_Daemon_();
void inputPort_2_Daemon();
void _inputPort_2_Daemon_();
void outputPort_1_Daemon();
void _outputPort_1_Daemon_();
void outputPort_2_Daemon();
void _outputPort_2_Daemon_();
void _prioritySelect_(bit_vector*, bit_vector*, bit_vector*, bit_vector*, bit_vector*, bit_vector* , bit_vector* );
void start_daemons(FILE* fp, int trace_on);
void stop_daemons();
