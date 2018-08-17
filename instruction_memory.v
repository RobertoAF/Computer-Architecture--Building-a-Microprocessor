module instruction_memory(input [7:0] addr, output reg [15:0] inst);
 
  reg [15:0] memory[255:0];  // 256 16-byte words of memory
  
  initial begin
    memory[0] <= 16'b0100_0001_0000_0011; // addi $r1, $r0, 3
    memory[1] <= 16'b0100_0010_0000_0000; // addi $r2, $r0, 0
    memory[2] <= 16'b0100_0011_0000_0001; // addi $r3, $r0, 1
    memory[3] <= 16'b1001_0000_0001_0110; // beqz $r1, +6 
    memory[4] <= 16'b0100_0100_0010_0000; // addi $r4, $r2, 0
    memory[5] <= 16'b0100_0010_0011_0000; // addi $r2, $r3, 0
    memory[6] <= 16'b0000_0011_0010_0100; // add $r3, $r2, $r4
    memory[7] <= 16'b0101_0001_0001_0001; // subi $r1, $r1, 1
    memory[8] <= 16'b1001_0000_0000_1011; // beqz $r0, -5
    memory[9] <= 16'b1100_0000_0011_0000; // halt $r3
  end
  
  always @(addr) begin
    inst = memory[addr];
  end
 
endmodule
