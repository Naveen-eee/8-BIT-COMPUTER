module control_unit(

    input clk,
    input reset,

    input [3:0] opcode,

    input zero_flag_out,
    input carry_flag_out,

    output reg pc_inc,
    output reg pc_load,

    output reg load_ir,

    output reg load_mar,

    output reg load_a,
    output reg load_b,

    output reg a_out_en,

    output reg load_out,

    output reg load_input,
    output reg input_out_en,
    output reg ri,
    output reg ro,

    output reg alu_out_en,
    output reg load_flags,

    output reg [2:0] alu_op,

    output reg iro,

    output reg hlt

);

parameter T0 = 3'd0;
parameter T1 = 3'd1;
parameter T2 = 3'd2;
parameter T3 = 3'd3;
parameter T4 = 3'd4;
parameter T5 = 3'd5;

reg [2:0] state;
reg [2:0] next_state;

//
// State Register
//
always @(posedge clk or posedge reset)
begin
    if(reset)
        state <= T0;
    else
        state <= next_state;
end

//
// Next State Logic
//
always @(*)
begin
    case(state)

        T0 : next_state = T1;
        T1 : next_state = T2;
        T2 : next_state = T3;
        T3 : next_state = T4;
        T4 : next_state = T5;
        T5 : next_state = T0;

        default : next_state = T0;

    endcase
end

//
// Output Logic
//
always @(*)
begin

    // Default Values

    pc_inc      = 1'b0;
    pc_load     = 1'b0;

    load_ir     = 1'b0;

    load_mar    = 1'b0;

    load_a      = 1'b0;
    load_b      = 1'b0;

    a_out_en    = 1'b0;

    load_out    = 1'b0;

    load_input  = 1'b0;
    input_out_en = 1'b0;
    ri          = 1'b0;
    ro          = 1'b0;

    alu_out_en  = 1'b0;
    load_flags  = 1'b0;

    alu_op      = 3'b000;

    iro         = 1'b0;

    hlt         = 1'b0;

    case(state)

    //------------------------------------------------
    // T0 : Fetch Instruction
    //------------------------------------------------

    T0:
    begin
        iro = 1'b1;
    end

    //------------------------------------------------
    // T1 : Load IR
    //------------------------------------------------

    T1:
    begin
        load_ir = 1'b1;
    end

    //------------------------------------------------
    // T2 : Increment PC
    //------------------------------------------------

    T2:
    begin
        pc_inc = 1'b1;
    end

    //------------------------------------------------
    // T3
    //------------------------------------------------

    T3:
    begin

        case(opcode)

        4'b0001: load_mar = 1'b1;          // LDA

        4'b0010: load_mar = 1'b1;          // STA

        4'b0011: load_input = 1'b1;        // INP

        4'b0100:
        begin                             // OUT
            a_out_en = 1'b1;
            load_out = 1'b1;
        end

        4'b0101: load_mar = 1'b1;          // ADD

        4'b0110: load_mar = 1'b1;          // SUB

        4'b0111:
        begin                             // INC
            alu_op     = 3'b010;
            alu_out_en = 1'b1;
            load_a     = 1'b1;
            load_flags = 1'b1;
        end

        4'b1000:
        begin                             // DEC
            alu_op     = 3'b011;
            alu_out_en = 1'b1;
            load_a     = 1'b1;
            load_flags = 1'b1;
        end

        4'b1001: load_mar = 1'b1;          // AND

        4'b1010: load_mar = 1'b1;          // OR

        4'b1011: load_mar = 1'b1;          // XOR

        4'b1100: pc_load = 1'b1;           // JMP

        4'b1101:
        begin                             // JZ
            if(zero_flag_out)
                pc_load = 1'b1;
        end

        4'b1110:
        begin                             // JC
            if(carry_flag_out)
                pc_load = 1'b1;
        end

        4'b1111:
        begin                             // HLT
            hlt = 1'b1;
        end

        endcase

    end

    //------------------------------------------------
    // T4
    //------------------------------------------------

    T4:
    begin

        case(opcode)

        4'b0001:
        begin                             // LDA
            ro = 1'b1;
        end

        4'b0010:
        begin                             // STA
            ri       = 1'b1;
            a_out_en = 1'b1;
        end

        4'b0011:
        begin
            input_out_en = 1'b1;
            load_a       = 1'b1;
        end

        4'b0101:
        begin                             // ADD
            ro     = 1'b1;
            load_b = 1'b1;
        end

        4'b0110:
        begin                             // SUB
            ro     = 1'b1;
            load_b = 1'b1;
        end

        4'b1001:
        begin                             // AND
            ro     = 1'b1;
            load_b = 1'b1;
        end

        4'b1010:
        begin                             // OR
            ro     = 1'b1;
            load_b = 1'b1;
        end

        4'b1011:
        begin                             // XOR
            ro     = 1'b1;
            load_b = 1'b1;
        end

        endcase

    end

    //------------------------------------------------
    // T5
    //------------------------------------------------

    T5:
    begin

        case(opcode)

       4'b0001:
	begin
    		ro     = 1'b1;
    		load_a = 1'b1;
	end

        4'b0101:
        begin                             // ADD
            alu_op     = 3'b000;
            alu_out_en = 1'b1;
            load_a     = 1'b1;
            load_flags = 1'b1;
        end

        4'b0110:
        begin                             // SUB
            alu_op     = 3'b001;
            alu_out_en = 1'b1;
            load_a     = 1'b1;
            load_flags = 1'b1;
        end

        4'b1001:
        begin                             // AND
            alu_op     = 3'b100;
            alu_out_en = 1'b1;
            load_a     = 1'b1;
            load_flags = 1'b1;
        end

        4'b1010:
        begin                             // OR
            alu_op     = 3'b101;
            alu_out_en = 1'b1;
            load_a     = 1'b1;
            load_flags = 1'b1;
        end

        4'b1011:
        begin                             // XOR
            alu_op     = 3'b110;
            alu_out_en = 1'b1;
            load_a     = 1'b1;
            load_flags = 1'b1;
        end

        endcase

    end

    endcase

end

endmodule
