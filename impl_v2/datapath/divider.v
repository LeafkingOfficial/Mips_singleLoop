module divider(
    input [31:0] instr,
    output reg [5:0] opcode,
    output reg [4:0] rs,
    output reg [4:0] rt,
    output reg [4:0] rd,
    output reg [4:0] shamt,
    output reg [5:0] funct,
    output reg [15:0] imm16,
    output reg [25:0] imm26
);
    always @(*) begin
        opcode = instr[31:26]; // 操作码：位31到位26
        rs     = instr[25:21]; // 源寄存器：位25到位21
        rt     = instr[20:16]; // 目标寄存器：位20到位16
        rd     = instr[15:11]; // 目的寄存器：位15到位11
        shamt  = instr[10:6];  // 移位量：位10到位6
        funct  = instr[5:0];   // 功能码：位5到位0
        imm16  = instr[15:0];  // 立即数：位15到位0
        imm26  = instr[25:0];  //跳转数：位25到位0
    end
endmodule
