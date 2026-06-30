module alu(
    input  [7:0] a_reg_data,
    input  [7:0] b_reg_out,
    input  [2:0] alu_op,
    input        alu_out_en,

    output [7:0] alu_result,
    output       zero_flag,
    output       carry_flag
);
reg [8:0] temp;
always @(*) begin
    case (alu_op)
        3'b000 : temp = a_reg_data + b_reg_out;        // ADD
        3'b001 : temp = a_reg_data - b_reg_out;        // SUB
        3'b010 : temp = a_reg_data + 8'd1;            // INC
        3'b011 : temp = a_reg_data - 8'd1;            // DEC
        3'b100 : temp = {1'b0, (a_reg_data & b_reg_out)}; // AND
        3'b101 : temp = {1'b0, (a_reg_data | b_reg_out)}; // OR
        3'b110 : temp = {1'b0, (a_reg_data ^ b_reg_out)}; // XOR
        default: temp = 9'b000000000;
    endcase
end
assign alu_result = (alu_out_en) ? temp[7:0] : 8'bz ; 
assign carry_flag = temp[8];
assign zero_flag  = (temp[7:0] == 8'b00000000);

endmodule