`timescale 1ns/1ns
module Multiplier( clk, dataA, dataB, Signal, dataOut, reset );
    input clk ;
    input reset ;
    input [31:0] dataA ;
    input [31:0] dataB ;
    input [5:0] Signal ;
    output [63:0] dataOut ;

    reg [63:0] product_reg;
    reg [63:0] multiplicand_reg;
    reg [31:0] multiplier_reg;
    reg [5:0] counter;
    reg [1:0] state;

    parameter IDLE = 2'b00;
    parameter BUSY = 2'b01;
    parameter DONE = 2'b10;
    parameter MULTU = 6'b011001;

    always @( posedge clk or posedge reset ) begin
        if ( reset ) begin
            product_reg <= 64'b0;
            multiplicand_reg <= 64'b0;
            multiplier_reg <= 32'b0;
            counter <= 6'b0;
            state <= IDLE;
        end
        else begin
            case (state)
                IDLE: begin
                    if ( Signal == MULTU ) begin
                        product_reg <= 64'b0;
                        multiplicand_reg <= {32'b0, dataA};
                        multiplier_reg <= dataB;
                        counter <= 6'b0;
                        state <= BUSY;
                    end
                end

                BUSY: begin
                    if ( counter < 6'd32 ) begin
                        if ( multiplier_reg[0] == 1'b1 ) begin
                            product_reg <= product_reg + multiplicand_reg;
                        end
                        multiplicand_reg <= {multiplicand_reg[62:0], 1'b0};
                        multiplier_reg <= {1'b0, multiplier_reg[31:1]};
                        counter <= counter + 1'b1;
                    end
                    else begin
                        state <= DONE;
                    end
                end

                DONE: begin
                    if ( Signal != MULTU ) begin
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

    assign dataOut = product_reg;

endmodule
