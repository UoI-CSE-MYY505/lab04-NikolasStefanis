
.globl str_ge, recCheck

.data

maria:    .string "Maria"
markos:   .string "Markos"
marios:   .string "Marios"
marianna: .string "Marianna"

.align 4  # make sure the string arrays are aligned to words (easier to see in ripes memory view)

# These are string arrays
# The labels below are replaced by the respective addresses
arraySorted:    .word maria, marianna, marios, markos

arrayNotSorted: .word marianna, markos, maria

.text

            la   a0, arrayNotSorted
            li   a1, 4
            jal  recCheck

            li   a7, 10
            ecall

str_ge:
#---------
# Write the subroutine code here
    .global str_ge
str_ge:
    loop:
        lb t0, 0(a0)      
        lb t1, 0(a1)     
        beqz t0, done
        beqz t1, less_than
        bne t0, t1, check_order


        addi a0, a0, 1
        addi a1, a1, 1
        j loop

    check_order:
        blt t0, t1, less_than
        li a0, 1           
        ret

    less_than:
        li a0, 0           
        ret

    done:
       
        li a0, 0
        ret

#  You may move jr ra   if you wish.
#---------
            jr   ra
 
# ----------------------------------------------------------------------------
# recCheck(array, size)
# if size == 0 or size == 1
#     return 1
# if str_ge(array[1], array[0])      # if first two items in ascending order,
#     return recCheck(&(array[1]), size-1)  # check from 2nd element onwards
# else
#     return 0

recCheck:
#---------
# Write the subroutine code here
    .global recCheck
recCheck:

    beqz a1, sorted
    li t0, 1
    beq a1, t0, sorted
    lw t1, 0(a0)       
    lw t2, 4(a0)     

   
    mv a0, t1
    mv a1, t2
    call str_ge       
    
    beqz a0, not_sorted  

   
    addi a0, a0, 4      
    addi a1, a1, -1     
    call recCheck

    ret

not_sorted:
    li a0, 0           
    ret

sorted:
    li a0, 1           
    ret

#  You may move jr ra   if you wish.
#---------
            jr   ra
