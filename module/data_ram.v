module data_ram(

    input clk,

    input ri,
    input ro,

    input [3:0] data_addr,
    input [7:0] data_ram_in,

    input dma_active,
    input [3:0] dma_addr,
    input [7:0] dma_data,

    output reg [7:0] data_ram_out

);

reg [7:0] memory [0:15];

// TEMPORARY DEBUG VALUES

    initial
begin
//    memory[0]  = 8'd10;
//    memory[1]  = 8'd20;
//    memory[2]  = 8'd30;
//    memory[3]  = 8'd40;
//    memory[4]  = 8'd50;
//    memory[5]  = 8'd60;
//    memory[6]  = 8'd70;
//    memory[7]  = 8'd80;

//    memory[8]  = 8'd90;
//    memory[9]  = 8'd100;
//    memory[10] = 8'd110;
//    memory[11] = 8'd120;
//    memory[12] = 8'd130;
//    memory[13] = 8'd140;
//    memory[14] = 8'd150;
//    memory[15] = 8'd160;
memory[0] = 8'd1; // A
memory[1] = 8'd1; // B
memory[2] = 8'd0; // TEMP
memory[3] = 8'd4; // COUNT
end


always @(posedge clk)
begin

    if(dma_active)
        memory[dma_addr] <= dma_data;

    else if(ri)
        memory[data_addr] <= data_ram_in;

end

always @(*)
begin

    if(ro)
        data_ram_out = memory[data_addr];

    else
        data_ram_out = 8'bzzzzzzzz;

end

endmodule