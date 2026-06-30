module a_register(
    input        clk,
    input        reset,
    input        load_a,      // AI
    input        a_out_en,    // AO
    input  [7:0] w_bus,
    output [7:0] a_reg_data,
    output [7:0] a_reg_out
);
reg [7:0] a_reg;
always @(posedge clk or posedge reset)
begin
    if(reset)
        a_reg <= 8'b00000000;

    else if(load_a)
        a_reg <= w_bus;
end
assign a_reg_data = a_reg;

assign a_reg_out =
       (a_out_en) ? a_reg : 8'bzzzzzzzz;
endmodule