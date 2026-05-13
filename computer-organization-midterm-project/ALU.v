`timescale 1ns/1ns
module ALU( dataA, dataB, Signal, dataOut, reset );
    input reset ;
    input [31:0] dataA ;
    input [31:0] dataB ;
    input [5:0] Signal ;
    output [31:0] dataOut ;

    wire binvert;
    wire [1:0] op;
    wire [31:0] carry;
    wire [31:0] set;
    wire [31:0] alu_res;

    assign binvert = (Signal == 6'b100010 || Signal == 6'b101010) ? 1'b1 : 1'b0;
    assign op = (Signal == 6'b100100) ? 2'b00 :
                (Signal == 6'b100101) ? 2'b01 :
                (Signal == 6'b100000 || Signal == 6'b100010) ? 2'b10 :
                (Signal == 6'b101010) ? 2'b11 : 
                2'b00;

    ALU_1bit alu0  ( .a(dataA[0]),  .b(dataB[0]),  .cin(binvert),   .less(set[31]), .binvert(binvert), .op(op), .result(alu_res[0]),  .cout(carry[0]),  .set(set[0])  );
    ALU_1bit alu1  ( .a(dataA[1]),  .b(dataB[1]),  .cin(carry[0]),  .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[1]),  .cout(carry[1]),  .set(set[1])  );
    ALU_1bit alu2  ( .a(dataA[2]),  .b(dataB[2]),  .cin(carry[1]),  .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[2]),  .cout(carry[2]),  .set(set[2])  );
    ALU_1bit alu3  ( .a(dataA[3]),  .b(dataB[3]),  .cin(carry[2]),  .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[3]),  .cout(carry[3]),  .set(set[3])  );
    ALU_1bit alu4  ( .a(dataA[4]),  .b(dataB[4]),  .cin(carry[3]),  .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[4]),  .cout(carry[4]),  .set(set[4])  );
    ALU_1bit alu5  ( .a(dataA[5]),  .b(dataB[5]),  .cin(carry[4]),  .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[5]),  .cout(carry[5]),  .set(set[5])  );
    ALU_1bit alu6  ( .a(dataA[6]),  .b(dataB[6]),  .cin(carry[5]),  .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[6]),  .cout(carry[6]),  .set(set[6])  );
    ALU_1bit alu7  ( .a(dataA[7]),  .b(dataB[7]),  .cin(carry[6]),  .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[7]),  .cout(carry[7]),  .set(set[7])  );
    ALU_1bit alu8  ( .a(dataA[8]),  .b(dataB[8]),  .cin(carry[7]),  .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[8]),  .cout(carry[8]),  .set(set[8])  );
    ALU_1bit alu9  ( .a(dataA[9]),  .b(dataB[9]),  .cin(carry[8]),  .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[9]),  .cout(carry[9]),  .set(set[9])  );
    ALU_1bit alu10 ( .a(dataA[10]), .b(dataB[10]), .cin(carry[9]),  .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[10]), .cout(carry[10]), .set(set[10]) );
    ALU_1bit alu11 ( .a(dataA[11]), .b(dataB[11]), .cin(carry[10]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[11]), .cout(carry[11]), .set(set[11]) );
    ALU_1bit alu12 ( .a(dataA[12]), .b(dataB[12]), .cin(carry[11]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[12]), .cout(carry[12]), .set(set[12]) );
    ALU_1bit alu13 ( .a(dataA[13]), .b(dataB[13]), .cin(carry[12]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[13]), .cout(carry[13]), .set(set[13]) );
    ALU_1bit alu14 ( .a(dataA[14]), .b(dataB[14]), .cin(carry[13]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[14]), .cout(carry[14]), .set(set[14]) );
    ALU_1bit alu15 ( .a(dataA[15]), .b(dataB[15]), .cin(carry[14]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[15]), .cout(carry[15]), .set(set[15]) );
    ALU_1bit alu16 ( .a(dataA[16]), .b(dataB[16]), .cin(carry[15]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[16]), .cout(carry[16]), .set(set[16]) );
    ALU_1bit alu17 ( .a(dataA[17]), .b(dataB[17]), .cin(carry[16]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[17]), .cout(carry[17]), .set(set[17]) );
    ALU_1bit alu18 ( .a(dataA[18]), .b(dataB[18]), .cin(carry[17]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[18]), .cout(carry[18]), .set(set[18]) );
    ALU_1bit alu19 ( .a(dataA[19]), .b(dataB[19]), .cin(carry[18]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[19]), .cout(carry[19]), .set(set[19]) );
    ALU_1bit alu20 ( .a(dataA[20]), .b(dataB[20]), .cin(carry[19]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[20]), .cout(carry[20]), .set(set[20]) );
    ALU_1bit alu21 ( .a(dataA[21]), .b(dataB[21]), .cin(carry[20]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[21]), .cout(carry[21]), .set(set[21]) );
    ALU_1bit alu22 ( .a(dataA[22]), .b(dataB[22]), .cin(carry[21]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[22]), .cout(carry[22]), .set(set[22]) );
    ALU_1bit alu23 ( .a(dataA[23]), .b(dataB[23]), .cin(carry[22]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[23]), .cout(carry[23]), .set(set[23]) );
    ALU_1bit alu24 ( .a(dataA[24]), .b(dataB[24]), .cin(carry[23]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[24]), .cout(carry[24]), .set(set[24]) );
    ALU_1bit alu25 ( .a(dataA[25]), .b(dataB[25]), .cin(carry[24]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[25]), .cout(carry[25]), .set(set[25]) );
    ALU_1bit alu26 ( .a(dataA[26]), .b(dataB[26]), .cin(carry[25]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[26]), .cout(carry[26]), .set(set[26]) );
    ALU_1bit alu27 ( .a(dataA[27]), .b(dataB[27]), .cin(carry[26]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[27]), .cout(carry[27]), .set(set[27]) );
    ALU_1bit alu28 ( .a(dataA[28]), .b(dataB[28]), .cin(carry[27]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[28]), .cout(carry[28]), .set(set[28]) );
    ALU_1bit alu29 ( .a(dataA[29]), .b(dataB[29]), .cin(carry[28]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[29]), .cout(carry[29]), .set(set[29]) );
    ALU_1bit alu30 ( .a(dataA[30]), .b(dataB[30]), .cin(carry[29]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[30]), .cout(carry[30]), .set(set[30]) );
    ALU_1bit alu31 ( .a(dataA[31]), .b(dataB[31]), .cin(carry[30]), .less(1'b0),    .binvert(binvert), .op(op), .result(alu_res[31]), .cout(carry[31]), .set(set[31]) );

    assign dataOut = reset ? 32'b0 : alu_res;

endmodule
