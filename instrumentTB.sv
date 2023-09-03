//Test bench for the module instrument I made
`timescale 1ns/100ps

module instrumentTB;

//Defining variables
logic			inc, ind, ine, inf, ing, ina, inb;
logic			demo, demo2;
logic			clk = 1'b1;
logic			outc, outd, oute, outf, outg, outa, outb;
logic			segA, segB, segC, segD, segE, segF, segG;
logic			segA2, segB2, segC2, segD2, segE2, segF2, segG2;

//Defining the period
  `define PERIOD 10

//Defining the clock 
 always
	#(`PERIOD/2) clk = ~clk;

//Calling the instrument module with all inputs
instrument DUT1 (.inc(inc), .ind(ind), .ine(ine), .inf(inf), .ing(ing), .ina(ina), .inb(inb), .demo(demo), .clk(clk), .outc(outc), .outd(outd), .oute(oute), .outf(outf), 
.outg(outg), .outa(outa), .outb(outb), .segA(segA), .segB(segB), .segC(segC), .segD(segD), .segE(segE), .segF(segF), .segG(segG),.segA2(segA2), .segB2(segB2), .segC2(segC2), .segD2(segD2), .segE2(segE2), .segF2(segF2), .segG2(segG2), .demo2(demo2));

//displays all the values in the simulation waveform
  initial
    begin
     $monitor ( "time=%t inc=%b ind=%b ine=%b inf=%b ing=%b ina=%b inb=%b demo=%b demo2=%b clk=%b outc=%h outd=%h oute=%h outf=%h outg=%h outa=%h outb=%h segA=%h segB=%h segC=%h segD=%h segE=%h segF=%h segG=%h segA2=%h segB2=%h segC2=%h segD2=%h segE2=%h segF2=%h segG2=%h", 
	  $time, inc, ind, ine, inf, ing, ina, inb, demo, demo2, clk, outc, outd, oute, outf, outg, outa, outb, segA, segB, segC, segD, segE, segF, segG, segA2, segB2, segC2, segD2, segE2, segF2, segG2);
	 end

	
	  always
	   begin
	
//Testing all variables out to make sure output matches what I want	
		inc = 1;
		
		   #10;
		  
		ind = 1;
		inc = 0;
		  
		   #10;
		 
		ine = 1;
		ind = 0;
		  
			#10;
			
		inf = 1;
		ine = 0;
		
			#10;
		
		ing = 1;
		inf = 0;
		
			#10;
			
		ina = 1;
		ing = 0;
		
			#10;
			
		inb = 1;
		ina = 0;
		
			#10;
		
		inc = 1;
		inb = 0;
		
			#10;

//Testing multiple variables to check if output matches what I want			
		inc = 1;
		inb = 1;
		
//Turning on the demo		
			#10;
			
		inc = 0;
	   inb = 0;
		demo = 1;
		
//The rest is just pressing the demo clock to make sure everything plays as I want to.		
			#10;
			
		demo2 = 1;
		
			#10;
		
		demo2 = 0;
		
			#10;
			
		demo2 = 1;
		
			#10;
			
		demo2 = 0;
		
			#10;
			
		demo2 = 1;
		
			#10;
			
		demo2 = 0;
		
			#10;
			
		demo2 = 1;
		
			#10;
		
		demo2 = 0;
		
			#10;
			
		demo2 = 1;
		
			#10;
			
		demo2 = 0;
		
			#10;
			
		demo2 = 1;
		
			#10;
			
		demo2 = 0;
		
			#10;
			
		demo2 = 1;
		
			#10;
		
		demo2 = 0;
		
			#10;
			
		$finish;
	  	  end
endmodule