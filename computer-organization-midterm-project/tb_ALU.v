`timescale 1ns/ 1ns
module tb_ALU();
	reg clk, rst;
	reg[5:0] ctrl;
	reg[31:0] inputA, inputB, ans;
	wire[31:0] out;
	integer fp_r, fp_r_ans, eof;
	
	// ????????10ns
	initial begin
		clk = 1'b1;
		forever #5 clk = ~clk;
	end
	
	initial begin
		eof = 0;
		rst = 1'b1;
		#10;
		rst = 1'b0;
		/*
			?????????"input.txt"?????
			????????
			????????  InputA  InputB
		*/
		fp_r = $fopen( "input.txt", "r" );
		/*
			???????"ans.txt"?????
			??????????
		*/
		fp_r_ans = $fopen( "ans.txt", "r" );
		/*
			??????ALU???????
			??????????"Correct"
			???????????????
			???????????cycle number
		*/
		$display( "Start\n" );
		eof = $fscanf(fp_r_ans, "%d", ans);
		while( eof != -1 ) begin
			$fscanf(fp_r, "%d%d%d", ctrl, inputA, inputB );
			$write( "%d: Input: ", $time/10 );
			if ( ctrl == 6'd36 ) $write( "AND(%d)", ctrl );
			else if ( ctrl == 6'd37 ) $write( "OR(%d) ", ctrl );
			else if ( ctrl == 6'd32 ) $write( "ADD(%d) ", ctrl );
			else if ( ctrl == 6'd34 ) $write( "SUB(%d) ", ctrl );
			else if ( ctrl == 6'd42 ) $write( "SLT(%d) ", ctrl );
			else if ( ctrl == 6'd2 ) $write( "SRL(%d) ", ctrl );
			else if ( ctrl == 6'd25 ) $write( "MULTU(%d) ", ctrl ); // ? DIVU (27) ??? MULTU (25)
			$display( " %d %d", inputA, inputB  );
            
            // ???????? 32'd27 ??? 6'd25 (MULTU)
			if ( ctrl == 6'd25 ) begin
				#330; // ?????????????? 32 ? clk cycle (320ns + buffer) ????
				$display( "%d: Mult End\n", $time/10 ); // ? Div End ??? Mult End
				/*
					?????????????Hi-Lo???
					??????MFHI, MFLO??????????
				*/
				#10;
				#10;
				
				$display( "                   Move Hi" );
				ctrl = 6'd16;
				#10;
				if ( ans == out )
					$display( "%d: Correct: Your answer is:%d,\n                                 Correct answer is:%d\n", $time/10, out, ans );
				else
					$display( "%d: Wrong Answer: Your answer is:%d,\n                                             Correct answer is:%d\n", $time/10, out, ans );
				$display( "                   Move Lo" );
				ctrl = 6'd18;
				eof = $fscanf(fp_r_ans, "%d", ans);
				#10;
				if ( ans == out )
					$display( "%d: Correct: Your answer is:%d,\n                                 Correct answer is:%d\n", $time/10, out, ans );
				else
					$display( "%d: Wrong Answer: Your answer is:%d,\n                                             Correct answer is:%d\n", $time/10, out, ans );
			end
			else begin
				#10;
				if ( ans == out )
					$display( "%d: Correct: Your answer is:%d,\n                                 Correct answer is:%d\n", $time/10, out, ans );
				else
					$display( "%d: Wrong Answer: Your answer is:%d,\n                                             Correct answer is:%d\n", $time/10, out, ans );
			end
			eof = $fscanf(fp_r_ans, "%d", ans);
		end
		$fclose( fp_r );
		$fclose( fp_r_ans );
		$display( "Simulation End\n" );
		$stop();
	end

	TotalALU alu( .clk(clk), .reset(rst), .dataA(inputA), 
				  .dataB(inputB), .Signal(ctrl), .Output(out) );

endmodule 

/*
	AND   : 36
	OR    : 37
	ADD   : 32
	SUB   : 34
	SLT   : 42
	SRL   : 02
	MULTU : 25  <-- ????????????? MULTU
*/