let hasSideEffects = 0, mayLoad = 0, mayStore = 0, Predicates = [HasNonStdExtMHalk] in {

  class MHalk_ALU_rr_wb<bits<7> funct7, bits<3> funct3, RISCVOpcode opcode, string opcodestr,
                       RegisterClass ty1 = GPR, RegisterClass ty2 = ty1, RegisterClass resty = ty1>
      : RVInstR<funct7, funct3, opcode, (outs resty:$rd_wb), (ins resty:$rd, ty1:$rs1, ty2:$rs2),
                opcodestr, "$rd, $rs1, $rs2">,
        Sched<[WriteIALU, ReadIALU, ReadIALU]> {
    let Constraints = "$rd = $rd_wb";
  }
}

// MAC Operations

def MH_MAC :      MHalk_ALU_rr_wb<0b0100001, 0b000, OPC_OP, "mh.mac">;
def MH_MACS :     MHalk_ALU_rr_wb<0b1000000, 0b001, RISCVOpcode<0b1011011>, "mh.macs">;
def MH_MACU :     MHalk_ALU_rr_wb<0b0000000, 0b001, RISCVOpcode<0b1011011>, "mh.macu">;

// Patterns for multiply operations

def muls : PatFrag<(ops node:$rs1, node:$rs2),
                   (mul (sext_inreg node:$rs1, i16),
                        (sext_inreg node:$rs2, i16))>;

def mulu : PatFrag<(ops node:$rs1, node:$rs2),
                   (mul (and node:$rs1, 65535),
                        (and node:$rs2, 65535))>;

def macs : PatFrag<(ops node:$rd, node:$rs1, node:$rs2),
                   (add node:$rd, (muls node:$rs1, node:$rs2))>;

def macu : PatFrag<(ops node:$rd, node:$rs1, node:$rs2),
                   (add node:$rd, (mulu node:$rs1, node:$rs2))>;

def : Pat<(add GPR:$rd, (mul GPR:$rs1, GPR:$rs2)),
          (MH_MAC GPR:$rd, GPR:$rs1, GPR:$rs2)>;
def : Pat<(macs GPR:$rd, GPR:$rs1, GPR:$rs2),
          (MH_MACS GPR:$rd, GPR:$rs1, GPR:$rs2)>;
def : Pat<(macu GPR:$rd, GPR:$rs1, GPR:$rs2),
          (MH_MACU GPR:$rd, GPR:$rs1, GPR:$rs2)>;


// Patterns for builtin functions
def : Pat<(int_riscv_mhalk_mac GPR:$rs1, GPR:$rs2, GPR:$rd), (MH_MAC GPR:$rd, GPR:$rs1, GPR:$rs2)>;
def : Pat<(int_riscv_mhalk_macs GPR:$rs1, GPR:$rs2, GPR:$rd), (MH_MACS GPR:$rd, GPR:$rs1, GPR:$rs2)>;
def : Pat<(int_riscv_mhalk_macu GPR:$rs1, GPR:$rs2, GPR:$rd), (MH_MACU GPR:$rd, GPR:$rs1, GPR:$rs2)>;

/*
multiclass MulMacBuiltin<string intrin, string instr> {

    def : Pat<(!cast<Intrinsic>("int_riscv_mhalk_mac" # intrin # "N")
                    GPR:$rs1, GPR:$rs2, GPR:$rd, uimm5:$shift),
              (!cast<RVInst>("MH_MAC" # instr # "N")
                    GPR:$rd, GPR:$rs1, GPR:$rs2, uimm5:$shift)>;

    def : Pat<(!cast<Intrinsic>("int_riscv_mhalk_mac" # intrin # "RN")
                    GPR:$rs1, GPR:$rs2, GPR:$rd, uimm5:$shift, imm),
              (!cast<RVInst>("MH_MAC" # instr # "RN")
                    GPR:$rd, GPR:$rs1, GPR:$rs2, uimm5:$shift)>;

}

defm : MulMacBuiltin<"s",   "S">;
defm : MulMacBuiltin<"u",   "U">;
*/
