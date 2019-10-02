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

	reg [31:0] memory [0:255];
	//reg [31:0] shamt ; 
	reg [11:0] operand1 ;
	reg [11:0] operand2;
	reg [11:0] operand3;
	reg [11:0] operand4;
	reg [11:0] operand5;
 	reg [31:0] operation1; 
	reg [31:0] operation2; 
	reg [31:0] operation3;
	reg [31:0] operation4;
	reg [31:0] operation5;
	reg [31:0] operation6;
	reg [31:0] operation7;
	reg [31:0] operation8 ;
	reg [31:0] operation9 ;
	reg [31:0] error =0;

 




	initial begin
		
repeat(1)begin
 operand1 = $urandom_range(160,20) ; 
 operand2 = $urandom_range(12,1); 
 operand3 = $urandom_range(30,1);
 operand4 = $urandom_range(100,13);
 operand5 = $urandom_range(12,1);
        

memory[0] = 32'h 00000093;
memory[1] = {{operand1},{20'h00193}};
memory[2] = {{operand2},{20'h00113}};
memory[3] = {{operand3},{20'h00213}};
memory[4] = 32'h 002192b3;
memory[5] = 32'h 0050a023;
memory[6] = 32'h 00312333;
memory[7] = 32'h 0060a423;
memory[8] = {{operand4}, {20'h1a393}};//32'h 00b1a393;
memory[9] = 32'h 0070a623;
memory[10] = {{operand5},{20'h19413}};//32'h 00119413;
memory[11] = 32'h 0080a823;
memory[12] = {{operand5},{20'h1d493}};//32'h 0011d493;
memory[13] = 32'h 0090aa23;
memory[14] = {{operand5},{20'h1b513}};//32'h ff41b513;
memory[15] = 32'h 00a0ac23;
memory[16] = 32'h 0041b5b3;
memory[17] = 32'h 00b0ae23;
memory[18] = 32'h 4011d633;
memory[19] = 32'h 02c0a023;
memory[21] = {{operand5},{20'h1d693}};//32'h 0021d693;
memory[22] = 32'h 02d0a223;






	repeat (300) @(posedge clk);
	resetn <= 1;
	repeat (300) @(posedge clk);
	resetn <= 0;
	repeat (300) @(posedge clk);
	resetn <= 1;
	//repeat (300) @(posedge clk);


end
$finish;
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
				operation1 = operand1 <<operand2 ;
				operation2 =1 ;
				if(operand1 <= operand4  ) begin 
				operation4 = 1;

			    end
			    else begin
			    operation4 =0; 
			    end

				operation5 = operand1 << operand5 ; 
				operation6 = operand1 >> operand5 ;
				if(operand1 <= operand3 ) begin 
				operation8 = 1;

			    end
			    else begin
			    operation8 = 0;
			    end
				
				if(operand1 <= operand5 ) begin 
				operation7 = 1;

			    end
			    else begin
			    operation7 = 0;
			    end

				operation9 = operand1 >>> 0;
				operation3 = operand3 >> operand5;


				if(  (mem_addr == 32'h 00000000)&&(mem_wdata == operation1) )begin 

					$display(".................................................SLL ok , Error = %d",error);


				end

				


				else if(  (mem_addr == 32'h 00000008)&&(mem_wdata == operation2) )begin 

					$display(".................................................SLT ok ,Error = %d",error);


				end

				
				 

				else if(  (mem_addr == 32'h 0000000c)&&(mem_wdata == operation4) )begin 

					$display("...................................................SLTI ok,Error = %d",error);


				end
				
				

				else if(  (mem_addr == 32'h 00000010)&&(mem_wdata == operation5) )begin 

					$display("..................................................SLLI ok,Error = %d",error);


				end


				

				


				else if(  (mem_addr == 32'h 00000014)&&(mem_wdata == operation6) )begin 

					$display("..................................................SRLI ok,Error = %d",error);


				end

				 

				else if(  (mem_addr == 32'h 00000018)&&(mem_wdata == operation7) )begin 

					$display(".....................................................SLTIU ok,Error = %d",error);


				end

				

				else if(  (mem_addr == 32'h 0000001c)&&(mem_wdata == operation8) )begin 

					$display(".....................................................SLTU ok,Error = %d",error);


				end

				
				

				else if(  (mem_addr == 32'h 00000020)&&(mem_wdata == operation9) )begin 

					$display(".......................................................SRA ok,Error = %d",error);


				end

				

               

				else if((mem_addr == 32'h00000024 ) && (mem_wdata == operation3)) begin 

					$display(".......................................................SRLI ok,Error = %d",error);

				end

				



				else begin 
					error = error + 1; 
					$display("....................................................Error in this instruction \n  Please check files again , Total error count =%d", error);
				end

            end

			/* add memory-mapped IO here */
		end
	end
endmodule
