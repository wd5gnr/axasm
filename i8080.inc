#ifndef _SOLO_ASM_INC
#define _SOLO_ASM_INC
#include <stdio.h>
#include <stdlib.h>
#include <soloasm.h>

// We assume the first ORG is the lowest address
#define ORG(n) unsigned int genasm(int _solo_pass) { \
   unsigned _solo_add=n;\
   _solo_info.psize=8; \
   _solo_info.begin=n; \
   _solo_info.memsize=0xFFFF; \
   _solo_info.ary=malloc(_solo_info.memsize)


#define REORG(n) _solo_add=n;
#define END _solo_info.end=_solo_add-1; return _solo_add; }

#define DEFLABEL(l) static unsigned l
#define LABEL(l) l=_solo_add

#define DB(n) _solo_info.ary[_solo_add++]=(n)
#define DW(n) DB((n)%256); DB((n)/256)

#define _REGP(r) (((r>>1)&3)<<4)
#define _REG(r) (((r)&7)<<3)

#define A 7
#define B 0
#define C 1
#define D 2
#define E 3
#define H 4
#define L 5
#define M 6


#define BC B
#define DE D
#define HL H
#define SP 6
#define PSW 6

#define NZ 0
#define Z 1
#define NC 2
#define CY 3
#define PO 4
#define PE 5
#define P 6
#define MI 7

#define a 7
#define b 0
#define c 1
#define d 2
#define e 3
#define h 4
#define l 5
#define m 6


#define bc b
#define de d
#define hl h
#define sp 6
#define psw 6

#define nz 0
#define z 1
#define nc 2
#define cy 3
#define po 4
#define pe 5
#define p 6
#define mi 7



#define NOP DB(0)
#define MOV(d,s) DB(0x40+(((d)&7)<<3)+((s)&7))
#define MVI(d,i) DB(6+(((d)&7)<<3)); DB(i)
#define LXI(r,i) DB(1+_REGP(r)); DW(i)
#define LDA(a) DB(0x3a); DW(a)
#define STA(a) DB(0x32); DW(a)
#define LHLD(a) DB(0x2a); DW(a)
#define SHLD(a) DB(0x22); DW(a)
#define LDAX(r) DB(0xa+_REGP(r))
#define STAX(r) DB(2+_REGP(r))
#define XCHG DB(0xEB)
#define ADD(s) DB(0x80+((s)&7))
#define ADI(i) DB(0xC6); DB(i)
#define ADC(s) DB(0x88+((s)&7))
#define ACI(i) DB(0xCE); DB(i)
#define SUB(s) DB(0x90+((s)&7))
#define SUI(i) DB(0xD6); DB(i)
#define SBB(s) DB(0x98+((s)&7))
#define SBI(i) DB(0xDE); DB(i)
#define INR(d) DB(4+_REG(d))
#define DCR(d) DB(5+_REG(d))
#define INX(r) DB(3+_REGP(r))
#define DCX(r) DB(0xB+_REGP(r))
#define DAD(r) DB(9+_REGP(r))
#define DAA DB(0x27)
#define ANA(s) DB(0xA0+((s)&7))
#define ANI(i) DB(0xE6); DB(i)
#define ORA(s) DB(0xB0+((s&7)))
#define ORI(i) DB(0xF6); DB(i)
#define XRA(s) DB(0xA8+((s)&7))
#define XRI(i) DB(0xEE); DB(i)
#define CMP(s) DB(0xB8+((s&7)))
#define CPI(i) DB(0xFE); DB(i)
#define RLC DB(7)
#define RRC DB(0xF)
#define RAL DB(0x17)
#define RAR DB(0x1f)
#define CMA DB(0x2f)
#define CMC DB(0x3f)
#define STC DB(0x37)
#define JMP(l) DB(0xc3); DW(l) 
#define J(c,l) DB(0xC0+(((c)&7)<<3)+2); DW(l)
// do JZ, JC, etc here
#define JZ(l) J(Z,l)
#define JNZ(l) J(NZ,l)
#define JNC(l) J(NC,l)
#define JC(l) J(CY,l)
#define JPO(l) J(PO,l)
#define JPE(l) J(PE,l)
#define JP(l) J(P,l)
#define JM(l) J(MI,l)

#define CALL(l) DB(0xcd); DW(l) 
#define CALL_(c,l) DB(0xC4+(((c)&7)<<3)); DW(l)
// define CALLZ etc
#define CALLZ(l) CALL_(Z,l)
#define CZ(l) CALLZ(l)
#define CALLNZ(l) CALL_(NZ,l)
#define CNZ(l) CALLNZ(l)
#define CALLNC(l) CALL_(NC,l)
#define CNC(l) CALLNC(l)
#define CALLC(l) CALL_(CY,l)
#define CC(l) CALLC(l)
#define CALLPO(l) CALL_(PO,l)
#define CPO(l) CALLPO(l)
#define CALLPE(l) CALL_(PE,l)
#define CPE(l) CALLPE(l)
#define CALLP(l) CALL_(P,l)
#define CP(l) CALLP(l)
#define CALLM(l) CALL_(MI,l)
#define CM(l) CALLM(l)

#define RET DB(0xc9)
#define R_(c) DB(0xC0+(((c)&7)<<3)); 
// define RETZ etc.
#define RETZ R_(Z)
#define RZ RETZ
#define RETNZ R_(NZ)
#define RNZ RETNZ
#define RETNC R_(NC)
#define RNC RETNC
#define RETC R_(CY)
#define RC RETC
#define RETPO R_(PO)
#define RPO RETPO
#define RETPE R_(PE)
#define RPE RETPE
#define RETP R_(P)
#define RP RETP
#define RETM R_(MI)
#define RM RETM

#define RST(n) DB(0x0xC7+((c)&7<<3)); 
#define PCHL  DB(0xe9)
#define PUSH(r) DB(0xC5+_REGP(r))
#define POP(r) DB(0xC1+_REGP(r))
#define XTHL  DB(0xe3)
#define SPHL  DB(0xf9) 
#define IN(p) DB(0xDb); DB(p)
#define OUT(p) DB(0xD3); DB(p)
#define EI  DB(0xfb)
#define DI  DB(0xf3)
#define HLT  DB(0x76)






#endif
