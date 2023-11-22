.data
msg: .asciiz "Enter A Value For 'X' To Calculate The Polynomial '3x^5+2x^4-5x^3-x^2+7x-6': "
    .text
    .globl main
main:
    # Print the message
    la $a0, msg      # Load the address of the message into $a0
    li $v0, 4        # System call code for printing string
    syscall          # Invoke the system call to print the message

    # Read user input for x
    li $v0, 5        # System call code for reading an integer
    syscall          # Invoke the system call to read an integer

    add $a0, $v0, $0  # Move the user input to $a0
    li $s0, 0         # Initialize the sum to 0

    li $a1, 3          # Load coefficient 3 into $a1
    li $a2, 5          # Load exponent 5 into $a2
    jal poly           # Call poly function with coefficient and exponent
    add $s0, $s0, $v0  # Accumulate the result of poly into $s0

    li $a1, 2          # Load coefficient 2 into $a1
    li $a2, 4          # Load exponent 4 into $a2
    jal poly           # Call poly function with coefficient and exponent
    add $s0, $s0, $v0  # Accumulate the result of poly into $s0

    li $a1, -5         # Load coefficient -5 into $a1
    li $a2, 3          # Load exponent 3 into $a2
    jal poly           # Call poly function with coefficient and exponent
    add $s0, $s0, $v0  # Accumulate the result of poly into $s0

    li $a1, -1         # Load coefficient -1 into $a1
    li $a2, 2          # Load exponent 2 into $a2
    jal poly           # Call poly function with coefficient and exponent
    add $s0, $s0, $v0  # Accumulate the result of poly into $s0

    li $a1, 7          # Load coefficient 7 into $a1
    li $a2, 1          # Load exponent 1 into $a2
    jal poly           # Call poly function with coefficient and exponent
    add $s0, $s0, $v0  # Accumulate the result of poly into $s0

    li $a1, -6         # Load coefficient -6 into $a1
    li $a2, 0          # Load exponent 0 into $a2
    jal poly           # Call poly function with coefficient and exponent
    add $s0, $s0, $v0  # Accumulate the result of poly into $s0
    
    # Print the result
    add $a0, $s0, $0  # Move the result to $a0
    li $v0, 1         # System call code for printing an integer
    syscall          # Invoke the system call to print the result

    # Exit program
    li $v0, 10        # System call code for program exit
    syscall          # Invoke the system call


poly: 
    # Save the return address and call the pow function
    move $s1, $ra     # Save the return address in $s1
    jal pow           # Jump and link to the pow function
    mul $v0, $v0, $a1 # Multiply the result of pow by $a1
    move $ra, $s1     # Restore the return address
    jr $ra            # Return to the caller

pow:
    bne $a2, 0, branch   # Branch to 'branch' if the exponent is not zero
    li $v0, 1         # If exponent is zero, result is 1
    jr $ra            # Return to the caller

branch:
    add $t0, $a2, $0  # Copy the exponent to $t0
    li $v0, 1         # Initialize the result to 1

powloop:
    mul $v0, $a0, $v0 # Multiply the result by the base
    addi $t0, $t0, -1 # Decrement the exponent
    bgt $t0, 0, powloop  # If exponent > 0, repeat the loop

    jr $ra            # Return to the caller
    
