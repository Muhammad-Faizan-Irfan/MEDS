.data
value: .word 0xDEADBEEF
newline: .string "\n"

.text
main:
    
    la t0, value
    
    #load word
    lw t1, 0(t0) 
    mv a1, t1
    li a0, 34
    ecall
    
    #newline
    li a0, 4
    la a1, newline
    ecall
    
    #load half_word offset 0
    lhu t1, 0(t0) 
    mv a1, t1
    li a0, 34
    ecall
    
    #newline
    li a0, 4
    la a1, newline
    ecall
    
    #load half_word offset 2
    lhu t1, 2(t0) 
    mv a1, t1
    li a0, 34
    ecall
    
    #newline
    li a0, 4
    la a1, newline
    ecall
    
    #load byte
    lbu t1, 0(t0) 
    mv a1, t1
    li a0, 34
    ecall
    
    li a0, 10
    ecall