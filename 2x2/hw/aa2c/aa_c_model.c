#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <aa_c_model_internal.h>
#include <aa_c_model.h>
FILE* __report_log_file__ = NULL;
int __trace_on__ = 0;
void _set_trace_file(FILE* fp) {
__report_log_file__ = fp;
}
bit_vector _ONE_1;
#define ONE_1 (_ONE_1)

bit_vector _ONE_2;
#define ONE_2 (_ONE_2)

bit_vector _ONE_33;
#define ONE_33 (_ONE_33)

bit_vector _ONE_8;
#define ONE_8 (_ONE_8)

bit_vector _ZERO_1;
#define ZERO_1 (_ZERO_1)

bit_vector _ZERO_2;
#define ZERO_2 (_ZERO_2)

bit_vector _ZERO_33;
#define ZERO_33 (_ZERO_33)

bit_vector _ZERO_8;
#define ZERO_8 (_ZERO_8)

void __init_aa_globals__() 
{
init_static_bit_vector(&(ONE_1), 1);\
bit_vector_clear(&ONE_1);\
ONE_1.val.byte_array[0] = 1;\
init_static_bit_vector(&(ONE_2), 2);\
bit_vector_clear(&ONE_2);\
ONE_2.val.byte_array[0] = 1;\
init_static_bit_vector(&(ONE_33), 33);\
bit_vector_clear(&ONE_33);\
ONE_33.val.byte_array[0] = 1;\
init_static_bit_vector(&(ONE_8), 8);\
bit_vector_clear(&ONE_8);\
ONE_8.val.byte_array[0] = 1;\
init_static_bit_vector(&(ZERO_1), 1);\
bit_vector_clear(&ZERO_1);\
init_static_bit_vector(&(ZERO_2), 2);\
bit_vector_clear(&ZERO_2);\
init_static_bit_vector(&(ZERO_33), 33);\
bit_vector_clear(&ZERO_33);\
init_static_bit_vector(&(ZERO_8), 8);\
bit_vector_clear(&ZERO_8);\
register_pipe("in_data_1", 2, 32, 0);\
register_pipe("in_data_1_64", 2, 64, 0);\
register_pipe("in_data_2", 2, 32, 0);\
register_pipe("in_data_2_64", 2, 64, 0);\
register_pipe("noblock_obuf_1_1", 640, 8, 2);\
register_pipe("noblock_obuf_1_2", 640, 8, 2);\
register_pipe("noblock_obuf_2_1", 640, 8, 2);\
register_pipe("noblock_obuf_2_2", 640, 8, 2);\
register_pipe("out_data_1", 2, 32, 0);\
register_pipe("out_data_2", 2, 32, 0);\
}
void _converter_1_Daemon_()
{
MUTEX_DECL(_converter_1_Daemon_series_block_stmt_40_c_mutex_);
MUTEX_LOCK(_converter_1_Daemon_series_block_stmt_40_c_mutex_);
_converter_1_Daemon_inner_inarg_prep_macro__; 
_converter_1_Daemon_branch_block_stmt_41_c_export_decl_macro_; 
{
{
// do-while:   file .Aa/switch2x2.linked.aa, line 36
__declare_static_bit_vector(konst_59,1);\
bit_vector_clear(&konst_59);\
konst_59.val.byte_array[0] = 1;\
uint8_t do_while_entry_flag;
do_while_entry_flag = 1;
uint8_t do_while_loopback_flag;
do_while_loopback_flag = 0;
while(1) {
// merge  file .Aa/switch2x2.linked.aa, line 38
_converter_1_Daemon_merge_stmt_43_c_preamble_macro_; 
// 			$phi in_word_64 := 			  in_data_1_64 $on   $entry ,   $loopback 
 // type of target is $uint<64>
_converter_1_Daemon_phi_stmt_44_c_macro_; 
_converter_1_Daemon_merge_stmt_43_c_postamble_macro_; 
// 			$volatile word_lower := ( $slice in_word_64 31 0 )  $buffering 1
_converter_1_Daemon_assign_stmt_51_c_macro_; 
// $report (converter_1_Daemon conversion_trace 			 in_word_64 in_word_64 			 word_lower word_lower )
_converter_1_Daemon_stmt_54_c_macro_; 
// 			in_data_1 := word_lower $buffering 1// bits of buffering = 32. 
_converter_1_Daemon_assign_stmt_57_c_macro_; 
do_while_entry_flag = 0;
do_while_loopback_flag = 1;
bit_vector_clear(&konst_59);\
konst_59.val.byte_array[0] = 1;\
if (!bit_vector_to_uint64(0, &konst_59)) break;
} 
}
_converter_1_Daemon_branch_block_stmt_41_c_export_apply_macro_;
}
_converter_1_Daemon_inner_outarg_prep_macro__; 
MUTEX_UNLOCK(_converter_1_Daemon_series_block_stmt_40_c_mutex_);
}
void converter_1_Daemon()
{
_converter_1_Daemon_outer_arg_decl_macro__;
_converter_1_Daemon_();
_converter_1_Daemon_outer_op_xfer_macro__;
}


void _converter_2_Daemon_()
{
MUTEX_DECL(_converter_2_Daemon_series_block_stmt_62_c_mutex_);
MUTEX_LOCK(_converter_2_Daemon_series_block_stmt_62_c_mutex_);
_converter_2_Daemon_inner_inarg_prep_macro__; 
_converter_2_Daemon_branch_block_stmt_63_c_export_decl_macro_; 
{
{
// do-while:   file .Aa/switch2x2.linked.aa, line 55
__declare_static_bit_vector(konst_81,1);\
bit_vector_clear(&konst_81);\
konst_81.val.byte_array[0] = 1;\
uint8_t do_while_entry_flag;
do_while_entry_flag = 1;
uint8_t do_while_loopback_flag;
do_while_loopback_flag = 0;
while(1) {
// merge  file .Aa/switch2x2.linked.aa, line 57
_converter_2_Daemon_merge_stmt_65_c_preamble_macro_; 
// 			$phi in_word_64 := 			  in_data_2_64 $on   $entry ,   $loopback 
 // type of target is $uint<64>
_converter_2_Daemon_phi_stmt_66_c_macro_; 
_converter_2_Daemon_merge_stmt_65_c_postamble_macro_; 
// 			$volatile word_lower := ( $slice in_word_64 31 0 )  $buffering 1
_converter_2_Daemon_assign_stmt_73_c_macro_; 
// $report (converter_2_Daemon conversion_trace 			 in_word_64 in_word_64 			 word_lower word_lower )
_converter_2_Daemon_stmt_76_c_macro_; 
// 			in_data_2 := word_lower $buffering 1// bits of buffering = 32. 
_converter_2_Daemon_assign_stmt_79_c_macro_; 
do_while_entry_flag = 0;
do_while_loopback_flag = 1;
bit_vector_clear(&konst_81);\
konst_81.val.byte_array[0] = 1;\
if (!bit_vector_to_uint64(0, &konst_81)) break;
} 
}
_converter_2_Daemon_branch_block_stmt_63_c_export_apply_macro_;
}
_converter_2_Daemon_inner_outarg_prep_macro__; 
MUTEX_UNLOCK(_converter_2_Daemon_series_block_stmt_62_c_mutex_);
}
void converter_2_Daemon()
{
_converter_2_Daemon_outer_arg_decl_macro__;
_converter_2_Daemon_();
_converter_2_Daemon_outer_op_xfer_macro__;
}


void _global_storage_initializer__()
{
MUTEX_DECL(_global_storage_initializer__series_block_stmt_84_c_mutex_);
MUTEX_LOCK(_global_storage_initializer__series_block_stmt_84_c_mutex_);
_global_storage_initializer__inner_inarg_prep_macro__; 
/* null */ ;
_global_storage_initializer__inner_outarg_prep_macro__; 
MUTEX_UNLOCK(_global_storage_initializer__series_block_stmt_84_c_mutex_);
}
void global_storage_initializer_()
{
_global_storage_initializer__outer_arg_decl_macro__;
_global_storage_initializer__();
_global_storage_initializer__outer_op_xfer_macro__;
}


void _inputPort_1_Daemon_()
{
MUTEX_DECL(_inputPort_1_Daemon_series_block_stmt_87_c_mutex_);
MUTEX_LOCK(_inputPort_1_Daemon_series_block_stmt_87_c_mutex_);
_inputPort_1_Daemon_inner_inarg_prep_macro__; 
_inputPort_1_Daemon_branch_block_stmt_88_c_export_decl_macro_; 
{
{
// do-while:   file .Aa/switch2x2.linked.aa, line 81
__declare_static_bit_vector(konst_177,1);\
bit_vector_clear(&konst_177);\
konst_177.val.byte_array[0] = 1;\
uint8_t do_while_entry_flag;
do_while_entry_flag = 1;
uint8_t do_while_loopback_flag;
do_while_loopback_flag = 0;
while(1) {
// merge  file .Aa/switch2x2.linked.aa, line 83
_inputPort_1_Daemon_merge_stmt_90_c_preamble_macro_; 
// 			$phi count_down := 			  ($bitcast ($uint<16>) 0  ) $on   $entry 			  next_count_down $on   $loopback 
 // type of target is $uint<16>
_inputPort_1_Daemon_phi_stmt_91_c_macro_; 
// 			$phi input_word := 			  in_data_1 $on   $entry ,   $loopback 
 // type of target is $uint<32>
_inputPort_1_Daemon_phi_stmt_97_c_macro_; 
// 			$phi last_dest_id := 			  0  $on   $entry 			  next_last_dest_id $on   $loopback 
 // type of target is $uint<8>
_inputPort_1_Daemon_phi_stmt_100_c_macro_; 
_inputPort_1_Daemon_merge_stmt_90_c_postamble_macro_; 
// $report (inputPort_1_Daemon received_input_word 			 input_word input_word )
_inputPort_1_Daemon_stmt_106_c_macro_; 
// 			$volatile new_packet := (count_down == 0 ) $buffering 1
_inputPort_1_Daemon_assign_stmt_111_c_macro_; 
// 			$volatile dest_id := ( $slice input_word 31 24 )  $buffering 1
_inputPort_1_Daemon_assign_stmt_115_c_macro_; 
// 			$volatile pkt_length := ( $slice input_word 23 8 )  $buffering 1
_inputPort_1_Daemon_assign_stmt_119_c_macro_; 
// 			$volatile seq_id := ( $slice input_word 7 0 )  $buffering 1
_inputPort_1_Daemon_assign_stmt_123_c_macro_; 
// $guard (new_packet) $report (inputPort_1_Daemon new_packet_summary 			 dest_id dest_id 			 pkt_length pkt_length 			 seq_id seq_id )
_inputPort_1_Daemon_stmt_128_c_macro_; 
// 			$volatile next_count_down := ( $mux new_packet (pkt_length - 1 )  (count_down - 1 ) )  $buffering 1
_inputPort_1_Daemon_assign_stmt_138_c_macro_; 
// 			$volatile next_last_dest_id := ( $mux new_packet dest_id  last_dest_id )  $buffering 1
_inputPort_1_Daemon_assign_stmt_144_c_macro_; 
// 			$volatile data_to_outport := (ONE_1 && input_word) $buffering 1
_inputPort_1_Daemon_assign_stmt_149_c_macro_; 
// 			$volatile send_to_1 := (next_last_dest_id == 1 ) $buffering 1
_inputPort_1_Daemon_assign_stmt_154_c_macro_; 
// 			$guard (send_to_1) noblock_obuf_1_1 := data_to_outport $buffering 1// bits of buffering = 33. 
_inputPort_1_Daemon_assign_stmt_158_c_macro_; 
// 			$volatile send_to_2 := (next_last_dest_id == 2 ) $buffering 1
_inputPort_1_Daemon_assign_stmt_163_c_macro_; 
// 			$guard (send_to_2) noblock_obuf_1_2 := data_to_outport $buffering 1// bits of buffering = 33. 
_inputPort_1_Daemon_assign_stmt_167_c_macro_; 
// $report (inputPort_1_Daemon write_status 			 send_to_1 send_to_1 			 send_to_2 send_to_2 			 data_to_outport data_to_outport 			 new_packet new_packet 			 last_dest_id last_dest_id 			 next_last_dest_id next_last_dest_id 			 count_down count_down )
_inputPort_1_Daemon_stmt_175_c_macro_; 
do_while_entry_flag = 0;
do_while_loopback_flag = 1;
bit_vector_clear(&konst_177);\
konst_177.val.byte_array[0] = 1;\
if (!bit_vector_to_uint64(0, &konst_177)) break;
} 
}
_inputPort_1_Daemon_branch_block_stmt_88_c_export_apply_macro_;
}
_inputPort_1_Daemon_inner_outarg_prep_macro__; 
MUTEX_UNLOCK(_inputPort_1_Daemon_series_block_stmt_87_c_mutex_);
}
void inputPort_1_Daemon()
{
_inputPort_1_Daemon_outer_arg_decl_macro__;
_inputPort_1_Daemon_();
_inputPort_1_Daemon_outer_op_xfer_macro__;
}


void _inputPort_2_Daemon_()
{
MUTEX_DECL(_inputPort_2_Daemon_series_block_stmt_180_c_mutex_);
MUTEX_LOCK(_inputPort_2_Daemon_series_block_stmt_180_c_mutex_);
_inputPort_2_Daemon_inner_inarg_prep_macro__; 
_inputPort_2_Daemon_branch_block_stmt_181_c_export_decl_macro_; 
{
{
// do-while:   file .Aa/switch2x2.linked.aa, line 115
__declare_static_bit_vector(konst_269,1);\
bit_vector_clear(&konst_269);\
konst_269.val.byte_array[0] = 1;\
uint8_t do_while_entry_flag;
do_while_entry_flag = 1;
uint8_t do_while_loopback_flag;
do_while_loopback_flag = 0;
while(1) {
// merge  file .Aa/switch2x2.linked.aa, line 117
_inputPort_2_Daemon_merge_stmt_183_c_preamble_macro_; 
// 			$phi count_down := 			  ($bitcast ($uint<16>) 0  ) $on   $entry 			  next_count_down $on   $loopback 
 // type of target is $uint<16>
_inputPort_2_Daemon_phi_stmt_184_c_macro_; 
// 			$phi input_word := 			  in_data_2 $on   $entry ,   $loopback 
 // type of target is $uint<32>
_inputPort_2_Daemon_phi_stmt_189_c_macro_; 
// 			$phi last_dest_id := 			  0  $on   $entry 			  next_last_dest_id $on   $loopback 
 // type of target is $uint<8>
_inputPort_2_Daemon_phi_stmt_192_c_macro_; 
_inputPort_2_Daemon_merge_stmt_183_c_postamble_macro_; 
// $report (inputPort_2_Daemon received_input_word 			 input_word input_word )
_inputPort_2_Daemon_stmt_198_c_macro_; 
// 			$volatile new_packet := (count_down == 0 ) $buffering 1
_inputPort_2_Daemon_assign_stmt_203_c_macro_; 
// 			$volatile dest_id := ( $slice input_word 31 24 )  $buffering 1
_inputPort_2_Daemon_assign_stmt_207_c_macro_; 
// 			$volatile pkt_length := ( $slice input_word 23 8 )  $buffering 1
_inputPort_2_Daemon_assign_stmt_211_c_macro_; 
// 			$volatile seq_id := ( $slice input_word 7 0 )  $buffering 1
_inputPort_2_Daemon_assign_stmt_215_c_macro_; 
// $guard (new_packet) $report (inputPort_2_Daemon new_packet_summary 			 dest_id dest_id 			 pkt_length pkt_length 			 seq_id seq_id )
_inputPort_2_Daemon_stmt_220_c_macro_; 
// 			$volatile next_count_down := ( $mux new_packet (pkt_length - 1 )  (count_down - 1 ) )  $buffering 1
_inputPort_2_Daemon_assign_stmt_230_c_macro_; 
// 			$volatile next_last_dest_id := ( $mux new_packet dest_id  last_dest_id )  $buffering 1
_inputPort_2_Daemon_assign_stmt_236_c_macro_; 
// 			$volatile data_to_outport := (ONE_1 && input_word) $buffering 1
_inputPort_2_Daemon_assign_stmt_241_c_macro_; 
// 			$volatile send_to_1 := (next_last_dest_id == 1 ) $buffering 1
_inputPort_2_Daemon_assign_stmt_246_c_macro_; 
// 			$guard (send_to_1) noblock_obuf_2_1 := data_to_outport $buffering 1// bits of buffering = 33. 
_inputPort_2_Daemon_assign_stmt_250_c_macro_; 
// 			$volatile send_to_2 := (next_last_dest_id == 2 ) $buffering 1
_inputPort_2_Daemon_assign_stmt_255_c_macro_; 
// 			$guard (send_to_2) noblock_obuf_2_2 := data_to_outport $buffering 1// bits of buffering = 33. 
_inputPort_2_Daemon_assign_stmt_259_c_macro_; 
// $report (inputPort_2_Daemon write_status 			 send_to_1 send_to_1 			 send_to_2 send_to_2 			 data_to_outport data_to_outport 			 new_packet new_packet 			 last_dest_id last_dest_id 			 next_last_dest_id next_last_dest_id 			 count_down count_down )
_inputPort_2_Daemon_stmt_267_c_macro_; 
do_while_entry_flag = 0;
do_while_loopback_flag = 1;
bit_vector_clear(&konst_269);\
konst_269.val.byte_array[0] = 1;\
if (!bit_vector_to_uint64(0, &konst_269)) break;
} 
}
_inputPort_2_Daemon_branch_block_stmt_181_c_export_apply_macro_;
}
_inputPort_2_Daemon_inner_outarg_prep_macro__; 
MUTEX_UNLOCK(_inputPort_2_Daemon_series_block_stmt_180_c_mutex_);
}
void inputPort_2_Daemon()
{
_inputPort_2_Daemon_outer_arg_decl_macro__;
_inputPort_2_Daemon_();
_inputPort_2_Daemon_outer_op_xfer_macro__;
}


void _outputPort_1_Daemon_()
{
MUTEX_DECL(_outputPort_1_Daemon_series_block_stmt_333_c_mutex_);
MUTEX_LOCK(_outputPort_1_Daemon_series_block_stmt_333_c_mutex_);
_outputPort_1_Daemon_inner_inarg_prep_macro__; 
_outputPort_1_Daemon_branch_block_stmt_334_c_export_decl_macro_; 
{
{
// do-while:   file .Aa/switch2x2.linked.aa, line 160
__declare_static_bit_vector(konst_493,1);\
bit_vector_clear(&konst_493);\
konst_493.val.byte_array[0] = 1;\
uint8_t do_while_entry_flag;
do_while_entry_flag = 1;
uint8_t do_while_loopback_flag;
do_while_loopback_flag = 0;
while(1) {
// merge  file .Aa/switch2x2.linked.aa, line 162
_outputPort_1_Daemon_merge_stmt_336_c_preamble_macro_; 
// 			$phi down_counter := 			  ZERO_8 $on   $entry 			  next_down_counter $on   $loopback 
 // type of target is $uint<8>
_outputPort_1_Daemon_phi_stmt_337_c_macro_; 
// 			$phi pkt_1_e_word := 			  $guard (read_from_1) noblock_obuf_1_1 $on   $loopback 			  ZERO_33 $on   $entry 
 // type of target is $uint<33>
_outputPort_1_Daemon_phi_stmt_341_c_macro_; 
// 			$phi pkt_2_e_word := 			  ZERO_33 $on   $entry 			  $guard (read_from_2) noblock_obuf_2_1 $on   $loopback 
 // type of target is $uint<33>
_outputPort_1_Daemon_phi_stmt_346_c_macro_; 
// 			$phi active_packet := 			  ZERO_2 $on   $entry 			  next_active_packet $on   $loopback 
 // type of target is $uint<2>
_outputPort_1_Daemon_phi_stmt_351_c_macro_; 
// 			$phi active_packet_length := 			  ZERO_8 $on   $entry 			  next_active_packet_length $on   $loopback 
 // type of target is $uint<8>
_outputPort_1_Daemon_phi_stmt_355_c_macro_; 
// 			$phi pkt_1_has_priority := 			  ZERO_1 $on   $entry 			  next_pkt_1_has_priority $on   $loopback 
 // type of target is $uint<1>
_outputPort_1_Daemon_phi_stmt_359_c_macro_; 
_outputPort_1_Daemon_merge_stmt_336_c_postamble_macro_; 
// 			$volatile p1_valid := (pkt_1_e_word [] 32 ) $buffering 1
_outputPort_1_Daemon_assign_stmt_368_c_macro_; 
// 			$volatile p2_valid := (pkt_2_e_word [] 32 ) $buffering 1
_outputPort_1_Daemon_assign_stmt_373_c_macro_; 
// $report (outputPort_1_Daemon state_summary 			 active_packet active_packet 			 down_counter down_counter 			 pkt_1_has_priority pkt_1_has_priority 			 read_from_1 read_from_1 			 pkt_1_e_word pkt_1_e_word 			 read_from_2 read_from_2 			 pkt_2_e_word pkt_2_e_word )
_outputPort_1_Daemon_stmt_381_c_macro_; 
// 			$volatile valid_active_pkt_word_read := (( $mux (active_packet == 1 ) p1_valid  _b0  )  | ( $mux (active_packet == 2 ) p2_valid  _b0  ) ) $buffering 1
_outputPort_1_Daemon_assign_stmt_396_c_macro_; 
//  $volatile 			$call prioritySelect (down_counter active_packet pkt_1_has_priority p1_valid p2_valid ) (next_active_packet next_pkt_1_has_priority ) 
_outputPort_1_Daemon_call_stmt_404_c_macro_; 
// 			$volatile started_new_packet := ((next_active_packet != 0 ) & (down_counter == 0 )) $buffering 1
_outputPort_1_Daemon_assign_stmt_413_c_macro_; 
// 			$volatile next_active_packet_length := ( $mux started_new_packet ( $mux (next_active_packet == 1 ) ( $slice pkt_1_e_word 15 8 )   ( $slice pkt_2_e_word 15 8 )  )   active_packet_length )  $buffering 1
_outputPort_1_Daemon_assign_stmt_426_c_macro_; 
// 			$volatile next_down_counter := ( $mux started_new_packet (next_active_packet_length - 1 )  ( $mux valid_active_pkt_word_read (down_counter - 1 )  down_counter )  )  $buffering 1
_outputPort_1_Daemon_assign_stmt_439_c_macro_; 
// 			$volatile read_from_1 := (( ~ p1_valid ) | (next_active_packet == 1 )) $buffering 1
_outputPort_1_Daemon_assign_stmt_447_c_macro_; 
// 			$volatile read_from_2 := (( ~ p2_valid ) | (next_active_packet == 2 )) $buffering 1
_outputPort_1_Daemon_assign_stmt_455_c_macro_; 
// 			$volatile data_to_out := ( $mux (next_active_packet == 1 ) ( $slice pkt_1_e_word 31 0 )   ( $slice pkt_2_e_word 31 0 )  )  $buffering 1
_outputPort_1_Daemon_assign_stmt_465_c_macro_; 
// 			$volatile send_flag := (( $mux (next_active_packet == 1 ) p1_valid  _b0  )  | ( $mux (next_active_packet == 2 ) p2_valid  _b0  ) ) $buffering 1
_outputPort_1_Daemon_assign_stmt_480_c_macro_; 
// 			$guard (send_flag) out_data_1 := data_to_out $buffering 1// bits of buffering = 32. 
_outputPort_1_Daemon_assign_stmt_484_c_macro_; 
// $report (outputPort_1_Daemon send_information 			 started_new_packet started_new_packet 			 next_active_packet next_active_packet 			 send_flag send_flag 			 p1_valid p1_valid 			 p2_valid p2_valid 			 data_to_out data_to_out )
_outputPort_1_Daemon_stmt_491_c_macro_; 
do_while_entry_flag = 0;
do_while_loopback_flag = 1;
bit_vector_clear(&konst_493);\
konst_493.val.byte_array[0] = 1;\
if (!bit_vector_to_uint64(0, &konst_493)) break;
} 
}
_outputPort_1_Daemon_branch_block_stmt_334_c_export_apply_macro_;
}
_outputPort_1_Daemon_inner_outarg_prep_macro__; 
MUTEX_UNLOCK(_outputPort_1_Daemon_series_block_stmt_333_c_mutex_);
}
void outputPort_1_Daemon()
{
_outputPort_1_Daemon_outer_arg_decl_macro__;
_outputPort_1_Daemon_();
_outputPort_1_Daemon_outer_op_xfer_macro__;
}


void _outputPort_2_Daemon_()
{
MUTEX_DECL(_outputPort_2_Daemon_series_block_stmt_496_c_mutex_);
MUTEX_LOCK(_outputPort_2_Daemon_series_block_stmt_496_c_mutex_);
_outputPort_2_Daemon_inner_inarg_prep_macro__; 
_outputPort_2_Daemon_branch_block_stmt_497_c_export_decl_macro_; 
{
{
// do-while:   file .Aa/switch2x2.linked.aa, line 200
__declare_static_bit_vector(konst_656,1);\
bit_vector_clear(&konst_656);\
konst_656.val.byte_array[0] = 1;\
uint8_t do_while_entry_flag;
do_while_entry_flag = 1;
uint8_t do_while_loopback_flag;
do_while_loopback_flag = 0;
while(1) {
// merge  file .Aa/switch2x2.linked.aa, line 202
_outputPort_2_Daemon_merge_stmt_499_c_preamble_macro_; 
// 			$phi down_counter := 			  ZERO_8 $on   $entry 			  next_down_counter $on   $loopback 
 // type of target is $uint<8>
_outputPort_2_Daemon_phi_stmt_500_c_macro_; 
// 			$phi pkt_1_e_word := 			  ZERO_33 $on   $entry 			  $guard (read_from_1) noblock_obuf_1_2 $on   $loopback 
 // type of target is $uint<33>
_outputPort_2_Daemon_phi_stmt_504_c_macro_; 
// 			$phi pkt_2_e_word := 			  ZERO_33 $on   $entry 			  $guard (read_from_2) noblock_obuf_2_2 $on   $loopback 
 // type of target is $uint<33>
_outputPort_2_Daemon_phi_stmt_509_c_macro_; 
// 			$phi active_packet := 			  ZERO_2 $on   $entry 			  next_active_packet $on   $loopback 
 // type of target is $uint<2>
_outputPort_2_Daemon_phi_stmt_514_c_macro_; 
// 			$phi active_packet_length := 			  ZERO_8 $on   $entry 			  next_active_packet_length $on   $loopback 
 // type of target is $uint<8>
_outputPort_2_Daemon_phi_stmt_518_c_macro_; 
// 			$phi pkt_1_has_priority := 			  ZERO_1 $on   $entry 			  next_pkt_1_has_priority $on   $loopback 
 // type of target is $uint<1>
_outputPort_2_Daemon_phi_stmt_522_c_macro_; 
_outputPort_2_Daemon_merge_stmt_499_c_postamble_macro_; 
// 			$volatile p1_valid := (pkt_1_e_word [] 32 ) $buffering 1
_outputPort_2_Daemon_assign_stmt_531_c_macro_; 
// 			$volatile p2_valid := (pkt_2_e_word [] 32 ) $buffering 1
_outputPort_2_Daemon_assign_stmt_536_c_macro_; 
// $report (outputPort_2_Daemon state_summary 			 active_packet active_packet 			 down_counter down_counter 			 pkt_1_has_priority pkt_1_has_priority 			 read_from_1 read_from_1 			 pkt_1_e_word pkt_1_e_word 			 read_from_2 read_from_2 			 pkt_2_e_word pkt_2_e_word )
_outputPort_2_Daemon_stmt_544_c_macro_; 
// 			$volatile valid_active_pkt_word_read := (( $mux (active_packet == 1 ) p1_valid  _b0  )  | ( $mux (active_packet == 2 ) p2_valid  _b0  ) ) $buffering 1
_outputPort_2_Daemon_assign_stmt_559_c_macro_; 
//  $volatile 			$call prioritySelect (down_counter active_packet pkt_1_has_priority p1_valid p2_valid ) (next_active_packet next_pkt_1_has_priority ) 
_outputPort_2_Daemon_call_stmt_567_c_macro_; 
// 			$volatile started_new_packet := ((next_active_packet != 0 ) & (down_counter == 0 )) $buffering 1
_outputPort_2_Daemon_assign_stmt_576_c_macro_; 
// 			$volatile next_active_packet_length := ( $mux started_new_packet ( $mux (next_active_packet == 1 ) ( $slice pkt_1_e_word 15 8 )   ( $slice pkt_2_e_word 15 8 )  )   active_packet_length )  $buffering 1
_outputPort_2_Daemon_assign_stmt_589_c_macro_; 
// 			$volatile next_down_counter := ( $mux started_new_packet (next_active_packet_length - 1 )  ( $mux valid_active_pkt_word_read (down_counter - 1 )  down_counter )  )  $buffering 1
_outputPort_2_Daemon_assign_stmt_602_c_macro_; 
// 			$volatile read_from_1 := (( ~ p1_valid ) | (next_active_packet == 1 )) $buffering 1
_outputPort_2_Daemon_assign_stmt_610_c_macro_; 
// 			$volatile read_from_2 := (( ~ p2_valid ) | (next_active_packet == 2 )) $buffering 1
_outputPort_2_Daemon_assign_stmt_618_c_macro_; 
// 			$volatile data_to_out := ( $mux (next_active_packet == 1 ) ( $slice pkt_1_e_word 31 0 )   ( $slice pkt_2_e_word 31 0 )  )  $buffering 1
_outputPort_2_Daemon_assign_stmt_628_c_macro_; 
// 			$volatile send_flag := (( $mux (next_active_packet == 1 ) p1_valid  _b0  )  | ( $mux (next_active_packet == 2 ) p2_valid  _b0  ) ) $buffering 1
_outputPort_2_Daemon_assign_stmt_643_c_macro_; 
// 			$guard (send_flag) out_data_2 := data_to_out $buffering 1// bits of buffering = 32. 
_outputPort_2_Daemon_assign_stmt_647_c_macro_; 
// $report (outputPort_2_Daemon send_information 			 started_new_packet started_new_packet 			 next_active_packet next_active_packet 			 send_flag send_flag 			 p1_valid p1_valid 			 p2_valid p2_valid 			 data_to_out data_to_out )
_outputPort_2_Daemon_stmt_654_c_macro_; 
do_while_entry_flag = 0;
do_while_loopback_flag = 1;
bit_vector_clear(&konst_656);\
konst_656.val.byte_array[0] = 1;\
if (!bit_vector_to_uint64(0, &konst_656)) break;
} 
}
_outputPort_2_Daemon_branch_block_stmt_497_c_export_apply_macro_;
}
_outputPort_2_Daemon_inner_outarg_prep_macro__; 
MUTEX_UNLOCK(_outputPort_2_Daemon_series_block_stmt_496_c_mutex_);
}
void outputPort_2_Daemon()
{
_outputPort_2_Daemon_outer_arg_decl_macro__;
_outputPort_2_Daemon_();
_outputPort_2_Daemon_outer_op_xfer_macro__;
}


void _prioritySelect_(bit_vector* __pdown_counter, bit_vector* __pactive_packet, bit_vector* __ppkt_1_has_priority, bit_vector* __pp1_valid, bit_vector* __pp2_valid, bit_vector*  __pnext_active_packet, bit_vector*  __pnext_pkt_1_has_priority)
{
MUTEX_DECL(_prioritySelect_series_block_stmt_272_c_mutex_);
MUTEX_LOCK(_prioritySelect_series_block_stmt_272_c_mutex_);
_prioritySelect_inner_inarg_prep_macro__; 
// 	d0 := (down_counter == 0 ) $buffering 1
_prioritySelect_assign_stmt_284_c_macro_; 
// 	select_1 := ((d0 & p1_valid) & (pkt_1_has_priority | ( ~ p2_valid ))) $buffering 1
_prioritySelect_assign_stmt_294_c_macro_; 
// 	select_2 := ((d0 & p2_valid) & (( ~ pkt_1_has_priority ) | ( ~ p1_valid ))) $buffering 1
_prioritySelect_assign_stmt_305_c_macro_; 
// 	next_active_packet := ((( $mux ( ~ d0 ) active_packet  _b0  )  | ( $mux select_1 1   _b0  ) ) | ( $mux select_2 2   _b0  ) ) $buffering 1
_prioritySelect_assign_stmt_322_c_macro_; 
// 	next_pkt_1_has_priority := ( $mux (select_1 | select_2) ( ~ pkt_1_has_priority )  pkt_1_has_priority )  $buffering 1
_prioritySelect_assign_stmt_331_c_macro_; 
_prioritySelect_inner_outarg_prep_macro__; 
MUTEX_UNLOCK(_prioritySelect_series_block_stmt_272_c_mutex_);
}
DEFINE_THREAD(converter_1_Daemon);
PTHREAD_DECL(converter_1_Daemon);
DEFINE_THREAD(converter_2_Daemon);
PTHREAD_DECL(converter_2_Daemon);
DEFINE_THREAD(inputPort_1_Daemon);
PTHREAD_DECL(inputPort_1_Daemon);
DEFINE_THREAD(inputPort_2_Daemon);
PTHREAD_DECL(inputPort_2_Daemon);
DEFINE_THREAD(outputPort_1_Daemon);
PTHREAD_DECL(outputPort_1_Daemon);
DEFINE_THREAD(outputPort_2_Daemon);
PTHREAD_DECL(outputPort_2_Daemon);
void start_daemons(FILE* fp, int trace_on) {
__report_log_file__ = fp;
__trace_on__ = trace_on;
__init_aa_globals__(); 
PTHREAD_CREATE(converter_1_Daemon);
PTHREAD_CREATE(converter_2_Daemon);
PTHREAD_CREATE(inputPort_1_Daemon);
PTHREAD_CREATE(inputPort_2_Daemon);
PTHREAD_CREATE(outputPort_1_Daemon);
PTHREAD_CREATE(outputPort_2_Daemon);
}
void stop_daemons() {
PTHREAD_CANCEL(converter_1_Daemon);
PTHREAD_CANCEL(converter_2_Daemon);
PTHREAD_CANCEL(inputPort_1_Daemon);
PTHREAD_CANCEL(inputPort_2_Daemon);
PTHREAD_CANCEL(outputPort_1_Daemon);
PTHREAD_CANCEL(outputPort_2_Daemon);
}
