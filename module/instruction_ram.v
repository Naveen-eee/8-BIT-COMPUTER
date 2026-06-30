module instruction_ram(

    input clk,

    input iri,
    input iro,
    input [3:0] addr,
    input [7:0] instruction_in,

    input [3:0] pc_out,

    output reg [7:0] instruction_out

);

reg [7:0] memory [0:15];

initial
begin
    memory[0]  = 8'h10; // LDA 0
    memory[1]  = 8'h51; // ADD 1
    memory[2]  = 8'h22; // STA 2

    memory[3]  = 8'h11; // LDA 1
    memory[4]  = 8'h20; // STA 0

    memory[5]  = 8'h12; // LDA 2
    memory[6]  = 8'h21; // STA 1

    memory[7]  = 8'h40; // OUT

    memory[8]  = 8'h13; // LDA 3
    memory[9]  = 8'h80; // DEC
    memory[10] = 8'h23; // STA 3

    memory[11] = 8'hDD; // JZ 13
    memory[12] = 8'hC0; // JMP 0

    memory[13] = 8'hF0; // HLT
end


always @(posedge clk)
begin
    if(iri)
        memory[addr] <= instruction_in;
end

always @(*)
begin
    instruction_out = memory[pc_out];
end

endmodule