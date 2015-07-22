#ifndef __SOLO_ASM_INC
#define __SOLO_ASM_INC
#include <stdlib.h>
#include <soloasm.h>

// We assume the first ORG is the lowest address
#define ORG(n) unsigned int genasm(int _solo_pass) { \
   unsigned _solo_add=n;\
   _solo_info.psize=14; \
   _solo_info.begin=n; \
   _solo_info.memsize=0x3FFF; \
   _solo_info.ary=malloc(_solo_info.memsize)

#define REORG(n) _solo_add=n;
#define END _solo_info.end=_solo_add-1; return _solo_add; }

#define DEFLABEL(l) static unsigned l
#define LABEL(l) l=_solo_add

#define W 0
#define F 1
#define PICI1(op,d,file) _solo_info.ary[_solo_add++]=((op)<<8|((d)<<7)|(file&0x7F))
#define PICI2(op,bit,file) _solo_info.ary[_solo_add++]=((op)<<10)|(d)<<7|(file&0x7F))
#define PICI3(op,k) _solo_info.ary[_solo_add++]=((op)<<8|(k))
#define PICI4(op,k) _solo_info.ary[_solo_add++]=((op)<<11|(k))

#define ADDWF(f,d) PICI1(0x7,d,f)
#define ANDWF(f,d) PICI1(0x5,d,f)
#define CLRF(f) PICI1(0x1,1,f)
#define CLRW PICI1(0x1,0,0)
#define COMF(f,d) PICI1(0x9,d,f)
#define DECF(f,d) PICI1(0x3,d,f)
#define DECFSZ(f,d) PICI1(0xb,d,f)
#define INCF(f,d) PICI1(0xa,d,f)
#define INCFSZ(f,d) PICI1(0xf,d,f)
#define IORWF(f,d) PICI1(0x4,d,f)
#define MOVF(f,d) PICI1(0x8,d,f)
#define MOVWF(f) PICI1(0x0,1,f)
#define NOP PICI1(0,0,0)
#define RLF(f,d) PICI1(0xd,d,f)
#define RRF(f,d) PICI1(0xc,d,f)
#define SUBWF(f,d) PICI1(0x2,d,f)
#define SWAPF(f,d) PICI1(0xe,d,f)
#define XORWF(f,d) PICI1(0x6,d,f)
#define BCF(f,b) PICI2(4,b,f)
#define BSF(f,b) PICI2(5,b,f)
#define BTFSC(f,b) PICI2(6,b,f)
#define BTFSS(f,b) PICI2(7,b,f)
#define ADDLW(k) PICI3(0x3E,k)
#define ANDLW(k) PICI3(0x39,k)
#define CALL(k) PICI4(0x4,k)
#define CLRWDT PICI4(0,0x64)
#define GOTO(k) PICI4(0x5,k)
#define IORLW(k) PICI3(0x38,k)
#define MOVLW(k) PICI4(0x6,k)
#define RETFIE PICI4(0,0x9)
#define RETLW(k) PICI3(0x34,k)
#define RETURN PICI4(0,8)
#define SLEEP PICI4(0,0x63)
#define SUBLW(k) PICI3(0x3c,k)
#define XORLW(k) PICI3(0x3a,k)
#define DW(d) _solo_info.ary[_solo_add++]=(d)

#define INDF 0
#define TMR0 1
#define OPTION_REG 0x81
#define PCL 2
#define STATUS 3
#define FSR 4
#define PORTA 5
#define TRISA 0x85
#define PORTB 6
#define TRISB 0x86
#define EEDATA 8
#define EECON1 0x88
#define EEADR 9
#define EECON2 0x89
#define PCLATH 0xA
#define INTCON 0xB

#define IRP 7
#define RP1 6
#define RP0 5
#define TO 4
#define PD 3
#define Z 2
#define DC 1
#define C 0

#define RA4 4
#define RA3 3
#define RA2 2
#define RA1 1
#define RA0 0
#define T0CKI 4
#define RB7 7
#define RB6 6
#define RB5 5
#define RB4 4
#define RB3 3
#define RB2 2
#define RB1 1
#define RB0 0
#define INT 0
#define GIE 7
#define EEIE 6
#define T0IE 5
#define INTE 4
#define RBIE 3
#define T0IF 2
#define INTF 1
#define RBIF 0
#define RBPU 7
#define INTEDG 6
#define TOCS 5
#define T0SE 4
#define PSA 3
#define PS2 2
#define PS1 1
#define PS0 0
#define EEIF 4
#define WRERR 3
#define WREN 2
#define WR 1
#define RD 0


#endif
