module cpu_top(

    input clk,
    input reset,
    input start,  
    // DMA / Sensor

   // input dma_en,
    input dma_start,

     input ir_sensor,

    // Instruction Programming

    input iri,
    input [3:0] prog_addr,
    input [7:0] prog_instruction,

    // 7 Segment Display

    output [3:0] an,
    output [6:0] seg,
    output [3:0] pc_an,
    output [6:0] pc_seg,

    // Debug

    output [7:0] cpu_out

);
wire [7:0] sensor_data;
reg run;
//reg start_d;

//always @(posedge clk)
//begin
//    start_d <= start;
//end

//wire start_pulse;
//assign start_pulse = start & ~start_d;

//wire core_reset;
//assign core_reset = reset | start_pulse;
wire core_reset;
assign core_reset = reset;
assign an[3] = 1'b0;   // active-low display OFF
assign pc_an[3] = 1'b0;   // PC display MSB OFF
assign sensor_data = {7'b0000000, ir_sensor};
//=====================================================
// Clock Divider
//=====================================================
always @(posedge clk or posedge reset)
begin
    if(reset)
        run <= 1'b0;
    else if(start)
        run <= 1'b1;
end
//wire slow_clk;

//assign slow_clk = clk;
wire slow_clk;
wire cpu_clk;

assign cpu_clk = slow_clk & run & ~hlt;

clock_divider CLK_DIV(
    .clk(clk),
    .reset(reset),
    .slow_clk(slow_clk)
);
//=====================================================
// Internal Wires
//=====================================================

wire [3:0] pc_out;
wire [3:0] mar_out;

wire [7:0] instruction_out;
wire [7:0] ir_out;

wire [3:0] opcode;
wire [3:0] operand;

wire [7:0] data_ram_out;

wire [7:0] input_reg_out;

wire [7:0] a_reg_data;
wire [7:0] a_reg_out;

wire [7:0] b_reg_out;

wire [7:0] alu_result;

wire zero_flag;
wire carry_flag;

wire zero_flag_out;
wire carry_flag_out;

//=====================================================
// Control Signals
//=====================================================

wire pc_inc;
wire pc_load;

wire load_ir;

wire load_mar;

wire load_a;
wire load_b;

wire a_out_en;

wire load_out;

wire load_input;
wire input_out_en;

wire ri;
wire ro;

wire alu_out_en;
wire load_flags;

wire [2:0] alu_op;

wire iro;

wire hlt;

//=====================================================
// DMA Signals
//=====================================================

wire dma_active;
wire dma_done;

wire [3:0] dma_addr;
wire [7:0] dma_data;

//=====================================================
// Common Bus
//=====================================================

wire [7:0] w_bus;

assign w_bus =
        (ro)           ? data_ram_out :
        (a_out_en)     ? a_reg_out :
        (alu_out_en)   ? alu_result :
        (input_out_en) ? input_reg_out :
                         8'b00000000;

//=====================================================
// PC
//=====================================================

pc PC(

    .clk(cpu_clk),
    .reset(core_reset),

    .pc_inc(pc_inc),
    .pc_load(pc_load),

    .operand(operand),

    .pc_out(pc_out)

);

//=====================================================
// Instruction RAM
//=====================================================

instruction_ram IRAM(

    .clk(slow_clk),

    .iri(iri),
    .iro(iro),

    .addr(prog_addr),

    .instruction_in(prog_instruction),

    .pc_out(pc_out),

    .instruction_out(instruction_out)

);

//=====================================================
// Instruction Register
//=====================================================

ir IR(

    .clk(cpu_clk),

    .load_ir(load_ir),

    .instruction(instruction_out),

    .ir_out(ir_out),

    .opcode(opcode),

    .operand(operand)

);

//=====================================================
// MAR
//=====================================================

mar MAR(

    .clk(cpu_clk),

    .load_mar(load_mar),

    .addr_in(operand),

    .mar_out(mar_out)

);

//=====================================================
// DMA
//=====================================================

dma_controller DMA(

    .clk(slow_clk),
    .reset(reset),

    .dma_en(1'b1),
    .dma_start(dma_start),

    .sensor_data(sensor_data),

    .dma_active(dma_active),
    .dma_done(dma_done),

    .dma_addr(dma_addr),
    .dma_data(dma_data)

);

//=====================================================
// Data RAM
//=====================================================

data_ram DRAM(

    .clk(slow_clk),

    .ri(ri),
    .ro(ro),

    .data_addr(mar_out),

    .data_ram_in(a_reg_data),
    
    .dma_active(dma_active),
     
    .dma_addr(dma_addr),
    .dma_data(dma_data),

    .data_ram_out(data_ram_out)

);

//=====================================================
// Input Register
//=====================================================

input_register INPUT_REG(

    .clk(slow_clk),

    .load_input(load_input),

    .input_out_en(input_out_en),

    .sensor_data(sensor_data),

    .input_reg_out(input_reg_out)

);

//=====================================================
// A Register
//=====================================================

a_register AREG(

    .clk(cpu_clk),
    .reset(core_reset),

    .load_a(load_a),

    .a_out_en(a_out_en),

    .w_bus(w_bus),

    .a_reg_data(a_reg_data),

    .a_reg_out(a_reg_out)

);
//=====================================================
// B Register
//=====================================================

b_register BREG(

    .clk(cpu_clk),
    .reset(core_reset),

    .load_b(load_b),

    .w_bus(w_bus),

    .b_reg_out(b_reg_out)

);

//=====================================================
// ALU
//=====================================================

alu ALU(

    .a_reg_data(a_reg_data),

    .b_reg_out(b_reg_out),

    .alu_op(alu_op),

    .alu_out_en(alu_out_en),

    .alu_result(alu_result),

    .zero_flag(zero_flag),

    .carry_flag(carry_flag)

);

//=====================================================
// Flag Register
//=====================================================

flag_register FLAGS(

    .clk(cpu_clk),
    .reset(core_reset),

    .load_flags(load_flags),

    .zero_flag(zero_flag),

    .carry_flag(carry_flag),

    .zero_flag_out(zero_flag_out),

    .carry_flag_out(carry_flag_out)

);

//=====================================================
// Output Register
//=====================================================

out_register OREG(

    .clk(cpu_clk),
    .reset(core_reset),

    .load_out(load_out),

    .w_bus(w_bus),

    .out_reg_out(cpu_out)

);

//=====================================================
// Display Controller
//=====================================================

display_controller DISP(

    .clk(clk),          // fast clock for display refresh
    .reset(reset),

    .cpu_out(cpu_out),

    .an(an),
    .seg(seg)

);

display_controller DISP_PC(
    .clk(clk),
    .reset(reset),
    .cpu_out({4'b0000,pc_out}),
    .an(pc_an),
    .seg(pc_seg)
);
//=====================================================
// Control Unit
//=====================================================

control_unit CU(

    .clk(cpu_clk),
    .reset(core_reset),

    .opcode(opcode),

    .zero_flag_out(zero_flag_out),
    .carry_flag_out(carry_flag_out),

    .pc_inc(pc_inc),
    .pc_load(pc_load),

    .load_ir(load_ir),

    .load_mar(load_mar),

    .load_a(load_a),
    .load_b(load_b),

    .a_out_en(a_out_en),

    .load_out(load_out),

    .load_input(load_input),
    .input_out_en(input_out_en),

    .ri(ri),
    .ro(ro),

    .alu_out_en(alu_out_en),

    .load_flags(load_flags),

    .alu_op(alu_op),

    .iro(iro),

    .hlt(hlt)

);


endmodule