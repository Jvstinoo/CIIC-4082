# Ram and Addition on 6502

- Data on the NES is stored on the processor register or system memory.
- The 6502 is an 8-bit architecture, with a single 8-bit accumulator register.
  - The 6502 is called a one address machine because instructions can references at most one address at a time.

## Addressing Modes

### Immediate Addressing "#$E8"

- ldx #10 means load x immediate 10, load x = 10 to the processor's x register.
- only works with byte.

### ZeroPage Addressing

- ldx $2F: provide an 8 bit operand to the instruction.
- operand: address or value over which to perform an operation.
- stx $01 addresses memory using only a byte.

### Absolute Addressing

- uses 16 bit addressing (stx $0301)
- can access any of the 64kb memory on the NES
- slower than ZeroPage

### Implicit Addressing

- inx: no use of address
