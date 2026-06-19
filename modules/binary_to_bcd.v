module binary_to_bcd(
    input [7:0] binary,
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] ones
);

integer value;

always @(*) begin
    value = binary;

    hundreds = value / 100;
    tens     = (value % 100) / 10;
    ones     = value % 10;
end

endmodule