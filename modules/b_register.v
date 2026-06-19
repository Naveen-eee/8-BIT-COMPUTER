module b_register(
    input        clk,
    input        reset,
    input        load_b,
    input  [7:0] w_bus,
    output [7:0] b_reg_out
);
reg [7:0] b_reg;
always @(posedge clk or posedge reset)
begin
    if(reset)
        b_reg <= 8'b00000000;
    else if(load_b)
        b_reg <= w_bus;
end
assign b_reg_out = b_reg;
endmodule