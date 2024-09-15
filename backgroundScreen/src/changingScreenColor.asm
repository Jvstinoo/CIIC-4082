.include "constants.inc"
.include "header.inc"
.import reset_handler

.if 0
  .segment:         assembler directive - instruction for the assembler to follow when it is converting code to machine code.
  HEADER segment:   contains information for emulators about what kind of chips are present in the cartridge.
  byte:             tells assembler to insert literal data bytes into the output.
  CODE segment:     contains game code stored in the PRG-ROM.
  CHARS segment:    represents the entire contents of the CHR-ROM, included as a binary file.
  .res 8192:        assembler directive that tells the assembler to "reserve" a certain amount of blank space (in bytes).
  directives:       instructions for the assembler that affect the conversion from assembly to machine code. (.proc indicates new lexical scope).

  Bit #	Effect
  0	Greyscale mode enable (0: normal color, 1: greyscale)
  1	Left edge (8px) background enable (0: hide, 1: show)
  2	Left edge (8px) foreground enable (0: hide, 1: show)
  3	Background enable
  4	Foreground enable
  5	Emphasize red
  6	Emphasize green
  7	Emphasize blue
.endif

.segment "CODE"
.proc irq_handler ; interrupt request can be triggered by the NES' sound processor
  RTI ; return from interrupt
.endproc

.proc nmi_handler ; non-maskable interrupt occurs when the PPU starts preparing the next frame of graphics
  RTI
.endproc


.if 0
  ;This is mainly telling PPU to store $29 (green background color) at address $3f00. How?

  ;CPU memory address 2006 allows us to to select an address in PPU memory. 
  ;2007 allows us to write a byte of data to that address.

  ;two bytes of data are being stored in $2006 - high byte (3f) and low byte (00).
  ;  3f00 is the address of the first color of the first palette.
  ;  to store data at the selected PPU memory address, we store a byte to $2007.
  ;    this write byte $29 (green color) to the memory address selected (3f00).

  ;How does it display on the screen?

  ;By using PPUMASK: $2001. A byte where each bit represents a property and if it is on/off is stored.
  What each bit does is at the top of the program.
.endif

.export main
.proc main
  LDX PPUSTATUS    
  LDX #$3f
  STX PPUADDR
  LDX #$00
  STX PPUADDR
  LDA #$01
  STA PPUDATA
  LDA #%00011110
  STA PPUMASK
forever:
  JMP forever
.endproc

.segment "VECTORS" ; ca65 has this specific segment for these three VECTORS
.addr nmi_handler, reset_handler, irq_handler

.segment "CHR"
.res 8192