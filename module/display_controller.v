module display_controller(

    input clk,
    input reset,

    input [7:0] cpu_out,

    output reg [2:0] an,
    output reg [6:0] seg

);

reg [3:0] hundreds;
reg [3:0] tens;
reg [3:0] ones;

reg [15:0] refresh_counter;

wire [1:0] digit_select;

assign digit_select = refresh_counter[15:14];

//
// Binary to BCD
//
integer temp;

always @(*)
begin

    temp = cpu_out;

    hundreds = temp / 100;

    temp = temp % 100;

    tens = temp / 10;

    ones = temp % 10;

end

//
// Refresh Counter
//
always @(posedge clk or posedge reset)
begin

    if(reset)
        refresh_counter <= 16'd0;

    else
        refresh_counter <= refresh_counter + 1'b1;

end

//
// Display Multiplexing
//
always @(*)
begin

    case(digit_select)

        // Ones Digit

        2'b00:
        begin

            an = 3'b110;

            case(ones)

                4'd0: seg = 7'b1000000;
                4'd1: seg = 7'b1111001;
                4'd2: seg = 7'b0100100;
                4'd3: seg = 7'b0110000;
                4'd4: seg = 7'b0011001;
                4'd5: seg = 7'b0010010;
                4'd6: seg = 7'b0000010;
                4'd7: seg = 7'b1111000;
                4'd8: seg = 7'b0000000;
                4'd9: seg = 7'b0010000;

                default: seg = 7'b1111111;

            endcase

        end

        // Tens Digit

        2'b01:
        begin

            an = 3'b101;

            case(tens)

                4'd0: seg = 7'b1000000;
                4'd1: seg = 7'b1111001;
                4'd2: seg = 7'b0100100;
                4'd3: seg = 7'b0110000;
                4'd4: seg = 7'b0011001;
                4'd5: seg = 7'b0010010;
                4'd6: seg = 7'b0000010;
                4'd7: seg = 7'b1111000;
                4'd8: seg = 7'b0000000;
                4'd9: seg = 7'b0010000;

                default: seg = 7'b1111111;

            endcase

        end

        // Hundreds Digit

        default:
        begin

            an = 3'b011;

            case(hundreds)

                4'd0: seg = 7'b1000000;
                4'd1: seg = 7'b1111001;
                4'd2: seg = 7'b0100100;
                4'd3: seg = 7'b0110000;
                4'd4: seg = 7'b0011001;
                4'd5: seg = 7'b0010010;
                4'd6: seg = 7'b0000010;
                4'd7: seg = 7'b1111000;
                4'd8: seg = 7'b0000000;
                4'd9: seg = 7'b0010000;

                default: seg = 7'b1111111;

            endcase

        end

    endcase

end

endmodule