module display_scanner(

    input clk,

    input [3:0] hundreds,
    input [3:0] tens,
    input [3:0] ones,

    output reg [3:0] an,
    output [6:0] seg
);

reg [1:0] digit_sel;
reg [3:0] digit;

wire [6:0] seg_int;

seven_seg_decoder DEC(
    .digit(digit),
    .seg(seg_int)
);

assign seg = seg_int;

always @(posedge clk)
    digit_sel <= digit_sel + 1;

always @(*) begin

    case(digit_sel)

        2'b00:
        begin
            an    = 4'b1110;
            digit = ones;
        end

        2'b01:
        begin
            an    = 4'b1101;
            digit = tens;
        end

        2'b10:
        begin
            an    = 4'b1011;
            digit = hundreds;
        end

        2'b11:
        begin
            an    = 4'b0111;
            digit = 4'hF;
        end

    endcase

end

endmodule