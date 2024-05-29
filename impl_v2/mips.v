`include "datapath/gpr.v"
`include "datapath/alu.v"
`include "datapath/ext.v"
`include "datapath/mux32.v"
`include "datapath/mux5.v"
`include "datapath/dm.v"
`include "datapath/ifu.v"
`include "datapath/divider.v"
`include "control/ctrl.v"
`timescale 1ns / 1ps

module mips();

reg clk;

initial begin
    clk = 0;
    forever #5 clk = ~clk; // 时钟周期为10ns
end



// 内部连接信号声明
wire [31:0] instr;
wire [31:0] imm32;
wire [5:0] opcode, funct;
wire [4:0] rs, rt, rd, shamt, rw;
wire [15:0] imm16;
wire [2:0] aluCtr;
wire [1:0] nPC_sel, ext_op;
wire mem2Reg, memWrite, aluSrc, regDst, regWrite, zero, pcReset;
wire [31:0] pc, dmData, BusA, BusB, BusW, BusW2, BusB2;
wire [25:0] imm26;

//实例化全部模块
ctrl CTRL (
    .op(opcode),
    .funct(funct),
    .mem2Reg(mem2Reg),
    .memWrite(memWrite),
    .aluSrc(aluSrc),
    .regDst(regDst),
    .regWrite(regWrite),
    .aluCtr(aluCtr),
    .nPC_sel(nPC_sel),
    .pcReset(pcReset),
    .ext_op(ext_op)

);
divider DIV (
    .instr(instr),
    .opcode(opcode),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .shamt(shamt),
    .funct(funct),
    .imm16(imm16),
    .imm26(imm26)
);
ifu IFU(
    .imm32(imm32),
    .clk(clk),
    .reset(pcReset),
    .zero(zero),
    .nPC_sel(nPC_sel),
    .pc(pc), //输出PC连接Pc显示
    .instr(instr),
    .imm26(imm26)
);
dm DM (
    .addr(BusW),
    .wrEn(memWrite),
    .clk(clk),
    .wd(BusB),
    .rd(dmData) //连接Mem2RegMux选择读取Data字
);
mux32 Mem2RegMux (
    .sel(mem2Reg),
    .a(BusW),
    .b(dmData),
    .c(BusW2) //连接到GPR的rw
);
mux5 RegMux (
    .sel(regDst),
    .a(rt),
    .b(rd),
    .c(rw) //连接到GPR的rw
);
mux32 ALUSrcMux (
    .sel(aluSrc),
    .a(BusB),
    .b(imm32),
    .c(BusB2) //连接ALU的BusB输入
);
ext EXT (
    .data16(imm16),
    .ext_op(ext_op),
    .data32(imm32)
);
alu ALU (
    .srcA(BusA),
    .srcB(BusB2),
    .ctrl(aluCtr),
    .zero(zero),
    .aluResu(BusW)
);
gpr GPR (
    .ra(rs),
    .rb(rt),
    .rw(rw),
    .wd3(BusW2),
    .clk(clk),
    .we3(regWrite),
    .rd1(BusA),
    .rd2(BusB)
);
initial begin
    $dumpfile("mips_tb.vcd");
    $dumpvars(0, mips);
    #200;
    $finish;
end

endmodule