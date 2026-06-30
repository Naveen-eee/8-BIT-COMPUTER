`timescale 1ns/1ps

module cpu_top_tb;

reg clk;
reg reset;

reg dma_en;
reg dma_start;
reg ir_sensor;
reg iri;
reg [3:0] prog_addr;
reg [7:0] prog_instruction;

wire [2:0] an;
wire [6:0] seg;
wire [7:0] cpu_out;

cpu_top DUT(
    .clk(clk),
    .reset(reset),

    .dma_en(dma_en),
    .dma_start(dma_start),

    .ir_sensor(ir_sensor),

    .iri(iri),
    .prog_addr(prog_addr),
    .prog_instruction(prog_instruction),

    .an(an),
    .seg(seg),

    .cpu_out(cpu_out)
);

always #5 clk = ~clk;

initial
begin

    clk = 0;
    reset = 1;

    dma_en = 0;
    dma_start = 0;
    sensor_data = 0;

    iri = 0;
    prog_addr = 0;
    prog_instruction = 0;

    #20;
    reset = 0;

    //----------------------------------
    // Program Memory
    //----------------------------------

   iri = 1;

// 0 : LDA 0
prog_addr = 4'd0;
prog_instruction = 8'b0001_0000;
#10;

// 1 : ADD 1
prog_addr = 4'd1;
prog_instruction = 8'b0101_0001;
#10;

// 2 : STA 2
prog_addr = 4'd2;
prog_instruction = 8'b0010_0010;
#10;

// 3 : LDA 2
prog_addr = 4'd3;
prog_instruction = 8'b0001_0010;
#10;

// 4 : DEC
prog_addr = 4'd4;
prog_instruction = 8'b1000_0000;
#10;

// 5 : INC
prog_addr = 4'd5;
prog_instruction = 8'b0111_0000;
#10;

// 6 : SUB 1
prog_addr = 4'd6;
prog_instruction = 8'b0110_0001;
#10;

// 7 : OUT
prog_addr = 4'd7;
prog_instruction = 8'b0100_0000;
#10;

// 8 : HLT
prog_addr = 4'd8;
prog_instruction = 8'b1111_0000;
#10;

iri = 0;

    //----------------------------------
    // Run CPU
    //----------------------------------

    #2000;

    $display("----------------------");
    $display("CPU_OUT = %d", cpu_out);
    $display("----------------------");

    $stop;

end

endmodule