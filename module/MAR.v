module mar(

    input clk,
    input load_mar,      // MI Enable

    input [3:0] addr_in,

    output reg [3:0] mar_out

);

    always @(posedge clk)
    begin
        if(load_mar)
        begin
            mar_out <= addr_in;
        end
    end

endmodule