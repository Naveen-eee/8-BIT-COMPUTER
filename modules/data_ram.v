module data_ram(

    input clk,

    // CPU Write

    input ri,
    input ro,

    input [3:0] data_addr,
    input [7:0] data_ram_in,

    // DMA Write

    input dma_active,
    input [3:0] dma_addr,
    input [7:0] dma_data,

    output reg [7:0] data_ram_out

);

    reg [7:0] memory [0:15];

    // Write Operation

    always @(posedge clk)
    begin

        // DMA has higher priority

        if(dma_active)
        begin
            memory[dma_addr] <= dma_data;
        end

        // CPU Write (STA)

        else if(ri)
        begin
            memory[data_addr] <= data_ram_in;
        end

    end

    // Read Operation

    always @(*)
    begin

        if(ro)
        begin
            data_ram_out = memory[data_addr];
        end

        else
        begin
            data_ram_out = 8'b00000000;
        end

    end

endmodule