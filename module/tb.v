`timescale 1ns/1ps

module cpu_top_tb;

reg clk;
reg reset;

reg dma_en;
reg dma_start;

reg [7:0] sensor_data;

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

    .sensor_data(sensor_data),

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

    //--------------------------------
    // Reset
    //--------------------------------

    #50;
    reset = 0;

    //--------------------------------
    // Program Instruction RAM
    //--------------------------------

    iri = 1;

    prog_addr = 4'd0;
    prog_instruction = 8'b0001_0000;   // LDA 0
    #10;

    prog_addr = 4'd1;
    prog_instruction = 8'b0101_0001;   // ADD 1
    #10;

    prog_addr = 4'd2;
    prog_instruction = 8'b0100_0000;   // OUT
    #10;

    prog_addr = 4'd3;
    prog_instruction = 8'b1111_0000;   // HLT
    #10;

    iri = 0;

    //--------------------------------
    // Run CPU
    //--------------------------------

    #5000;

    $display("--------------------------------");
    $display("CPU OUT = %d", cpu_out);
    $display("--------------------------------");

    $stop;

end

endmodule