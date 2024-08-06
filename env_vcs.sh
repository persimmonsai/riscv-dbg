

# Create virtual env
# $ virtualenv --python python3.10 venv
# Activate virtual env (floogen environment is okay in virtual env)
source $HOME/Persimmons/venv/bin/activate
# Deactivate virtual env
# $ deactivate

# VCS
export VCS_HOME=/opt/tools/synopsys/vcs/V-2023.12/
export PATH=$PATH:$VCS_HOME/bin
export VERDI_HOME=/opt/tools/synopsys/verdi/V-2023.12
export PATH=$PATH:$VERDI_HOME/bin

export VCS_ARCH_OVERRIDE="linux"

#/opt/tools/synopsys/scl/2023.09/linux64/bin/lmstat -c 27020@azure-license-server -a
export LM_LICENSE_FILE=27020@azure-license-server

# Synopsis LC
module use /opt/tools/modules
module load synopsys/lc

# Bender
export PATH=$HOME/Persimmons/tool:$PATH
#module load pulp/bender

# Official llvm compiler
export PATH=$HOME/Persimmons/tool/riscv-llvm/bin/:$PATH

# Official CAV6 compiler
export PATH=$HOME/Persimmons/tool/riscv/bin:$PATH

# Official riscv-32 compiler
#export PATH=$HOME/Persimmons/tool/riscv-32/bin:$PATH

# spike-dasm
export PATH=$HOME/Persimmons/tool/spike-dasm:$PATH

# Python package path
export PYTHONPATH=$PYTHONPATH:/home/attapon/Persimmons/FlooNoC/

# RISCV internal installation path with openocd
export RISCV=$HOME/Persimmons/riscv-dbg/ci/riscv
export PATH=$RISCV/bin:$PATH

# Check for existing vcs
which vcs
which verdi

# Check for existing bender
bender --version
which bender

# Check for existing llvm compiler
riscv32-unknown-elf-clang --version

# Check for CAV6 compiler
riscv64-unknown-elf-gcc --version

# Check for riscv-32 compiler
riscv32-unknown-elf-gcc --version


