module mux32(
    input sel,
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] c
);

always @(*) begin
    if (sel == 0) begin
        c <= a;
    end else begin
        c <= b;
    end
end

endmodule
