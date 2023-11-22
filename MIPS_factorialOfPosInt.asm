.data
prompt:     .asciiz "Enter a positive integer: "
result_msg: .asciiz "The factorial of the given integer "
is_msg: .asciiz " is "
newline:    .asciiz "\n"
space:      .asciiz " "
.text
.globl main
main:
    #Print the prompt to enter a positive integer
        li $v0, 4
        la $a0, prompt
        syscall

    #Read an integer from the user
        li $v0, 5
        syscall

    #Store the user input in $t0
        move $t0, $v0

    #Initialize $t1 to 1 (factorial result)
        li $t1, 1

    #Initialize $t2 to 1 (counter)
        li $t2, 1
loop:
    #Check if $t2 > $t0 (if counter > input)
        bgt $t2, $t0, done

    #Multiply the current factorial result ($t1) by the counter ($t2)
        mul $t1, $t1, $t2

    #Increment the counter ($t2)
        addi $t2, $t2, 1

    #Repeat the loop
    j loop
done:
    #Print the result message
        li $v0, 4
        la $a0, result_msg
        syscall

    #Display input value
        li $v0, 1
        move $a0, $t0
        syscall

    #Display " is "
        li $v0, 4
        la $a0, is_msg
        syscall

    #Print the factorial result
        li $v0, 1
        move $a0, $t1
        syscall

    #Print a newline
        li $v0, 4
        la $a0, newline
        syscall

    #Exit the program
        li $v0, 10
        syscall
