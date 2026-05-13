`timescale 1ns/1ns
module ALU_1bit(a, b, cin, less, binvert, op, result, cout, set);
    input a, b, cin, less, binvert;
    input [1:0] op;
    output result, cout, set;

    wire b_mux_out;
    wire and_res;
    wire or_res;
    wire sum_internal;

    assign b_mux_out = binvert ? ~b : b;
    assign and_res = a & b;
    assign or_res  = a | b;

    FullAdder fa(
        .a(a),
        .b(b_mux_out),
        .cin(cin),
        .sum(sum_internal),
        .cout(cout)
    );

    assign set = sum_internal;

    assign result = (op == 2'b00) ? and_res :
                    (op == 2'b01) ? or_res :
                    (op == 2'b10) ? sum_internal :
                    less;
endmodule
