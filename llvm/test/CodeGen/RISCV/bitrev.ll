; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I

declare i32 @llvm.bitreverse.i32(i32)

	define i32 @bitrev(i32 %a) {
		%1 = call i32 @llvm.bitreverse.i32(i32 %a)
		ret i32 %1
}
