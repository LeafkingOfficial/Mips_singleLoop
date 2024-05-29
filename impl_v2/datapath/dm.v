module dm(
    input [31:0] addr,
    input [31:0] wd,        //write address
    input wrEn,               //write enable
    input clk,              
    output reg [31:0] rd
);

    reg [31:0] dataMem [255:0]; // 定义256个32位的数据存储器
    initial begin
        //$readmemb("../data.txt", dataMem); // 从文件中读取数据初始值
        $readmemb("data.txt", dataMem,0,255); // 从文件中读取数据初始值
    end

    always @(*) begin
        rd <= dataMem[addr[31:2]]; // 读取操作
    end

    always @(posedge clk) begin
        if (wrEn == 1) begin
            dataMem[addr[31:2]] <= wd; // 使用 `addr` 作为地址，`wd` 作为数据
        end
        $writememb("data_after.txt", dataMem,0,255);
    end

endmodule
