.export Main
.segment "CODE"

; piece of code to check if incoming damage to player will result in player dying. game over screen if so.

.proc Main
  ; Initialize Health, Damage, and the Return Value
  lda #25 ; load accumulator ; health
  sta $00 ; store accumulator in register $00
  lda #30 ; damage
  sta $01
  lda #0 ; return
  sta $02

  ; Check if Damage >= Health
  lda $01 ; loads damage  
  cmp $00 ; compares damage with health. if damage < health, no carry. if damage >= health, carry.
  bcc not_lethal ; branch if carry clear. if prev line results in 0, will jump to branch not_lethal

  ; Set address $01 to "1" to indicate the player has died
  lda #1
  sta $01

  ; Branch to this label when damage isn't lethal
not_lethal:
  rts ; exits subroutine. values stored in output memory will retain 0 
.endproc
