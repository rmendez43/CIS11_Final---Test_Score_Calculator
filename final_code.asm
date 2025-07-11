; CIS 11 TEST SCORE CALCULATOR  
; RYAN MENDEZ 
; KEVIN MORRIS 
; EIKO FUKUSHIMA 
; APRAJITA

.ORIG x3000

; ---- Display welcome message ----

    LEA R0, WEL
    PUTS
    LD R0, NEWLINE
    OUT

; ---- Get and process 5 test grades ----
    ; For each grade:
    ; 1. Call GET_GRADE to read input
    ; 2. Store grade in GRADES array
    ; 3. Determine letter grade with GET_LETTER
    ; 4. Output letter grade using POP

    JSR GET_GRADE            ; Get first test score into R3
    LEA R6, GRADES           ; Load address of GRADES array into R6
    STR R3, R6, #0           ; Store score at GRADES[0]
    JSR GET_LETTER           ; Convert score to letter grade and display
    JSR POP                  ; Return from subroutine
    LD R0, NEWLINE           ; Load newline character
    OUT                      ; Output newline

    JSR GET_GRADE            ; Get second test score into R3
    LEA R6, GRADES           ; Load address of GRADES array into R6
    LD R5, ONE               ; Load value 1
    ADD R7, R6, R5           ; Calculate address GRADES[1]
    STR R3, R7, #0           ; Store score at GRADES[1]
    JSR GET_LETTER           ; Convert score to letter grade and display
    JSR POP                  ; Return from subroutine
    LD R0, NEWLINE           ; Load newline character
    OUT                      ; Output newline

    JSR GET_GRADE            ; Get third test score into R3
    LEA R6, GRADES           ; Load address of GRADES array into R6
    LD R5, TWO               ; Load value 2
    ADD R7, R6, R5           ; Calculate address GRADES[2]
    STR R3, R7, #0           ; Store score at GRADES[2]
    JSR GET_LETTER           ; Convert score to letter grade and display
    JSR POP                  ; Return from subroutine
    LD R0, NEWLINE           ; Load newline character
    OUT                      ; Output newline

    JSR GET_GRADE            ; Get fourth test score into R3
    LEA R6, GRADES           ; Load address of GRADES array into R6
    LD R5, THREE             ; Load value 3
    ADD R7, R6, R5           ; Calculate address GRADES[3]
    STR R3, R7, #0           ; Store score at GRADES[3]
    JSR GET_LETTER           ; Convert score to letter grade and display
    JSR POP                  ; Return from subroutine
    LD R0, NEWLINE           ; Load newline character
    OUT                      ; Output newline

    JSR GET_GRADE            ; Get fifth test score into R3
    LEA R6, GRADES           ; Load address of GRADES array into R6
    LD R5, FOUR              ; Load value 4
    ADD R7, R6, R5           ; Calculate address GRADES[4]
    STR R3, R7, #0           ; Store score at GRADES[4]
    JSR GET_LETTER           ; Convert score to letter grade and display
    JSR POP                  ; Return from subroutine
    LD R0, NEWLINE           ; Load newline character
    OUT                      ; Output newline

    ; Calculate and display statistics
    JSR CALCULATE_STATS
    HALT

; ============================
; Subroutine: CALCULATE_STATS
; Calculates and displays max, min, and average of test scores
; ============================

CALCULATE_STATS
    ST R7, SAVELOC1
    LEA R2, GRADES
    
    ; Initialize MIN, MAX, and SUM with first grade
    LDR R3, R2, #0          ; First grade
    ST R3, MAX_GRADE        ; Set as initial max
    ST R3, MIN_GRADE        ; Set as initial min
    ST R3, TOTAL_SUM        ; Start sum

    ; --- Process remaining grades (2–5) ---
    ; Each block loads a grade, updates sum, checks max/min
    ; The process is repeated for each grade index (1 to 4)
    
    LDR R4, R2, #1           ; Load grade 2 from GRADES into R4
    LD R5, TOTAL_SUM         ; Load current total sum
    ADD R5, R5, R4           ; Add grade 2 to total sum
    ST R5, TOTAL_SUM         ; Store updated sum

    LD R5, MAX_GRADE         ; Load current max grade
    NOT R5, R5               ; Compute two's complement of max grade
    ADD R5, R5, #1           
    ADD R6, R4, R5           ; Compare grade 2 to max
    BRZP SKIP_MAX1           ; If grade ≤ max, skip update
    ST R4, MAX_GRADE         ; Else, update max grade
SKIP_MAX1

    LD R5, MIN_GRADE         ; Load current min grade
    NOT R4, R4               ; Compute two's complement of grade 2
    ADD R4, R4, #1           
    ADD R6, R5, R4           ; Compare min to grade
    BRZP SKIP_MIN1           ; If grade ≥ min, skip update
    LDR R4, R2, #1           ; Reload grade 2
    ST R4, MIN_GRADE         ; Update min grade
SKIP_MIN1

    ; The same comments above apply to grades 3-5 below

    LDR R4, R2, #2           ; Load grade 3
    LD R5, TOTAL_SUM         
    ADD R5, R5, R4           
    ST R5, TOTAL_SUM         

    LD R5, MAX_GRADE         
    NOT R5, R5               
    ADD R5, R5, #1           
    ADD R6, R4, R5           
    BRZP SKIP_MAX2           
    ST R4, MAX_GRADE         
SKIP_MAX2

    LD R5, MIN_GRADE         
    NOT R4, R4               
    ADD R4, R4, #1           
    ADD R6, R5, R4           
    BRZP SKIP_MIN2           
    LDR R4, R2, #2           
    ST R4, MIN_GRADE         
SKIP_MIN2

    LDR R4, R2, #3           ; Load grade 4
    LD R5, TOTAL_SUM         
    ADD R5, R5, R4           
    ST R5, TOTAL_SUM         

    LD R5, MAX_GRADE         
    NOT R5, R5               
    ADD R5, R5, #1           
    ADD R6, R4, R5           
    BRZP SKIP_MAX3           
    ST R4, MAX_GRADE         
SKIP_MAX3

    LD R5, MIN_GRADE         
    NOT R4, R4               
    ADD R4, R4, #1           
    ADD R6, R5, R4           
    BRZP SKIP_MIN3           
    LDR R4, R2, #3           
    ST R4, MIN_GRADE         
SKIP_MIN3

    LDR R4, R2, #4           ; Load grade 5
    LD R5, TOTAL_SUM         
    ADD R5, R5, R4           
    ST R5, TOTAL_SUM         

    LD R5, MAX_GRADE         
    NOT R5, R5               
    ADD R5, R5, #1           
    ADD R6, R4, R5           
    BRZP SKIP_MAX4           
    ST R4, MAX_GRADE         
SKIP_MAX4

    LD R5, MIN_GRADE         
    NOT R4, R4               
    ADD R4, R4, #1           
    ADD R6, R5, R4           
    BRZP SKIP_MIN4           
    LDR R4, R2, #4           
    ST R4, MIN_GRADE         
SKIP_MIN4

    LD R3, TOTAL_SUM         ; Load total of all grades
    AND R4, R4, #0           ; Clear R4 (quotient)
AVG_LOOP
    ADD R5, R3, #-5          ; Subtract 5
    BRN AVG_DONE             ; If < 0, exit loop
    ADD R3, R3, #-5          ; Subtract 5 from total
    ADD R4, R4, #1           ; Increment quotient
    BRnzp AVG_LOOP
AVG_DONE
    ST R4, AVERAGE_GRADE     ; Store average

    LEA R0, MIN              ; Load address of "MIN"
    PUTS                     ; Display "MIN"
    LD R3, MAX_GRADE         ; Load max grade into R3
    AND R1, R1, #0           ; Clear R1
    JSR BREAK_INT            ; Convert and display number
    LD R0, NEWLINE           
    OUT                      ; Output newline

    LEA R0, MAX              ; Load address of "MAX"
    PUTS                     ; Display "MAX"
    LD R3, MIN_GRADE         ; Load min grade into R3
    AND R1, R1, #0           
    JSR BREAK_INT            
    LD R0, NEWLINE           
    OUT                      

    LEA R0, AVG              ; Load address of "AVG"
    PUTS                     ; Display "AVG"
    LD R3, AVERAGE_GRADE     ; Load average grade
    AND R1, R1, #0           
    JSR BREAK_INT            
    LD R0, NEWLINE           
    OUT                      

    LD R7, SAVELOC1          ; Restore R7
    RET                      ; Return from subroutine


; ========== Data ==========

WEL             .STRINGZ "TEST FIVE SCORES: (0 - 99)"   ; Welcome message to display
NEWLINE         .FILL x000A                             ; ASCII newline character
SPACE           .FILL x0020                             ; ASCII space character
DECODE_DEC      .FILL #-48                              ; Used to convert ASCII digit to numeric value
DECODE_SYM      .FILL #48                               ; Used to convert numeric value to ASCII digit
DECODE_THIRTY   .FILL #-30                              ; Helper constant (not clearly used here)
NUM_TESTS       .FILL #5                                ; Number of test scores to input
MAX_GRADE       .BLKW #1                                ; Memory space to store maximum grade
MIN_GRADE       .BLKW #1                                ; Memory space to store minimum grade
AVERAGE_GRADE   .BLKW #1                                ; Memory space to store average grade
TOTAL_SUM       .BLKW #1                                ; Memory space to store sum of all grades
GRADES          .BLKW #5                                ; Array to store 5 individual test scores
MIN             .STRINGZ "MIN "                         ; Label to display before printing minimum grade
MAX             .STRINGZ "MAX "                         ; Label to display before printing maximum grade
AVG             .STRINGZ "AVG "                         ; Label to display before printing average grade
ONE             .FILL #1                                ; Constant 1
TWO             .FILL #2                                ; Constant 2
THREE           .FILL #3                                ; Constant 3
FOUR            .FILL #4                                ; Constant 4
TEN             .FILL #10                               ; Constant 10 (used for division/multiplication)
NEG_ONE         .FILL #-1                               ; Constant -1

; ========== Save Locations ==========

SAVELOC1 .FILL x0000   ; Temporary storage for R7 (return address) or general-purpose registers
SAVELOC2 .FILL x0000   ; Another save location, commonly for R7 during subroutine calls
SAVELOC3 .FILL x0000   ; Used to save a register (often R3) during nested subroutine or validation
SAVELOC4 .FILL x0000   ; Used to store R2 or other temporary data
SAVELOC5 .FILL x0000   ; Used to store R1 or other temporary data

; ========== Subroutines ==========

GET_GRADE
    ST R7, SAVELOC1          ; Save return address
    JSR CLEAR_REG            ; Clear registers R1–R4
    LD R4, DECODE_DEC        ; Load decimal decoding offset (-48)
    GETC                     ; Get first character (tens digit)
    JSR VALIDATE2            ; Validate character is a digit
    OUT                      ; Echo character to screen
    ADD R1, R0, #0           ; Copy character to R1
    ADD R1, R1, R4           ; Convert ASCII to digit
    ADD R2, R2, #10          ; Set multiplier to 10

MULT10
    ADD R3, R3, R1           ; R3 += tens digit
    ADD R2, R2, #-1          ; Decrement counter
    BRP MULT10               ; Loop 10 times to multiply digit by 10

    GETC                     ; Get second character (ones digit)
    JSR VALIDATE2            ; Validate digit
    OUT                      ; Echo digit
    ADD R0, R0, R4           ; Convert ASCII to number
    ADD R3, R3, R0           ; Add ones digit to R3 (final grade)
    LD R0, SPACE             ; Load space character
    OUT                      ; Output space
    LD R7, SAVELOC1          ; Restore return address
    RET                      ; Return with grade in R3

BREAK_INT
    ST R7, SAVELOC2          ; Save return address
    LD R5, DECODE_SYM        ; Load ASCII base ('0')
    ADD R4, R3, #0           ; Copy grade to R4

DIV1
    ADD R1, R1, #1           ; Increment quotient
    ADD R4, R4, #-10         ; Subtract 10 from R4
    BRP DIV1                 ; Loop until remainder < 10

    ADD R1, R1, #-1          ; Adjust quotient
    ADD R4, R4, #10          ; Adjust remainder
    ADD R6, R4, #-10         ; Check if remainder is negative
    BRNP POS                 ; If not, continue

NEG
    ADD R1, R1, #1           ; Fix quotient
    ADD R4, R4, #-10         ; Fix remainder

POS
    ST R1, Q                 ; Store quotient
    ST R4, R                 ; Store remainder
    LD R0, Q                
    ADD R0, R0, R5           ; Convert to ASCII
    OUT                      ; Output tens digit
    LD R0, R
    ADD R0, R0, R5           ; Convert to ASCII
    OUT                      ; Output ones digit
    LD R7, SAVELOC2          ; Restore return address
    RET                      ; Return

Q .FILL X0                   ; Storage for quotient
R .FILL X0                   ; Storage for remainder

PUSH
    ST R7, SAVELOC3          ; Save return address
    JSR CLEAR_REG            ; Clear registers
    LD R6, POINTER           ; Load current stack pointer
    ADD R6, R6, #0           
    BRNZ STACK_ERROR         ; If stack pointer invalid, halt
    ADD R6, R6, #-1          ; Move stack pointer down
    STR R0, R6, #0           ; Store value at new location
    ST R6, POINTER           ; Update stack pointer
    LD R7, SAVELOC3          ; Restore return address
    RET
POINTER .FILL X4000          ; Initial top of stack address

POP
    LD R6, POINTER           ; Load current stack pointer
    ST R1, SAVELOC5          ; Save R1
    LD R1, BASELINE          ; Load bottom limit of stack
    ADD R1, R1, R6           
    BRZP STACK_ERROR         ; If below baseline, error
    LD R1, SAVELOC5          ; Restore R1
    LDR R0, R6, #0           ; Load top value into R0
    ST R7, SAVELOC4          ; Save R7
    OUT                      ; Output character
    LD R0, SPACE             
    OUT                      ; Output space
    ADD R6, R6, #1           ; Move stack pointer up
    ST R6, POINTER           ; Update pointer
    LD R7, SAVELOC4          ; Restore R7
    RET

STACK_ERROR
    LEA R0, ERROR            ; Load error message
    PUTS                     ; Print error
    HALT                     ; Halt execution

BASELINE .FILL XC000         ; Lowest legal stack address
ERROR    .STRINGZ "PROGRAM STOP" ; Error message

GET_LETTER
    AND R2, R2, #0           ; Clear R2

A_GRADE
    LD R0, A_NUM             ; Load A-grade threshold (e.g., -90)
    LD R1, A_LET             ; Load 'A' character
    ADD R2, R3, R0           ; Compare grade to threshold
    BRZP STR_GRADE           ; If grade >= threshold, use this letter

B_GRADE
    AND R2, R2, #0
    LD R0, B_NUM
    LD R1, B_LET
    ADD R2, R3, R0
    BRZP STR_GRADE

C_GRADE
    AND R2, R2, #0
    LD R0, C_NUM
    LD R1, C_LET
    ADD R2, R3, R0
    BRZP STR_GRADE

D_GRADE
    AND R2, R2, #0
    LD R0, D_NUM
    LD R1, D_LET
    ADD R2, R3, R0
    BRZP STR_GRADE

F_GRADE
    AND R2, R2, #0
    LD R0, F_NUM
    LD R1, F_LET
    ADD R2, R3, R0
    BRNZP STR_GRADE
    RET

STR_GRADE
    ST R7, SAVELOC1          ; Save return address
    AND R0, R0, #0           
    ADD R0, R1, #0           ; Move letter into R0
    JSR PUSH                 ; Push onto stack
    LD R7, SAVELOC1          ; Restore R7
    RET


A_NUM .FILL #-90   ; 90
A_LET .FILL X41    ; 'A'
B_NUM .FILL #-80
B_LET .FILL X42    ; 'B'
C_NUM .FILL #-70
C_LET .FILL X43    ; 'C'
D_NUM .FILL #-60
D_LET .FILL X44    ; 'D'
F_NUM .FILL #-50
F_LET .FILL X46    ; 'F'

CLEAR_REG
    AND R1, R1, #0       ; Clear R1
    AND R2, R2, #0       ; Clear R2
    AND R3, R3, #0       ; Clear R3
    AND R4, R4, #0       ; Clear R4
    AND R5, R5, #0       ; Clear R5
    AND R6, R6, #0       ; Clear R6
    RET                 ; Return to caller


VALIDATE2
    ST R1, SAVELOC5      ; Save R1
    ST R2, SAVELOC4      ; Save R2
    ST R3, SAVELOC3      ; Save R3
    LD R1, DATA_MIN      ; Load lower bound (-48)
    ADD R2, R0, R1       ; R2 = R0 - 48
    BRN FAIL             ; If R0 < 48, invalid input
    LD R1, DATA_MAX      ; Load upper bound (-57)
    ADD R3, R0, R1       ; R3 = R0 - 57
    BRP FAIL             ; If R0 > 57, invalid input
    LD R1, SAVELOC5      ; Restore R1
    LD R2, SAVELOC4      ; Restore R2
    LD R3, SAVELOC3      ; Restore R3
    RET                  ; Return if input was valid

FAIL
    LEA R0, FAIL_STR     ; Load error message string
    PUTS                 ; Print error message
    LD R0, NEWLINE2      ; Load newline character
    OUT                  ; Print newline
    HALT                 ; Terminate program

; If user does not type a number

FAIL_STR  .STRINGZ "WRONG INPUT, PROGRAM TERMINATED" ; Error message
DATA_MIN  .FILL #-48                                 ; ASCII '0' offset (for min digit)
DATA_MAX  .FILL #-57                                 ; ASCII '9' offset (for max digit)
NEWLINE2  .FILL XA                                   ; ASCII newline
.END
