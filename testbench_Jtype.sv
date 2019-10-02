// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

`timescale 1 ns / 1 ps

module testbench;
	reg clk = 1;
	reg resetn = 0;
	wire trap;
  wire mem_valid;
	wire mem_instr;
	reg mem_ready;
	wire [31:0] mem_addr;
	wire [31:0] mem_wdata;
	wire [3:0] mem_wstrb;
	reg  [31:0] mem_rdata;


	always #5 clk = ~clk;

	initial begin
	//	if ($test$plusargs("vcd")) begin
			$dumpfile("testbench.dump");
			$dumpvars(0, testbench);
		//end
		repeat (350) @(posedge clk);
		resetn <= 1;
		repeat (350) @(posedge clk);
		$finish;
	end

	
	always @(posedge clk) begin
		if (mem_valid && mem_ready) begin
			if (mem_instr)
				$display("ifetch 0x%08x: 0x%08x", mem_addr, mem_rdata);
			else if (mem_wstrb)
				$display("write  0x%08x: 0x%08x (wstrb=%b)", mem_addr, mem_wdata, mem_wstrb);
			else
				$display("read   0x%08x: 0x%08x", mem_addr, mem_rdata);
		end
	end

	picorv32_reduced_pin #(
	) uut (
		.clk         (clk        ),
		.resetn      (resetn     ),
		
		.mem_valid   (mem_valid  ),
		.mem_instr   (mem_instr  ),
		.mem_ready   (mem_ready  ),
		.mem_addr    (mem_addr   ),
		.mem_wdata   (mem_wdata  ),
		.mem_wstrb   (mem_wstrb  ),
		.mem_rdata   (mem_rdata  )
	);

	reg [31:0] memory [0:1024];
	
	reg [31:0] error =0;


	initial begin
		
 //  operand1 = $urandom_range(2020,0);
 //  operand2 = $urandom_range(20,0);
 //  operand3 = $urandom_range(50,0);
 //  operand4 = $urandom_range(10,0);
//   operand5 = $urandom_range(100,0);



memory[0] = 32'h00000093;
memory[1] = 32'h7e400113;
memory[2] = 32'h00900193;
memory[3] = 32'h03200213;
memory[4] = 32'h00a00293;
memory[5] = 32'hf9c00f93;
memory[6] = 32'h02828493;
memory[7] = 32'h00448463;
memory[8] = 32'h05010313;
memory[9] = 32'h7bc10313;
memory[10] = 32'h0020ae23;
memory[11] = 32'h00119463;
memory[12] = 32'h00118393;
memory[13] = 32'h05a18393;
memory[14] = 32'h0270aa23;
memory[15] = 32'h0051c463;
memory[16] = 32'h00518433;
memory[17] = 32'h03220413;
memory[18] = 32'h0480a223;
memory[19] = 32'h0032d463;
memory[20] = 32'h01e20513;
memory[21] = 32'h15e20513;
memory[22] = 32'h04a0aa23;
memory[23] = 32'h01f26463;
memory[24] = 32'h064f8f93;
memory[25] = 32'hf9cf8593;
memory[26] = 32'h06b0a223;
memory[27] = 32'h004ff463;
memory[28] = 32'h7eef8f93;
memory[29] = 32'h7d060613;
memory[30] = 32'h06c0aa23;
memory[31] = 32'h0c868693;
memory[32] = 32'h01f686b3;
memory[33] = 32'h4026d713;
memory[34] = 32'h08e0a223;        


end

	always @(posedge clk) begin
		mem_ready <= 0;
		if (mem_valid && !mem_ready) begin
			if (mem_addr < 1024) begin
				mem_ready <= 1;
				mem_rdata <= memory[mem_addr >> 2];
				if (mem_wstrb[0]) memory[mem_addr >> 2][ 7: 0] <= mem_wdata[ 7: 0];
				if (mem_wstrb[1]) memory[mem_addr >> 2][15: 8] <= mem_wdata[15: 8];
				if (mem_wstrb[2]) memory[mem_addr >> 2][23:16] <= mem_wdata[23:16];
				if (mem_wstrb[3]) memory[mem_addr >> 2][31:24] <= mem_wdata[31:24];
			end
			if(mem_wstrb == 4'b 1111) begin 
				//operation1 =operand1+ 1980;

				if(  (mem_addr == 32'h 0000001c)&&(mem_wdata == 32'h 000007e4) )begin 

					$display(".................................................BEQ ok,Error=%d", error);


				end
				
				

				else if(  (mem_addr == 32'h 00000034)&&(mem_wdata == 32'h 00000063) )begin 

					$display(".................................................BNE ok,Error=%d", error);


				end
				 

				else if(  (mem_addr == 32'h 00000044)&&(mem_wdata == 32'h 00000064) )begin 

					$display("...................................................BLT ok,Error=%d", error);


				end
				

				else if(  (mem_addr == 32'h 00000054)&&(mem_wdata == 32'h 00000190) )begin 

					$display("..................................................BGE ok,Error=%d", error);


				end

				


				else if(  (mem_addr == 32'h 00000064)&&(mem_wdata == 32'h ffffff38) )begin 

					$display("................................................. BLTU ok,Error=%d", error);


				end

				

				else if(  (mem_addr == 32'h 00000074)&&(mem_wdata == 32'h 000007d0) )begin 

					$display(".....................................................BGEU ok,Error=%d", error);


				end

				

				else if(  (mem_addr == 32'h 00000084)&&(mem_wdata == 32'h 00000019) )begin 

					$display(".....................................................SRAI ok ,Error=%d", error);


				end

				else begin 
					error = error + 1; 

				$display("Error in this instruction..................Total Error=%d", error);
			    end

			end



		

			/* add memory-mapped IO here */
		end
	end
endmodule
