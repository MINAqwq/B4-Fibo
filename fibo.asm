; B4 Fibonacci Sequence
; written in an AT&T inspired syntax (assembled this later by hand)

; Fibonacci Bootstrap
LDI $0, %A	; write 0 into A

LDI $0, %B	; write 0 into B
ST		; write 0 to addr 0

LDI $1, %B	; write 1 into B
ST		; write 0 to addr 1

LDI $1, %A	; write 1 into A
LDI $2, %B	; write 2 into B
ST		; write 1 to addr 2

; Memory lies on page 0xF
; 0x0: 0 = Z
; 0x1: 0 = X
; 0x2: 1 = Y

; in b mode we jump if A != B
LDI $0, %A
LDI $1, %B

; set carry 1 and jump to page 1
CMP B
JPC B, loop

; to be sure we can jump back later, we need to pad loop to the next page (0x10)
.page 1
loop:

; Z = X + Y
LDI $2, %B	; write 2 into B
LD		; load Y into A
PT %B		; write Y into B

LDI $1, %B	; write 1 into B 
LD		; load X into A

ADD %B		; A = A + B
LDI $0, %B	; write 0 into B
ST		; write A to addr 0

; X = Y
LDI $2, %B	; write 2 into B
LD		; load Y into A
LDI $1, %B	; write 1 into B
ST		; overwrite X with Y


; Y = Z
LDI $0, %B	; write 0 into B
LD		; load Z into A
LDI $2, %B	; write 2 into B
ST		; overwrite Y with Z

; load X
LDI $1, %B	; write 1 to B
LD		; load X into A

; check if X is decimal 13
LDI $13, %B
CMP B

; if A is not decimal 13 we jump back to the loop start
JPC B, loop

