@Vending machine code

    .global main
    .extern printf
main:
    @@@ Print out "menu" of choices.
    LDR R0, =msg0
    BL printf
    LDR R0, =msg1
    BL printf
    LDR R0, =msg2
    BL printf
    LDR R0, =msg3
    BL printf
    LDR R0, =msg4
    BL printf
    @@@ Have user enter in their selection
    @@@ Store selection in variable select
    LDR R0, =inp
    LDR R1, =select
    BL scanf
    @@@ Prompt user for quantity
    LDR R0, =msg5
    BL printf
    @@@ Have user enter value into variable
    @@@ Quantity
    LDR R0, =inp
    LDR R1, =quantity
    BL scanf

    LDR R1, =select  @Address of var select
    LDR R1, [R1]     @Value of select in R1

	@Your modifications will begin at this point

	LDR R0, =msg6	@Final message
	
	CMP   R1, #1    @Check for "peanuts"
	MOVEQ R3, #75   @If user entered 1 set R3 to 75
	
	LDRLT R0, =msg7 @If user enters less than 1 set error
	BLLT  printf
	MOVLT R7, #1
	SWILT #0

	CMP   R1, #2    @Check for "chocolate"
	MOVEQ R3, #125  @If user entered 2 set R3 to 125

	CMP   R1, #3    @Check for "pretzels"
	MOVEQ R3, #90	@If user entered 3 set R3 to 90
	MOVGT R3, #1
	
	LDRGT R0, =msg7 @If we get here user entered
        BLGT  printf 	@an illegal selection so print
        MOVGT R7, #1 	@error message and terminate
	SWIGT #0        @Terminate, error condition

    LDR R4, =quantity @Get address of var quantity
    LDR R4, [R4]      @Value of quantity now in R4
    MUL R1, R3, R4    @Multiply number of cents times quantity
                      @and put result in R1
    BL printf
    MOV R7, #0
    SWI #0        @Normal exit

.data
select: .word 0
quantity: .word 0
msg0: .asciz "CSC2301 Vending machine!\n"
msg1: .asciz "Enter your choice:\n"
msg2: .asciz "1 for peanuts @ 75 cents\n"
msg3: .asciz "2 for chocolate @ $1.25\n"
msg4: .asciz "3 for pretzels @ 90 cents\n"
msg5: .asciz "Enter quantity\n";
msg6: .asciz "Your total is: %d cents\n";
msg7: .asciz "Illegal selection.  Goodbye\n"
inp: .asciz "%d"


