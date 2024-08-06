
## Tool Installation
```sh
# Define installation path and creating installation directory
export RISCV=$HOME/Persimmons/riscv-dbg/ci/riscv
mkdir -p $RISCV
# Run installation script
cd ci
./download-pulp-gcc.sh
./get-openocd.sh
# Add simulation binary to path
export PATH=$RISCV/bin:$PATH
```

1st Terminal
```sh
cd tb
# bender update
make vcs-run VCS_FLAGS="-debug_access+all"
# make vcs-run VCS_FLAGS="-debug_access+all" SIMV_FLAGS="+verbose"
```

2nd Terminal
```sh
cd tb
export JTAG_VPI_PORT=9999
# To run test compliance (OK)
openocd -f dm_compliance_test.cfg |& tee "dm_compliance_test.log"
# To run debugging of test program (Can't connect openocd with gdb) 
openocd -f dm_debug.cfg |& tee "dm_debug.log"
```

3th Terminal
```sh
riscv32-unknown-elf-gdb prog/test.elf
# In GDB
target remote localhost:3333
monitor reset halt
load
continue
# Can't connect to target and download .elf program via gdb in the simulation
# riscv32-unknown-elf-gdb -ex "target extended-remote :3333"
# riscv32-unknown-elf-gdb -x elf_run.gdb $1 &
```

Tips : Use the below command to list of port that is using currently if port forwarding is not working.
```sh
lsof -i -P -n
```
