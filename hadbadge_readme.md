Notes:

1. Some instructions are changed (see hadbadge.inc) to avoid parse conflicts. This especially affects MOV:
* MOV X,Y is the normal move instruction
* MVI X,N is the MOV immediate instruction
* MOVIXYR0 is the MOV Indirect XY, R0 instruction
* And so on...
* Others affected are the math operators ADD/ADDI and JR, JRI -- JRI takes a fixed offset, JR computes it from a label

2. You must have an ORG and an END

3. To compile to a hex dump:
```
./axasm -p hadbadge -H testhad.asm
```

4. Most synthetic instructions are in place

5. Use ##define to define things in your own code

6. Use R0-RF if you like. The SFRs are also named. Note that everything is 4 bits so R0, R10, R20, etc. are all the same as R0.

7. The RG,N instructions need to be respun to accept the G. Sorry!