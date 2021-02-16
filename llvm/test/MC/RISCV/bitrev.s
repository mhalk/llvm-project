# RUN: llvm-mc %s -triple=riscv32 -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -triple=riscv32 -riscv-no-aliases -filetype=obj < %s \
# RUN:     | llvm-objdump -d -r - \
# RUN:     | FileCheck -check-prefixes=CHECK-OBJ,CHECK-ASM-AND-OBJ %s

# CHECK-ASM-AND-OBJ: bitrev a0, a1
bitrev a0, a1
