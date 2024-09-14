# 6502 Architecture - from CMPSI 201 pdf

## Absolute Addresses

- These are two bytes in length. The upper byte represents the page of memory being accesses, and the lower byte, the offset within that page.
- The 6502's 64k address space is 256 pages of 256 bytes per page (256*256=65532, this architecture has a maximum of 64k bytes of random access memory).
- Instructions that reference memory typically use two-byte addresses to access any byte anywhere in the address space. If only a byte address, it assumes it should look on the first page (upper byte = 0 and byte given = lower byte).

## Pages

Page 0: Used to contain frequently references variables in order to save space in the program code.
Page 1: Used as the stack (hardwired by the processor), not used by the programmers for any other purpose.
Page 2: This is where the code for user programs often starts.

## Memory Layout

Lower addresses (particularly pages 0 and 1) must contain RAM and the upper addresses (particularly 255) must contain ROM.
