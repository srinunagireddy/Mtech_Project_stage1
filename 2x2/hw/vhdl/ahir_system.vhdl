-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.ahir_system_global_package.all;
entity converter_1_Daemon is -- 
  generic (tag_length : integer); 
  port ( -- 
    in_data_1_64_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_1_64_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_1_64_pipe_read_data : in   std_logic_vector(63 downto 0);
    in_data_1_pipe_write_req : out  std_logic_vector(0 downto 0);
    in_data_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
    in_data_1_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) ;
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic-- 
  );
  -- 
end entity converter_1_Daemon;
architecture converter_1_Daemon_arch of converter_1_Daemon is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal converter_1_Daemon_CP_0_start: Boolean;
  signal converter_1_Daemon_CP_0_symbol: Boolean;
  -- volatile/operator module components. 
  -- links between control-path and data-path
  signal do_while_stmt_42_branch_req_0 : boolean;
  signal RPIPE_in_data_1_64_46_inst_req_0 : boolean;
  signal RPIPE_in_data_1_64_46_inst_ack_0 : boolean;
  signal RPIPE_in_data_1_64_46_inst_req_1 : boolean;
  signal RPIPE_in_data_1_64_46_inst_ack_1 : boolean;
  signal WPIPE_in_data_1_55_inst_req_0 : boolean;
  signal WPIPE_in_data_1_55_inst_ack_0 : boolean;
  signal WPIPE_in_data_1_55_inst_req_1 : boolean;
  signal WPIPE_in_data_1_55_inst_ack_1 : boolean;
  signal do_while_stmt_42_branch_ack_0 : boolean;
  signal do_while_stmt_42_branch_ack_1 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "converter_1_Daemon_input_buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj_in_buffer_unload_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  converter_1_Daemon_CP_0_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "converter_1_Daemon_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 0) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= converter_1_Daemon_CP_0_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj_out_buffer_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= converter_1_Daemon_CP_0_start & tag_ilock_write_ack_symbol;
    gj_tag_ilock_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= converter_1_Daemon_CP_0_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  converter_1_Daemon_CP_0: Block -- control-path 
    signal converter_1_Daemon_CP_0_elements: BooleanArray(25 downto 0);
    -- 
  begin -- 
    converter_1_Daemon_CP_0_elements(0) <= converter_1_Daemon_CP_0_start;
    converter_1_Daemon_CP_0_symbol <= converter_1_Daemon_CP_0_elements(1);
    -- CP-element group 0:  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	2 
    -- CP-element group 0:  members (4) 
      -- CP-element group 0: 	 $entry
      -- CP-element group 0: 	 branch_block_stmt_41/$entry
      -- CP-element group 0: 	 branch_block_stmt_41/branch_block_stmt_41__entry__
      -- CP-element group 0: 	 branch_block_stmt_41/do_while_stmt_42__entry__
      -- 
    -- CP-element group 1:  transition  place  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	25 
    -- CP-element group 1: successors 
    -- CP-element group 1:  members (4) 
      -- CP-element group 1: 	 $exit
      -- CP-element group 1: 	 branch_block_stmt_41/$exit
      -- CP-element group 1: 	 branch_block_stmt_41/branch_block_stmt_41__exit__
      -- CP-element group 1: 	 branch_block_stmt_41/do_while_stmt_42__exit__
      -- 
    converter_1_Daemon_CP_0_elements(1) <= converter_1_Daemon_CP_0_elements(25);
    -- CP-element group 2:  transition  place  bypass  pipeline-parent 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	0 
    -- CP-element group 2: successors 
    -- CP-element group 2: 	8 
    -- CP-element group 2:  members (2) 
      -- CP-element group 2: 	 branch_block_stmt_41/do_while_stmt_42/$entry
      -- CP-element group 2: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42__entry__
      -- 
    converter_1_Daemon_CP_0_elements(2) <= converter_1_Daemon_CP_0_elements(0);
    -- CP-element group 3:  merge  place  bypass  pipeline-parent 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	25 
    -- CP-element group 3:  members (1) 
      -- CP-element group 3: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42__exit__
      -- 
    -- Element group converter_1_Daemon_CP_0_elements(3) is bound as output of CP function.
    -- CP-element group 4:  merge  place  bypass  pipeline-parent 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: successors 
    -- CP-element group 4: 	7 
    -- CP-element group 4:  members (1) 
      -- CP-element group 4: 	 branch_block_stmt_41/do_while_stmt_42/loop_back
      -- 
    -- Element group converter_1_Daemon_CP_0_elements(4) is bound as output of CP function.
    -- CP-element group 5:  branch  transition  place  bypass  pipeline-parent 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	10 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	24 
    -- CP-element group 5: 	23 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_41/do_while_stmt_42/condition_done
      -- CP-element group 5: 	 branch_block_stmt_41/do_while_stmt_42/loop_exit/$entry
      -- CP-element group 5: 	 branch_block_stmt_41/do_while_stmt_42/loop_taken/$entry
      -- 
    converter_1_Daemon_CP_0_elements(5) <= converter_1_Daemon_CP_0_elements(10);
    -- CP-element group 6:  branch  place  bypass  pipeline-parent 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	22 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (1) 
      -- CP-element group 6: 	 branch_block_stmt_41/do_while_stmt_42/loop_body_done
      -- 
    converter_1_Daemon_CP_0_elements(6) <= converter_1_Daemon_CP_0_elements(22);
    -- CP-element group 7:  transition  bypass  pipeline-parent 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	4 
    -- CP-element group 7: successors 
    -- CP-element group 7:  members (1) 
      -- CP-element group 7: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/back_edge_to_loop_body
      -- 
    converter_1_Daemon_CP_0_elements(7) <= converter_1_Daemon_CP_0_elements(4);
    -- CP-element group 8:  transition  bypass  pipeline-parent 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	2 
    -- CP-element group 8: successors 
    -- CP-element group 8:  members (1) 
      -- CP-element group 8: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/first_time_through_loop_body
      -- 
    converter_1_Daemon_CP_0_elements(8) <= converter_1_Daemon_CP_0_elements(2);
    -- CP-element group 9:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	13 
    -- CP-element group 9: 	21 
    -- CP-element group 9: 	11 
    -- CP-element group 9:  members (3) 
      -- CP-element group 9: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/$entry
      -- CP-element group 9: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/loop_body_start
      -- CP-element group 9: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_sample_start_
      -- 
    -- Element group converter_1_Daemon_CP_0_elements(9) is bound as output of CP function.
    -- CP-element group 10:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	21 
    -- CP-element group 10: 	12 
    -- CP-element group 10: 	17 
    -- CP-element group 10: successors 
    -- CP-element group 10: 	5 
    -- CP-element group 10:  members (1) 
      -- CP-element group 10: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/condition_evaluated
      -- 
    condition_evaluated_24_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " condition_evaluated_24_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => converter_1_Daemon_CP_0_elements(10), ack => do_while_stmt_42_branch_req_0); -- 
    converter_1_Daemon_cp_element_group_10: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 2,1 => 2,2 => 2);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "converter_1_Daemon_cp_element_group_10"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= converter_1_Daemon_CP_0_elements(21) & converter_1_Daemon_CP_0_elements(12) & converter_1_Daemon_CP_0_elements(17);
      gj_converter_1_Daemon_cp_element_group_10 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_1_Daemon_CP_0_elements(10), clk => clk, reset => reset); --
    end block;
    -- CP-element group 11:  join  transition  bypass  pipeline-parent 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	9 
    -- CP-element group 11: marked-predecessors 
    -- CP-element group 11: 	17 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	14 
    -- CP-element group 11:  members (1) 
      -- CP-element group 11: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/aggregated_phi_sample_req
      -- 
    converter_1_Daemon_cp_element_group_11: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 2,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_1_Daemon_cp_element_group_11"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_1_Daemon_CP_0_elements(9) & converter_1_Daemon_CP_0_elements(17);
      gj_converter_1_Daemon_cp_element_group_11 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_1_Daemon_CP_0_elements(11), clk => clk, reset => reset); --
    end block;
    -- CP-element group 12:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	16 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	10 
    -- CP-element group 12:  members (1) 
      -- CP-element group 12: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/aggregated_phi_sample_ack_d
      -- 
    -- Element group converter_1_Daemon_CP_0_elements(12) is a control-delay.
    cp_element_12_delay: control_delay_element  generic map(name => " 12_delay", delay_value => 1)  port map(req => converter_1_Daemon_CP_0_elements(16), ack => converter_1_Daemon_CP_0_elements(12), clk => clk, reset =>reset);
    -- CP-element group 13:  join  transition  bypass  pipeline-parent 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	9 
    -- CP-element group 13: marked-predecessors 
    -- CP-element group 13: 	19 
    -- CP-element group 13: successors 
    -- CP-element group 13: 	15 
    -- CP-element group 13:  members (2) 
      -- CP-element group 13: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/aggregated_phi_update_req
      -- CP-element group 13: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_update_start_
      -- 
    converter_1_Daemon_cp_element_group_13: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 2,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_1_Daemon_cp_element_group_13"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_1_Daemon_CP_0_elements(9) & converter_1_Daemon_CP_0_elements(19);
      gj_converter_1_Daemon_cp_element_group_13 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_1_Daemon_CP_0_elements(13), clk => clk, reset => reset); --
    end block;
    -- CP-element group 14:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	11 
    -- CP-element group 14: marked-predecessors 
    -- CP-element group 14: 	17 
    -- CP-element group 14: successors 
    -- CP-element group 14: 	16 
    -- CP-element group 14:  members (3) 
      -- CP-element group 14: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_sample_start_
      -- CP-element group 14: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_Sample/$entry
      -- CP-element group 14: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_Sample/rr
      -- 
    rr_42_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_42_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => converter_1_Daemon_CP_0_elements(14), ack => RPIPE_in_data_1_64_46_inst_req_0); -- 
    converter_1_Daemon_cp_element_group_14: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_1_Daemon_cp_element_group_14"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_1_Daemon_CP_0_elements(11) & converter_1_Daemon_CP_0_elements(17);
      gj_converter_1_Daemon_cp_element_group_14 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_1_Daemon_CP_0_elements(14), clk => clk, reset => reset); --
    end block;
    -- CP-element group 15:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	13 
    -- CP-element group 15: 	16 
    -- CP-element group 15: successors 
    -- CP-element group 15: 	17 
    -- CP-element group 15:  members (3) 
      -- CP-element group 15: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_update_start_
      -- CP-element group 15: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_Update/$entry
      -- CP-element group 15: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_Update/cr
      -- 
    cr_47_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_47_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => converter_1_Daemon_CP_0_elements(15), ack => RPIPE_in_data_1_64_46_inst_req_1); -- 
    converter_1_Daemon_cp_element_group_15: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_1_Daemon_cp_element_group_15"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_1_Daemon_CP_0_elements(13) & converter_1_Daemon_CP_0_elements(16);
      gj_converter_1_Daemon_cp_element_group_15 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_1_Daemon_CP_0_elements(15), clk => clk, reset => reset); --
    end block;
    -- CP-element group 16:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	14 
    -- CP-element group 16: successors 
    -- CP-element group 16: 	22 
    -- CP-element group 16: 	12 
    -- CP-element group 16: 	15 
    -- CP-element group 16:  members (5) 
      -- CP-element group 16: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_sample_completed_
      -- CP-element group 16: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_Sample/$exit
      -- CP-element group 16: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_Sample/ra
      -- CP-element group 16: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/aggregated_phi_sample_ack
      -- CP-element group 16: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_sample_completed_
      -- 
    ra_43_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 16_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_1_64_46_inst_ack_0, ack => converter_1_Daemon_CP_0_elements(16)); -- 
    -- CP-element group 17:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	15 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	10 
    -- CP-element group 17: 	18 
    -- CP-element group 17: marked-successors 
    -- CP-element group 17: 	14 
    -- CP-element group 17: 	11 
    -- CP-element group 17:  members (5) 
      -- CP-element group 17: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_update_completed_
      -- CP-element group 17: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_update_completed_
      -- CP-element group 17: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_Update/$exit
      -- CP-element group 17: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_64_46_Update/ca
      -- CP-element group 17: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/aggregated_phi_update_ack
      -- 
    ca_48_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 17_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_1_64_46_inst_ack_1, ack => converter_1_Daemon_CP_0_elements(17)); -- 
    -- CP-element group 18:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: 	17 
    -- CP-element group 18: marked-predecessors 
    -- CP-element group 18: 	20 
    -- CP-element group 18: successors 
    -- CP-element group 18: 	19 
    -- CP-element group 18:  members (3) 
      -- CP-element group 18: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_sample_start_
      -- CP-element group 18: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_Sample/$entry
      -- CP-element group 18: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_Sample/req
      -- 
    req_56_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_56_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => converter_1_Daemon_CP_0_elements(18), ack => WPIPE_in_data_1_55_inst_req_0); -- 
    converter_1_Daemon_cp_element_group_18: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_1_Daemon_cp_element_group_18"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_1_Daemon_CP_0_elements(17) & converter_1_Daemon_CP_0_elements(20);
      gj_converter_1_Daemon_cp_element_group_18 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_1_Daemon_CP_0_elements(18), clk => clk, reset => reset); --
    end block;
    -- CP-element group 19:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: 	18 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	20 
    -- CP-element group 19: marked-successors 
    -- CP-element group 19: 	13 
    -- CP-element group 19:  members (6) 
      -- CP-element group 19: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_sample_completed_
      -- CP-element group 19: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_update_start_
      -- CP-element group 19: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_Sample/$exit
      -- CP-element group 19: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_Sample/ack
      -- CP-element group 19: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_Update/$entry
      -- CP-element group 19: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_Update/req
      -- 
    ack_57_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 19_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_in_data_1_55_inst_ack_0, ack => converter_1_Daemon_CP_0_elements(19)); -- 
    req_61_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_61_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => converter_1_Daemon_CP_0_elements(19), ack => WPIPE_in_data_1_55_inst_req_1); -- 
    -- CP-element group 20:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	19 
    -- CP-element group 20: successors 
    -- CP-element group 20: 	22 
    -- CP-element group 20: marked-successors 
    -- CP-element group 20: 	18 
    -- CP-element group 20:  members (3) 
      -- CP-element group 20: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_update_completed_
      -- CP-element group 20: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_Update/$exit
      -- CP-element group 20: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_in_data_1_55_Update/ack
      -- 
    ack_62_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 20_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_in_data_1_55_inst_ack_1, ack => converter_1_Daemon_CP_0_elements(20)); -- 
    -- CP-element group 21:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: 	9 
    -- CP-element group 21: successors 
    -- CP-element group 21: 	10 
    -- CP-element group 21:  members (1) 
      -- CP-element group 21: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/loop_body_delay_to_condition_start
      -- 
    -- Element group converter_1_Daemon_CP_0_elements(21) is a control-delay.
    cp_element_21_delay: control_delay_element  generic map(name => " 21_delay", delay_value => 1)  port map(req => converter_1_Daemon_CP_0_elements(9), ack => converter_1_Daemon_CP_0_elements(21), clk => clk, reset =>reset);
    -- CP-element group 22:  join  transition  bypass  pipeline-parent 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	16 
    -- CP-element group 22: 	20 
    -- CP-element group 22: successors 
    -- CP-element group 22: 	6 
    -- CP-element group 22:  members (1) 
      -- CP-element group 22: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/$exit
      -- 
    converter_1_Daemon_cp_element_group_22: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 2,1 => 2);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_1_Daemon_cp_element_group_22"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_1_Daemon_CP_0_elements(16) & converter_1_Daemon_CP_0_elements(20);
      gj_converter_1_Daemon_cp_element_group_22 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_1_Daemon_CP_0_elements(22), clk => clk, reset => reset); --
    end block;
    -- CP-element group 23:  transition  input  bypass  pipeline-parent 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: 	5 
    -- CP-element group 23: successors 
    -- CP-element group 23:  members (2) 
      -- CP-element group 23: 	 branch_block_stmt_41/do_while_stmt_42/loop_exit/$exit
      -- CP-element group 23: 	 branch_block_stmt_41/do_while_stmt_42/loop_exit/ack
      -- 
    ack_67_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 23_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_42_branch_ack_0, ack => converter_1_Daemon_CP_0_elements(23)); -- 
    -- CP-element group 24:  transition  input  bypass  pipeline-parent 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: 	5 
    -- CP-element group 24: successors 
    -- CP-element group 24:  members (2) 
      -- CP-element group 24: 	 branch_block_stmt_41/do_while_stmt_42/loop_taken/$exit
      -- CP-element group 24: 	 branch_block_stmt_41/do_while_stmt_42/loop_taken/ack
      -- 
    ack_71_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 24_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_42_branch_ack_1, ack => converter_1_Daemon_CP_0_elements(24)); -- 
    -- CP-element group 25:  transition  bypass  pipeline-parent 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: 	3 
    -- CP-element group 25: successors 
    -- CP-element group 25: 	1 
    -- CP-element group 25:  members (1) 
      -- CP-element group 25: 	 branch_block_stmt_41/do_while_stmt_42/$exit
      -- 
    converter_1_Daemon_CP_0_elements(25) <= converter_1_Daemon_CP_0_elements(3);
    converter_1_Daemon_do_while_stmt_42_terminator_72: loop_terminator -- 
      generic map (name => " converter_1_Daemon_do_while_stmt_42_terminator_72", max_iterations_in_flight =>2) 
      port map(loop_body_exit => converter_1_Daemon_CP_0_elements(6),loop_continue => converter_1_Daemon_CP_0_elements(24),loop_terminate => converter_1_Daemon_CP_0_elements(23),loop_back => converter_1_Daemon_CP_0_elements(4),loop_exit => converter_1_Daemon_CP_0_elements(3),clk => clk, reset => reset); -- 
    entry_tmerge_25_block : block -- 
      signal preds : BooleanArray(0 to 1);
      begin -- 
        preds(0)  <= converter_1_Daemon_CP_0_elements(7);
        preds(1)  <= converter_1_Daemon_CP_0_elements(8);
        entry_tmerge_25 : transition_merge -- 
          generic map(name => " entry_tmerge_25")
          port map (preds => preds, symbol_out => converter_1_Daemon_CP_0_elements(9));
          -- 
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal RPIPE_in_data_1_64_46_wire : std_logic_vector(63 downto 0);
    signal in_word_64_44 : std_logic_vector(63 downto 0);
    signal konst_59_wire_constant : std_logic_vector(0 downto 0);
    signal word_lower_51 : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    konst_59_wire_constant <= "1";
    -- flow-through slice operator slice_50_inst
    word_lower_51 <= in_word_64_44(31 downto 0);
    -- interlock ssrc_phi_stmt_44
    process(RPIPE_in_data_1_64_46_wire) -- 
      variable tmp_var : std_logic_vector(63 downto 0); -- 
    begin -- 
      tmp_var := (others => '0'); 
      tmp_var( 63 downto 0) := RPIPE_in_data_1_64_46_wire(63 downto 0);
      in_word_64_44 <= tmp_var; -- 
    end process;
    do_while_stmt_42_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= konst_59_wire_constant;
      branch_instance: BranchBase -- 
        generic map( name => "do_while_stmt_42_branch", condition_width => 1,  bypass_flag => true)
        port map( -- 
          condition => condition_sig,
          req => do_while_stmt_42_branch_req_0,
          ack0 => do_while_stmt_42_branch_ack_0,
          ack1 => do_while_stmt_42_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared inport operator group (0) : RPIPE_in_data_1_64_46_inst 
    InportGroup_0: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_in_data_1_64_46_inst_req_0;
      RPIPE_in_data_1_64_46_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_in_data_1_64_46_inst_req_1;
      RPIPE_in_data_1_64_46_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      RPIPE_in_data_1_64_46_wire <= data_out(63 downto 0);
      in_data_1_64_read_0_gI: SplitGuardInterface generic map(name => "in_data_1_64_read_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      in_data_1_64_read_0: InputPortRevised -- 
        generic map ( name => "in_data_1_64_read_0", data_width => 64,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => False,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => in_data_1_64_pipe_read_req(0),
          oack => in_data_1_64_pipe_read_ack(0),
          odata => in_data_1_64_pipe_read_data(63 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : WPIPE_in_data_1_55_inst 
    OutportGroup_0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_in_data_1_55_inst_req_0;
      WPIPE_in_data_1_55_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_in_data_1_55_inst_req_1;
      WPIPE_in_data_1_55_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <=  '1';
      data_in <= word_lower_51;
      in_data_1_write_0_gI: SplitGuardInterface generic map(name => "in_data_1_write_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      in_data_1_write_0: OutputPortRevised -- 
        generic map ( name => "in_data_1", data_width => 32, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => in_data_1_pipe_write_req(0),
          oack => in_data_1_pipe_write_ack(0),
          odata => in_data_1_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- 
  end Block; -- data_path
  -- 
end converter_1_Daemon_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.ahir_system_global_package.all;
entity converter_2_Daemon is -- 
  generic (tag_length : integer); 
  port ( -- 
    in_data_2_64_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_2_64_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_2_64_pipe_read_data : in   std_logic_vector(63 downto 0);
    in_data_2_pipe_write_req : out  std_logic_vector(0 downto 0);
    in_data_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
    in_data_2_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) ;
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic-- 
  );
  -- 
end entity converter_2_Daemon;
architecture converter_2_Daemon_arch of converter_2_Daemon is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal converter_2_Daemon_CP_73_start: Boolean;
  signal converter_2_Daemon_CP_73_symbol: Boolean;
  -- volatile/operator module components. 
  -- links between control-path and data-path
  signal do_while_stmt_64_branch_req_0 : boolean;
  signal RPIPE_in_data_2_64_68_inst_req_0 : boolean;
  signal RPIPE_in_data_2_64_68_inst_ack_0 : boolean;
  signal RPIPE_in_data_2_64_68_inst_req_1 : boolean;
  signal RPIPE_in_data_2_64_68_inst_ack_1 : boolean;
  signal WPIPE_in_data_2_77_inst_req_0 : boolean;
  signal WPIPE_in_data_2_77_inst_ack_0 : boolean;
  signal WPIPE_in_data_2_77_inst_req_1 : boolean;
  signal WPIPE_in_data_2_77_inst_ack_1 : boolean;
  signal do_while_stmt_64_branch_ack_0 : boolean;
  signal do_while_stmt_64_branch_ack_1 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "converter_2_Daemon_input_buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj_in_buffer_unload_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  converter_2_Daemon_CP_73_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "converter_2_Daemon_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 0) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= converter_2_Daemon_CP_73_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj_out_buffer_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= converter_2_Daemon_CP_73_start & tag_ilock_write_ack_symbol;
    gj_tag_ilock_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= converter_2_Daemon_CP_73_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  converter_2_Daemon_CP_73: Block -- control-path 
    signal converter_2_Daemon_CP_73_elements: BooleanArray(25 downto 0);
    -- 
  begin -- 
    converter_2_Daemon_CP_73_elements(0) <= converter_2_Daemon_CP_73_start;
    converter_2_Daemon_CP_73_symbol <= converter_2_Daemon_CP_73_elements(1);
    -- CP-element group 0:  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	2 
    -- CP-element group 0:  members (4) 
      -- CP-element group 0: 	 $entry
      -- CP-element group 0: 	 branch_block_stmt_63/$entry
      -- CP-element group 0: 	 branch_block_stmt_63/branch_block_stmt_63__entry__
      -- CP-element group 0: 	 branch_block_stmt_63/do_while_stmt_64__entry__
      -- 
    -- CP-element group 1:  transition  place  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	25 
    -- CP-element group 1: successors 
    -- CP-element group 1:  members (4) 
      -- CP-element group 1: 	 $exit
      -- CP-element group 1: 	 branch_block_stmt_63/$exit
      -- CP-element group 1: 	 branch_block_stmt_63/branch_block_stmt_63__exit__
      -- CP-element group 1: 	 branch_block_stmt_63/do_while_stmt_64__exit__
      -- 
    converter_2_Daemon_CP_73_elements(1) <= converter_2_Daemon_CP_73_elements(25);
    -- CP-element group 2:  transition  place  bypass  pipeline-parent 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	0 
    -- CP-element group 2: successors 
    -- CP-element group 2: 	8 
    -- CP-element group 2:  members (2) 
      -- CP-element group 2: 	 branch_block_stmt_63/do_while_stmt_64/$entry
      -- CP-element group 2: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64__entry__
      -- 
    converter_2_Daemon_CP_73_elements(2) <= converter_2_Daemon_CP_73_elements(0);
    -- CP-element group 3:  merge  place  bypass  pipeline-parent 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	25 
    -- CP-element group 3:  members (1) 
      -- CP-element group 3: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64__exit__
      -- 
    -- Element group converter_2_Daemon_CP_73_elements(3) is bound as output of CP function.
    -- CP-element group 4:  merge  place  bypass  pipeline-parent 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: successors 
    -- CP-element group 4: 	7 
    -- CP-element group 4:  members (1) 
      -- CP-element group 4: 	 branch_block_stmt_63/do_while_stmt_64/loop_back
      -- 
    -- Element group converter_2_Daemon_CP_73_elements(4) is bound as output of CP function.
    -- CP-element group 5:  branch  transition  place  bypass  pipeline-parent 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	10 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	24 
    -- CP-element group 5: 	23 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_63/do_while_stmt_64/condition_done
      -- CP-element group 5: 	 branch_block_stmt_63/do_while_stmt_64/loop_exit/$entry
      -- CP-element group 5: 	 branch_block_stmt_63/do_while_stmt_64/loop_taken/$entry
      -- 
    converter_2_Daemon_CP_73_elements(5) <= converter_2_Daemon_CP_73_elements(10);
    -- CP-element group 6:  branch  place  bypass  pipeline-parent 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	22 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (1) 
      -- CP-element group 6: 	 branch_block_stmt_63/do_while_stmt_64/loop_body_done
      -- 
    converter_2_Daemon_CP_73_elements(6) <= converter_2_Daemon_CP_73_elements(22);
    -- CP-element group 7:  transition  bypass  pipeline-parent 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	4 
    -- CP-element group 7: successors 
    -- CP-element group 7:  members (1) 
      -- CP-element group 7: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/back_edge_to_loop_body
      -- 
    converter_2_Daemon_CP_73_elements(7) <= converter_2_Daemon_CP_73_elements(4);
    -- CP-element group 8:  transition  bypass  pipeline-parent 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	2 
    -- CP-element group 8: successors 
    -- CP-element group 8:  members (1) 
      -- CP-element group 8: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/first_time_through_loop_body
      -- 
    converter_2_Daemon_CP_73_elements(8) <= converter_2_Daemon_CP_73_elements(2);
    -- CP-element group 9:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	13 
    -- CP-element group 9: 	11 
    -- CP-element group 9: 	21 
    -- CP-element group 9:  members (3) 
      -- CP-element group 9: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/$entry
      -- CP-element group 9: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/loop_body_start
      -- CP-element group 9: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/phi_stmt_66_sample_start_
      -- 
    -- Element group converter_2_Daemon_CP_73_elements(9) is bound as output of CP function.
    -- CP-element group 10:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	12 
    -- CP-element group 10: 	21 
    -- CP-element group 10: 	17 
    -- CP-element group 10: successors 
    -- CP-element group 10: 	5 
    -- CP-element group 10:  members (1) 
      -- CP-element group 10: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/condition_evaluated
      -- 
    condition_evaluated_97_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " condition_evaluated_97_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => converter_2_Daemon_CP_73_elements(10), ack => do_while_stmt_64_branch_req_0); -- 
    converter_2_Daemon_cp_element_group_10: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 2,1 => 2,2 => 2);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "converter_2_Daemon_cp_element_group_10"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= converter_2_Daemon_CP_73_elements(12) & converter_2_Daemon_CP_73_elements(21) & converter_2_Daemon_CP_73_elements(17);
      gj_converter_2_Daemon_cp_element_group_10 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_2_Daemon_CP_73_elements(10), clk => clk, reset => reset); --
    end block;
    -- CP-element group 11:  join  transition  bypass  pipeline-parent 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	9 
    -- CP-element group 11: marked-predecessors 
    -- CP-element group 11: 	17 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	14 
    -- CP-element group 11:  members (1) 
      -- CP-element group 11: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/aggregated_phi_sample_req
      -- 
    converter_2_Daemon_cp_element_group_11: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 2,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_2_Daemon_cp_element_group_11"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_2_Daemon_CP_73_elements(9) & converter_2_Daemon_CP_73_elements(17);
      gj_converter_2_Daemon_cp_element_group_11 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_2_Daemon_CP_73_elements(11), clk => clk, reset => reset); --
    end block;
    -- CP-element group 12:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	16 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	10 
    -- CP-element group 12:  members (1) 
      -- CP-element group 12: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/aggregated_phi_sample_ack_d
      -- 
    -- Element group converter_2_Daemon_CP_73_elements(12) is a control-delay.
    cp_element_12_delay: control_delay_element  generic map(name => " 12_delay", delay_value => 1)  port map(req => converter_2_Daemon_CP_73_elements(16), ack => converter_2_Daemon_CP_73_elements(12), clk => clk, reset =>reset);
    -- CP-element group 13:  join  transition  bypass  pipeline-parent 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	9 
    -- CP-element group 13: marked-predecessors 
    -- CP-element group 13: 	19 
    -- CP-element group 13: successors 
    -- CP-element group 13: 	15 
    -- CP-element group 13:  members (2) 
      -- CP-element group 13: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/phi_stmt_66_update_start_
      -- CP-element group 13: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/aggregated_phi_update_req
      -- 
    converter_2_Daemon_cp_element_group_13: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 2,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_2_Daemon_cp_element_group_13"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_2_Daemon_CP_73_elements(9) & converter_2_Daemon_CP_73_elements(19);
      gj_converter_2_Daemon_cp_element_group_13 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_2_Daemon_CP_73_elements(13), clk => clk, reset => reset); --
    end block;
    -- CP-element group 14:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	11 
    -- CP-element group 14: marked-predecessors 
    -- CP-element group 14: 	17 
    -- CP-element group 14: successors 
    -- CP-element group 14: 	16 
    -- CP-element group 14:  members (3) 
      -- CP-element group 14: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_sample_start_
      -- CP-element group 14: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_Sample/$entry
      -- CP-element group 14: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_Sample/rr
      -- 
    rr_115_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_115_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => converter_2_Daemon_CP_73_elements(14), ack => RPIPE_in_data_2_64_68_inst_req_0); -- 
    converter_2_Daemon_cp_element_group_14: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_2_Daemon_cp_element_group_14"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_2_Daemon_CP_73_elements(11) & converter_2_Daemon_CP_73_elements(17);
      gj_converter_2_Daemon_cp_element_group_14 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_2_Daemon_CP_73_elements(14), clk => clk, reset => reset); --
    end block;
    -- CP-element group 15:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	13 
    -- CP-element group 15: 	16 
    -- CP-element group 15: successors 
    -- CP-element group 15: 	17 
    -- CP-element group 15:  members (3) 
      -- CP-element group 15: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_update_start_
      -- CP-element group 15: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_Update/$entry
      -- CP-element group 15: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_Update/cr
      -- 
    cr_120_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_120_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => converter_2_Daemon_CP_73_elements(15), ack => RPIPE_in_data_2_64_68_inst_req_1); -- 
    converter_2_Daemon_cp_element_group_15: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_2_Daemon_cp_element_group_15"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_2_Daemon_CP_73_elements(13) & converter_2_Daemon_CP_73_elements(16);
      gj_converter_2_Daemon_cp_element_group_15 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_2_Daemon_CP_73_elements(15), clk => clk, reset => reset); --
    end block;
    -- CP-element group 16:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	14 
    -- CP-element group 16: successors 
    -- CP-element group 16: 	15 
    -- CP-element group 16: 	12 
    -- CP-element group 16: 	22 
    -- CP-element group 16:  members (5) 
      -- CP-element group 16: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/phi_stmt_66_sample_completed_
      -- CP-element group 16: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_sample_completed_
      -- CP-element group 16: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/aggregated_phi_sample_ack
      -- CP-element group 16: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_Sample/$exit
      -- CP-element group 16: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_Sample/ra
      -- 
    ra_116_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 16_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_2_64_68_inst_ack_0, ack => converter_2_Daemon_CP_73_elements(16)); -- 
    -- CP-element group 17:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	15 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	10 
    -- CP-element group 17: 	18 
    -- CP-element group 17: marked-successors 
    -- CP-element group 17: 	11 
    -- CP-element group 17: 	14 
    -- CP-element group 17:  members (5) 
      -- CP-element group 17: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/phi_stmt_66_update_completed_
      -- CP-element group 17: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/aggregated_phi_update_ack
      -- CP-element group 17: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_update_completed_
      -- CP-element group 17: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_Update/$exit
      -- CP-element group 17: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/RPIPE_in_data_2_64_68_Update/ca
      -- 
    ca_121_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 17_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_2_64_68_inst_ack_1, ack => converter_2_Daemon_CP_73_elements(17)); -- 
    -- CP-element group 18:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: 	17 
    -- CP-element group 18: marked-predecessors 
    -- CP-element group 18: 	20 
    -- CP-element group 18: successors 
    -- CP-element group 18: 	19 
    -- CP-element group 18:  members (3) 
      -- CP-element group 18: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_sample_start_
      -- CP-element group 18: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_Sample/$entry
      -- CP-element group 18: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_Sample/req
      -- 
    req_129_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_129_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => converter_2_Daemon_CP_73_elements(18), ack => WPIPE_in_data_2_77_inst_req_0); -- 
    converter_2_Daemon_cp_element_group_18: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_2_Daemon_cp_element_group_18"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_2_Daemon_CP_73_elements(17) & converter_2_Daemon_CP_73_elements(20);
      gj_converter_2_Daemon_cp_element_group_18 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_2_Daemon_CP_73_elements(18), clk => clk, reset => reset); --
    end block;
    -- CP-element group 19:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: 	18 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	20 
    -- CP-element group 19: marked-successors 
    -- CP-element group 19: 	13 
    -- CP-element group 19:  members (6) 
      -- CP-element group 19: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_sample_completed_
      -- CP-element group 19: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_update_start_
      -- CP-element group 19: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_Sample/$exit
      -- CP-element group 19: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_Sample/ack
      -- CP-element group 19: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_Update/$entry
      -- CP-element group 19: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_Update/req
      -- 
    ack_130_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 19_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_in_data_2_77_inst_ack_0, ack => converter_2_Daemon_CP_73_elements(19)); -- 
    req_134_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_134_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => converter_2_Daemon_CP_73_elements(19), ack => WPIPE_in_data_2_77_inst_req_1); -- 
    -- CP-element group 20:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	19 
    -- CP-element group 20: successors 
    -- CP-element group 20: 	22 
    -- CP-element group 20: marked-successors 
    -- CP-element group 20: 	18 
    -- CP-element group 20:  members (3) 
      -- CP-element group 20: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_update_completed_
      -- CP-element group 20: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_Update/$exit
      -- CP-element group 20: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/WPIPE_in_data_2_77_Update/ack
      -- 
    ack_135_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 20_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_in_data_2_77_inst_ack_1, ack => converter_2_Daemon_CP_73_elements(20)); -- 
    -- CP-element group 21:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: 	9 
    -- CP-element group 21: successors 
    -- CP-element group 21: 	10 
    -- CP-element group 21:  members (1) 
      -- CP-element group 21: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/loop_body_delay_to_condition_start
      -- 
    -- Element group converter_2_Daemon_CP_73_elements(21) is a control-delay.
    cp_element_21_delay: control_delay_element  generic map(name => " 21_delay", delay_value => 1)  port map(req => converter_2_Daemon_CP_73_elements(9), ack => converter_2_Daemon_CP_73_elements(21), clk => clk, reset =>reset);
    -- CP-element group 22:  join  transition  bypass  pipeline-parent 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	20 
    -- CP-element group 22: 	16 
    -- CP-element group 22: successors 
    -- CP-element group 22: 	6 
    -- CP-element group 22:  members (1) 
      -- CP-element group 22: 	 branch_block_stmt_63/do_while_stmt_64/do_while_stmt_64_loop_body/$exit
      -- 
    converter_2_Daemon_cp_element_group_22: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 2,1 => 2);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "converter_2_Daemon_cp_element_group_22"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= converter_2_Daemon_CP_73_elements(20) & converter_2_Daemon_CP_73_elements(16);
      gj_converter_2_Daemon_cp_element_group_22 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => converter_2_Daemon_CP_73_elements(22), clk => clk, reset => reset); --
    end block;
    -- CP-element group 23:  transition  input  bypass  pipeline-parent 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: 	5 
    -- CP-element group 23: successors 
    -- CP-element group 23:  members (2) 
      -- CP-element group 23: 	 branch_block_stmt_63/do_while_stmt_64/loop_exit/$exit
      -- CP-element group 23: 	 branch_block_stmt_63/do_while_stmt_64/loop_exit/ack
      -- 
    ack_140_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 23_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_64_branch_ack_0, ack => converter_2_Daemon_CP_73_elements(23)); -- 
    -- CP-element group 24:  transition  input  bypass  pipeline-parent 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: 	5 
    -- CP-element group 24: successors 
    -- CP-element group 24:  members (2) 
      -- CP-element group 24: 	 branch_block_stmt_63/do_while_stmt_64/loop_taken/$exit
      -- CP-element group 24: 	 branch_block_stmt_63/do_while_stmt_64/loop_taken/ack
      -- 
    ack_144_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 24_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_64_branch_ack_1, ack => converter_2_Daemon_CP_73_elements(24)); -- 
    -- CP-element group 25:  transition  bypass  pipeline-parent 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: 	3 
    -- CP-element group 25: successors 
    -- CP-element group 25: 	1 
    -- CP-element group 25:  members (1) 
      -- CP-element group 25: 	 branch_block_stmt_63/do_while_stmt_64/$exit
      -- 
    converter_2_Daemon_CP_73_elements(25) <= converter_2_Daemon_CP_73_elements(3);
    converter_2_Daemon_do_while_stmt_64_terminator_145: loop_terminator -- 
      generic map (name => " converter_2_Daemon_do_while_stmt_64_terminator_145", max_iterations_in_flight =>2) 
      port map(loop_body_exit => converter_2_Daemon_CP_73_elements(6),loop_continue => converter_2_Daemon_CP_73_elements(24),loop_terminate => converter_2_Daemon_CP_73_elements(23),loop_back => converter_2_Daemon_CP_73_elements(4),loop_exit => converter_2_Daemon_CP_73_elements(3),clk => clk, reset => reset); -- 
    entry_tmerge_98_block : block -- 
      signal preds : BooleanArray(0 to 1);
      begin -- 
        preds(0)  <= converter_2_Daemon_CP_73_elements(7);
        preds(1)  <= converter_2_Daemon_CP_73_elements(8);
        entry_tmerge_98 : transition_merge -- 
          generic map(name => " entry_tmerge_98")
          port map (preds => preds, symbol_out => converter_2_Daemon_CP_73_elements(9));
          -- 
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal RPIPE_in_data_2_64_68_wire : std_logic_vector(63 downto 0);
    signal in_word_64_66 : std_logic_vector(63 downto 0);
    signal konst_81_wire_constant : std_logic_vector(0 downto 0);
    signal word_lower_73 : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    konst_81_wire_constant <= "1";
    -- flow-through slice operator slice_72_inst
    word_lower_73 <= in_word_64_66(31 downto 0);
    -- interlock ssrc_phi_stmt_66
    process(RPIPE_in_data_2_64_68_wire) -- 
      variable tmp_var : std_logic_vector(63 downto 0); -- 
    begin -- 
      tmp_var := (others => '0'); 
      tmp_var( 63 downto 0) := RPIPE_in_data_2_64_68_wire(63 downto 0);
      in_word_64_66 <= tmp_var; -- 
    end process;
    do_while_stmt_64_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= konst_81_wire_constant;
      branch_instance: BranchBase -- 
        generic map( name => "do_while_stmt_64_branch", condition_width => 1,  bypass_flag => true)
        port map( -- 
          condition => condition_sig,
          req => do_while_stmt_64_branch_req_0,
          ack0 => do_while_stmt_64_branch_ack_0,
          ack1 => do_while_stmt_64_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared inport operator group (0) : RPIPE_in_data_2_64_68_inst 
    InportGroup_0: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_in_data_2_64_68_inst_req_0;
      RPIPE_in_data_2_64_68_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_in_data_2_64_68_inst_req_1;
      RPIPE_in_data_2_64_68_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      RPIPE_in_data_2_64_68_wire <= data_out(63 downto 0);
      in_data_2_64_read_0_gI: SplitGuardInterface generic map(name => "in_data_2_64_read_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      in_data_2_64_read_0: InputPortRevised -- 
        generic map ( name => "in_data_2_64_read_0", data_width => 64,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => False,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => in_data_2_64_pipe_read_req(0),
          oack => in_data_2_64_pipe_read_ack(0),
          odata => in_data_2_64_pipe_read_data(63 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : WPIPE_in_data_2_77_inst 
    OutportGroup_0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_in_data_2_77_inst_req_0;
      WPIPE_in_data_2_77_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_in_data_2_77_inst_req_1;
      WPIPE_in_data_2_77_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <=  '1';
      data_in <= word_lower_73;
      in_data_2_write_0_gI: SplitGuardInterface generic map(name => "in_data_2_write_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      in_data_2_write_0: OutputPortRevised -- 
        generic map ( name => "in_data_2", data_width => 32, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => in_data_2_pipe_write_req(0),
          oack => in_data_2_pipe_write_ack(0),
          odata => in_data_2_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- 
  end Block; -- data_path
  -- 
end converter_2_Daemon_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.ahir_system_global_package.all;
entity inputPort_1_Daemon is -- 
  generic (tag_length : integer); 
  port ( -- 
    in_data_1_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_1_pipe_read_data : in   std_logic_vector(31 downto 0);
    noblock_obuf_1_1_pipe_write_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_1_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_1_1_pipe_write_data : out  std_logic_vector(32 downto 0);
    noblock_obuf_1_2_pipe_write_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_1_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_1_2_pipe_write_data : out  std_logic_vector(32 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) ;
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic-- 
  );
  -- 
end entity inputPort_1_Daemon;
architecture inputPort_1_Daemon_arch of inputPort_1_Daemon is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal inputPort_1_Daemon_CP_149_start: Boolean;
  signal inputPort_1_Daemon_CP_149_symbol: Boolean;
  -- volatile/operator module components. 
  -- links between control-path and data-path
  signal do_while_stmt_89_branch_req_0 : boolean;
  signal phi_stmt_91_req_1 : boolean;
  signal phi_stmt_91_req_0 : boolean;
  signal phi_stmt_91_ack_0 : boolean;
  signal next_count_down_138_96_buf_req_0 : boolean;
  signal next_count_down_138_96_buf_ack_0 : boolean;
  signal next_count_down_138_96_buf_req_1 : boolean;
  signal next_count_down_138_96_buf_ack_1 : boolean;
  signal RPIPE_in_data_1_99_inst_req_0 : boolean;
  signal RPIPE_in_data_1_99_inst_ack_0 : boolean;
  signal RPIPE_in_data_1_99_inst_req_1 : boolean;
  signal RPIPE_in_data_1_99_inst_ack_1 : boolean;
  signal phi_stmt_100_req_1 : boolean;
  signal phi_stmt_100_req_0 : boolean;
  signal phi_stmt_100_ack_0 : boolean;
  signal next_last_dest_id_144_103_buf_req_0 : boolean;
  signal next_last_dest_id_144_103_buf_ack_0 : boolean;
  signal next_last_dest_id_144_103_buf_req_1 : boolean;
  signal next_last_dest_id_144_103_buf_ack_1 : boolean;
  signal WPIPE_noblock_obuf_1_1_156_inst_req_0 : boolean;
  signal WPIPE_noblock_obuf_1_1_156_inst_ack_0 : boolean;
  signal WPIPE_noblock_obuf_1_1_156_inst_req_1 : boolean;
  signal WPIPE_noblock_obuf_1_1_156_inst_ack_1 : boolean;
  signal WPIPE_noblock_obuf_1_2_165_inst_req_0 : boolean;
  signal WPIPE_noblock_obuf_1_2_165_inst_ack_0 : boolean;
  signal WPIPE_noblock_obuf_1_2_165_inst_req_1 : boolean;
  signal WPIPE_noblock_obuf_1_2_165_inst_ack_1 : boolean;
  signal do_while_stmt_89_branch_ack_0 : boolean;
  signal do_while_stmt_89_branch_ack_1 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "inputPort_1_Daemon_input_buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj_in_buffer_unload_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  inputPort_1_Daemon_CP_149_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "inputPort_1_Daemon_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 0) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= inputPort_1_Daemon_CP_149_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj_out_buffer_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= inputPort_1_Daemon_CP_149_start & tag_ilock_write_ack_symbol;
    gj_tag_ilock_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= inputPort_1_Daemon_CP_149_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  inputPort_1_Daemon_CP_149: Block -- control-path 
    signal inputPort_1_Daemon_CP_149_elements: BooleanArray(67 downto 0);
    -- 
  begin -- 
    inputPort_1_Daemon_CP_149_elements(0) <= inputPort_1_Daemon_CP_149_start;
    inputPort_1_Daemon_CP_149_symbol <= inputPort_1_Daemon_CP_149_elements(1);
    -- CP-element group 0:  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	2 
    -- CP-element group 0:  members (4) 
      -- CP-element group 0: 	 $entry
      -- CP-element group 0: 	 branch_block_stmt_88/$entry
      -- CP-element group 0: 	 branch_block_stmt_88/branch_block_stmt_88__entry__
      -- CP-element group 0: 	 branch_block_stmt_88/do_while_stmt_89__entry__
      -- 
    -- CP-element group 1:  transition  place  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	67 
    -- CP-element group 1: successors 
    -- CP-element group 1:  members (4) 
      -- CP-element group 1: 	 $exit
      -- CP-element group 1: 	 branch_block_stmt_88/$exit
      -- CP-element group 1: 	 branch_block_stmt_88/branch_block_stmt_88__exit__
      -- CP-element group 1: 	 branch_block_stmt_88/do_while_stmt_89__exit__
      -- 
    inputPort_1_Daemon_CP_149_elements(1) <= inputPort_1_Daemon_CP_149_elements(67);
    -- CP-element group 2:  transition  place  bypass  pipeline-parent 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	0 
    -- CP-element group 2: successors 
    -- CP-element group 2: 	8 
    -- CP-element group 2:  members (2) 
      -- CP-element group 2: 	 branch_block_stmt_88/do_while_stmt_89/$entry
      -- CP-element group 2: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89__entry__
      -- 
    inputPort_1_Daemon_CP_149_elements(2) <= inputPort_1_Daemon_CP_149_elements(0);
    -- CP-element group 3:  merge  place  bypass  pipeline-parent 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	67 
    -- CP-element group 3:  members (1) 
      -- CP-element group 3: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89__exit__
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(3) is bound as output of CP function.
    -- CP-element group 4:  merge  place  bypass  pipeline-parent 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: successors 
    -- CP-element group 4: 	7 
    -- CP-element group 4:  members (1) 
      -- CP-element group 4: 	 branch_block_stmt_88/do_while_stmt_89/loop_back
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(4) is bound as output of CP function.
    -- CP-element group 5:  branch  transition  place  bypass  pipeline-parent 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	10 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	65 
    -- CP-element group 5: 	66 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_88/do_while_stmt_89/condition_done
      -- CP-element group 5: 	 branch_block_stmt_88/do_while_stmt_89/loop_exit/$entry
      -- CP-element group 5: 	 branch_block_stmt_88/do_while_stmt_89/loop_taken/$entry
      -- 
    inputPort_1_Daemon_CP_149_elements(5) <= inputPort_1_Daemon_CP_149_elements(10);
    -- CP-element group 6:  branch  place  bypass  pipeline-parent 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	64 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (1) 
      -- CP-element group 6: 	 branch_block_stmt_88/do_while_stmt_89/loop_body_done
      -- 
    inputPort_1_Daemon_CP_149_elements(6) <= inputPort_1_Daemon_CP_149_elements(64);
    -- CP-element group 7:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	4 
    -- CP-element group 7: successors 
    -- CP-element group 7: 	44 
    -- CP-element group 7: 	22 
    -- CP-element group 7:  members (1) 
      -- CP-element group 7: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/back_edge_to_loop_body
      -- 
    inputPort_1_Daemon_CP_149_elements(7) <= inputPort_1_Daemon_CP_149_elements(4);
    -- CP-element group 8:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	2 
    -- CP-element group 8: successors 
    -- CP-element group 8: 	46 
    -- CP-element group 8: 	24 
    -- CP-element group 8:  members (1) 
      -- CP-element group 8: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/first_time_through_loop_body
      -- 
    inputPort_1_Daemon_CP_149_elements(8) <= inputPort_1_Daemon_CP_149_elements(2);
    -- CP-element group 9:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	11 
    -- CP-element group 9: 	41 
    -- CP-element group 9: 	35 
    -- CP-element group 9: 	63 
    -- CP-element group 9: 	40 
    -- CP-element group 9: 	16 
    -- CP-element group 9: 	17 
    -- CP-element group 9:  members (3) 
      -- CP-element group 9: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_97_sample_start_
      -- CP-element group 9: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/$entry
      -- CP-element group 9: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/loop_body_start
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(9) is bound as output of CP function.
    -- CP-element group 10:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	13 
    -- CP-element group 10: 	63 
    -- CP-element group 10: 	15 
    -- CP-element group 10: successors 
    -- CP-element group 10: 	5 
    -- CP-element group 10:  members (1) 
      -- CP-element group 10: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/condition_evaluated
      -- 
    condition_evaluated_173_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " condition_evaluated_173_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(10), ack => do_while_stmt_89_branch_req_0); -- 
    inputPort_1_Daemon_cp_element_group_10: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_10"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(13) & inputPort_1_Daemon_CP_149_elements(63) & inputPort_1_Daemon_CP_149_elements(15);
      gj_inputPort_1_Daemon_cp_element_group_10 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(10), clk => clk, reset => reset); --
    end block;
    -- CP-element group 11:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	9 
    -- CP-element group 11: 	40 
    -- CP-element group 11: 	16 
    -- CP-element group 11: marked-predecessors 
    -- CP-element group 11: 	15 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	36 
    -- CP-element group 11: 	18 
    -- CP-element group 11:  members (2) 
      -- CP-element group 11: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/aggregated_phi_sample_req
      -- CP-element group 11: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_sample_start__ps
      -- 
    inputPort_1_Daemon_cp_element_group_11: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 7,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_11"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(9) & inputPort_1_Daemon_CP_149_elements(40) & inputPort_1_Daemon_CP_149_elements(16) & inputPort_1_Daemon_CP_149_elements(15);
      gj_inputPort_1_Daemon_cp_element_group_11 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(11), clk => clk, reset => reset); --
    end block;
    -- CP-element group 12:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	42 
    -- CP-element group 12: 	38 
    -- CP-element group 12: 	19 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	13 
    -- CP-element group 12: 	64 
    -- CP-element group 12: marked-successors 
    -- CP-element group 12: 	40 
    -- CP-element group 12: 	16 
    -- CP-element group 12:  members (4) 
      -- CP-element group 12: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_97_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/aggregated_phi_sample_ack
      -- CP-element group 12: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_sample_completed_
      -- 
    inputPort_1_Daemon_cp_element_group_12: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_12"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(42) & inputPort_1_Daemon_CP_149_elements(38) & inputPort_1_Daemon_CP_149_elements(19);
      gj_inputPort_1_Daemon_cp_element_group_12 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(12), clk => clk, reset => reset); --
    end block;
    -- CP-element group 13:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	12 
    -- CP-element group 13: successors 
    -- CP-element group 13: 	10 
    -- CP-element group 13:  members (1) 
      -- CP-element group 13: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/aggregated_phi_sample_ack_d
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(13) is a control-delay.
    cp_element_13_delay: control_delay_element  generic map(name => " 13_delay", delay_value => 1)  port map(req => inputPort_1_Daemon_CP_149_elements(12), ack => inputPort_1_Daemon_CP_149_elements(13), clk => clk, reset =>reset);
    -- CP-element group 14:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	41 
    -- CP-element group 14: 	35 
    -- CP-element group 14: 	17 
    -- CP-element group 14: successors 
    -- CP-element group 14: 	37 
    -- CP-element group 14: 	20 
    -- CP-element group 14:  members (2) 
      -- CP-element group 14: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/aggregated_phi_update_req
      -- CP-element group 14: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_update_start__ps
      -- 
    inputPort_1_Daemon_cp_element_group_14: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_14"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(41) & inputPort_1_Daemon_CP_149_elements(35) & inputPort_1_Daemon_CP_149_elements(17);
      gj_inputPort_1_Daemon_cp_element_group_14 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(14), clk => clk, reset => reset); --
    end block;
    -- CP-element group 15:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	39 
    -- CP-element group 15: 	43 
    -- CP-element group 15: 	21 
    -- CP-element group 15: successors 
    -- CP-element group 15: 	10 
    -- CP-element group 15: marked-successors 
    -- CP-element group 15: 	11 
    -- CP-element group 15:  members (1) 
      -- CP-element group 15: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/aggregated_phi_update_ack
      -- 
    inputPort_1_Daemon_cp_element_group_15: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_15"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(39) & inputPort_1_Daemon_CP_149_elements(43) & inputPort_1_Daemon_CP_149_elements(21);
      gj_inputPort_1_Daemon_cp_element_group_15 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(15), clk => clk, reset => reset); --
    end block;
    -- CP-element group 16:  join  transition  bypass  pipeline-parent 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	9 
    -- CP-element group 16: marked-predecessors 
    -- CP-element group 16: 	12 
    -- CP-element group 16: successors 
    -- CP-element group 16: 	11 
    -- CP-element group 16:  members (1) 
      -- CP-element group 16: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_sample_start_
      -- 
    inputPort_1_Daemon_cp_element_group_16: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_16"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(9) & inputPort_1_Daemon_CP_149_elements(12);
      gj_inputPort_1_Daemon_cp_element_group_16 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(16), clk => clk, reset => reset); --
    end block;
    -- CP-element group 17:  join  transition  bypass  pipeline-parent 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	9 
    -- CP-element group 17: marked-predecessors 
    -- CP-element group 17: 	58 
    -- CP-element group 17: 	61 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	14 
    -- CP-element group 17:  members (1) 
      -- CP-element group 17: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_update_start_
      -- 
    inputPort_1_Daemon_cp_element_group_17: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_17"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(9) & inputPort_1_Daemon_CP_149_elements(58) & inputPort_1_Daemon_CP_149_elements(61);
      gj_inputPort_1_Daemon_cp_element_group_17 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(17), clk => clk, reset => reset); --
    end block;
    -- CP-element group 18:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: 	11 
    -- CP-element group 18: successors 
    -- CP-element group 18:  members (1) 
      -- CP-element group 18: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_sample_start__ps
      -- 
    inputPort_1_Daemon_CP_149_elements(18) <= inputPort_1_Daemon_CP_149_elements(11);
    -- CP-element group 19:  join  transition  bypass  pipeline-parent 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	12 
    -- CP-element group 19:  members (1) 
      -- CP-element group 19: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_sample_completed__ps
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(19) is bound as output of CP function.
    -- CP-element group 20:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	14 
    -- CP-element group 20: successors 
    -- CP-element group 20:  members (1) 
      -- CP-element group 20: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_update_start__ps
      -- 
    inputPort_1_Daemon_CP_149_elements(20) <= inputPort_1_Daemon_CP_149_elements(14);
    -- CP-element group 21:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: successors 
    -- CP-element group 21: 	60 
    -- CP-element group 21: 	57 
    -- CP-element group 21: 	15 
    -- CP-element group 21:  members (2) 
      -- CP-element group 21: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_update_completed_
      -- CP-element group 21: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_update_completed__ps
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(21) is bound as output of CP function.
    -- CP-element group 22:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	7 
    -- CP-element group 22: successors 
    -- CP-element group 22:  members (1) 
      -- CP-element group 22: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_loopback_trigger
      -- 
    inputPort_1_Daemon_CP_149_elements(22) <= inputPort_1_Daemon_CP_149_elements(7);
    -- CP-element group 23:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: successors 
    -- CP-element group 23:  members (2) 
      -- CP-element group 23: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_loopback_sample_req
      -- CP-element group 23: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_loopback_sample_req_ps
      -- 
    phi_stmt_91_loopback_sample_req_189_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_91_loopback_sample_req_189_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(23), ack => phi_stmt_91_req_1); -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(23) is bound as output of CP function.
    -- CP-element group 24:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: 	8 
    -- CP-element group 24: successors 
    -- CP-element group 24:  members (1) 
      -- CP-element group 24: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_entry_trigger
      -- 
    inputPort_1_Daemon_CP_149_elements(24) <= inputPort_1_Daemon_CP_149_elements(8);
    -- CP-element group 25:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: successors 
    -- CP-element group 25:  members (2) 
      -- CP-element group 25: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_entry_sample_req
      -- CP-element group 25: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_entry_sample_req_ps
      -- 
    phi_stmt_91_entry_sample_req_192_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_91_entry_sample_req_192_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(25), ack => phi_stmt_91_req_0); -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(25) is bound as output of CP function.
    -- CP-element group 26:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 26: predecessors 
    -- CP-element group 26: successors 
    -- CP-element group 26:  members (2) 
      -- CP-element group 26: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_phi_mux_ack
      -- CP-element group 26: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_91_phi_mux_ack_ps
      -- 
    phi_stmt_91_phi_mux_ack_195_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 26_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_91_ack_0, ack => inputPort_1_Daemon_CP_149_elements(26)); -- 
    -- CP-element group 27:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 27: predecessors 
    -- CP-element group 27: successors 
    -- CP-element group 27:  members (4) 
      -- CP-element group 27: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/type_cast_95_sample_start__ps
      -- CP-element group 27: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/type_cast_95_sample_completed__ps
      -- CP-element group 27: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/type_cast_95_sample_start_
      -- CP-element group 27: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/type_cast_95_sample_completed_
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(27) is bound as output of CP function.
    -- CP-element group 28:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 28: predecessors 
    -- CP-element group 28: successors 
    -- CP-element group 28: 	30 
    -- CP-element group 28:  members (2) 
      -- CP-element group 28: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/type_cast_95_update_start__ps
      -- CP-element group 28: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/type_cast_95_update_start_
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(28) is bound as output of CP function.
    -- CP-element group 29:  join  transition  bypass  pipeline-parent 
    -- CP-element group 29: predecessors 
    -- CP-element group 29: 	30 
    -- CP-element group 29: successors 
    -- CP-element group 29:  members (1) 
      -- CP-element group 29: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/type_cast_95_update_completed__ps
      -- 
    inputPort_1_Daemon_CP_149_elements(29) <= inputPort_1_Daemon_CP_149_elements(30);
    -- CP-element group 30:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 30: predecessors 
    -- CP-element group 30: 	28 
    -- CP-element group 30: successors 
    -- CP-element group 30: 	29 
    -- CP-element group 30:  members (1) 
      -- CP-element group 30: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/type_cast_95_update_completed_
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(30) is a control-delay.
    cp_element_30_delay: control_delay_element  generic map(name => " 30_delay", delay_value => 1)  port map(req => inputPort_1_Daemon_CP_149_elements(28), ack => inputPort_1_Daemon_CP_149_elements(30), clk => clk, reset =>reset);
    -- CP-element group 31:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 31: predecessors 
    -- CP-element group 31: successors 
    -- CP-element group 31: 	33 
    -- CP-element group 31:  members (4) 
      -- CP-element group 31: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_sample_start__ps
      -- CP-element group 31: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_sample_start_
      -- CP-element group 31: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_Sample/$entry
      -- CP-element group 31: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_Sample/req
      -- 
    req_216_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_216_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(31), ack => next_count_down_138_96_buf_req_0); -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(31) is bound as output of CP function.
    -- CP-element group 32:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 32: predecessors 
    -- CP-element group 32: successors 
    -- CP-element group 32: 	34 
    -- CP-element group 32:  members (4) 
      -- CP-element group 32: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_update_start__ps
      -- CP-element group 32: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_update_start_
      -- CP-element group 32: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_Update/$entry
      -- CP-element group 32: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_Update/req
      -- 
    req_221_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_221_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(32), ack => next_count_down_138_96_buf_req_1); -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(32) is bound as output of CP function.
    -- CP-element group 33:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 33: predecessors 
    -- CP-element group 33: 	31 
    -- CP-element group 33: successors 
    -- CP-element group 33:  members (4) 
      -- CP-element group 33: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_sample_completed__ps
      -- CP-element group 33: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_sample_completed_
      -- CP-element group 33: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_Sample/$exit
      -- CP-element group 33: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_Sample/ack
      -- 
    ack_217_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 33_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_down_138_96_buf_ack_0, ack => inputPort_1_Daemon_CP_149_elements(33)); -- 
    -- CP-element group 34:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 34: predecessors 
    -- CP-element group 34: 	32 
    -- CP-element group 34: successors 
    -- CP-element group 34:  members (4) 
      -- CP-element group 34: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_update_completed__ps
      -- CP-element group 34: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_update_completed_
      -- CP-element group 34: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_Update/$exit
      -- CP-element group 34: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_count_down_96_Update/ack
      -- 
    ack_222_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 34_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_down_138_96_buf_ack_1, ack => inputPort_1_Daemon_CP_149_elements(34)); -- 
    -- CP-element group 35:  join  transition  bypass  pipeline-parent 
    -- CP-element group 35: predecessors 
    -- CP-element group 35: 	9 
    -- CP-element group 35: marked-predecessors 
    -- CP-element group 35: 	58 
    -- CP-element group 35: 	61 
    -- CP-element group 35: successors 
    -- CP-element group 35: 	14 
    -- CP-element group 35:  members (1) 
      -- CP-element group 35: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_97_update_start_
      -- 
    inputPort_1_Daemon_cp_element_group_35: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_35"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(9) & inputPort_1_Daemon_CP_149_elements(58) & inputPort_1_Daemon_CP_149_elements(61);
      gj_inputPort_1_Daemon_cp_element_group_35 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(35), clk => clk, reset => reset); --
    end block;
    -- CP-element group 36:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 36: predecessors 
    -- CP-element group 36: 	11 
    -- CP-element group 36: marked-predecessors 
    -- CP-element group 36: 	39 
    -- CP-element group 36: successors 
    -- CP-element group 36: 	38 
    -- CP-element group 36:  members (3) 
      -- CP-element group 36: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_sample_start_
      -- CP-element group 36: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_Sample/$entry
      -- CP-element group 36: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_Sample/rr
      -- 
    rr_235_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_235_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(36), ack => RPIPE_in_data_1_99_inst_req_0); -- 
    inputPort_1_Daemon_cp_element_group_36: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_36"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(11) & inputPort_1_Daemon_CP_149_elements(39);
      gj_inputPort_1_Daemon_cp_element_group_36 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(36), clk => clk, reset => reset); --
    end block;
    -- CP-element group 37:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 37: predecessors 
    -- CP-element group 37: 	14 
    -- CP-element group 37: 	38 
    -- CP-element group 37: successors 
    -- CP-element group 37: 	39 
    -- CP-element group 37:  members (3) 
      -- CP-element group 37: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_update_start_
      -- CP-element group 37: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_Update/$entry
      -- CP-element group 37: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_Update/cr
      -- 
    cr_240_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_240_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(37), ack => RPIPE_in_data_1_99_inst_req_1); -- 
    inputPort_1_Daemon_cp_element_group_37: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_37"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(14) & inputPort_1_Daemon_CP_149_elements(38);
      gj_inputPort_1_Daemon_cp_element_group_37 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(37), clk => clk, reset => reset); --
    end block;
    -- CP-element group 38:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 38: predecessors 
    -- CP-element group 38: 	36 
    -- CP-element group 38: successors 
    -- CP-element group 38: 	12 
    -- CP-element group 38: 	37 
    -- CP-element group 38:  members (3) 
      -- CP-element group 38: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_sample_completed_
      -- CP-element group 38: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_Sample/$exit
      -- CP-element group 38: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_Sample/ra
      -- 
    ra_236_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 38_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_1_99_inst_ack_0, ack => inputPort_1_Daemon_CP_149_elements(38)); -- 
    -- CP-element group 39:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 39: predecessors 
    -- CP-element group 39: 	37 
    -- CP-element group 39: successors 
    -- CP-element group 39: 	60 
    -- CP-element group 39: 	57 
    -- CP-element group 39: 	15 
    -- CP-element group 39: marked-successors 
    -- CP-element group 39: 	36 
    -- CP-element group 39:  members (4) 
      -- CP-element group 39: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_97_update_completed_
      -- CP-element group 39: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_update_completed_
      -- CP-element group 39: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_Update/$exit
      -- CP-element group 39: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/RPIPE_in_data_1_99_Update/ca
      -- 
    ca_241_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 39_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_1_99_inst_ack_1, ack => inputPort_1_Daemon_CP_149_elements(39)); -- 
    -- CP-element group 40:  join  transition  bypass  pipeline-parent 
    -- CP-element group 40: predecessors 
    -- CP-element group 40: 	9 
    -- CP-element group 40: marked-predecessors 
    -- CP-element group 40: 	12 
    -- CP-element group 40: successors 
    -- CP-element group 40: 	11 
    -- CP-element group 40:  members (1) 
      -- CP-element group 40: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_sample_start_
      -- 
    inputPort_1_Daemon_cp_element_group_40: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_40"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(9) & inputPort_1_Daemon_CP_149_elements(12);
      gj_inputPort_1_Daemon_cp_element_group_40 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(40), clk => clk, reset => reset); --
    end block;
    -- CP-element group 41:  join  transition  bypass  pipeline-parent 
    -- CP-element group 41: predecessors 
    -- CP-element group 41: 	9 
    -- CP-element group 41: marked-predecessors 
    -- CP-element group 41: 	58 
    -- CP-element group 41: 	61 
    -- CP-element group 41: successors 
    -- CP-element group 41: 	14 
    -- CP-element group 41:  members (1) 
      -- CP-element group 41: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_update_start_
      -- 
    inputPort_1_Daemon_cp_element_group_41: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_41"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(9) & inputPort_1_Daemon_CP_149_elements(58) & inputPort_1_Daemon_CP_149_elements(61);
      gj_inputPort_1_Daemon_cp_element_group_41 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(41), clk => clk, reset => reset); --
    end block;
    -- CP-element group 42:  join  transition  bypass  pipeline-parent 
    -- CP-element group 42: predecessors 
    -- CP-element group 42: successors 
    -- CP-element group 42: 	12 
    -- CP-element group 42:  members (1) 
      -- CP-element group 42: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_sample_completed__ps
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(42) is bound as output of CP function.
    -- CP-element group 43:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 43: predecessors 
    -- CP-element group 43: successors 
    -- CP-element group 43: 	60 
    -- CP-element group 43: 	57 
    -- CP-element group 43: 	15 
    -- CP-element group 43:  members (2) 
      -- CP-element group 43: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_update_completed_
      -- CP-element group 43: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_update_completed__ps
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(43) is bound as output of CP function.
    -- CP-element group 44:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 44: predecessors 
    -- CP-element group 44: 	7 
    -- CP-element group 44: successors 
    -- CP-element group 44:  members (1) 
      -- CP-element group 44: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_loopback_trigger
      -- 
    inputPort_1_Daemon_CP_149_elements(44) <= inputPort_1_Daemon_CP_149_elements(7);
    -- CP-element group 45:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 45: predecessors 
    -- CP-element group 45: successors 
    -- CP-element group 45:  members (2) 
      -- CP-element group 45: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_loopback_sample_req
      -- CP-element group 45: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_loopback_sample_req_ps
      -- 
    phi_stmt_100_loopback_sample_req_251_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_100_loopback_sample_req_251_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(45), ack => phi_stmt_100_req_1); -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(45) is bound as output of CP function.
    -- CP-element group 46:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 46: predecessors 
    -- CP-element group 46: 	8 
    -- CP-element group 46: successors 
    -- CP-element group 46:  members (1) 
      -- CP-element group 46: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_entry_trigger
      -- 
    inputPort_1_Daemon_CP_149_elements(46) <= inputPort_1_Daemon_CP_149_elements(8);
    -- CP-element group 47:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 47: predecessors 
    -- CP-element group 47: successors 
    -- CP-element group 47:  members (2) 
      -- CP-element group 47: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_entry_sample_req
      -- CP-element group 47: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_entry_sample_req_ps
      -- 
    phi_stmt_100_entry_sample_req_254_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_100_entry_sample_req_254_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(47), ack => phi_stmt_100_req_0); -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(47) is bound as output of CP function.
    -- CP-element group 48:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 48: predecessors 
    -- CP-element group 48: successors 
    -- CP-element group 48:  members (2) 
      -- CP-element group 48: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_phi_mux_ack
      -- CP-element group 48: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/phi_stmt_100_phi_mux_ack_ps
      -- 
    phi_stmt_100_phi_mux_ack_257_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 48_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_100_ack_0, ack => inputPort_1_Daemon_CP_149_elements(48)); -- 
    -- CP-element group 49:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 49: predecessors 
    -- CP-element group 49: successors 
    -- CP-element group 49:  members (4) 
      -- CP-element group 49: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/konst_102_sample_start__ps
      -- CP-element group 49: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/konst_102_sample_completed__ps
      -- CP-element group 49: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/konst_102_sample_start_
      -- CP-element group 49: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/konst_102_sample_completed_
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(49) is bound as output of CP function.
    -- CP-element group 50:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 50: predecessors 
    -- CP-element group 50: successors 
    -- CP-element group 50: 	52 
    -- CP-element group 50:  members (2) 
      -- CP-element group 50: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/konst_102_update_start__ps
      -- CP-element group 50: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/konst_102_update_start_
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(50) is bound as output of CP function.
    -- CP-element group 51:  join  transition  bypass  pipeline-parent 
    -- CP-element group 51: predecessors 
    -- CP-element group 51: 	52 
    -- CP-element group 51: successors 
    -- CP-element group 51:  members (1) 
      -- CP-element group 51: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/konst_102_update_completed__ps
      -- 
    inputPort_1_Daemon_CP_149_elements(51) <= inputPort_1_Daemon_CP_149_elements(52);
    -- CP-element group 52:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 52: predecessors 
    -- CP-element group 52: 	50 
    -- CP-element group 52: successors 
    -- CP-element group 52: 	51 
    -- CP-element group 52:  members (1) 
      -- CP-element group 52: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/konst_102_update_completed_
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(52) is a control-delay.
    cp_element_52_delay: control_delay_element  generic map(name => " 52_delay", delay_value => 1)  port map(req => inputPort_1_Daemon_CP_149_elements(50), ack => inputPort_1_Daemon_CP_149_elements(52), clk => clk, reset =>reset);
    -- CP-element group 53:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 53: predecessors 
    -- CP-element group 53: successors 
    -- CP-element group 53: 	55 
    -- CP-element group 53:  members (4) 
      -- CP-element group 53: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_sample_start__ps
      -- CP-element group 53: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_sample_start_
      -- CP-element group 53: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_Sample/$entry
      -- CP-element group 53: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_Sample/req
      -- 
    req_278_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_278_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(53), ack => next_last_dest_id_144_103_buf_req_0); -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(53) is bound as output of CP function.
    -- CP-element group 54:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 54: predecessors 
    -- CP-element group 54: successors 
    -- CP-element group 54: 	56 
    -- CP-element group 54:  members (4) 
      -- CP-element group 54: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_update_start__ps
      -- CP-element group 54: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_update_start_
      -- CP-element group 54: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_Update/$entry
      -- CP-element group 54: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_Update/req
      -- 
    req_283_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_283_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(54), ack => next_last_dest_id_144_103_buf_req_1); -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(54) is bound as output of CP function.
    -- CP-element group 55:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 55: predecessors 
    -- CP-element group 55: 	53 
    -- CP-element group 55: successors 
    -- CP-element group 55:  members (4) 
      -- CP-element group 55: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_sample_completed__ps
      -- CP-element group 55: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_sample_completed_
      -- CP-element group 55: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_Sample/$exit
      -- CP-element group 55: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_Sample/ack
      -- 
    ack_279_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 55_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_last_dest_id_144_103_buf_ack_0, ack => inputPort_1_Daemon_CP_149_elements(55)); -- 
    -- CP-element group 56:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 56: predecessors 
    -- CP-element group 56: 	54 
    -- CP-element group 56: successors 
    -- CP-element group 56:  members (4) 
      -- CP-element group 56: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_update_completed__ps
      -- CP-element group 56: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_update_completed_
      -- CP-element group 56: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_Update/$exit
      -- CP-element group 56: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/R_next_last_dest_id_103_Update/ack
      -- 
    ack_284_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 56_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_last_dest_id_144_103_buf_ack_1, ack => inputPort_1_Daemon_CP_149_elements(56)); -- 
    -- CP-element group 57:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 57: predecessors 
    -- CP-element group 57: 	39 
    -- CP-element group 57: 	43 
    -- CP-element group 57: 	21 
    -- CP-element group 57: marked-predecessors 
    -- CP-element group 57: 	59 
    -- CP-element group 57: successors 
    -- CP-element group 57: 	58 
    -- CP-element group 57:  members (3) 
      -- CP-element group 57: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_sample_start_
      -- CP-element group 57: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_Sample/$entry
      -- CP-element group 57: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_Sample/req
      -- 
    req_293_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_293_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(57), ack => WPIPE_noblock_obuf_1_1_156_inst_req_0); -- 
    inputPort_1_Daemon_cp_element_group_57: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_57"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(39) & inputPort_1_Daemon_CP_149_elements(43) & inputPort_1_Daemon_CP_149_elements(21) & inputPort_1_Daemon_CP_149_elements(59);
      gj_inputPort_1_Daemon_cp_element_group_57 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(57), clk => clk, reset => reset); --
    end block;
    -- CP-element group 58:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 58: predecessors 
    -- CP-element group 58: 	57 
    -- CP-element group 58: successors 
    -- CP-element group 58: 	59 
    -- CP-element group 58: marked-successors 
    -- CP-element group 58: 	41 
    -- CP-element group 58: 	35 
    -- CP-element group 58: 	17 
    -- CP-element group 58:  members (6) 
      -- CP-element group 58: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_sample_completed_
      -- CP-element group 58: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_update_start_
      -- CP-element group 58: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_Sample/$exit
      -- CP-element group 58: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_Sample/ack
      -- CP-element group 58: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_Update/$entry
      -- CP-element group 58: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_Update/req
      -- 
    ack_294_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 58_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_1_1_156_inst_ack_0, ack => inputPort_1_Daemon_CP_149_elements(58)); -- 
    req_298_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_298_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(58), ack => WPIPE_noblock_obuf_1_1_156_inst_req_1); -- 
    -- CP-element group 59:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 59: predecessors 
    -- CP-element group 59: 	58 
    -- CP-element group 59: successors 
    -- CP-element group 59: 	64 
    -- CP-element group 59: marked-successors 
    -- CP-element group 59: 	57 
    -- CP-element group 59:  members (3) 
      -- CP-element group 59: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_update_completed_
      -- CP-element group 59: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_Update/$exit
      -- CP-element group 59: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_1_156_Update/ack
      -- 
    ack_299_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 59_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_1_1_156_inst_ack_1, ack => inputPort_1_Daemon_CP_149_elements(59)); -- 
    -- CP-element group 60:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 60: predecessors 
    -- CP-element group 60: 	39 
    -- CP-element group 60: 	43 
    -- CP-element group 60: 	21 
    -- CP-element group 60: marked-predecessors 
    -- CP-element group 60: 	62 
    -- CP-element group 60: successors 
    -- CP-element group 60: 	61 
    -- CP-element group 60:  members (3) 
      -- CP-element group 60: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_sample_start_
      -- CP-element group 60: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_Sample/$entry
      -- CP-element group 60: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_Sample/req
      -- 
    req_307_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_307_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(60), ack => WPIPE_noblock_obuf_1_2_165_inst_req_0); -- 
    inputPort_1_Daemon_cp_element_group_60: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_60"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(39) & inputPort_1_Daemon_CP_149_elements(43) & inputPort_1_Daemon_CP_149_elements(21) & inputPort_1_Daemon_CP_149_elements(62);
      gj_inputPort_1_Daemon_cp_element_group_60 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(60), clk => clk, reset => reset); --
    end block;
    -- CP-element group 61:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 61: predecessors 
    -- CP-element group 61: 	60 
    -- CP-element group 61: successors 
    -- CP-element group 61: 	62 
    -- CP-element group 61: marked-successors 
    -- CP-element group 61: 	41 
    -- CP-element group 61: 	35 
    -- CP-element group 61: 	17 
    -- CP-element group 61:  members (6) 
      -- CP-element group 61: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_sample_completed_
      -- CP-element group 61: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_update_start_
      -- CP-element group 61: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_Sample/$exit
      -- CP-element group 61: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_Sample/ack
      -- CP-element group 61: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_Update/$entry
      -- CP-element group 61: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_Update/req
      -- 
    ack_308_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 61_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_1_2_165_inst_ack_0, ack => inputPort_1_Daemon_CP_149_elements(61)); -- 
    req_312_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_312_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_149_elements(61), ack => WPIPE_noblock_obuf_1_2_165_inst_req_1); -- 
    -- CP-element group 62:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 62: predecessors 
    -- CP-element group 62: 	61 
    -- CP-element group 62: successors 
    -- CP-element group 62: 	64 
    -- CP-element group 62: marked-successors 
    -- CP-element group 62: 	60 
    -- CP-element group 62:  members (3) 
      -- CP-element group 62: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_update_completed_
      -- CP-element group 62: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_Update/$exit
      -- CP-element group 62: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/WPIPE_noblock_obuf_1_2_165_Update/ack
      -- 
    ack_313_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 62_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_1_2_165_inst_ack_1, ack => inputPort_1_Daemon_CP_149_elements(62)); -- 
    -- CP-element group 63:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 63: predecessors 
    -- CP-element group 63: 	9 
    -- CP-element group 63: successors 
    -- CP-element group 63: 	10 
    -- CP-element group 63:  members (1) 
      -- CP-element group 63: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/loop_body_delay_to_condition_start
      -- 
    -- Element group inputPort_1_Daemon_CP_149_elements(63) is a control-delay.
    cp_element_63_delay: control_delay_element  generic map(name => " 63_delay", delay_value => 1)  port map(req => inputPort_1_Daemon_CP_149_elements(9), ack => inputPort_1_Daemon_CP_149_elements(63), clk => clk, reset =>reset);
    -- CP-element group 64:  join  transition  bypass  pipeline-parent 
    -- CP-element group 64: predecessors 
    -- CP-element group 64: 	12 
    -- CP-element group 64: 	62 
    -- CP-element group 64: 	59 
    -- CP-element group 64: successors 
    -- CP-element group 64: 	6 
    -- CP-element group 64:  members (1) 
      -- CP-element group 64: 	 branch_block_stmt_88/do_while_stmt_89/do_while_stmt_89_loop_body/$exit
      -- 
    inputPort_1_Daemon_cp_element_group_64: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_64"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_149_elements(12) & inputPort_1_Daemon_CP_149_elements(62) & inputPort_1_Daemon_CP_149_elements(59);
      gj_inputPort_1_Daemon_cp_element_group_64 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(64), clk => clk, reset => reset); --
    end block;
    -- CP-element group 65:  transition  input  bypass  pipeline-parent 
    -- CP-element group 65: predecessors 
    -- CP-element group 65: 	5 
    -- CP-element group 65: successors 
    -- CP-element group 65:  members (2) 
      -- CP-element group 65: 	 branch_block_stmt_88/do_while_stmt_89/loop_exit/$exit
      -- CP-element group 65: 	 branch_block_stmt_88/do_while_stmt_89/loop_exit/ack
      -- 
    ack_318_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 65_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_89_branch_ack_0, ack => inputPort_1_Daemon_CP_149_elements(65)); -- 
    -- CP-element group 66:  transition  input  bypass  pipeline-parent 
    -- CP-element group 66: predecessors 
    -- CP-element group 66: 	5 
    -- CP-element group 66: successors 
    -- CP-element group 66:  members (2) 
      -- CP-element group 66: 	 branch_block_stmt_88/do_while_stmt_89/loop_taken/$exit
      -- CP-element group 66: 	 branch_block_stmt_88/do_while_stmt_89/loop_taken/ack
      -- 
    ack_322_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 66_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_89_branch_ack_1, ack => inputPort_1_Daemon_CP_149_elements(66)); -- 
    -- CP-element group 67:  transition  bypass  pipeline-parent 
    -- CP-element group 67: predecessors 
    -- CP-element group 67: 	3 
    -- CP-element group 67: successors 
    -- CP-element group 67: 	1 
    -- CP-element group 67:  members (1) 
      -- CP-element group 67: 	 branch_block_stmt_88/do_while_stmt_89/$exit
      -- 
    inputPort_1_Daemon_CP_149_elements(67) <= inputPort_1_Daemon_CP_149_elements(3);
    inputPort_1_Daemon_do_while_stmt_89_terminator_323: loop_terminator -- 
      generic map (name => " inputPort_1_Daemon_do_while_stmt_89_terminator_323", max_iterations_in_flight =>7) 
      port map(loop_body_exit => inputPort_1_Daemon_CP_149_elements(6),loop_continue => inputPort_1_Daemon_CP_149_elements(66),loop_terminate => inputPort_1_Daemon_CP_149_elements(65),loop_back => inputPort_1_Daemon_CP_149_elements(4),loop_exit => inputPort_1_Daemon_CP_149_elements(3),clk => clk, reset => reset); -- 
    phi_stmt_91_phi_seq_223_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= inputPort_1_Daemon_CP_149_elements(24);
      inputPort_1_Daemon_CP_149_elements(27)<= src_sample_reqs(0);
      src_sample_acks(0)  <= inputPort_1_Daemon_CP_149_elements(27);
      inputPort_1_Daemon_CP_149_elements(28)<= src_update_reqs(0);
      src_update_acks(0)  <= inputPort_1_Daemon_CP_149_elements(29);
      inputPort_1_Daemon_CP_149_elements(25) <= phi_mux_reqs(0);
      triggers(1)  <= inputPort_1_Daemon_CP_149_elements(22);
      inputPort_1_Daemon_CP_149_elements(31)<= src_sample_reqs(1);
      src_sample_acks(1)  <= inputPort_1_Daemon_CP_149_elements(33);
      inputPort_1_Daemon_CP_149_elements(32)<= src_update_reqs(1);
      src_update_acks(1)  <= inputPort_1_Daemon_CP_149_elements(34);
      inputPort_1_Daemon_CP_149_elements(23) <= phi_mux_reqs(1);
      phi_stmt_91_phi_seq_223 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_91_phi_seq_223") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => inputPort_1_Daemon_CP_149_elements(18), 
          phi_sample_ack => inputPort_1_Daemon_CP_149_elements(19), 
          phi_update_req => inputPort_1_Daemon_CP_149_elements(20), 
          phi_update_ack => inputPort_1_Daemon_CP_149_elements(21), 
          phi_mux_ack => inputPort_1_Daemon_CP_149_elements(26), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_100_phi_seq_285_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= inputPort_1_Daemon_CP_149_elements(46);
      inputPort_1_Daemon_CP_149_elements(49)<= src_sample_reqs(0);
      src_sample_acks(0)  <= inputPort_1_Daemon_CP_149_elements(49);
      inputPort_1_Daemon_CP_149_elements(50)<= src_update_reqs(0);
      src_update_acks(0)  <= inputPort_1_Daemon_CP_149_elements(51);
      inputPort_1_Daemon_CP_149_elements(47) <= phi_mux_reqs(0);
      triggers(1)  <= inputPort_1_Daemon_CP_149_elements(44);
      inputPort_1_Daemon_CP_149_elements(53)<= src_sample_reqs(1);
      src_sample_acks(1)  <= inputPort_1_Daemon_CP_149_elements(55);
      inputPort_1_Daemon_CP_149_elements(54)<= src_update_reqs(1);
      src_update_acks(1)  <= inputPort_1_Daemon_CP_149_elements(56);
      inputPort_1_Daemon_CP_149_elements(45) <= phi_mux_reqs(1);
      phi_stmt_100_phi_seq_285 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_100_phi_seq_285") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => inputPort_1_Daemon_CP_149_elements(11), 
          phi_sample_ack => inputPort_1_Daemon_CP_149_elements(42), 
          phi_update_req => inputPort_1_Daemon_CP_149_elements(14), 
          phi_update_ack => inputPort_1_Daemon_CP_149_elements(43), 
          phi_mux_ack => inputPort_1_Daemon_CP_149_elements(48), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    entry_tmerge_174_block : block -- 
      signal preds : BooleanArray(0 to 1);
      begin -- 
        preds(0)  <= inputPort_1_Daemon_CP_149_elements(7);
        preds(1)  <= inputPort_1_Daemon_CP_149_elements(8);
        entry_tmerge_174 : transition_merge -- 
          generic map(name => " entry_tmerge_174")
          port map (preds => preds, symbol_out => inputPort_1_Daemon_CP_149_elements(9));
          -- 
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal RPIPE_in_data_1_99_wire : std_logic_vector(31 downto 0);
    signal R_ONE_1_146_wire_constant : std_logic_vector(0 downto 0);
    signal SUB_u16_u16_133_wire : std_logic_vector(15 downto 0);
    signal SUB_u16_u16_136_wire : std_logic_vector(15 downto 0);
    signal count_down_91 : std_logic_vector(15 downto 0);
    signal data_to_outport_149 : std_logic_vector(32 downto 0);
    signal dest_id_115 : std_logic_vector(7 downto 0);
    signal input_word_97 : std_logic_vector(31 downto 0);
    signal konst_102_wire_constant : std_logic_vector(7 downto 0);
    signal konst_109_wire_constant : std_logic_vector(15 downto 0);
    signal konst_132_wire_constant : std_logic_vector(15 downto 0);
    signal konst_135_wire_constant : std_logic_vector(15 downto 0);
    signal konst_152_wire_constant : std_logic_vector(7 downto 0);
    signal konst_161_wire_constant : std_logic_vector(7 downto 0);
    signal konst_177_wire_constant : std_logic_vector(0 downto 0);
    signal last_dest_id_100 : std_logic_vector(7 downto 0);
    signal new_packet_111 : std_logic_vector(0 downto 0);
    signal next_count_down_138 : std_logic_vector(15 downto 0);
    signal next_count_down_138_96_buffered : std_logic_vector(15 downto 0);
    signal next_last_dest_id_144 : std_logic_vector(7 downto 0);
    signal next_last_dest_id_144_103_buffered : std_logic_vector(7 downto 0);
    signal pkt_length_119 : std_logic_vector(15 downto 0);
    signal send_to_1_154 : std_logic_vector(0 downto 0);
    signal send_to_2_163 : std_logic_vector(0 downto 0);
    signal seq_id_123 : std_logic_vector(7 downto 0);
    signal type_cast_95_wire_constant : std_logic_vector(15 downto 0);
    -- 
  begin -- 
    R_ONE_1_146_wire_constant <= "1";
    konst_102_wire_constant <= "00000000";
    konst_109_wire_constant <= "0000000000000000";
    konst_132_wire_constant <= "0000000000000001";
    konst_135_wire_constant <= "0000000000000001";
    konst_152_wire_constant <= "00000001";
    konst_161_wire_constant <= "00000010";
    konst_177_wire_constant <= "1";
    type_cast_95_wire_constant <= "0000000000000000";
    phi_stmt_100: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= konst_102_wire_constant & next_last_dest_id_144_103_buffered;
      req <= phi_stmt_100_req_0 & phi_stmt_100_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_100",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_100_ack_0,
          idata => idata,
          odata => last_dest_id_100,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_100
    phi_stmt_91: Block -- phi operator 
      signal idata: std_logic_vector(31 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_95_wire_constant & next_count_down_138_96_buffered;
      req <= phi_stmt_91_req_0 & phi_stmt_91_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_91",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 16) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_91_ack_0,
          idata => idata,
          odata => count_down_91,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_91
    -- flow-through select operator MUX_137_inst
    next_count_down_138 <= SUB_u16_u16_133_wire when (new_packet_111(0) /=  '0') else SUB_u16_u16_136_wire;
    -- flow-through select operator MUX_143_inst
    next_last_dest_id_144 <= dest_id_115 when (new_packet_111(0) /=  '0') else last_dest_id_100;
    -- flow-through slice operator slice_114_inst
    dest_id_115 <= input_word_97(31 downto 24);
    -- flow-through slice operator slice_118_inst
    pkt_length_119 <= input_word_97(23 downto 8);
    -- flow-through slice operator slice_122_inst
    seq_id_123 <= input_word_97(7 downto 0);
    next_count_down_138_96_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_count_down_138_96_buf_req_0;
      next_count_down_138_96_buf_ack_0<= wack(0);
      rreq(0) <= next_count_down_138_96_buf_req_1;
      next_count_down_138_96_buf_ack_1<= rack(0);
      next_count_down_138_96_buf : InterlockBuffer generic map ( -- 
        name => "next_count_down_138_96_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 16,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_count_down_138,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_count_down_138_96_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_last_dest_id_144_103_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_last_dest_id_144_103_buf_req_0;
      next_last_dest_id_144_103_buf_ack_0<= wack(0);
      rreq(0) <= next_last_dest_id_144_103_buf_req_1;
      next_last_dest_id_144_103_buf_ack_1<= rack(0);
      next_last_dest_id_144_103_buf : InterlockBuffer generic map ( -- 
        name => "next_last_dest_id_144_103_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_last_dest_id_144,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_last_dest_id_144_103_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    -- interlock ssrc_phi_stmt_97
    process(RPIPE_in_data_1_99_wire) -- 
      variable tmp_var : std_logic_vector(31 downto 0); -- 
    begin -- 
      tmp_var := (others => '0'); 
      tmp_var( 31 downto 0) := RPIPE_in_data_1_99_wire(31 downto 0);
      input_word_97 <= tmp_var; -- 
    end process;
    do_while_stmt_89_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= konst_177_wire_constant;
      branch_instance: BranchBase -- 
        generic map( name => "do_while_stmt_89_branch", condition_width => 1,  bypass_flag => true)
        port map( -- 
          condition => condition_sig,
          req => do_while_stmt_89_branch_req_0,
          ack0 => do_while_stmt_89_branch_ack_0,
          ack1 => do_while_stmt_89_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- flow through binary operator CONCAT_u1_u33_148_inst
    process(R_ONE_1_146_wire_constant, input_word_97) -- 
      variable tmp_var : std_logic_vector(32 downto 0); -- 
    begin -- 
      ApConcat_proc(R_ONE_1_146_wire_constant, input_word_97, tmp_var);
      data_to_outport_149 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u16_u1_110_inst
    process(count_down_91) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(count_down_91, konst_109_wire_constant, tmp_var);
      new_packet_111 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_153_inst
    process(next_last_dest_id_144) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_last_dest_id_144, konst_152_wire_constant, tmp_var);
      send_to_1_154 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_162_inst
    process(next_last_dest_id_144) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_last_dest_id_144, konst_161_wire_constant, tmp_var);
      send_to_2_163 <= tmp_var; --
    end process;
    -- flow through binary operator SUB_u16_u16_133_inst
    SUB_u16_u16_133_wire <= std_logic_vector(unsigned(pkt_length_119) - unsigned(konst_132_wire_constant));
    -- flow through binary operator SUB_u16_u16_136_inst
    SUB_u16_u16_136_wire <= std_logic_vector(unsigned(count_down_91) - unsigned(konst_135_wire_constant));
    -- shared inport operator group (0) : RPIPE_in_data_1_99_inst 
    InportGroup_0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_in_data_1_99_inst_req_0;
      RPIPE_in_data_1_99_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_in_data_1_99_inst_req_1;
      RPIPE_in_data_1_99_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      RPIPE_in_data_1_99_wire <= data_out(31 downto 0);
      in_data_1_read_0_gI: SplitGuardInterface generic map(name => "in_data_1_read_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      in_data_1_read_0: InputPortRevised -- 
        generic map ( name => "in_data_1_read_0", data_width => 32,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => False,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => in_data_1_pipe_read_req(0),
          oack => in_data_1_pipe_read_ack(0),
          odata => in_data_1_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : WPIPE_noblock_obuf_1_1_156_inst 
    OutportGroup_0: Block -- 
      signal data_in: std_logic_vector(32 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_noblock_obuf_1_1_156_inst_req_0;
      WPIPE_noblock_obuf_1_1_156_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_noblock_obuf_1_1_156_inst_req_1;
      WPIPE_noblock_obuf_1_1_156_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_to_1_154(0);
      data_in <= data_to_outport_149;
      noblock_obuf_1_1_write_0_gI: SplitGuardInterface generic map(name => "noblock_obuf_1_1_write_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_1_1_write_0: OutputPortRevised -- 
        generic map ( name => "noblock_obuf_1_1", data_width => 33, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => noblock_obuf_1_1_pipe_write_req(0),
          oack => noblock_obuf_1_1_pipe_write_ack(0),
          odata => noblock_obuf_1_1_pipe_write_data(32 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- shared outport operator group (1) : WPIPE_noblock_obuf_1_2_165_inst 
    OutportGroup_1: Block -- 
      signal data_in: std_logic_vector(32 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_noblock_obuf_1_2_165_inst_req_0;
      WPIPE_noblock_obuf_1_2_165_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_noblock_obuf_1_2_165_inst_req_1;
      WPIPE_noblock_obuf_1_2_165_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_to_2_163(0);
      data_in <= data_to_outport_149;
      noblock_obuf_1_2_write_1_gI: SplitGuardInterface generic map(name => "noblock_obuf_1_2_write_1_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_1_2_write_1: OutputPortRevised -- 
        generic map ( name => "noblock_obuf_1_2", data_width => 33, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => noblock_obuf_1_2_pipe_write_req(0),
          oack => noblock_obuf_1_2_pipe_write_ack(0),
          odata => noblock_obuf_1_2_pipe_write_data(32 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 1
    -- 
  end Block; -- data_path
  -- 
end inputPort_1_Daemon_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.ahir_system_global_package.all;
entity inputPort_2_Daemon is -- 
  generic (tag_length : integer); 
  port ( -- 
    in_data_2_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_2_pipe_read_data : in   std_logic_vector(31 downto 0);
    noblock_obuf_2_1_pipe_write_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_2_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_2_1_pipe_write_data : out  std_logic_vector(32 downto 0);
    noblock_obuf_2_2_pipe_write_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_2_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_2_2_pipe_write_data : out  std_logic_vector(32 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) ;
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic-- 
  );
  -- 
end entity inputPort_2_Daemon;
architecture inputPort_2_Daemon_arch of inputPort_2_Daemon is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal inputPort_2_Daemon_CP_324_start: Boolean;
  signal inputPort_2_Daemon_CP_324_symbol: Boolean;
  -- volatile/operator module components. 
  -- links between control-path and data-path
  signal next_count_down_230_188_buf_req_0 : boolean;
  signal next_count_down_230_188_buf_ack_0 : boolean;
  signal next_count_down_230_188_buf_req_1 : boolean;
  signal next_count_down_230_188_buf_ack_1 : boolean;
  signal do_while_stmt_182_branch_req_0 : boolean;
  signal phi_stmt_184_req_1 : boolean;
  signal phi_stmt_184_req_0 : boolean;
  signal phi_stmt_184_ack_0 : boolean;
  signal RPIPE_in_data_2_191_inst_req_0 : boolean;
  signal RPIPE_in_data_2_191_inst_ack_0 : boolean;
  signal RPIPE_in_data_2_191_inst_req_1 : boolean;
  signal RPIPE_in_data_2_191_inst_ack_1 : boolean;
  signal phi_stmt_192_req_1 : boolean;
  signal phi_stmt_192_req_0 : boolean;
  signal phi_stmt_192_ack_0 : boolean;
  signal next_last_dest_id_236_195_buf_req_0 : boolean;
  signal next_last_dest_id_236_195_buf_ack_0 : boolean;
  signal next_last_dest_id_236_195_buf_req_1 : boolean;
  signal next_last_dest_id_236_195_buf_ack_1 : boolean;
  signal WPIPE_noblock_obuf_2_1_248_inst_req_0 : boolean;
  signal WPIPE_noblock_obuf_2_1_248_inst_ack_0 : boolean;
  signal WPIPE_noblock_obuf_2_1_248_inst_req_1 : boolean;
  signal WPIPE_noblock_obuf_2_1_248_inst_ack_1 : boolean;
  signal WPIPE_noblock_obuf_2_2_257_inst_req_0 : boolean;
  signal WPIPE_noblock_obuf_2_2_257_inst_ack_0 : boolean;
  signal WPIPE_noblock_obuf_2_2_257_inst_req_1 : boolean;
  signal WPIPE_noblock_obuf_2_2_257_inst_ack_1 : boolean;
  signal do_while_stmt_182_branch_ack_0 : boolean;
  signal do_while_stmt_182_branch_ack_1 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "inputPort_2_Daemon_input_buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj_in_buffer_unload_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  inputPort_2_Daemon_CP_324_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "inputPort_2_Daemon_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 0) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= inputPort_2_Daemon_CP_324_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj_out_buffer_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= inputPort_2_Daemon_CP_324_start & tag_ilock_write_ack_symbol;
    gj_tag_ilock_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= inputPort_2_Daemon_CP_324_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  inputPort_2_Daemon_CP_324: Block -- control-path 
    signal inputPort_2_Daemon_CP_324_elements: BooleanArray(67 downto 0);
    -- 
  begin -- 
    inputPort_2_Daemon_CP_324_elements(0) <= inputPort_2_Daemon_CP_324_start;
    inputPort_2_Daemon_CP_324_symbol <= inputPort_2_Daemon_CP_324_elements(1);
    -- CP-element group 0:  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	2 
    -- CP-element group 0:  members (4) 
      -- CP-element group 0: 	 $entry
      -- CP-element group 0: 	 branch_block_stmt_181/$entry
      -- CP-element group 0: 	 branch_block_stmt_181/branch_block_stmt_181__entry__
      -- CP-element group 0: 	 branch_block_stmt_181/do_while_stmt_182__entry__
      -- 
    -- CP-element group 1:  transition  place  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	67 
    -- CP-element group 1: successors 
    -- CP-element group 1:  members (4) 
      -- CP-element group 1: 	 $exit
      -- CP-element group 1: 	 branch_block_stmt_181/$exit
      -- CP-element group 1: 	 branch_block_stmt_181/branch_block_stmt_181__exit__
      -- CP-element group 1: 	 branch_block_stmt_181/do_while_stmt_182__exit__
      -- 
    inputPort_2_Daemon_CP_324_elements(1) <= inputPort_2_Daemon_CP_324_elements(67);
    -- CP-element group 2:  transition  place  bypass  pipeline-parent 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	0 
    -- CP-element group 2: successors 
    -- CP-element group 2: 	8 
    -- CP-element group 2:  members (2) 
      -- CP-element group 2: 	 branch_block_stmt_181/do_while_stmt_182/$entry
      -- CP-element group 2: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182__entry__
      -- 
    inputPort_2_Daemon_CP_324_elements(2) <= inputPort_2_Daemon_CP_324_elements(0);
    -- CP-element group 3:  merge  place  bypass  pipeline-parent 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	67 
    -- CP-element group 3:  members (1) 
      -- CP-element group 3: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182__exit__
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(3) is bound as output of CP function.
    -- CP-element group 4:  merge  place  bypass  pipeline-parent 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: successors 
    -- CP-element group 4: 	7 
    -- CP-element group 4:  members (1) 
      -- CP-element group 4: 	 branch_block_stmt_181/do_while_stmt_182/loop_back
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(4) is bound as output of CP function.
    -- CP-element group 5:  branch  transition  place  bypass  pipeline-parent 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	10 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	65 
    -- CP-element group 5: 	66 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_181/do_while_stmt_182/condition_done
      -- CP-element group 5: 	 branch_block_stmt_181/do_while_stmt_182/loop_exit/$entry
      -- CP-element group 5: 	 branch_block_stmt_181/do_while_stmt_182/loop_taken/$entry
      -- 
    inputPort_2_Daemon_CP_324_elements(5) <= inputPort_2_Daemon_CP_324_elements(10);
    -- CP-element group 6:  branch  place  bypass  pipeline-parent 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	64 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (1) 
      -- CP-element group 6: 	 branch_block_stmt_181/do_while_stmt_182/loop_body_done
      -- 
    inputPort_2_Daemon_CP_324_elements(6) <= inputPort_2_Daemon_CP_324_elements(64);
    -- CP-element group 7:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	4 
    -- CP-element group 7: successors 
    -- CP-element group 7: 	44 
    -- CP-element group 7: 	22 
    -- CP-element group 7:  members (1) 
      -- CP-element group 7: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/back_edge_to_loop_body
      -- 
    inputPort_2_Daemon_CP_324_elements(7) <= inputPort_2_Daemon_CP_324_elements(4);
    -- CP-element group 8:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	2 
    -- CP-element group 8: successors 
    -- CP-element group 8: 	46 
    -- CP-element group 8: 	24 
    -- CP-element group 8:  members (1) 
      -- CP-element group 8: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/first_time_through_loop_body
      -- 
    inputPort_2_Daemon_CP_324_elements(8) <= inputPort_2_Daemon_CP_324_elements(2);
    -- CP-element group 9:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	11 
    -- CP-element group 9: 	40 
    -- CP-element group 9: 	41 
    -- CP-element group 9: 	63 
    -- CP-element group 9: 	35 
    -- CP-element group 9: 	16 
    -- CP-element group 9: 	17 
    -- CP-element group 9:  members (3) 
      -- CP-element group 9: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/$entry
      -- CP-element group 9: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/loop_body_start
      -- CP-element group 9: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_189_sample_start_
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(9) is bound as output of CP function.
    -- CP-element group 10:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	13 
    -- CP-element group 10: 	63 
    -- CP-element group 10: 	15 
    -- CP-element group 10: successors 
    -- CP-element group 10: 	5 
    -- CP-element group 10:  members (1) 
      -- CP-element group 10: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/condition_evaluated
      -- 
    condition_evaluated_348_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " condition_evaluated_348_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(10), ack => do_while_stmt_182_branch_req_0); -- 
    inputPort_2_Daemon_cp_element_group_10: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_10"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(13) & inputPort_2_Daemon_CP_324_elements(63) & inputPort_2_Daemon_CP_324_elements(15);
      gj_inputPort_2_Daemon_cp_element_group_10 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(10), clk => clk, reset => reset); --
    end block;
    -- CP-element group 11:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	9 
    -- CP-element group 11: 	40 
    -- CP-element group 11: 	16 
    -- CP-element group 11: marked-predecessors 
    -- CP-element group 11: 	15 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	36 
    -- CP-element group 11: 	18 
    -- CP-element group 11:  members (2) 
      -- CP-element group 11: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/aggregated_phi_sample_req
      -- CP-element group 11: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_sample_start__ps
      -- 
    inputPort_2_Daemon_cp_element_group_11: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 7,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_11"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(9) & inputPort_2_Daemon_CP_324_elements(40) & inputPort_2_Daemon_CP_324_elements(16) & inputPort_2_Daemon_CP_324_elements(15);
      gj_inputPort_2_Daemon_cp_element_group_11 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(11), clk => clk, reset => reset); --
    end block;
    -- CP-element group 12:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	42 
    -- CP-element group 12: 	38 
    -- CP-element group 12: 	19 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	13 
    -- CP-element group 12: 	64 
    -- CP-element group 12: marked-successors 
    -- CP-element group 12: 	40 
    -- CP-element group 12: 	16 
    -- CP-element group 12:  members (4) 
      -- CP-element group 12: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/aggregated_phi_sample_ack
      -- CP-element group 12: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_189_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_sample_completed_
      -- 
    inputPort_2_Daemon_cp_element_group_12: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_12"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(42) & inputPort_2_Daemon_CP_324_elements(38) & inputPort_2_Daemon_CP_324_elements(19);
      gj_inputPort_2_Daemon_cp_element_group_12 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(12), clk => clk, reset => reset); --
    end block;
    -- CP-element group 13:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	12 
    -- CP-element group 13: successors 
    -- CP-element group 13: 	10 
    -- CP-element group 13:  members (1) 
      -- CP-element group 13: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/aggregated_phi_sample_ack_d
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(13) is a control-delay.
    cp_element_13_delay: control_delay_element  generic map(name => " 13_delay", delay_value => 1)  port map(req => inputPort_2_Daemon_CP_324_elements(12), ack => inputPort_2_Daemon_CP_324_elements(13), clk => clk, reset =>reset);
    -- CP-element group 14:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	41 
    -- CP-element group 14: 	35 
    -- CP-element group 14: 	17 
    -- CP-element group 14: successors 
    -- CP-element group 14: 	37 
    -- CP-element group 14: 	20 
    -- CP-element group 14:  members (2) 
      -- CP-element group 14: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/aggregated_phi_update_req
      -- CP-element group 14: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_update_start__ps
      -- 
    inputPort_2_Daemon_cp_element_group_14: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_14"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(41) & inputPort_2_Daemon_CP_324_elements(35) & inputPort_2_Daemon_CP_324_elements(17);
      gj_inputPort_2_Daemon_cp_element_group_14 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(14), clk => clk, reset => reset); --
    end block;
    -- CP-element group 15:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	43 
    -- CP-element group 15: 	39 
    -- CP-element group 15: 	21 
    -- CP-element group 15: successors 
    -- CP-element group 15: 	10 
    -- CP-element group 15: marked-successors 
    -- CP-element group 15: 	11 
    -- CP-element group 15:  members (1) 
      -- CP-element group 15: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/aggregated_phi_update_ack
      -- 
    inputPort_2_Daemon_cp_element_group_15: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_15"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(43) & inputPort_2_Daemon_CP_324_elements(39) & inputPort_2_Daemon_CP_324_elements(21);
      gj_inputPort_2_Daemon_cp_element_group_15 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(15), clk => clk, reset => reset); --
    end block;
    -- CP-element group 16:  join  transition  bypass  pipeline-parent 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	9 
    -- CP-element group 16: marked-predecessors 
    -- CP-element group 16: 	12 
    -- CP-element group 16: successors 
    -- CP-element group 16: 	11 
    -- CP-element group 16:  members (1) 
      -- CP-element group 16: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_sample_start_
      -- 
    inputPort_2_Daemon_cp_element_group_16: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_16"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(9) & inputPort_2_Daemon_CP_324_elements(12);
      gj_inputPort_2_Daemon_cp_element_group_16 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(16), clk => clk, reset => reset); --
    end block;
    -- CP-element group 17:  join  transition  bypass  pipeline-parent 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	9 
    -- CP-element group 17: marked-predecessors 
    -- CP-element group 17: 	58 
    -- CP-element group 17: 	61 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	14 
    -- CP-element group 17:  members (1) 
      -- CP-element group 17: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_update_start_
      -- 
    inputPort_2_Daemon_cp_element_group_17: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_17"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(9) & inputPort_2_Daemon_CP_324_elements(58) & inputPort_2_Daemon_CP_324_elements(61);
      gj_inputPort_2_Daemon_cp_element_group_17 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(17), clk => clk, reset => reset); --
    end block;
    -- CP-element group 18:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: 	11 
    -- CP-element group 18: successors 
    -- CP-element group 18:  members (1) 
      -- CP-element group 18: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_sample_start__ps
      -- 
    inputPort_2_Daemon_CP_324_elements(18) <= inputPort_2_Daemon_CP_324_elements(11);
    -- CP-element group 19:  join  transition  bypass  pipeline-parent 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	12 
    -- CP-element group 19:  members (1) 
      -- CP-element group 19: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_sample_completed__ps
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(19) is bound as output of CP function.
    -- CP-element group 20:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	14 
    -- CP-element group 20: successors 
    -- CP-element group 20:  members (1) 
      -- CP-element group 20: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_update_start__ps
      -- 
    inputPort_2_Daemon_CP_324_elements(20) <= inputPort_2_Daemon_CP_324_elements(14);
    -- CP-element group 21:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: successors 
    -- CP-element group 21: 	57 
    -- CP-element group 21: 	60 
    -- CP-element group 21: 	15 
    -- CP-element group 21:  members (2) 
      -- CP-element group 21: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_update_completed_
      -- CP-element group 21: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_update_completed__ps
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(21) is bound as output of CP function.
    -- CP-element group 22:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	7 
    -- CP-element group 22: successors 
    -- CP-element group 22:  members (1) 
      -- CP-element group 22: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_loopback_trigger
      -- 
    inputPort_2_Daemon_CP_324_elements(22) <= inputPort_2_Daemon_CP_324_elements(7);
    -- CP-element group 23:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: successors 
    -- CP-element group 23:  members (2) 
      -- CP-element group 23: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_loopback_sample_req
      -- CP-element group 23: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_loopback_sample_req_ps
      -- 
    phi_stmt_184_loopback_sample_req_364_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_184_loopback_sample_req_364_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(23), ack => phi_stmt_184_req_1); -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(23) is bound as output of CP function.
    -- CP-element group 24:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: 	8 
    -- CP-element group 24: successors 
    -- CP-element group 24:  members (1) 
      -- CP-element group 24: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_entry_trigger
      -- 
    inputPort_2_Daemon_CP_324_elements(24) <= inputPort_2_Daemon_CP_324_elements(8);
    -- CP-element group 25:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: successors 
    -- CP-element group 25:  members (2) 
      -- CP-element group 25: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_entry_sample_req
      -- CP-element group 25: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_entry_sample_req_ps
      -- 
    phi_stmt_184_entry_sample_req_367_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_184_entry_sample_req_367_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(25), ack => phi_stmt_184_req_0); -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(25) is bound as output of CP function.
    -- CP-element group 26:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 26: predecessors 
    -- CP-element group 26: successors 
    -- CP-element group 26:  members (2) 
      -- CP-element group 26: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_phi_mux_ack
      -- CP-element group 26: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_184_phi_mux_ack_ps
      -- 
    phi_stmt_184_phi_mux_ack_370_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 26_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_184_ack_0, ack => inputPort_2_Daemon_CP_324_elements(26)); -- 
    -- CP-element group 27:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 27: predecessors 
    -- CP-element group 27: successors 
    -- CP-element group 27:  members (4) 
      -- CP-element group 27: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/type_cast_187_sample_start__ps
      -- CP-element group 27: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/type_cast_187_sample_completed__ps
      -- CP-element group 27: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/type_cast_187_sample_start_
      -- CP-element group 27: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/type_cast_187_sample_completed_
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(27) is bound as output of CP function.
    -- CP-element group 28:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 28: predecessors 
    -- CP-element group 28: successors 
    -- CP-element group 28: 	30 
    -- CP-element group 28:  members (2) 
      -- CP-element group 28: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/type_cast_187_update_start__ps
      -- CP-element group 28: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/type_cast_187_update_start_
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(28) is bound as output of CP function.
    -- CP-element group 29:  join  transition  bypass  pipeline-parent 
    -- CP-element group 29: predecessors 
    -- CP-element group 29: 	30 
    -- CP-element group 29: successors 
    -- CP-element group 29:  members (1) 
      -- CP-element group 29: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/type_cast_187_update_completed__ps
      -- 
    inputPort_2_Daemon_CP_324_elements(29) <= inputPort_2_Daemon_CP_324_elements(30);
    -- CP-element group 30:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 30: predecessors 
    -- CP-element group 30: 	28 
    -- CP-element group 30: successors 
    -- CP-element group 30: 	29 
    -- CP-element group 30:  members (1) 
      -- CP-element group 30: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/type_cast_187_update_completed_
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(30) is a control-delay.
    cp_element_30_delay: control_delay_element  generic map(name => " 30_delay", delay_value => 1)  port map(req => inputPort_2_Daemon_CP_324_elements(28), ack => inputPort_2_Daemon_CP_324_elements(30), clk => clk, reset =>reset);
    -- CP-element group 31:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 31: predecessors 
    -- CP-element group 31: successors 
    -- CP-element group 31: 	33 
    -- CP-element group 31:  members (4) 
      -- CP-element group 31: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_sample_start__ps
      -- CP-element group 31: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_sample_start_
      -- CP-element group 31: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_Sample/$entry
      -- CP-element group 31: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_Sample/req
      -- 
    req_391_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_391_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(31), ack => next_count_down_230_188_buf_req_0); -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(31) is bound as output of CP function.
    -- CP-element group 32:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 32: predecessors 
    -- CP-element group 32: successors 
    -- CP-element group 32: 	34 
    -- CP-element group 32:  members (4) 
      -- CP-element group 32: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_update_start__ps
      -- CP-element group 32: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_update_start_
      -- CP-element group 32: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_Update/$entry
      -- CP-element group 32: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_Update/req
      -- 
    req_396_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_396_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(32), ack => next_count_down_230_188_buf_req_1); -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(32) is bound as output of CP function.
    -- CP-element group 33:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 33: predecessors 
    -- CP-element group 33: 	31 
    -- CP-element group 33: successors 
    -- CP-element group 33:  members (4) 
      -- CP-element group 33: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_sample_completed__ps
      -- CP-element group 33: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_sample_completed_
      -- CP-element group 33: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_Sample/$exit
      -- CP-element group 33: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_Sample/ack
      -- 
    ack_392_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 33_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_down_230_188_buf_ack_0, ack => inputPort_2_Daemon_CP_324_elements(33)); -- 
    -- CP-element group 34:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 34: predecessors 
    -- CP-element group 34: 	32 
    -- CP-element group 34: successors 
    -- CP-element group 34:  members (4) 
      -- CP-element group 34: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_update_completed__ps
      -- CP-element group 34: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_update_completed_
      -- CP-element group 34: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_Update/$exit
      -- CP-element group 34: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_count_down_188_Update/ack
      -- 
    ack_397_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 34_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_down_230_188_buf_ack_1, ack => inputPort_2_Daemon_CP_324_elements(34)); -- 
    -- CP-element group 35:  join  transition  bypass  pipeline-parent 
    -- CP-element group 35: predecessors 
    -- CP-element group 35: 	9 
    -- CP-element group 35: marked-predecessors 
    -- CP-element group 35: 	58 
    -- CP-element group 35: 	61 
    -- CP-element group 35: successors 
    -- CP-element group 35: 	14 
    -- CP-element group 35:  members (1) 
      -- CP-element group 35: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_189_update_start_
      -- 
    inputPort_2_Daemon_cp_element_group_35: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_35"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(9) & inputPort_2_Daemon_CP_324_elements(58) & inputPort_2_Daemon_CP_324_elements(61);
      gj_inputPort_2_Daemon_cp_element_group_35 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(35), clk => clk, reset => reset); --
    end block;
    -- CP-element group 36:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 36: predecessors 
    -- CP-element group 36: 	11 
    -- CP-element group 36: marked-predecessors 
    -- CP-element group 36: 	39 
    -- CP-element group 36: successors 
    -- CP-element group 36: 	38 
    -- CP-element group 36:  members (3) 
      -- CP-element group 36: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_sample_start_
      -- CP-element group 36: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_Sample/$entry
      -- CP-element group 36: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_Sample/rr
      -- 
    rr_410_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_410_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(36), ack => RPIPE_in_data_2_191_inst_req_0); -- 
    inputPort_2_Daemon_cp_element_group_36: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_36"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(11) & inputPort_2_Daemon_CP_324_elements(39);
      gj_inputPort_2_Daemon_cp_element_group_36 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(36), clk => clk, reset => reset); --
    end block;
    -- CP-element group 37:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 37: predecessors 
    -- CP-element group 37: 	14 
    -- CP-element group 37: 	38 
    -- CP-element group 37: successors 
    -- CP-element group 37: 	39 
    -- CP-element group 37:  members (3) 
      -- CP-element group 37: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_update_start_
      -- CP-element group 37: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_Update/$entry
      -- CP-element group 37: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_Update/cr
      -- 
    cr_415_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_415_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(37), ack => RPIPE_in_data_2_191_inst_req_1); -- 
    inputPort_2_Daemon_cp_element_group_37: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_37"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(14) & inputPort_2_Daemon_CP_324_elements(38);
      gj_inputPort_2_Daemon_cp_element_group_37 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(37), clk => clk, reset => reset); --
    end block;
    -- CP-element group 38:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 38: predecessors 
    -- CP-element group 38: 	36 
    -- CP-element group 38: successors 
    -- CP-element group 38: 	12 
    -- CP-element group 38: 	37 
    -- CP-element group 38:  members (3) 
      -- CP-element group 38: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_sample_completed_
      -- CP-element group 38: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_Sample/$exit
      -- CP-element group 38: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_Sample/ra
      -- 
    ra_411_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 38_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_2_191_inst_ack_0, ack => inputPort_2_Daemon_CP_324_elements(38)); -- 
    -- CP-element group 39:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 39: predecessors 
    -- CP-element group 39: 	37 
    -- CP-element group 39: successors 
    -- CP-element group 39: 	57 
    -- CP-element group 39: 	60 
    -- CP-element group 39: 	15 
    -- CP-element group 39: marked-successors 
    -- CP-element group 39: 	36 
    -- CP-element group 39:  members (4) 
      -- CP-element group 39: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_189_update_completed_
      -- CP-element group 39: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_update_completed_
      -- CP-element group 39: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_Update/$exit
      -- CP-element group 39: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/RPIPE_in_data_2_191_Update/ca
      -- 
    ca_416_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 39_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_2_191_inst_ack_1, ack => inputPort_2_Daemon_CP_324_elements(39)); -- 
    -- CP-element group 40:  join  transition  bypass  pipeline-parent 
    -- CP-element group 40: predecessors 
    -- CP-element group 40: 	9 
    -- CP-element group 40: marked-predecessors 
    -- CP-element group 40: 	12 
    -- CP-element group 40: successors 
    -- CP-element group 40: 	11 
    -- CP-element group 40:  members (1) 
      -- CP-element group 40: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_sample_start_
      -- 
    inputPort_2_Daemon_cp_element_group_40: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_40"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(9) & inputPort_2_Daemon_CP_324_elements(12);
      gj_inputPort_2_Daemon_cp_element_group_40 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(40), clk => clk, reset => reset); --
    end block;
    -- CP-element group 41:  join  transition  bypass  pipeline-parent 
    -- CP-element group 41: predecessors 
    -- CP-element group 41: 	9 
    -- CP-element group 41: marked-predecessors 
    -- CP-element group 41: 	58 
    -- CP-element group 41: 	61 
    -- CP-element group 41: successors 
    -- CP-element group 41: 	14 
    -- CP-element group 41:  members (1) 
      -- CP-element group 41: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_update_start_
      -- 
    inputPort_2_Daemon_cp_element_group_41: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_41"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(9) & inputPort_2_Daemon_CP_324_elements(58) & inputPort_2_Daemon_CP_324_elements(61);
      gj_inputPort_2_Daemon_cp_element_group_41 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(41), clk => clk, reset => reset); --
    end block;
    -- CP-element group 42:  join  transition  bypass  pipeline-parent 
    -- CP-element group 42: predecessors 
    -- CP-element group 42: successors 
    -- CP-element group 42: 	12 
    -- CP-element group 42:  members (1) 
      -- CP-element group 42: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_sample_completed__ps
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(42) is bound as output of CP function.
    -- CP-element group 43:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 43: predecessors 
    -- CP-element group 43: successors 
    -- CP-element group 43: 	57 
    -- CP-element group 43: 	60 
    -- CP-element group 43: 	15 
    -- CP-element group 43:  members (2) 
      -- CP-element group 43: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_update_completed_
      -- CP-element group 43: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_update_completed__ps
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(43) is bound as output of CP function.
    -- CP-element group 44:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 44: predecessors 
    -- CP-element group 44: 	7 
    -- CP-element group 44: successors 
    -- CP-element group 44:  members (1) 
      -- CP-element group 44: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_loopback_trigger
      -- 
    inputPort_2_Daemon_CP_324_elements(44) <= inputPort_2_Daemon_CP_324_elements(7);
    -- CP-element group 45:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 45: predecessors 
    -- CP-element group 45: successors 
    -- CP-element group 45:  members (2) 
      -- CP-element group 45: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_loopback_sample_req
      -- CP-element group 45: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_loopback_sample_req_ps
      -- 
    phi_stmt_192_loopback_sample_req_426_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_192_loopback_sample_req_426_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(45), ack => phi_stmt_192_req_1); -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(45) is bound as output of CP function.
    -- CP-element group 46:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 46: predecessors 
    -- CP-element group 46: 	8 
    -- CP-element group 46: successors 
    -- CP-element group 46:  members (1) 
      -- CP-element group 46: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_entry_trigger
      -- 
    inputPort_2_Daemon_CP_324_elements(46) <= inputPort_2_Daemon_CP_324_elements(8);
    -- CP-element group 47:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 47: predecessors 
    -- CP-element group 47: successors 
    -- CP-element group 47:  members (2) 
      -- CP-element group 47: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_entry_sample_req
      -- CP-element group 47: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_entry_sample_req_ps
      -- 
    phi_stmt_192_entry_sample_req_429_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_192_entry_sample_req_429_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(47), ack => phi_stmt_192_req_0); -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(47) is bound as output of CP function.
    -- CP-element group 48:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 48: predecessors 
    -- CP-element group 48: successors 
    -- CP-element group 48:  members (2) 
      -- CP-element group 48: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_phi_mux_ack
      -- CP-element group 48: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/phi_stmt_192_phi_mux_ack_ps
      -- 
    phi_stmt_192_phi_mux_ack_432_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 48_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_192_ack_0, ack => inputPort_2_Daemon_CP_324_elements(48)); -- 
    -- CP-element group 49:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 49: predecessors 
    -- CP-element group 49: successors 
    -- CP-element group 49:  members (4) 
      -- CP-element group 49: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/konst_194_sample_start__ps
      -- CP-element group 49: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/konst_194_sample_completed__ps
      -- CP-element group 49: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/konst_194_sample_start_
      -- CP-element group 49: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/konst_194_sample_completed_
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(49) is bound as output of CP function.
    -- CP-element group 50:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 50: predecessors 
    -- CP-element group 50: successors 
    -- CP-element group 50: 	52 
    -- CP-element group 50:  members (2) 
      -- CP-element group 50: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/konst_194_update_start__ps
      -- CP-element group 50: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/konst_194_update_start_
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(50) is bound as output of CP function.
    -- CP-element group 51:  join  transition  bypass  pipeline-parent 
    -- CP-element group 51: predecessors 
    -- CP-element group 51: 	52 
    -- CP-element group 51: successors 
    -- CP-element group 51:  members (1) 
      -- CP-element group 51: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/konst_194_update_completed__ps
      -- 
    inputPort_2_Daemon_CP_324_elements(51) <= inputPort_2_Daemon_CP_324_elements(52);
    -- CP-element group 52:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 52: predecessors 
    -- CP-element group 52: 	50 
    -- CP-element group 52: successors 
    -- CP-element group 52: 	51 
    -- CP-element group 52:  members (1) 
      -- CP-element group 52: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/konst_194_update_completed_
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(52) is a control-delay.
    cp_element_52_delay: control_delay_element  generic map(name => " 52_delay", delay_value => 1)  port map(req => inputPort_2_Daemon_CP_324_elements(50), ack => inputPort_2_Daemon_CP_324_elements(52), clk => clk, reset =>reset);
    -- CP-element group 53:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 53: predecessors 
    -- CP-element group 53: successors 
    -- CP-element group 53: 	55 
    -- CP-element group 53:  members (4) 
      -- CP-element group 53: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_sample_start__ps
      -- CP-element group 53: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_sample_start_
      -- CP-element group 53: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_Sample/$entry
      -- CP-element group 53: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_Sample/req
      -- 
    req_453_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_453_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(53), ack => next_last_dest_id_236_195_buf_req_0); -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(53) is bound as output of CP function.
    -- CP-element group 54:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 54: predecessors 
    -- CP-element group 54: successors 
    -- CP-element group 54: 	56 
    -- CP-element group 54:  members (4) 
      -- CP-element group 54: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_update_start__ps
      -- CP-element group 54: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_update_start_
      -- CP-element group 54: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_Update/$entry
      -- CP-element group 54: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_Update/req
      -- 
    req_458_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_458_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(54), ack => next_last_dest_id_236_195_buf_req_1); -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(54) is bound as output of CP function.
    -- CP-element group 55:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 55: predecessors 
    -- CP-element group 55: 	53 
    -- CP-element group 55: successors 
    -- CP-element group 55:  members (4) 
      -- CP-element group 55: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_sample_completed__ps
      -- CP-element group 55: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_sample_completed_
      -- CP-element group 55: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_Sample/$exit
      -- CP-element group 55: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_Sample/ack
      -- 
    ack_454_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 55_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_last_dest_id_236_195_buf_ack_0, ack => inputPort_2_Daemon_CP_324_elements(55)); -- 
    -- CP-element group 56:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 56: predecessors 
    -- CP-element group 56: 	54 
    -- CP-element group 56: successors 
    -- CP-element group 56:  members (4) 
      -- CP-element group 56: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_update_completed__ps
      -- CP-element group 56: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_update_completed_
      -- CP-element group 56: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_Update/$exit
      -- CP-element group 56: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/R_next_last_dest_id_195_Update/ack
      -- 
    ack_459_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 56_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_last_dest_id_236_195_buf_ack_1, ack => inputPort_2_Daemon_CP_324_elements(56)); -- 
    -- CP-element group 57:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 57: predecessors 
    -- CP-element group 57: 	43 
    -- CP-element group 57: 	39 
    -- CP-element group 57: 	21 
    -- CP-element group 57: marked-predecessors 
    -- CP-element group 57: 	59 
    -- CP-element group 57: successors 
    -- CP-element group 57: 	58 
    -- CP-element group 57:  members (3) 
      -- CP-element group 57: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_sample_start_
      -- CP-element group 57: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_Sample/$entry
      -- CP-element group 57: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_Sample/req
      -- 
    req_468_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_468_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(57), ack => WPIPE_noblock_obuf_2_1_248_inst_req_0); -- 
    inputPort_2_Daemon_cp_element_group_57: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_57"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(43) & inputPort_2_Daemon_CP_324_elements(39) & inputPort_2_Daemon_CP_324_elements(21) & inputPort_2_Daemon_CP_324_elements(59);
      gj_inputPort_2_Daemon_cp_element_group_57 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(57), clk => clk, reset => reset); --
    end block;
    -- CP-element group 58:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 58: predecessors 
    -- CP-element group 58: 	57 
    -- CP-element group 58: successors 
    -- CP-element group 58: 	59 
    -- CP-element group 58: marked-successors 
    -- CP-element group 58: 	41 
    -- CP-element group 58: 	35 
    -- CP-element group 58: 	17 
    -- CP-element group 58:  members (6) 
      -- CP-element group 58: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_sample_completed_
      -- CP-element group 58: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_update_start_
      -- CP-element group 58: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_Sample/$exit
      -- CP-element group 58: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_Sample/ack
      -- CP-element group 58: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_Update/$entry
      -- CP-element group 58: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_Update/req
      -- 
    ack_469_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 58_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_2_1_248_inst_ack_0, ack => inputPort_2_Daemon_CP_324_elements(58)); -- 
    req_473_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_473_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(58), ack => WPIPE_noblock_obuf_2_1_248_inst_req_1); -- 
    -- CP-element group 59:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 59: predecessors 
    -- CP-element group 59: 	58 
    -- CP-element group 59: successors 
    -- CP-element group 59: 	64 
    -- CP-element group 59: marked-successors 
    -- CP-element group 59: 	57 
    -- CP-element group 59:  members (3) 
      -- CP-element group 59: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_update_completed_
      -- CP-element group 59: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_Update/$exit
      -- CP-element group 59: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_1_248_Update/ack
      -- 
    ack_474_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 59_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_2_1_248_inst_ack_1, ack => inputPort_2_Daemon_CP_324_elements(59)); -- 
    -- CP-element group 60:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 60: predecessors 
    -- CP-element group 60: 	43 
    -- CP-element group 60: 	39 
    -- CP-element group 60: 	21 
    -- CP-element group 60: marked-predecessors 
    -- CP-element group 60: 	62 
    -- CP-element group 60: successors 
    -- CP-element group 60: 	61 
    -- CP-element group 60:  members (3) 
      -- CP-element group 60: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_sample_start_
      -- CP-element group 60: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_Sample/$entry
      -- CP-element group 60: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_Sample/req
      -- 
    req_482_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_482_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(60), ack => WPIPE_noblock_obuf_2_2_257_inst_req_0); -- 
    inputPort_2_Daemon_cp_element_group_60: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_60"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(43) & inputPort_2_Daemon_CP_324_elements(39) & inputPort_2_Daemon_CP_324_elements(21) & inputPort_2_Daemon_CP_324_elements(62);
      gj_inputPort_2_Daemon_cp_element_group_60 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(60), clk => clk, reset => reset); --
    end block;
    -- CP-element group 61:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 61: predecessors 
    -- CP-element group 61: 	60 
    -- CP-element group 61: successors 
    -- CP-element group 61: 	62 
    -- CP-element group 61: marked-successors 
    -- CP-element group 61: 	41 
    -- CP-element group 61: 	35 
    -- CP-element group 61: 	17 
    -- CP-element group 61:  members (6) 
      -- CP-element group 61: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_sample_completed_
      -- CP-element group 61: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_update_start_
      -- CP-element group 61: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_Sample/$exit
      -- CP-element group 61: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_Sample/ack
      -- CP-element group 61: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_Update/$entry
      -- CP-element group 61: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_Update/req
      -- 
    ack_483_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 61_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_2_2_257_inst_ack_0, ack => inputPort_2_Daemon_CP_324_elements(61)); -- 
    req_487_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_487_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_324_elements(61), ack => WPIPE_noblock_obuf_2_2_257_inst_req_1); -- 
    -- CP-element group 62:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 62: predecessors 
    -- CP-element group 62: 	61 
    -- CP-element group 62: successors 
    -- CP-element group 62: 	64 
    -- CP-element group 62: marked-successors 
    -- CP-element group 62: 	60 
    -- CP-element group 62:  members (3) 
      -- CP-element group 62: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_update_completed_
      -- CP-element group 62: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_Update/$exit
      -- CP-element group 62: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/WPIPE_noblock_obuf_2_2_257_Update/ack
      -- 
    ack_488_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 62_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_2_2_257_inst_ack_1, ack => inputPort_2_Daemon_CP_324_elements(62)); -- 
    -- CP-element group 63:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 63: predecessors 
    -- CP-element group 63: 	9 
    -- CP-element group 63: successors 
    -- CP-element group 63: 	10 
    -- CP-element group 63:  members (1) 
      -- CP-element group 63: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/loop_body_delay_to_condition_start
      -- 
    -- Element group inputPort_2_Daemon_CP_324_elements(63) is a control-delay.
    cp_element_63_delay: control_delay_element  generic map(name => " 63_delay", delay_value => 1)  port map(req => inputPort_2_Daemon_CP_324_elements(9), ack => inputPort_2_Daemon_CP_324_elements(63), clk => clk, reset =>reset);
    -- CP-element group 64:  join  transition  bypass  pipeline-parent 
    -- CP-element group 64: predecessors 
    -- CP-element group 64: 	12 
    -- CP-element group 64: 	59 
    -- CP-element group 64: 	62 
    -- CP-element group 64: successors 
    -- CP-element group 64: 	6 
    -- CP-element group 64:  members (1) 
      -- CP-element group 64: 	 branch_block_stmt_181/do_while_stmt_182/do_while_stmt_182_loop_body/$exit
      -- 
    inputPort_2_Daemon_cp_element_group_64: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_64"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_324_elements(12) & inputPort_2_Daemon_CP_324_elements(59) & inputPort_2_Daemon_CP_324_elements(62);
      gj_inputPort_2_Daemon_cp_element_group_64 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(64), clk => clk, reset => reset); --
    end block;
    -- CP-element group 65:  transition  input  bypass  pipeline-parent 
    -- CP-element group 65: predecessors 
    -- CP-element group 65: 	5 
    -- CP-element group 65: successors 
    -- CP-element group 65:  members (2) 
      -- CP-element group 65: 	 branch_block_stmt_181/do_while_stmt_182/loop_exit/$exit
      -- CP-element group 65: 	 branch_block_stmt_181/do_while_stmt_182/loop_exit/ack
      -- 
    ack_493_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 65_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_182_branch_ack_0, ack => inputPort_2_Daemon_CP_324_elements(65)); -- 
    -- CP-element group 66:  transition  input  bypass  pipeline-parent 
    -- CP-element group 66: predecessors 
    -- CP-element group 66: 	5 
    -- CP-element group 66: successors 
    -- CP-element group 66:  members (2) 
      -- CP-element group 66: 	 branch_block_stmt_181/do_while_stmt_182/loop_taken/$exit
      -- CP-element group 66: 	 branch_block_stmt_181/do_while_stmt_182/loop_taken/ack
      -- 
    ack_497_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 66_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_182_branch_ack_1, ack => inputPort_2_Daemon_CP_324_elements(66)); -- 
    -- CP-element group 67:  transition  bypass  pipeline-parent 
    -- CP-element group 67: predecessors 
    -- CP-element group 67: 	3 
    -- CP-element group 67: successors 
    -- CP-element group 67: 	1 
    -- CP-element group 67:  members (1) 
      -- CP-element group 67: 	 branch_block_stmt_181/do_while_stmt_182/$exit
      -- 
    inputPort_2_Daemon_CP_324_elements(67) <= inputPort_2_Daemon_CP_324_elements(3);
    inputPort_2_Daemon_do_while_stmt_182_terminator_498: loop_terminator -- 
      generic map (name => " inputPort_2_Daemon_do_while_stmt_182_terminator_498", max_iterations_in_flight =>7) 
      port map(loop_body_exit => inputPort_2_Daemon_CP_324_elements(6),loop_continue => inputPort_2_Daemon_CP_324_elements(66),loop_terminate => inputPort_2_Daemon_CP_324_elements(65),loop_back => inputPort_2_Daemon_CP_324_elements(4),loop_exit => inputPort_2_Daemon_CP_324_elements(3),clk => clk, reset => reset); -- 
    phi_stmt_184_phi_seq_398_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= inputPort_2_Daemon_CP_324_elements(24);
      inputPort_2_Daemon_CP_324_elements(27)<= src_sample_reqs(0);
      src_sample_acks(0)  <= inputPort_2_Daemon_CP_324_elements(27);
      inputPort_2_Daemon_CP_324_elements(28)<= src_update_reqs(0);
      src_update_acks(0)  <= inputPort_2_Daemon_CP_324_elements(29);
      inputPort_2_Daemon_CP_324_elements(25) <= phi_mux_reqs(0);
      triggers(1)  <= inputPort_2_Daemon_CP_324_elements(22);
      inputPort_2_Daemon_CP_324_elements(31)<= src_sample_reqs(1);
      src_sample_acks(1)  <= inputPort_2_Daemon_CP_324_elements(33);
      inputPort_2_Daemon_CP_324_elements(32)<= src_update_reqs(1);
      src_update_acks(1)  <= inputPort_2_Daemon_CP_324_elements(34);
      inputPort_2_Daemon_CP_324_elements(23) <= phi_mux_reqs(1);
      phi_stmt_184_phi_seq_398 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_184_phi_seq_398") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => inputPort_2_Daemon_CP_324_elements(18), 
          phi_sample_ack => inputPort_2_Daemon_CP_324_elements(19), 
          phi_update_req => inputPort_2_Daemon_CP_324_elements(20), 
          phi_update_ack => inputPort_2_Daemon_CP_324_elements(21), 
          phi_mux_ack => inputPort_2_Daemon_CP_324_elements(26), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_192_phi_seq_460_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= inputPort_2_Daemon_CP_324_elements(46);
      inputPort_2_Daemon_CP_324_elements(49)<= src_sample_reqs(0);
      src_sample_acks(0)  <= inputPort_2_Daemon_CP_324_elements(49);
      inputPort_2_Daemon_CP_324_elements(50)<= src_update_reqs(0);
      src_update_acks(0)  <= inputPort_2_Daemon_CP_324_elements(51);
      inputPort_2_Daemon_CP_324_elements(47) <= phi_mux_reqs(0);
      triggers(1)  <= inputPort_2_Daemon_CP_324_elements(44);
      inputPort_2_Daemon_CP_324_elements(53)<= src_sample_reqs(1);
      src_sample_acks(1)  <= inputPort_2_Daemon_CP_324_elements(55);
      inputPort_2_Daemon_CP_324_elements(54)<= src_update_reqs(1);
      src_update_acks(1)  <= inputPort_2_Daemon_CP_324_elements(56);
      inputPort_2_Daemon_CP_324_elements(45) <= phi_mux_reqs(1);
      phi_stmt_192_phi_seq_460 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_192_phi_seq_460") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => inputPort_2_Daemon_CP_324_elements(11), 
          phi_sample_ack => inputPort_2_Daemon_CP_324_elements(42), 
          phi_update_req => inputPort_2_Daemon_CP_324_elements(14), 
          phi_update_ack => inputPort_2_Daemon_CP_324_elements(43), 
          phi_mux_ack => inputPort_2_Daemon_CP_324_elements(48), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    entry_tmerge_349_block : block -- 
      signal preds : BooleanArray(0 to 1);
      begin -- 
        preds(0)  <= inputPort_2_Daemon_CP_324_elements(7);
        preds(1)  <= inputPort_2_Daemon_CP_324_elements(8);
        entry_tmerge_349 : transition_merge -- 
          generic map(name => " entry_tmerge_349")
          port map (preds => preds, symbol_out => inputPort_2_Daemon_CP_324_elements(9));
          -- 
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal RPIPE_in_data_2_191_wire : std_logic_vector(31 downto 0);
    signal R_ONE_1_238_wire_constant : std_logic_vector(0 downto 0);
    signal SUB_u16_u16_225_wire : std_logic_vector(15 downto 0);
    signal SUB_u16_u16_228_wire : std_logic_vector(15 downto 0);
    signal count_down_184 : std_logic_vector(15 downto 0);
    signal data_to_outport_241 : std_logic_vector(32 downto 0);
    signal dest_id_207 : std_logic_vector(7 downto 0);
    signal input_word_189 : std_logic_vector(31 downto 0);
    signal konst_194_wire_constant : std_logic_vector(7 downto 0);
    signal konst_201_wire_constant : std_logic_vector(15 downto 0);
    signal konst_224_wire_constant : std_logic_vector(15 downto 0);
    signal konst_227_wire_constant : std_logic_vector(15 downto 0);
    signal konst_244_wire_constant : std_logic_vector(7 downto 0);
    signal konst_253_wire_constant : std_logic_vector(7 downto 0);
    signal konst_269_wire_constant : std_logic_vector(0 downto 0);
    signal last_dest_id_192 : std_logic_vector(7 downto 0);
    signal new_packet_203 : std_logic_vector(0 downto 0);
    signal next_count_down_230 : std_logic_vector(15 downto 0);
    signal next_count_down_230_188_buffered : std_logic_vector(15 downto 0);
    signal next_last_dest_id_236 : std_logic_vector(7 downto 0);
    signal next_last_dest_id_236_195_buffered : std_logic_vector(7 downto 0);
    signal pkt_length_211 : std_logic_vector(15 downto 0);
    signal send_to_1_246 : std_logic_vector(0 downto 0);
    signal send_to_2_255 : std_logic_vector(0 downto 0);
    signal seq_id_215 : std_logic_vector(7 downto 0);
    signal type_cast_187_wire_constant : std_logic_vector(15 downto 0);
    -- 
  begin -- 
    R_ONE_1_238_wire_constant <= "1";
    konst_194_wire_constant <= "00000000";
    konst_201_wire_constant <= "0000000000000000";
    konst_224_wire_constant <= "0000000000000001";
    konst_227_wire_constant <= "0000000000000001";
    konst_244_wire_constant <= "00000001";
    konst_253_wire_constant <= "00000010";
    konst_269_wire_constant <= "1";
    type_cast_187_wire_constant <= "0000000000000000";
    phi_stmt_184: Block -- phi operator 
      signal idata: std_logic_vector(31 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_187_wire_constant & next_count_down_230_188_buffered;
      req <= phi_stmt_184_req_0 & phi_stmt_184_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_184",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 16) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_184_ack_0,
          idata => idata,
          odata => count_down_184,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_184
    phi_stmt_192: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= konst_194_wire_constant & next_last_dest_id_236_195_buffered;
      req <= phi_stmt_192_req_0 & phi_stmt_192_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_192",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_192_ack_0,
          idata => idata,
          odata => last_dest_id_192,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_192
    -- flow-through select operator MUX_229_inst
    next_count_down_230 <= SUB_u16_u16_225_wire when (new_packet_203(0) /=  '0') else SUB_u16_u16_228_wire;
    -- flow-through select operator MUX_235_inst
    next_last_dest_id_236 <= dest_id_207 when (new_packet_203(0) /=  '0') else last_dest_id_192;
    -- flow-through slice operator slice_206_inst
    dest_id_207 <= input_word_189(31 downto 24);
    -- flow-through slice operator slice_210_inst
    pkt_length_211 <= input_word_189(23 downto 8);
    -- flow-through slice operator slice_214_inst
    seq_id_215 <= input_word_189(7 downto 0);
    next_count_down_230_188_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_count_down_230_188_buf_req_0;
      next_count_down_230_188_buf_ack_0<= wack(0);
      rreq(0) <= next_count_down_230_188_buf_req_1;
      next_count_down_230_188_buf_ack_1<= rack(0);
      next_count_down_230_188_buf : InterlockBuffer generic map ( -- 
        name => "next_count_down_230_188_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 16,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_count_down_230,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_count_down_230_188_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_last_dest_id_236_195_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_last_dest_id_236_195_buf_req_0;
      next_last_dest_id_236_195_buf_ack_0<= wack(0);
      rreq(0) <= next_last_dest_id_236_195_buf_req_1;
      next_last_dest_id_236_195_buf_ack_1<= rack(0);
      next_last_dest_id_236_195_buf : InterlockBuffer generic map ( -- 
        name => "next_last_dest_id_236_195_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_last_dest_id_236,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_last_dest_id_236_195_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    -- interlock ssrc_phi_stmt_189
    process(RPIPE_in_data_2_191_wire) -- 
      variable tmp_var : std_logic_vector(31 downto 0); -- 
    begin -- 
      tmp_var := (others => '0'); 
      tmp_var( 31 downto 0) := RPIPE_in_data_2_191_wire(31 downto 0);
      input_word_189 <= tmp_var; -- 
    end process;
    do_while_stmt_182_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= konst_269_wire_constant;
      branch_instance: BranchBase -- 
        generic map( name => "do_while_stmt_182_branch", condition_width => 1,  bypass_flag => true)
        port map( -- 
          condition => condition_sig,
          req => do_while_stmt_182_branch_req_0,
          ack0 => do_while_stmt_182_branch_ack_0,
          ack1 => do_while_stmt_182_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- flow through binary operator CONCAT_u1_u33_240_inst
    process(R_ONE_1_238_wire_constant, input_word_189) -- 
      variable tmp_var : std_logic_vector(32 downto 0); -- 
    begin -- 
      ApConcat_proc(R_ONE_1_238_wire_constant, input_word_189, tmp_var);
      data_to_outport_241 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u16_u1_202_inst
    process(count_down_184) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(count_down_184, konst_201_wire_constant, tmp_var);
      new_packet_203 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_245_inst
    process(next_last_dest_id_236) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_last_dest_id_236, konst_244_wire_constant, tmp_var);
      send_to_1_246 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_254_inst
    process(next_last_dest_id_236) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_last_dest_id_236, konst_253_wire_constant, tmp_var);
      send_to_2_255 <= tmp_var; --
    end process;
    -- flow through binary operator SUB_u16_u16_225_inst
    SUB_u16_u16_225_wire <= std_logic_vector(unsigned(pkt_length_211) - unsigned(konst_224_wire_constant));
    -- flow through binary operator SUB_u16_u16_228_inst
    SUB_u16_u16_228_wire <= std_logic_vector(unsigned(count_down_184) - unsigned(konst_227_wire_constant));
    -- shared inport operator group (0) : RPIPE_in_data_2_191_inst 
    InportGroup_0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_in_data_2_191_inst_req_0;
      RPIPE_in_data_2_191_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_in_data_2_191_inst_req_1;
      RPIPE_in_data_2_191_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      RPIPE_in_data_2_191_wire <= data_out(31 downto 0);
      in_data_2_read_0_gI: SplitGuardInterface generic map(name => "in_data_2_read_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      in_data_2_read_0: InputPortRevised -- 
        generic map ( name => "in_data_2_read_0", data_width => 32,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => False,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => in_data_2_pipe_read_req(0),
          oack => in_data_2_pipe_read_ack(0),
          odata => in_data_2_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : WPIPE_noblock_obuf_2_1_248_inst 
    OutportGroup_0: Block -- 
      signal data_in: std_logic_vector(32 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_noblock_obuf_2_1_248_inst_req_0;
      WPIPE_noblock_obuf_2_1_248_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_noblock_obuf_2_1_248_inst_req_1;
      WPIPE_noblock_obuf_2_1_248_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_to_1_246(0);
      data_in <= data_to_outport_241;
      noblock_obuf_2_1_write_0_gI: SplitGuardInterface generic map(name => "noblock_obuf_2_1_write_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_2_1_write_0: OutputPortRevised -- 
        generic map ( name => "noblock_obuf_2_1", data_width => 33, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => noblock_obuf_2_1_pipe_write_req(0),
          oack => noblock_obuf_2_1_pipe_write_ack(0),
          odata => noblock_obuf_2_1_pipe_write_data(32 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- shared outport operator group (1) : WPIPE_noblock_obuf_2_2_257_inst 
    OutportGroup_1: Block -- 
      signal data_in: std_logic_vector(32 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_noblock_obuf_2_2_257_inst_req_0;
      WPIPE_noblock_obuf_2_2_257_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_noblock_obuf_2_2_257_inst_req_1;
      WPIPE_noblock_obuf_2_2_257_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_to_2_255(0);
      data_in <= data_to_outport_241;
      noblock_obuf_2_2_write_1_gI: SplitGuardInterface generic map(name => "noblock_obuf_2_2_write_1_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_2_2_write_1: OutputPortRevised -- 
        generic map ( name => "noblock_obuf_2_2", data_width => 33, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => noblock_obuf_2_2_pipe_write_req(0),
          oack => noblock_obuf_2_2_pipe_write_ack(0),
          odata => noblock_obuf_2_2_pipe_write_data(32 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 1
    -- 
  end Block; -- data_path
  -- 
end inputPort_2_Daemon_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.ahir_system_global_package.all;
entity outputPort_1_Daemon is -- 
  generic (tag_length : integer); 
  port ( -- 
    noblock_obuf_2_1_pipe_read_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_2_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_2_1_pipe_read_data : in   std_logic_vector(32 downto 0);
    noblock_obuf_1_1_pipe_read_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_1_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_1_1_pipe_read_data : in   std_logic_vector(32 downto 0);
    out_data_1_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_data_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_data_1_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) ;
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic-- 
  );
  -- 
end entity outputPort_1_Daemon;
architecture outputPort_1_Daemon_arch of outputPort_1_Daemon is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal outputPort_1_Daemon_CP_502_start: Boolean;
  signal outputPort_1_Daemon_CP_502_symbol: Boolean;
  -- volatile/operator module components. 
  component prioritySelect_Volatile is -- 
    port ( -- 
      down_counter : in  std_logic_vector(7 downto 0);
      active_packet : in  std_logic_vector(1 downto 0);
      pkt_1_has_priority : in  std_logic_vector(0 downto 0);
      p1_valid : in  std_logic_vector(0 downto 0);
      p2_valid : in  std_logic_vector(0 downto 0);
      next_active_packet : out  std_logic_vector(1 downto 0);
      next_pkt_1_has_priority : out  std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component; 
  -- links between control-path and data-path
  signal RPIPE_noblock_obuf_2_1_350_inst_ack_1 : boolean;
  signal RPIPE_noblock_obuf_1_1_344_inst_ack_0 : boolean;
  signal RPIPE_noblock_obuf_2_1_350_inst_req_1 : boolean;
  signal phi_stmt_351_ack_0 : boolean;
  signal do_while_stmt_335_branch_req_0 : boolean;
  signal RPIPE_noblock_obuf_1_1_344_inst_req_0 : boolean;
  signal phi_stmt_337_req_1 : boolean;
  signal RPIPE_noblock_obuf_2_1_350_inst_ack_0 : boolean;
  signal RPIPE_noblock_obuf_2_1_350_inst_req_0 : boolean;
  signal phi_stmt_341_ack_0 : boolean;
  signal next_down_counter_439_340_buf_ack_0 : boolean;
  signal next_down_counter_439_340_buf_req_0 : boolean;
  signal phi_stmt_341_req_1 : boolean;
  signal next_down_counter_439_340_buf_ack_1 : boolean;
  signal next_active_packet_404_354_buf_req_1 : boolean;
  signal next_active_packet_404_354_buf_ack_1 : boolean;
  signal next_down_counter_439_340_buf_req_1 : boolean;
  signal phi_stmt_337_ack_0 : boolean;
  signal phi_stmt_346_req_1 : boolean;
  signal RPIPE_noblock_obuf_1_1_344_inst_ack_1 : boolean;
  signal phi_stmt_341_req_0 : boolean;
  signal phi_stmt_346_ack_0 : boolean;
  signal phi_stmt_351_req_1 : boolean;
  signal phi_stmt_346_req_0 : boolean;
  signal next_active_packet_404_354_buf_ack_0 : boolean;
  signal phi_stmt_351_req_0 : boolean;
  signal next_active_packet_404_354_buf_req_0 : boolean;
  signal RPIPE_noblock_obuf_1_1_344_inst_req_1 : boolean;
  signal phi_stmt_337_req_0 : boolean;
  signal phi_stmt_355_req_1 : boolean;
  signal phi_stmt_355_req_0 : boolean;
  signal phi_stmt_355_ack_0 : boolean;
  signal next_active_packet_length_426_358_buf_req_0 : boolean;
  signal next_active_packet_length_426_358_buf_ack_0 : boolean;
  signal next_active_packet_length_426_358_buf_req_1 : boolean;
  signal next_active_packet_length_426_358_buf_ack_1 : boolean;
  signal phi_stmt_359_req_1 : boolean;
  signal phi_stmt_359_req_0 : boolean;
  signal phi_stmt_359_ack_0 : boolean;
  signal next_pkt_1_has_priority_404_362_buf_req_0 : boolean;
  signal next_pkt_1_has_priority_404_362_buf_ack_0 : boolean;
  signal next_pkt_1_has_priority_404_362_buf_req_1 : boolean;
  signal next_pkt_1_has_priority_404_362_buf_ack_1 : boolean;
  signal WPIPE_out_data_1_482_inst_req_0 : boolean;
  signal WPIPE_out_data_1_482_inst_ack_0 : boolean;
  signal WPIPE_out_data_1_482_inst_req_1 : boolean;
  signal WPIPE_out_data_1_482_inst_ack_1 : boolean;
  signal do_while_stmt_335_branch_ack_0 : boolean;
  signal do_while_stmt_335_branch_ack_1 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "outputPort_1_Daemon_input_buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj_in_buffer_unload_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  outputPort_1_Daemon_CP_502_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "outputPort_1_Daemon_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 0) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= outputPort_1_Daemon_CP_502_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj_out_buffer_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= outputPort_1_Daemon_CP_502_start & tag_ilock_write_ack_symbol;
    gj_tag_ilock_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= outputPort_1_Daemon_CP_502_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  outputPort_1_Daemon_CP_502: Block -- control-path 
    signal outputPort_1_Daemon_CP_502_elements: BooleanArray(139 downto 0);
    -- 
  begin -- 
    outputPort_1_Daemon_CP_502_elements(0) <= outputPort_1_Daemon_CP_502_start;
    outputPort_1_Daemon_CP_502_symbol <= outputPort_1_Daemon_CP_502_elements(1);
    -- CP-element group 0:  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	2 
    -- CP-element group 0:  members (4) 
      -- CP-element group 0: 	 branch_block_stmt_334/do_while_stmt_335__entry__
      -- CP-element group 0: 	 branch_block_stmt_334/$entry
      -- CP-element group 0: 	 branch_block_stmt_334/branch_block_stmt_334__entry__
      -- CP-element group 0: 	 $entry
      -- 
    -- CP-element group 1:  transition  place  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	139 
    -- CP-element group 1: successors 
    -- CP-element group 1:  members (4) 
      -- CP-element group 1: 	 branch_block_stmt_334/do_while_stmt_335__exit__
      -- CP-element group 1: 	 branch_block_stmt_334/branch_block_stmt_334__exit__
      -- CP-element group 1: 	 branch_block_stmt_334/$exit
      -- CP-element group 1: 	 $exit
      -- 
    outputPort_1_Daemon_CP_502_elements(1) <= outputPort_1_Daemon_CP_502_elements(139);
    -- CP-element group 2:  transition  place  bypass  pipeline-parent 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	0 
    -- CP-element group 2: successors 
    -- CP-element group 2: 	8 
    -- CP-element group 2:  members (2) 
      -- CP-element group 2: 	 branch_block_stmt_334/do_while_stmt_335/$entry
      -- CP-element group 2: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335__entry__
      -- 
    outputPort_1_Daemon_CP_502_elements(2) <= outputPort_1_Daemon_CP_502_elements(0);
    -- CP-element group 3:  merge  place  bypass  pipeline-parent 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	139 
    -- CP-element group 3:  members (1) 
      -- CP-element group 3: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335__exit__
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(3) is bound as output of CP function.
    -- CP-element group 4:  merge  place  bypass  pipeline-parent 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: successors 
    -- CP-element group 4: 	7 
    -- CP-element group 4:  members (1) 
      -- CP-element group 4: 	 branch_block_stmt_334/do_while_stmt_335/loop_back
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(4) is bound as output of CP function.
    -- CP-element group 5:  branch  transition  place  bypass  pipeline-parent 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	10 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	138 
    -- CP-element group 5: 	137 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_334/do_while_stmt_335/condition_done
      -- CP-element group 5: 	 branch_block_stmt_334/do_while_stmt_335/loop_exit/$entry
      -- CP-element group 5: 	 branch_block_stmt_334/do_while_stmt_335/loop_taken/$entry
      -- 
    outputPort_1_Daemon_CP_502_elements(5) <= outputPort_1_Daemon_CP_502_elements(10);
    -- CP-element group 6:  branch  place  bypass  pipeline-parent 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	136 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (1) 
      -- CP-element group 6: 	 branch_block_stmt_334/do_while_stmt_335/loop_body_done
      -- 
    outputPort_1_Daemon_CP_502_elements(6) <= outputPort_1_Daemon_CP_502_elements(136);
    -- CP-element group 7:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	4 
    -- CP-element group 7: successors 
    -- CP-element group 7: 	20 
    -- CP-element group 7: 	39 
    -- CP-element group 7: 	60 
    -- CP-element group 7: 	81 
    -- CP-element group 7: 	100 
    -- CP-element group 7: 	119 
    -- CP-element group 7:  members (1) 
      -- CP-element group 7: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/back_edge_to_loop_body
      -- 
    outputPort_1_Daemon_CP_502_elements(7) <= outputPort_1_Daemon_CP_502_elements(4);
    -- CP-element group 8:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	2 
    -- CP-element group 8: successors 
    -- CP-element group 8: 	22 
    -- CP-element group 8: 	41 
    -- CP-element group 8: 	62 
    -- CP-element group 8: 	83 
    -- CP-element group 8: 	102 
    -- CP-element group 8: 	121 
    -- CP-element group 8:  members (1) 
      -- CP-element group 8: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/first_time_through_loop_body
      -- 
    outputPort_1_Daemon_CP_502_elements(8) <= outputPort_1_Daemon_CP_502_elements(2);
    -- CP-element group 9:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	16 
    -- CP-element group 9: 	17 
    -- CP-element group 9: 	135 
    -- CP-element group 9: 	33 
    -- CP-element group 9: 	34 
    -- CP-element group 9: 	54 
    -- CP-element group 9: 	55 
    -- CP-element group 9: 	75 
    -- CP-element group 9: 	76 
    -- CP-element group 9: 	94 
    -- CP-element group 9: 	95 
    -- CP-element group 9: 	113 
    -- CP-element group 9: 	114 
    -- CP-element group 9:  members (2) 
      -- CP-element group 9: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/loop_body_start
      -- CP-element group 9: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/$entry
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(9) is bound as output of CP function.
    -- CP-element group 10:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	13 
    -- CP-element group 10: 	15 
    -- CP-element group 10: 	135 
    -- CP-element group 10: successors 
    -- CP-element group 10: 	5 
    -- CP-element group 10:  members (1) 
      -- CP-element group 10: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/condition_evaluated
      -- 
    condition_evaluated_526_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " condition_evaluated_526_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(10), ack => do_while_stmt_335_branch_req_0); -- 
    outputPort_1_Daemon_cp_element_group_10: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_10"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(13) & outputPort_1_Daemon_CP_502_elements(15) & outputPort_1_Daemon_CP_502_elements(135);
      gj_outputPort_1_Daemon_cp_element_group_10 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(10), clk => clk, reset => reset); --
    end block;
    -- CP-element group 11:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	16 
    -- CP-element group 11: 	33 
    -- CP-element group 11: 	54 
    -- CP-element group 11: 	75 
    -- CP-element group 11: 	94 
    -- CP-element group 11: 	113 
    -- CP-element group 11: marked-predecessors 
    -- CP-element group 11: 	15 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	35 
    -- CP-element group 11: 	56 
    -- CP-element group 11: 	77 
    -- CP-element group 11: 	96 
    -- CP-element group 11: 	115 
    -- CP-element group 11:  members (2) 
      -- CP-element group 11: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/aggregated_phi_sample_req
      -- CP-element group 11: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_sample_start__ps
      -- 
    outputPort_1_Daemon_cp_element_group_11: block -- 
      constant place_capacities: IntegerArray(0 to 6) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1,6 => 1);
      constant place_markings: IntegerArray(0 to 6)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0,6 => 1);
      constant place_delays: IntegerArray(0 to 6) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0,6 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_11"; 
      signal preds: BooleanArray(1 to 7); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(16) & outputPort_1_Daemon_CP_502_elements(33) & outputPort_1_Daemon_CP_502_elements(54) & outputPort_1_Daemon_CP_502_elements(75) & outputPort_1_Daemon_CP_502_elements(94) & outputPort_1_Daemon_CP_502_elements(113) & outputPort_1_Daemon_CP_502_elements(15);
      gj_outputPort_1_Daemon_cp_element_group_11 : generic_join generic map(name => joinName, number_of_predecessors => 7, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(11), clk => clk, reset => reset); --
    end block;
    -- CP-element group 12:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	18 
    -- CP-element group 12: 	36 
    -- CP-element group 12: 	57 
    -- CP-element group 12: 	78 
    -- CP-element group 12: 	97 
    -- CP-element group 12: 	116 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	13 
    -- CP-element group 12: 	136 
    -- CP-element group 12: marked-successors 
    -- CP-element group 12: 	16 
    -- CP-element group 12: 	33 
    -- CP-element group 12: 	54 
    -- CP-element group 12: 	75 
    -- CP-element group 12: 	94 
    -- CP-element group 12: 	113 
    -- CP-element group 12:  members (7) 
      -- CP-element group 12: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/aggregated_phi_sample_ack
      -- CP-element group 12: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_sample_completed_
      -- 
    outputPort_1_Daemon_cp_element_group_12: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_12"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(18) & outputPort_1_Daemon_CP_502_elements(36) & outputPort_1_Daemon_CP_502_elements(57) & outputPort_1_Daemon_CP_502_elements(78) & outputPort_1_Daemon_CP_502_elements(97) & outputPort_1_Daemon_CP_502_elements(116);
      gj_outputPort_1_Daemon_cp_element_group_12 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(12), clk => clk, reset => reset); --
    end block;
    -- CP-element group 13:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	12 
    -- CP-element group 13: successors 
    -- CP-element group 13: 	10 
    -- CP-element group 13:  members (1) 
      -- CP-element group 13: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/aggregated_phi_sample_ack_d
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(13) is a control-delay.
    cp_element_13_delay: control_delay_element  generic map(name => " 13_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_502_elements(12), ack => outputPort_1_Daemon_CP_502_elements(13), clk => clk, reset =>reset);
    -- CP-element group 14:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	17 
    -- CP-element group 14: 	34 
    -- CP-element group 14: 	55 
    -- CP-element group 14: 	76 
    -- CP-element group 14: 	95 
    -- CP-element group 14: 	114 
    -- CP-element group 14: successors 
    -- CP-element group 14: 	37 
    -- CP-element group 14: 	58 
    -- CP-element group 14: 	79 
    -- CP-element group 14: 	98 
    -- CP-element group 14: 	117 
    -- CP-element group 14:  members (2) 
      -- CP-element group 14: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_update_start__ps
      -- CP-element group 14: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/aggregated_phi_update_req
      -- 
    outputPort_1_Daemon_cp_element_group_14: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_14"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(17) & outputPort_1_Daemon_CP_502_elements(34) & outputPort_1_Daemon_CP_502_elements(55) & outputPort_1_Daemon_CP_502_elements(76) & outputPort_1_Daemon_CP_502_elements(95) & outputPort_1_Daemon_CP_502_elements(114);
      gj_outputPort_1_Daemon_cp_element_group_14 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(14), clk => clk, reset => reset); --
    end block;
    -- CP-element group 15:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	19 
    -- CP-element group 15: 	38 
    -- CP-element group 15: 	59 
    -- CP-element group 15: 	80 
    -- CP-element group 15: 	99 
    -- CP-element group 15: 	118 
    -- CP-element group 15: successors 
    -- CP-element group 15: 	10 
    -- CP-element group 15: marked-successors 
    -- CP-element group 15: 	11 
    -- CP-element group 15:  members (1) 
      -- CP-element group 15: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/aggregated_phi_update_ack
      -- 
    outputPort_1_Daemon_cp_element_group_15: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 7,1 => 7,2 => 7,3 => 7,4 => 7,5 => 7);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_15"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(19) & outputPort_1_Daemon_CP_502_elements(38) & outputPort_1_Daemon_CP_502_elements(59) & outputPort_1_Daemon_CP_502_elements(80) & outputPort_1_Daemon_CP_502_elements(99) & outputPort_1_Daemon_CP_502_elements(118);
      gj_outputPort_1_Daemon_cp_element_group_15 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(15), clk => clk, reset => reset); --
    end block;
    -- CP-element group 16:  join  transition  bypass  pipeline-parent 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	9 
    -- CP-element group 16: marked-predecessors 
    -- CP-element group 16: 	12 
    -- CP-element group 16: successors 
    -- CP-element group 16: 	11 
    -- CP-element group 16:  members (1) 
      -- CP-element group 16: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_16: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_16"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_16 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(16), clk => clk, reset => reset); --
    end block;
    -- CP-element group 17:  join  transition  bypass  pipeline-parent 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	9 
    -- CP-element group 17: marked-predecessors 
    -- CP-element group 17: 	133 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	14 
    -- CP-element group 17:  members (1) 
      -- CP-element group 17: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_17: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_17"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(133);
      gj_outputPort_1_Daemon_cp_element_group_17 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(17), clk => clk, reset => reset); --
    end block;
    -- CP-element group 18:  join  transition  bypass  pipeline-parent 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: successors 
    -- CP-element group 18: 	12 
    -- CP-element group 18:  members (1) 
      -- CP-element group 18: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(18) is bound as output of CP function.
    -- CP-element group 19:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	15 
    -- CP-element group 19: 	132 
    -- CP-element group 19:  members (2) 
      -- CP-element group 19: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_update_completed__ps
      -- CP-element group 19: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(19) is bound as output of CP function.
    -- CP-element group 20:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	7 
    -- CP-element group 20: successors 
    -- CP-element group 20:  members (1) 
      -- CP-element group 20: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(20) <= outputPort_1_Daemon_CP_502_elements(7);
    -- CP-element group 21:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: successors 
    -- CP-element group 21:  members (2) 
      -- CP-element group 21: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_loopback_sample_req_ps
      -- CP-element group 21: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_loopback_sample_req
      -- 
    phi_stmt_337_loopback_sample_req_542_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_337_loopback_sample_req_542_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(21), ack => phi_stmt_337_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(21) is bound as output of CP function.
    -- CP-element group 22:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	8 
    -- CP-element group 22: successors 
    -- CP-element group 22:  members (1) 
      -- CP-element group 22: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_entry_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(22) <= outputPort_1_Daemon_CP_502_elements(8);
    -- CP-element group 23:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: successors 
    -- CP-element group 23:  members (2) 
      -- CP-element group 23: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_entry_sample_req_ps
      -- CP-element group 23: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_entry_sample_req
      -- 
    phi_stmt_337_entry_sample_req_545_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_337_entry_sample_req_545_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(23), ack => phi_stmt_337_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(23) is bound as output of CP function.
    -- CP-element group 24:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: successors 
    -- CP-element group 24:  members (2) 
      -- CP-element group 24: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_phi_mux_ack_ps
      -- CP-element group 24: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_337_phi_mux_ack
      -- 
    phi_stmt_337_phi_mux_ack_548_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 24_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_337_ack_0, ack => outputPort_1_Daemon_CP_502_elements(24)); -- 
    -- CP-element group 25:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: successors 
    -- CP-element group 25:  members (4) 
      -- CP-element group 25: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_339_sample_completed_
      -- CP-element group 25: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_339_sample_start_
      -- CP-element group 25: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_339_sample_completed__ps
      -- CP-element group 25: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_339_sample_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(25) is bound as output of CP function.
    -- CP-element group 26:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 26: predecessors 
    -- CP-element group 26: successors 
    -- CP-element group 26: 	28 
    -- CP-element group 26:  members (2) 
      -- CP-element group 26: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_339_update_start__ps
      -- CP-element group 26: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_339_update_start_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(26) is bound as output of CP function.
    -- CP-element group 27:  join  transition  bypass  pipeline-parent 
    -- CP-element group 27: predecessors 
    -- CP-element group 27: 	28 
    -- CP-element group 27: successors 
    -- CP-element group 27:  members (1) 
      -- CP-element group 27: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_339_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(27) <= outputPort_1_Daemon_CP_502_elements(28);
    -- CP-element group 28:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 28: predecessors 
    -- CP-element group 28: 	26 
    -- CP-element group 28: successors 
    -- CP-element group 28: 	27 
    -- CP-element group 28:  members (1) 
      -- CP-element group 28: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_339_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(28) is a control-delay.
    cp_element_28_delay: control_delay_element  generic map(name => " 28_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_502_elements(26), ack => outputPort_1_Daemon_CP_502_elements(28), clk => clk, reset =>reset);
    -- CP-element group 29:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 29: predecessors 
    -- CP-element group 29: successors 
    -- CP-element group 29: 	31 
    -- CP-element group 29:  members (4) 
      -- CP-element group 29: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_sample_start__ps
      -- CP-element group 29: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_Sample/req
      -- CP-element group 29: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_Sample/$entry
      -- CP-element group 29: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_sample_start_
      -- 
    req_569_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_569_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(29), ack => next_down_counter_439_340_buf_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(29) is bound as output of CP function.
    -- CP-element group 30:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 30: predecessors 
    -- CP-element group 30: successors 
    -- CP-element group 30: 	32 
    -- CP-element group 30:  members (4) 
      -- CP-element group 30: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_Update/req
      -- CP-element group 30: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_Update/$entry
      -- CP-element group 30: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_update_start_
      -- CP-element group 30: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_update_start__ps
      -- 
    req_574_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_574_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(30), ack => next_down_counter_439_340_buf_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(30) is bound as output of CP function.
    -- CP-element group 31:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 31: predecessors 
    -- CP-element group 31: 	29 
    -- CP-element group 31: successors 
    -- CP-element group 31:  members (4) 
      -- CP-element group 31: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_Sample/ack
      -- CP-element group 31: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_Sample/$exit
      -- CP-element group 31: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_sample_completed_
      -- CP-element group 31: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_sample_completed__ps
      -- 
    ack_570_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 31_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_down_counter_439_340_buf_ack_0, ack => outputPort_1_Daemon_CP_502_elements(31)); -- 
    -- CP-element group 32:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 32: predecessors 
    -- CP-element group 32: 	30 
    -- CP-element group 32: successors 
    -- CP-element group 32:  members (4) 
      -- CP-element group 32: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_Update/ack
      -- CP-element group 32: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_Update/$exit
      -- CP-element group 32: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_update_completed_
      -- CP-element group 32: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_down_counter_340_update_completed__ps
      -- 
    ack_575_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 32_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_down_counter_439_340_buf_ack_1, ack => outputPort_1_Daemon_CP_502_elements(32)); -- 
    -- CP-element group 33:  join  transition  bypass  pipeline-parent 
    -- CP-element group 33: predecessors 
    -- CP-element group 33: 	9 
    -- CP-element group 33: marked-predecessors 
    -- CP-element group 33: 	12 
    -- CP-element group 33: successors 
    -- CP-element group 33: 	11 
    -- CP-element group 33:  members (1) 
      -- CP-element group 33: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_33: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_33"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_33 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(33), clk => clk, reset => reset); --
    end block;
    -- CP-element group 34:  join  transition  bypass  pipeline-parent 
    -- CP-element group 34: predecessors 
    -- CP-element group 34: 	9 
    -- CP-element group 34: marked-predecessors 
    -- CP-element group 34: 	133 
    -- CP-element group 34: successors 
    -- CP-element group 34: 	14 
    -- CP-element group 34:  members (1) 
      -- CP-element group 34: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_34: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_34"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(133);
      gj_outputPort_1_Daemon_cp_element_group_34 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(34), clk => clk, reset => reset); --
    end block;
    -- CP-element group 35:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 35: predecessors 
    -- CP-element group 35: 	11 
    -- CP-element group 35: successors 
    -- CP-element group 35:  members (1) 
      -- CP-element group 35: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_sample_start__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(35) <= outputPort_1_Daemon_CP_502_elements(11);
    -- CP-element group 36:  join  transition  bypass  pipeline-parent 
    -- CP-element group 36: predecessors 
    -- CP-element group 36: successors 
    -- CP-element group 36: 	12 
    -- CP-element group 36:  members (1) 
      -- CP-element group 36: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(36) is bound as output of CP function.
    -- CP-element group 37:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 37: predecessors 
    -- CP-element group 37: 	14 
    -- CP-element group 37: successors 
    -- CP-element group 37:  members (1) 
      -- CP-element group 37: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_update_start__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(37) <= outputPort_1_Daemon_CP_502_elements(14);
    -- CP-element group 38:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 38: predecessors 
    -- CP-element group 38: successors 
    -- CP-element group 38: 	15 
    -- CP-element group 38: 	132 
    -- CP-element group 38:  members (2) 
      -- CP-element group 38: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_update_completed_
      -- CP-element group 38: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_update_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(38) is bound as output of CP function.
    -- CP-element group 39:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 39: predecessors 
    -- CP-element group 39: 	7 
    -- CP-element group 39: successors 
    -- CP-element group 39:  members (1) 
      -- CP-element group 39: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(39) <= outputPort_1_Daemon_CP_502_elements(7);
    -- CP-element group 40:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 40: predecessors 
    -- CP-element group 40: successors 
    -- CP-element group 40:  members (2) 
      -- CP-element group 40: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_loopback_sample_req_ps
      -- CP-element group 40: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_loopback_sample_req
      -- 
    phi_stmt_341_loopback_sample_req_586_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_341_loopback_sample_req_586_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(40), ack => phi_stmt_341_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(40) is bound as output of CP function.
    -- CP-element group 41:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 41: predecessors 
    -- CP-element group 41: 	8 
    -- CP-element group 41: successors 
    -- CP-element group 41:  members (1) 
      -- CP-element group 41: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_entry_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(41) <= outputPort_1_Daemon_CP_502_elements(8);
    -- CP-element group 42:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 42: predecessors 
    -- CP-element group 42: successors 
    -- CP-element group 42:  members (2) 
      -- CP-element group 42: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_entry_sample_req_ps
      -- CP-element group 42: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_entry_sample_req
      -- 
    phi_stmt_341_entry_sample_req_589_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_341_entry_sample_req_589_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(42), ack => phi_stmt_341_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(42) is bound as output of CP function.
    -- CP-element group 43:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 43: predecessors 
    -- CP-element group 43: successors 
    -- CP-element group 43:  members (2) 
      -- CP-element group 43: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_phi_mux_ack_ps
      -- CP-element group 43: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_341_phi_mux_ack
      -- 
    phi_stmt_341_phi_mux_ack_592_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 43_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_341_ack_0, ack => outputPort_1_Daemon_CP_502_elements(43)); -- 
    -- CP-element group 44:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 44: predecessors 
    -- CP-element group 44: successors 
    -- CP-element group 44: 	46 
    -- CP-element group 44:  members (1) 
      -- CP-element group 44: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_sample_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(44) is bound as output of CP function.
    -- CP-element group 45:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 45: predecessors 
    -- CP-element group 45: successors 
    -- CP-element group 45: 	47 
    -- CP-element group 45:  members (1) 
      -- CP-element group 45: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_update_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(45) is bound as output of CP function.
    -- CP-element group 46:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 46: predecessors 
    -- CP-element group 46: 	44 
    -- CP-element group 46: marked-predecessors 
    -- CP-element group 46: 	49 
    -- CP-element group 46: successors 
    -- CP-element group 46: 	48 
    -- CP-element group 46:  members (3) 
      -- CP-element group 46: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_Sample/rr
      -- CP-element group 46: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_Sample/$entry
      -- CP-element group 46: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_sample_start_
      -- 
    rr_605_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_605_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(46), ack => RPIPE_noblock_obuf_1_1_344_inst_req_0); -- 
    outputPort_1_Daemon_cp_element_group_46: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_46"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(44) & outputPort_1_Daemon_CP_502_elements(49);
      gj_outputPort_1_Daemon_cp_element_group_46 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(46), clk => clk, reset => reset); --
    end block;
    -- CP-element group 47:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 47: predecessors 
    -- CP-element group 47: 	45 
    -- CP-element group 47: 	48 
    -- CP-element group 47: successors 
    -- CP-element group 47: 	49 
    -- CP-element group 47:  members (3) 
      -- CP-element group 47: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_update_start_
      -- CP-element group 47: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_Update/cr
      -- CP-element group 47: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_Update/$entry
      -- 
    cr_610_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_610_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(47), ack => RPIPE_noblock_obuf_1_1_344_inst_req_1); -- 
    outputPort_1_Daemon_cp_element_group_47: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_47"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(45) & outputPort_1_Daemon_CP_502_elements(48);
      gj_outputPort_1_Daemon_cp_element_group_47 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(47), clk => clk, reset => reset); --
    end block;
    -- CP-element group 48:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 48: predecessors 
    -- CP-element group 48: 	46 
    -- CP-element group 48: successors 
    -- CP-element group 48: 	47 
    -- CP-element group 48:  members (4) 
      -- CP-element group 48: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_Sample/ra
      -- CP-element group 48: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_sample_completed__ps
      -- CP-element group 48: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_Sample/$exit
      -- CP-element group 48: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_sample_completed_
      -- 
    ra_606_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 48_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_1_1_344_inst_ack_0, ack => outputPort_1_Daemon_CP_502_elements(48)); -- 
    -- CP-element group 49:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 49: predecessors 
    -- CP-element group 49: 	47 
    -- CP-element group 49: successors 
    -- CP-element group 49: marked-successors 
    -- CP-element group 49: 	46 
    -- CP-element group 49:  members (4) 
      -- CP-element group 49: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_update_completed__ps
      -- CP-element group 49: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_update_completed_
      -- CP-element group 49: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_Update/ca
      -- CP-element group 49: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_1_1_344_Update/$exit
      -- 
    ca_611_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 49_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_1_1_344_inst_ack_1, ack => outputPort_1_Daemon_CP_502_elements(49)); -- 
    -- CP-element group 50:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 50: predecessors 
    -- CP-element group 50: successors 
    -- CP-element group 50:  members (4) 
      -- CP-element group 50: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_345_sample_completed_
      -- CP-element group 50: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_345_sample_start_
      -- CP-element group 50: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_345_sample_completed__ps
      -- CP-element group 50: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_345_sample_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(50) is bound as output of CP function.
    -- CP-element group 51:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 51: predecessors 
    -- CP-element group 51: successors 
    -- CP-element group 51: 	53 
    -- CP-element group 51:  members (2) 
      -- CP-element group 51: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_345_update_start_
      -- CP-element group 51: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_345_update_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(51) is bound as output of CP function.
    -- CP-element group 52:  join  transition  bypass  pipeline-parent 
    -- CP-element group 52: predecessors 
    -- CP-element group 52: 	53 
    -- CP-element group 52: successors 
    -- CP-element group 52:  members (1) 
      -- CP-element group 52: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_345_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(52) <= outputPort_1_Daemon_CP_502_elements(53);
    -- CP-element group 53:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 53: predecessors 
    -- CP-element group 53: 	51 
    -- CP-element group 53: successors 
    -- CP-element group 53: 	52 
    -- CP-element group 53:  members (1) 
      -- CP-element group 53: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_345_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(53) is a control-delay.
    cp_element_53_delay: control_delay_element  generic map(name => " 53_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_502_elements(51), ack => outputPort_1_Daemon_CP_502_elements(53), clk => clk, reset =>reset);
    -- CP-element group 54:  join  transition  bypass  pipeline-parent 
    -- CP-element group 54: predecessors 
    -- CP-element group 54: 	9 
    -- CP-element group 54: marked-predecessors 
    -- CP-element group 54: 	12 
    -- CP-element group 54: successors 
    -- CP-element group 54: 	11 
    -- CP-element group 54:  members (1) 
      -- CP-element group 54: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_54: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_54"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_54 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(54), clk => clk, reset => reset); --
    end block;
    -- CP-element group 55:  join  transition  bypass  pipeline-parent 
    -- CP-element group 55: predecessors 
    -- CP-element group 55: 	9 
    -- CP-element group 55: marked-predecessors 
    -- CP-element group 55: 	133 
    -- CP-element group 55: successors 
    -- CP-element group 55: 	14 
    -- CP-element group 55:  members (1) 
      -- CP-element group 55: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_55: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_55"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(133);
      gj_outputPort_1_Daemon_cp_element_group_55 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(55), clk => clk, reset => reset); --
    end block;
    -- CP-element group 56:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 56: predecessors 
    -- CP-element group 56: 	11 
    -- CP-element group 56: successors 
    -- CP-element group 56:  members (1) 
      -- CP-element group 56: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_sample_start__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(56) <= outputPort_1_Daemon_CP_502_elements(11);
    -- CP-element group 57:  join  transition  bypass  pipeline-parent 
    -- CP-element group 57: predecessors 
    -- CP-element group 57: successors 
    -- CP-element group 57: 	12 
    -- CP-element group 57:  members (1) 
      -- CP-element group 57: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(57) is bound as output of CP function.
    -- CP-element group 58:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 58: predecessors 
    -- CP-element group 58: 	14 
    -- CP-element group 58: successors 
    -- CP-element group 58:  members (1) 
      -- CP-element group 58: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_update_start__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(58) <= outputPort_1_Daemon_CP_502_elements(14);
    -- CP-element group 59:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 59: predecessors 
    -- CP-element group 59: successors 
    -- CP-element group 59: 	15 
    -- CP-element group 59: 	132 
    -- CP-element group 59:  members (2) 
      -- CP-element group 59: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_update_completed__ps
      -- CP-element group 59: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(59) is bound as output of CP function.
    -- CP-element group 60:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 60: predecessors 
    -- CP-element group 60: 	7 
    -- CP-element group 60: successors 
    -- CP-element group 60:  members (1) 
      -- CP-element group 60: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(60) <= outputPort_1_Daemon_CP_502_elements(7);
    -- CP-element group 61:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 61: predecessors 
    -- CP-element group 61: successors 
    -- CP-element group 61:  members (2) 
      -- CP-element group 61: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_loopback_sample_req_ps
      -- CP-element group 61: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_loopback_sample_req
      -- 
    phi_stmt_346_loopback_sample_req_630_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_346_loopback_sample_req_630_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(61), ack => phi_stmt_346_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(61) is bound as output of CP function.
    -- CP-element group 62:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 62: predecessors 
    -- CP-element group 62: 	8 
    -- CP-element group 62: successors 
    -- CP-element group 62:  members (1) 
      -- CP-element group 62: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_entry_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(62) <= outputPort_1_Daemon_CP_502_elements(8);
    -- CP-element group 63:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 63: predecessors 
    -- CP-element group 63: successors 
    -- CP-element group 63:  members (2) 
      -- CP-element group 63: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_entry_sample_req_ps
      -- CP-element group 63: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_entry_sample_req
      -- 
    phi_stmt_346_entry_sample_req_633_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_346_entry_sample_req_633_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(63), ack => phi_stmt_346_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(63) is bound as output of CP function.
    -- CP-element group 64:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 64: predecessors 
    -- CP-element group 64: successors 
    -- CP-element group 64:  members (2) 
      -- CP-element group 64: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_phi_mux_ack_ps
      -- CP-element group 64: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_346_phi_mux_ack
      -- 
    phi_stmt_346_phi_mux_ack_636_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 64_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_346_ack_0, ack => outputPort_1_Daemon_CP_502_elements(64)); -- 
    -- CP-element group 65:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 65: predecessors 
    -- CP-element group 65: successors 
    -- CP-element group 65:  members (4) 
      -- CP-element group 65: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_348_sample_completed_
      -- CP-element group 65: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_348_sample_start_
      -- CP-element group 65: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_348_sample_completed__ps
      -- CP-element group 65: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_348_sample_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(65) is bound as output of CP function.
    -- CP-element group 66:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 66: predecessors 
    -- CP-element group 66: successors 
    -- CP-element group 66: 	68 
    -- CP-element group 66:  members (2) 
      -- CP-element group 66: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_348_update_start_
      -- CP-element group 66: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_348_update_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(66) is bound as output of CP function.
    -- CP-element group 67:  join  transition  bypass  pipeline-parent 
    -- CP-element group 67: predecessors 
    -- CP-element group 67: 	68 
    -- CP-element group 67: successors 
    -- CP-element group 67:  members (1) 
      -- CP-element group 67: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_348_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(67) <= outputPort_1_Daemon_CP_502_elements(68);
    -- CP-element group 68:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 68: predecessors 
    -- CP-element group 68: 	66 
    -- CP-element group 68: successors 
    -- CP-element group 68: 	67 
    -- CP-element group 68:  members (1) 
      -- CP-element group 68: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_33_348_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(68) is a control-delay.
    cp_element_68_delay: control_delay_element  generic map(name => " 68_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_502_elements(66), ack => outputPort_1_Daemon_CP_502_elements(68), clk => clk, reset =>reset);
    -- CP-element group 69:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 69: predecessors 
    -- CP-element group 69: successors 
    -- CP-element group 69: 	71 
    -- CP-element group 69:  members (1) 
      -- CP-element group 69: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_sample_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(69) is bound as output of CP function.
    -- CP-element group 70:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 70: predecessors 
    -- CP-element group 70: successors 
    -- CP-element group 70: 	72 
    -- CP-element group 70:  members (1) 
      -- CP-element group 70: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_update_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(70) is bound as output of CP function.
    -- CP-element group 71:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 71: predecessors 
    -- CP-element group 71: 	69 
    -- CP-element group 71: marked-predecessors 
    -- CP-element group 71: 	74 
    -- CP-element group 71: successors 
    -- CP-element group 71: 	73 
    -- CP-element group 71:  members (3) 
      -- CP-element group 71: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_Sample/rr
      -- CP-element group 71: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_Sample/$entry
      -- CP-element group 71: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_sample_start_
      -- 
    rr_657_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_657_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(71), ack => RPIPE_noblock_obuf_2_1_350_inst_req_0); -- 
    outputPort_1_Daemon_cp_element_group_71: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_71"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(69) & outputPort_1_Daemon_CP_502_elements(74);
      gj_outputPort_1_Daemon_cp_element_group_71 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(71), clk => clk, reset => reset); --
    end block;
    -- CP-element group 72:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 72: predecessors 
    -- CP-element group 72: 	70 
    -- CP-element group 72: 	73 
    -- CP-element group 72: successors 
    -- CP-element group 72: 	74 
    -- CP-element group 72:  members (3) 
      -- CP-element group 72: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_Update/cr
      -- CP-element group 72: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_Update/$entry
      -- CP-element group 72: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_update_start_
      -- 
    cr_662_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_662_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(72), ack => RPIPE_noblock_obuf_2_1_350_inst_req_1); -- 
    outputPort_1_Daemon_cp_element_group_72: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_72"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(70) & outputPort_1_Daemon_CP_502_elements(73);
      gj_outputPort_1_Daemon_cp_element_group_72 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(72), clk => clk, reset => reset); --
    end block;
    -- CP-element group 73:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 73: predecessors 
    -- CP-element group 73: 	71 
    -- CP-element group 73: successors 
    -- CP-element group 73: 	72 
    -- CP-element group 73:  members (4) 
      -- CP-element group 73: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_Sample/ra
      -- CP-element group 73: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_Sample/$exit
      -- CP-element group 73: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_sample_completed_
      -- CP-element group 73: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_sample_completed__ps
      -- 
    ra_658_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 73_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_2_1_350_inst_ack_0, ack => outputPort_1_Daemon_CP_502_elements(73)); -- 
    -- CP-element group 74:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 74: predecessors 
    -- CP-element group 74: 	72 
    -- CP-element group 74: successors 
    -- CP-element group 74: marked-successors 
    -- CP-element group 74: 	71 
    -- CP-element group 74:  members (4) 
      -- CP-element group 74: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_Update/ca
      -- CP-element group 74: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_Update/$exit
      -- CP-element group 74: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_update_completed_
      -- CP-element group 74: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/RPIPE_noblock_obuf_2_1_350_update_completed__ps
      -- 
    ca_663_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 74_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_2_1_350_inst_ack_1, ack => outputPort_1_Daemon_CP_502_elements(74)); -- 
    -- CP-element group 75:  join  transition  bypass  pipeline-parent 
    -- CP-element group 75: predecessors 
    -- CP-element group 75: 	9 
    -- CP-element group 75: marked-predecessors 
    -- CP-element group 75: 	12 
    -- CP-element group 75: successors 
    -- CP-element group 75: 	11 
    -- CP-element group 75:  members (1) 
      -- CP-element group 75: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_75: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_75"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_75 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(75), clk => clk, reset => reset); --
    end block;
    -- CP-element group 76:  join  transition  bypass  pipeline-parent 
    -- CP-element group 76: predecessors 
    -- CP-element group 76: 	9 
    -- CP-element group 76: marked-predecessors 
    -- CP-element group 76: 	133 
    -- CP-element group 76: successors 
    -- CP-element group 76: 	14 
    -- CP-element group 76:  members (1) 
      -- CP-element group 76: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_76: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_76"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(133);
      gj_outputPort_1_Daemon_cp_element_group_76 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(76), clk => clk, reset => reset); --
    end block;
    -- CP-element group 77:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 77: predecessors 
    -- CP-element group 77: 	11 
    -- CP-element group 77: successors 
    -- CP-element group 77:  members (1) 
      -- CP-element group 77: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_sample_start__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(77) <= outputPort_1_Daemon_CP_502_elements(11);
    -- CP-element group 78:  join  transition  bypass  pipeline-parent 
    -- CP-element group 78: predecessors 
    -- CP-element group 78: successors 
    -- CP-element group 78: 	12 
    -- CP-element group 78:  members (1) 
      -- CP-element group 78: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(78) is bound as output of CP function.
    -- CP-element group 79:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 79: predecessors 
    -- CP-element group 79: 	14 
    -- CP-element group 79: successors 
    -- CP-element group 79:  members (1) 
      -- CP-element group 79: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_update_start__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(79) <= outputPort_1_Daemon_CP_502_elements(14);
    -- CP-element group 80:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 80: predecessors 
    -- CP-element group 80: successors 
    -- CP-element group 80: 	15 
    -- CP-element group 80: 	132 
    -- CP-element group 80:  members (2) 
      -- CP-element group 80: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_update_completed__ps
      -- CP-element group 80: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(80) is bound as output of CP function.
    -- CP-element group 81:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 81: predecessors 
    -- CP-element group 81: 	7 
    -- CP-element group 81: successors 
    -- CP-element group 81:  members (1) 
      -- CP-element group 81: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(81) <= outputPort_1_Daemon_CP_502_elements(7);
    -- CP-element group 82:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 82: predecessors 
    -- CP-element group 82: successors 
    -- CP-element group 82:  members (2) 
      -- CP-element group 82: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_loopback_sample_req
      -- CP-element group 82: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_loopback_sample_req_ps
      -- 
    phi_stmt_351_loopback_sample_req_674_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_351_loopback_sample_req_674_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(82), ack => phi_stmt_351_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(82) is bound as output of CP function.
    -- CP-element group 83:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 83: predecessors 
    -- CP-element group 83: 	8 
    -- CP-element group 83: successors 
    -- CP-element group 83:  members (1) 
      -- CP-element group 83: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_entry_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(83) <= outputPort_1_Daemon_CP_502_elements(8);
    -- CP-element group 84:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 84: predecessors 
    -- CP-element group 84: successors 
    -- CP-element group 84:  members (2) 
      -- CP-element group 84: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_entry_sample_req_ps
      -- CP-element group 84: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_entry_sample_req
      -- 
    phi_stmt_351_entry_sample_req_677_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_351_entry_sample_req_677_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(84), ack => phi_stmt_351_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(84) is bound as output of CP function.
    -- CP-element group 85:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 85: predecessors 
    -- CP-element group 85: successors 
    -- CP-element group 85:  members (2) 
      -- CP-element group 85: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_phi_mux_ack
      -- CP-element group 85: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_351_phi_mux_ack_ps
      -- 
    phi_stmt_351_phi_mux_ack_680_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 85_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_351_ack_0, ack => outputPort_1_Daemon_CP_502_elements(85)); -- 
    -- CP-element group 86:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 86: predecessors 
    -- CP-element group 86: successors 
    -- CP-element group 86:  members (4) 
      -- CP-element group 86: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_2_353_sample_start__ps
      -- CP-element group 86: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_2_353_sample_completed__ps
      -- CP-element group 86: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_2_353_sample_start_
      -- CP-element group 86: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_2_353_sample_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(86) is bound as output of CP function.
    -- CP-element group 87:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 87: predecessors 
    -- CP-element group 87: successors 
    -- CP-element group 87: 	89 
    -- CP-element group 87:  members (2) 
      -- CP-element group 87: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_2_353_update_start__ps
      -- CP-element group 87: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_2_353_update_start_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(87) is bound as output of CP function.
    -- CP-element group 88:  join  transition  bypass  pipeline-parent 
    -- CP-element group 88: predecessors 
    -- CP-element group 88: 	89 
    -- CP-element group 88: successors 
    -- CP-element group 88:  members (1) 
      -- CP-element group 88: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_2_353_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(88) <= outputPort_1_Daemon_CP_502_elements(89);
    -- CP-element group 89:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 89: predecessors 
    -- CP-element group 89: 	87 
    -- CP-element group 89: successors 
    -- CP-element group 89: 	88 
    -- CP-element group 89:  members (1) 
      -- CP-element group 89: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_2_353_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(89) is a control-delay.
    cp_element_89_delay: control_delay_element  generic map(name => " 89_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_502_elements(87), ack => outputPort_1_Daemon_CP_502_elements(89), clk => clk, reset =>reset);
    -- CP-element group 90:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 90: predecessors 
    -- CP-element group 90: successors 
    -- CP-element group 90: 	92 
    -- CP-element group 90:  members (4) 
      -- CP-element group 90: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_sample_start__ps
      -- CP-element group 90: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_Sample/$entry
      -- CP-element group 90: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_Sample/req
      -- CP-element group 90: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_sample_start_
      -- 
    req_701_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_701_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(90), ack => next_active_packet_404_354_buf_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(90) is bound as output of CP function.
    -- CP-element group 91:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 91: predecessors 
    -- CP-element group 91: successors 
    -- CP-element group 91: 	93 
    -- CP-element group 91:  members (4) 
      -- CP-element group 91: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_update_start__ps
      -- CP-element group 91: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_Update/req
      -- CP-element group 91: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_Update/$entry
      -- CP-element group 91: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_update_start_
      -- 
    req_706_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_706_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(91), ack => next_active_packet_404_354_buf_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(91) is bound as output of CP function.
    -- CP-element group 92:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 92: predecessors 
    -- CP-element group 92: 	90 
    -- CP-element group 92: successors 
    -- CP-element group 92:  members (4) 
      -- CP-element group 92: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_sample_completed__ps
      -- CP-element group 92: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_Sample/ack
      -- CP-element group 92: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_Sample/$exit
      -- CP-element group 92: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_sample_completed_
      -- 
    ack_702_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 92_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_404_354_buf_ack_0, ack => outputPort_1_Daemon_CP_502_elements(92)); -- 
    -- CP-element group 93:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 93: predecessors 
    -- CP-element group 93: 	91 
    -- CP-element group 93: successors 
    -- CP-element group 93:  members (4) 
      -- CP-element group 93: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_Update/ack
      -- CP-element group 93: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_Update/$exit
      -- CP-element group 93: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_update_completed__ps
      -- CP-element group 93: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_354_update_completed_
      -- 
    ack_707_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 93_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_404_354_buf_ack_1, ack => outputPort_1_Daemon_CP_502_elements(93)); -- 
    -- CP-element group 94:  join  transition  bypass  pipeline-parent 
    -- CP-element group 94: predecessors 
    -- CP-element group 94: 	9 
    -- CP-element group 94: marked-predecessors 
    -- CP-element group 94: 	12 
    -- CP-element group 94: successors 
    -- CP-element group 94: 	11 
    -- CP-element group 94:  members (1) 
      -- CP-element group 94: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_94: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_94"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_94 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(94), clk => clk, reset => reset); --
    end block;
    -- CP-element group 95:  join  transition  bypass  pipeline-parent 
    -- CP-element group 95: predecessors 
    -- CP-element group 95: 	9 
    -- CP-element group 95: marked-predecessors 
    -- CP-element group 95: 	99 
    -- CP-element group 95: successors 
    -- CP-element group 95: 	14 
    -- CP-element group 95:  members (1) 
      -- CP-element group 95: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_95: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_95"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(99);
      gj_outputPort_1_Daemon_cp_element_group_95 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(95), clk => clk, reset => reset); --
    end block;
    -- CP-element group 96:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 96: predecessors 
    -- CP-element group 96: 	11 
    -- CP-element group 96: successors 
    -- CP-element group 96:  members (1) 
      -- CP-element group 96: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_sample_start__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(96) <= outputPort_1_Daemon_CP_502_elements(11);
    -- CP-element group 97:  join  transition  bypass  pipeline-parent 
    -- CP-element group 97: predecessors 
    -- CP-element group 97: successors 
    -- CP-element group 97: 	12 
    -- CP-element group 97:  members (1) 
      -- CP-element group 97: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(97) is bound as output of CP function.
    -- CP-element group 98:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 98: predecessors 
    -- CP-element group 98: 	14 
    -- CP-element group 98: successors 
    -- CP-element group 98:  members (1) 
      -- CP-element group 98: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_update_start__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(98) <= outputPort_1_Daemon_CP_502_elements(14);
    -- CP-element group 99:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 99: predecessors 
    -- CP-element group 99: successors 
    -- CP-element group 99: 	15 
    -- CP-element group 99: marked-successors 
    -- CP-element group 99: 	95 
    -- CP-element group 99:  members (2) 
      -- CP-element group 99: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_update_completed_
      -- CP-element group 99: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_update_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(99) is bound as output of CP function.
    -- CP-element group 100:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 100: predecessors 
    -- CP-element group 100: 	7 
    -- CP-element group 100: successors 
    -- CP-element group 100:  members (1) 
      -- CP-element group 100: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(100) <= outputPort_1_Daemon_CP_502_elements(7);
    -- CP-element group 101:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 101: predecessors 
    -- CP-element group 101: successors 
    -- CP-element group 101:  members (2) 
      -- CP-element group 101: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_loopback_sample_req
      -- CP-element group 101: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_loopback_sample_req_ps
      -- 
    phi_stmt_355_loopback_sample_req_718_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_355_loopback_sample_req_718_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(101), ack => phi_stmt_355_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(101) is bound as output of CP function.
    -- CP-element group 102:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 102: predecessors 
    -- CP-element group 102: 	8 
    -- CP-element group 102: successors 
    -- CP-element group 102:  members (1) 
      -- CP-element group 102: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_entry_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(102) <= outputPort_1_Daemon_CP_502_elements(8);
    -- CP-element group 103:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 103: predecessors 
    -- CP-element group 103: successors 
    -- CP-element group 103:  members (2) 
      -- CP-element group 103: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_entry_sample_req
      -- CP-element group 103: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_entry_sample_req_ps
      -- 
    phi_stmt_355_entry_sample_req_721_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_355_entry_sample_req_721_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(103), ack => phi_stmt_355_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(103) is bound as output of CP function.
    -- CP-element group 104:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 104: predecessors 
    -- CP-element group 104: successors 
    -- CP-element group 104:  members (2) 
      -- CP-element group 104: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_phi_mux_ack
      -- CP-element group 104: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_355_phi_mux_ack_ps
      -- 
    phi_stmt_355_phi_mux_ack_724_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 104_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_355_ack_0, ack => outputPort_1_Daemon_CP_502_elements(104)); -- 
    -- CP-element group 105:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 105: predecessors 
    -- CP-element group 105: successors 
    -- CP-element group 105:  members (4) 
      -- CP-element group 105: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_357_sample_start__ps
      -- CP-element group 105: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_357_sample_completed__ps
      -- CP-element group 105: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_357_sample_start_
      -- CP-element group 105: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_357_sample_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(105) is bound as output of CP function.
    -- CP-element group 106:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 106: predecessors 
    -- CP-element group 106: successors 
    -- CP-element group 106: 	108 
    -- CP-element group 106:  members (2) 
      -- CP-element group 106: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_357_update_start__ps
      -- CP-element group 106: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_357_update_start_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(106) is bound as output of CP function.
    -- CP-element group 107:  join  transition  bypass  pipeline-parent 
    -- CP-element group 107: predecessors 
    -- CP-element group 107: 	108 
    -- CP-element group 107: successors 
    -- CP-element group 107:  members (1) 
      -- CP-element group 107: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_357_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(107) <= outputPort_1_Daemon_CP_502_elements(108);
    -- CP-element group 108:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 108: predecessors 
    -- CP-element group 108: 	106 
    -- CP-element group 108: successors 
    -- CP-element group 108: 	107 
    -- CP-element group 108:  members (1) 
      -- CP-element group 108: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_8_357_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(108) is a control-delay.
    cp_element_108_delay: control_delay_element  generic map(name => " 108_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_502_elements(106), ack => outputPort_1_Daemon_CP_502_elements(108), clk => clk, reset =>reset);
    -- CP-element group 109:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 109: predecessors 
    -- CP-element group 109: successors 
    -- CP-element group 109: 	111 
    -- CP-element group 109:  members (4) 
      -- CP-element group 109: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_sample_start__ps
      -- CP-element group 109: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_sample_start_
      -- CP-element group 109: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_Sample/$entry
      -- CP-element group 109: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_Sample/req
      -- 
    req_745_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_745_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(109), ack => next_active_packet_length_426_358_buf_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(109) is bound as output of CP function.
    -- CP-element group 110:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 110: predecessors 
    -- CP-element group 110: successors 
    -- CP-element group 110: 	112 
    -- CP-element group 110:  members (4) 
      -- CP-element group 110: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_update_start__ps
      -- CP-element group 110: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_update_start_
      -- CP-element group 110: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_Update/$entry
      -- CP-element group 110: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_Update/req
      -- 
    req_750_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_750_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(110), ack => next_active_packet_length_426_358_buf_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(110) is bound as output of CP function.
    -- CP-element group 111:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 111: predecessors 
    -- CP-element group 111: 	109 
    -- CP-element group 111: successors 
    -- CP-element group 111:  members (4) 
      -- CP-element group 111: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_sample_completed__ps
      -- CP-element group 111: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_sample_completed_
      -- CP-element group 111: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_Sample/$exit
      -- CP-element group 111: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_Sample/ack
      -- 
    ack_746_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 111_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_length_426_358_buf_ack_0, ack => outputPort_1_Daemon_CP_502_elements(111)); -- 
    -- CP-element group 112:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 112: predecessors 
    -- CP-element group 112: 	110 
    -- CP-element group 112: successors 
    -- CP-element group 112:  members (4) 
      -- CP-element group 112: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_update_completed__ps
      -- CP-element group 112: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_update_completed_
      -- CP-element group 112: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_Update/$exit
      -- CP-element group 112: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_active_packet_length_358_Update/ack
      -- 
    ack_751_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 112_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_length_426_358_buf_ack_1, ack => outputPort_1_Daemon_CP_502_elements(112)); -- 
    -- CP-element group 113:  join  transition  bypass  pipeline-parent 
    -- CP-element group 113: predecessors 
    -- CP-element group 113: 	9 
    -- CP-element group 113: marked-predecessors 
    -- CP-element group 113: 	12 
    -- CP-element group 113: successors 
    -- CP-element group 113: 	11 
    -- CP-element group 113:  members (1) 
      -- CP-element group 113: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_113: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 40) := "outputPort_1_Daemon_cp_element_group_113"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_113 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(113), clk => clk, reset => reset); --
    end block;
    -- CP-element group 114:  join  transition  bypass  pipeline-parent 
    -- CP-element group 114: predecessors 
    -- CP-element group 114: 	9 
    -- CP-element group 114: marked-predecessors 
    -- CP-element group 114: 	133 
    -- CP-element group 114: successors 
    -- CP-element group 114: 	14 
    -- CP-element group 114:  members (1) 
      -- CP-element group 114: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_114: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 40) := "outputPort_1_Daemon_cp_element_group_114"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(9) & outputPort_1_Daemon_CP_502_elements(133);
      gj_outputPort_1_Daemon_cp_element_group_114 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(114), clk => clk, reset => reset); --
    end block;
    -- CP-element group 115:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 115: predecessors 
    -- CP-element group 115: 	11 
    -- CP-element group 115: successors 
    -- CP-element group 115:  members (1) 
      -- CP-element group 115: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_sample_start__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(115) <= outputPort_1_Daemon_CP_502_elements(11);
    -- CP-element group 116:  join  transition  bypass  pipeline-parent 
    -- CP-element group 116: predecessors 
    -- CP-element group 116: successors 
    -- CP-element group 116: 	12 
    -- CP-element group 116:  members (1) 
      -- CP-element group 116: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(116) is bound as output of CP function.
    -- CP-element group 117:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 117: predecessors 
    -- CP-element group 117: 	14 
    -- CP-element group 117: successors 
    -- CP-element group 117:  members (1) 
      -- CP-element group 117: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_update_start__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(117) <= outputPort_1_Daemon_CP_502_elements(14);
    -- CP-element group 118:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 118: predecessors 
    -- CP-element group 118: successors 
    -- CP-element group 118: 	15 
    -- CP-element group 118: 	132 
    -- CP-element group 118:  members (2) 
      -- CP-element group 118: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_update_completed_
      -- CP-element group 118: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_update_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(118) is bound as output of CP function.
    -- CP-element group 119:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 119: predecessors 
    -- CP-element group 119: 	7 
    -- CP-element group 119: successors 
    -- CP-element group 119:  members (1) 
      -- CP-element group 119: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(119) <= outputPort_1_Daemon_CP_502_elements(7);
    -- CP-element group 120:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 120: predecessors 
    -- CP-element group 120: successors 
    -- CP-element group 120:  members (2) 
      -- CP-element group 120: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_loopback_sample_req
      -- CP-element group 120: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_loopback_sample_req_ps
      -- 
    phi_stmt_359_loopback_sample_req_762_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_359_loopback_sample_req_762_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(120), ack => phi_stmt_359_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(120) is bound as output of CP function.
    -- CP-element group 121:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 121: predecessors 
    -- CP-element group 121: 	8 
    -- CP-element group 121: successors 
    -- CP-element group 121:  members (1) 
      -- CP-element group 121: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_entry_trigger
      -- 
    outputPort_1_Daemon_CP_502_elements(121) <= outputPort_1_Daemon_CP_502_elements(8);
    -- CP-element group 122:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 122: predecessors 
    -- CP-element group 122: successors 
    -- CP-element group 122:  members (2) 
      -- CP-element group 122: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_entry_sample_req
      -- CP-element group 122: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_entry_sample_req_ps
      -- 
    phi_stmt_359_entry_sample_req_765_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_359_entry_sample_req_765_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(122), ack => phi_stmt_359_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(122) is bound as output of CP function.
    -- CP-element group 123:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 123: predecessors 
    -- CP-element group 123: successors 
    -- CP-element group 123:  members (2) 
      -- CP-element group 123: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_phi_mux_ack
      -- CP-element group 123: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/phi_stmt_359_phi_mux_ack_ps
      -- 
    phi_stmt_359_phi_mux_ack_768_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 123_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_359_ack_0, ack => outputPort_1_Daemon_CP_502_elements(123)); -- 
    -- CP-element group 124:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 124: predecessors 
    -- CP-element group 124: successors 
    -- CP-element group 124:  members (4) 
      -- CP-element group 124: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_1_361_sample_start__ps
      -- CP-element group 124: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_1_361_sample_completed__ps
      -- CP-element group 124: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_1_361_sample_start_
      -- CP-element group 124: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_1_361_sample_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(124) is bound as output of CP function.
    -- CP-element group 125:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 125: predecessors 
    -- CP-element group 125: successors 
    -- CP-element group 125: 	127 
    -- CP-element group 125:  members (2) 
      -- CP-element group 125: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_1_361_update_start__ps
      -- CP-element group 125: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_1_361_update_start_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(125) is bound as output of CP function.
    -- CP-element group 126:  join  transition  bypass  pipeline-parent 
    -- CP-element group 126: predecessors 
    -- CP-element group 126: 	127 
    -- CP-element group 126: successors 
    -- CP-element group 126:  members (1) 
      -- CP-element group 126: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_1_361_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_502_elements(126) <= outputPort_1_Daemon_CP_502_elements(127);
    -- CP-element group 127:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 127: predecessors 
    -- CP-element group 127: 	125 
    -- CP-element group 127: successors 
    -- CP-element group 127: 	126 
    -- CP-element group 127:  members (1) 
      -- CP-element group 127: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_ZERO_1_361_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(127) is a control-delay.
    cp_element_127_delay: control_delay_element  generic map(name => " 127_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_502_elements(125), ack => outputPort_1_Daemon_CP_502_elements(127), clk => clk, reset =>reset);
    -- CP-element group 128:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 128: predecessors 
    -- CP-element group 128: successors 
    -- CP-element group 128: 	130 
    -- CP-element group 128:  members (4) 
      -- CP-element group 128: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_sample_start__ps
      -- CP-element group 128: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_sample_start_
      -- CP-element group 128: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_Sample/$entry
      -- CP-element group 128: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_Sample/req
      -- 
    req_789_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_789_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(128), ack => next_pkt_1_has_priority_404_362_buf_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(128) is bound as output of CP function.
    -- CP-element group 129:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 129: predecessors 
    -- CP-element group 129: successors 
    -- CP-element group 129: 	131 
    -- CP-element group 129:  members (4) 
      -- CP-element group 129: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_update_start__ps
      -- CP-element group 129: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_update_start_
      -- CP-element group 129: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_Update/$entry
      -- CP-element group 129: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_Update/req
      -- 
    req_794_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_794_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(129), ack => next_pkt_1_has_priority_404_362_buf_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(129) is bound as output of CP function.
    -- CP-element group 130:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 130: predecessors 
    -- CP-element group 130: 	128 
    -- CP-element group 130: successors 
    -- CP-element group 130:  members (4) 
      -- CP-element group 130: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_sample_completed__ps
      -- CP-element group 130: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_sample_completed_
      -- CP-element group 130: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_Sample/$exit
      -- CP-element group 130: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_Sample/ack
      -- 
    ack_790_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 130_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_pkt_1_has_priority_404_362_buf_ack_0, ack => outputPort_1_Daemon_CP_502_elements(130)); -- 
    -- CP-element group 131:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 131: predecessors 
    -- CP-element group 131: 	129 
    -- CP-element group 131: successors 
    -- CP-element group 131:  members (4) 
      -- CP-element group 131: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_update_completed__ps
      -- CP-element group 131: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_update_completed_
      -- CP-element group 131: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_Update/$exit
      -- CP-element group 131: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/R_next_pkt_1_has_priority_362_Update/ack
      -- 
    ack_795_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 131_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_pkt_1_has_priority_404_362_buf_ack_1, ack => outputPort_1_Daemon_CP_502_elements(131)); -- 
    -- CP-element group 132:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 132: predecessors 
    -- CP-element group 132: 	19 
    -- CP-element group 132: 	38 
    -- CP-element group 132: 	59 
    -- CP-element group 132: 	80 
    -- CP-element group 132: 	118 
    -- CP-element group 132: marked-predecessors 
    -- CP-element group 132: 	134 
    -- CP-element group 132: successors 
    -- CP-element group 132: 	133 
    -- CP-element group 132:  members (3) 
      -- CP-element group 132: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_sample_start_
      -- CP-element group 132: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_Sample/$entry
      -- CP-element group 132: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_Sample/req
      -- 
    req_804_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_804_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(132), ack => WPIPE_out_data_1_482_inst_req_0); -- 
    outputPort_1_Daemon_cp_element_group_132: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 1);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 40) := "outputPort_1_Daemon_cp_element_group_132"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(19) & outputPort_1_Daemon_CP_502_elements(38) & outputPort_1_Daemon_CP_502_elements(59) & outputPort_1_Daemon_CP_502_elements(80) & outputPort_1_Daemon_CP_502_elements(118) & outputPort_1_Daemon_CP_502_elements(134);
      gj_outputPort_1_Daemon_cp_element_group_132 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(132), clk => clk, reset => reset); --
    end block;
    -- CP-element group 133:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 133: predecessors 
    -- CP-element group 133: 	132 
    -- CP-element group 133: successors 
    -- CP-element group 133: 	134 
    -- CP-element group 133: marked-successors 
    -- CP-element group 133: 	17 
    -- CP-element group 133: 	34 
    -- CP-element group 133: 	55 
    -- CP-element group 133: 	76 
    -- CP-element group 133: 	114 
    -- CP-element group 133:  members (6) 
      -- CP-element group 133: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_sample_completed_
      -- CP-element group 133: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_update_start_
      -- CP-element group 133: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_Sample/$exit
      -- CP-element group 133: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_Sample/ack
      -- CP-element group 133: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_Update/$entry
      -- CP-element group 133: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_Update/req
      -- 
    ack_805_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 133_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_data_1_482_inst_ack_0, ack => outputPort_1_Daemon_CP_502_elements(133)); -- 
    req_809_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_809_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_502_elements(133), ack => WPIPE_out_data_1_482_inst_req_1); -- 
    -- CP-element group 134:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 134: predecessors 
    -- CP-element group 134: 	133 
    -- CP-element group 134: successors 
    -- CP-element group 134: 	136 
    -- CP-element group 134: marked-successors 
    -- CP-element group 134: 	132 
    -- CP-element group 134:  members (3) 
      -- CP-element group 134: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_update_completed_
      -- CP-element group 134: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_Update/$exit
      -- CP-element group 134: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/WPIPE_out_data_1_482_Update/ack
      -- 
    ack_810_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 134_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_data_1_482_inst_ack_1, ack => outputPort_1_Daemon_CP_502_elements(134)); -- 
    -- CP-element group 135:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 135: predecessors 
    -- CP-element group 135: 	9 
    -- CP-element group 135: successors 
    -- CP-element group 135: 	10 
    -- CP-element group 135:  members (1) 
      -- CP-element group 135: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/loop_body_delay_to_condition_start
      -- 
    -- Element group outputPort_1_Daemon_CP_502_elements(135) is a control-delay.
    cp_element_135_delay: control_delay_element  generic map(name => " 135_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_502_elements(9), ack => outputPort_1_Daemon_CP_502_elements(135), clk => clk, reset =>reset);
    -- CP-element group 136:  join  transition  bypass  pipeline-parent 
    -- CP-element group 136: predecessors 
    -- CP-element group 136: 	12 
    -- CP-element group 136: 	134 
    -- CP-element group 136: successors 
    -- CP-element group 136: 	6 
    -- CP-element group 136:  members (1) 
      -- CP-element group 136: 	 branch_block_stmt_334/do_while_stmt_335/do_while_stmt_335_loop_body/$exit
      -- 
    outputPort_1_Daemon_cp_element_group_136: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 7);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 40) := "outputPort_1_Daemon_cp_element_group_136"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_502_elements(12) & outputPort_1_Daemon_CP_502_elements(134);
      gj_outputPort_1_Daemon_cp_element_group_136 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(136), clk => clk, reset => reset); --
    end block;
    -- CP-element group 137:  transition  input  bypass  pipeline-parent 
    -- CP-element group 137: predecessors 
    -- CP-element group 137: 	5 
    -- CP-element group 137: successors 
    -- CP-element group 137:  members (2) 
      -- CP-element group 137: 	 branch_block_stmt_334/do_while_stmt_335/loop_exit/$exit
      -- CP-element group 137: 	 branch_block_stmt_334/do_while_stmt_335/loop_exit/ack
      -- 
    ack_815_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 137_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_335_branch_ack_0, ack => outputPort_1_Daemon_CP_502_elements(137)); -- 
    -- CP-element group 138:  transition  input  bypass  pipeline-parent 
    -- CP-element group 138: predecessors 
    -- CP-element group 138: 	5 
    -- CP-element group 138: successors 
    -- CP-element group 138:  members (2) 
      -- CP-element group 138: 	 branch_block_stmt_334/do_while_stmt_335/loop_taken/$exit
      -- CP-element group 138: 	 branch_block_stmt_334/do_while_stmt_335/loop_taken/ack
      -- 
    ack_819_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 138_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_335_branch_ack_1, ack => outputPort_1_Daemon_CP_502_elements(138)); -- 
    -- CP-element group 139:  transition  bypass  pipeline-parent 
    -- CP-element group 139: predecessors 
    -- CP-element group 139: 	3 
    -- CP-element group 139: successors 
    -- CP-element group 139: 	1 
    -- CP-element group 139:  members (1) 
      -- CP-element group 139: 	 branch_block_stmt_334/do_while_stmt_335/$exit
      -- 
    outputPort_1_Daemon_CP_502_elements(139) <= outputPort_1_Daemon_CP_502_elements(3);
    outputPort_1_Daemon_do_while_stmt_335_terminator_820: loop_terminator -- 
      generic map (name => " outputPort_1_Daemon_do_while_stmt_335_terminator_820", max_iterations_in_flight =>7) 
      port map(loop_body_exit => outputPort_1_Daemon_CP_502_elements(6),loop_continue => outputPort_1_Daemon_CP_502_elements(138),loop_terminate => outputPort_1_Daemon_CP_502_elements(137),loop_back => outputPort_1_Daemon_CP_502_elements(4),loop_exit => outputPort_1_Daemon_CP_502_elements(3),clk => clk, reset => reset); -- 
    phi_stmt_337_phi_seq_576_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_502_elements(22);
      outputPort_1_Daemon_CP_502_elements(25)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_502_elements(25);
      outputPort_1_Daemon_CP_502_elements(26)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_502_elements(27);
      outputPort_1_Daemon_CP_502_elements(23) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_502_elements(20);
      outputPort_1_Daemon_CP_502_elements(29)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_502_elements(31);
      outputPort_1_Daemon_CP_502_elements(30)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_502_elements(32);
      outputPort_1_Daemon_CP_502_elements(21) <= phi_mux_reqs(1);
      phi_stmt_337_phi_seq_576 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_337_phi_seq_576") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_502_elements(11), 
          phi_sample_ack => outputPort_1_Daemon_CP_502_elements(18), 
          phi_update_req => outputPort_1_Daemon_CP_502_elements(14), 
          phi_update_ack => outputPort_1_Daemon_CP_502_elements(19), 
          phi_mux_ack => outputPort_1_Daemon_CP_502_elements(24), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_341_phi_seq_620_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_502_elements(39);
      outputPort_1_Daemon_CP_502_elements(44)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_502_elements(48);
      outputPort_1_Daemon_CP_502_elements(45)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_502_elements(49);
      outputPort_1_Daemon_CP_502_elements(40) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_502_elements(41);
      outputPort_1_Daemon_CP_502_elements(50)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_502_elements(50);
      outputPort_1_Daemon_CP_502_elements(51)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_502_elements(52);
      outputPort_1_Daemon_CP_502_elements(42) <= phi_mux_reqs(1);
      phi_stmt_341_phi_seq_620 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_341_phi_seq_620") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_502_elements(35), 
          phi_sample_ack => outputPort_1_Daemon_CP_502_elements(36), 
          phi_update_req => outputPort_1_Daemon_CP_502_elements(37), 
          phi_update_ack => outputPort_1_Daemon_CP_502_elements(38), 
          phi_mux_ack => outputPort_1_Daemon_CP_502_elements(43), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_346_phi_seq_664_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_502_elements(62);
      outputPort_1_Daemon_CP_502_elements(65)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_502_elements(65);
      outputPort_1_Daemon_CP_502_elements(66)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_502_elements(67);
      outputPort_1_Daemon_CP_502_elements(63) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_502_elements(60);
      outputPort_1_Daemon_CP_502_elements(69)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_502_elements(73);
      outputPort_1_Daemon_CP_502_elements(70)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_502_elements(74);
      outputPort_1_Daemon_CP_502_elements(61) <= phi_mux_reqs(1);
      phi_stmt_346_phi_seq_664 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_346_phi_seq_664") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_502_elements(56), 
          phi_sample_ack => outputPort_1_Daemon_CP_502_elements(57), 
          phi_update_req => outputPort_1_Daemon_CP_502_elements(58), 
          phi_update_ack => outputPort_1_Daemon_CP_502_elements(59), 
          phi_mux_ack => outputPort_1_Daemon_CP_502_elements(64), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_351_phi_seq_708_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_502_elements(83);
      outputPort_1_Daemon_CP_502_elements(86)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_502_elements(86);
      outputPort_1_Daemon_CP_502_elements(87)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_502_elements(88);
      outputPort_1_Daemon_CP_502_elements(84) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_502_elements(81);
      outputPort_1_Daemon_CP_502_elements(90)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_502_elements(92);
      outputPort_1_Daemon_CP_502_elements(91)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_502_elements(93);
      outputPort_1_Daemon_CP_502_elements(82) <= phi_mux_reqs(1);
      phi_stmt_351_phi_seq_708 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_351_phi_seq_708") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_502_elements(77), 
          phi_sample_ack => outputPort_1_Daemon_CP_502_elements(78), 
          phi_update_req => outputPort_1_Daemon_CP_502_elements(79), 
          phi_update_ack => outputPort_1_Daemon_CP_502_elements(80), 
          phi_mux_ack => outputPort_1_Daemon_CP_502_elements(85), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_355_phi_seq_752_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_502_elements(102);
      outputPort_1_Daemon_CP_502_elements(105)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_502_elements(105);
      outputPort_1_Daemon_CP_502_elements(106)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_502_elements(107);
      outputPort_1_Daemon_CP_502_elements(103) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_502_elements(100);
      outputPort_1_Daemon_CP_502_elements(109)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_502_elements(111);
      outputPort_1_Daemon_CP_502_elements(110)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_502_elements(112);
      outputPort_1_Daemon_CP_502_elements(101) <= phi_mux_reqs(1);
      phi_stmt_355_phi_seq_752 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_355_phi_seq_752") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_502_elements(96), 
          phi_sample_ack => outputPort_1_Daemon_CP_502_elements(97), 
          phi_update_req => outputPort_1_Daemon_CP_502_elements(98), 
          phi_update_ack => outputPort_1_Daemon_CP_502_elements(99), 
          phi_mux_ack => outputPort_1_Daemon_CP_502_elements(104), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_359_phi_seq_796_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_502_elements(121);
      outputPort_1_Daemon_CP_502_elements(124)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_502_elements(124);
      outputPort_1_Daemon_CP_502_elements(125)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_502_elements(126);
      outputPort_1_Daemon_CP_502_elements(122) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_502_elements(119);
      outputPort_1_Daemon_CP_502_elements(128)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_502_elements(130);
      outputPort_1_Daemon_CP_502_elements(129)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_502_elements(131);
      outputPort_1_Daemon_CP_502_elements(120) <= phi_mux_reqs(1);
      phi_stmt_359_phi_seq_796 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_359_phi_seq_796") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_502_elements(115), 
          phi_sample_ack => outputPort_1_Daemon_CP_502_elements(116), 
          phi_update_req => outputPort_1_Daemon_CP_502_elements(117), 
          phi_update_ack => outputPort_1_Daemon_CP_502_elements(118), 
          phi_mux_ack => outputPort_1_Daemon_CP_502_elements(123), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    entry_tmerge_527_block : block -- 
      signal preds : BooleanArray(0 to 1);
      begin -- 
        preds(0)  <= outputPort_1_Daemon_CP_502_elements(7);
        preds(1)  <= outputPort_1_Daemon_CP_502_elements(8);
        entry_tmerge_527 : transition_merge -- 
          generic map(name => " entry_tmerge_527")
          port map (preds => preds, symbol_out => outputPort_1_Daemon_CP_502_elements(9));
          -- 
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal EQ_u2_u1_385_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_391_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_418_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_445_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_453_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_459_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_469_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_475_wire : std_logic_vector(0 downto 0);
    signal EQ_u8_u1_411_wire : std_logic_vector(0 downto 0);
    signal MUX_388_wire : std_logic_vector(0 downto 0);
    signal MUX_394_wire : std_logic_vector(0 downto 0);
    signal MUX_423_wire : std_logic_vector(7 downto 0);
    signal MUX_437_wire : std_logic_vector(7 downto 0);
    signal MUX_472_wire : std_logic_vector(0 downto 0);
    signal MUX_478_wire : std_logic_vector(0 downto 0);
    signal NEQ_u2_u1_408_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_442_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_450_wire : std_logic_vector(0 downto 0);
    signal RPIPE_noblock_obuf_1_1_344_wire : std_logic_vector(32 downto 0);
    signal RPIPE_noblock_obuf_2_1_350_wire : std_logic_vector(32 downto 0);
    signal R_ZERO_1_361_wire_constant : std_logic_vector(0 downto 0);
    signal R_ZERO_2_353_wire_constant : std_logic_vector(1 downto 0);
    signal R_ZERO_33_345_wire_constant : std_logic_vector(32 downto 0);
    signal R_ZERO_33_348_wire_constant : std_logic_vector(32 downto 0);
    signal R_ZERO_8_339_wire_constant : std_logic_vector(7 downto 0);
    signal R_ZERO_8_357_wire_constant : std_logic_vector(7 downto 0);
    signal SUB_u8_u8_431_wire : std_logic_vector(7 downto 0);
    signal SUB_u8_u8_435_wire : std_logic_vector(7 downto 0);
    signal active_packet_351 : std_logic_vector(1 downto 0);
    signal active_packet_length_355 : std_logic_vector(7 downto 0);
    signal data_to_out_465 : std_logic_vector(31 downto 0);
    signal down_counter_337 : std_logic_vector(7 downto 0);
    signal konst_366_wire_constant : std_logic_vector(32 downto 0);
    signal konst_371_wire_constant : std_logic_vector(32 downto 0);
    signal konst_384_wire_constant : std_logic_vector(1 downto 0);
    signal konst_387_wire_constant : std_logic_vector(0 downto 0);
    signal konst_390_wire_constant : std_logic_vector(1 downto 0);
    signal konst_393_wire_constant : std_logic_vector(0 downto 0);
    signal konst_407_wire_constant : std_logic_vector(1 downto 0);
    signal konst_410_wire_constant : std_logic_vector(7 downto 0);
    signal konst_417_wire_constant : std_logic_vector(1 downto 0);
    signal konst_430_wire_constant : std_logic_vector(7 downto 0);
    signal konst_434_wire_constant : std_logic_vector(7 downto 0);
    signal konst_444_wire_constant : std_logic_vector(1 downto 0);
    signal konst_452_wire_constant : std_logic_vector(1 downto 0);
    signal konst_458_wire_constant : std_logic_vector(1 downto 0);
    signal konst_468_wire_constant : std_logic_vector(1 downto 0);
    signal konst_471_wire_constant : std_logic_vector(0 downto 0);
    signal konst_474_wire_constant : std_logic_vector(1 downto 0);
    signal konst_477_wire_constant : std_logic_vector(0 downto 0);
    signal konst_493_wire_constant : std_logic_vector(0 downto 0);
    signal next_active_packet_404 : std_logic_vector(1 downto 0);
    signal next_active_packet_404_354_buffered : std_logic_vector(1 downto 0);
    signal next_active_packet_length_426 : std_logic_vector(7 downto 0);
    signal next_active_packet_length_426_358_buffered : std_logic_vector(7 downto 0);
    signal next_down_counter_439 : std_logic_vector(7 downto 0);
    signal next_down_counter_439_340_buffered : std_logic_vector(7 downto 0);
    signal next_pkt_1_has_priority_404 : std_logic_vector(0 downto 0);
    signal next_pkt_1_has_priority_404_362_buffered : std_logic_vector(0 downto 0);
    signal p1_valid_368 : std_logic_vector(0 downto 0);
    signal p2_valid_373 : std_logic_vector(0 downto 0);
    signal pkt_1_e_word_341 : std_logic_vector(32 downto 0);
    signal pkt_1_has_priority_359 : std_logic_vector(0 downto 0);
    signal pkt_2_e_word_346 : std_logic_vector(32 downto 0);
    signal read_from_1_447 : std_logic_vector(0 downto 0);
    signal read_from_2_455 : std_logic_vector(0 downto 0);
    signal send_flag_480 : std_logic_vector(0 downto 0);
    signal slice_420_wire : std_logic_vector(7 downto 0);
    signal slice_422_wire : std_logic_vector(7 downto 0);
    signal slice_461_wire : std_logic_vector(31 downto 0);
    signal slice_463_wire : std_logic_vector(31 downto 0);
    signal started_new_packet_413 : std_logic_vector(0 downto 0);
    signal valid_active_pkt_word_read_396 : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    R_ZERO_1_361_wire_constant <= "0";
    R_ZERO_2_353_wire_constant <= "00";
    R_ZERO_33_345_wire_constant <= "000000000000000000000000000000000";
    R_ZERO_33_348_wire_constant <= "000000000000000000000000000000000";
    R_ZERO_8_339_wire_constant <= "00000000";
    R_ZERO_8_357_wire_constant <= "00000000";
    konst_366_wire_constant <= "000000000000000000000000000100000";
    konst_371_wire_constant <= "000000000000000000000000000100000";
    konst_384_wire_constant <= "01";
    konst_387_wire_constant <= "0";
    konst_390_wire_constant <= "10";
    konst_393_wire_constant <= "0";
    konst_407_wire_constant <= "00";
    konst_410_wire_constant <= "00000000";
    konst_417_wire_constant <= "01";
    konst_430_wire_constant <= "00000001";
    konst_434_wire_constant <= "00000001";
    konst_444_wire_constant <= "01";
    konst_452_wire_constant <= "10";
    konst_458_wire_constant <= "01";
    konst_468_wire_constant <= "01";
    konst_471_wire_constant <= "0";
    konst_474_wire_constant <= "10";
    konst_477_wire_constant <= "0";
    konst_493_wire_constant <= "1";
    phi_stmt_337: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_8_339_wire_constant & next_down_counter_439_340_buffered;
      req <= phi_stmt_337_req_0 & phi_stmt_337_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_337",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_337_ack_0,
          idata => idata,
          odata => down_counter_337,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_337
    phi_stmt_341: Block -- phi operator 
      signal idata: std_logic_vector(65 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= RPIPE_noblock_obuf_1_1_344_wire & R_ZERO_33_345_wire_constant;
      req <= phi_stmt_341_req_0 & phi_stmt_341_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_341",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 33) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_341_ack_0,
          idata => idata,
          odata => pkt_1_e_word_341,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_341
    phi_stmt_346: Block -- phi operator 
      signal idata: std_logic_vector(65 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_33_348_wire_constant & RPIPE_noblock_obuf_2_1_350_wire;
      req <= phi_stmt_346_req_0 & phi_stmt_346_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_346",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 33) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_346_ack_0,
          idata => idata,
          odata => pkt_2_e_word_346,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_346
    phi_stmt_351: Block -- phi operator 
      signal idata: std_logic_vector(3 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_2_353_wire_constant & next_active_packet_404_354_buffered;
      req <= phi_stmt_351_req_0 & phi_stmt_351_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_351",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 2) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_351_ack_0,
          idata => idata,
          odata => active_packet_351,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_351
    phi_stmt_355: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_8_357_wire_constant & next_active_packet_length_426_358_buffered;
      req <= phi_stmt_355_req_0 & phi_stmt_355_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_355",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_355_ack_0,
          idata => idata,
          odata => active_packet_length_355,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_355
    phi_stmt_359: Block -- phi operator 
      signal idata: std_logic_vector(1 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_1_361_wire_constant & next_pkt_1_has_priority_404_362_buffered;
      req <= phi_stmt_359_req_0 & phi_stmt_359_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_359",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 1) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_359_ack_0,
          idata => idata,
          odata => pkt_1_has_priority_359,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_359
    -- flow-through select operator MUX_388_inst
    MUX_388_wire <= p1_valid_368 when (EQ_u2_u1_385_wire(0) /=  '0') else konst_387_wire_constant;
    -- flow-through select operator MUX_394_inst
    MUX_394_wire <= p2_valid_373 when (EQ_u2_u1_391_wire(0) /=  '0') else konst_393_wire_constant;
    -- flow-through select operator MUX_423_inst
    MUX_423_wire <= slice_420_wire when (EQ_u2_u1_418_wire(0) /=  '0') else slice_422_wire;
    -- flow-through select operator MUX_425_inst
    next_active_packet_length_426 <= MUX_423_wire when (started_new_packet_413(0) /=  '0') else active_packet_length_355;
    -- flow-through select operator MUX_437_inst
    MUX_437_wire <= SUB_u8_u8_435_wire when (valid_active_pkt_word_read_396(0) /=  '0') else down_counter_337;
    -- flow-through select operator MUX_438_inst
    next_down_counter_439 <= SUB_u8_u8_431_wire when (started_new_packet_413(0) /=  '0') else MUX_437_wire;
    -- flow-through select operator MUX_464_inst
    data_to_out_465 <= slice_461_wire when (EQ_u2_u1_459_wire(0) /=  '0') else slice_463_wire;
    -- flow-through select operator MUX_472_inst
    MUX_472_wire <= p1_valid_368 when (EQ_u2_u1_469_wire(0) /=  '0') else konst_471_wire_constant;
    -- flow-through select operator MUX_478_inst
    MUX_478_wire <= p2_valid_373 when (EQ_u2_u1_475_wire(0) /=  '0') else konst_477_wire_constant;
    -- flow-through slice operator slice_420_inst
    slice_420_wire <= pkt_1_e_word_341(15 downto 8);
    -- flow-through slice operator slice_422_inst
    slice_422_wire <= pkt_2_e_word_346(15 downto 8);
    -- flow-through slice operator slice_461_inst
    slice_461_wire <= pkt_1_e_word_341(31 downto 0);
    -- flow-through slice operator slice_463_inst
    slice_463_wire <= pkt_2_e_word_346(31 downto 0);
    next_active_packet_404_354_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_active_packet_404_354_buf_req_0;
      next_active_packet_404_354_buf_ack_0<= wack(0);
      rreq(0) <= next_active_packet_404_354_buf_req_1;
      next_active_packet_404_354_buf_ack_1<= rack(0);
      next_active_packet_404_354_buf : InterlockBuffer generic map ( -- 
        name => "next_active_packet_404_354_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 2,
        out_data_width => 2,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_active_packet_404,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_active_packet_404_354_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_active_packet_length_426_358_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_active_packet_length_426_358_buf_req_0;
      next_active_packet_length_426_358_buf_ack_0<= wack(0);
      rreq(0) <= next_active_packet_length_426_358_buf_req_1;
      next_active_packet_length_426_358_buf_ack_1<= rack(0);
      next_active_packet_length_426_358_buf : InterlockBuffer generic map ( -- 
        name => "next_active_packet_length_426_358_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_active_packet_length_426,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_active_packet_length_426_358_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_down_counter_439_340_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_down_counter_439_340_buf_req_0;
      next_down_counter_439_340_buf_ack_0<= wack(0);
      rreq(0) <= next_down_counter_439_340_buf_req_1;
      next_down_counter_439_340_buf_ack_1<= rack(0);
      next_down_counter_439_340_buf : InterlockBuffer generic map ( -- 
        name => "next_down_counter_439_340_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_down_counter_439,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_down_counter_439_340_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_pkt_1_has_priority_404_362_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_pkt_1_has_priority_404_362_buf_req_0;
      next_pkt_1_has_priority_404_362_buf_ack_0<= wack(0);
      rreq(0) <= next_pkt_1_has_priority_404_362_buf_req_1;
      next_pkt_1_has_priority_404_362_buf_ack_1<= rack(0);
      next_pkt_1_has_priority_404_362_buf : InterlockBuffer generic map ( -- 
        name => "next_pkt_1_has_priority_404_362_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 1,
        out_data_width => 1,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_pkt_1_has_priority_404,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_pkt_1_has_priority_404_362_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    do_while_stmt_335_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= konst_493_wire_constant;
      branch_instance: BranchBase -- 
        generic map( name => "do_while_stmt_335_branch", condition_width => 1,  bypass_flag => true)
        port map( -- 
          condition => condition_sig,
          req => do_while_stmt_335_branch_req_0,
          ack0 => do_while_stmt_335_branch_ack_0,
          ack1 => do_while_stmt_335_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- flow through binary operator AND_u1_u1_412_inst
    started_new_packet_413 <= (NEQ_u2_u1_408_wire and EQ_u8_u1_411_wire);
    -- flow through binary operator BITSEL_u33_u1_367_inst
    process(pkt_1_e_word_341) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApBitsel_proc(pkt_1_e_word_341, konst_366_wire_constant, tmp_var);
      p1_valid_368 <= tmp_var; --
    end process;
    -- flow through binary operator BITSEL_u33_u1_372_inst
    process(pkt_2_e_word_346) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApBitsel_proc(pkt_2_e_word_346, konst_371_wire_constant, tmp_var);
      p2_valid_373 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_385_inst
    process(active_packet_351) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(active_packet_351, konst_384_wire_constant, tmp_var);
      EQ_u2_u1_385_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_391_inst
    process(active_packet_351) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(active_packet_351, konst_390_wire_constant, tmp_var);
      EQ_u2_u1_391_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_418_inst
    process(next_active_packet_404) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_404, konst_417_wire_constant, tmp_var);
      EQ_u2_u1_418_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_445_inst
    process(next_active_packet_404) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_404, konst_444_wire_constant, tmp_var);
      EQ_u2_u1_445_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_453_inst
    process(next_active_packet_404) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_404, konst_452_wire_constant, tmp_var);
      EQ_u2_u1_453_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_459_inst
    process(next_active_packet_404) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_404, konst_458_wire_constant, tmp_var);
      EQ_u2_u1_459_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_469_inst
    process(next_active_packet_404) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_404, konst_468_wire_constant, tmp_var);
      EQ_u2_u1_469_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_475_inst
    process(next_active_packet_404) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_404, konst_474_wire_constant, tmp_var);
      EQ_u2_u1_475_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_411_inst
    process(down_counter_337) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(down_counter_337, konst_410_wire_constant, tmp_var);
      EQ_u8_u1_411_wire <= tmp_var; --
    end process;
    -- flow through binary operator NEQ_u2_u1_408_inst
    process(next_active_packet_404) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntNe_proc(next_active_packet_404, konst_407_wire_constant, tmp_var);
      NEQ_u2_u1_408_wire <= tmp_var; --
    end process;
    -- unary operator NOT_u1_u1_442_inst
    process(p1_valid_368) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p1_valid_368, tmp_var);
      NOT_u1_u1_442_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_450_inst
    process(p2_valid_373) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p2_valid_373, tmp_var);
      NOT_u1_u1_450_wire <= tmp_var; -- 
    end process;
    -- flow through binary operator OR_u1_u1_395_inst
    valid_active_pkt_word_read_396 <= (MUX_388_wire or MUX_394_wire);
    -- flow through binary operator OR_u1_u1_446_inst
    read_from_1_447 <= (NOT_u1_u1_442_wire or EQ_u2_u1_445_wire);
    -- flow through binary operator OR_u1_u1_454_inst
    read_from_2_455 <= (NOT_u1_u1_450_wire or EQ_u2_u1_453_wire);
    -- flow through binary operator OR_u1_u1_479_inst
    send_flag_480 <= (MUX_472_wire or MUX_478_wire);
    -- flow through binary operator SUB_u8_u8_431_inst
    SUB_u8_u8_431_wire <= std_logic_vector(unsigned(next_active_packet_length_426) - unsigned(konst_430_wire_constant));
    -- flow through binary operator SUB_u8_u8_435_inst
    SUB_u8_u8_435_wire <= std_logic_vector(unsigned(down_counter_337) - unsigned(konst_434_wire_constant));
    -- shared inport operator group (0) : RPIPE_noblock_obuf_1_1_344_inst 
    InportGroup_0: Block -- 
      signal data_out: std_logic_vector(32 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_noblock_obuf_1_1_344_inst_req_0;
      RPIPE_noblock_obuf_1_1_344_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_noblock_obuf_1_1_344_inst_req_1;
      RPIPE_noblock_obuf_1_1_344_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <= read_from_1_447(0);
      RPIPE_noblock_obuf_1_1_344_wire <= data_out(32 downto 0);
      noblock_obuf_1_1_read_0_gI: SplitGuardInterface generic map(name => "noblock_obuf_1_1_read_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_1_1_read_0: InputPortRevised -- 
        generic map ( name => "noblock_obuf_1_1_read_0", data_width => 33,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => true,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => noblock_obuf_1_1_pipe_read_req(0),
          oack => noblock_obuf_1_1_pipe_read_ack(0),
          odata => noblock_obuf_1_1_pipe_read_data(32 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared inport operator group (1) : RPIPE_noblock_obuf_2_1_350_inst 
    InportGroup_1: Block -- 
      signal data_out: std_logic_vector(32 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_noblock_obuf_2_1_350_inst_req_0;
      RPIPE_noblock_obuf_2_1_350_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_noblock_obuf_2_1_350_inst_req_1;
      RPIPE_noblock_obuf_2_1_350_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <= read_from_2_455(0);
      RPIPE_noblock_obuf_2_1_350_wire <= data_out(32 downto 0);
      noblock_obuf_2_1_read_1_gI: SplitGuardInterface generic map(name => "noblock_obuf_2_1_read_1_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_2_1_read_1: InputPortRevised -- 
        generic map ( name => "noblock_obuf_2_1_read_1", data_width => 33,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => true,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => noblock_obuf_2_1_pipe_read_req(0),
          oack => noblock_obuf_2_1_pipe_read_ack(0),
          odata => noblock_obuf_2_1_pipe_read_data(32 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 1
    -- shared outport operator group (0) : WPIPE_out_data_1_482_inst 
    OutportGroup_0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_out_data_1_482_inst_req_0;
      WPIPE_out_data_1_482_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_out_data_1_482_inst_req_1;
      WPIPE_out_data_1_482_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_flag_480(0);
      data_in <= data_to_out_465;
      out_data_1_write_0_gI: SplitGuardInterface generic map(name => "out_data_1_write_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      out_data_1_write_0: OutputPortRevised -- 
        generic map ( name => "out_data_1", data_width => 32, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => out_data_1_pipe_write_req(0),
          oack => out_data_1_pipe_write_ack(0),
          odata => out_data_1_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    volatile_operator_prioritySelect_1172: prioritySelect_Volatile port map(down_counter => down_counter_337, active_packet => active_packet_351, pkt_1_has_priority => pkt_1_has_priority_359, p1_valid => p1_valid_368, p2_valid => p2_valid_373, next_active_packet => next_active_packet_404, next_pkt_1_has_priority => next_pkt_1_has_priority_404); 
    -- 
  end Block; -- data_path
  -- 
end outputPort_1_Daemon_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.ahir_system_global_package.all;
entity outputPort_2_Daemon is -- 
  generic (tag_length : integer); 
  port ( -- 
    noblock_obuf_2_2_pipe_read_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_2_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_2_2_pipe_read_data : in   std_logic_vector(32 downto 0);
    noblock_obuf_1_2_pipe_read_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_1_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_1_2_pipe_read_data : in   std_logic_vector(32 downto 0);
    out_data_2_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_data_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_data_2_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) ;
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic-- 
  );
  -- 
end entity outputPort_2_Daemon;
architecture outputPort_2_Daemon_arch of outputPort_2_Daemon is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal outputPort_2_Daemon_CP_821_start: Boolean;
  signal outputPort_2_Daemon_CP_821_symbol: Boolean;
  -- volatile/operator module components. 
  component prioritySelect_Volatile is -- 
    port ( -- 
      down_counter : in  std_logic_vector(7 downto 0);
      active_packet : in  std_logic_vector(1 downto 0);
      pkt_1_has_priority : in  std_logic_vector(0 downto 0);
      p1_valid : in  std_logic_vector(0 downto 0);
      p2_valid : in  std_logic_vector(0 downto 0);
      next_active_packet : out  std_logic_vector(1 downto 0);
      next_pkt_1_has_priority : out  std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component; 
  -- links between control-path and data-path
  signal RPIPE_noblock_obuf_1_2_508_inst_ack_1 : boolean;
  signal next_down_counter_602_503_buf_req_0 : boolean;
  signal phi_stmt_500_ack_0 : boolean;
  signal RPIPE_noblock_obuf_1_2_508_inst_req_0 : boolean;
  signal next_down_counter_602_503_buf_ack_0 : boolean;
  signal phi_stmt_514_ack_0 : boolean;
  signal RPIPE_noblock_obuf_2_2_513_inst_ack_0 : boolean;
  signal phi_stmt_504_ack_0 : boolean;
  signal phi_stmt_518_ack_0 : boolean;
  signal next_down_counter_602_503_buf_ack_1 : boolean;
  signal RPIPE_noblock_obuf_2_2_513_inst_req_1 : boolean;
  signal RPIPE_noblock_obuf_1_2_508_inst_ack_0 : boolean;
  signal RPIPE_noblock_obuf_2_2_513_inst_req_0 : boolean;
  signal RPIPE_noblock_obuf_2_2_513_inst_ack_1 : boolean;
  signal phi_stmt_500_req_0 : boolean;
  signal phi_stmt_509_req_1 : boolean;
  signal next_active_packet_567_517_buf_req_1 : boolean;
  signal phi_stmt_509_req_0 : boolean;
  signal next_active_packet_length_589_521_buf_req_1 : boolean;
  signal next_active_packet_567_517_buf_ack_0 : boolean;
  signal next_active_packet_567_517_buf_req_0 : boolean;
  signal next_down_counter_602_503_buf_req_1 : boolean;
  signal phi_stmt_504_req_1 : boolean;
  signal RPIPE_noblock_obuf_1_2_508_inst_req_1 : boolean;
  signal phi_stmt_500_req_1 : boolean;
  signal phi_stmt_514_req_1 : boolean;
  signal phi_stmt_509_ack_0 : boolean;
  signal phi_stmt_504_req_0 : boolean;
  signal phi_stmt_514_req_0 : boolean;
  signal phi_stmt_522_req_1 : boolean;
  signal next_active_packet_567_517_buf_ack_1 : boolean;
  signal do_while_stmt_498_branch_req_0 : boolean;
  signal phi_stmt_518_req_0 : boolean;
  signal phi_stmt_518_req_1 : boolean;
  signal next_active_packet_length_589_521_buf_req_0 : boolean;
  signal next_active_packet_length_589_521_buf_ack_0 : boolean;
  signal next_active_packet_length_589_521_buf_ack_1 : boolean;
  signal phi_stmt_522_req_0 : boolean;
  signal phi_stmt_522_ack_0 : boolean;
  signal next_pkt_1_has_priority_567_525_buf_req_0 : boolean;
  signal next_pkt_1_has_priority_567_525_buf_ack_0 : boolean;
  signal next_pkt_1_has_priority_567_525_buf_req_1 : boolean;
  signal next_pkt_1_has_priority_567_525_buf_ack_1 : boolean;
  signal WPIPE_out_data_2_645_inst_req_0 : boolean;
  signal WPIPE_out_data_2_645_inst_ack_0 : boolean;
  signal WPIPE_out_data_2_645_inst_req_1 : boolean;
  signal WPIPE_out_data_2_645_inst_ack_1 : boolean;
  signal do_while_stmt_498_branch_ack_0 : boolean;
  signal do_while_stmt_498_branch_ack_1 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "outputPort_2_Daemon_input_buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj_in_buffer_unload_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  outputPort_2_Daemon_CP_821_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "outputPort_2_Daemon_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 0) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= outputPort_2_Daemon_CP_821_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj_out_buffer_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= outputPort_2_Daemon_CP_821_start & tag_ilock_write_ack_symbol;
    gj_tag_ilock_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= outputPort_2_Daemon_CP_821_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  outputPort_2_Daemon_CP_821: Block -- control-path 
    signal outputPort_2_Daemon_CP_821_elements: BooleanArray(139 downto 0);
    -- 
  begin -- 
    outputPort_2_Daemon_CP_821_elements(0) <= outputPort_2_Daemon_CP_821_start;
    outputPort_2_Daemon_CP_821_symbol <= outputPort_2_Daemon_CP_821_elements(1);
    -- CP-element group 0:  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	2 
    -- CP-element group 0:  members (4) 
      -- CP-element group 0: 	 branch_block_stmt_497/do_while_stmt_498__entry__
      -- CP-element group 0: 	 branch_block_stmt_497/branch_block_stmt_497__entry__
      -- CP-element group 0: 	 branch_block_stmt_497/$entry
      -- CP-element group 0: 	 $entry
      -- 
    -- CP-element group 1:  transition  place  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	139 
    -- CP-element group 1: successors 
    -- CP-element group 1:  members (4) 
      -- CP-element group 1: 	 branch_block_stmt_497/do_while_stmt_498__exit__
      -- CP-element group 1: 	 branch_block_stmt_497/branch_block_stmt_497__exit__
      -- CP-element group 1: 	 branch_block_stmt_497/$exit
      -- CP-element group 1: 	 $exit
      -- 
    outputPort_2_Daemon_CP_821_elements(1) <= outputPort_2_Daemon_CP_821_elements(139);
    -- CP-element group 2:  transition  place  bypass  pipeline-parent 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	0 
    -- CP-element group 2: successors 
    -- CP-element group 2: 	8 
    -- CP-element group 2:  members (2) 
      -- CP-element group 2: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498__entry__
      -- CP-element group 2: 	 branch_block_stmt_497/do_while_stmt_498/$entry
      -- 
    outputPort_2_Daemon_CP_821_elements(2) <= outputPort_2_Daemon_CP_821_elements(0);
    -- CP-element group 3:  merge  place  bypass  pipeline-parent 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	139 
    -- CP-element group 3:  members (1) 
      -- CP-element group 3: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498__exit__
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(3) is bound as output of CP function.
    -- CP-element group 4:  merge  place  bypass  pipeline-parent 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: successors 
    -- CP-element group 4: 	7 
    -- CP-element group 4:  members (1) 
      -- CP-element group 4: 	 branch_block_stmt_497/do_while_stmt_498/loop_back
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(4) is bound as output of CP function.
    -- CP-element group 5:  branch  transition  place  bypass  pipeline-parent 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	10 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	137 
    -- CP-element group 5: 	138 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_497/do_while_stmt_498/condition_done
      -- CP-element group 5: 	 branch_block_stmt_497/do_while_stmt_498/loop_exit/$entry
      -- CP-element group 5: 	 branch_block_stmt_497/do_while_stmt_498/loop_taken/$entry
      -- 
    outputPort_2_Daemon_CP_821_elements(5) <= outputPort_2_Daemon_CP_821_elements(10);
    -- CP-element group 6:  branch  place  bypass  pipeline-parent 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	136 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (1) 
      -- CP-element group 6: 	 branch_block_stmt_497/do_while_stmt_498/loop_body_done
      -- 
    outputPort_2_Daemon_CP_821_elements(6) <= outputPort_2_Daemon_CP_821_elements(136);
    -- CP-element group 7:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	4 
    -- CP-element group 7: successors 
    -- CP-element group 7: 	41 
    -- CP-element group 7: 	60 
    -- CP-element group 7: 	100 
    -- CP-element group 7: 	81 
    -- CP-element group 7: 	22 
    -- CP-element group 7: 	119 
    -- CP-element group 7:  members (1) 
      -- CP-element group 7: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/back_edge_to_loop_body
      -- 
    outputPort_2_Daemon_CP_821_elements(7) <= outputPort_2_Daemon_CP_821_elements(4);
    -- CP-element group 8:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	2 
    -- CP-element group 8: successors 
    -- CP-element group 8: 	83 
    -- CP-element group 8: 	102 
    -- CP-element group 8: 	43 
    -- CP-element group 8: 	24 
    -- CP-element group 8: 	62 
    -- CP-element group 8: 	121 
    -- CP-element group 8:  members (1) 
      -- CP-element group 8: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/first_time_through_loop_body
      -- 
    outputPort_2_Daemon_CP_821_elements(8) <= outputPort_2_Daemon_CP_821_elements(2);
    -- CP-element group 9:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	57 
    -- CP-element group 9: 	75 
    -- CP-element group 9: 	76 
    -- CP-element group 9: 	135 
    -- CP-element group 9: 	56 
    -- CP-element group 9: 	16 
    -- CP-element group 9: 	17 
    -- CP-element group 9: 	113 
    -- CP-element group 9: 	114 
    -- CP-element group 9: 	36 
    -- CP-element group 9: 	35 
    -- CP-element group 9: 	94 
    -- CP-element group 9: 	95 
    -- CP-element group 9:  members (2) 
      -- CP-element group 9: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/loop_body_start
      -- CP-element group 9: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/$entry
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(9) is bound as output of CP function.
    -- CP-element group 10:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	135 
    -- CP-element group 10: 	13 
    -- CP-element group 10: 	15 
    -- CP-element group 10: successors 
    -- CP-element group 10: 	5 
    -- CP-element group 10:  members (1) 
      -- CP-element group 10: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/condition_evaluated
      -- 
    condition_evaluated_845_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " condition_evaluated_845_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(10), ack => do_while_stmt_498_branch_req_0); -- 
    outputPort_2_Daemon_cp_element_group_10: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_10"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(135) & outputPort_2_Daemon_CP_821_elements(13) & outputPort_2_Daemon_CP_821_elements(15);
      gj_outputPort_2_Daemon_cp_element_group_10 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(10), clk => clk, reset => reset); --
    end block;
    -- CP-element group 11:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	75 
    -- CP-element group 11: 	56 
    -- CP-element group 11: 	16 
    -- CP-element group 11: 	113 
    -- CP-element group 11: 	35 
    -- CP-element group 11: 	94 
    -- CP-element group 11: marked-predecessors 
    -- CP-element group 11: 	15 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	77 
    -- CP-element group 11: 	18 
    -- CP-element group 11: 	115 
    -- CP-element group 11: 	37 
    -- CP-element group 11: 	96 
    -- CP-element group 11:  members (2) 
      -- CP-element group 11: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_sample_start__ps
      -- CP-element group 11: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/aggregated_phi_sample_req
      -- 
    outputPort_2_Daemon_cp_element_group_11: block -- 
      constant place_capacities: IntegerArray(0 to 6) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1,6 => 1);
      constant place_markings: IntegerArray(0 to 6)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0,6 => 1);
      constant place_delays: IntegerArray(0 to 6) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0,6 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_11"; 
      signal preds: BooleanArray(1 to 7); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(75) & outputPort_2_Daemon_CP_821_elements(56) & outputPort_2_Daemon_CP_821_elements(16) & outputPort_2_Daemon_CP_821_elements(113) & outputPort_2_Daemon_CP_821_elements(35) & outputPort_2_Daemon_CP_821_elements(94) & outputPort_2_Daemon_CP_821_elements(15);
      gj_outputPort_2_Daemon_cp_element_group_11 : generic_join generic map(name => joinName, number_of_predecessors => 7, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(11), clk => clk, reset => reset); --
    end block;
    -- CP-element group 12:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	58 
    -- CP-element group 12: 	78 
    -- CP-element group 12: 	19 
    -- CP-element group 12: 	116 
    -- CP-element group 12: 	38 
    -- CP-element group 12: 	97 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	136 
    -- CP-element group 12: 	13 
    -- CP-element group 12: marked-successors 
    -- CP-element group 12: 	75 
    -- CP-element group 12: 	56 
    -- CP-element group 12: 	16 
    -- CP-element group 12: 	113 
    -- CP-element group 12: 	35 
    -- CP-element group 12: 	94 
    -- CP-element group 12:  members (7) 
      -- CP-element group 12: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/aggregated_phi_sample_ack
      -- CP-element group 12: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_sample_completed_
      -- 
    outputPort_2_Daemon_cp_element_group_12: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_12"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(58) & outputPort_2_Daemon_CP_821_elements(78) & outputPort_2_Daemon_CP_821_elements(19) & outputPort_2_Daemon_CP_821_elements(116) & outputPort_2_Daemon_CP_821_elements(38) & outputPort_2_Daemon_CP_821_elements(97);
      gj_outputPort_2_Daemon_cp_element_group_12 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(12), clk => clk, reset => reset); --
    end block;
    -- CP-element group 13:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	12 
    -- CP-element group 13: successors 
    -- CP-element group 13: 	10 
    -- CP-element group 13:  members (1) 
      -- CP-element group 13: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/aggregated_phi_sample_ack_d
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(13) is a control-delay.
    cp_element_13_delay: control_delay_element  generic map(name => " 13_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_821_elements(12), ack => outputPort_2_Daemon_CP_821_elements(13), clk => clk, reset =>reset);
    -- CP-element group 14:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	57 
    -- CP-element group 14: 	76 
    -- CP-element group 14: 	17 
    -- CP-element group 14: 	114 
    -- CP-element group 14: 	36 
    -- CP-element group 14: 	95 
    -- CP-element group 14: successors 
    -- CP-element group 14: 	79 
    -- CP-element group 14: 	20 
    -- CP-element group 14: 	117 
    -- CP-element group 14: 	39 
    -- CP-element group 14: 	98 
    -- CP-element group 14:  members (2) 
      -- CP-element group 14: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/aggregated_phi_update_req
      -- CP-element group 14: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_update_start__ps
      -- 
    outputPort_2_Daemon_cp_element_group_14: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_14"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(57) & outputPort_2_Daemon_CP_821_elements(76) & outputPort_2_Daemon_CP_821_elements(17) & outputPort_2_Daemon_CP_821_elements(114) & outputPort_2_Daemon_CP_821_elements(36) & outputPort_2_Daemon_CP_821_elements(95);
      gj_outputPort_2_Daemon_cp_element_group_14 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(14), clk => clk, reset => reset); --
    end block;
    -- CP-element group 15:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	40 
    -- CP-element group 15: 	59 
    -- CP-element group 15: 	80 
    -- CP-element group 15: 	21 
    -- CP-element group 15: 	118 
    -- CP-element group 15: 	99 
    -- CP-element group 15: successors 
    -- CP-element group 15: 	10 
    -- CP-element group 15: marked-successors 
    -- CP-element group 15: 	11 
    -- CP-element group 15:  members (1) 
      -- CP-element group 15: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/aggregated_phi_update_ack
      -- 
    outputPort_2_Daemon_cp_element_group_15: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 7,1 => 7,2 => 7,3 => 7,4 => 7,5 => 7);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_15"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(40) & outputPort_2_Daemon_CP_821_elements(59) & outputPort_2_Daemon_CP_821_elements(80) & outputPort_2_Daemon_CP_821_elements(21) & outputPort_2_Daemon_CP_821_elements(118) & outputPort_2_Daemon_CP_821_elements(99);
      gj_outputPort_2_Daemon_cp_element_group_15 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(15), clk => clk, reset => reset); --
    end block;
    -- CP-element group 16:  join  transition  bypass  pipeline-parent 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	9 
    -- CP-element group 16: marked-predecessors 
    -- CP-element group 16: 	12 
    -- CP-element group 16: successors 
    -- CP-element group 16: 	11 
    -- CP-element group 16:  members (1) 
      -- CP-element group 16: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_16: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_16"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_16 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(16), clk => clk, reset => reset); --
    end block;
    -- CP-element group 17:  join  transition  bypass  pipeline-parent 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	9 
    -- CP-element group 17: marked-predecessors 
    -- CP-element group 17: 	133 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	14 
    -- CP-element group 17:  members (1) 
      -- CP-element group 17: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_17: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_17"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(133);
      gj_outputPort_2_Daemon_cp_element_group_17 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(17), clk => clk, reset => reset); --
    end block;
    -- CP-element group 18:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: 	11 
    -- CP-element group 18: successors 
    -- CP-element group 18:  members (1) 
      -- CP-element group 18: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_sample_start__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(18) <= outputPort_2_Daemon_CP_821_elements(11);
    -- CP-element group 19:  join  transition  bypass  pipeline-parent 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	12 
    -- CP-element group 19:  members (1) 
      -- CP-element group 19: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(19) is bound as output of CP function.
    -- CP-element group 20:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	14 
    -- CP-element group 20: successors 
    -- CP-element group 20:  members (1) 
      -- CP-element group 20: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_update_start__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(20) <= outputPort_2_Daemon_CP_821_elements(14);
    -- CP-element group 21:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: successors 
    -- CP-element group 21: 	132 
    -- CP-element group 21: 	15 
    -- CP-element group 21:  members (2) 
      -- CP-element group 21: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_update_completed_
      -- CP-element group 21: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_update_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(21) is bound as output of CP function.
    -- CP-element group 22:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	7 
    -- CP-element group 22: successors 
    -- CP-element group 22:  members (1) 
      -- CP-element group 22: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(22) <= outputPort_2_Daemon_CP_821_elements(7);
    -- CP-element group 23:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: successors 
    -- CP-element group 23:  members (2) 
      -- CP-element group 23: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_loopback_sample_req
      -- CP-element group 23: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_loopback_sample_req_ps
      -- 
    phi_stmt_500_loopback_sample_req_861_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_500_loopback_sample_req_861_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(23), ack => phi_stmt_500_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(23) is bound as output of CP function.
    -- CP-element group 24:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: 	8 
    -- CP-element group 24: successors 
    -- CP-element group 24:  members (1) 
      -- CP-element group 24: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_entry_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(24) <= outputPort_2_Daemon_CP_821_elements(8);
    -- CP-element group 25:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: successors 
    -- CP-element group 25:  members (2) 
      -- CP-element group 25: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_entry_sample_req
      -- CP-element group 25: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_entry_sample_req_ps
      -- 
    phi_stmt_500_entry_sample_req_864_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_500_entry_sample_req_864_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(25), ack => phi_stmt_500_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(25) is bound as output of CP function.
    -- CP-element group 26:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 26: predecessors 
    -- CP-element group 26: successors 
    -- CP-element group 26:  members (2) 
      -- CP-element group 26: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_phi_mux_ack
      -- CP-element group 26: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_500_phi_mux_ack_ps
      -- 
    phi_stmt_500_phi_mux_ack_867_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 26_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_500_ack_0, ack => outputPort_2_Daemon_CP_821_elements(26)); -- 
    -- CP-element group 27:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 27: predecessors 
    -- CP-element group 27: successors 
    -- CP-element group 27:  members (4) 
      -- CP-element group 27: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_502_sample_start_
      -- CP-element group 27: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_502_sample_start__ps
      -- CP-element group 27: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_502_sample_completed_
      -- CP-element group 27: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_502_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(27) is bound as output of CP function.
    -- CP-element group 28:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 28: predecessors 
    -- CP-element group 28: successors 
    -- CP-element group 28: 	30 
    -- CP-element group 28:  members (2) 
      -- CP-element group 28: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_502_update_start_
      -- CP-element group 28: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_502_update_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(28) is bound as output of CP function.
    -- CP-element group 29:  join  transition  bypass  pipeline-parent 
    -- CP-element group 29: predecessors 
    -- CP-element group 29: 	30 
    -- CP-element group 29: successors 
    -- CP-element group 29:  members (1) 
      -- CP-element group 29: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_502_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(29) <= outputPort_2_Daemon_CP_821_elements(30);
    -- CP-element group 30:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 30: predecessors 
    -- CP-element group 30: 	28 
    -- CP-element group 30: successors 
    -- CP-element group 30: 	29 
    -- CP-element group 30:  members (1) 
      -- CP-element group 30: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_502_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(30) is a control-delay.
    cp_element_30_delay: control_delay_element  generic map(name => " 30_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_821_elements(28), ack => outputPort_2_Daemon_CP_821_elements(30), clk => clk, reset =>reset);
    -- CP-element group 31:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 31: predecessors 
    -- CP-element group 31: successors 
    -- CP-element group 31: 	33 
    -- CP-element group 31:  members (4) 
      -- CP-element group 31: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_Sample/req
      -- CP-element group 31: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_Sample/$entry
      -- CP-element group 31: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_sample_start_
      -- CP-element group 31: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_sample_start__ps
      -- 
    req_888_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_888_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(31), ack => next_down_counter_602_503_buf_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(31) is bound as output of CP function.
    -- CP-element group 32:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 32: predecessors 
    -- CP-element group 32: successors 
    -- CP-element group 32: 	34 
    -- CP-element group 32:  members (4) 
      -- CP-element group 32: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_update_start__ps
      -- CP-element group 32: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_Update/$entry
      -- CP-element group 32: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_Update/req
      -- CP-element group 32: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_update_start_
      -- 
    req_893_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_893_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(32), ack => next_down_counter_602_503_buf_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(32) is bound as output of CP function.
    -- CP-element group 33:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 33: predecessors 
    -- CP-element group 33: 	31 
    -- CP-element group 33: successors 
    -- CP-element group 33:  members (4) 
      -- CP-element group 33: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_Sample/ack
      -- CP-element group 33: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_sample_completed__ps
      -- CP-element group 33: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_Sample/$exit
      -- CP-element group 33: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_sample_completed_
      -- 
    ack_889_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 33_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_down_counter_602_503_buf_ack_0, ack => outputPort_2_Daemon_CP_821_elements(33)); -- 
    -- CP-element group 34:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 34: predecessors 
    -- CP-element group 34: 	32 
    -- CP-element group 34: successors 
    -- CP-element group 34:  members (4) 
      -- CP-element group 34: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_Update/ack
      -- CP-element group 34: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_update_completed__ps
      -- CP-element group 34: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_Update/$exit
      -- CP-element group 34: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_down_counter_503_update_completed_
      -- 
    ack_894_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 34_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_down_counter_602_503_buf_ack_1, ack => outputPort_2_Daemon_CP_821_elements(34)); -- 
    -- CP-element group 35:  join  transition  bypass  pipeline-parent 
    -- CP-element group 35: predecessors 
    -- CP-element group 35: 	9 
    -- CP-element group 35: marked-predecessors 
    -- CP-element group 35: 	12 
    -- CP-element group 35: successors 
    -- CP-element group 35: 	11 
    -- CP-element group 35:  members (1) 
      -- CP-element group 35: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_35: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_35"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_35 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(35), clk => clk, reset => reset); --
    end block;
    -- CP-element group 36:  join  transition  bypass  pipeline-parent 
    -- CP-element group 36: predecessors 
    -- CP-element group 36: 	9 
    -- CP-element group 36: marked-predecessors 
    -- CP-element group 36: 	133 
    -- CP-element group 36: successors 
    -- CP-element group 36: 	14 
    -- CP-element group 36:  members (1) 
      -- CP-element group 36: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_36: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_36"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(133);
      gj_outputPort_2_Daemon_cp_element_group_36 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(36), clk => clk, reset => reset); --
    end block;
    -- CP-element group 37:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 37: predecessors 
    -- CP-element group 37: 	11 
    -- CP-element group 37: successors 
    -- CP-element group 37:  members (1) 
      -- CP-element group 37: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_sample_start__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(37) <= outputPort_2_Daemon_CP_821_elements(11);
    -- CP-element group 38:  join  transition  bypass  pipeline-parent 
    -- CP-element group 38: predecessors 
    -- CP-element group 38: successors 
    -- CP-element group 38: 	12 
    -- CP-element group 38:  members (1) 
      -- CP-element group 38: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(38) is bound as output of CP function.
    -- CP-element group 39:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 39: predecessors 
    -- CP-element group 39: 	14 
    -- CP-element group 39: successors 
    -- CP-element group 39:  members (1) 
      -- CP-element group 39: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_update_start__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(39) <= outputPort_2_Daemon_CP_821_elements(14);
    -- CP-element group 40:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 40: predecessors 
    -- CP-element group 40: successors 
    -- CP-element group 40: 	132 
    -- CP-element group 40: 	15 
    -- CP-element group 40:  members (2) 
      -- CP-element group 40: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_update_completed__ps
      -- CP-element group 40: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(40) is bound as output of CP function.
    -- CP-element group 41:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 41: predecessors 
    -- CP-element group 41: 	7 
    -- CP-element group 41: successors 
    -- CP-element group 41:  members (1) 
      -- CP-element group 41: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(41) <= outputPort_2_Daemon_CP_821_elements(7);
    -- CP-element group 42:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 42: predecessors 
    -- CP-element group 42: successors 
    -- CP-element group 42:  members (2) 
      -- CP-element group 42: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_loopback_sample_req_ps
      -- CP-element group 42: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_loopback_sample_req
      -- 
    phi_stmt_504_loopback_sample_req_905_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_504_loopback_sample_req_905_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(42), ack => phi_stmt_504_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(42) is bound as output of CP function.
    -- CP-element group 43:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 43: predecessors 
    -- CP-element group 43: 	8 
    -- CP-element group 43: successors 
    -- CP-element group 43:  members (1) 
      -- CP-element group 43: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_entry_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(43) <= outputPort_2_Daemon_CP_821_elements(8);
    -- CP-element group 44:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 44: predecessors 
    -- CP-element group 44: successors 
    -- CP-element group 44:  members (2) 
      -- CP-element group 44: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_entry_sample_req_ps
      -- CP-element group 44: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_entry_sample_req
      -- 
    phi_stmt_504_entry_sample_req_908_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_504_entry_sample_req_908_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(44), ack => phi_stmt_504_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(44) is bound as output of CP function.
    -- CP-element group 45:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 45: predecessors 
    -- CP-element group 45: successors 
    -- CP-element group 45:  members (2) 
      -- CP-element group 45: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_phi_mux_ack
      -- CP-element group 45: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_504_phi_mux_ack_ps
      -- 
    phi_stmt_504_phi_mux_ack_911_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 45_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_504_ack_0, ack => outputPort_2_Daemon_CP_821_elements(45)); -- 
    -- CP-element group 46:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 46: predecessors 
    -- CP-element group 46: successors 
    -- CP-element group 46:  members (4) 
      -- CP-element group 46: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_506_sample_start_
      -- CP-element group 46: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_506_sample_completed_
      -- CP-element group 46: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_506_sample_start__ps
      -- CP-element group 46: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_506_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(46) is bound as output of CP function.
    -- CP-element group 47:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 47: predecessors 
    -- CP-element group 47: successors 
    -- CP-element group 47: 	49 
    -- CP-element group 47:  members (2) 
      -- CP-element group 47: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_506_update_start__ps
      -- CP-element group 47: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_506_update_start_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(47) is bound as output of CP function.
    -- CP-element group 48:  join  transition  bypass  pipeline-parent 
    -- CP-element group 48: predecessors 
    -- CP-element group 48: 	49 
    -- CP-element group 48: successors 
    -- CP-element group 48:  members (1) 
      -- CP-element group 48: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_506_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(48) <= outputPort_2_Daemon_CP_821_elements(49);
    -- CP-element group 49:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 49: predecessors 
    -- CP-element group 49: 	47 
    -- CP-element group 49: successors 
    -- CP-element group 49: 	48 
    -- CP-element group 49:  members (1) 
      -- CP-element group 49: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_506_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(49) is a control-delay.
    cp_element_49_delay: control_delay_element  generic map(name => " 49_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_821_elements(47), ack => outputPort_2_Daemon_CP_821_elements(49), clk => clk, reset =>reset);
    -- CP-element group 50:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 50: predecessors 
    -- CP-element group 50: successors 
    -- CP-element group 50: 	52 
    -- CP-element group 50:  members (1) 
      -- CP-element group 50: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_sample_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(50) is bound as output of CP function.
    -- CP-element group 51:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 51: predecessors 
    -- CP-element group 51: successors 
    -- CP-element group 51: 	53 
    -- CP-element group 51:  members (1) 
      -- CP-element group 51: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_update_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(51) is bound as output of CP function.
    -- CP-element group 52:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 52: predecessors 
    -- CP-element group 52: 	50 
    -- CP-element group 52: marked-predecessors 
    -- CP-element group 52: 	55 
    -- CP-element group 52: successors 
    -- CP-element group 52: 	54 
    -- CP-element group 52:  members (3) 
      -- CP-element group 52: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_Sample/rr
      -- CP-element group 52: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_Sample/$entry
      -- CP-element group 52: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_sample_start_
      -- 
    rr_932_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_932_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(52), ack => RPIPE_noblock_obuf_1_2_508_inst_req_0); -- 
    outputPort_2_Daemon_cp_element_group_52: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_52"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(50) & outputPort_2_Daemon_CP_821_elements(55);
      gj_outputPort_2_Daemon_cp_element_group_52 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(52), clk => clk, reset => reset); --
    end block;
    -- CP-element group 53:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 53: predecessors 
    -- CP-element group 53: 	54 
    -- CP-element group 53: 	51 
    -- CP-element group 53: successors 
    -- CP-element group 53: 	55 
    -- CP-element group 53:  members (3) 
      -- CP-element group 53: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_update_start_
      -- CP-element group 53: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_Update/cr
      -- CP-element group 53: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_Update/$entry
      -- 
    cr_937_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_937_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(53), ack => RPIPE_noblock_obuf_1_2_508_inst_req_1); -- 
    outputPort_2_Daemon_cp_element_group_53: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 7);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_53"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(54) & outputPort_2_Daemon_CP_821_elements(51);
      gj_outputPort_2_Daemon_cp_element_group_53 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(53), clk => clk, reset => reset); --
    end block;
    -- CP-element group 54:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 54: predecessors 
    -- CP-element group 54: 	52 
    -- CP-element group 54: successors 
    -- CP-element group 54: 	53 
    -- CP-element group 54:  members (4) 
      -- CP-element group 54: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_sample_completed_
      -- CP-element group 54: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_Sample/$exit
      -- CP-element group 54: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_Sample/ra
      -- CP-element group 54: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_sample_completed__ps
      -- 
    ra_933_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 54_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_1_2_508_inst_ack_0, ack => outputPort_2_Daemon_CP_821_elements(54)); -- 
    -- CP-element group 55:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 55: predecessors 
    -- CP-element group 55: 	53 
    -- CP-element group 55: successors 
    -- CP-element group 55: marked-successors 
    -- CP-element group 55: 	52 
    -- CP-element group 55:  members (4) 
      -- CP-element group 55: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_Update/ca
      -- CP-element group 55: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_update_completed_
      -- CP-element group 55: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_Update/$exit
      -- CP-element group 55: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_1_2_508_update_completed__ps
      -- 
    ca_938_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 55_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_1_2_508_inst_ack_1, ack => outputPort_2_Daemon_CP_821_elements(55)); -- 
    -- CP-element group 56:  join  transition  bypass  pipeline-parent 
    -- CP-element group 56: predecessors 
    -- CP-element group 56: 	9 
    -- CP-element group 56: marked-predecessors 
    -- CP-element group 56: 	12 
    -- CP-element group 56: successors 
    -- CP-element group 56: 	11 
    -- CP-element group 56:  members (1) 
      -- CP-element group 56: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_56: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_56"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_56 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(56), clk => clk, reset => reset); --
    end block;
    -- CP-element group 57:  join  transition  bypass  pipeline-parent 
    -- CP-element group 57: predecessors 
    -- CP-element group 57: 	9 
    -- CP-element group 57: marked-predecessors 
    -- CP-element group 57: 	133 
    -- CP-element group 57: successors 
    -- CP-element group 57: 	14 
    -- CP-element group 57:  members (1) 
      -- CP-element group 57: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_57: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_57"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(133);
      gj_outputPort_2_Daemon_cp_element_group_57 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(57), clk => clk, reset => reset); --
    end block;
    -- CP-element group 58:  join  transition  bypass  pipeline-parent 
    -- CP-element group 58: predecessors 
    -- CP-element group 58: successors 
    -- CP-element group 58: 	12 
    -- CP-element group 58:  members (1) 
      -- CP-element group 58: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(58) is bound as output of CP function.
    -- CP-element group 59:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 59: predecessors 
    -- CP-element group 59: successors 
    -- CP-element group 59: 	132 
    -- CP-element group 59: 	15 
    -- CP-element group 59:  members (2) 
      -- CP-element group 59: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_update_completed__ps
      -- CP-element group 59: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(59) is bound as output of CP function.
    -- CP-element group 60:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 60: predecessors 
    -- CP-element group 60: 	7 
    -- CP-element group 60: successors 
    -- CP-element group 60:  members (1) 
      -- CP-element group 60: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(60) <= outputPort_2_Daemon_CP_821_elements(7);
    -- CP-element group 61:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 61: predecessors 
    -- CP-element group 61: successors 
    -- CP-element group 61:  members (2) 
      -- CP-element group 61: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_loopback_sample_req
      -- CP-element group 61: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_loopback_sample_req_ps
      -- 
    phi_stmt_509_loopback_sample_req_949_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_509_loopback_sample_req_949_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(61), ack => phi_stmt_509_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(61) is bound as output of CP function.
    -- CP-element group 62:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 62: predecessors 
    -- CP-element group 62: 	8 
    -- CP-element group 62: successors 
    -- CP-element group 62:  members (1) 
      -- CP-element group 62: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_entry_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(62) <= outputPort_2_Daemon_CP_821_elements(8);
    -- CP-element group 63:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 63: predecessors 
    -- CP-element group 63: successors 
    -- CP-element group 63:  members (2) 
      -- CP-element group 63: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_entry_sample_req
      -- CP-element group 63: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_entry_sample_req_ps
      -- 
    phi_stmt_509_entry_sample_req_952_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_509_entry_sample_req_952_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(63), ack => phi_stmt_509_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(63) is bound as output of CP function.
    -- CP-element group 64:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 64: predecessors 
    -- CP-element group 64: successors 
    -- CP-element group 64:  members (2) 
      -- CP-element group 64: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_phi_mux_ack_ps
      -- CP-element group 64: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_509_phi_mux_ack
      -- 
    phi_stmt_509_phi_mux_ack_955_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 64_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_509_ack_0, ack => outputPort_2_Daemon_CP_821_elements(64)); -- 
    -- CP-element group 65:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 65: predecessors 
    -- CP-element group 65: successors 
    -- CP-element group 65:  members (4) 
      -- CP-element group 65: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_511_sample_completed__ps
      -- CP-element group 65: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_511_sample_start__ps
      -- CP-element group 65: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_511_sample_completed_
      -- CP-element group 65: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_511_sample_start_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(65) is bound as output of CP function.
    -- CP-element group 66:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 66: predecessors 
    -- CP-element group 66: successors 
    -- CP-element group 66: 	68 
    -- CP-element group 66:  members (2) 
      -- CP-element group 66: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_511_update_start_
      -- CP-element group 66: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_511_update_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(66) is bound as output of CP function.
    -- CP-element group 67:  join  transition  bypass  pipeline-parent 
    -- CP-element group 67: predecessors 
    -- CP-element group 67: 	68 
    -- CP-element group 67: successors 
    -- CP-element group 67:  members (1) 
      -- CP-element group 67: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_511_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(67) <= outputPort_2_Daemon_CP_821_elements(68);
    -- CP-element group 68:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 68: predecessors 
    -- CP-element group 68: 	66 
    -- CP-element group 68: successors 
    -- CP-element group 68: 	67 
    -- CP-element group 68:  members (1) 
      -- CP-element group 68: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_33_511_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(68) is a control-delay.
    cp_element_68_delay: control_delay_element  generic map(name => " 68_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_821_elements(66), ack => outputPort_2_Daemon_CP_821_elements(68), clk => clk, reset =>reset);
    -- CP-element group 69:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 69: predecessors 
    -- CP-element group 69: successors 
    -- CP-element group 69: 	71 
    -- CP-element group 69:  members (1) 
      -- CP-element group 69: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_sample_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(69) is bound as output of CP function.
    -- CP-element group 70:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 70: predecessors 
    -- CP-element group 70: successors 
    -- CP-element group 70: 	72 
    -- CP-element group 70:  members (1) 
      -- CP-element group 70: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_update_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(70) is bound as output of CP function.
    -- CP-element group 71:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 71: predecessors 
    -- CP-element group 71: 	69 
    -- CP-element group 71: marked-predecessors 
    -- CP-element group 71: 	74 
    -- CP-element group 71: successors 
    -- CP-element group 71: 	73 
    -- CP-element group 71:  members (3) 
      -- CP-element group 71: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_sample_start_
      -- CP-element group 71: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_Sample/rr
      -- CP-element group 71: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_Sample/$entry
      -- 
    rr_976_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_976_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(71), ack => RPIPE_noblock_obuf_2_2_513_inst_req_0); -- 
    outputPort_2_Daemon_cp_element_group_71: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_71"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(69) & outputPort_2_Daemon_CP_821_elements(74);
      gj_outputPort_2_Daemon_cp_element_group_71 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(71), clk => clk, reset => reset); --
    end block;
    -- CP-element group 72:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 72: predecessors 
    -- CP-element group 72: 	70 
    -- CP-element group 72: 	73 
    -- CP-element group 72: successors 
    -- CP-element group 72: 	74 
    -- CP-element group 72:  members (3) 
      -- CP-element group 72: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_Update/$entry
      -- CP-element group 72: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_Update/cr
      -- CP-element group 72: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_update_start_
      -- 
    cr_981_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_981_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(72), ack => RPIPE_noblock_obuf_2_2_513_inst_req_1); -- 
    outputPort_2_Daemon_cp_element_group_72: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_72"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(70) & outputPort_2_Daemon_CP_821_elements(73);
      gj_outputPort_2_Daemon_cp_element_group_72 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(72), clk => clk, reset => reset); --
    end block;
    -- CP-element group 73:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 73: predecessors 
    -- CP-element group 73: 	71 
    -- CP-element group 73: successors 
    -- CP-element group 73: 	72 
    -- CP-element group 73:  members (4) 
      -- CP-element group 73: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_sample_completed_
      -- CP-element group 73: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_sample_completed__ps
      -- CP-element group 73: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_Sample/ra
      -- CP-element group 73: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_Sample/$exit
      -- 
    ra_977_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 73_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_2_2_513_inst_ack_0, ack => outputPort_2_Daemon_CP_821_elements(73)); -- 
    -- CP-element group 74:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 74: predecessors 
    -- CP-element group 74: 	72 
    -- CP-element group 74: successors 
    -- CP-element group 74: marked-successors 
    -- CP-element group 74: 	71 
    -- CP-element group 74:  members (4) 
      -- CP-element group 74: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_update_completed_
      -- CP-element group 74: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_Update/$exit
      -- CP-element group 74: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_Update/ca
      -- CP-element group 74: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/RPIPE_noblock_obuf_2_2_513_update_completed__ps
      -- 
    ca_982_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 74_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_2_2_513_inst_ack_1, ack => outputPort_2_Daemon_CP_821_elements(74)); -- 
    -- CP-element group 75:  join  transition  bypass  pipeline-parent 
    -- CP-element group 75: predecessors 
    -- CP-element group 75: 	9 
    -- CP-element group 75: marked-predecessors 
    -- CP-element group 75: 	12 
    -- CP-element group 75: successors 
    -- CP-element group 75: 	11 
    -- CP-element group 75:  members (1) 
      -- CP-element group 75: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_75: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_75"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_75 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(75), clk => clk, reset => reset); --
    end block;
    -- CP-element group 76:  join  transition  bypass  pipeline-parent 
    -- CP-element group 76: predecessors 
    -- CP-element group 76: 	9 
    -- CP-element group 76: marked-predecessors 
    -- CP-element group 76: 	133 
    -- CP-element group 76: successors 
    -- CP-element group 76: 	14 
    -- CP-element group 76:  members (1) 
      -- CP-element group 76: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_76: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_76"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(133);
      gj_outputPort_2_Daemon_cp_element_group_76 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(76), clk => clk, reset => reset); --
    end block;
    -- CP-element group 77:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 77: predecessors 
    -- CP-element group 77: 	11 
    -- CP-element group 77: successors 
    -- CP-element group 77:  members (1) 
      -- CP-element group 77: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_sample_start__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(77) <= outputPort_2_Daemon_CP_821_elements(11);
    -- CP-element group 78:  join  transition  bypass  pipeline-parent 
    -- CP-element group 78: predecessors 
    -- CP-element group 78: successors 
    -- CP-element group 78: 	12 
    -- CP-element group 78:  members (1) 
      -- CP-element group 78: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(78) is bound as output of CP function.
    -- CP-element group 79:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 79: predecessors 
    -- CP-element group 79: 	14 
    -- CP-element group 79: successors 
    -- CP-element group 79:  members (1) 
      -- CP-element group 79: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_update_start__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(79) <= outputPort_2_Daemon_CP_821_elements(14);
    -- CP-element group 80:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 80: predecessors 
    -- CP-element group 80: successors 
    -- CP-element group 80: 	132 
    -- CP-element group 80: 	15 
    -- CP-element group 80:  members (2) 
      -- CP-element group 80: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_update_completed_
      -- CP-element group 80: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_update_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(80) is bound as output of CP function.
    -- CP-element group 81:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 81: predecessors 
    -- CP-element group 81: 	7 
    -- CP-element group 81: successors 
    -- CP-element group 81:  members (1) 
      -- CP-element group 81: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(81) <= outputPort_2_Daemon_CP_821_elements(7);
    -- CP-element group 82:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 82: predecessors 
    -- CP-element group 82: successors 
    -- CP-element group 82:  members (2) 
      -- CP-element group 82: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_loopback_sample_req_ps
      -- CP-element group 82: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_loopback_sample_req
      -- 
    phi_stmt_514_loopback_sample_req_993_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_514_loopback_sample_req_993_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(82), ack => phi_stmt_514_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(82) is bound as output of CP function.
    -- CP-element group 83:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 83: predecessors 
    -- CP-element group 83: 	8 
    -- CP-element group 83: successors 
    -- CP-element group 83:  members (1) 
      -- CP-element group 83: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_entry_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(83) <= outputPort_2_Daemon_CP_821_elements(8);
    -- CP-element group 84:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 84: predecessors 
    -- CP-element group 84: successors 
    -- CP-element group 84:  members (2) 
      -- CP-element group 84: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_entry_sample_req_ps
      -- CP-element group 84: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_entry_sample_req
      -- 
    phi_stmt_514_entry_sample_req_996_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_514_entry_sample_req_996_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(84), ack => phi_stmt_514_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(84) is bound as output of CP function.
    -- CP-element group 85:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 85: predecessors 
    -- CP-element group 85: successors 
    -- CP-element group 85:  members (2) 
      -- CP-element group 85: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_phi_mux_ack
      -- CP-element group 85: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_514_phi_mux_ack_ps
      -- 
    phi_stmt_514_phi_mux_ack_999_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 85_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_514_ack_0, ack => outputPort_2_Daemon_CP_821_elements(85)); -- 
    -- CP-element group 86:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 86: predecessors 
    -- CP-element group 86: successors 
    -- CP-element group 86:  members (4) 
      -- CP-element group 86: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_2_516_sample_start_
      -- CP-element group 86: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_2_516_sample_completed_
      -- CP-element group 86: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_2_516_sample_completed__ps
      -- CP-element group 86: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_2_516_sample_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(86) is bound as output of CP function.
    -- CP-element group 87:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 87: predecessors 
    -- CP-element group 87: successors 
    -- CP-element group 87: 	89 
    -- CP-element group 87:  members (2) 
      -- CP-element group 87: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_2_516_update_start__ps
      -- CP-element group 87: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_2_516_update_start_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(87) is bound as output of CP function.
    -- CP-element group 88:  join  transition  bypass  pipeline-parent 
    -- CP-element group 88: predecessors 
    -- CP-element group 88: 	89 
    -- CP-element group 88: successors 
    -- CP-element group 88:  members (1) 
      -- CP-element group 88: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_2_516_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(88) <= outputPort_2_Daemon_CP_821_elements(89);
    -- CP-element group 89:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 89: predecessors 
    -- CP-element group 89: 	87 
    -- CP-element group 89: successors 
    -- CP-element group 89: 	88 
    -- CP-element group 89:  members (1) 
      -- CP-element group 89: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_2_516_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(89) is a control-delay.
    cp_element_89_delay: control_delay_element  generic map(name => " 89_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_821_elements(87), ack => outputPort_2_Daemon_CP_821_elements(89), clk => clk, reset =>reset);
    -- CP-element group 90:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 90: predecessors 
    -- CP-element group 90: successors 
    -- CP-element group 90: 	92 
    -- CP-element group 90:  members (4) 
      -- CP-element group 90: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_Sample/req
      -- CP-element group 90: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_Sample/$entry
      -- CP-element group 90: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_sample_start_
      -- CP-element group 90: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_sample_start__ps
      -- 
    req_1020_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_1020_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(90), ack => next_active_packet_567_517_buf_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(90) is bound as output of CP function.
    -- CP-element group 91:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 91: predecessors 
    -- CP-element group 91: successors 
    -- CP-element group 91: 	93 
    -- CP-element group 91:  members (4) 
      -- CP-element group 91: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_Update/req
      -- CP-element group 91: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_Update/$entry
      -- CP-element group 91: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_update_start_
      -- CP-element group 91: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_update_start__ps
      -- 
    req_1025_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_1025_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(91), ack => next_active_packet_567_517_buf_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(91) is bound as output of CP function.
    -- CP-element group 92:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 92: predecessors 
    -- CP-element group 92: 	90 
    -- CP-element group 92: successors 
    -- CP-element group 92:  members (4) 
      -- CP-element group 92: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_Sample/ack
      -- CP-element group 92: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_Sample/$exit
      -- CP-element group 92: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_sample_completed_
      -- CP-element group 92: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_sample_completed__ps
      -- 
    ack_1021_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 92_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_567_517_buf_ack_0, ack => outputPort_2_Daemon_CP_821_elements(92)); -- 
    -- CP-element group 93:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 93: predecessors 
    -- CP-element group 93: 	91 
    -- CP-element group 93: successors 
    -- CP-element group 93:  members (4) 
      -- CP-element group 93: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_Update/$exit
      -- CP-element group 93: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_update_completed_
      -- CP-element group 93: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_update_completed__ps
      -- CP-element group 93: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_517_Update/ack
      -- 
    ack_1026_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 93_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_567_517_buf_ack_1, ack => outputPort_2_Daemon_CP_821_elements(93)); -- 
    -- CP-element group 94:  join  transition  bypass  pipeline-parent 
    -- CP-element group 94: predecessors 
    -- CP-element group 94: 	9 
    -- CP-element group 94: marked-predecessors 
    -- CP-element group 94: 	12 
    -- CP-element group 94: successors 
    -- CP-element group 94: 	11 
    -- CP-element group 94:  members (1) 
      -- CP-element group 94: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_94: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_94"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_94 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(94), clk => clk, reset => reset); --
    end block;
    -- CP-element group 95:  join  transition  bypass  pipeline-parent 
    -- CP-element group 95: predecessors 
    -- CP-element group 95: 	9 
    -- CP-element group 95: marked-predecessors 
    -- CP-element group 95: 	99 
    -- CP-element group 95: successors 
    -- CP-element group 95: 	14 
    -- CP-element group 95:  members (1) 
      -- CP-element group 95: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_95: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_95"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(99);
      gj_outputPort_2_Daemon_cp_element_group_95 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(95), clk => clk, reset => reset); --
    end block;
    -- CP-element group 96:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 96: predecessors 
    -- CP-element group 96: 	11 
    -- CP-element group 96: successors 
    -- CP-element group 96:  members (1) 
      -- CP-element group 96: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_sample_start__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(96) <= outputPort_2_Daemon_CP_821_elements(11);
    -- CP-element group 97:  join  transition  bypass  pipeline-parent 
    -- CP-element group 97: predecessors 
    -- CP-element group 97: successors 
    -- CP-element group 97: 	12 
    -- CP-element group 97:  members (1) 
      -- CP-element group 97: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(97) is bound as output of CP function.
    -- CP-element group 98:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 98: predecessors 
    -- CP-element group 98: 	14 
    -- CP-element group 98: successors 
    -- CP-element group 98:  members (1) 
      -- CP-element group 98: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_update_start__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(98) <= outputPort_2_Daemon_CP_821_elements(14);
    -- CP-element group 99:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 99: predecessors 
    -- CP-element group 99: successors 
    -- CP-element group 99: 	15 
    -- CP-element group 99: marked-successors 
    -- CP-element group 99: 	95 
    -- CP-element group 99:  members (2) 
      -- CP-element group 99: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_update_completed_
      -- CP-element group 99: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_update_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(99) is bound as output of CP function.
    -- CP-element group 100:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 100: predecessors 
    -- CP-element group 100: 	7 
    -- CP-element group 100: successors 
    -- CP-element group 100:  members (1) 
      -- CP-element group 100: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(100) <= outputPort_2_Daemon_CP_821_elements(7);
    -- CP-element group 101:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 101: predecessors 
    -- CP-element group 101: successors 
    -- CP-element group 101:  members (2) 
      -- CP-element group 101: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_loopback_sample_req_ps
      -- CP-element group 101: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_loopback_sample_req
      -- 
    phi_stmt_518_loopback_sample_req_1037_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_518_loopback_sample_req_1037_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(101), ack => phi_stmt_518_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(101) is bound as output of CP function.
    -- CP-element group 102:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 102: predecessors 
    -- CP-element group 102: 	8 
    -- CP-element group 102: successors 
    -- CP-element group 102:  members (1) 
      -- CP-element group 102: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_entry_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(102) <= outputPort_2_Daemon_CP_821_elements(8);
    -- CP-element group 103:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 103: predecessors 
    -- CP-element group 103: successors 
    -- CP-element group 103:  members (2) 
      -- CP-element group 103: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_entry_sample_req_ps
      -- CP-element group 103: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_entry_sample_req
      -- 
    phi_stmt_518_entry_sample_req_1040_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_518_entry_sample_req_1040_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(103), ack => phi_stmt_518_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(103) is bound as output of CP function.
    -- CP-element group 104:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 104: predecessors 
    -- CP-element group 104: successors 
    -- CP-element group 104:  members (2) 
      -- CP-element group 104: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_phi_mux_ack
      -- CP-element group 104: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_518_phi_mux_ack_ps
      -- 
    phi_stmt_518_phi_mux_ack_1043_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 104_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_518_ack_0, ack => outputPort_2_Daemon_CP_821_elements(104)); -- 
    -- CP-element group 105:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 105: predecessors 
    -- CP-element group 105: successors 
    -- CP-element group 105:  members (4) 
      -- CP-element group 105: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_520_sample_start_
      -- CP-element group 105: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_520_sample_completed__ps
      -- CP-element group 105: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_520_sample_start__ps
      -- CP-element group 105: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_520_sample_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(105) is bound as output of CP function.
    -- CP-element group 106:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 106: predecessors 
    -- CP-element group 106: successors 
    -- CP-element group 106: 	108 
    -- CP-element group 106:  members (2) 
      -- CP-element group 106: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_520_update_start__ps
      -- CP-element group 106: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_520_update_start_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(106) is bound as output of CP function.
    -- CP-element group 107:  join  transition  bypass  pipeline-parent 
    -- CP-element group 107: predecessors 
    -- CP-element group 107: 	108 
    -- CP-element group 107: successors 
    -- CP-element group 107:  members (1) 
      -- CP-element group 107: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_520_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(107) <= outputPort_2_Daemon_CP_821_elements(108);
    -- CP-element group 108:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 108: predecessors 
    -- CP-element group 108: 	106 
    -- CP-element group 108: successors 
    -- CP-element group 108: 	107 
    -- CP-element group 108:  members (1) 
      -- CP-element group 108: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_8_520_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(108) is a control-delay.
    cp_element_108_delay: control_delay_element  generic map(name => " 108_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_821_elements(106), ack => outputPort_2_Daemon_CP_821_elements(108), clk => clk, reset =>reset);
    -- CP-element group 109:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 109: predecessors 
    -- CP-element group 109: successors 
    -- CP-element group 109: 	111 
    -- CP-element group 109:  members (4) 
      -- CP-element group 109: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_sample_start_
      -- CP-element group 109: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_Sample/req
      -- CP-element group 109: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_Sample/$entry
      -- CP-element group 109: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_sample_start__ps
      -- 
    req_1064_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_1064_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(109), ack => next_active_packet_length_589_521_buf_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(109) is bound as output of CP function.
    -- CP-element group 110:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 110: predecessors 
    -- CP-element group 110: successors 
    -- CP-element group 110: 	112 
    -- CP-element group 110:  members (4) 
      -- CP-element group 110: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_Update/req
      -- CP-element group 110: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_update_start_
      -- CP-element group 110: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_update_start__ps
      -- CP-element group 110: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_Update/$entry
      -- 
    req_1069_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_1069_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(110), ack => next_active_packet_length_589_521_buf_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(110) is bound as output of CP function.
    -- CP-element group 111:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 111: predecessors 
    -- CP-element group 111: 	109 
    -- CP-element group 111: successors 
    -- CP-element group 111:  members (4) 
      -- CP-element group 111: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_sample_completed_
      -- CP-element group 111: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_Sample/$exit
      -- CP-element group 111: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_Sample/ack
      -- CP-element group 111: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_sample_completed__ps
      -- 
    ack_1065_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 111_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_length_589_521_buf_ack_0, ack => outputPort_2_Daemon_CP_821_elements(111)); -- 
    -- CP-element group 112:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 112: predecessors 
    -- CP-element group 112: 	110 
    -- CP-element group 112: successors 
    -- CP-element group 112:  members (4) 
      -- CP-element group 112: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_update_completed_
      -- CP-element group 112: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_Update/$exit
      -- CP-element group 112: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_update_completed__ps
      -- CP-element group 112: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_active_packet_length_521_Update/ack
      -- 
    ack_1070_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 112_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_length_589_521_buf_ack_1, ack => outputPort_2_Daemon_CP_821_elements(112)); -- 
    -- CP-element group 113:  join  transition  bypass  pipeline-parent 
    -- CP-element group 113: predecessors 
    -- CP-element group 113: 	9 
    -- CP-element group 113: marked-predecessors 
    -- CP-element group 113: 	12 
    -- CP-element group 113: successors 
    -- CP-element group 113: 	11 
    -- CP-element group 113:  members (1) 
      -- CP-element group 113: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_113: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 40) := "outputPort_2_Daemon_cp_element_group_113"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_113 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(113), clk => clk, reset => reset); --
    end block;
    -- CP-element group 114:  join  transition  bypass  pipeline-parent 
    -- CP-element group 114: predecessors 
    -- CP-element group 114: 	9 
    -- CP-element group 114: marked-predecessors 
    -- CP-element group 114: 	133 
    -- CP-element group 114: successors 
    -- CP-element group 114: 	14 
    -- CP-element group 114:  members (1) 
      -- CP-element group 114: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_114: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 40) := "outputPort_2_Daemon_cp_element_group_114"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(9) & outputPort_2_Daemon_CP_821_elements(133);
      gj_outputPort_2_Daemon_cp_element_group_114 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(114), clk => clk, reset => reset); --
    end block;
    -- CP-element group 115:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 115: predecessors 
    -- CP-element group 115: 	11 
    -- CP-element group 115: successors 
    -- CP-element group 115:  members (1) 
      -- CP-element group 115: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_sample_start__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(115) <= outputPort_2_Daemon_CP_821_elements(11);
    -- CP-element group 116:  join  transition  bypass  pipeline-parent 
    -- CP-element group 116: predecessors 
    -- CP-element group 116: successors 
    -- CP-element group 116: 	12 
    -- CP-element group 116:  members (1) 
      -- CP-element group 116: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(116) is bound as output of CP function.
    -- CP-element group 117:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 117: predecessors 
    -- CP-element group 117: 	14 
    -- CP-element group 117: successors 
    -- CP-element group 117:  members (1) 
      -- CP-element group 117: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_update_start__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(117) <= outputPort_2_Daemon_CP_821_elements(14);
    -- CP-element group 118:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 118: predecessors 
    -- CP-element group 118: successors 
    -- CP-element group 118: 	132 
    -- CP-element group 118: 	15 
    -- CP-element group 118:  members (2) 
      -- CP-element group 118: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_update_completed__ps
      -- CP-element group 118: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(118) is bound as output of CP function.
    -- CP-element group 119:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 119: predecessors 
    -- CP-element group 119: 	7 
    -- CP-element group 119: successors 
    -- CP-element group 119:  members (1) 
      -- CP-element group 119: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(119) <= outputPort_2_Daemon_CP_821_elements(7);
    -- CP-element group 120:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 120: predecessors 
    -- CP-element group 120: successors 
    -- CP-element group 120:  members (2) 
      -- CP-element group 120: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_loopback_sample_req
      -- CP-element group 120: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_loopback_sample_req_ps
      -- 
    phi_stmt_522_loopback_sample_req_1081_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_522_loopback_sample_req_1081_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(120), ack => phi_stmt_522_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(120) is bound as output of CP function.
    -- CP-element group 121:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 121: predecessors 
    -- CP-element group 121: 	8 
    -- CP-element group 121: successors 
    -- CP-element group 121:  members (1) 
      -- CP-element group 121: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_entry_trigger
      -- 
    outputPort_2_Daemon_CP_821_elements(121) <= outputPort_2_Daemon_CP_821_elements(8);
    -- CP-element group 122:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 122: predecessors 
    -- CP-element group 122: successors 
    -- CP-element group 122:  members (2) 
      -- CP-element group 122: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_entry_sample_req
      -- CP-element group 122: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_entry_sample_req_ps
      -- 
    phi_stmt_522_entry_sample_req_1084_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_522_entry_sample_req_1084_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(122), ack => phi_stmt_522_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(122) is bound as output of CP function.
    -- CP-element group 123:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 123: predecessors 
    -- CP-element group 123: successors 
    -- CP-element group 123:  members (2) 
      -- CP-element group 123: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_phi_mux_ack
      -- CP-element group 123: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/phi_stmt_522_phi_mux_ack_ps
      -- 
    phi_stmt_522_phi_mux_ack_1087_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 123_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_522_ack_0, ack => outputPort_2_Daemon_CP_821_elements(123)); -- 
    -- CP-element group 124:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 124: predecessors 
    -- CP-element group 124: successors 
    -- CP-element group 124:  members (4) 
      -- CP-element group 124: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_1_524_sample_start__ps
      -- CP-element group 124: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_1_524_sample_completed__ps
      -- CP-element group 124: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_1_524_sample_start_
      -- CP-element group 124: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_1_524_sample_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(124) is bound as output of CP function.
    -- CP-element group 125:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 125: predecessors 
    -- CP-element group 125: successors 
    -- CP-element group 125: 	127 
    -- CP-element group 125:  members (2) 
      -- CP-element group 125: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_1_524_update_start__ps
      -- CP-element group 125: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_1_524_update_start_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(125) is bound as output of CP function.
    -- CP-element group 126:  join  transition  bypass  pipeline-parent 
    -- CP-element group 126: predecessors 
    -- CP-element group 126: 	127 
    -- CP-element group 126: successors 
    -- CP-element group 126:  members (1) 
      -- CP-element group 126: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_1_524_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_821_elements(126) <= outputPort_2_Daemon_CP_821_elements(127);
    -- CP-element group 127:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 127: predecessors 
    -- CP-element group 127: 	125 
    -- CP-element group 127: successors 
    -- CP-element group 127: 	126 
    -- CP-element group 127:  members (1) 
      -- CP-element group 127: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_ZERO_1_524_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(127) is a control-delay.
    cp_element_127_delay: control_delay_element  generic map(name => " 127_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_821_elements(125), ack => outputPort_2_Daemon_CP_821_elements(127), clk => clk, reset =>reset);
    -- CP-element group 128:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 128: predecessors 
    -- CP-element group 128: successors 
    -- CP-element group 128: 	130 
    -- CP-element group 128:  members (4) 
      -- CP-element group 128: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_sample_start__ps
      -- CP-element group 128: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_sample_start_
      -- CP-element group 128: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_Sample/$entry
      -- CP-element group 128: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_Sample/req
      -- 
    req_1108_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_1108_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(128), ack => next_pkt_1_has_priority_567_525_buf_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(128) is bound as output of CP function.
    -- CP-element group 129:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 129: predecessors 
    -- CP-element group 129: successors 
    -- CP-element group 129: 	131 
    -- CP-element group 129:  members (4) 
      -- CP-element group 129: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_update_start__ps
      -- CP-element group 129: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_update_start_
      -- CP-element group 129: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_Update/$entry
      -- CP-element group 129: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_Update/req
      -- 
    req_1113_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_1113_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(129), ack => next_pkt_1_has_priority_567_525_buf_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(129) is bound as output of CP function.
    -- CP-element group 130:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 130: predecessors 
    -- CP-element group 130: 	128 
    -- CP-element group 130: successors 
    -- CP-element group 130:  members (4) 
      -- CP-element group 130: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_sample_completed__ps
      -- CP-element group 130: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_sample_completed_
      -- CP-element group 130: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_Sample/$exit
      -- CP-element group 130: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_Sample/ack
      -- 
    ack_1109_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 130_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_pkt_1_has_priority_567_525_buf_ack_0, ack => outputPort_2_Daemon_CP_821_elements(130)); -- 
    -- CP-element group 131:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 131: predecessors 
    -- CP-element group 131: 	129 
    -- CP-element group 131: successors 
    -- CP-element group 131:  members (4) 
      -- CP-element group 131: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_update_completed__ps
      -- CP-element group 131: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_update_completed_
      -- CP-element group 131: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_Update/$exit
      -- CP-element group 131: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/R_next_pkt_1_has_priority_525_Update/ack
      -- 
    ack_1114_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 131_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_pkt_1_has_priority_567_525_buf_ack_1, ack => outputPort_2_Daemon_CP_821_elements(131)); -- 
    -- CP-element group 132:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 132: predecessors 
    -- CP-element group 132: 	40 
    -- CP-element group 132: 	59 
    -- CP-element group 132: 	80 
    -- CP-element group 132: 	21 
    -- CP-element group 132: 	118 
    -- CP-element group 132: marked-predecessors 
    -- CP-element group 132: 	134 
    -- CP-element group 132: successors 
    -- CP-element group 132: 	133 
    -- CP-element group 132:  members (3) 
      -- CP-element group 132: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_sample_start_
      -- CP-element group 132: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_Sample/$entry
      -- CP-element group 132: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_Sample/req
      -- 
    req_1123_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_1123_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(132), ack => WPIPE_out_data_2_645_inst_req_0); -- 
    outputPort_2_Daemon_cp_element_group_132: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 1);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 40) := "outputPort_2_Daemon_cp_element_group_132"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(40) & outputPort_2_Daemon_CP_821_elements(59) & outputPort_2_Daemon_CP_821_elements(80) & outputPort_2_Daemon_CP_821_elements(21) & outputPort_2_Daemon_CP_821_elements(118) & outputPort_2_Daemon_CP_821_elements(134);
      gj_outputPort_2_Daemon_cp_element_group_132 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(132), clk => clk, reset => reset); --
    end block;
    -- CP-element group 133:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 133: predecessors 
    -- CP-element group 133: 	132 
    -- CP-element group 133: successors 
    -- CP-element group 133: 	134 
    -- CP-element group 133: marked-successors 
    -- CP-element group 133: 	57 
    -- CP-element group 133: 	76 
    -- CP-element group 133: 	17 
    -- CP-element group 133: 	114 
    -- CP-element group 133: 	36 
    -- CP-element group 133:  members (6) 
      -- CP-element group 133: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_sample_completed_
      -- CP-element group 133: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_update_start_
      -- CP-element group 133: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_Sample/$exit
      -- CP-element group 133: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_Sample/ack
      -- CP-element group 133: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_Update/$entry
      -- CP-element group 133: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_Update/req
      -- 
    ack_1124_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 133_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_data_2_645_inst_ack_0, ack => outputPort_2_Daemon_CP_821_elements(133)); -- 
    req_1128_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_1128_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_821_elements(133), ack => WPIPE_out_data_2_645_inst_req_1); -- 
    -- CP-element group 134:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 134: predecessors 
    -- CP-element group 134: 	133 
    -- CP-element group 134: successors 
    -- CP-element group 134: 	136 
    -- CP-element group 134: marked-successors 
    -- CP-element group 134: 	132 
    -- CP-element group 134:  members (3) 
      -- CP-element group 134: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_update_completed_
      -- CP-element group 134: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_Update/$exit
      -- CP-element group 134: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/WPIPE_out_data_2_645_Update/ack
      -- 
    ack_1129_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 134_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_data_2_645_inst_ack_1, ack => outputPort_2_Daemon_CP_821_elements(134)); -- 
    -- CP-element group 135:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 135: predecessors 
    -- CP-element group 135: 	9 
    -- CP-element group 135: successors 
    -- CP-element group 135: 	10 
    -- CP-element group 135:  members (1) 
      -- CP-element group 135: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/loop_body_delay_to_condition_start
      -- 
    -- Element group outputPort_2_Daemon_CP_821_elements(135) is a control-delay.
    cp_element_135_delay: control_delay_element  generic map(name => " 135_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_821_elements(9), ack => outputPort_2_Daemon_CP_821_elements(135), clk => clk, reset =>reset);
    -- CP-element group 136:  join  transition  bypass  pipeline-parent 
    -- CP-element group 136: predecessors 
    -- CP-element group 136: 	134 
    -- CP-element group 136: 	12 
    -- CP-element group 136: successors 
    -- CP-element group 136: 	6 
    -- CP-element group 136:  members (1) 
      -- CP-element group 136: 	 branch_block_stmt_497/do_while_stmt_498/do_while_stmt_498_loop_body/$exit
      -- 
    outputPort_2_Daemon_cp_element_group_136: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 7);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 40) := "outputPort_2_Daemon_cp_element_group_136"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_821_elements(134) & outputPort_2_Daemon_CP_821_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_136 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(136), clk => clk, reset => reset); --
    end block;
    -- CP-element group 137:  transition  input  bypass  pipeline-parent 
    -- CP-element group 137: predecessors 
    -- CP-element group 137: 	5 
    -- CP-element group 137: successors 
    -- CP-element group 137:  members (2) 
      -- CP-element group 137: 	 branch_block_stmt_497/do_while_stmt_498/loop_exit/$exit
      -- CP-element group 137: 	 branch_block_stmt_497/do_while_stmt_498/loop_exit/ack
      -- 
    ack_1134_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 137_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_498_branch_ack_0, ack => outputPort_2_Daemon_CP_821_elements(137)); -- 
    -- CP-element group 138:  transition  input  bypass  pipeline-parent 
    -- CP-element group 138: predecessors 
    -- CP-element group 138: 	5 
    -- CP-element group 138: successors 
    -- CP-element group 138:  members (2) 
      -- CP-element group 138: 	 branch_block_stmt_497/do_while_stmt_498/loop_taken/$exit
      -- CP-element group 138: 	 branch_block_stmt_497/do_while_stmt_498/loop_taken/ack
      -- 
    ack_1138_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 138_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_498_branch_ack_1, ack => outputPort_2_Daemon_CP_821_elements(138)); -- 
    -- CP-element group 139:  transition  bypass  pipeline-parent 
    -- CP-element group 139: predecessors 
    -- CP-element group 139: 	3 
    -- CP-element group 139: successors 
    -- CP-element group 139: 	1 
    -- CP-element group 139:  members (1) 
      -- CP-element group 139: 	 branch_block_stmt_497/do_while_stmt_498/$exit
      -- 
    outputPort_2_Daemon_CP_821_elements(139) <= outputPort_2_Daemon_CP_821_elements(3);
    outputPort_2_Daemon_do_while_stmt_498_terminator_1139: loop_terminator -- 
      generic map (name => " outputPort_2_Daemon_do_while_stmt_498_terminator_1139", max_iterations_in_flight =>7) 
      port map(loop_body_exit => outputPort_2_Daemon_CP_821_elements(6),loop_continue => outputPort_2_Daemon_CP_821_elements(138),loop_terminate => outputPort_2_Daemon_CP_821_elements(137),loop_back => outputPort_2_Daemon_CP_821_elements(4),loop_exit => outputPort_2_Daemon_CP_821_elements(3),clk => clk, reset => reset); -- 
    phi_stmt_500_phi_seq_895_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_821_elements(24);
      outputPort_2_Daemon_CP_821_elements(27)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_821_elements(27);
      outputPort_2_Daemon_CP_821_elements(28)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_821_elements(29);
      outputPort_2_Daemon_CP_821_elements(25) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_821_elements(22);
      outputPort_2_Daemon_CP_821_elements(31)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_821_elements(33);
      outputPort_2_Daemon_CP_821_elements(32)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_821_elements(34);
      outputPort_2_Daemon_CP_821_elements(23) <= phi_mux_reqs(1);
      phi_stmt_500_phi_seq_895 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_500_phi_seq_895") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_821_elements(18), 
          phi_sample_ack => outputPort_2_Daemon_CP_821_elements(19), 
          phi_update_req => outputPort_2_Daemon_CP_821_elements(20), 
          phi_update_ack => outputPort_2_Daemon_CP_821_elements(21), 
          phi_mux_ack => outputPort_2_Daemon_CP_821_elements(26), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_504_phi_seq_939_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_821_elements(43);
      outputPort_2_Daemon_CP_821_elements(46)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_821_elements(46);
      outputPort_2_Daemon_CP_821_elements(47)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_821_elements(48);
      outputPort_2_Daemon_CP_821_elements(44) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_821_elements(41);
      outputPort_2_Daemon_CP_821_elements(50)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_821_elements(54);
      outputPort_2_Daemon_CP_821_elements(51)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_821_elements(55);
      outputPort_2_Daemon_CP_821_elements(42) <= phi_mux_reqs(1);
      phi_stmt_504_phi_seq_939 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_504_phi_seq_939") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_821_elements(37), 
          phi_sample_ack => outputPort_2_Daemon_CP_821_elements(38), 
          phi_update_req => outputPort_2_Daemon_CP_821_elements(39), 
          phi_update_ack => outputPort_2_Daemon_CP_821_elements(40), 
          phi_mux_ack => outputPort_2_Daemon_CP_821_elements(45), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_509_phi_seq_983_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_821_elements(62);
      outputPort_2_Daemon_CP_821_elements(65)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_821_elements(65);
      outputPort_2_Daemon_CP_821_elements(66)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_821_elements(67);
      outputPort_2_Daemon_CP_821_elements(63) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_821_elements(60);
      outputPort_2_Daemon_CP_821_elements(69)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_821_elements(73);
      outputPort_2_Daemon_CP_821_elements(70)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_821_elements(74);
      outputPort_2_Daemon_CP_821_elements(61) <= phi_mux_reqs(1);
      phi_stmt_509_phi_seq_983 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_509_phi_seq_983") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_821_elements(11), 
          phi_sample_ack => outputPort_2_Daemon_CP_821_elements(58), 
          phi_update_req => outputPort_2_Daemon_CP_821_elements(14), 
          phi_update_ack => outputPort_2_Daemon_CP_821_elements(59), 
          phi_mux_ack => outputPort_2_Daemon_CP_821_elements(64), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_514_phi_seq_1027_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_821_elements(83);
      outputPort_2_Daemon_CP_821_elements(86)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_821_elements(86);
      outputPort_2_Daemon_CP_821_elements(87)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_821_elements(88);
      outputPort_2_Daemon_CP_821_elements(84) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_821_elements(81);
      outputPort_2_Daemon_CP_821_elements(90)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_821_elements(92);
      outputPort_2_Daemon_CP_821_elements(91)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_821_elements(93);
      outputPort_2_Daemon_CP_821_elements(82) <= phi_mux_reqs(1);
      phi_stmt_514_phi_seq_1027 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_514_phi_seq_1027") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_821_elements(77), 
          phi_sample_ack => outputPort_2_Daemon_CP_821_elements(78), 
          phi_update_req => outputPort_2_Daemon_CP_821_elements(79), 
          phi_update_ack => outputPort_2_Daemon_CP_821_elements(80), 
          phi_mux_ack => outputPort_2_Daemon_CP_821_elements(85), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_518_phi_seq_1071_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_821_elements(102);
      outputPort_2_Daemon_CP_821_elements(105)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_821_elements(105);
      outputPort_2_Daemon_CP_821_elements(106)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_821_elements(107);
      outputPort_2_Daemon_CP_821_elements(103) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_821_elements(100);
      outputPort_2_Daemon_CP_821_elements(109)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_821_elements(111);
      outputPort_2_Daemon_CP_821_elements(110)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_821_elements(112);
      outputPort_2_Daemon_CP_821_elements(101) <= phi_mux_reqs(1);
      phi_stmt_518_phi_seq_1071 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_518_phi_seq_1071") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_821_elements(96), 
          phi_sample_ack => outputPort_2_Daemon_CP_821_elements(97), 
          phi_update_req => outputPort_2_Daemon_CP_821_elements(98), 
          phi_update_ack => outputPort_2_Daemon_CP_821_elements(99), 
          phi_mux_ack => outputPort_2_Daemon_CP_821_elements(104), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_522_phi_seq_1115_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_821_elements(121);
      outputPort_2_Daemon_CP_821_elements(124)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_821_elements(124);
      outputPort_2_Daemon_CP_821_elements(125)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_821_elements(126);
      outputPort_2_Daemon_CP_821_elements(122) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_821_elements(119);
      outputPort_2_Daemon_CP_821_elements(128)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_821_elements(130);
      outputPort_2_Daemon_CP_821_elements(129)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_821_elements(131);
      outputPort_2_Daemon_CP_821_elements(120) <= phi_mux_reqs(1);
      phi_stmt_522_phi_seq_1115 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_522_phi_seq_1115") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_821_elements(115), 
          phi_sample_ack => outputPort_2_Daemon_CP_821_elements(116), 
          phi_update_req => outputPort_2_Daemon_CP_821_elements(117), 
          phi_update_ack => outputPort_2_Daemon_CP_821_elements(118), 
          phi_mux_ack => outputPort_2_Daemon_CP_821_elements(123), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    entry_tmerge_846_block : block -- 
      signal preds : BooleanArray(0 to 1);
      begin -- 
        preds(0)  <= outputPort_2_Daemon_CP_821_elements(7);
        preds(1)  <= outputPort_2_Daemon_CP_821_elements(8);
        entry_tmerge_846 : transition_merge -- 
          generic map(name => " entry_tmerge_846")
          port map (preds => preds, symbol_out => outputPort_2_Daemon_CP_821_elements(9));
          -- 
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal EQ_u2_u1_548_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_554_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_581_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_608_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_616_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_622_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_632_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_638_wire : std_logic_vector(0 downto 0);
    signal EQ_u8_u1_574_wire : std_logic_vector(0 downto 0);
    signal MUX_551_wire : std_logic_vector(0 downto 0);
    signal MUX_557_wire : std_logic_vector(0 downto 0);
    signal MUX_586_wire : std_logic_vector(7 downto 0);
    signal MUX_600_wire : std_logic_vector(7 downto 0);
    signal MUX_635_wire : std_logic_vector(0 downto 0);
    signal MUX_641_wire : std_logic_vector(0 downto 0);
    signal NEQ_u2_u1_571_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_605_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_613_wire : std_logic_vector(0 downto 0);
    signal RPIPE_noblock_obuf_1_2_508_wire : std_logic_vector(32 downto 0);
    signal RPIPE_noblock_obuf_2_2_513_wire : std_logic_vector(32 downto 0);
    signal R_ZERO_1_524_wire_constant : std_logic_vector(0 downto 0);
    signal R_ZERO_2_516_wire_constant : std_logic_vector(1 downto 0);
    signal R_ZERO_33_506_wire_constant : std_logic_vector(32 downto 0);
    signal R_ZERO_33_511_wire_constant : std_logic_vector(32 downto 0);
    signal R_ZERO_8_502_wire_constant : std_logic_vector(7 downto 0);
    signal R_ZERO_8_520_wire_constant : std_logic_vector(7 downto 0);
    signal SUB_u8_u8_594_wire : std_logic_vector(7 downto 0);
    signal SUB_u8_u8_598_wire : std_logic_vector(7 downto 0);
    signal active_packet_514 : std_logic_vector(1 downto 0);
    signal active_packet_length_518 : std_logic_vector(7 downto 0);
    signal data_to_out_628 : std_logic_vector(31 downto 0);
    signal down_counter_500 : std_logic_vector(7 downto 0);
    signal konst_529_wire_constant : std_logic_vector(32 downto 0);
    signal konst_534_wire_constant : std_logic_vector(32 downto 0);
    signal konst_547_wire_constant : std_logic_vector(1 downto 0);
    signal konst_550_wire_constant : std_logic_vector(0 downto 0);
    signal konst_553_wire_constant : std_logic_vector(1 downto 0);
    signal konst_556_wire_constant : std_logic_vector(0 downto 0);
    signal konst_570_wire_constant : std_logic_vector(1 downto 0);
    signal konst_573_wire_constant : std_logic_vector(7 downto 0);
    signal konst_580_wire_constant : std_logic_vector(1 downto 0);
    signal konst_593_wire_constant : std_logic_vector(7 downto 0);
    signal konst_597_wire_constant : std_logic_vector(7 downto 0);
    signal konst_607_wire_constant : std_logic_vector(1 downto 0);
    signal konst_615_wire_constant : std_logic_vector(1 downto 0);
    signal konst_621_wire_constant : std_logic_vector(1 downto 0);
    signal konst_631_wire_constant : std_logic_vector(1 downto 0);
    signal konst_634_wire_constant : std_logic_vector(0 downto 0);
    signal konst_637_wire_constant : std_logic_vector(1 downto 0);
    signal konst_640_wire_constant : std_logic_vector(0 downto 0);
    signal konst_656_wire_constant : std_logic_vector(0 downto 0);
    signal next_active_packet_567 : std_logic_vector(1 downto 0);
    signal next_active_packet_567_517_buffered : std_logic_vector(1 downto 0);
    signal next_active_packet_length_589 : std_logic_vector(7 downto 0);
    signal next_active_packet_length_589_521_buffered : std_logic_vector(7 downto 0);
    signal next_down_counter_602 : std_logic_vector(7 downto 0);
    signal next_down_counter_602_503_buffered : std_logic_vector(7 downto 0);
    signal next_pkt_1_has_priority_567 : std_logic_vector(0 downto 0);
    signal next_pkt_1_has_priority_567_525_buffered : std_logic_vector(0 downto 0);
    signal p1_valid_531 : std_logic_vector(0 downto 0);
    signal p2_valid_536 : std_logic_vector(0 downto 0);
    signal pkt_1_e_word_504 : std_logic_vector(32 downto 0);
    signal pkt_1_has_priority_522 : std_logic_vector(0 downto 0);
    signal pkt_2_e_word_509 : std_logic_vector(32 downto 0);
    signal read_from_1_610 : std_logic_vector(0 downto 0);
    signal read_from_2_618 : std_logic_vector(0 downto 0);
    signal send_flag_643 : std_logic_vector(0 downto 0);
    signal slice_583_wire : std_logic_vector(7 downto 0);
    signal slice_585_wire : std_logic_vector(7 downto 0);
    signal slice_624_wire : std_logic_vector(31 downto 0);
    signal slice_626_wire : std_logic_vector(31 downto 0);
    signal started_new_packet_576 : std_logic_vector(0 downto 0);
    signal valid_active_pkt_word_read_559 : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    R_ZERO_1_524_wire_constant <= "0";
    R_ZERO_2_516_wire_constant <= "00";
    R_ZERO_33_506_wire_constant <= "000000000000000000000000000000000";
    R_ZERO_33_511_wire_constant <= "000000000000000000000000000000000";
    R_ZERO_8_502_wire_constant <= "00000000";
    R_ZERO_8_520_wire_constant <= "00000000";
    konst_529_wire_constant <= "000000000000000000000000000100000";
    konst_534_wire_constant <= "000000000000000000000000000100000";
    konst_547_wire_constant <= "01";
    konst_550_wire_constant <= "0";
    konst_553_wire_constant <= "10";
    konst_556_wire_constant <= "0";
    konst_570_wire_constant <= "00";
    konst_573_wire_constant <= "00000000";
    konst_580_wire_constant <= "01";
    konst_593_wire_constant <= "00000001";
    konst_597_wire_constant <= "00000001";
    konst_607_wire_constant <= "01";
    konst_615_wire_constant <= "10";
    konst_621_wire_constant <= "01";
    konst_631_wire_constant <= "01";
    konst_634_wire_constant <= "0";
    konst_637_wire_constant <= "10";
    konst_640_wire_constant <= "0";
    konst_656_wire_constant <= "1";
    phi_stmt_500: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_8_502_wire_constant & next_down_counter_602_503_buffered;
      req <= phi_stmt_500_req_0 & phi_stmt_500_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_500",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_500_ack_0,
          idata => idata,
          odata => down_counter_500,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_500
    phi_stmt_504: Block -- phi operator 
      signal idata: std_logic_vector(65 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_33_506_wire_constant & RPIPE_noblock_obuf_1_2_508_wire;
      req <= phi_stmt_504_req_0 & phi_stmt_504_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_504",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 33) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_504_ack_0,
          idata => idata,
          odata => pkt_1_e_word_504,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_504
    phi_stmt_509: Block -- phi operator 
      signal idata: std_logic_vector(65 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_33_511_wire_constant & RPIPE_noblock_obuf_2_2_513_wire;
      req <= phi_stmt_509_req_0 & phi_stmt_509_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_509",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 33) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_509_ack_0,
          idata => idata,
          odata => pkt_2_e_word_509,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_509
    phi_stmt_514: Block -- phi operator 
      signal idata: std_logic_vector(3 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_2_516_wire_constant & next_active_packet_567_517_buffered;
      req <= phi_stmt_514_req_0 & phi_stmt_514_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_514",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 2) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_514_ack_0,
          idata => idata,
          odata => active_packet_514,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_514
    phi_stmt_518: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_8_520_wire_constant & next_active_packet_length_589_521_buffered;
      req <= phi_stmt_518_req_0 & phi_stmt_518_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_518",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_518_ack_0,
          idata => idata,
          odata => active_packet_length_518,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_518
    phi_stmt_522: Block -- phi operator 
      signal idata: std_logic_vector(1 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_1_524_wire_constant & next_pkt_1_has_priority_567_525_buffered;
      req <= phi_stmt_522_req_0 & phi_stmt_522_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_522",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 1) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_522_ack_0,
          idata => idata,
          odata => pkt_1_has_priority_522,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_522
    -- flow-through select operator MUX_551_inst
    MUX_551_wire <= p1_valid_531 when (EQ_u2_u1_548_wire(0) /=  '0') else konst_550_wire_constant;
    -- flow-through select operator MUX_557_inst
    MUX_557_wire <= p2_valid_536 when (EQ_u2_u1_554_wire(0) /=  '0') else konst_556_wire_constant;
    -- flow-through select operator MUX_586_inst
    MUX_586_wire <= slice_583_wire when (EQ_u2_u1_581_wire(0) /=  '0') else slice_585_wire;
    -- flow-through select operator MUX_588_inst
    next_active_packet_length_589 <= MUX_586_wire when (started_new_packet_576(0) /=  '0') else active_packet_length_518;
    -- flow-through select operator MUX_600_inst
    MUX_600_wire <= SUB_u8_u8_598_wire when (valid_active_pkt_word_read_559(0) /=  '0') else down_counter_500;
    -- flow-through select operator MUX_601_inst
    next_down_counter_602 <= SUB_u8_u8_594_wire when (started_new_packet_576(0) /=  '0') else MUX_600_wire;
    -- flow-through select operator MUX_627_inst
    data_to_out_628 <= slice_624_wire when (EQ_u2_u1_622_wire(0) /=  '0') else slice_626_wire;
    -- flow-through select operator MUX_635_inst
    MUX_635_wire <= p1_valid_531 when (EQ_u2_u1_632_wire(0) /=  '0') else konst_634_wire_constant;
    -- flow-through select operator MUX_641_inst
    MUX_641_wire <= p2_valid_536 when (EQ_u2_u1_638_wire(0) /=  '0') else konst_640_wire_constant;
    -- flow-through slice operator slice_583_inst
    slice_583_wire <= pkt_1_e_word_504(15 downto 8);
    -- flow-through slice operator slice_585_inst
    slice_585_wire <= pkt_2_e_word_509(15 downto 8);
    -- flow-through slice operator slice_624_inst
    slice_624_wire <= pkt_1_e_word_504(31 downto 0);
    -- flow-through slice operator slice_626_inst
    slice_626_wire <= pkt_2_e_word_509(31 downto 0);
    next_active_packet_567_517_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_active_packet_567_517_buf_req_0;
      next_active_packet_567_517_buf_ack_0<= wack(0);
      rreq(0) <= next_active_packet_567_517_buf_req_1;
      next_active_packet_567_517_buf_ack_1<= rack(0);
      next_active_packet_567_517_buf : InterlockBuffer generic map ( -- 
        name => "next_active_packet_567_517_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 2,
        out_data_width => 2,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_active_packet_567,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_active_packet_567_517_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_active_packet_length_589_521_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_active_packet_length_589_521_buf_req_0;
      next_active_packet_length_589_521_buf_ack_0<= wack(0);
      rreq(0) <= next_active_packet_length_589_521_buf_req_1;
      next_active_packet_length_589_521_buf_ack_1<= rack(0);
      next_active_packet_length_589_521_buf : InterlockBuffer generic map ( -- 
        name => "next_active_packet_length_589_521_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_active_packet_length_589,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_active_packet_length_589_521_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_down_counter_602_503_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_down_counter_602_503_buf_req_0;
      next_down_counter_602_503_buf_ack_0<= wack(0);
      rreq(0) <= next_down_counter_602_503_buf_req_1;
      next_down_counter_602_503_buf_ack_1<= rack(0);
      next_down_counter_602_503_buf : InterlockBuffer generic map ( -- 
        name => "next_down_counter_602_503_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_down_counter_602,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_down_counter_602_503_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_pkt_1_has_priority_567_525_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_pkt_1_has_priority_567_525_buf_req_0;
      next_pkt_1_has_priority_567_525_buf_ack_0<= wack(0);
      rreq(0) <= next_pkt_1_has_priority_567_525_buf_req_1;
      next_pkt_1_has_priority_567_525_buf_ack_1<= rack(0);
      next_pkt_1_has_priority_567_525_buf : InterlockBuffer generic map ( -- 
        name => "next_pkt_1_has_priority_567_525_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 1,
        out_data_width => 1,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_pkt_1_has_priority_567,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_pkt_1_has_priority_567_525_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    do_while_stmt_498_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= konst_656_wire_constant;
      branch_instance: BranchBase -- 
        generic map( name => "do_while_stmt_498_branch", condition_width => 1,  bypass_flag => true)
        port map( -- 
          condition => condition_sig,
          req => do_while_stmt_498_branch_req_0,
          ack0 => do_while_stmt_498_branch_ack_0,
          ack1 => do_while_stmt_498_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- flow through binary operator AND_u1_u1_575_inst
    started_new_packet_576 <= (NEQ_u2_u1_571_wire and EQ_u8_u1_574_wire);
    -- flow through binary operator BITSEL_u33_u1_530_inst
    process(pkt_1_e_word_504) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApBitsel_proc(pkt_1_e_word_504, konst_529_wire_constant, tmp_var);
      p1_valid_531 <= tmp_var; --
    end process;
    -- flow through binary operator BITSEL_u33_u1_535_inst
    process(pkt_2_e_word_509) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApBitsel_proc(pkt_2_e_word_509, konst_534_wire_constant, tmp_var);
      p2_valid_536 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_548_inst
    process(active_packet_514) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(active_packet_514, konst_547_wire_constant, tmp_var);
      EQ_u2_u1_548_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_554_inst
    process(active_packet_514) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(active_packet_514, konst_553_wire_constant, tmp_var);
      EQ_u2_u1_554_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_581_inst
    process(next_active_packet_567) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_567, konst_580_wire_constant, tmp_var);
      EQ_u2_u1_581_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_608_inst
    process(next_active_packet_567) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_567, konst_607_wire_constant, tmp_var);
      EQ_u2_u1_608_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_616_inst
    process(next_active_packet_567) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_567, konst_615_wire_constant, tmp_var);
      EQ_u2_u1_616_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_622_inst
    process(next_active_packet_567) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_567, konst_621_wire_constant, tmp_var);
      EQ_u2_u1_622_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_632_inst
    process(next_active_packet_567) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_567, konst_631_wire_constant, tmp_var);
      EQ_u2_u1_632_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_638_inst
    process(next_active_packet_567) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_567, konst_637_wire_constant, tmp_var);
      EQ_u2_u1_638_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_574_inst
    process(down_counter_500) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(down_counter_500, konst_573_wire_constant, tmp_var);
      EQ_u8_u1_574_wire <= tmp_var; --
    end process;
    -- flow through binary operator NEQ_u2_u1_571_inst
    process(next_active_packet_567) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntNe_proc(next_active_packet_567, konst_570_wire_constant, tmp_var);
      NEQ_u2_u1_571_wire <= tmp_var; --
    end process;
    -- unary operator NOT_u1_u1_605_inst
    process(p1_valid_531) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p1_valid_531, tmp_var);
      NOT_u1_u1_605_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_613_inst
    process(p2_valid_536) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p2_valid_536, tmp_var);
      NOT_u1_u1_613_wire <= tmp_var; -- 
    end process;
    -- flow through binary operator OR_u1_u1_558_inst
    valid_active_pkt_word_read_559 <= (MUX_551_wire or MUX_557_wire);
    -- flow through binary operator OR_u1_u1_609_inst
    read_from_1_610 <= (NOT_u1_u1_605_wire or EQ_u2_u1_608_wire);
    -- flow through binary operator OR_u1_u1_617_inst
    read_from_2_618 <= (NOT_u1_u1_613_wire or EQ_u2_u1_616_wire);
    -- flow through binary operator OR_u1_u1_642_inst
    send_flag_643 <= (MUX_635_wire or MUX_641_wire);
    -- flow through binary operator SUB_u8_u8_594_inst
    SUB_u8_u8_594_wire <= std_logic_vector(unsigned(next_active_packet_length_589) - unsigned(konst_593_wire_constant));
    -- flow through binary operator SUB_u8_u8_598_inst
    SUB_u8_u8_598_wire <= std_logic_vector(unsigned(down_counter_500) - unsigned(konst_597_wire_constant));
    -- shared inport operator group (0) : RPIPE_noblock_obuf_1_2_508_inst 
    InportGroup_0: Block -- 
      signal data_out: std_logic_vector(32 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_noblock_obuf_1_2_508_inst_req_0;
      RPIPE_noblock_obuf_1_2_508_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_noblock_obuf_1_2_508_inst_req_1;
      RPIPE_noblock_obuf_1_2_508_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <= read_from_1_610(0);
      RPIPE_noblock_obuf_1_2_508_wire <= data_out(32 downto 0);
      noblock_obuf_1_2_read_0_gI: SplitGuardInterface generic map(name => "noblock_obuf_1_2_read_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_1_2_read_0: InputPortRevised -- 
        generic map ( name => "noblock_obuf_1_2_read_0", data_width => 33,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => true,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => noblock_obuf_1_2_pipe_read_req(0),
          oack => noblock_obuf_1_2_pipe_read_ack(0),
          odata => noblock_obuf_1_2_pipe_read_data(32 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared inport operator group (1) : RPIPE_noblock_obuf_2_2_513_inst 
    InportGroup_1: Block -- 
      signal data_out: std_logic_vector(32 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_noblock_obuf_2_2_513_inst_req_0;
      RPIPE_noblock_obuf_2_2_513_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_noblock_obuf_2_2_513_inst_req_1;
      RPIPE_noblock_obuf_2_2_513_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <= read_from_2_618(0);
      RPIPE_noblock_obuf_2_2_513_wire <= data_out(32 downto 0);
      noblock_obuf_2_2_read_1_gI: SplitGuardInterface generic map(name => "noblock_obuf_2_2_read_1_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_2_2_read_1: InputPortRevised -- 
        generic map ( name => "noblock_obuf_2_2_read_1", data_width => 33,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => true,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => noblock_obuf_2_2_pipe_read_req(0),
          oack => noblock_obuf_2_2_pipe_read_ack(0),
          odata => noblock_obuf_2_2_pipe_read_data(32 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 1
    -- shared outport operator group (0) : WPIPE_out_data_2_645_inst 
    OutportGroup_0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_out_data_2_645_inst_req_0;
      WPIPE_out_data_2_645_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_out_data_2_645_inst_req_1;
      WPIPE_out_data_2_645_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_flag_643(0);
      data_in <= data_to_out_628;
      out_data_2_write_0_gI: SplitGuardInterface generic map(name => "out_data_2_write_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      out_data_2_write_0: OutputPortRevised -- 
        generic map ( name => "out_data_2", data_width => 32, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => out_data_2_pipe_write_req(0),
          oack => out_data_2_pipe_write_ack(0),
          odata => out_data_2_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    volatile_operator_prioritySelect_1640: prioritySelect_Volatile port map(down_counter => down_counter_500, active_packet => active_packet_514, pkt_1_has_priority => pkt_1_has_priority_522, p1_valid => p1_valid_531, p2_valid => p2_valid_536, next_active_packet => next_active_packet_567, next_pkt_1_has_priority => next_pkt_1_has_priority_567); 
    -- 
  end Block; -- data_path
  -- 
end outputPort_2_Daemon_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.ahir_system_global_package.all;
entity prioritySelect_Volatile is -- 
  port ( -- 
    down_counter : in  std_logic_vector(7 downto 0);
    active_packet : in  std_logic_vector(1 downto 0);
    pkt_1_has_priority : in  std_logic_vector(0 downto 0);
    p1_valid : in  std_logic_vector(0 downto 0);
    p2_valid : in  std_logic_vector(0 downto 0);
    next_active_packet : out  std_logic_vector(1 downto 0);
    next_pkt_1_has_priority : out  std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity prioritySelect_Volatile;
architecture prioritySelect_Volatile_arch of prioritySelect_Volatile is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector(13-1 downto 0);
  signal default_zero_sig: std_logic;
  -- input port buffer signals
  signal down_counter_buffer :  std_logic_vector(7 downto 0);
  signal active_packet_buffer :  std_logic_vector(1 downto 0);
  signal pkt_1_has_priority_buffer :  std_logic_vector(0 downto 0);
  signal p1_valid_buffer :  std_logic_vector(0 downto 0);
  signal p2_valid_buffer :  std_logic_vector(0 downto 0);
  -- output port buffer signals
  signal next_active_packet_buffer :  std_logic_vector(1 downto 0);
  signal next_pkt_1_has_priority_buffer :  std_logic_vector(0 downto 0);
  -- volatile/operator module components. 
  -- 
begin --  
  -- input handling ------------------------------------------------
  down_counter_buffer <= down_counter;
  active_packet_buffer <= active_packet;
  pkt_1_has_priority_buffer <= pkt_1_has_priority;
  p1_valid_buffer <= p1_valid;
  p2_valid_buffer <= p2_valid;
  -- output handling  -------------------------------------------------------
  next_active_packet <= next_active_packet_buffer;
  next_pkt_1_has_priority <= next_pkt_1_has_priority_buffer;
  -- the control path --------------------------------------------------
  default_zero_sig <= '0';
  -- volatile module, no control path
  -- the data path
  data_path: Block -- 
    signal AND_u1_u1_288_wire : std_logic_vector(0 downto 0);
    signal AND_u1_u1_298_wire : std_logic_vector(0 downto 0);
    signal MUX_311_wire : std_logic_vector(1 downto 0);
    signal MUX_315_wire : std_logic_vector(1 downto 0);
    signal MUX_320_wire : std_logic_vector(1 downto 0);
    signal NOT_u1_u1_291_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_300_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_302_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_308_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_328_wire : std_logic_vector(0 downto 0);
    signal OR_u1_u1_292_wire : std_logic_vector(0 downto 0);
    signal OR_u1_u1_303_wire : std_logic_vector(0 downto 0);
    signal OR_u1_u1_326_wire : std_logic_vector(0 downto 0);
    signal OR_u2_u2_316_wire : std_logic_vector(1 downto 0);
    signal d0_284 : std_logic_vector(0 downto 0);
    signal konst_282_wire_constant : std_logic_vector(7 downto 0);
    signal konst_310_wire_constant : std_logic_vector(1 downto 0);
    signal konst_313_wire_constant : std_logic_vector(1 downto 0);
    signal konst_314_wire_constant : std_logic_vector(1 downto 0);
    signal konst_318_wire_constant : std_logic_vector(1 downto 0);
    signal konst_319_wire_constant : std_logic_vector(1 downto 0);
    signal select_1_294 : std_logic_vector(0 downto 0);
    signal select_2_305 : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    konst_282_wire_constant <= "00000000";
    konst_310_wire_constant <= "00";
    konst_313_wire_constant <= "01";
    konst_314_wire_constant <= "00";
    konst_318_wire_constant <= "10";
    konst_319_wire_constant <= "00";
    -- flow-through select operator MUX_311_inst
    MUX_311_wire <= active_packet_buffer when (NOT_u1_u1_308_wire(0) /=  '0') else konst_310_wire_constant;
    -- flow-through select operator MUX_315_inst
    MUX_315_wire <= konst_313_wire_constant when (select_1_294(0) /=  '0') else konst_314_wire_constant;
    -- flow-through select operator MUX_320_inst
    MUX_320_wire <= konst_318_wire_constant when (select_2_305(0) /=  '0') else konst_319_wire_constant;
    -- flow-through select operator MUX_330_inst
    next_pkt_1_has_priority_buffer <= NOT_u1_u1_328_wire when (OR_u1_u1_326_wire(0) /=  '0') else pkt_1_has_priority_buffer;
    -- flow through binary operator AND_u1_u1_288_inst
    AND_u1_u1_288_wire <= (d0_284 and p1_valid_buffer);
    -- flow through binary operator AND_u1_u1_293_inst
    select_1_294 <= (AND_u1_u1_288_wire and OR_u1_u1_292_wire);
    -- flow through binary operator AND_u1_u1_298_inst
    AND_u1_u1_298_wire <= (d0_284 and p2_valid_buffer);
    -- flow through binary operator AND_u1_u1_304_inst
    select_2_305 <= (AND_u1_u1_298_wire and OR_u1_u1_303_wire);
    -- flow through binary operator EQ_u8_u1_283_inst
    process(down_counter_buffer) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(down_counter_buffer, konst_282_wire_constant, tmp_var);
      d0_284 <= tmp_var; --
    end process;
    -- unary operator NOT_u1_u1_291_inst
    process(p2_valid_buffer) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p2_valid_buffer, tmp_var);
      NOT_u1_u1_291_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_300_inst
    process(pkt_1_has_priority_buffer) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", pkt_1_has_priority_buffer, tmp_var);
      NOT_u1_u1_300_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_302_inst
    process(p1_valid_buffer) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p1_valid_buffer, tmp_var);
      NOT_u1_u1_302_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_308_inst
    process(d0_284) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", d0_284, tmp_var);
      NOT_u1_u1_308_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_328_inst
    process(pkt_1_has_priority_buffer) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", pkt_1_has_priority_buffer, tmp_var);
      NOT_u1_u1_328_wire <= tmp_var; -- 
    end process;
    -- flow through binary operator OR_u1_u1_292_inst
    OR_u1_u1_292_wire <= (pkt_1_has_priority_buffer or NOT_u1_u1_291_wire);
    -- flow through binary operator OR_u1_u1_303_inst
    OR_u1_u1_303_wire <= (NOT_u1_u1_300_wire or NOT_u1_u1_302_wire);
    -- flow through binary operator OR_u1_u1_326_inst
    OR_u1_u1_326_wire <= (select_1_294 or select_2_305);
    -- flow through binary operator OR_u2_u2_316_inst
    OR_u2_u2_316_wire <= (MUX_311_wire or MUX_315_wire);
    -- flow through binary operator OR_u2_u2_321_inst
    next_active_packet_buffer <= (OR_u2_u2_316_wire or MUX_320_wire);
    -- 
  end Block; -- data_path
  -- 
end prioritySelect_Volatile_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.ahir_system_global_package.all;
entity ahir_system is  -- system 
  port (-- 
    clk : in std_logic;
    reset : in std_logic;
    in_data_1_64_pipe_write_data: in std_logic_vector(63 downto 0);
    in_data_1_64_pipe_write_req : in std_logic_vector(0 downto 0);
    in_data_1_64_pipe_write_ack : out std_logic_vector(0 downto 0);
    in_data_2_64_pipe_write_data: in std_logic_vector(63 downto 0);
    in_data_2_64_pipe_write_req : in std_logic_vector(0 downto 0);
    in_data_2_64_pipe_write_ack : out std_logic_vector(0 downto 0);
    out_data_1_pipe_read_data: out std_logic_vector(31 downto 0);
    out_data_1_pipe_read_req : in std_logic_vector(0 downto 0);
    out_data_1_pipe_read_ack : out std_logic_vector(0 downto 0);
    out_data_2_pipe_read_data: out std_logic_vector(31 downto 0);
    out_data_2_pipe_read_req : in std_logic_vector(0 downto 0);
    out_data_2_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
  -- 
end entity; 
architecture ahir_system_arch  of ahir_system is -- system-architecture 
  -- declarations related to module converter_1_Daemon
  component converter_1_Daemon is -- 
    generic (tag_length : integer); 
    port ( -- 
      in_data_1_64_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_1_64_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_1_64_pipe_read_data : in   std_logic_vector(63 downto 0);
      in_data_1_pipe_write_req : out  std_logic_vector(0 downto 0);
      in_data_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
      in_data_1_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) ;
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic-- 
    );
    -- 
  end component;
  -- argument signals for module converter_1_Daemon
  signal converter_1_Daemon_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal converter_1_Daemon_tag_out   : std_logic_vector(1 downto 0);
  signal converter_1_Daemon_start_req : std_logic;
  signal converter_1_Daemon_start_ack : std_logic;
  signal converter_1_Daemon_fin_req   : std_logic;
  signal converter_1_Daemon_fin_ack : std_logic;
  -- declarations related to module converter_2_Daemon
  component converter_2_Daemon is -- 
    generic (tag_length : integer); 
    port ( -- 
      in_data_2_64_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_2_64_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_2_64_pipe_read_data : in   std_logic_vector(63 downto 0);
      in_data_2_pipe_write_req : out  std_logic_vector(0 downto 0);
      in_data_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
      in_data_2_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) ;
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic-- 
    );
    -- 
  end component;
  -- argument signals for module converter_2_Daemon
  signal converter_2_Daemon_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal converter_2_Daemon_tag_out   : std_logic_vector(1 downto 0);
  signal converter_2_Daemon_start_req : std_logic;
  signal converter_2_Daemon_start_ack : std_logic;
  signal converter_2_Daemon_fin_req   : std_logic;
  signal converter_2_Daemon_fin_ack : std_logic;
  -- declarations related to module inputPort_1_Daemon
  component inputPort_1_Daemon is -- 
    generic (tag_length : integer); 
    port ( -- 
      in_data_1_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_1_pipe_read_data : in   std_logic_vector(31 downto 0);
      noblock_obuf_1_1_pipe_write_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_1_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_1_1_pipe_write_data : out  std_logic_vector(32 downto 0);
      noblock_obuf_1_2_pipe_write_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_1_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_1_2_pipe_write_data : out  std_logic_vector(32 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) ;
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic-- 
    );
    -- 
  end component;
  -- argument signals for module inputPort_1_Daemon
  signal inputPort_1_Daemon_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal inputPort_1_Daemon_tag_out   : std_logic_vector(1 downto 0);
  signal inputPort_1_Daemon_start_req : std_logic;
  signal inputPort_1_Daemon_start_ack : std_logic;
  signal inputPort_1_Daemon_fin_req   : std_logic;
  signal inputPort_1_Daemon_fin_ack : std_logic;
  -- declarations related to module inputPort_2_Daemon
  component inputPort_2_Daemon is -- 
    generic (tag_length : integer); 
    port ( -- 
      in_data_2_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_2_pipe_read_data : in   std_logic_vector(31 downto 0);
      noblock_obuf_2_1_pipe_write_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_2_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_2_1_pipe_write_data : out  std_logic_vector(32 downto 0);
      noblock_obuf_2_2_pipe_write_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_2_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_2_2_pipe_write_data : out  std_logic_vector(32 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) ;
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic-- 
    );
    -- 
  end component;
  -- argument signals for module inputPort_2_Daemon
  signal inputPort_2_Daemon_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal inputPort_2_Daemon_tag_out   : std_logic_vector(1 downto 0);
  signal inputPort_2_Daemon_start_req : std_logic;
  signal inputPort_2_Daemon_start_ack : std_logic;
  signal inputPort_2_Daemon_fin_req   : std_logic;
  signal inputPort_2_Daemon_fin_ack : std_logic;
  -- declarations related to module outputPort_1_Daemon
  component outputPort_1_Daemon is -- 
    generic (tag_length : integer); 
    port ( -- 
      noblock_obuf_2_1_pipe_read_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_2_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_2_1_pipe_read_data : in   std_logic_vector(32 downto 0);
      noblock_obuf_1_1_pipe_read_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_1_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_1_1_pipe_read_data : in   std_logic_vector(32 downto 0);
      out_data_1_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_data_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_data_1_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) ;
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic-- 
    );
    -- 
  end component;
  -- argument signals for module outputPort_1_Daemon
  signal outputPort_1_Daemon_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal outputPort_1_Daemon_tag_out   : std_logic_vector(1 downto 0);
  signal outputPort_1_Daemon_start_req : std_logic;
  signal outputPort_1_Daemon_start_ack : std_logic;
  signal outputPort_1_Daemon_fin_req   : std_logic;
  signal outputPort_1_Daemon_fin_ack : std_logic;
  -- declarations related to module outputPort_2_Daemon
  component outputPort_2_Daemon is -- 
    generic (tag_length : integer); 
    port ( -- 
      noblock_obuf_2_2_pipe_read_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_2_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_2_2_pipe_read_data : in   std_logic_vector(32 downto 0);
      noblock_obuf_1_2_pipe_read_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_1_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_1_2_pipe_read_data : in   std_logic_vector(32 downto 0);
      out_data_2_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_data_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_data_2_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) ;
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic-- 
    );
    -- 
  end component;
  -- argument signals for module outputPort_2_Daemon
  signal outputPort_2_Daemon_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal outputPort_2_Daemon_tag_out   : std_logic_vector(1 downto 0);
  signal outputPort_2_Daemon_start_req : std_logic;
  signal outputPort_2_Daemon_start_ack : std_logic;
  signal outputPort_2_Daemon_fin_req   : std_logic;
  signal outputPort_2_Daemon_fin_ack : std_logic;
  -- declarations related to module prioritySelect
  -- aggregate signals for write to pipe in_data_1
  signal in_data_1_pipe_write_data: std_logic_vector(31 downto 0);
  signal in_data_1_pipe_write_req: std_logic_vector(0 downto 0);
  signal in_data_1_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe in_data_1
  signal in_data_1_pipe_read_data: std_logic_vector(31 downto 0);
  signal in_data_1_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_data_1_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe in_data_1_64
  signal in_data_1_64_pipe_read_data: std_logic_vector(63 downto 0);
  signal in_data_1_64_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_data_1_64_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe in_data_2
  signal in_data_2_pipe_write_data: std_logic_vector(31 downto 0);
  signal in_data_2_pipe_write_req: std_logic_vector(0 downto 0);
  signal in_data_2_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe in_data_2
  signal in_data_2_pipe_read_data: std_logic_vector(31 downto 0);
  signal in_data_2_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_data_2_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe in_data_2_64
  signal in_data_2_64_pipe_read_data: std_logic_vector(63 downto 0);
  signal in_data_2_64_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_data_2_64_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe noblock_obuf_1_1
  signal noblock_obuf_1_1_pipe_write_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_1_1_pipe_write_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_1_1_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe noblock_obuf_1_1
  signal noblock_obuf_1_1_pipe_read_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_1_1_pipe_read_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_1_1_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe noblock_obuf_1_2
  signal noblock_obuf_1_2_pipe_write_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_1_2_pipe_write_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_1_2_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe noblock_obuf_1_2
  signal noblock_obuf_1_2_pipe_read_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_1_2_pipe_read_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_1_2_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe noblock_obuf_2_1
  signal noblock_obuf_2_1_pipe_write_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_2_1_pipe_write_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_2_1_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe noblock_obuf_2_1
  signal noblock_obuf_2_1_pipe_read_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_2_1_pipe_read_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_2_1_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe noblock_obuf_2_2
  signal noblock_obuf_2_2_pipe_write_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_2_2_pipe_write_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_2_2_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe noblock_obuf_2_2
  signal noblock_obuf_2_2_pipe_read_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_2_2_pipe_read_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_2_2_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe out_data_1
  signal out_data_1_pipe_write_data: std_logic_vector(31 downto 0);
  signal out_data_1_pipe_write_req: std_logic_vector(0 downto 0);
  signal out_data_1_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe out_data_2
  signal out_data_2_pipe_write_data: std_logic_vector(31 downto 0);
  signal out_data_2_pipe_write_req: std_logic_vector(0 downto 0);
  signal out_data_2_pipe_write_ack: std_logic_vector(0 downto 0);
  -- gated clock signal declarations.
  -- 
begin -- 
  -- module converter_1_Daemon
  converter_1_Daemon_instance:converter_1_Daemon-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => converter_1_Daemon_start_req,
      start_ack => converter_1_Daemon_start_ack,
      fin_req => converter_1_Daemon_fin_req,
      fin_ack => converter_1_Daemon_fin_ack,
      clk => clk,
      reset => reset,
      in_data_1_64_pipe_read_req => in_data_1_64_pipe_read_req(0 downto 0),
      in_data_1_64_pipe_read_ack => in_data_1_64_pipe_read_ack(0 downto 0),
      in_data_1_64_pipe_read_data => in_data_1_64_pipe_read_data(63 downto 0),
      in_data_1_pipe_write_req => in_data_1_pipe_write_req(0 downto 0),
      in_data_1_pipe_write_ack => in_data_1_pipe_write_ack(0 downto 0),
      in_data_1_pipe_write_data => in_data_1_pipe_write_data(31 downto 0),
      tag_in => converter_1_Daemon_tag_in,
      tag_out => converter_1_Daemon_tag_out-- 
    ); -- 
  -- module will be run forever 
  converter_1_Daemon_tag_in <= (others => '0');
  converter_1_Daemon_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => converter_1_Daemon_start_req, start_ack => converter_1_Daemon_start_ack,  fin_req => converter_1_Daemon_fin_req,  fin_ack => converter_1_Daemon_fin_ack);
  -- module converter_2_Daemon
  converter_2_Daemon_instance:converter_2_Daemon-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => converter_2_Daemon_start_req,
      start_ack => converter_2_Daemon_start_ack,
      fin_req => converter_2_Daemon_fin_req,
      fin_ack => converter_2_Daemon_fin_ack,
      clk => clk,
      reset => reset,
      in_data_2_64_pipe_read_req => in_data_2_64_pipe_read_req(0 downto 0),
      in_data_2_64_pipe_read_ack => in_data_2_64_pipe_read_ack(0 downto 0),
      in_data_2_64_pipe_read_data => in_data_2_64_pipe_read_data(63 downto 0),
      in_data_2_pipe_write_req => in_data_2_pipe_write_req(0 downto 0),
      in_data_2_pipe_write_ack => in_data_2_pipe_write_ack(0 downto 0),
      in_data_2_pipe_write_data => in_data_2_pipe_write_data(31 downto 0),
      tag_in => converter_2_Daemon_tag_in,
      tag_out => converter_2_Daemon_tag_out-- 
    ); -- 
  -- module will be run forever 
  converter_2_Daemon_tag_in <= (others => '0');
  converter_2_Daemon_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => converter_2_Daemon_start_req, start_ack => converter_2_Daemon_start_ack,  fin_req => converter_2_Daemon_fin_req,  fin_ack => converter_2_Daemon_fin_ack);
  -- module inputPort_1_Daemon
  inputPort_1_Daemon_instance:inputPort_1_Daemon-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => inputPort_1_Daemon_start_req,
      start_ack => inputPort_1_Daemon_start_ack,
      fin_req => inputPort_1_Daemon_fin_req,
      fin_ack => inputPort_1_Daemon_fin_ack,
      clk => clk,
      reset => reset,
      in_data_1_pipe_read_req => in_data_1_pipe_read_req(0 downto 0),
      in_data_1_pipe_read_ack => in_data_1_pipe_read_ack(0 downto 0),
      in_data_1_pipe_read_data => in_data_1_pipe_read_data(31 downto 0),
      noblock_obuf_1_1_pipe_write_req => noblock_obuf_1_1_pipe_write_req(0 downto 0),
      noblock_obuf_1_1_pipe_write_ack => noblock_obuf_1_1_pipe_write_ack(0 downto 0),
      noblock_obuf_1_1_pipe_write_data => noblock_obuf_1_1_pipe_write_data(32 downto 0),
      noblock_obuf_1_2_pipe_write_req => noblock_obuf_1_2_pipe_write_req(0 downto 0),
      noblock_obuf_1_2_pipe_write_ack => noblock_obuf_1_2_pipe_write_ack(0 downto 0),
      noblock_obuf_1_2_pipe_write_data => noblock_obuf_1_2_pipe_write_data(32 downto 0),
      tag_in => inputPort_1_Daemon_tag_in,
      tag_out => inputPort_1_Daemon_tag_out-- 
    ); -- 
  -- module will be run forever 
  inputPort_1_Daemon_tag_in <= (others => '0');
  inputPort_1_Daemon_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => inputPort_1_Daemon_start_req, start_ack => inputPort_1_Daemon_start_ack,  fin_req => inputPort_1_Daemon_fin_req,  fin_ack => inputPort_1_Daemon_fin_ack);
  -- module inputPort_2_Daemon
  inputPort_2_Daemon_instance:inputPort_2_Daemon-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => inputPort_2_Daemon_start_req,
      start_ack => inputPort_2_Daemon_start_ack,
      fin_req => inputPort_2_Daemon_fin_req,
      fin_ack => inputPort_2_Daemon_fin_ack,
      clk => clk,
      reset => reset,
      in_data_2_pipe_read_req => in_data_2_pipe_read_req(0 downto 0),
      in_data_2_pipe_read_ack => in_data_2_pipe_read_ack(0 downto 0),
      in_data_2_pipe_read_data => in_data_2_pipe_read_data(31 downto 0),
      noblock_obuf_2_1_pipe_write_req => noblock_obuf_2_1_pipe_write_req(0 downto 0),
      noblock_obuf_2_1_pipe_write_ack => noblock_obuf_2_1_pipe_write_ack(0 downto 0),
      noblock_obuf_2_1_pipe_write_data => noblock_obuf_2_1_pipe_write_data(32 downto 0),
      noblock_obuf_2_2_pipe_write_req => noblock_obuf_2_2_pipe_write_req(0 downto 0),
      noblock_obuf_2_2_pipe_write_ack => noblock_obuf_2_2_pipe_write_ack(0 downto 0),
      noblock_obuf_2_2_pipe_write_data => noblock_obuf_2_2_pipe_write_data(32 downto 0),
      tag_in => inputPort_2_Daemon_tag_in,
      tag_out => inputPort_2_Daemon_tag_out-- 
    ); -- 
  -- module will be run forever 
  inputPort_2_Daemon_tag_in <= (others => '0');
  inputPort_2_Daemon_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => inputPort_2_Daemon_start_req, start_ack => inputPort_2_Daemon_start_ack,  fin_req => inputPort_2_Daemon_fin_req,  fin_ack => inputPort_2_Daemon_fin_ack);
  -- module outputPort_1_Daemon
  outputPort_1_Daemon_instance:outputPort_1_Daemon-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => outputPort_1_Daemon_start_req,
      start_ack => outputPort_1_Daemon_start_ack,
      fin_req => outputPort_1_Daemon_fin_req,
      fin_ack => outputPort_1_Daemon_fin_ack,
      clk => clk,
      reset => reset,
      noblock_obuf_2_1_pipe_read_req => noblock_obuf_2_1_pipe_read_req(0 downto 0),
      noblock_obuf_2_1_pipe_read_ack => noblock_obuf_2_1_pipe_read_ack(0 downto 0),
      noblock_obuf_2_1_pipe_read_data => noblock_obuf_2_1_pipe_read_data(32 downto 0),
      noblock_obuf_1_1_pipe_read_req => noblock_obuf_1_1_pipe_read_req(0 downto 0),
      noblock_obuf_1_1_pipe_read_ack => noblock_obuf_1_1_pipe_read_ack(0 downto 0),
      noblock_obuf_1_1_pipe_read_data => noblock_obuf_1_1_pipe_read_data(32 downto 0),
      out_data_1_pipe_write_req => out_data_1_pipe_write_req(0 downto 0),
      out_data_1_pipe_write_ack => out_data_1_pipe_write_ack(0 downto 0),
      out_data_1_pipe_write_data => out_data_1_pipe_write_data(31 downto 0),
      tag_in => outputPort_1_Daemon_tag_in,
      tag_out => outputPort_1_Daemon_tag_out-- 
    ); -- 
  -- module will be run forever 
  outputPort_1_Daemon_tag_in <= (others => '0');
  outputPort_1_Daemon_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => outputPort_1_Daemon_start_req, start_ack => outputPort_1_Daemon_start_ack,  fin_req => outputPort_1_Daemon_fin_req,  fin_ack => outputPort_1_Daemon_fin_ack);
  -- module outputPort_2_Daemon
  outputPort_2_Daemon_instance:outputPort_2_Daemon-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => outputPort_2_Daemon_start_req,
      start_ack => outputPort_2_Daemon_start_ack,
      fin_req => outputPort_2_Daemon_fin_req,
      fin_ack => outputPort_2_Daemon_fin_ack,
      clk => clk,
      reset => reset,
      noblock_obuf_2_2_pipe_read_req => noblock_obuf_2_2_pipe_read_req(0 downto 0),
      noblock_obuf_2_2_pipe_read_ack => noblock_obuf_2_2_pipe_read_ack(0 downto 0),
      noblock_obuf_2_2_pipe_read_data => noblock_obuf_2_2_pipe_read_data(32 downto 0),
      noblock_obuf_1_2_pipe_read_req => noblock_obuf_1_2_pipe_read_req(0 downto 0),
      noblock_obuf_1_2_pipe_read_ack => noblock_obuf_1_2_pipe_read_ack(0 downto 0),
      noblock_obuf_1_2_pipe_read_data => noblock_obuf_1_2_pipe_read_data(32 downto 0),
      out_data_2_pipe_write_req => out_data_2_pipe_write_req(0 downto 0),
      out_data_2_pipe_write_ack => out_data_2_pipe_write_ack(0 downto 0),
      out_data_2_pipe_write_data => out_data_2_pipe_write_data(31 downto 0),
      tag_in => outputPort_2_Daemon_tag_in,
      tag_out => outputPort_2_Daemon_tag_out-- 
    ); -- 
  -- module will be run forever 
  outputPort_2_Daemon_tag_in <= (others => '0');
  outputPort_2_Daemon_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => outputPort_2_Daemon_start_req, start_ack => outputPort_2_Daemon_start_ack,  fin_req => outputPort_2_Daemon_fin_req,  fin_ack => outputPort_2_Daemon_fin_ack);
  in_data_1_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe in_data_1",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 2 --
    )
    port map( -- 
      read_req => in_data_1_pipe_read_req,
      read_ack => in_data_1_pipe_read_ack,
      read_data => in_data_1_pipe_read_data,
      write_req => in_data_1_pipe_write_req,
      write_ack => in_data_1_pipe_write_ack,
      write_data => in_data_1_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  in_data_1_64_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe in_data_1_64",
      num_reads => 1,
      num_writes => 1,
      data_width => 64,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 0 --
    )
    port map( -- 
      read_req => in_data_1_64_pipe_read_req,
      read_ack => in_data_1_64_pipe_read_ack,
      read_data => in_data_1_64_pipe_read_data,
      write_req => in_data_1_64_pipe_write_req,
      write_ack => in_data_1_64_pipe_write_ack,
      write_data => in_data_1_64_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  in_data_2_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe in_data_2",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 2 --
    )
    port map( -- 
      read_req => in_data_2_pipe_read_req,
      read_ack => in_data_2_pipe_read_ack,
      read_data => in_data_2_pipe_read_data,
      write_req => in_data_2_pipe_write_req,
      write_ack => in_data_2_pipe_write_ack,
      write_data => in_data_2_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  in_data_2_64_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe in_data_2_64",
      num_reads => 1,
      num_writes => 1,
      data_width => 64,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 0 --
    )
    port map( -- 
      read_req => in_data_2_64_pipe_read_req,
      read_ack => in_data_2_64_pipe_read_ack,
      read_data => in_data_2_64_pipe_read_data,
      write_req => in_data_2_64_pipe_write_req,
      write_ack => in_data_2_64_pipe_write_ack,
      write_data => in_data_2_64_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- non-blocking pipe... Input-ports must have non-blocking-flag => true
  noblock_obuf_1_1_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe noblock_obuf_1_1",
      num_reads => 1,
      num_writes => 1,
      data_width => 33,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 128 --
    )
    port map( -- 
      read_req => noblock_obuf_1_1_pipe_read_req,
      read_ack => noblock_obuf_1_1_pipe_read_ack,
      read_data => noblock_obuf_1_1_pipe_read_data,
      write_req => noblock_obuf_1_1_pipe_write_req,
      write_ack => noblock_obuf_1_1_pipe_write_ack,
      write_data => noblock_obuf_1_1_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- non-blocking pipe... Input-ports must have non-blocking-flag => true
  noblock_obuf_1_2_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe noblock_obuf_1_2",
      num_reads => 1,
      num_writes => 1,
      data_width => 33,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 128 --
    )
    port map( -- 
      read_req => noblock_obuf_1_2_pipe_read_req,
      read_ack => noblock_obuf_1_2_pipe_read_ack,
      read_data => noblock_obuf_1_2_pipe_read_data,
      write_req => noblock_obuf_1_2_pipe_write_req,
      write_ack => noblock_obuf_1_2_pipe_write_ack,
      write_data => noblock_obuf_1_2_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- non-blocking pipe... Input-ports must have non-blocking-flag => true
  noblock_obuf_2_1_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe noblock_obuf_2_1",
      num_reads => 1,
      num_writes => 1,
      data_width => 33,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 128 --
    )
    port map( -- 
      read_req => noblock_obuf_2_1_pipe_read_req,
      read_ack => noblock_obuf_2_1_pipe_read_ack,
      read_data => noblock_obuf_2_1_pipe_read_data,
      write_req => noblock_obuf_2_1_pipe_write_req,
      write_ack => noblock_obuf_2_1_pipe_write_ack,
      write_data => noblock_obuf_2_1_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- non-blocking pipe... Input-ports must have non-blocking-flag => true
  noblock_obuf_2_2_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe noblock_obuf_2_2",
      num_reads => 1,
      num_writes => 1,
      data_width => 33,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 128 --
    )
    port map( -- 
      read_req => noblock_obuf_2_2_pipe_read_req,
      read_ack => noblock_obuf_2_2_pipe_read_ack,
      read_data => noblock_obuf_2_2_pipe_read_data,
      write_req => noblock_obuf_2_2_pipe_write_req,
      write_ack => noblock_obuf_2_2_pipe_write_ack,
      write_data => noblock_obuf_2_2_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  out_data_1_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe out_data_1",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 0 --
    )
    port map( -- 
      read_req => out_data_1_pipe_read_req,
      read_ack => out_data_1_pipe_read_ack,
      read_data => out_data_1_pipe_read_data,
      write_req => out_data_1_pipe_write_req,
      write_ack => out_data_1_pipe_write_ack,
      write_data => out_data_1_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  out_data_2_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe out_data_2",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 0 --
    )
    port map( -- 
      read_req => out_data_2_pipe_read_req,
      read_ack => out_data_2_pipe_read_ack,
      read_data => out_data_2_pipe_read_data,
      write_req => out_data_2_pipe_write_req,
      write_ack => out_data_2_pipe_write_ack,
      write_data => out_data_2_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- gated clock generators 
  -- 
end ahir_system_arch;
