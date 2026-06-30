module dma_controller(

    input clk,
    input reset,

    input dma_en,
    input dma_start,

    input [7:0] sensor_data,

    output reg dma_active,
    output reg dma_done,

    output reg [3:0] dma_addr,
    output reg [7:0] dma_data

);

reg [4:0] sample_count;

always @(posedge clk)
begin

    if(reset)
    begin
        dma_active <= 1'b0;
        dma_done <= 1'b0;

        dma_addr <= 4'd0;
        dma_data <= sensor_data;

        sample_count <= 5'd0;
    end

    else if(dma_en)
    begin

        if(dma_start && !dma_active)
        begin
            dma_active <= 1'b1;
            dma_done <= 1'b0;

            dma_addr <= 4'd0;
            sample_count <= 5'd0;
        end

        else if(dma_active)
        begin

            dma_data <= sensor_data;

            if(sample_count == 5'd15)
            begin
                dma_active <= 1'b0;
                dma_done <= 1'b1;
            end

            else
            begin
                dma_addr <= dma_addr + 1'b1;
                sample_count <= sample_count + 1'b1;
            end

        end

    end

end

endmodule