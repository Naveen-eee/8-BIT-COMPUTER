module out_register(
    input        clk,
    input        reset,
    input        load_out,

    input  [7:0] w_bus,

    output reg [7:0] out_reg_out
);

always @(posedge clk or posedge reset)
begin

    if(reset)
        out_reg_out <= 8'b00000000;

    else if(load_out)
        out_reg_out <= w_bus;

end

endmodule