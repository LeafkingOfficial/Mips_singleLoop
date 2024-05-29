module ctrl(
    input [5:0] op,
    input [5:0] funct,
    output reg mem2Reg, 
    output reg memWrite, 
    output reg aluSrc, 
    output reg regDst, 
    output reg regWrite, 
    output reg [1:0] nPC_sel, 
    output reg pcReset,
    output reg [1:0] ext_op,
    output reg [2:0] aluCtr
);
    reg [12:0] tempcode;
    
    always @(*) begin
        // 默认值
        tempcode = 13'b0;

        // 根据 op 和 funct 设置 tempcode
        if (op == 6'b000000) begin // R 型指令
            case (funct)
                6'b100001: tempcode = 13'b0000000011000; // ADDU
                6'b100011: tempcode = 13'b0010000011000; // SUBU
                default: tempcode = 13'b0;
            endcase
        end else begin
            case (op)
                6'b001101: tempcode = 13'b0110000010100; // ORI
                6'b100011: tempcode = 13'b0000100010101; //LW
                6'b101011: tempcode = 13'b0000100001110; //SW
                6'b000100: tempcode = 13'b0010000100000; //BEQ
                6'b000010: tempcode = 13'b0000001000000; //j
                6'b001111: tempcode = 13'b0001000010100; //lui
                default: tempcode = 13'b0;
            endcase
        end
        {aluCtr, ext_op, pcReset, nPC_sel, regWrite, regDst, aluSrc, memWrite, mem2Reg} = tempcode;
    end

endmodule
