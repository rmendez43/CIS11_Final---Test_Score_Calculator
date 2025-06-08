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

; This repeated code block below reads five test scores, stores them
; in memory, calculates the letter grade, and displays it.

    JSR GET_GRADE
    LEA R6, GRADES
    STR R3, R6, #0
    JSR GET_LETTER
    JSR POP
    LD R0, NEWLINE
    OUT

    JSR GET_GRADE
    LEA R6, GRADES
    LD R5, ONE
    ADD R7, R6, R5
    STR R3, R7, #0
    JSR GET_LETTER
    JSR POP
    LD R0, NEWLINE
    OUT

    JSR GET_GRADE
    LEA R6, GRADES
    LD R5, TWO
    ADD R7, R6, R5
    STR R3, R7, #0
    JSR GET_LETTER
    JSR POP
    LD R0, NEWLINE
    OUT

    JSR GET_GRADE
    LEA R6, GRADES
    LD R5, THREE
    ADD R7, R6, R5
    STR R3, R7, #0
    JSR GET_LETTER
    JSR POP
    LD R0, NEWLINE
    OUT

    JSR GET_GRADE
    LEA R6, GRADES
    LD R5, FOUR
    ADD R7, R6, R5
    STR R3, R7, #0
    JSR GET_LETTER
    JSR POP
    LD R0, NEWLINE
    OUT

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
    
    ; Process grade 2
    LDR R4, R2, #1
    LD R5, TOTAL_SUM
    ADD R5, R5, R4
    ST R5, TOTAL_SUM
    
    ; Check if grade 2 is new max
    LD R5, MAX_GRADE
    NOT R5, R5
    ADD R5, R5, #1
    ADD R6, R4, R5
    BRZP SKIP_MAX1
    ST R4, MAX_GRADE
SKIP_MAX1
    
    ; Check if grade 2 is new min
    LD R5, MIN_GRADE
    NOT R4, R4
    ADD R4, R4, #1
    ADD R6, R5, R4
    BRZP SKIP_MIN1
    LDR R4, R2, #1
    ST R4, MIN_GRADE
SKIP_MIN1
    
    ; Process grade 3
    LDR R4, R2, #2
    LD R5, TOTAL_SUM
    ADD R5, R5, R4
    ST R5, TOTAL_SUM
    
    ; Check if grade 3 is new max
    LD R5, MAX_GRADE
    NOT R5, R5
    ADD R5, R5, #1
    ADD R6, R4, R5
    BRZP SKIP_MAX2
    ST R4, MAX_GRADE
SKIP_MAX2
    
    ; Check if grade 3 is new min
    LD R5, MIN_GRADE
    NOT R4, R4
    ADD R4, R4, #1
    ADD R6, R5, R4
    BRZP SKIP_MIN2
    LDR R4, R2, #2
    ST R4, MIN_GRADE
SKIP_MIN2
    
    ; Process grade 4
    LDR R4, R2, #3
    LD R5, TOTAL_SUM
    ADD R5, R5, R4
    ST R5, TOTAL_SUM
    
    ; Check if grade 4 is new max
    LD R5, MAX_GRADE
    NOT R5, R5
    ADD R5, R5, #1
    ADD R6, R4, R5
    BRZP SKIP_MAX3
    ST R4, MAX_GRADE
SKIP_MAX3
    
    ; Check if grade 4 is new min
    LD R5, MIN_GRADE
    NOT R4, R4
    ADD R4, R4, #1
    ADD R6, R5, R4
    BRZP SKIP_MIN3
    LDR R4, R2, #3
    ST R4, MIN_GRADE
SKIP_MIN3
    
    ; Process grade 5
    LDR R4, R2, #4
    LD R5, TOTAL_SUM
    ADD R5, R5, R4
    ST R5, TOTAL_SUM
    
    ; Check if grade 5 is new max
    LD R5, MAX_GRADE
    NOT R5, R5
    ADD R5, R5, #1
    ADD R6, R4, R5
    BRZP SKIP_MAX4
    ST R4, MAX_GRADE
SKIP_MAX4
    
    ; Check if grade 5 is new min
    LD R5, MIN_GRADE
    NOT R4, R4
    ADD R4, R4, #1
    ADD R6, R5, R4
    BRZP SKIP_MIN4
    LDR R4, R2, #4
    ST R4, MIN_GRADE
SKIP_MIN4
    
    ; Calculate average (divide total by 5)
    LD R3, TOTAL_SUM
    AND R4, R4, #0          ; Quotient
AVG_LOOP
    ADD R5, R3, #-5
    BRN AVG_DONE
    ADD R3, R3, #-5
    ADD R4, R4, #1
    BRnzp AVG_LOOP
AVG_DONE
    ST R4, AVERAGE_GRADE
    
    ; Display MAX
    LEA R0, MIN
    PUTS
    LD R3, MAX_GRADE
    AND R1, R1, #0
    JSR BREAK_INT
    LD R0, NEWLINE
    OUT
    
    ; Display MIN
    LEA R0, MAX
    PUTS
    LD R3, MIN_GRADE
    AND R1, R1, #0
    JSR BREAK_INT
    LD R0, NEWLINE
    OUT
    
    ; Display AVG
    LEA R0, AVG
    PUTS
    LD R3, AVERAGE_GRADE
    AND R1, R1, #0
    JSR BREAK_INT
    LD R0, NEWLINE
    OUT
    
    LD R7, SAVELOC1
    RET

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

SAVELOC1 .FILL x0000
SAVELOC2 .FILL x0000
SAVELOC3 .FILL x0000
SAVELOC4 .FILL x0000
SAVELOC5 .FILL x0000

; ========== Subroutines ==========

GET_GRADE
    ST R7, SAVELOC1
    JSR CLEAR_REG
    LD R4, DECODE_DEC
    GETC
    JSR VALIDATE2
    OUT
    ADD R1, R0, #0
    ADD R1, R1, R4
    ADD R2, R2, #10

MULT10
    ADD R3, R3, R1
    ADD R2, R2, #-1
    BRP MULT10

    GETC
    JSR VALIDATE2
    OUT
    ADD R0, R0, R4
    ADD R3, R3, R0
    LD R0, SPACE
    OUT
    LD R7, SAVELOC1
    RET

BREAK_INT
    ST R7, SAVELOC2
    LD R5, DECODE_SYM
    ADD R4, R3, #0

DIV1
    ADD R1, R1, #1
    ADD R4, R4, #-10
    BRP DIV1

    ADD R1, R1, #-1
    ADD R4, R4, #10
    ADD R6, R4, #-10
    BRNP POS

NEG
    ADD R1, R1, #1
    ADD R4, R4, #-10

POS
    ST R1, Q
    ST R4, R
    LD R0, Q
    ADD R0, R0, R5
    OUT
    LD R0, R
    ADD R0, R0, R5
    OUT
    LD R7, SAVELOC2
    RET

Q .FILL X0
R .FILL X0

PUSH
    ST R7, SAVELOC3
    JSR CLEAR_REG
    LD R6, POINTER
    ADD R6, R6, #0
    BRNZ STACK_ERROR
    ADD R6, R6, #-1
    STR R0, R6, #0
    ST R6, POINTER
    LD R7, SAVELOC3
    RET

POINTER .FILL X4000

POP
    LD R6, POINTER
    ST R1, SAVELOC5
    LD R1, BASELINE
    ADD R1, R1, R6
    BRZP STACK_ERROR
    LD R1, SAVELOC5
    LDR R0, R6, #0
    ST R7, SAVELOC4
    OUT
    LD R0, SPACE
    OUT
    ADD R6, R6, #1
    ST R6, POINTER
    LD R7, SAVELOC4
    RET

STACK_ERROR
    LEA R0, ERROR
    PUTS
    HALT

BASELINE .FILL XC000
ERROR    .STRINGZ "PROGRAM STOP"

GET_LETTER
    AND R2, R2, #0

A_GRADE
    LD R0, A_NUM
    LD R1, A_LET
    ADD R2, R3, R0
    BRZP STR_GRADE

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
    ST R7, SAVELOC1
    AND R0, R0, #0
    ADD R0, R1, #0
    JSR PUSH
    LD R7, SAVELOC1
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
    AND R1, R1, #0
    AND R2, R2, #0
    AND R3, R3, #0
    AND R4, R4, #0
    AND R5, R5, #0
    AND R6, R6, #0
    RET

VALIDATE2
    ST R1, SAVELOC5
    ST R2, SAVELOC4
    ST R3, SAVELOC3
    LD R1, DATA_MIN
    ADD R2, R0, R1
    BRN FAIL
    LD R1, DATA_MAX
    ADD R3, R0, R1
    BRP FAIL
    LD R1, SAVELOC5
    LD R2, SAVELOC4
    LD R3, SAVELOC3
    RET

FAIL
    LEA R0, FAIL_STR
    PUTS
    LD R0, NEWLINE2
    OUT
    HALT

; If user does not type a number

FAIL_STR  .STRINGZ "WRONG INPUT, PROGRAM TERMINATED"
DATA_MIN  .FILL #-48
DATA_MAX  .FILL #-57
NEWLINE2  .FILL XA
.END
