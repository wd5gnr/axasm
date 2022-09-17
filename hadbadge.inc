#ifndef __SOLO_ASM_INC
#define __SOLO_ASM_INC
#include <stdlib.h>
#include <soloasm.h>

// We assume the first ORG is the lowest address
#define ORG(n) unsigned int genasm(int _solo_pass) { \
   unsigned _solo_add=n;\
   _solo_info.psize=12; \
   _solo_info.begin=n; \
   _solo_info.memsize=0xFFF; \
   _solo_info.ary=malloc(_solo_info.memsize)

#define REORG(n) _solo_add=n;
#define END _solo_info.end=_solo_add-1; return _solo_add; }

#define DEFLABEL(l) static unsigned l
#define LABEL(l) l=_solo_add

#define DB(n) _solo_info.ary[_solo_add++]=(n)
#define NIB(a) ((a)&0xF)
#define NIB4(a) (((a)&0x0F)<<4)


#define ADD(X,Y) DB(0x100|NIB4(X)|NIB(Y))
#define ADC(X,Y) DB(0x200|NIB4(X)|NIB(Y))
#define SUB(X,Y) DB(0x300|NIB4(X)|NIB(Y))
#define SBB(X,Y) DB(0x400|NIB4(X)|NIB(Y))
#define OR(X,Y)  DB(0x500|NIB4(X)|NIB(Y))
#define AND(X,Y) DB(0x600|NIB4(X)|NIB(Y))
#define XOR(X,Y) DB(0x700|NIB4(X)|NIB(Y))
#define MOV(X,Y) DB(0x800|NIB4(X)|NIB(Y))
#define MVI(X,Y) DB(0x900|NIB4(X)|NIB(Y))
#define MOVIXYR0(X,Y) DB(0xA00|NIB4(X)|NIB(Y))
#define MOVR0IXY(X,Y) DB(0xB00|NIB4(X)|NIB(Y))
#define MOVIR0(N) DB(0xC00|(((N)&0xFF)))
#define MOVR0I(N) DB(0xD00|(((N)&0xFF)))
#define MOVPCNN(N) DB(0xE00|(((N)&0xFF)))
#define JRI(N) DB(0xF00|(((N)&0xFF)))
#define JR(L) { int off=(L)-_solo_add+1; DB(0xF00|off & 0xFF); }
#define CP(N) DB(NIB(N))
#define ADDI(N) DB(0x10|NIB(N))
#define INC(Y) DB(0x20|NIB(Y))
#define DEC(Y) DB(0x30|NIB(Y))
#define DSZ(Y) DB(0x40|NIB(Y))
#define ORI(N) DB(0x50|NIB(N))
#define ANDI(N) DB(0x60|NIB(N))
#define XORI(N) DB(0x70|NIB(N))
#define EXR(N) DB(0x80|NIB(N))
#define BIT(M) DB(0x90|NIB(M))
#define BSET(M) DB(0xA0|NIB(M))
#define BCLR(M) DB(0xB0|NIB(M))
#define BTG(M) DB(0xC0|NIB(M))
#define RRC(Y) DB(0xD0|NIB(Y))
#define RET(N) DB(0xE0|NIB(N))
#define SKIP(M) DB(0xF0|NIB(M))


#define R0 0
#define R1 1
#define R2 2
#define R3 3
#define R4 4
#define R5 5
#define R6 6
#define R7 7
#define R8 8
#define R9 9
#define RA 10
#define RB 11
#define RC 12
#define RD 13
#define RE 14
#define RF 15

// Note these are on page 0
#define OUT RA
#define IN RB
#define JSR RC
#define PCL RD
#define PCM RE
#define PCH RF

// note these are on page F
#define PAGE R0
#define SPEED R1
#define SYNC R2
#define WRFLAGS R3
#define RDFLAGS R4
#define SERCTL R5
#define SERLOW R6
#define SERHIGH R7
#define RECV R8
#define AUTO_OFF R9
#define OUTB RA
#define INB RB
#define KEY_STATUS RC
#define KEY_REG RD
#define DIMMER RE
#define RANDOM RF


#endif
