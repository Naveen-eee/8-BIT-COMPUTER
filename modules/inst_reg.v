module ir(
    input clk,
    input load_ir,

    input [7:0] instruction,

    output reg [7:0] ir_out,

    output [3:0] opcode,
    output [3:0] operand
);

always @(posedge clk)
begin
    if(load_ir)
        ir_out <= instruction;
end

assign opcode  = ir_out[7:4];
assign operand = ir_out[3:0];

endmodule
