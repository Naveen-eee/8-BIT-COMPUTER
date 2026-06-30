module pc (
    input clk,
    input reset,
    input pc_inc,
    input pc_load,
    input [3:0] operand,
    output reg [3:0] pc_out
);

always @(posedge clk or posedge reset)
begin
    if(reset)
        pc_out <= 4'd0;

    else if(pc_load)
        pc_out <= operand;

    else if(pc_inc)
        pc_out <= pc_out + 1'b1;
end

endmodule
