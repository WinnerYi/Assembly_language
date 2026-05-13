`timescale 1ns/1ns
module Shifter( dataA, dataB, Signal, dataOut, reset );
    input reset ;
    input [31:0] dataA ;
    input [31:0] dataB ;
    input [5:0] Signal ;
    output [31:0] dataOut ;

    wire [31:0] s0, s1, s2, s3, s4;

    assign s0 = dataB[0] ? {1'b0, dataA[31:1]} : dataA;
    assign s1 = dataB[1] ? {2'b00, s0[31:2]} : s0;
    assign s2 = dataB[2] ? {4'b0000, s1[31:4]} : s1;
    assign s3 = dataB[3] ? {8'b0000_0000, s2[31:8]} : s2;
    assign s4 = dataB[4] ? {16'b0000_0000_0000_0000, s3[31:16]} : s3;

    assign dataOut = reset ? 32'b0 : 
                     (Signal == 6'b000010) ? s4 : 32'b0;

endmodule
