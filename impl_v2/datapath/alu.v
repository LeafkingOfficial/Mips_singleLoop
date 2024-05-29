module alu(
    input [31:0] srcA,
    input [31:0] srcB,
    input [2:0] ctrl,
    output reg zero,
    output reg [31:0] aluResu
);

always @(*) begin
    case (ctrl)
        3'b000: aluResu = srcA + srcB; // ADD operation
        3'b001: aluResu = srcA - srcB; // SUB operation
        3'b010: aluResu = srcA & srcB; // AND operation
        3'b011: aluResu = srcA | srcB; // OR operation
        default: aluResu = 32'b0; // Default case
    endcase
    
    // Set zero flag
    if (aluResu == 32'b0)
        zero = 1;
    else
        zero = 0;
end

endmodule
