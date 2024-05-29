module ext(
    input [15:0] data16,
    input [1:0] ext_op,
    output reg [31:0] data32
);

always @(*) begin
    if (ext_op == 2'b00) begin
        data32 <= {16'b0, data16}; // 零扩展
    end else if(ext_op == 2'b01) begin
        data32 <= {{16{data16[15]}}, data16}; // 符号扩展
    end else begin
        data32 <= {data16,16'b0}; // lui扩展
    end
end

endmodule
