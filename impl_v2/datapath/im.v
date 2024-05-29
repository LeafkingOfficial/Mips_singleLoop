module im(
    input [31:0] addr,
    output reg [31:0] instr
);
    reg [7:0] memory [0:1023]; // 1KB = 1024 bytes
    initial begin
        //$readmemb("../code.txt", memory);
        $readmemh("code.txt", memory, 0, 1023);
    end

    always @(*) begin
        // 拼接四个字节成一个32位指令
        instr <= {memory[addr], memory[addr + 1], memory[addr + 2], memory[addr+3]};
    end
    
endmodule