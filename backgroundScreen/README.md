# How to

1. Assemble each .asm file to create .o files:
    ca65 changingScreenColor.asm
    ca65 reset.asm

2. Pass all .o files to linker:
    ld65 changingScreenColor.o reset.o - C nes.cfg -o run.nes

Commands in order:
    ca65 src/changingScreenColor.asm
    ca65 src/reset.asm
    ld65 src/changingScreenColor.o src/reset.o - C nes.cfg -o run.nes
