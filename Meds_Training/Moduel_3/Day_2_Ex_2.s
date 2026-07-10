.data
newline: .string "\n"
.text
main:
    
    li t0, 0xDEADBEEF
    
    #lower Byte
    andi t1, t0, 0xFF
    mv a1, t1
    addi a0, zero, 34
    ecall
    
    #newline
    li a0, 4
    la a1, newline
    ecall
    
    
    #second Byte
    srli t1, t0, 8
    andi t2, t1, 0xFF
    mv a1, t2
    addi a0, zero, 34
    ecall
    
    #newline
    li a0, 4
    la a1, newline
    ecall
    
    #upper half word
    srli t1, t0, 16
    mv a1, t1
    li a0, 34
    ecall
    
    #exit
    li a0, 10
    ecall
    