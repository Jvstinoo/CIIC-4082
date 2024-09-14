/*
HEADER segment:   contains information for emulators about what kind of chips are present in the cartridge.
CODE segment:     contains game code stored in the PRG-ROM.
CHARS segment:    represents the entire contents of the CHR-ROM, included as a binary file.
.res 8192:        assembler directive that tells the assembler to "reserve" a certain amount of blank space (in bytes).
directives:       instructions for the assembler that affect the conversion from assembly to machine code. (.proc indicates new lexical scope).

Opcodes:


*/
.segment "HEADER"
.byte $4e, $45, $53, $1a, $02, $01, $00, $00

.segment "CODE"
.proc irq_handler
  RTI
.endproc

.proc nmi_handler
  RTI
.endproc

.proc reset_handler
  SEI
  CLD
  LDX #$40
  STX $4017
  LDX #$FF
  TXS
  INX
  STX $2000
  STX $2001
  STX $4010
  BIT $2002
vblankwait:
  BIT $2002
  BPL vblankwait
vblankwait2:
  BIT $2002
  BPL vblankwait2
  JMP main
.endproc

/*
This is mainly telling PPU to store $29 (green background color) at address $3f00. How?

CPU memory address 2006 allows us to to select an address in PPU memory. 
2007 allows us to write a byte of data to that address.

two bytes of data are being stored in $2006 - high byte (3f) and low byte (00).
  3f00 is the address of the first color of the first palette.
  to store data at the selected PPU memory address, we store a byte to $2007.
    this write byte $29 (green color) to the memory address selected ($3f00).


*/
.proc main
  LDX $2002       ; loading into X value at memory address 2002
  LDX #$3f        ; loading into X value 3f (48+15=63?)
  STX $2006       ; storing value of X (63) into memory address 2006
  LDX #$00        ; loading into X value 00 (0)
  STX $2006       ; storing value of x (0) into memory address 2006
  LDA #$29        ; loading accumulator with value 29 (32+9=41?)
  STA $2007       ; storing accumulator value in memory address 2007 
  LDA #%00011110  ; loading accumulator with byte 00011110
  STA $2001       ; storing accumulator value in memory address 2001
forever:
  JMP forever
.endproc

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "CHARS"
.res 8192
.segment "STARTUP"