
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
make vcs-run VCS_FLAGS="-debug_all"
```

2nd Terminal
```sh
cd tb
export JTAG_VPI_PORT=9999
openocd -f dm_compliance_test.cfg
openocd -f dm_debug.cfg
```
