//===- IntrinsicsRISCV_MHalk.td - Defines RISCV intrinsics -*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines all of the RISCV MHalk-extension-specific intrinsics.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//

let TargetPrefix = "riscv" in {
  // MHalk specific intrinsics
  multiclass MHalkIntrinsic<list<LLVMType> ret_types,
                            list<LLVMType> param_types,
                            list<IntrinsicProperty> intr_properties> {

    def int_riscv_mhalk_ # NAME
        : GCCBuiltin<"__builtin_mhalk_" # NAME>,
          Intrinsic<ret_types, param_types, intr_properties>;
  }

  multiclass MHalkUnary32 : MHalkIntrinsic<[llvm_i32_ty], [llvm_i32_ty], [IntrNoMem]>;
  multiclass MHalkBinary32 : MHalkIntrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;
  multiclass MHalkTernary32 : MHalkIntrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;

  defm mac : MHalkTernary32;

  defm macs : MHalkIntrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;
  defm macu : MHalkIntrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;
}
