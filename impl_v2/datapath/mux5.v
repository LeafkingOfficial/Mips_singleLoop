module mux5(
    input sel,
    input [4:0] a,
    input [4:0] b,
    output reg [4:0] c
);

always @(*) begin
    if (sel == 0) begin
        c <= a;
    end else begin
        c <= b;
    end
end

endmodule
