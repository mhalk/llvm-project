
class MHalk_ALU_rr_wb<bits<7> funct7, bits<3> funct3, RISCVOpcode opcode, string opcodestr,
                     RegisterClass ty1 = GPR, RegisterClass ty2 = ty1, RegisterClass resty = ty1>
    : RVInstR<funct7, funct3, opcode, (outs resty:$rd_wb), (ins resty:$rd, ty1:$rs1, ty2:$rs2),
              opcodestr, "$rd, $rs1, $rs2">,
      Sched<[WriteIALU, ReadIALU, ReadIALU]> {
  let Constraints = "$rd = $rd_wb";
}

// MAC Operations

def MH_MAC :      MHalk_ALU_rr_wb<0b0100001, 0b000, OPC_OP, "mh.mac">;

def MH_MACS :     MHalk_ALU_rr_wb<0b1000000, 0b001, RISCVOpcode<0b1011011>, "mh.macs">;
def MH_MACU :     MHalk_ALU_rr_wb<0b0000000, 0b001, RISCVOpcode<0b1011011>, "mh.macu">;
