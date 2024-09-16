; Create a subroutine given a type and refill.
; Types: Small health, Large health, Small weapon, Large weapon.
; Health/Weapon limit: 100.
; Refill: Small health: 10, Large health: 25, Small weapon: 10, Large weapon: 25

.export Main
.segment "CODE"

refill:
    