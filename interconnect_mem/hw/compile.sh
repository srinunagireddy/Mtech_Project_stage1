#!/bin/bash
rm -rf .Aa aa2c .vC vhdl src/*.incl.aa
mkdir -p .Aa aa2c .vC vhdl

AaPreprocess -I src/ src/mem_interconnect.aa -o src/mem_interconnect.incl.aa
AaLinkExtMem src/decls.aa src/mem_interconnect.incl.aa | vcFormat > .Aa/linked.aa

# TOPMODULES now lists 5 concurrent processes
TOPMODULES="-T converter_0_Daemon -T converter_1_Daemon -T converter_2_Daemon -T converter_3_Daemon -T mem_daemon"

Aa2VC -C .Aa/linked.aa | vcFormat > .vC/final.vc
vc2vhdl -U -a -C -e ahir_system -w -s ghdl $TOPMODULES -f .vC/final.vc

vhdlFormat < ahir_system_global_package.unformatted_vhdl > vhdl/ahir_system_global_package.vhdl
vhdlFormat < ahir_system.unformatted_vhdl > vhdl/ahir_system.vhdl
vhdlFormat < ahir_system_test_bench.unformatted_vhdl > vhdl/ahir_system_test_bench.vhdl
rm -f *.unformatted_vhdl
