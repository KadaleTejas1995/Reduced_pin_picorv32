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
		if ($test$plusargs("vcd")) begin
			$dumpfile("testbench_RS.dump");
			$dumpvars(0, testbench);
		end

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
	reg [11:0] operand1 ;
	reg [11:0] operand2 ;
	reg [31:0] operand3 ;
	reg [31:0] operation1 ; 
	reg [31:0] operation2 ; 
	reg [31:0] operation3 ;
	reg [31:0] operation4 ;
	reg [31:0] operation5 ;
	reg [31:0] operation6 ;
	reg [31:0] error = 0;
	//reg [31:0] operation7 ;
	//reg [31:0] operation8 ; 


 	


	initial begin

repeat(3)begin

  operand1 = $urandom_range(1000,500);
  operand2 = $urandom_range(2000,1001);  

	memory[0]=  32'h 00000093;
	memory[1]=  {{operand1}, {20'h 00193}}; 
	memory[2]=  {{operand2}, {20'h 00213}}; 
	memory[3]=  32'h 00418133;
	memory[4]=  32'h 0020a823;
	memory[5]=  32'h 01410113;
	memory[6]=  32'h 0020aa23;
	memory[7]=  32'h 40320133;
	memory[8]=  32'h 0020ac23;
	memory[9]=  32'h 0041f133;
	memory[10]=  32'h 0020ae23;
	memory[12]=  32'h 0041c133;
	memory[13]=  32'h 0220a023;
	memory[14]=  32'h 0041e133;
	memory[15]=  32'h 0220a223;
	memory[16]=  32'h abcdf1b7;
	memory[17]=  32'h f1018193;
	memory[18]=  32'h 0230a423;
	memory[19]=  32'h 00c08283;
	memory[20]=  32'h 0250a623;
	memory[21]=  32'h 00c09303;
	memory[22]=  32'h 0260a823;
	memory[23]=  32'h 02308a23;
	memory[24]=  32'h 02309c23;


  	repeat (200) @(posedge clk);
	resetn <= 1;
	repeat (200) @(posedge clk);
	resetn <= 0;
	repeat (200) @(posedge clk);
	resetn <= 1;
	repeat (200) @(posedge clk);


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
			
			if(mem_wstrb >= 4'b 0001) begin 
				operation1 = operand1 + operand2;
				operation2 = operand1 + operand2 + 20;
				operation3 = operand2 - operand1;
				operation4 = operand1 & operand2 ;
				operation5 = operand2 ^ operand1;
				operation6 = operand1 | operand2;

				if(  (mem_addr == 32'h 00000010)&&(mem_wdata == operation1) )begin 

					$display(".................................................Add ok,Error = %d",error);


				end

				
				
				

				else if(  (mem_addr == 32'h 00000014)&&(mem_wdata == operation2) )begin 

					$display(".................................................Addi ok,Error = %d",error);


				end
				 

				else if(  (mem_addr == 32'h 00000018)&&(mem_wdata == operation3) )begin 

					$display("...................................................SUB ok,Error = %d",error);


				end
				

				else if(  (mem_addr == 32'h 0000001c)&&(mem_wdata == operation4) )begin 

					$display("..................................................AND ok,Error = %d",error);


				end

				


				else if(  (mem_addr == 32'h 00000020)&&(mem_wdata == operation5) )begin 

					$display("..................................................XOR ok,Error = %d",error);


				end

				

				else if(  (mem_addr == 32'h 00000024)&&(mem_wdata == operation6) )begin 

					$display(".....................................................OR ok,Error = %d",error);


				end

				

				else if(  (mem_addr == 32'h 00000028)&&(mem_wdata == 32'h abcdef10) )begin 

					$display(".....................................................LI ok,Error = %d",error);


				end

				
				

				else if(  (mem_addr == 32'h 0000002c)&&(mem_wdata == 32'h 00000033) )begin 

					$display(".......................................................LB ok,Error = %d",error);


				end

                else if(  (mem_addr == 32'h 00000030)&&(mem_wdata == 32'h ffff8133) )begin 

					$display(".......................................................LH ok,Error = %d",error);


				end

				else if((mem_addr == 32'h00000034 ) && (mem_wdata == 32'h10101010)) begin 

					$display(".......................................................SB ok,Error = %d",error);

				end

				else if((mem_addr == 32'h00000038 ) && (mem_wdata == 32'h ef10ef10)) begin 

					$display(".......................................................SH ok,Error = %d",error);

				end



				else begin 
					error = error + 1;

					$display("....................................................Error in this instruction \n  Please check files again ,Total Error = %d",error);
				end

            end



		end

		    
		


		    
	end
	

endmodule
