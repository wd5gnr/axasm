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

#define DB(n) _solo_info.ary[_solo_add++]=n
#define DW(n) DB((n)/256); DB((n)%256);

#define IDL _solo_info.ary[_solo_add++]=0
#define LDN(n) _solo_info.ary[_solo_add++]=(n)
#define INC(n) _solo_info.ary[_solo_add++]=0x10+(n)
#define DEC(n) _solo_info.ary[_solo_add++]=0x20+(n)
#define _BRANCH(n,a) _solo_info.ary[_solo_add++]=0x30+(n); _solo_info.ary[_solo_add++]=((a)&0xFF); if (_solo_pass==2 && (n>>8)!=(_solo_add>>8)) fprintf(stderr,"Warning: Branch target out of range at %04X\n",_solo_add-2)
#define BR(a) _BRANCH(0,a)
#define BQ(a) _BRANCH(1,a)
#define BZ(a) _BRANCH(2,a)
#define BDF(a)_BRANCH(3,a)
#define B1(a) _BRANCH(4,a)
#define B2(a) _BRANCH(5,a)
#define B3(a) _BRANCH(6,a)
#define B4(a) _BRANCH(7,a)
#define NBR(a) _BRANCH(8,a)
#define BNQ(a) _BRANCH(9,a)
#define BNZ(a) _BRANCH(10,a)
#define BNF(a) _BRANCH(11,a)
#define BN1(a) _BRANCH(12,a)
#define BN2(a) _BRANCH(13,a)
#define BN3(a) _BRANCH(14,a)
#define BN4(a) _BRANCH(15,a)
#define LDA(n) _solo_info.ary[_solo_add++]=(n)+0x40
#define STR(n) _solo_info.ary[_solo_add++]=(n)+0x50
#define IRX _solo_info.ary[_solo_add++]=0x60
#define OUT(n) _solo_info.ary[_solo_add++]=0x60+(n)
#define INP(n) _solo_info.ary[_solo_add++]=0x60+8+(n)
#define RET  
#define DIS _solo_info.ary[_solo_add++]=0x71
#define LDXA _solo_info.ary[_solo_add++]=0x72
#define STXD _solo_info.ary[_solo_add++]=0x73
#define ADC _solo_info.ary[_solo_add++]=0x74
#define SDB _solo_info.ary[_solo_add++]=0x75
#define SHRC _solo_info.ary[_solo_add++]=0x76
#define SMB _solo_info.ary[_solo_add++]=0x77
#define SAV _solo_info.ary[_solo_add++]=0x78
#define MARK _solo_info.ary[_solo_add++]=0x79
#define REQ _solo_info.ary[_solo_add++]=0x7A
#define SEQ _solo_info.ary[_solo_add++]=0x7B
#define ADCI _solo_info.ary[_solo_add++]=0x7C
#define SDBI _solo_info.ary[_solo_add++]=0x7D
#define SHLC _solo_info.ary[_solo_add++]=0x7E
#define SMBI _solo_info.ary[_solo_add++]=0x7F
#define GLO(n) _solo_info.ary[_solo_add++]=(n)+0x80
#define GHI(n) _solo_info.ary[_solo_add++]=(n)+0x90
#define PLO(n) _solo_info.ary[_solo_add++]=(n)+0xA0
#define PHI(n) _solo_info.ary[_solo_add++]=(n)+0xB0
#define _LBRANCH(n,a) _solo_info.ary[_solo_add++]=0xC0+(n); _solo_info.ary[_solo_add++]=((a)>>8); _solo_info.ary[_solo_add++]=((a)&0xFF) 
#define LBR(a) _LBRANCH(0,a)
#define LBQ(a) _LBRANCH(1,a)
#define LBZ(a) _LBRANCH(2,a)
#define LBDF(a) _LBRANCH(3,a)
#define NOP _LBRANCH(4,a)
#define LSNQ(a) _LBRANCH(5,a)
#define LSNZ(a) _LBRANCH(6,a)
#define LSNF(a) _LBRANCH(7,a)
#define NLBR(a) _LBRANCH(8,a)
#define LBNQ(a) _LBRANCH(9,a)
#define LBNZ(a) _LBRANCH(10,a)
#define LBNF(a) _LBRANCH(11,a)
#define LSIE _solo_info.ary[_solo_add++]=0xCC
#define LSQ _solo_info.ary[_solo_add++]=0xCD
#define LSZ3 _solo_info.ary[_solo_add++]=0xCE
#define LSDF _solo_info.ary[_solo_add++]=0xCF
#define SEP(n) _solo_info.ary[_solo_add++]=(n)+0xD0
#define SEX(n) _solo_info.ary[_solo_add++]=(n)+0xE0
#define LDX _solo_info.ary[_solo_add++]=0xF0
#define OR _solo_info.ary[_solo_add++]=0xF1
#define AND _solo_info.ary[_solo_add++]=0xF2
#define XOR _solo_info.ary[_solo_add++]=0xF3
#define ADD _solo_info.ary[_solo_add++]=0xF4
#define SD _solo_info.ary[_solo_add++]=0xF5
#define SHR _solo_info.ary[_solo_add++]=0xF6
#define SM _solo_info.ary[_solo_add++]=0xF7
#define LDI(n) _solo_info.ary[_solo_add++]=0xF8; _solo_info.ary[_solo_add++]=n
#define ORI(n) _solo_info.ary[_solo_add++]=0xF9; _solo_info.ary[_solo_add++]=n
#define ANI(n) _solo_info.ary[_solo_add++]=0xFA; _solo_info.ary[_solo_add++]=n
#define XRI(n) _solo_info.ary[_solo_add++]=0xFB; _solo_info.ary[_solo_add++]=n
#define ADI(n) _solo_info.ary[_solo_add++]=0xFC; _solo_info.ary[_solo_add++]=n
#define SDI(n) _solo_info.ary[_solo_add++]=0xFD; _solo_info.ary[_solo_add++]=n
#define SHL(n) _solo_info.ary[_solo_add++]=0xFE; _solo_info.ary[_solo_add++]=n
#define SMI(n) _solo_info.ary[_solo_add++]=0xFF; _solo_info.ary[_solo_add++]=n










#endif
