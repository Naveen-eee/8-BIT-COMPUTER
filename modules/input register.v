module input_register(

    input clk,
    input load_input,

    input [7:0] sensor_data,

    output reg [7:0] input_reg_out

);

always @(posedge clk)
begin

    if(load_input)
    begin
        input_reg_out <= sensor_data;
    end

end

endmodule