// Kyle Chong final project
// Defining the timescale for the entire code
`timescale 1ns/100ps	

//module, input, and output defining that I will use for the entire project
module instrument(
 input 						inc, ind, ine, inf, ing, ina, inb,						// This is the inputs of the 7 notes C-B
 input logic				demo, clk, demo2,												// Demo button and clock and demo clock (manual input) defining
 output logic 				outc, outd, oute, outf, outg, outa, outb, 			// This is the 7 LEDS that will correspond to the 7 notes
 output logic 				segA, segB, segC, segD, segE, segF, segG,				// First 7 bit display outputs for the note inputs 
 output logic				segA2, segB2, segC2, segD2, segE2, segF2, segG2		// Second 7 bit display for the demo outputs
 );
 
 //Defining the states for the demo
  enum logic [2:0]			{BASE		=	3'b000,
									 TINK1	=	3'b001,
									 TINK2	=	3'b010,
									 TINK3	=	3'b011,
									 TINK4	=	3'b100, 
									 TINK5	=	3'b101,
									 TINK6	=	3'b110,
									 TINK7	=	3'b111} PresentState, NextState;
									 
//t1 will be used as a case for determining what the 7 bit display output will be
  logic [2:0] t1;
 
 //making sure that it checks on a rising edge of a clock
 always_ff @ (posedge clk)
  begin
	
//This starts the demo playing
	 if (demo)
	 
	  PresentState <= NextState;
	 
//The else statement stops the demo from outputting anything
	 else
	 
	  PresentState <= BASE;
	
//The many if and else if statements lights up the LED and it also defines t1 to tell what should show up on the first display
   if (inc)
	 begin
	 
	 {outc, outd, oute, outf, outg, outa, outb, outc} = 7'b1000000;
	 t1 = 3'b000;
	 
	 end
	 
	else if (ind)
	 begin
	
	 {outc, outd, oute, outf, outg, outa, outb, outc} = 7'b0100000;
	 t1 = 3'b001;
	 
	 end
	 
	else if (ine)
	 begin
	
	 {outc, outd, oute, outf, outg, outa, outb, outc} = 7'b0010000;
	 t1 = 3'b010;
	 
	 end 
	 
	else if (inf)
	 begin
	
	 {outc, outd, oute, outf, outg, outa, outb, outc} = 7'b0001000;
	 t1= 3'b011;
	 
	 end
	 
	else if (ing)
	 begin
	
	 {outc, outd, oute, outf, outg, outa, outb, outc} = 7'b0000100;
	 t1 = 3'b100;
	 
	 end
	 
	else if (ina)
	 begin
	
	 {outc, outd, oute, outf, outg, outa, outb, outc} = 7'b0000010;
	 t1 = 3'b101;
	 
	 end
	 
	else if (inb)
	 begin
	 
	{outc, outd, oute, outf, outg, outa, outb, outc} = 7'b0000001;
	 t1 = 3'b110;
	 
	 end
	
//If none of the switches are pressed this function makes it so nothing shows up	
	else 
	 begin
	 
	  {outc, outd, oute, outf, outg, outa, outb, outc} = 7'b0000000;
	  t1 = 3'b111;
	  
	 end
	 
//Case to determine what is displayed
 case (t1)
 
//If somehow it does not match, nothign will show
  default:
  
   {segA, segB, segC, segD, segE, segF, segG} = 7'b1111111;
	
//Off state, nothing will show
  3'b111:
  
   {segA, segB, segC, segD, segE, segF, segG} = 7'b1111111;

//Display B  
  3'b110:
  
	 {segA, segB, segC, segD, segE, segF, segG} = 7'b0000000;
	 
//Display A	 
  3'b101:
  
    {segA, segB, segC, segD, segE, segF, segG} = 7'b0001000;
	 
//Display G	 
  3'b100:
  
    {segA, segB, segC, segD, segE, segF, segG} = 7'b0100000;
	 
//Display F	 
  3'b011:
   
    {segA, segB, segC, segD, segE, segF, segG} = 7'b0111000;
	 
//Display E	 
  3'b010:
  
    {segA, segB, segC, segD, segE, segF, segG} = 7'b0110000;
	 
//Display D	 
  3'b001:
  
    {segA, segB, segC, segD, segE, segF, segG} = 7'b0000001;
	 
//Display C	 
  3'b000:
  
    {segA, segB, segC, segD, segE, segF, segG} = 7'b0110001;
	 
  endcase
  
  end
  
//This function makes sure that whenever the falling edge of demo2 is pressed it updates 
  always_ff @ (negedge demo2)
  
   begin
	
//Case for the demo	
 case (PresentState)
 
//Default state that turns the display off 
  default:
  
  {segA2, segB2, segC2, segD2, segE2, segF2, segG2} = 7'b1111111;
 
//The first state where display is off and the next state will be the C
  BASE: 
  
   begin
	{segA2, segB2, segC2, segD2, segE2, segF2, segG2} = 7'b1111111;
	
//If demo clock is pressed it will go to the next state	
   if (!demo2)
	NextState <= TINK1;

//If nothing is pressed it will stay on the state	
	else 
	NextState <= PresentState;
	
	end
	
//Second state that should output a C. Will activate next step when clock is pressed.	
  TINK1:
   begin

   {segA2, segB2, segC2, segD2, segE2, segF2, segG2} = 7'b0110001;
	
	if (!demo2)
	NextState <= TINK2;
	
	else
	NextState <= PresentState;
	
	end
	
//Third state that will output a G. Will activate next step when clock is pressed.	
  TINK2:
   begin
	 
	{segA2, segB2, segC2, segD2, segE2, segF2, segG2} = 7'b0100000;
	
  	 if (!demo2)
	 NextState <= TINK3;
	 
	 else
	 NextState <= PresentState;
	 
	end
	
//Fourth state that will output a G. Will activate next step when clock is pressed.	
  TINK3:
   begin
	
	 {segA2, segB2, segC2, segD2, segE2, segF2, segG2} = 7'b0100000;
	 
	 if (!demo2)
	 NextState <= TINK4;
	 
	 else
	 NextState <= PresentState;
	 
	end
	
//Fifth state that should output a A. Will activate next step when clock is pressed.	
  TINK4:
   begin
	
	 {segA2, segB2, segC2, segD2, segE2, segF2, segG2} = 7'b0001000;
	 
	 if (!demo2)
	 NextState <= TINK5;
	 
	 else
	 NextState <= PresentState;
	
   end
	
//Sixth state that should output a A. Will activate next step when clock is pressed.	
  TINK5:
   begin
	
	 {segA2, segB2, segC2, segD2, segE2, segF2, segG2} = 7'b0001000;
	 
	 if (!demo2)
	 NextState <= TINK6;
	 
	 else
	 NextState <= PresentState;
	 
	end

//Seventh state that should output a G. Will activate next step when clock is pressed.	
  TINK6:
   begin
	
	 {segA2, segB2, segC2, segD2, segE2, segF2, segG2} = 7'b0100000;
	 
	 if (!demo2)
	 NextState <= TINK7;
	 
	 else
	 NextState <= PresentState;
	 
	end
	
//Eighth state that should output a G. Will go back to base when clock is pressed.	
  TINK7:
   begin
	 
	 {segA2, segB2, segC2, segD2, segE2, segF2, segG2} = 7'b0100000;
	 
	 if (!demo2)
	 NextState <= BASE;
	 
	 else
	 NextState <= PresentState;
	 
	end
	
  endcase
 end
 
//Some of the values have multiple of the same to make sure the output comes out since button can be funky sometimes.
 
endmodule
	