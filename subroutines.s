.export Main
.segment "CODE"

;example of subroutine

heal: 
    lda $00 ; load value of $00 into the accumulator. getting health value
    clc ; clear carry
    adc $0300 ; address in main memory space. adds value in $0300 to accumulator
    cmp $0301 ; compare $0301 with accumulator
    bcc :+ ; branch on carry clear (when carry = 0)
    lda $0301
:   sta $0300 ; stores accumulator to address $0300
    rts ; return 