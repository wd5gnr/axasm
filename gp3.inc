#ifndef _GP3_ASM_INC
#define _GP3_ASM_INC
#include <stdio.h>
#include <stdlib.h>
#include <soloasm.h>


void _gp3chkskip(unsigned skip)
  {
  if (skip<0 || skip>31) fprintf(stderr,"Skip out of range (%d)\n",skip);
  }



#define BEGIN unsigned int genasm(int _solo_pass) { \
    unsigned _solo_add=0;\
   _solo_info.psize=14; \
   _solo_info.begin=0; \
   _solo_info.memsize=0xFFFF; \
   _solo_info.ary=malloc(_solo_info.memsize)


#define END _solo_info.end=_solo_add-1; return _solo_add; }

#define DEFLABEL(l) static unsigned l
#define LABEL(l) l=_solo_add


// The following group are mostly "internal"
#define DB(n) _solo_info.ary[_solo_add++]=n
#define _B0(n) DB(0x80|((n)>>1))
#define _B2(m,n) DB((m)+((n)&1); _B0(n))
#define DBS(op,skip) _gp3chkskip(_solo_pass==2?skip:0); DB((skip<<8)|op)
#define ARGB(n) _B2(6,n)
#define ARGW(n) DB(((n&1)?0xA:8)+((n>>8)&1)); DB(0x80|(n>>9)); DB(0x80|((n&0xFF)>>1))



#define NOP DB(0x80)
#define DLY(n) DB(0x81); DB(n)
#define RST DB(0)
#define SETDIR(n) _B2(2,n)
#define SETOUT(n) _B2(4,n)
#define LED(n) DB(0xC+(n&1))
#define FREQA(p,freq) DB(0xE); DB(0x80|(((p)&7)<<1)|((freq)&1)); DB(0x80|((freq)>>8)&0xFF); DB(0x80|((freq)>>1)&0xFF)
#define FREQ(p,freq,dur) ARGW(dur); FREQA(p,freq)
#define SETCTR(n,b) DB(0xE); DB(0x90|((n)<<1)|((b)&1))
#define HIGH(p) DB(0x11+(p<<1))
#define LOW(p) DB(0x10+(p<<1))
#define TOG(p) DB(0x20+(p<<1))
#define ACONF(j,r) DB(0x31); DB(0x80+(j<<7)+r)
#define PULSEOUTA(p) DB(0x41+(p<<1))
#define PULSEOUT(p,v) ARGW(v); PULSEOUTA(p)
#define EEWA(d) _B2(0x50,d)
#define EEW(a,d) ARGW(a); _B2(0x50,d)
#define XPWMA(dc) _B2(0x54,dc)
#define XPWM(f,dc) ARGW(f); XPWMA(dc)
#define ARGINC DB(0x59)
#define ARGDEC DB(0x58)
#define HRESET DB(0x5C)
#define PWMA(p,dc) _B2(0x60+(p<<1),dc)
#define PWM(p,dc,dur) ARGW(dur); PWMA(p,dc)
#define JMP(n) DB(0x85); DB(n)
#define CALL(n) DB(0x86); DB(n)
#define RTN DB(0x87)
// repeat only works with a2d, inp, rctime, pulsein, digital in
#define REPEAT(n) ARGW((n)-1); DB(0x5b)

// Constants for things like LED
#define ON 1
#define OFF 0

// Loop counters
#define i 0
#define j 1
#define k 2



#define SETLOOP(loop,ct) DB((loop<<8)+0x88); DB(ct)
#define NEXT(loop,label) DB((loop<<8)+0x89); DB(label)
#define INPUT(mask,match,skip) DBS(0x82,skip-(_solo_add+3)); DB(mask); DB(match)
#define INPUTW(mask, match) INPUT(mask,match,_solo_add+3)
#define INCT(match,skip) DBS(0x83,skip-(_solo_add+1)); DB(match)
#define INCTW(match) INCT(match,_solo_add+1)
#define INANALOGX(chan,cc,tgt,skip) DBS(0x84,skip-(_solo_add+3)); DB((cc<8)|chan); DB(tgt)
#define INANALOGXW(chan,cc,tgt) INANALOGX(chan,cc,tgt,_solo_add+3)
#define INANALOGC(chan,cc,chan2,skip) DBS(0x84,skip-(_solo_add+3)); DB((cc<<8)|chan); DB(tgt|0x1000)
#define IANALOGCW(chan, cc, chan2) INANALOGC(chan,cc,chan2,_solo_add+3)
// codes for analog commands
#define lt 0
#define eq 1
#define gt 2
#define le 3
#define ge 4
#define SEND(byte) DB(0x8a); DB(byte)
#define SERIN(match,skip) DBS(0x8b,skip-(_solo_add+2)); DB(match)
#define SERINW(match) DB(0x8c); DB(match)
#define SERANY(skip) DBS(0x8d,skip-(_solo_add+1))
#define SERANYW DB(0x8e)
#define CHECK(add,mask,match,skip) DBS(0x8f,skip-(_solo_add+4)); DB(add); DB(mask); DB(match)


// These are probably not very useful in a GP3EZ script but are here for completeness
// You might use them if you have custom software on the remote end
#define RCTIME(n,s) _B2(0xE,0x20+(n<<1)+s)
#define INP(p) DB(0x21+(p<<1))
#define COUNTA(p) DB(0x40+(p<<1)
#define COUNT(p,v) ARGW(v); DB(0x40+(p<<1))
#define EERA DB(0x52)
#define EER(a) ARGW(a); AEER
#define A2D(p) DB(0x30+(p<<1))
#define COUNTER DB(0x5a)
#define PULSEIN(p,s) DB(0x70|((p<<1)|(s)))
#define GETIN DB(0x56)
#define GETDIR DB(0x57)
// read counter without reset
#define COUNTERX DB(0x5E)
#define VERSION DB(1)
#define VERSION2 DB(0x5F)

#endif
