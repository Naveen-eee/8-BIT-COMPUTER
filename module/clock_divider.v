module clock_divider(

    input clk,
    input reset,

    output reg slow_clk

);

reg [26:0] count;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        count    <= 27'd0;
        slow_clk <= 1'b0;
    end
    else if(count == 49_999_999)
    begin
        count    <= 27'd0;
        slow_clk <= ~slow_clk;
    end
    else
    begin
        count <= count + 1'b1;
    end
end

endmodule