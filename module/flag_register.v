module flag_register(
    input  clk,
    input  reset,

    input  load_flags,

    input  zero_flag,
    input  carry_flag,

    output reg zero_flag_out,
    output reg carry_flag_out
);

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        zero_flag_out  <= 1'b0;
        carry_flag_out <= 1'b0;
    end

    else if(load_flags)
    begin
        zero_flag_out  <= zero_flag;
        carry_flag_out <= carry_flag;
    end

end

endmodule