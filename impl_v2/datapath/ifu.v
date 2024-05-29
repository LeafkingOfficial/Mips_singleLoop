`include "datapath/im.v"

module ifu(
    input [31:0] imm32, // 输入的跳转立即数，需要经过ext32
    input clk,
    input reset,
    input zero,
    input [1:0] nPC_sel,
    input [25:0] imm26,
    output reg [31:0] pc,
    output wire [31:0] instr // 将instr声明为wire类型
);
    initial begin
        pc <= 32'b0; // default pc as start
    end
    
    // 实例化指令存储器模块
    im IM(
        .addr(pc),
        .instr(instr)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 32'b0; // 复位时将PC置为0
        end else begin
            case (nPC_sel)
                2'b01: begin
                    if (zero) begin
                        pc <= pc + 4 + (imm32 << 2); // 条件满足时PC加立即数
                    end else begin
                        pc <= pc + 4; // 否则PC加4
                    end
                end
                2'b10: begin
                    pc <= {pc[31:28], imm26, 2'b00}; // 跳转地址
                end
                default: begin
                    pc <= pc + 4; // 否则PC加4
                end
            endcase
        end
    end
endmodule
