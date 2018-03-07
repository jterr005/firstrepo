;=================================================
; Name: Jason Terrazas
; Email: jterr005@ucr.edu
;
; Assignment name: Assignment 5
; Lab section: <022>
;
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
LOOP_3000
LD R0, MENUSUB
JSRR R0

;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

ADD R3, R1, #-1
	BRz FIRST_SUB
ADD R3, R1, #-2
	BRz	SECOND_SUB
ADD R3, R1, #-3
	BRz THIRD_SUB
ADD R3, R1, #-4
	BRz FOURTH_SUB
ADD R3, R1, #-5
	BRz FIFTH_SUB
ADD R3, R1, #-6
	BRz SIXTH_SUB
ADD R3, R1, #-7
	BRz END_PROGRAM
	BR LOOP_3000

FIRST_SUB
	LD R0, ALL_MACHINES_BUSY
	JSRR R0
	BR LOOP_3000
SECOND_SUB
	LD R0, ALL_MACHINES_FREE
	JSRR R0
	BR LOOP_3000
THIRD_SUB
	LD R0, NUM_BUSY
	JSRR R0
	BR LOOP_3000
FOURTH_SUB
	LD R0, NUM_FREE
	JSRR R0
	BR LOOP_3000
FIFTH_SUB
	LD R0, MACHINE_STATUS
	JSRR R0
	BR LOOP_3000
SIXTH_SUB
	LD R0, FIRST_FREE
	JSRR R0
	BR LOOP_3000

END_PROGRAM
LEA R0, Goodbye
PUTS

HALT

;---------------
;Data
;---------------
;Add address for subroutines (just testing for now)
MENUSUB	.FILL	x3200
ALL_MACHINES_BUSY	.FILL	x3600
ALL_MACHINES_FREE	.FILL	x3800
NUM_BUSY	.FILL x4000
NUM_FREE	.FILL	x4200
MACHINE_STATUS	.FILL x4400
FIRST_FREE	.FILL	x4600

;Other data

;Strings for options
Goodbye .Stringz "Goodbye!\n"
ALLNOTBUSY .Stringz "Not all machines are busy\n"
ALLBUSY .Stringz "All machines are busy\n"
FREE .STRINGZ "All machines are free\n"
NOTFREE .STRINGZ "Not all machines are free\n"
BUSYMACHINE1 .STRINGZ "There are "
BUSYMACHINE2 .STRINGZ " busy machines\n"
FREEMACHINE1 .STRINGZ "There are "
FREEMACHINE2 .STRINGZ " free machines\n"
STATUS1 .STRINGZ "Machine "
STATUS2  .STRINGZ " is busy\n"
STATUS3 .STRINGZ " is free\n"
FIRSTFREE .STRINGZ "The first available machine is number "
FIRSTFREE2 .STRINGZ "\n"
FIRSTFREE3 .STRINGZ "No machines are free\n"


;------------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;------------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
;HINT back up

.ORIG x3200
ST R0, R0_BACKUPSTATE3400
ST R2, R2_BACKUPSTATE3400
ST R3, R3_BACKUPSTATE3400
ST R4, R4_BACKUPSTATE3400
ST R5, R5_BACKUPSTATE3400
ST R6, R6_BACKUPSTATE3400
ST R7, R7_BACKUPSTATE3400

COMEBACK
LD R0, Menu_string_addr
PUTS
LD R4, UPPERPLACEMENT
LD R5, LOWERPLACEMENT
AND R2, R2, #0
GETC
ADD R1, R0, #0
ADD R1, R1, R5
ADD R2, R2, #1


VALID_CHARACTER
	ADD R3, R0, R4
	BRp INVALID_CHAR
	ADD R3, R0, R5
	BRn INVALID_CHAR
	ADD R3, R0, #-10
	BRz INVALID_CHAR

OUT

BR VALID

INVALID_CHAR
	ADD R5, R2, #-1
	BRnp VALID
	ADD R6, R6, R0
	ADD R6, R0, #-10
	BRz HOP_3400
	OUT
	HOP_3400
	LEA R0, Error_message_1
	PUTS
	BR COMEBACK

VALID
	LEA R0, NEWLINE
	PUTS

;HINT Restore

LD R0, R0_BACKUPSTATE3400
LD R2, R2_BACKUPSTATE3400
LD R3, R3_BACKUPSTATE3400
LD R4, R4_BACKUPSTATE3400
LD R5, R5_BACKUPSTATE3400
LD R6, R6_BACKUPSTATE3400
LD R7, R7_BACKUPSTATE3400

RET

;--------------------------------
;Data for subroutine MENU
;--------------------------------
LOWERPLACEMENT	.FILL #-48
UPPERPLACEMENT	.FILL	#-55
R0_BACKUPSTATE3400 .BLKW #1
R2_BACKUPSTATE3400 .BLKW #1
R3_BACKUPSTATE3400 .BLKW #1
R4_BACKUPSTATE3400 .BLKW #1
R5_BACKUPSTATE3400 .BLKW #1
R6_BACKUPSTATE3400 .BLKW #1
R7_BACKUPSTATE3400 .BLKW #1
Error_message_1 .STRINGZ "\nINVALID INPUT\n"
Menu_string_addr .FILL x6000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
;HINT back up

.ORIG x3600
ST R0, R0_BACKUPSTATE3600
ST R1, R1_BACKUPSTATE3600
ST R3, R3_BACKUPSTATE3600
ST R4, R4_BACKUPSTATE3600
ST R5, R5_BACKUPSTATE3600
ST R6, R6_BACKUPSTATE3600
ST R7, R7_BACKUPSTATE3600
LD R6, BUSYNESS_ADDR_ALL_MACHINES_BUSY
LDR R2, R6, #0
LD R3, INCREMENT_3600
LD R5, MASKVAL_3600

ALL_BUSY_CHECK
	AND R4, R2, R5
	BRn DISCOVER_EMPTY
	ADD R2, R2, R2
	ADD R3, R3, #-1
	BRp ALL_BUSY_CHECK
	AND R2, R2, #0
	LD R2, SINGLE_3600
	BR HOP_3600

DISCOVER_EMPTY
	LD R2, RESET_3600

HOP_3600
	ADD R2, R2, #0
	BRp BUSYMACHINE
	LEA R0, ALLNOTBUSY
	PUTS
	BR	HOP2_3600
	BUSYMACHINE
	LEA R0, ALLBUSY
	PUTS

;HINT Restore

HOP2_3600
	LD R0, R0_BACKUPSTATE3600
	LD R1, R1_BACKUPSTATE3600
	LD R3, R3_BACKUPSTATE3600
	LD R4, R4_BACKUPSTATE3600
	LD R5, R5_BACKUPSTATE3600
	LD R6, R6_BACKUPSTATE3600
	LD R7, R7_BACKUPSTATE3600

RET

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
INCREMENT_3600 	.FILL #16
SINGLE_3600	.FILL #1
RESET_3600	.FILL	#0
MASKVAL_3600	.FILL	xD000
R0_BACKUPSTATE3600 .BLKW #1
R1_BACKUPSTATE3600 .BLKW #1
R3_BACKUPSTATE3600 .BLKW #1
R4_BACKUPSTATE3600 .BLKW #1
R5_BACKUPSTATE3600 .BLKW #1
R6_BACKUPSTATE3600 .BLKW #1
R7_BACKUPSTATE3600 .BLKW #1
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
;HINT back up

.ORIG x3800
ST R0, R0_BACKUPSTATE3800
ST R1, R1_BACKUPSTATE3800
ST R3, R3_BACKUPSTATE3800
ST R4, R4_BACKUPSTATE3800
ST R5, R5_BACKUPSTATE3800
ST R6, R6_BACKUPSTATE3800
ST R7, R7_BACKUPSTATE3800
LD R6, BUSYNESS_ADDR_ALL_MACHINES_FREE
LDR R2, R6, #0
LD R3, INCREMENT_3800
LD R4, MASKVAL_3800

ALL_FREE_CHECK
	AND R5, R2, R4
	BRzp DISCOVER_BUSY
	ADD R2, R2, R2
	ADD R3, R3, #-1
	BRp ALL_FREE_CHECK
	AND R2, R2, #0
	LD R2, SINGLE_3800
	BR HOP_3800

DISCOVER_BUSY
	LD R2, SINGLE_3800
	HOP_3800
	ADD R2, R2, #0
	BRp RELEASE_ALL
	LEA R0, NOTFREE
	PUTS
	BR HOP2_3800

RELEASE_ALL
	LEA R0, FREE
	PUTS

;HINT Restore

HOP2_3800
	LD R0, R0_BACKUPSTATE3800
	LD R1, R1_BACKUPSTATE3800
	LD R3, R3_BACKUPSTATE3800
	LD R4, R4_BACKUPSTATE3800
	LD R5, R5_BACKUPSTATE3800
	LD R6, R6_BACKUPSTATE3800
	LD R7, R7_BACKUPSTATE3800

RET

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
INCREMENT_3800 	.FILL #16
SINGLE_3800	.FILL #1
RESET_3800	.FILL	#0
MASKVAL_3800	.FILL	xD000
R0_BACKUPSTATE3800 .BLKW #1
R1_BACKUPSTATE3800 .BLKW #1
R3_BACKUPSTATE3800 .BLKW #1
R4_BACKUPSTATE3800 .BLKW #1
R5_BACKUPSTATE3800 .BLKW #1
R6_BACKUPSTATE3800 .BLKW #1
R7_BACKUPSTATE3800 .BLKW #1
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
;HINT back up

.ORIG x4000
ST R0, R0_BACKUPSTATE4000
ST R1, R1_BACKUPSTATE4000
ST R3, R3_BACKUPSTATE4000
ST R4, R4_BACKUPSTATE4000
ST R5, R5_BACKUPSTATE4000
ST R6, R6_BACKUPSTATE4000
ST R7, R7_BACKUPSTATE4000
LD R6, BUSYNESS_ADDR_NUM_BUSY_MACHINES
LDR R2, R6, #0
LD R3, INCREMENT_4000
LD R4, RESET_4000
LD R1, MASKVAL_4000

DOCUMENT_BUSY_MACHINES
	AND R5, R2, R1
	BRzp COUNT_BUSY_MACHINES

DOCUMENT2_BUSY_MACHINES
	ADD R2, R2, R2
	ADD R3, R3, #-1
	BRp DOCUMENT_BUSY_MACHINES
	BR	HOP_4000

COUNT_BUSY_MACHINES
	ADD R4, R4, #1
	BR DOCUMENT2_BUSY_MACHINES

HOP_4000
	AND R2, R2, #0
	ADD R2, R4, #0
	LEA R0, BUSYMACHINE1
	PUTS
	AND R6, R6, #0
	ADD R6, R2, #0
	LD R0, PRINTR_NUM4000
	JSRR R0
	LEA R0, BUSYMACHINE2
	PUTS

;HINT Restore

LD R0, R0_BACKUPSTATE4000
LD R1, R1_BACKUPSTATE4000
LD R3, R3_BACKUPSTATE4000
LD R4, R4_BACKUPSTATE4000
LD R5, R5_BACKUPSTATE4000
LD R6, R6_BACKUPSTATE4000
LD R7, R7_BACKUPSTATE4000
RET

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
OFFSET_FROM_MIGOS_AYE_4000	.FILL	#48
INCREMENT_4000	.FILL	#16
RESET_4000	.FILL #0
PRINTR_NUM4000 .FILL x5000
MASKVAL_4000	.FILL	xD000
R0_BACKUPSTATE4000 .BLKW #1
R1_BACKUPSTATE4000 .BLKW #1
R3_BACKUPSTATE4000 .BLKW #1
R4_BACKUPSTATE4000 .BLKW #1
R5_BACKUPSTATE4000 .BLKW #1
R6_BACKUPSTATE4000 .BLKW #1
R7_BACKUPSTATE4000 .BLKW #1
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xD000


;------------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free
;------------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
;HINT back up

.ORIG x4200
ST R0, R0_BACKUPSTATE4200
ST R1, R1_BACKUPSTATE4200
ST R3, R3_BACKUPSTATE4200
ST R4, R4_BACKUPSTATE4200
ST R5, R5_BACKUPSTATE4200
ST R6, R6_BACKUPSTATE4200
ST R7, R7_BACKUPSTATE4200
LD R6, BUSYNESS_ADDR_NUM_FREE_MACHINES
LDR R2, R6, #0
LD R3, INCREMENT_4200
LD R4, RESET_4200
LD R1, MASKVAL_4200

FREE_MACHINES_COUNTER
	AND R5, R2, R1
	BRn COUNT_FREE

FREE2_MACHINES_COUNTER
	ADD R2, R2, R2
	ADD R3, R3, #-1
	BRp FREE_MACHINES_COUNTER
	BR	HOP_4200

COUNT_FREE
	ADD R4, R4, #1
	BR FREE2_MACHINES_COUNTER

HOP_4200
	AND R2, R2, #0
	ADD R2, R4, #0
	LD R3, OFFSET_FROM_MIGOS_AYE_4200
	LEA R0, FREEMACHINE1
	PUTS
	AND R6, R6, #0
	ADD R6, R4, #0
	LD R0, PRINTR_NUM4200
	JSRR R0
	LEA R0, FREEMACHINE2
	PUTS

;HINT Restore

LD R0, R0_BACKUPSTATE4200
LD R1, R1_BACKUPSTATE4200
LD R3, R3_BACKUPSTATE4200
LD R4, R4_BACKUPSTATE4200
LD R5, R5_BACKUPSTATE4200
LD R6, R6_BACKUPSTATE4200
LD R7, R7_BACKUPSTATE4200

RET

;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
MASKVAL_4200	.Fill	xFFFF
PRINTR_NUM4200	.Fill	x5000
RESET_4200	.Fill #0
INCREMENT_4200	.Fill	#16
OFFSET_FROM_MIGOS_AYE_4200	.Fill	#48
R0_BACKUPSTATE4200 .BLKW #1
R1_BACKUPSTATE4200 .BLKW #1
R3_BACKUPSTATE4200 .BLKW #1
R4_BACKUPSTATE4200 .BLKW #1
R5_BACKUPSTATE4200 .BLKW #1
R6_BACKUPSTATE4200 .BLKW #1
R7_BACKUPSTATE4200 .BLKW #1
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xD000


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.ORIG x4400

;HINT back up

ST R0,R0_BACKUPSTATE4400
ST R1,R1_BACKUPSTATE4400
ST R2,R2_BACKUPSTATE4400
ST R3,R3_BACKUPSTATE4400
ST R4,R4_BACKUPSTATE4400
ST R5,R5_BACKUPSTATE4400
ST R6,R6_BACKUPSTATE4400
ST R7,R7_BACKUPSTATE4400
LD R0, PRINTER_INTPUT
JSRR R0
ADD R6, R1, #0
ADD R2, R1, #0
LEA R0, STATUS1
PUTS

ADD R4, R2, #0
LD R0, PRINTER_OUTPUT_4400
JSRR R0
LD R5, MASKVAL_4400

LSB_TESTER
	ADD R1, R1, #0
	BRnz KILL_LSB_TESTER
	ADD R5, R5, R5
	ADD R1, R1, #-1
	BR LSB_TESTER

KILL_LSB_TESTER
	LD R1, BUSYNESS_ADDR_MACHINE_STATUS
	LDR R1, R1, #0
	AND R1, R5, R1
	BRnp EMPTY_SLOT_DISCOVERED
	AND R2, R2, #0
	LEA R0, STATUS2
	PUTS
	BR KILL_CHECKING

EMPTY_SLOT_DISCOVERED
	LEA R0, STATUS3
	PUTS

;HINT Restore

KILL_CHECKING
	LD R0, R0_BACKUPSTATE4400
	LD R1, R1_BACKUPSTATE4400
	LD R2, R2_BACKUPSTATE4400
	LD R3, R3_BACKUPSTATE4400
	LD R4, R4_BACKUPSTATE4400
	LD R5, R5_BACKUPSTATE4400
	LD R6, R6_BACKUPSTATE4400
	LD R7, R7_BACKUPSTATE4400

	RET


;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
PRINTER_OUTPUT_4400	.FILL	x5000
PRINTER_INTPUT_4400	.FILL	x4600
MASKVAL_4400	.FILL 	x0001
R0_BACKUPSTATE4400	.BLKW #1
R1_BACKUPSTATE4400	.BLKW #1
R2_BACKUPSTATE4400	.BLKW #1
R3_BACKUPSTATE4400	.BLKW #1
R4_BACKUPSTATE4400	.BLKW #1
R5_BACKUPSTATE4400	.BLKW #1
R6_BACKUPSTATE4400	.BLKW #1
R7_BACKUPSTATE4400	.BLKW #1
BUSYNESS_ADDR_MACHINE_STATUS.Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition:
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.ORIG x4600

;HINT back up

ST R0, R0_BACKUPSTATE4600
ST R1, R1_BACKUPSTATE4600
ST R3, R3_BACKUPSTATE4600
ST R4, R4_BACKUPSTATE4600
ST R5, R5_BACKUPSTATE4600
ST R6, R6_BACKUPSTATE4600
ST R7, R7_BACKUPSTATE4600
AND R2, R2, #0
AND R1, R1, #0
AND R4, R4, #0
AND R2,R2,#0
AND R1,R1,#0
LD R1, INCREMENTER_4600
LD R5, MASKVAL_4600
LD R4,BUSYNESS_ADDR_FIRST_FREE
LDR R4,R4,#0

LEFTSHIFT_4400
    AND R3,R4,R5
    BRnp END_SHIFT_4400
    ADD R5,R5,R5
    ADD R2,R2,#1
   ADD R1,R1,#-1
   BRz END_SHIFT_4400
   BR LEFTSHIFT_4400

END_SHIFT_4400
	ADD R1,R1,#0
	BRnp FREE_FOUND
	LEA R0,FIRSTFREE3
	PUTS
	BR END_PRINT

FREE_FOUND
	LEA R0,FIRSTFREE
	PUTS
	ADD R6,R2,#0
	ADD R4,R2,#0
	LD R0,NUM_PRINTER
	JSRR R0
	LEA R0, FIRSTFREE2
	PUTS

;HINT Restore

END_PRINT
	LD R0, R0_BACKUPSTATE4600
	LD R1, R1_BACKUPSTATE4600
	LD R3, R3_BACKUPSTATE4600
	LD R4, R4_BACKUPSTATE4600
	LD R5, R5_BACKUPSTATE4600
	LD R6, R6_BACKUPSTATE4600
	LD R7, R7_BACKUPSTATE4600

	RET

;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
NUM_PRINTER	.Fill	x5000
MASKVAL_4600	.Fill	x0001
INCREMENTER_4600	.Fill	#16
OFFSET_FROM_MIGOS_AYE_4600	.Fill	#48
R0_BACKUPSTATE4600 .BLKW #1
R1_BACKUPSTATE4600 .BLKW #1
R3_BACKUPSTATE4600 .BLKW #1
R4_BACKUPSTATE4600 .BLKW #1
R5_BACKUPSTATE4600 .BLKW #1
R6_BACKUPSTATE4600 .BLKW #1
R7_BACKUPSTATE4600 .BLKW #1
BUSYNESS_ADDR_FIRST_FREE .Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition:
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine
;--------------------------------
.ORIG x4600

;Backup

ST R0, R0_BACKUPSTATE4800
ST R2, R2_BACKUPSTATE4800
ST R3, R3_BACKUPSTATE4800
ST R4, R4_BACKUPSTATE4800
ST R5, R5_BACKUPSTATE4800
ST R6, R6_BACKUPSTATE4800
ST R7, R7_BACKUPSTATE4800
LEA R0, prompt
PUTS

BR BEGINNING ;Starts it all off aka hops to branch

ERROR_MES		;Re-prompts the user for new input
	OUT
	AND R1, R1, #0
	ADD R1, R1, R0
	ADD R1, R0, #-10
	BRz HOP_4800
	LEA R0, NEWLINE_3
	PUTS
	HOP_4800
		THIS_BRANCH_4800
			LEA R0, Error_message_2
			PUTS
			LEA R0, prompt
			PUTS
			AND R0, R0, #0
			AND R1, R1, #0
			AND R2, R2, #0
			AND R3, R3, #0
			AND R4, R4, #0
			AND R5, R5, #0
			AND R6, R6, #0

BEGINNING
  LD R6, COUNTER
  AND R0, R0, #0
  AND R1, R1, #0
  AND R5, R5, #0

	WHILE_LOOP
  	GETC

  	NEGATIVE_SIGN
    	LD R3, SUB_SIGN
    	ADD R4, R0, R3
    	BRz VALID_NEGATIVE

  	POSITIVE_SIGN
    	LD R3, ADD_SIGN
    	ADD R4, R0, R3
    	BRz VALID_POSITIVE

  	ENTER_KEY
    	LD R3, INPUT_CHAR
    	ADD R4, R0, R3
    	BRz VALID_ENTER

  	INVALID_CHAR_2
    	LD R3, RESET_2_-48
    	ADD R4, R0, R3
    	BRn ERROR_MES
    	LD R3, RESET_2_-57
    	ADD R4, R0, R3
    	BRp ERROR_MES
  		AND R4, R4, #0
			OUT
			LD R3, RESET_2_-48
  		ADD R0, R0, R3
			ADD R6, R6, #0
    	BRnp MULTIPLY
    	ADD R4, R4, R0
    	ADD R5, R5, R0
			BR END_LOOPING

MULTIPLY
  ADD R4, R5, #0
  LD R3, RESET_10_4800
  ADD R5, R0, #0

LOOPING
  ADD R5, R5, R4
  ADD R3, R3, #-1
  BRp LOOPING

END_LOOPING
	ADD R6, R6, #1
	BR WHILE_LOOP


END_WHILE_LOOP

BR JUMP

VALID_NEGATIVE
  LD R1, RESET_2_1
  ADD R6, R6, #0
  BRp ERROR_MES
  ADD R6, R6, #1
  ADD R5, R5, #0
  BRp ERROR_MES
	LD R3, SUB_SIGN
  ADD R4, R3,#0
  BRz ERROR_MES
  OUT
  BR WHILE_LOOP

VALID_POSITIVE
  AND R1, R1, #0
  ADD R6, R6, #0
  BRnp ERROR_MES
  ADD R6, R6, #1
  ADD R5, R5, #0
  BRp ERROR_MES
  LD R3, ADD_SIGN
  ADD R4, R3, #0
  BRz ERROR_MES
  OUT
  BR WHILE_LOOP

VALID_ENTER
  ADD R6,R6, #0
  BRz ERROR_MES

JUMP
	ADD R1, R1, #0
  BRp NEG_NUM
  BRnz END_NEG_NUM

NEG_NUM
  NOT R5, R5
  ADD R5, R5, #1

END_NEG_NUM
	LEA R0, NEWLINE
	PUTS
	AND R3, R3, #0
	ADD R3, R5, #-9
	ADD R3, R3, #-6
	BRp THIS_BRANCH_4800
	AND R1, R1, #0
	ADD R1, R5, #0
	BRn THIS_BRANCH_4800

;Restore

LD R0, R0_BACKUPSTATE4800
LD R2, R2_BACKUPSTATE4800
LD R3, R3_BACKUPSTATE4800
LD R4, R4_BACKUPSTATE4800
LD R5, R5_BACKUPSTATE4800
LD R6, R6_BACKUPSTATE4800
LD R7, R7_BACKUPSTATE4800
RET


;--------------------------------
;Data for subroutine Get input
;--------------------------------
INPUT_CHAR .FILL #-10
COUNTER .FILL #0
RESET_2_-48 .FILL #-48
RESET_2_-57 .FILL #-57
RESET_2_1 .FILL #1
RESET_10_4800 .FILL #10
SUB_SIGN .FILL #-45
ADD_SIGN .FILL #-43
;ARRAY .BLKW #10
R0_BACKUPSTATE4800 .BLKW #1
R2_BACKUPSTATE4800 .BLKW #1
R3_BACKUPSTATE4800 .BLKW #1
R4_BACKUPSTATE4800 .BLKW #1
R5_BACKUPSTATE4800 .BLKW #1
R6_BACKUPSTATE4800 .BLKW #1
R7_BACKUPSTATE4800 .BLKW #1
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_message_2 .STRINGZ "ERROR INVALID INPUT\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs:
; Postcondition:
; The subroutine prints the number that is in
; Return Value :
; NOTE: This subroutine should print the number to the user WITHOUT
;		leading 0's and DOES NOT output the '+' for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine
;--------------------------------

;--------------------------------
;Data for subroutine print number
;--------------------------------

.ORIG x5000
ST R0, R0_BACKUP5000
ST R1, R1_BACKUP5000
ST R3, R3_BACKUP5000
ST R4, R4_BACKUP5000
ST R5, R5_BACKUP5000
ST R6, R6_BACKUP5000
ST R7, R7_BACKUP5000
AND R5, R5, #0
ADD R5, R4, #0
ADD R1, R6, #-9
BRnz SINGLE_DIGIT


PRINTING_NUM
  AND R1, R1, #0
  AND R2, R2, #0

  FIRST_DIGIT
    LD R5, DEC_10000 		;set r5 to -10000
    ADD R4, R4, R5 		;subtract num from 10000
    BRn INVALID 		;if it goes into negatives, undo it
      ADD R1, R1, #1 	;else add 1 to digit counter
      BR FIRST_DIGIT
    INVALID
      LD R5, PDEC_10000 	;add 10000 back in
			ADD R4, R4, R5

		PRINTFIRST_DIGIT
		AND R0, R0, #0
		LD R5, CONVERTER	;load ascii conversion into r5
			ADD R2, R2, #0
			BRp PRINTDIGIT1
				ADD R0, R1, #0
				BRz SKIP1
			PRINTDIGIT1
	    AND R0, R0, #0
			ADD R0, R1, #0
			ADD R2, R2, #1
			ADD R0, R0, R5
		 	OUT		;print

	SKIP1

  AND R1, R1, #0

	SECOND_DIGIT
		LD R5, DEC_1000
		ADD R4, R4, R5
		BRn INVALID2
			ADD R1, R1, #1 		;else add 1 to digit
			BR SECOND_DIGIT
		INVALID2
			LD R5, PDEC_1000
			ADD R4, R4, R5

		PRINTSECOND_DIGIT
			AND R0, R0,  #0
			LD R5, CONVERTER
			ADD R2, R2, #0
			BRp PRINTDIGIT2
				ADD R0, R1, #0
				BRz SKIP2
			PRINTDIGIT2
		  AND R0, R0, #0
			ADD R0, R1, #0
			ADD R2, R2, #1
			ADD R0, R0, R5
		 	OUT		;print

	SKIP2

  AND R1, R1, #0

  THIRD_DIGIT
    LD R5, DEC_100
    ADD R4, R4, R5
    BRn INVALID3
      ADD R1, R1, #1 		;else add 1 to digit
      BR THIRD_DIGIT
    INVALID3
      LD R5, PDEC_100
      ADD R4, R4, R5

    PRINTTHIRD_DIGIT
      AND R0, R0,  #0
      LD R5, CONVERTER
      ADD R2, R2, #0
      BRp PRINTDIGIT3
        ADD R0, R1, #0
        BRz SKIP3
      PRINTDIGIT3
      AND R0, R0, #0
      ADD R0, R1, #0
      ADD R2, R2, #1
      ADD R0, R0, R5
      OUT		;print

  SKIP3

  AND R1, R1, #0

  FOURTH_DIGIT
    LD R5, DEC_10
    ADD R4, R4, R5
    BRn INVALID4
      ADD R1, R1, #1 		;else add 1 to digit
      BR FOURTH_DIGIT
    INVALID4
      LD R5, PDEC_10
      ADD R4, R4, R5

    PRINTFOURTH_DIGIT
      AND R0, R0,  #0
      LD R5, CONVERTER
      ADD R2, R2, #0
      BRp PRINTDIGIT4
        ADD R0, R1, #0
        BRz SKIP4
      PRINTDIGIT4
      AND R0, R0, #0
      ADD R0, R1, #0
      ADD R2, R2, #1
      ADD R0, R0, R5
      OUT		;print

  SKIP4

  AND R1, R1, #0
	LAST_DIGIT
		LD R5, DEC_1_2
		ADD R4, R4, R5
		BRn INVALID5
			ADD R1, R1, #1 		;else add 1 to digit
			BR LAST_DIGIT
		INVALID5
			LD R5, PDEC_1
			ADD R4, R4, R5

		PRINTDIGIT5
			AND R0, R0, #0
			LD R5, CONVERTER
			ADD R0, R1, #0
			ADD R0, R0, R5 		;convert from ascii to dec
		 	OUT
			BR END_PRINTING
SINGLE_DIGIT
AND R0, R0, #0
LD R5, CONVERTER
ADD R0, R2, R5
OUT

END_PRINTING

;Data for subroutine
LD R0, R0_BACKUP5000
LD R1, R1_BACKUP5000
LD R2, R2_BACKUP5000
LD R4, R4_BACKUP5000
LD R3, R3_BACKUP5000
LD R5, R5_BACKUP5000
LD R6, R6_BACKUP5000
LD R7, R7_BACKUP5000

RET

R0_BACKUP5000 .BLKW #1
R1_BACKUP5000 .BLKW #1
R2_BACKUP5000 .BLKW #1
R3_BACKUP5000 .BLKW #1
R4_BACKUP5000 .BLKW #1
R6_BACKUP5000 .BLKW #1
R5_BACKUP5000 .BLKW #1
R7_BACKUP5000 .BLKW #1
CONVERTER .FILL #48
POS_SIGN  .FILL '+'
NEG_SIGN  .FILL '-'
DEC_10000 .FILL #-10000
DEC_1000  .FILL #-1000
DEC_100   .FILL #-100
DEC_10    .FILL #-10
DEC_1_2     .FILL #-1
PDEC_10000 .FILL #10000
PDEC_1000  .FILL #1000
PDEC_100   .FILL #100
PDEC_10    .FILL #10
PDEC_1     .FILL #1


.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"
NEWLINE	.STRINGZ	"\n"

.ORIG xD000			; Remote data
BUSYNESS .FILL xABCD		; <----!!!VALUE FOR BUSYNESS VECTOR!!!

;---------------
;END of PROGRAM
;---------------
.END
