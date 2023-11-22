.data
string: .asciiz "123"      	# Null-terminated string "123"

.text
main:
    la $a0, string		        # Load the address of the string into $a0
    jal convertStringToInt	    # Call the main function
    move $a0, $v0           	# Move the result to $a0 for printing
    li $v0, 1              		# Set syscall code for printing integer
    syscall
    li $v0, 10              	# Set syscall code for exit
    syscall			            # Exit the program

convertStringToInt:
    addi $sp, $sp, -4       	# Allocate space on the stack
    sw $ra, ($sp)           	# Save the return address on the stack
    add $t6, $0, 0x30       	# Set $t6 to ASCII code for '0'
    add $t7, $0, 0x39       	# Set $t7 to ASCII code for '9'
    add $s0, $0, $0          	# Initialize result to 0
    add $t0, $a0, $0         	# Set $t0 to the address of the string

loop:
    lb $t1, 0($t0)          	# Load a byte from the string
    slt $t2, $t1, $t6       	# Check if the byte is less than '0'
    bne $t2, $0, done       	# If true, exit loop
    slt $t2, $t7, $t1       	# Check if the byte is greater than '9'
    bne $t2, $0, done       	# If true, exit loop
    sub $t1, $t1, $t6       	# Convert ASCII to integer
    beq $s0, $0, first      	# If $s0 is 0, go to first
    mul $s0, $s0, 10        	# Multiply result by 10

first:
    add $s0, $s0, $t1       	# Add the digit to the result
    addi $t0, $t0, 1       		# Move to the next character
    j loop                  	# Jump back to the beginning of the loop

done:
    add $v0, $s0, $0        	# Set $v0 to the final result
    lw $ra, ($sp)           	# Restore the return address
    addi $sp, $sp, 4        	# Deallocate space on the stack
    jr $ra                  	# Jump back to the calling function
