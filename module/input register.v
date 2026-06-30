module input_register(

    input clk,
    input load_input,

    input input_out_en,

    input [7:0] sensor_data,

    output [7:0] input_reg_out

);

reg [7:0] input_reg;

always @(posedge clk)
begin
    if(load_input)
        input_reg <= sensor_data;
end

assign input_reg_out =
       (input_out_en) ? input_reg : 8'bzzzzzzzz;

endmodule
