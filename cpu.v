module cpu(input [9:0] SW, output [9:0] LEDR);
	// Declare wires to connect the different module instances.
	wire [7:0] pc_in;	// input to PC, output of PC ALU
	wire [7:0] pc_out;	// output of PC, input to instruction_memory
	wire [7:0] alu_result;	// result of main ALU
	wire [15:0] instruction_memory_out; // output of instruction_memory
	wire [7:0] register_file_data1_out;	// output of register data 1
	wire [7:0] register_file_data2_out;	// output of register data 2
	wire [7:0] mux2_out;	// output of mux2
	wire [7:0] mux3_out;	// output of mux3
	wire [7:0] sign_extender_out;	// output of sign extender
 
	// Control bits
	wire RegWrite;
	wire [1:0] AluSrc;
	wire Branch;
	wire [1:0] AluOp;
	wire Continue;
	wire Mux2Control;  //  mux2 control
 	
	// LED outputs
	assign LEDR[3:0] = pc_out[3:0];
	assign LEDR[8:4] = alu_result[4:0];
	assign LEDR[9] = Continue;
 	
	// Create and connect modules.
	pc(pc_in, SW[9], Continue, pc_out);
	instruction_memory(pc_out, instruction_memory_out);
	control_unit(instruction_memory_out[15:12], RegWrite, AluSrc, AluOp, Branch, Continue);
	register_file(instruction_memory_out[7:4],
	instruction_memory_out[3:0],
	instruction_memory_out[11:8],
	alu_result, SW[9], RegWrite,
	register_file_data1_out,
	register_file_data2_out);
	sign_extender(instruction_memory_out[3:0], sign_extender_out);
	mux3(AluSrc, register_file_data2_out, sign_extender_out, 0, mux3_out);	// C = 0
	alu(AluOp, register_file_data1_out, mux3_out, alu_result, Zero);
	assign Mux2Control=(Branch+Zero==2)? 1:0;	// Check if combined branch and 
							// Zero control signals are both 1.
	mux2(Mux2Control, 1, sign_extender_out, mux2_out);
	alu(0, pc_out, mux2_out, pc_in, x);		// No AluOp control input.
                                            		// No Zero wire output.
