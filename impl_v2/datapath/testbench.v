`include "ifu.v"
module top;
    reg [31:0] imm32;
    reg clk;
    reg reset;
    reg zero;
    reg nPC_sel;
    wire [31:0] pc;
    wire [31:0] instr;

    // 实例化IFU模块
    IFU ifu_instance (
        .imm32(imm32),
        .clk(clk),
        .reset(reset),
        .zero(zero),
        .nPC_sel(nPC_sel),
        .pc(pc),
        .instr(instr)
    );

    initial begin
        // 初始化信号
        clk = 0;
        reset = 1;
        zero = 0;
        nPC_sel = 0;
        imm32 = 32'h4;

        // 复位信号处理
        #10 reset = 0;

        // 测试信号
        #10 nPC_sel = 1; zero = 1; imm32 = 32'h10;
        #10 nPC_sel = 0; zero = 0;
        #10 nPC_sel = 1; zero = 0;

        // 打印结果
        $monitor("At time %t, pc = %h, instr = %h", $time, pc, instr);
        #50 $finish; // 结束仿真
    end

    // 生成时钟信号
    always #5 clk = ~clk;
endmodule
