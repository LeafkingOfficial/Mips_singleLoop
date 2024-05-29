module gpr(
    input [4:0] ra,
    input [4:0] rb,
    input [4:0] rw,
    input [31:0] wd3,
    input clk,
    input we3,
    output reg [31:0] rd1,
    output reg [31:0] rd2
);
    reg [31:0] reg32 [31:0]; // 定义32个32位寄存器
    reg [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12;

    initial begin
        $readmemb("register.txt", reg32,0,31); // 从文件中读取寄存器初始值
        //$readmemb("../register.txt", reg32); // 从文件中读取寄存器初始值
    end
    always @(*) begin
        rd1 <= reg32[ra]; // 读取操作1
        rd2 <= reg32[rb]; // 读取操作2
        reg32[0] <= 0;

        //输出显示
        R0 <= reg32[0];
        R1 <= reg32[1];
        R2 <= reg32[2];
        R3 <= reg32[3];
        R4 <= reg32[4];
        R5 <= reg32[5];
        R6 <= reg32[6];
        R7 <= reg32[7];
        R8 <= reg32[8];
        R9 <= reg32[9];
        R10 <= reg32[10];
        R11 <= reg32[11];
        R12 <= reg32[12];

    end
    always @(posedge clk) begin
        if (we3) begin
            reg32[rw] <= wd3; // 写入操作
        end
        $writememb("register_after.txt", reg32,0,31);
    end

endmodule
