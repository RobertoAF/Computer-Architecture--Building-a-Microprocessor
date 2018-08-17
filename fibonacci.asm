addi $r1, $r0, 3		# Argument is 3.                    		0100 0001 0000 0011
addi $r2, $r0, 0		# Initialize prev1 to 0.            		0100 0010 0000 0000
addi $r3, $r0, 1		# Initialize current to 1.            		0100 0011 0000 0001
 
beqz $r1, +6    		# If counter has reached 0, end.        	1001 0000 0001 0110
addi $r4, $r2, 0		# Initialize prev2 to prev1.        		0100 0100 0010 0000
addi $r2, $r3, 0		# Update prev1.                        		0100 0010 0011 0000
add $r3, $r2, $r4		# Update current with sum of prev2    		0000 0011 0010 0100
                		# and prev1.                    	
subi $r1, $r1, 1		# Decrement counter.                		0101 0001 0001 0001
beqz $r0, -5    		# Branch to top of loop.            		1001 0000 0000 1011
 
halt $r3        		# Halt, outputting value of current.		1100 0000 0011 0000
