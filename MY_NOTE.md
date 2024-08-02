
1st Terminal
```sh
export RISCV=$HOME/Persimmons/tool/riscv-32
cd tb
bender update
make vcs-run VCS_FLAGS="-debug_all"
```

Install openocd for the first run
```sh
export RISCV=$HOME/Persimmons/tool/riscv-32
source get-openocd.sh
```

2nd Terminal
```sh
export JTAG_VPI_PORT=9999
openocd -f dm_compliance_test.cfg
```









make vcs-run
```sh
## Clone dependency repo
git clone https://github.com/pulp-platform/fpnew.git --recurse -b v0.6.1
git clone https://github.com/openhwgroup/cv32e40p.git riscv
cd riscv/ && git checkout f9d63290eea738cb0a6fbf1e77bbd18555015a03
git clone https://github.com/pulp-platform/tech_cells_generic.git
cd tech_cells_generic/ && git checkout v0.2.3

## Compile remote bitbang driver for simulation
# "librbs_vcs.so" is the output from this process
make -C remote_bitbang all INCLUDE_DIRS="./ "
make[1]: Entering directory '/home/attapon/Persimmons/riscv-dbg/tb/remote_bitbang'
cc -MT remote_bitbang.o -MMD -MP -MF ./.d/remote_bitbang.Td -std=gnu11 -fno-strict-aliasing -Wall -Wextra -Wno-missing-field-initializers -Wno-unused-function -Wno-missing-braces -O2 -g -march=native -DENABLE_LOGGING -DNDEBUG -fPIC -I./  \
        -c  remote_bitbang.c -o remote_bitbang.o 
mv -f ./.d/remote_bitbang.Td ./.d/remote_bitbang.d && touch remote_bitbang.o
cc -MT sim_jtag.o -MMD -MP -MF ./.d/sim_jtag.Td -std=gnu11 -fno-strict-aliasing -Wall -Wextra -Wno-missing-field-initializers -Wno-unused-function -Wno-missing-braces -O2 -g -march=native -DENABLE_LOGGING -DNDEBUG -fPIC -I./  \
        -c  sim_jtag.c -o sim_jtag.o 
mv -f ./.d/sim_jtag.Td ./.d/sim_jtag.d && touch sim_jtag.o
ld -shared -E --exclude-libs ALL -o librbs.so  \
        remote_bitbang.o sim_jtag.o 
make[1]: Leaving directory '/home/attapon/Persimmons/riscv-dbg/tb/remote_bitbang'
mv remote_bitbang/librbs.so remote_bitbang/librbs_vcs.so

## 
vcs +vc -sverilog -race=all -ignore unique_checks -full64 \
        -timescale=1ns/1ps -assert svaext \
        -CC " -O3 -march=native"  \
        fpnew/src/fpnew_pkg.sv dm_tb_pkg.sv riscv/rtl/include/cv32e40p_apu_core_pkg.sv riscv/rtl/include/cv32e40p_pkg.sv riscv/rtl/include/../../bhv/include/cv32e40p_tracer_pkg.sv ../src/dm_pkg.sv common_cells/src/cdc_reset_ctrlr_pkg.sv riscv/rtl/../bhv/cv32e40p_sim_clock_gate.sv riscv/rtl/../bhv/cv32e40p_tracer.sv riscv/rtl/cv32e40p_if_stage.sv riscv/rtl/cv32e40p_cs_registers.sv riscv/rtl/cv32e40p_register_file_ff.sv riscv/rtl/cv32e40p_load_store_unit.sv riscv/rtl/cv32e40p_id_stage.sv riscv/rtl/cv32e40p_aligner.sv riscv/rtl/cv32e40p_decoder.sv riscv/rtl/cv32e40p_compressed_decoder.sv riscv/rtl/cv32e40p_fifo.sv riscv/rtl/cv32e40p_prefetch_buffer.sv riscv/rtl/cv32e40p_hwloop_regs.sv riscv/rtl/cv32e40p_mult.sv riscv/rtl/cv32e40p_int_controller.sv riscv/rtl/cv32e40p_ex_stage.sv riscv/rtl/cv32e40p_alu_div.sv riscv/rtl/cv32e40p_alu.sv riscv/rtl/cv32e40p_ff_one.sv riscv/rtl/cv32e40p_popcnt.sv riscv/rtl/cv32e40p_apu_disp.sv riscv/rtl/cv32e40p_controller.sv riscv/rtl/cv32e40p_obi_interface.sv riscv/rtl/cv32e40p_prefetch_controller.sv riscv/rtl/cv32e40p_sleep_unit.sv riscv/rtl/cv32e40p_core.sv common_cells/src/spill_register_flushable.sv common_cells/src/spill_register.sv common_cells/src/cdc_2phase.sv common_cells/src/cdc_2phase_clearable.sv common_cells/src/cdc_reset_ctrlr.sv common_cells/src/cdc_4phase.sv common_cells/src/deprecated/fifo_v2.sv common_cells/src/fifo_v3.sv common_cells/src/rstgen.sv common_cells/src/rstgen_bypass.sv common_cells/src/sync.sv tech_cells_generic/src/rtl/tc_clk.sv ../debug_rom/debug_rom.sv ../src/dm_csrs.sv ../src/dmi_cdc.sv ../src/dmi_jtag.sv ../src/dmi_jtag_tap.sv ../src/dm_mem.sv ../src/dm_sba.sv ../src/dm_top.sv ../src/dm_obi_top.sv  boot_rom.sv dp_ram.sv mm_ram.sv SimJTAG.sv ../sva/dm_top_sva.sv ../sva/dm_csrs_sva.sv ../sva/dm_sba_sva.sv tb_test_env.sv tb_top.sv \
        +incdir+riscv/rtl/include +incdir+common_cells/include
/home/attapon/.riscv/bin/riscv32-unknown-elf-gcc -march=rv32imc -Os -g  -nostdlib -static -T prog/link.ld prog/test.c prog/crt0.S prog/syscalls.c prog/vectors.S -lc -lm -lgcc -o prog/test.elf
/home/attapon/.riscv/bin/riscv32-unknown-elf-objcopy -O verilog --change-addresses -0x1c000000 prog/test.elf prog/test.hex
./simv -sv_lib remote_bitbang/librbs_vcs  "+firmware=prog/test.hex"
```




