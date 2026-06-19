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

    
    always @(posedge clk)
    begin
        if(iri)
        begin
            memory[addr] <= instruction_in;
        end
    end

    
    always @(*)
    begin
        if(iro)
            instruction_out = memory[pc_out];
        else
             instruction_out = 8'bzzzzzzzz;
    end

endmodule
