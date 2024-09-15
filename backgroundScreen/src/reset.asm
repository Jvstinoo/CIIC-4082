.include "constants.inc"

.segment "CODE" ; included so that linker knows which .proc this code belongs to. 
.import main ; importing so that assembler knows what memoery address main proc is at, since we are jumping to it at end of reset_handler.
.export reset_handler
.proc reset_handler ; occurs when the system is first turned on, or when user presses Reset button
  SEI           ; set interrupt ignore bit. used to ignore any IRQ event calls.
  CLD           ; clear decimal mode bit
  LDX #$40      ; disable audio IRQs and set up stack
  STX $4017     ; disable audio IRQs and set up stack
  LDX #$FF      ; disable audio IRQs and set up stack
  TXS           ; disable audio IRQs and set up stack
  INX         
  STX PPUCTRL
  STX $2001
  STX $4010
  BIT $2002
vblankwait:
  BIT $2002
  BPL vblankwait
vblankwait2:
  BIT $2002
  BPL vblankwait2
  JMP main ; jump to main
.endproc