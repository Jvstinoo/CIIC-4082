.export Main
.segment "CODE"

initial_monster_hp:
    .byte 80,35,75,90,200,0,15,50 ; places bytes into ROM

.proc Main
    ldx #7 ; loading 7 into index x

initialize_hp_loop:
    lda initial_monster_hp, x ; base address, x register. x acts as an offset, initial_monster_hp + x. moves index to last element in table (50)
    sta $0300, x ; stores in monster_hp table in system's ROM, absolute indexed addressing mode.
    dex
    bpl initialize_hp_loop ; branch on positive result