#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <stdio.h>
#include <BitVectors.h>
#include <pipeHandler.h>
// object initialization 

#define _converter_1_Daemon_inner_inarg_prep_macro__ 
#define _converter_1_Daemon_branch_block_stmt_41_c_export_decl_macro_ __declare_static_bit_vector(in_word_64,64);\
__declare_static_bit_vector(word_lower,32);\


#define _converter_1_Daemon_merge_stmt_43_c_preamble_macro_ uint8_t merge_stmt_43_entry_flag;\
merge_stmt_43_entry_flag = do_while_entry_flag;\
goto merge_stmt_43_run;\
merge_stmt_43_run: ;\

#define _converter_1_Daemon_phi_stmt_44_c_macro_ __declare_static_bit_vector(RPIPE_in_data_1_64_46,64);\
if(do_while_loopback_flag) {\
read_bit_vector_from_pipe("in_data_1_64",&(RPIPE_in_data_1_64_46));\
bit_vector_cast_to_bit_vector(0, &(in_word_64), &(RPIPE_in_data_1_64_46));\
}\
else {\
__declare_static_bit_vector(RPIPE_in_data_1_64_46,64);\
read_bit_vector_from_pipe("in_data_1_64",&(RPIPE_in_data_1_64_46));\
bit_vector_cast_to_bit_vector(0, &(in_word_64), &(RPIPE_in_data_1_64_46));\
}\
;
;

#define _converter_1_Daemon_merge_stmt_43_c_postamble_macro_ merge_stmt_43_entry_flag = 0;

#define _converter_1_Daemon_assign_stmt_51_c_macro_ __declare_static_bit_vector(slice_50,32);\
bit_vector_slice(&(in_word_64), &(slice_50), 0);\
bit_vector_cast_to_bit_vector(0, &(word_lower), &(slice_50));\
;

#define _converter_1_Daemon_stmt_54_c_macro_ uint32_t _converter_1_Daemon_stmt_54_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]converter_1_Daemon>\t%s\n",_converter_1_Daemon_stmt_54_c_macro___print_counter,"conversion_trace");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]converter_1_Daemon>\t\t%s\t\t",_converter_1_Daemon_stmt_54_c_macro___print_counter,"in_word_64");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(in_word_64)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]converter_1_Daemon>\t\t%s\t\t",_converter_1_Daemon_stmt_54_c_macro___print_counter,"word_lower");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(word_lower)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);;

#define _converter_1_Daemon_assign_stmt_57_c_macro_ write_bit_vector_to_pipe("in_data_1",&(word_lower));\
;
;

#define _converter_1_Daemon_branch_block_stmt_41_c_export_apply_macro_ ;

#define _converter_1_Daemon_inner_outarg_prep_macro__ ;

#define _converter_1_Daemon_outer_arg_decl_macro__ ;

#define _converter_1_Daemon_outer_op_xfer_macro__ ;

#define _converter_2_Daemon_inner_inarg_prep_macro__ 
#define _converter_2_Daemon_branch_block_stmt_63_c_export_decl_macro_ __declare_static_bit_vector(in_word_64,64);\
__declare_static_bit_vector(word_lower,32);\


#define _converter_2_Daemon_merge_stmt_65_c_preamble_macro_ uint8_t merge_stmt_65_entry_flag;\
merge_stmt_65_entry_flag = do_while_entry_flag;\
goto merge_stmt_65_run;\
merge_stmt_65_run: ;\

#define _converter_2_Daemon_phi_stmt_66_c_macro_ __declare_static_bit_vector(RPIPE_in_data_2_64_68,64);\
if(do_while_loopback_flag) {\
read_bit_vector_from_pipe("in_data_2_64",&(RPIPE_in_data_2_64_68));\
bit_vector_cast_to_bit_vector(0, &(in_word_64), &(RPIPE_in_data_2_64_68));\
}\
else {\
__declare_static_bit_vector(RPIPE_in_data_2_64_68,64);\
read_bit_vector_from_pipe("in_data_2_64",&(RPIPE_in_data_2_64_68));\
bit_vector_cast_to_bit_vector(0, &(in_word_64), &(RPIPE_in_data_2_64_68));\
}\
;
;

#define _converter_2_Daemon_merge_stmt_65_c_postamble_macro_ merge_stmt_65_entry_flag = 0;

#define _converter_2_Daemon_assign_stmt_73_c_macro_ __declare_static_bit_vector(slice_72,32);\
bit_vector_slice(&(in_word_64), &(slice_72), 0);\
bit_vector_cast_to_bit_vector(0, &(word_lower), &(slice_72));\
;

#define _converter_2_Daemon_stmt_76_c_macro_ uint32_t _converter_2_Daemon_stmt_76_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]converter_2_Daemon>\t%s\n",_converter_2_Daemon_stmt_76_c_macro___print_counter,"conversion_trace");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]converter_2_Daemon>\t\t%s\t\t",_converter_2_Daemon_stmt_76_c_macro___print_counter,"in_word_64");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(in_word_64)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]converter_2_Daemon>\t\t%s\t\t",_converter_2_Daemon_stmt_76_c_macro___print_counter,"word_lower");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(word_lower)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);;

#define _converter_2_Daemon_assign_stmt_79_c_macro_ write_bit_vector_to_pipe("in_data_2",&(word_lower));\
;
;

#define _converter_2_Daemon_branch_block_stmt_63_c_export_apply_macro_ ;

#define _converter_2_Daemon_inner_outarg_prep_macro__ ;

#define _converter_2_Daemon_outer_arg_decl_macro__ ;

#define _converter_2_Daemon_outer_op_xfer_macro__ ;

#define _global_storage_initializer__inner_inarg_prep_macro__ 
#define _global_storage_initializer__inner_outarg_prep_macro__ ;

#define _global_storage_initializer__outer_arg_decl_macro__ ;

#define _global_storage_initializer__outer_op_xfer_macro__ ;

#define _inputPort_1_Daemon_inner_inarg_prep_macro__ 
#define _inputPort_1_Daemon_branch_block_stmt_88_c_export_decl_macro_ __declare_static_bit_vector(count_down,16);\
__declare_static_bit_vector(input_word,32);\
__declare_static_bit_vector(last_dest_id,8);\
__declare_static_bit_vector(new_packet,1);\
__declare_static_bit_vector(dest_id,8);\
__declare_static_bit_vector(pkt_length,16);\
__declare_static_bit_vector(seq_id,8);\
__declare_static_bit_vector(next_count_down,16);\
__declare_static_bit_vector(next_last_dest_id,8);\
__declare_static_bit_vector(data_to_outport,33);\
__declare_static_bit_vector(send_to_1,1);\
__declare_static_bit_vector(send_to_2,1);\


#define _inputPort_1_Daemon_merge_stmt_90_c_preamble_macro_ uint8_t merge_stmt_90_entry_flag;\
merge_stmt_90_entry_flag = do_while_entry_flag;\
goto merge_stmt_90_run;\
merge_stmt_90_run: ;\

#define _inputPort_1_Daemon_phi_stmt_91_c_macro_ __declare_static_bit_vector(konst_94,16);\
bit_vector_clear(&konst_94);\
__declare_static_bit_vector(type_cast_95,16);\
bit_vector_clear(&type_cast_95);\
if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(count_down), &(next_count_down));\
}\
else {\
__declare_static_bit_vector(konst_94,16);\
bit_vector_clear(&konst_94);\
__declare_static_bit_vector(type_cast_95,16);\
bit_vector_clear(&type_cast_95);\
bit_vector_clear(&konst_94);\
bit_vector_bitcast_to_bit_vector( &(type_cast_95), &(konst_94));\
bit_vector_cast_to_bit_vector(0, &(count_down), &(type_cast_95));\
}\
;

#define _inputPort_1_Daemon_phi_stmt_97_c_macro_ __declare_static_bit_vector(RPIPE_in_data_1_99,32);\
if(do_while_loopback_flag) {\
read_bit_vector_from_pipe("in_data_1",&(RPIPE_in_data_1_99));\
bit_vector_cast_to_bit_vector(0, &(input_word), &(RPIPE_in_data_1_99));\
}\
else {\
__declare_static_bit_vector(RPIPE_in_data_1_99,32);\
read_bit_vector_from_pipe("in_data_1",&(RPIPE_in_data_1_99));\
bit_vector_cast_to_bit_vector(0, &(input_word), &(RPIPE_in_data_1_99));\
}\
;

#define _inputPort_1_Daemon_phi_stmt_100_c_macro_ __declare_static_bit_vector(konst_102,8);\
bit_vector_clear(&konst_102);\
if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(last_dest_id), &(next_last_dest_id));\
}\
else {\
__declare_static_bit_vector(konst_102,8);\
bit_vector_clear(&konst_102);\
bit_vector_clear(&konst_102);\
bit_vector_cast_to_bit_vector(0, &(last_dest_id), &(konst_102));\
}\
;
;

#define _inputPort_1_Daemon_merge_stmt_90_c_postamble_macro_ merge_stmt_90_entry_flag = 0;

#define _inputPort_1_Daemon_stmt_106_c_macro_ uint32_t _inputPort_1_Daemon_stmt_106_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t%s\n",_inputPort_1_Daemon_stmt_106_c_macro___print_counter,"received_input_word");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t\t%s\t\t",_inputPort_1_Daemon_stmt_106_c_macro___print_counter,"input_word");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(input_word)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);;

#define _inputPort_1_Daemon_assign_stmt_111_c_macro_ __declare_static_bit_vector(konst_109,16);\
bit_vector_clear(&konst_109);\
__declare_static_bit_vector(EQ_u16_u1_110,1);\
bit_vector_clear(&konst_109);\
bit_vector_equal(0, &(count_down), &(konst_109), &(EQ_u16_u1_110));\
bit_vector_cast_to_bit_vector(0, &(new_packet), &(EQ_u16_u1_110));\
;

#define _inputPort_1_Daemon_assign_stmt_115_c_macro_ __declare_static_bit_vector(slice_114,8);\
bit_vector_slice(&(input_word), &(slice_114), 24);\
bit_vector_cast_to_bit_vector(0, &(dest_id), &(slice_114));\
;

#define _inputPort_1_Daemon_assign_stmt_119_c_macro_ __declare_static_bit_vector(slice_118,16);\
bit_vector_slice(&(input_word), &(slice_118), 8);\
bit_vector_cast_to_bit_vector(0, &(pkt_length), &(slice_118));\
;

#define _inputPort_1_Daemon_assign_stmt_123_c_macro_ __declare_static_bit_vector(slice_122,8);\
bit_vector_slice(&(input_word), &(slice_122), 0);\
bit_vector_cast_to_bit_vector(0, &(seq_id), &(slice_122));\
;

#define _inputPort_1_Daemon_stmt_128_c_macro_ if (bit_vector_to_uint64(0, &new_packet)) {\
uint32_t _inputPort_1_Daemon_stmt_128_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t%s\n",_inputPort_1_Daemon_stmt_128_c_macro___print_counter,"new_packet_summary");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t\t%s\t\t",_inputPort_1_Daemon_stmt_128_c_macro___print_counter,"dest_id");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(dest_id)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t\t%s\t\t",_inputPort_1_Daemon_stmt_128_c_macro___print_counter,"pkt_length");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(pkt_length)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t\t%s\t\t",_inputPort_1_Daemon_stmt_128_c_macro___print_counter,"seq_id");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(seq_id)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);};

#define _inputPort_1_Daemon_assign_stmt_138_c_macro_ __declare_static_bit_vector(konst_132,16);\
bit_vector_clear(&konst_132);\
konst_132.val.byte_array[0] = 1;\
__declare_static_bit_vector(SUB_u16_u16_133,16);\
__declare_static_bit_vector(konst_135,16);\
bit_vector_clear(&konst_135);\
konst_135.val.byte_array[0] = 1;\
__declare_static_bit_vector(SUB_u16_u16_136,16);\
__declare_static_bit_vector(MUX_137,16);\
if (has_undefined_bit(&new_packet)) {fprintf(stderr, "Error: variable new_packet has undefined value (%s) at test point.\n", to_string(&new_packet));assert(0);} \
if(bit_vector_to_uint64(0, &new_packet)){bit_vector_clear(&konst_132);\
konst_132.val.byte_array[0] = 1;\
bit_vector_minus( &(pkt_length), &(konst_132), &(SUB_u16_u16_133));\
bit_vector_cast_to_bit_vector(0, &(MUX_137), &(SUB_u16_u16_133));\
}else {bit_vector_clear(&konst_135);\
konst_135.val.byte_array[0] = 1;\
bit_vector_minus( &(count_down), &(konst_135), &(SUB_u16_u16_136));\
bit_vector_cast_to_bit_vector(0, &(MUX_137), &(SUB_u16_u16_136));\
}bit_vector_cast_to_bit_vector(0, &(next_count_down), &(MUX_137));\
;

#define _inputPort_1_Daemon_assign_stmt_144_c_macro_ __declare_static_bit_vector(MUX_143,8);\
if (has_undefined_bit(&new_packet)) {fprintf(stderr, "Error: variable new_packet has undefined value (%s) at test point.\n", to_string(&new_packet));assert(0);} \
if(bit_vector_to_uint64(0, &new_packet)){bit_vector_cast_to_bit_vector(0, &(MUX_143), &(dest_id));\
}else {bit_vector_cast_to_bit_vector(0, &(MUX_143), &(last_dest_id));\
}bit_vector_cast_to_bit_vector(0, &(next_last_dest_id), &(MUX_143));\
;

#define _inputPort_1_Daemon_assign_stmt_149_c_macro_ __declare_static_bit_vector(CONCAT_u1_u33_148,33);\
bit_vector_concatenate( &(ONE_1), &(input_word), &(CONCAT_u1_u33_148));\
bit_vector_cast_to_bit_vector(0, &(data_to_outport), &(CONCAT_u1_u33_148));\
;

#define _inputPort_1_Daemon_assign_stmt_154_c_macro_ __declare_static_bit_vector(konst_152,8);\
bit_vector_clear(&konst_152);\
konst_152.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u8_u1_153,1);\
bit_vector_clear(&konst_152);\
konst_152.val.byte_array[0] = 1;\
bit_vector_equal(0, &(next_last_dest_id), &(konst_152), &(EQ_u8_u1_153));\
bit_vector_cast_to_bit_vector(0, &(send_to_1), &(EQ_u8_u1_153));\
;

#define _inputPort_1_Daemon_assign_stmt_158_c_macro_ if (has_undefined_bit(&send_to_1)) {fprintf(stderr, "Error: variable send_to_1 has undefined value (%s) at test point.\n", to_string(&send_to_1));assert(0);} \
if (bit_vector_to_uint64(0, &send_to_1)) {\
write_bit_vector_to_pipe("noblock_obuf_1_1",&(data_to_outport));\
}
;

#define _inputPort_1_Daemon_assign_stmt_163_c_macro_ __declare_static_bit_vector(konst_161,8);\
bit_vector_clear(&konst_161);\
konst_161.val.byte_array[0] = 2;\
__declare_static_bit_vector(EQ_u8_u1_162,1);\
bit_vector_clear(&konst_161);\
konst_161.val.byte_array[0] = 2;\
bit_vector_equal(0, &(next_last_dest_id), &(konst_161), &(EQ_u8_u1_162));\
bit_vector_cast_to_bit_vector(0, &(send_to_2), &(EQ_u8_u1_162));\
;

#define _inputPort_1_Daemon_assign_stmt_167_c_macro_ if (has_undefined_bit(&send_to_2)) {fprintf(stderr, "Error: variable send_to_2 has undefined value (%s) at test point.\n", to_string(&send_to_2));assert(0);} \
if (bit_vector_to_uint64(0, &send_to_2)) {\
write_bit_vector_to_pipe("noblock_obuf_1_2",&(data_to_outport));\
}
;

#define _inputPort_1_Daemon_stmt_175_c_macro_ uint32_t _inputPort_1_Daemon_stmt_175_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t%s\n",_inputPort_1_Daemon_stmt_175_c_macro___print_counter,"write_status");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t\t%s\t\t",_inputPort_1_Daemon_stmt_175_c_macro___print_counter,"send_to_1");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(send_to_1)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t\t%s\t\t",_inputPort_1_Daemon_stmt_175_c_macro___print_counter,"send_to_2");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(send_to_2)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t\t%s\t\t",_inputPort_1_Daemon_stmt_175_c_macro___print_counter,"data_to_outport");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(data_to_outport)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t\t%s\t\t",_inputPort_1_Daemon_stmt_175_c_macro___print_counter,"new_packet");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(new_packet)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t\t%s\t\t",_inputPort_1_Daemon_stmt_175_c_macro___print_counter,"last_dest_id");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(last_dest_id)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t\t%s\t\t",_inputPort_1_Daemon_stmt_175_c_macro___print_counter,"next_last_dest_id");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(next_last_dest_id)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_1_Daemon>\t\t%s\t\t",_inputPort_1_Daemon_stmt_175_c_macro___print_counter,"count_down");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(count_down)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);;
;

#define _inputPort_1_Daemon_branch_block_stmt_88_c_export_apply_macro_ ;

#define _inputPort_1_Daemon_inner_outarg_prep_macro__ ;

#define _inputPort_1_Daemon_outer_arg_decl_macro__ ;

#define _inputPort_1_Daemon_outer_op_xfer_macro__ ;

#define _inputPort_2_Daemon_inner_inarg_prep_macro__ 
#define _inputPort_2_Daemon_branch_block_stmt_181_c_export_decl_macro_ __declare_static_bit_vector(count_down,16);\
__declare_static_bit_vector(input_word,32);\
__declare_static_bit_vector(last_dest_id,8);\
__declare_static_bit_vector(new_packet,1);\
__declare_static_bit_vector(dest_id,8);\
__declare_static_bit_vector(pkt_length,16);\
__declare_static_bit_vector(seq_id,8);\
__declare_static_bit_vector(next_count_down,16);\
__declare_static_bit_vector(next_last_dest_id,8);\
__declare_static_bit_vector(data_to_outport,33);\
__declare_static_bit_vector(send_to_1,1);\
__declare_static_bit_vector(send_to_2,1);\


#define _inputPort_2_Daemon_merge_stmt_183_c_preamble_macro_ uint8_t merge_stmt_183_entry_flag;\
merge_stmt_183_entry_flag = do_while_entry_flag;\
goto merge_stmt_183_run;\
merge_stmt_183_run: ;\

#define _inputPort_2_Daemon_phi_stmt_184_c_macro_ __declare_static_bit_vector(konst_186,16);\
bit_vector_clear(&konst_186);\
__declare_static_bit_vector(type_cast_187,16);\
bit_vector_clear(&type_cast_187);\
if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(count_down), &(next_count_down));\
}\
else {\
__declare_static_bit_vector(konst_186,16);\
bit_vector_clear(&konst_186);\
__declare_static_bit_vector(type_cast_187,16);\
bit_vector_clear(&type_cast_187);\
bit_vector_clear(&konst_186);\
bit_vector_bitcast_to_bit_vector( &(type_cast_187), &(konst_186));\
bit_vector_cast_to_bit_vector(0, &(count_down), &(type_cast_187));\
}\
;

#define _inputPort_2_Daemon_phi_stmt_189_c_macro_ __declare_static_bit_vector(RPIPE_in_data_2_191,32);\
if(do_while_loopback_flag) {\
read_bit_vector_from_pipe("in_data_2",&(RPIPE_in_data_2_191));\
bit_vector_cast_to_bit_vector(0, &(input_word), &(RPIPE_in_data_2_191));\
}\
else {\
__declare_static_bit_vector(RPIPE_in_data_2_191,32);\
read_bit_vector_from_pipe("in_data_2",&(RPIPE_in_data_2_191));\
bit_vector_cast_to_bit_vector(0, &(input_word), &(RPIPE_in_data_2_191));\
}\
;

#define _inputPort_2_Daemon_phi_stmt_192_c_macro_ __declare_static_bit_vector(konst_194,8);\
bit_vector_clear(&konst_194);\
if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(last_dest_id), &(next_last_dest_id));\
}\
else {\
__declare_static_bit_vector(konst_194,8);\
bit_vector_clear(&konst_194);\
bit_vector_clear(&konst_194);\
bit_vector_cast_to_bit_vector(0, &(last_dest_id), &(konst_194));\
}\
;
;

#define _inputPort_2_Daemon_merge_stmt_183_c_postamble_macro_ merge_stmt_183_entry_flag = 0;

#define _inputPort_2_Daemon_stmt_198_c_macro_ uint32_t _inputPort_2_Daemon_stmt_198_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t%s\n",_inputPort_2_Daemon_stmt_198_c_macro___print_counter,"received_input_word");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t\t%s\t\t",_inputPort_2_Daemon_stmt_198_c_macro___print_counter,"input_word");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(input_word)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);;

#define _inputPort_2_Daemon_assign_stmt_203_c_macro_ __declare_static_bit_vector(konst_201,16);\
bit_vector_clear(&konst_201);\
__declare_static_bit_vector(EQ_u16_u1_202,1);\
bit_vector_clear(&konst_201);\
bit_vector_equal(0, &(count_down), &(konst_201), &(EQ_u16_u1_202));\
bit_vector_cast_to_bit_vector(0, &(new_packet), &(EQ_u16_u1_202));\
;

#define _inputPort_2_Daemon_assign_stmt_207_c_macro_ __declare_static_bit_vector(slice_206,8);\
bit_vector_slice(&(input_word), &(slice_206), 24);\
bit_vector_cast_to_bit_vector(0, &(dest_id), &(slice_206));\
;

#define _inputPort_2_Daemon_assign_stmt_211_c_macro_ __declare_static_bit_vector(slice_210,16);\
bit_vector_slice(&(input_word), &(slice_210), 8);\
bit_vector_cast_to_bit_vector(0, &(pkt_length), &(slice_210));\
;

#define _inputPort_2_Daemon_assign_stmt_215_c_macro_ __declare_static_bit_vector(slice_214,8);\
bit_vector_slice(&(input_word), &(slice_214), 0);\
bit_vector_cast_to_bit_vector(0, &(seq_id), &(slice_214));\
;

#define _inputPort_2_Daemon_stmt_220_c_macro_ if (bit_vector_to_uint64(0, &new_packet)) {\
uint32_t _inputPort_2_Daemon_stmt_220_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t%s\n",_inputPort_2_Daemon_stmt_220_c_macro___print_counter,"new_packet_summary");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t\t%s\t\t",_inputPort_2_Daemon_stmt_220_c_macro___print_counter,"dest_id");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(dest_id)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t\t%s\t\t",_inputPort_2_Daemon_stmt_220_c_macro___print_counter,"pkt_length");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(pkt_length)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t\t%s\t\t",_inputPort_2_Daemon_stmt_220_c_macro___print_counter,"seq_id");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(seq_id)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);};

#define _inputPort_2_Daemon_assign_stmt_230_c_macro_ __declare_static_bit_vector(konst_224,16);\
bit_vector_clear(&konst_224);\
konst_224.val.byte_array[0] = 1;\
__declare_static_bit_vector(SUB_u16_u16_225,16);\
__declare_static_bit_vector(konst_227,16);\
bit_vector_clear(&konst_227);\
konst_227.val.byte_array[0] = 1;\
__declare_static_bit_vector(SUB_u16_u16_228,16);\
__declare_static_bit_vector(MUX_229,16);\
if (has_undefined_bit(&new_packet)) {fprintf(stderr, "Error: variable new_packet has undefined value (%s) at test point.\n", to_string(&new_packet));assert(0);} \
if(bit_vector_to_uint64(0, &new_packet)){bit_vector_clear(&konst_224);\
konst_224.val.byte_array[0] = 1;\
bit_vector_minus( &(pkt_length), &(konst_224), &(SUB_u16_u16_225));\
bit_vector_cast_to_bit_vector(0, &(MUX_229), &(SUB_u16_u16_225));\
}else {bit_vector_clear(&konst_227);\
konst_227.val.byte_array[0] = 1;\
bit_vector_minus( &(count_down), &(konst_227), &(SUB_u16_u16_228));\
bit_vector_cast_to_bit_vector(0, &(MUX_229), &(SUB_u16_u16_228));\
}bit_vector_cast_to_bit_vector(0, &(next_count_down), &(MUX_229));\
;

#define _inputPort_2_Daemon_assign_stmt_236_c_macro_ __declare_static_bit_vector(MUX_235,8);\
if (has_undefined_bit(&new_packet)) {fprintf(stderr, "Error: variable new_packet has undefined value (%s) at test point.\n", to_string(&new_packet));assert(0);} \
if(bit_vector_to_uint64(0, &new_packet)){bit_vector_cast_to_bit_vector(0, &(MUX_235), &(dest_id));\
}else {bit_vector_cast_to_bit_vector(0, &(MUX_235), &(last_dest_id));\
}bit_vector_cast_to_bit_vector(0, &(next_last_dest_id), &(MUX_235));\
;

#define _inputPort_2_Daemon_assign_stmt_241_c_macro_ __declare_static_bit_vector(CONCAT_u1_u33_240,33);\
bit_vector_concatenate( &(ONE_1), &(input_word), &(CONCAT_u1_u33_240));\
bit_vector_cast_to_bit_vector(0, &(data_to_outport), &(CONCAT_u1_u33_240));\
;

#define _inputPort_2_Daemon_assign_stmt_246_c_macro_ __declare_static_bit_vector(konst_244,8);\
bit_vector_clear(&konst_244);\
konst_244.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u8_u1_245,1);\
bit_vector_clear(&konst_244);\
konst_244.val.byte_array[0] = 1;\
bit_vector_equal(0, &(next_last_dest_id), &(konst_244), &(EQ_u8_u1_245));\
bit_vector_cast_to_bit_vector(0, &(send_to_1), &(EQ_u8_u1_245));\
;

#define _inputPort_2_Daemon_assign_stmt_250_c_macro_ if (has_undefined_bit(&send_to_1)) {fprintf(stderr, "Error: variable send_to_1 has undefined value (%s) at test point.\n", to_string(&send_to_1));assert(0);} \
if (bit_vector_to_uint64(0, &send_to_1)) {\
write_bit_vector_to_pipe("noblock_obuf_2_1",&(data_to_outport));\
}
;

#define _inputPort_2_Daemon_assign_stmt_255_c_macro_ __declare_static_bit_vector(konst_253,8);\
bit_vector_clear(&konst_253);\
konst_253.val.byte_array[0] = 2;\
__declare_static_bit_vector(EQ_u8_u1_254,1);\
bit_vector_clear(&konst_253);\
konst_253.val.byte_array[0] = 2;\
bit_vector_equal(0, &(next_last_dest_id), &(konst_253), &(EQ_u8_u1_254));\
bit_vector_cast_to_bit_vector(0, &(send_to_2), &(EQ_u8_u1_254));\
;

#define _inputPort_2_Daemon_assign_stmt_259_c_macro_ if (has_undefined_bit(&send_to_2)) {fprintf(stderr, "Error: variable send_to_2 has undefined value (%s) at test point.\n", to_string(&send_to_2));assert(0);} \
if (bit_vector_to_uint64(0, &send_to_2)) {\
write_bit_vector_to_pipe("noblock_obuf_2_2",&(data_to_outport));\
}
;

#define _inputPort_2_Daemon_stmt_267_c_macro_ uint32_t _inputPort_2_Daemon_stmt_267_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t%s\n",_inputPort_2_Daemon_stmt_267_c_macro___print_counter,"write_status");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t\t%s\t\t",_inputPort_2_Daemon_stmt_267_c_macro___print_counter,"send_to_1");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(send_to_1)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t\t%s\t\t",_inputPort_2_Daemon_stmt_267_c_macro___print_counter,"send_to_2");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(send_to_2)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t\t%s\t\t",_inputPort_2_Daemon_stmt_267_c_macro___print_counter,"data_to_outport");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(data_to_outport)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t\t%s\t\t",_inputPort_2_Daemon_stmt_267_c_macro___print_counter,"new_packet");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(new_packet)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t\t%s\t\t",_inputPort_2_Daemon_stmt_267_c_macro___print_counter,"last_dest_id");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(last_dest_id)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t\t%s\t\t",_inputPort_2_Daemon_stmt_267_c_macro___print_counter,"next_last_dest_id");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(next_last_dest_id)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]inputPort_2_Daemon>\t\t%s\t\t",_inputPort_2_Daemon_stmt_267_c_macro___print_counter,"count_down");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(count_down)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);;
;

#define _inputPort_2_Daemon_branch_block_stmt_181_c_export_apply_macro_ ;

#define _inputPort_2_Daemon_inner_outarg_prep_macro__ ;

#define _inputPort_2_Daemon_outer_arg_decl_macro__ ;

#define _inputPort_2_Daemon_outer_op_xfer_macro__ ;

#define _outputPort_1_Daemon_inner_inarg_prep_macro__ 
#define _outputPort_1_Daemon_branch_block_stmt_334_c_export_decl_macro_ __declare_static_bit_vector(down_counter,8);\
__declare_static_bit_vector(pkt_1_e_word,33);\
__declare_static_bit_vector(pkt_2_e_word,33);\
__declare_static_bit_vector(active_packet,2);\
__declare_static_bit_vector(active_packet_length,8);\
__declare_static_bit_vector(pkt_1_has_priority,1);\
__declare_static_bit_vector(p1_valid,1);\
__declare_static_bit_vector(p2_valid,1);\
__declare_static_bit_vector(valid_active_pkt_word_read,1);\
__declare_static_bit_vector(next_active_packet,2);\
__declare_static_bit_vector(next_pkt_1_has_priority,1);\
__declare_static_bit_vector(started_new_packet,1);\
__declare_static_bit_vector(next_active_packet_length,8);\
__declare_static_bit_vector(next_down_counter,8);\
__declare_static_bit_vector(read_from_1,1);\
__declare_static_bit_vector(read_from_2,1);\
__declare_static_bit_vector(data_to_out,32);\
__declare_static_bit_vector(send_flag,1);\


#define _outputPort_1_Daemon_merge_stmt_336_c_preamble_macro_ uint8_t merge_stmt_336_entry_flag;\
merge_stmt_336_entry_flag = do_while_entry_flag;\
goto merge_stmt_336_run;\
merge_stmt_336_run: ;\

#define _outputPort_1_Daemon_phi_stmt_337_c_macro_ if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(down_counter), &(next_down_counter));\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(down_counter), &(ZERO_8));\
}\
;

#define _outputPort_1_Daemon_phi_stmt_341_c_macro_ __declare_static_bit_vector(RPIPE_noblock_obuf_1_1_344,33);\
if(do_while_loopback_flag) {\
if(bit_vector_to_uint64(0, &read_from_1)) {\
read_bit_vector_from_pipe("noblock_obuf_1_1",&(RPIPE_noblock_obuf_1_1_344));\
bit_vector_cast_to_bit_vector(0, &(pkt_1_e_word), &(RPIPE_noblock_obuf_1_1_344));\
}\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(pkt_1_e_word), &(ZERO_33));\
}\
;

#define _outputPort_1_Daemon_phi_stmt_346_c_macro_ __declare_static_bit_vector(RPIPE_noblock_obuf_2_1_350,33);\
if(do_while_loopback_flag) {\
if(bit_vector_to_uint64(0, &read_from_2)) {\
read_bit_vector_from_pipe("noblock_obuf_2_1",&(RPIPE_noblock_obuf_2_1_350));\
bit_vector_cast_to_bit_vector(0, &(pkt_2_e_word), &(RPIPE_noblock_obuf_2_1_350));\
}\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(pkt_2_e_word), &(ZERO_33));\
}\
;

#define _outputPort_1_Daemon_phi_stmt_351_c_macro_ if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(active_packet), &(next_active_packet));\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(active_packet), &(ZERO_2));\
}\
;

#define _outputPort_1_Daemon_phi_stmt_355_c_macro_ if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(active_packet_length), &(next_active_packet_length));\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(active_packet_length), &(ZERO_8));\
}\
;

#define _outputPort_1_Daemon_phi_stmt_359_c_macro_ if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(pkt_1_has_priority), &(next_pkt_1_has_priority));\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(pkt_1_has_priority), &(ZERO_1));\
}\
;
;

#define _outputPort_1_Daemon_merge_stmt_336_c_postamble_macro_ merge_stmt_336_entry_flag = 0;

#define _outputPort_1_Daemon_assign_stmt_368_c_macro_ __declare_static_bit_vector(konst_366,33);\
bit_vector_clear(&konst_366);\
konst_366.val.byte_array[0] = 32;\
__declare_static_bit_vector(BITSEL_u33_u1_367,1);\
bit_vector_clear(&konst_366);\
konst_366.val.byte_array[0] = 32;\
bit_vector_bitsel( &(pkt_1_e_word), &(konst_366), &(BITSEL_u33_u1_367));\
bit_vector_cast_to_bit_vector(0, &(p1_valid), &(BITSEL_u33_u1_367));\
;

#define _outputPort_1_Daemon_assign_stmt_373_c_macro_ __declare_static_bit_vector(konst_371,33);\
bit_vector_clear(&konst_371);\
konst_371.val.byte_array[0] = 32;\
__declare_static_bit_vector(BITSEL_u33_u1_372,1);\
bit_vector_clear(&konst_371);\
konst_371.val.byte_array[0] = 32;\
bit_vector_bitsel( &(pkt_2_e_word), &(konst_371), &(BITSEL_u33_u1_372));\
bit_vector_cast_to_bit_vector(0, &(p2_valid), &(BITSEL_u33_u1_372));\
;

#define _outputPort_1_Daemon_stmt_381_c_macro_ uint32_t _outputPort_1_Daemon_stmt_381_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t%s\n",_outputPort_1_Daemon_stmt_381_c_macro___print_counter,"state_summary");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_381_c_macro___print_counter,"active_packet");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(active_packet)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_381_c_macro___print_counter,"down_counter");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(down_counter)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_381_c_macro___print_counter,"pkt_1_has_priority");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(pkt_1_has_priority)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_381_c_macro___print_counter,"read_from_1");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(read_from_1)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_381_c_macro___print_counter,"pkt_1_e_word");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(pkt_1_e_word)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_381_c_macro___print_counter,"read_from_2");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(read_from_2)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_381_c_macro___print_counter,"pkt_2_e_word");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(pkt_2_e_word)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);;

#define _outputPort_1_Daemon_assign_stmt_396_c_macro_ __declare_static_bit_vector(konst_384,2);\
bit_vector_clear(&konst_384);\
konst_384.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u2_u1_385,1);\
__declare_static_bit_vector(konst_387,1);\
bit_vector_clear(&konst_387);\
__declare_static_bit_vector(MUX_388,1);\
__declare_static_bit_vector(konst_390,2);\
bit_vector_clear(&konst_390);\
konst_390.val.byte_array[0] = 2;\
__declare_static_bit_vector(EQ_u2_u1_391,1);\
__declare_static_bit_vector(konst_393,1);\
bit_vector_clear(&konst_393);\
__declare_static_bit_vector(MUX_394,1);\
__declare_static_bit_vector(OR_u1_u1_395,1);\
bit_vector_clear(&konst_384);\
konst_384.val.byte_array[0] = 1;\
bit_vector_equal(0, &(active_packet), &(konst_384), &(EQ_u2_u1_385));\
if (has_undefined_bit(&EQ_u2_u1_385)) {fprintf(stderr, "Error: variable EQ_u2_u1_385 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_385));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_385)){bit_vector_cast_to_bit_vector(0, &(MUX_388), &(p1_valid));\
}else {bit_vector_clear(&konst_387);\
bit_vector_cast_to_bit_vector(0, &(MUX_388), &(konst_387));\
}bit_vector_clear(&konst_390);\
konst_390.val.byte_array[0] = 2;\
bit_vector_equal(0, &(active_packet), &(konst_390), &(EQ_u2_u1_391));\
if (has_undefined_bit(&EQ_u2_u1_391)) {fprintf(stderr, "Error: variable EQ_u2_u1_391 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_391));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_391)){bit_vector_cast_to_bit_vector(0, &(MUX_394), &(p2_valid));\
}else {bit_vector_clear(&konst_393);\
bit_vector_cast_to_bit_vector(0, &(MUX_394), &(konst_393));\
}bit_vector_or(&(MUX_388), &(MUX_394), &(OR_u1_u1_395));\
bit_vector_cast_to_bit_vector(0, &(valid_active_pkt_word_read), &(OR_u1_u1_395));\
;

#define _outputPort_1_Daemon_call_stmt_404_c_macro_ _prioritySelect_( &(down_counter),  &(active_packet),  &(pkt_1_has_priority),  &(p1_valid),  &(p2_valid), &(next_active_packet), &(next_pkt_1_has_priority));\
;

#define _outputPort_1_Daemon_assign_stmt_413_c_macro_ __declare_static_bit_vector(konst_407,2);\
bit_vector_clear(&konst_407);\
__declare_static_bit_vector(NEQ_u2_u1_408,1);\
__declare_static_bit_vector(konst_410,8);\
bit_vector_clear(&konst_410);\
__declare_static_bit_vector(EQ_u8_u1_411,1);\
__declare_static_bit_vector(AND_u1_u1_412,1);\
bit_vector_clear(&konst_407);\
bit_vector_not_equal(0, &(next_active_packet), &(konst_407), &NEQ_u2_u1_408);\
bit_vector_clear(&konst_410);\
bit_vector_equal(0, &(down_counter), &(konst_410), &(EQ_u8_u1_411));\
bit_vector_and(&(NEQ_u2_u1_408), &(EQ_u8_u1_411), &(AND_u1_u1_412));\
bit_vector_cast_to_bit_vector(0, &(started_new_packet), &(AND_u1_u1_412));\
;

#define _outputPort_1_Daemon_assign_stmt_426_c_macro_ __declare_static_bit_vector(konst_417,2);\
bit_vector_clear(&konst_417);\
konst_417.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u2_u1_418,1);\
__declare_static_bit_vector(slice_420,8);\
__declare_static_bit_vector(slice_422,8);\
__declare_static_bit_vector(MUX_423,8);\
__declare_static_bit_vector(MUX_425,8);\
if (has_undefined_bit(&started_new_packet)) {fprintf(stderr, "Error: variable started_new_packet has undefined value (%s) at test point.\n", to_string(&started_new_packet));assert(0);} \
if(bit_vector_to_uint64(0, &started_new_packet)){bit_vector_clear(&konst_417);\
konst_417.val.byte_array[0] = 1;\
bit_vector_equal(0, &(next_active_packet), &(konst_417), &(EQ_u2_u1_418));\
if (has_undefined_bit(&EQ_u2_u1_418)) {fprintf(stderr, "Error: variable EQ_u2_u1_418 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_418));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_418)){bit_vector_slice(&(pkt_1_e_word), &(slice_420), 8);\
bit_vector_cast_to_bit_vector(0, &(MUX_423), &(slice_420));\
}else {bit_vector_slice(&(pkt_2_e_word), &(slice_422), 8);\
bit_vector_cast_to_bit_vector(0, &(MUX_423), &(slice_422));\
}bit_vector_cast_to_bit_vector(0, &(MUX_425), &(MUX_423));\
}else {bit_vector_cast_to_bit_vector(0, &(MUX_425), &(active_packet_length));\
}bit_vector_cast_to_bit_vector(0, &(next_active_packet_length), &(MUX_425));\
;

#define _outputPort_1_Daemon_assign_stmt_439_c_macro_ __declare_static_bit_vector(konst_430,8);\
bit_vector_clear(&konst_430);\
konst_430.val.byte_array[0] = 1;\
__declare_static_bit_vector(SUB_u8_u8_431,8);\
__declare_static_bit_vector(konst_434,8);\
bit_vector_clear(&konst_434);\
konst_434.val.byte_array[0] = 1;\
__declare_static_bit_vector(SUB_u8_u8_435,8);\
__declare_static_bit_vector(MUX_437,8);\
__declare_static_bit_vector(MUX_438,8);\
if (has_undefined_bit(&started_new_packet)) {fprintf(stderr, "Error: variable started_new_packet has undefined value (%s) at test point.\n", to_string(&started_new_packet));assert(0);} \
if(bit_vector_to_uint64(0, &started_new_packet)){bit_vector_clear(&konst_430);\
konst_430.val.byte_array[0] = 1;\
bit_vector_minus( &(next_active_packet_length), &(konst_430), &(SUB_u8_u8_431));\
bit_vector_cast_to_bit_vector(0, &(MUX_438), &(SUB_u8_u8_431));\
}else {if (has_undefined_bit(&valid_active_pkt_word_read)) {fprintf(stderr, "Error: variable valid_active_pkt_word_read has undefined value (%s) at test point.\n", to_string(&valid_active_pkt_word_read));assert(0);} \
if(bit_vector_to_uint64(0, &valid_active_pkt_word_read)){bit_vector_clear(&konst_434);\
konst_434.val.byte_array[0] = 1;\
bit_vector_minus( &(down_counter), &(konst_434), &(SUB_u8_u8_435));\
bit_vector_cast_to_bit_vector(0, &(MUX_437), &(SUB_u8_u8_435));\
}else {bit_vector_cast_to_bit_vector(0, &(MUX_437), &(down_counter));\
}bit_vector_cast_to_bit_vector(0, &(MUX_438), &(MUX_437));\
}bit_vector_cast_to_bit_vector(0, &(next_down_counter), &(MUX_438));\
;

#define _outputPort_1_Daemon_assign_stmt_447_c_macro_ __declare_static_bit_vector(NOT_u1_u1_442,1);\
__declare_static_bit_vector(konst_444,2);\
bit_vector_clear(&konst_444);\
konst_444.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u2_u1_445,1);\
__declare_static_bit_vector(OR_u1_u1_446,1);\
bit_vector_not( &(p1_valid), &(NOT_u1_u1_442));\
bit_vector_clear(&konst_444);\
konst_444.val.byte_array[0] = 1;\
bit_vector_equal(0, &(next_active_packet), &(konst_444), &(EQ_u2_u1_445));\
bit_vector_or(&(NOT_u1_u1_442), &(EQ_u2_u1_445), &(OR_u1_u1_446));\
bit_vector_cast_to_bit_vector(0, &(read_from_1), &(OR_u1_u1_446));\
;

#define _outputPort_1_Daemon_assign_stmt_455_c_macro_ __declare_static_bit_vector(NOT_u1_u1_450,1);\
__declare_static_bit_vector(konst_452,2);\
bit_vector_clear(&konst_452);\
konst_452.val.byte_array[0] = 2;\
__declare_static_bit_vector(EQ_u2_u1_453,1);\
__declare_static_bit_vector(OR_u1_u1_454,1);\
bit_vector_not( &(p2_valid), &(NOT_u1_u1_450));\
bit_vector_clear(&konst_452);\
konst_452.val.byte_array[0] = 2;\
bit_vector_equal(0, &(next_active_packet), &(konst_452), &(EQ_u2_u1_453));\
bit_vector_or(&(NOT_u1_u1_450), &(EQ_u2_u1_453), &(OR_u1_u1_454));\
bit_vector_cast_to_bit_vector(0, &(read_from_2), &(OR_u1_u1_454));\
;

#define _outputPort_1_Daemon_assign_stmt_465_c_macro_ __declare_static_bit_vector(konst_458,2);\
bit_vector_clear(&konst_458);\
konst_458.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u2_u1_459,1);\
__declare_static_bit_vector(slice_461,32);\
__declare_static_bit_vector(slice_463,32);\
__declare_static_bit_vector(MUX_464,32);\
bit_vector_clear(&konst_458);\
konst_458.val.byte_array[0] = 1;\
bit_vector_equal(0, &(next_active_packet), &(konst_458), &(EQ_u2_u1_459));\
if (has_undefined_bit(&EQ_u2_u1_459)) {fprintf(stderr, "Error: variable EQ_u2_u1_459 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_459));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_459)){bit_vector_slice(&(pkt_1_e_word), &(slice_461), 0);\
bit_vector_cast_to_bit_vector(0, &(MUX_464), &(slice_461));\
}else {bit_vector_slice(&(pkt_2_e_word), &(slice_463), 0);\
bit_vector_cast_to_bit_vector(0, &(MUX_464), &(slice_463));\
}bit_vector_cast_to_bit_vector(0, &(data_to_out), &(MUX_464));\
;

#define _outputPort_1_Daemon_assign_stmt_480_c_macro_ __declare_static_bit_vector(konst_468,2);\
bit_vector_clear(&konst_468);\
konst_468.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u2_u1_469,1);\
__declare_static_bit_vector(konst_471,1);\
bit_vector_clear(&konst_471);\
__declare_static_bit_vector(MUX_472,1);\
__declare_static_bit_vector(konst_474,2);\
bit_vector_clear(&konst_474);\
konst_474.val.byte_array[0] = 2;\
__declare_static_bit_vector(EQ_u2_u1_475,1);\
__declare_static_bit_vector(konst_477,1);\
bit_vector_clear(&konst_477);\
__declare_static_bit_vector(MUX_478,1);\
__declare_static_bit_vector(OR_u1_u1_479,1);\
bit_vector_clear(&konst_468);\
konst_468.val.byte_array[0] = 1;\
bit_vector_equal(0, &(next_active_packet), &(konst_468), &(EQ_u2_u1_469));\
if (has_undefined_bit(&EQ_u2_u1_469)) {fprintf(stderr, "Error: variable EQ_u2_u1_469 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_469));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_469)){bit_vector_cast_to_bit_vector(0, &(MUX_472), &(p1_valid));\
}else {bit_vector_clear(&konst_471);\
bit_vector_cast_to_bit_vector(0, &(MUX_472), &(konst_471));\
}bit_vector_clear(&konst_474);\
konst_474.val.byte_array[0] = 2;\
bit_vector_equal(0, &(next_active_packet), &(konst_474), &(EQ_u2_u1_475));\
if (has_undefined_bit(&EQ_u2_u1_475)) {fprintf(stderr, "Error: variable EQ_u2_u1_475 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_475));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_475)){bit_vector_cast_to_bit_vector(0, &(MUX_478), &(p2_valid));\
}else {bit_vector_clear(&konst_477);\
bit_vector_cast_to_bit_vector(0, &(MUX_478), &(konst_477));\
}bit_vector_or(&(MUX_472), &(MUX_478), &(OR_u1_u1_479));\
bit_vector_cast_to_bit_vector(0, &(send_flag), &(OR_u1_u1_479));\
;

#define _outputPort_1_Daemon_assign_stmt_484_c_macro_ if (has_undefined_bit(&send_flag)) {fprintf(stderr, "Error: variable send_flag has undefined value (%s) at test point.\n", to_string(&send_flag));assert(0);} \
if (bit_vector_to_uint64(0, &send_flag)) {\
write_bit_vector_to_pipe("out_data_1",&(data_to_out));\
}
;

#define _outputPort_1_Daemon_stmt_491_c_macro_ uint32_t _outputPort_1_Daemon_stmt_491_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t%s\n",_outputPort_1_Daemon_stmt_491_c_macro___print_counter,"send_information");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_491_c_macro___print_counter,"started_new_packet");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(started_new_packet)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_491_c_macro___print_counter,"next_active_packet");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(next_active_packet)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_491_c_macro___print_counter,"send_flag");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(send_flag)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_491_c_macro___print_counter,"p1_valid");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(p1_valid)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_491_c_macro___print_counter,"p2_valid");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(p2_valid)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_1_Daemon>\t\t%s\t\t",_outputPort_1_Daemon_stmt_491_c_macro___print_counter,"data_to_out");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(data_to_out)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);;
;

#define _outputPort_1_Daemon_branch_block_stmt_334_c_export_apply_macro_ ;

#define _outputPort_1_Daemon_inner_outarg_prep_macro__ ;

#define _outputPort_1_Daemon_outer_arg_decl_macro__ ;

#define _outputPort_1_Daemon_outer_op_xfer_macro__ ;

#define _outputPort_2_Daemon_inner_inarg_prep_macro__ 
#define _outputPort_2_Daemon_branch_block_stmt_497_c_export_decl_macro_ __declare_static_bit_vector(down_counter,8);\
__declare_static_bit_vector(pkt_1_e_word,33);\
__declare_static_bit_vector(pkt_2_e_word,33);\
__declare_static_bit_vector(active_packet,2);\
__declare_static_bit_vector(active_packet_length,8);\
__declare_static_bit_vector(pkt_1_has_priority,1);\
__declare_static_bit_vector(p1_valid,1);\
__declare_static_bit_vector(p2_valid,1);\
__declare_static_bit_vector(valid_active_pkt_word_read,1);\
__declare_static_bit_vector(next_active_packet,2);\
__declare_static_bit_vector(next_pkt_1_has_priority,1);\
__declare_static_bit_vector(started_new_packet,1);\
__declare_static_bit_vector(next_active_packet_length,8);\
__declare_static_bit_vector(next_down_counter,8);\
__declare_static_bit_vector(read_from_1,1);\
__declare_static_bit_vector(read_from_2,1);\
__declare_static_bit_vector(data_to_out,32);\
__declare_static_bit_vector(send_flag,1);\


#define _outputPort_2_Daemon_merge_stmt_499_c_preamble_macro_ uint8_t merge_stmt_499_entry_flag;\
merge_stmt_499_entry_flag = do_while_entry_flag;\
goto merge_stmt_499_run;\
merge_stmt_499_run: ;\

#define _outputPort_2_Daemon_phi_stmt_500_c_macro_ if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(down_counter), &(next_down_counter));\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(down_counter), &(ZERO_8));\
}\
;

#define _outputPort_2_Daemon_phi_stmt_504_c_macro_ __declare_static_bit_vector(RPIPE_noblock_obuf_1_2_508,33);\
if(do_while_loopback_flag) {\
if(bit_vector_to_uint64(0, &read_from_1)) {\
read_bit_vector_from_pipe("noblock_obuf_1_2",&(RPIPE_noblock_obuf_1_2_508));\
bit_vector_cast_to_bit_vector(0, &(pkt_1_e_word), &(RPIPE_noblock_obuf_1_2_508));\
}\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(pkt_1_e_word), &(ZERO_33));\
}\
;

#define _outputPort_2_Daemon_phi_stmt_509_c_macro_ __declare_static_bit_vector(RPIPE_noblock_obuf_2_2_513,33);\
if(do_while_loopback_flag) {\
if(bit_vector_to_uint64(0, &read_from_2)) {\
read_bit_vector_from_pipe("noblock_obuf_2_2",&(RPIPE_noblock_obuf_2_2_513));\
bit_vector_cast_to_bit_vector(0, &(pkt_2_e_word), &(RPIPE_noblock_obuf_2_2_513));\
}\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(pkt_2_e_word), &(ZERO_33));\
}\
;

#define _outputPort_2_Daemon_phi_stmt_514_c_macro_ if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(active_packet), &(next_active_packet));\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(active_packet), &(ZERO_2));\
}\
;

#define _outputPort_2_Daemon_phi_stmt_518_c_macro_ if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(active_packet_length), &(next_active_packet_length));\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(active_packet_length), &(ZERO_8));\
}\
;

#define _outputPort_2_Daemon_phi_stmt_522_c_macro_ if(do_while_loopback_flag) {\
bit_vector_cast_to_bit_vector(0, &(pkt_1_has_priority), &(next_pkt_1_has_priority));\
}\
else {\
bit_vector_cast_to_bit_vector(0, &(pkt_1_has_priority), &(ZERO_1));\
}\
;
;

#define _outputPort_2_Daemon_merge_stmt_499_c_postamble_macro_ merge_stmt_499_entry_flag = 0;

#define _outputPort_2_Daemon_assign_stmt_531_c_macro_ __declare_static_bit_vector(konst_529,33);\
bit_vector_clear(&konst_529);\
konst_529.val.byte_array[0] = 32;\
__declare_static_bit_vector(BITSEL_u33_u1_530,1);\
bit_vector_clear(&konst_529);\
konst_529.val.byte_array[0] = 32;\
bit_vector_bitsel( &(pkt_1_e_word), &(konst_529), &(BITSEL_u33_u1_530));\
bit_vector_cast_to_bit_vector(0, &(p1_valid), &(BITSEL_u33_u1_530));\
;

#define _outputPort_2_Daemon_assign_stmt_536_c_macro_ __declare_static_bit_vector(konst_534,33);\
bit_vector_clear(&konst_534);\
konst_534.val.byte_array[0] = 32;\
__declare_static_bit_vector(BITSEL_u33_u1_535,1);\
bit_vector_clear(&konst_534);\
konst_534.val.byte_array[0] = 32;\
bit_vector_bitsel( &(pkt_2_e_word), &(konst_534), &(BITSEL_u33_u1_535));\
bit_vector_cast_to_bit_vector(0, &(p2_valid), &(BITSEL_u33_u1_535));\
;

#define _outputPort_2_Daemon_stmt_544_c_macro_ uint32_t _outputPort_2_Daemon_stmt_544_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t%s\n",_outputPort_2_Daemon_stmt_544_c_macro___print_counter,"state_summary");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_544_c_macro___print_counter,"active_packet");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(active_packet)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_544_c_macro___print_counter,"down_counter");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(down_counter)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_544_c_macro___print_counter,"pkt_1_has_priority");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(pkt_1_has_priority)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_544_c_macro___print_counter,"read_from_1");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(read_from_1)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_544_c_macro___print_counter,"pkt_1_e_word");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(pkt_1_e_word)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_544_c_macro___print_counter,"read_from_2");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(read_from_2)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_544_c_macro___print_counter,"pkt_2_e_word");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(pkt_2_e_word)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);;

#define _outputPort_2_Daemon_assign_stmt_559_c_macro_ __declare_static_bit_vector(konst_547,2);\
bit_vector_clear(&konst_547);\
konst_547.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u2_u1_548,1);\
__declare_static_bit_vector(konst_550,1);\
bit_vector_clear(&konst_550);\
__declare_static_bit_vector(MUX_551,1);\
__declare_static_bit_vector(konst_553,2);\
bit_vector_clear(&konst_553);\
konst_553.val.byte_array[0] = 2;\
__declare_static_bit_vector(EQ_u2_u1_554,1);\
__declare_static_bit_vector(konst_556,1);\
bit_vector_clear(&konst_556);\
__declare_static_bit_vector(MUX_557,1);\
__declare_static_bit_vector(OR_u1_u1_558,1);\
bit_vector_clear(&konst_547);\
konst_547.val.byte_array[0] = 1;\
bit_vector_equal(0, &(active_packet), &(konst_547), &(EQ_u2_u1_548));\
if (has_undefined_bit(&EQ_u2_u1_548)) {fprintf(stderr, "Error: variable EQ_u2_u1_548 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_548));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_548)){bit_vector_cast_to_bit_vector(0, &(MUX_551), &(p1_valid));\
}else {bit_vector_clear(&konst_550);\
bit_vector_cast_to_bit_vector(0, &(MUX_551), &(konst_550));\
}bit_vector_clear(&konst_553);\
konst_553.val.byte_array[0] = 2;\
bit_vector_equal(0, &(active_packet), &(konst_553), &(EQ_u2_u1_554));\
if (has_undefined_bit(&EQ_u2_u1_554)) {fprintf(stderr, "Error: variable EQ_u2_u1_554 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_554));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_554)){bit_vector_cast_to_bit_vector(0, &(MUX_557), &(p2_valid));\
}else {bit_vector_clear(&konst_556);\
bit_vector_cast_to_bit_vector(0, &(MUX_557), &(konst_556));\
}bit_vector_or(&(MUX_551), &(MUX_557), &(OR_u1_u1_558));\
bit_vector_cast_to_bit_vector(0, &(valid_active_pkt_word_read), &(OR_u1_u1_558));\
;

#define _outputPort_2_Daemon_call_stmt_567_c_macro_ _prioritySelect_( &(down_counter),  &(active_packet),  &(pkt_1_has_priority),  &(p1_valid),  &(p2_valid), &(next_active_packet), &(next_pkt_1_has_priority));\
;

#define _outputPort_2_Daemon_assign_stmt_576_c_macro_ __declare_static_bit_vector(konst_570,2);\
bit_vector_clear(&konst_570);\
__declare_static_bit_vector(NEQ_u2_u1_571,1);\
__declare_static_bit_vector(konst_573,8);\
bit_vector_clear(&konst_573);\
__declare_static_bit_vector(EQ_u8_u1_574,1);\
__declare_static_bit_vector(AND_u1_u1_575,1);\
bit_vector_clear(&konst_570);\
bit_vector_not_equal(0, &(next_active_packet), &(konst_570), &NEQ_u2_u1_571);\
bit_vector_clear(&konst_573);\
bit_vector_equal(0, &(down_counter), &(konst_573), &(EQ_u8_u1_574));\
bit_vector_and(&(NEQ_u2_u1_571), &(EQ_u8_u1_574), &(AND_u1_u1_575));\
bit_vector_cast_to_bit_vector(0, &(started_new_packet), &(AND_u1_u1_575));\
;

#define _outputPort_2_Daemon_assign_stmt_589_c_macro_ __declare_static_bit_vector(konst_580,2);\
bit_vector_clear(&konst_580);\
konst_580.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u2_u1_581,1);\
__declare_static_bit_vector(slice_583,8);\
__declare_static_bit_vector(slice_585,8);\
__declare_static_bit_vector(MUX_586,8);\
__declare_static_bit_vector(MUX_588,8);\
if (has_undefined_bit(&started_new_packet)) {fprintf(stderr, "Error: variable started_new_packet has undefined value (%s) at test point.\n", to_string(&started_new_packet));assert(0);} \
if(bit_vector_to_uint64(0, &started_new_packet)){bit_vector_clear(&konst_580);\
konst_580.val.byte_array[0] = 1;\
bit_vector_equal(0, &(next_active_packet), &(konst_580), &(EQ_u2_u1_581));\
if (has_undefined_bit(&EQ_u2_u1_581)) {fprintf(stderr, "Error: variable EQ_u2_u1_581 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_581));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_581)){bit_vector_slice(&(pkt_1_e_word), &(slice_583), 8);\
bit_vector_cast_to_bit_vector(0, &(MUX_586), &(slice_583));\
}else {bit_vector_slice(&(pkt_2_e_word), &(slice_585), 8);\
bit_vector_cast_to_bit_vector(0, &(MUX_586), &(slice_585));\
}bit_vector_cast_to_bit_vector(0, &(MUX_588), &(MUX_586));\
}else {bit_vector_cast_to_bit_vector(0, &(MUX_588), &(active_packet_length));\
}bit_vector_cast_to_bit_vector(0, &(next_active_packet_length), &(MUX_588));\
;

#define _outputPort_2_Daemon_assign_stmt_602_c_macro_ __declare_static_bit_vector(konst_593,8);\
bit_vector_clear(&konst_593);\
konst_593.val.byte_array[0] = 1;\
__declare_static_bit_vector(SUB_u8_u8_594,8);\
__declare_static_bit_vector(konst_597,8);\
bit_vector_clear(&konst_597);\
konst_597.val.byte_array[0] = 1;\
__declare_static_bit_vector(SUB_u8_u8_598,8);\
__declare_static_bit_vector(MUX_600,8);\
__declare_static_bit_vector(MUX_601,8);\
if (has_undefined_bit(&started_new_packet)) {fprintf(stderr, "Error: variable started_new_packet has undefined value (%s) at test point.\n", to_string(&started_new_packet));assert(0);} \
if(bit_vector_to_uint64(0, &started_new_packet)){bit_vector_clear(&konst_593);\
konst_593.val.byte_array[0] = 1;\
bit_vector_minus( &(next_active_packet_length), &(konst_593), &(SUB_u8_u8_594));\
bit_vector_cast_to_bit_vector(0, &(MUX_601), &(SUB_u8_u8_594));\
}else {if (has_undefined_bit(&valid_active_pkt_word_read)) {fprintf(stderr, "Error: variable valid_active_pkt_word_read has undefined value (%s) at test point.\n", to_string(&valid_active_pkt_word_read));assert(0);} \
if(bit_vector_to_uint64(0, &valid_active_pkt_word_read)){bit_vector_clear(&konst_597);\
konst_597.val.byte_array[0] = 1;\
bit_vector_minus( &(down_counter), &(konst_597), &(SUB_u8_u8_598));\
bit_vector_cast_to_bit_vector(0, &(MUX_600), &(SUB_u8_u8_598));\
}else {bit_vector_cast_to_bit_vector(0, &(MUX_600), &(down_counter));\
}bit_vector_cast_to_bit_vector(0, &(MUX_601), &(MUX_600));\
}bit_vector_cast_to_bit_vector(0, &(next_down_counter), &(MUX_601));\
;

#define _outputPort_2_Daemon_assign_stmt_610_c_macro_ __declare_static_bit_vector(NOT_u1_u1_605,1);\
__declare_static_bit_vector(konst_607,2);\
bit_vector_clear(&konst_607);\
konst_607.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u2_u1_608,1);\
__declare_static_bit_vector(OR_u1_u1_609,1);\
bit_vector_not( &(p1_valid), &(NOT_u1_u1_605));\
bit_vector_clear(&konst_607);\
konst_607.val.byte_array[0] = 1;\
bit_vector_equal(0, &(next_active_packet), &(konst_607), &(EQ_u2_u1_608));\
bit_vector_or(&(NOT_u1_u1_605), &(EQ_u2_u1_608), &(OR_u1_u1_609));\
bit_vector_cast_to_bit_vector(0, &(read_from_1), &(OR_u1_u1_609));\
;

#define _outputPort_2_Daemon_assign_stmt_618_c_macro_ __declare_static_bit_vector(NOT_u1_u1_613,1);\
__declare_static_bit_vector(konst_615,2);\
bit_vector_clear(&konst_615);\
konst_615.val.byte_array[0] = 2;\
__declare_static_bit_vector(EQ_u2_u1_616,1);\
__declare_static_bit_vector(OR_u1_u1_617,1);\
bit_vector_not( &(p2_valid), &(NOT_u1_u1_613));\
bit_vector_clear(&konst_615);\
konst_615.val.byte_array[0] = 2;\
bit_vector_equal(0, &(next_active_packet), &(konst_615), &(EQ_u2_u1_616));\
bit_vector_or(&(NOT_u1_u1_613), &(EQ_u2_u1_616), &(OR_u1_u1_617));\
bit_vector_cast_to_bit_vector(0, &(read_from_2), &(OR_u1_u1_617));\
;

#define _outputPort_2_Daemon_assign_stmt_628_c_macro_ __declare_static_bit_vector(konst_621,2);\
bit_vector_clear(&konst_621);\
konst_621.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u2_u1_622,1);\
__declare_static_bit_vector(slice_624,32);\
__declare_static_bit_vector(slice_626,32);\
__declare_static_bit_vector(MUX_627,32);\
bit_vector_clear(&konst_621);\
konst_621.val.byte_array[0] = 1;\
bit_vector_equal(0, &(next_active_packet), &(konst_621), &(EQ_u2_u1_622));\
if (has_undefined_bit(&EQ_u2_u1_622)) {fprintf(stderr, "Error: variable EQ_u2_u1_622 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_622));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_622)){bit_vector_slice(&(pkt_1_e_word), &(slice_624), 0);\
bit_vector_cast_to_bit_vector(0, &(MUX_627), &(slice_624));\
}else {bit_vector_slice(&(pkt_2_e_word), &(slice_626), 0);\
bit_vector_cast_to_bit_vector(0, &(MUX_627), &(slice_626));\
}bit_vector_cast_to_bit_vector(0, &(data_to_out), &(MUX_627));\
;

#define _outputPort_2_Daemon_assign_stmt_643_c_macro_ __declare_static_bit_vector(konst_631,2);\
bit_vector_clear(&konst_631);\
konst_631.val.byte_array[0] = 1;\
__declare_static_bit_vector(EQ_u2_u1_632,1);\
__declare_static_bit_vector(konst_634,1);\
bit_vector_clear(&konst_634);\
__declare_static_bit_vector(MUX_635,1);\
__declare_static_bit_vector(konst_637,2);\
bit_vector_clear(&konst_637);\
konst_637.val.byte_array[0] = 2;\
__declare_static_bit_vector(EQ_u2_u1_638,1);\
__declare_static_bit_vector(konst_640,1);\
bit_vector_clear(&konst_640);\
__declare_static_bit_vector(MUX_641,1);\
__declare_static_bit_vector(OR_u1_u1_642,1);\
bit_vector_clear(&konst_631);\
konst_631.val.byte_array[0] = 1;\
bit_vector_equal(0, &(next_active_packet), &(konst_631), &(EQ_u2_u1_632));\
if (has_undefined_bit(&EQ_u2_u1_632)) {fprintf(stderr, "Error: variable EQ_u2_u1_632 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_632));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_632)){bit_vector_cast_to_bit_vector(0, &(MUX_635), &(p1_valid));\
}else {bit_vector_clear(&konst_634);\
bit_vector_cast_to_bit_vector(0, &(MUX_635), &(konst_634));\
}bit_vector_clear(&konst_637);\
konst_637.val.byte_array[0] = 2;\
bit_vector_equal(0, &(next_active_packet), &(konst_637), &(EQ_u2_u1_638));\
if (has_undefined_bit(&EQ_u2_u1_638)) {fprintf(stderr, "Error: variable EQ_u2_u1_638 has undefined value (%s) at test point.\n", to_string(&EQ_u2_u1_638));assert(0);} \
if(bit_vector_to_uint64(0, &EQ_u2_u1_638)){bit_vector_cast_to_bit_vector(0, &(MUX_641), &(p2_valid));\
}else {bit_vector_clear(&konst_640);\
bit_vector_cast_to_bit_vector(0, &(MUX_641), &(konst_640));\
}bit_vector_or(&(MUX_635), &(MUX_641), &(OR_u1_u1_642));\
bit_vector_cast_to_bit_vector(0, &(send_flag), &(OR_u1_u1_642));\
;

#define _outputPort_2_Daemon_assign_stmt_647_c_macro_ if (has_undefined_bit(&send_flag)) {fprintf(stderr, "Error: variable send_flag has undefined value (%s) at test point.\n", to_string(&send_flag));assert(0);} \
if (bit_vector_to_uint64(0, &send_flag)) {\
write_bit_vector_to_pipe("out_data_2",&(data_to_out));\
}
;

#define _outputPort_2_Daemon_stmt_654_c_macro_ uint32_t _outputPort_2_Daemon_stmt_654_c_macro___print_counter= get_file_print_lock(__report_log_file__);if(__report_log_file__ != NULL) fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t%s\n",_outputPort_2_Daemon_stmt_654_c_macro___print_counter,"send_information");if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_654_c_macro___print_counter,"started_new_packet");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(started_new_packet)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_654_c_macro___print_counter,"next_active_packet");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(next_active_packet)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_654_c_macro___print_counter,"send_flag");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(send_flag)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_654_c_macro___print_counter,"p1_valid");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(p1_valid)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_654_c_macro___print_counter,"p2_valid");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(p2_valid)));fflush (__report_log_file__);}if(__report_log_file__ != NULL) {fprintf(__report_log_file__,"[%u]outputPort_2_Daemon>\t\t%s\t\t",_outputPort_2_Daemon_stmt_654_c_macro___print_counter,"data_to_out");fprintf(__report_log_file__, ":= 0x%s\n",to_hex_string(&(data_to_out)));fflush (__report_log_file__);}release_file_print_lock(__report_log_file__);;
;

#define _outputPort_2_Daemon_branch_block_stmt_497_c_export_apply_macro_ ;

#define _outputPort_2_Daemon_inner_outarg_prep_macro__ ;

#define _outputPort_2_Daemon_outer_arg_decl_macro__ ;

#define _outputPort_2_Daemon_outer_op_xfer_macro__ ;

#define _prioritySelect_inner_inarg_prep_macro__ __declare_static_bit_vector(down_counter,8);\
bit_vector_cast_to_bit_vector(0, &(down_counter), &((*__pdown_counter)));\
__declare_static_bit_vector(active_packet,2);\
bit_vector_cast_to_bit_vector(0, &(active_packet), &((*__pactive_packet)));\
__declare_static_bit_vector(pkt_1_has_priority,1);\
bit_vector_cast_to_bit_vector(0, &(pkt_1_has_priority), &((*__ppkt_1_has_priority)));\
__declare_static_bit_vector(p1_valid,1);\
bit_vector_cast_to_bit_vector(0, &(p1_valid), &((*__pp1_valid)));\
__declare_static_bit_vector(p2_valid,1);\
bit_vector_cast_to_bit_vector(0, &(p2_valid), &((*__pp2_valid)));\
__declare_static_bit_vector(next_active_packet,2);\
__declare_static_bit_vector(next_pkt_1_has_priority,1);\
__declare_static_bit_vector(d0,1);\
__declare_static_bit_vector(select_1,1);\
__declare_static_bit_vector(select_2,1);\

#define _prioritySelect_assign_stmt_284_c_macro_ __declare_static_bit_vector(konst_282,8);\
bit_vector_clear(&konst_282);\
__declare_static_bit_vector(EQ_u8_u1_283,1);\
bit_vector_clear(&konst_282);\
bit_vector_equal(0, &(down_counter), &(konst_282), &(EQ_u8_u1_283));\
bit_vector_cast_to_bit_vector(0, &(d0), &(EQ_u8_u1_283));\
;

#define _prioritySelect_assign_stmt_294_c_macro_ __declare_static_bit_vector(AND_u1_u1_288,1);\
__declare_static_bit_vector(NOT_u1_u1_291,1);\
__declare_static_bit_vector(OR_u1_u1_292,1);\
__declare_static_bit_vector(AND_u1_u1_293,1);\
bit_vector_and(&(d0), &(p1_valid), &(AND_u1_u1_288));\
bit_vector_not( &(p2_valid), &(NOT_u1_u1_291));\
bit_vector_or(&(pkt_1_has_priority), &(NOT_u1_u1_291), &(OR_u1_u1_292));\
bit_vector_and(&(AND_u1_u1_288), &(OR_u1_u1_292), &(AND_u1_u1_293));\
bit_vector_cast_to_bit_vector(0, &(select_1), &(AND_u1_u1_293));\
;

#define _prioritySelect_assign_stmt_305_c_macro_ __declare_static_bit_vector(AND_u1_u1_298,1);\
__declare_static_bit_vector(NOT_u1_u1_300,1);\
__declare_static_bit_vector(NOT_u1_u1_302,1);\
__declare_static_bit_vector(OR_u1_u1_303,1);\
__declare_static_bit_vector(AND_u1_u1_304,1);\
bit_vector_and(&(d0), &(p2_valid), &(AND_u1_u1_298));\
bit_vector_not( &(pkt_1_has_priority), &(NOT_u1_u1_300));\
bit_vector_not( &(p1_valid), &(NOT_u1_u1_302));\
bit_vector_or(&(NOT_u1_u1_300), &(NOT_u1_u1_302), &(OR_u1_u1_303));\
bit_vector_and(&(AND_u1_u1_298), &(OR_u1_u1_303), &(AND_u1_u1_304));\
bit_vector_cast_to_bit_vector(0, &(select_2), &(AND_u1_u1_304));\
;

#define _prioritySelect_assign_stmt_322_c_macro_ __declare_static_bit_vector(NOT_u1_u1_308,1);\
__declare_static_bit_vector(konst_310,2);\
bit_vector_clear(&konst_310);\
__declare_static_bit_vector(MUX_311,2);\
__declare_static_bit_vector(konst_313,2);\
bit_vector_clear(&konst_313);\
konst_313.val.byte_array[0] = 1;\
__declare_static_bit_vector(konst_314,2);\
bit_vector_clear(&konst_314);\
__declare_static_bit_vector(MUX_315,2);\
__declare_static_bit_vector(OR_u2_u2_316,2);\
__declare_static_bit_vector(konst_318,2);\
bit_vector_clear(&konst_318);\
konst_318.val.byte_array[0] = 2;\
__declare_static_bit_vector(konst_319,2);\
bit_vector_clear(&konst_319);\
__declare_static_bit_vector(MUX_320,2);\
__declare_static_bit_vector(OR_u2_u2_321,2);\
bit_vector_not( &(d0), &(NOT_u1_u1_308));\
if (has_undefined_bit(&NOT_u1_u1_308)) {fprintf(stderr, "Error: variable NOT_u1_u1_308 has undefined value (%s) at test point.\n", to_string(&NOT_u1_u1_308));assert(0);} \
if(bit_vector_to_uint64(0, &NOT_u1_u1_308)){bit_vector_cast_to_bit_vector(0, &(MUX_311), &(active_packet));\
}else {bit_vector_clear(&konst_310);\
bit_vector_cast_to_bit_vector(0, &(MUX_311), &(konst_310));\
}if (has_undefined_bit(&select_1)) {fprintf(stderr, "Error: variable select_1 has undefined value (%s) at test point.\n", to_string(&select_1));assert(0);} \
if(bit_vector_to_uint64(0, &select_1)){bit_vector_clear(&konst_313);\
konst_313.val.byte_array[0] = 1;\
bit_vector_cast_to_bit_vector(0, &(MUX_315), &(konst_313));\
}else {bit_vector_clear(&konst_314);\
bit_vector_cast_to_bit_vector(0, &(MUX_315), &(konst_314));\
}bit_vector_or(&(MUX_311), &(MUX_315), &(OR_u2_u2_316));\
if (has_undefined_bit(&select_2)) {fprintf(stderr, "Error: variable select_2 has undefined value (%s) at test point.\n", to_string(&select_2));assert(0);} \
if(bit_vector_to_uint64(0, &select_2)){bit_vector_clear(&konst_318);\
konst_318.val.byte_array[0] = 2;\
bit_vector_cast_to_bit_vector(0, &(MUX_320), &(konst_318));\
}else {bit_vector_clear(&konst_319);\
bit_vector_cast_to_bit_vector(0, &(MUX_320), &(konst_319));\
}bit_vector_or(&(OR_u2_u2_316), &(MUX_320), &(OR_u2_u2_321));\
bit_vector_cast_to_bit_vector(0, &(next_active_packet), &(OR_u2_u2_321));\
;

#define _prioritySelect_assign_stmt_331_c_macro_ __declare_static_bit_vector(OR_u1_u1_326,1);\
__declare_static_bit_vector(NOT_u1_u1_328,1);\
__declare_static_bit_vector(MUX_330,1);\
bit_vector_or(&(select_1), &(select_2), &(OR_u1_u1_326));\
if (has_undefined_bit(&OR_u1_u1_326)) {fprintf(stderr, "Error: variable OR_u1_u1_326 has undefined value (%s) at test point.\n", to_string(&OR_u1_u1_326));assert(0);} \
if(bit_vector_to_uint64(0, &OR_u1_u1_326)){bit_vector_not( &(pkt_1_has_priority), &(NOT_u1_u1_328));\
bit_vector_cast_to_bit_vector(0, &(MUX_330), &(NOT_u1_u1_328));\
}else {bit_vector_cast_to_bit_vector(0, &(MUX_330), &(pkt_1_has_priority));\
}bit_vector_cast_to_bit_vector(0, &(next_pkt_1_has_priority), &(MUX_330));\
;

#define _prioritySelect_inner_outarg_prep_macro__ bit_vector_cast_to_bit_vector(0, &((*__pnext_active_packet)), &(next_active_packet));\
bit_vector_cast_to_bit_vector(0, &((*__pnext_pkt_1_has_priority)), &(next_pkt_1_has_priority));\
;
