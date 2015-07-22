;***********************************************************************
; MICROCOSM ASSOCIATES  8080/8085 CPU DIAGNOSTIC VERSION 1.0  (C) 1980
;***********************************************************************
;
;DONATED TO THE "SIG/M" CP/M USER'S GROUP BY:
;KELLY SMITH, MICROCOSM ASSOCIATES
;3055 WACO AVENUE
;SIMI VALLEY, CALIFORNIA, 93065
;(805) 527-9321 (MODEM, CP/M-NET (TM))
;(805) 527-0518 (VERBAL)
;
;***********************************************************************
; Modified 2001/02/28 by Richard Cini for use in the Altair32 Emulator
;       Project
;
; Need to somehow connect this code to Windows so that failure messages
;       can be posted to Windows. Maybe just store error code in
;       Mem[0xffff]. Maybe trap NOP in the emulator code?
;
;***********************************************************************
; Modified 2006/11/16 by Scott Moore to work on CPU8080 FPGA core
;
;***********************************************************************
	;;  AAW Nov 2010 - Modified for axasm and Altair8800 Micro
	ORG 0



##define stack 8192


;************************************************************
;                8080/8085 CPU TEST/DIAGNOSTIC
;************************************************************
;
;note: (1) program assumes "call",and "lxi sp" instructions work;
;
;      (2) instructions not tested are "hlt","di","ei",
;          and "rst 0" thru "rst 7"
;
;
;
;test jump instructions and flags
;
cpu:    lxi     SP,stack ;set the stack pointer
        ani     0       ;initialize a reg. and clear all flags
        jz      j010    ;test "jz"
        call    cpuer
j010:   jnc     j020    ;test "jnc"
        call    cpuer
j020:   jpe     j030    ;test "jpe"
        call    cpuer
j030:   jp      j040    ;test "jp"
        call    cpuer
j040:   jnz     j050    ;test "jnz"
        jc      j050    ;test "jc"
        jpo     j050    ;test "jpo"
        jm      j050    ;test "jm"
        jmp     j060    ;test "jmp" (it's a little late,but what the hell;
j050:   call    cpuer
j060:   adi     6       ;a=6,c=0,p=1,s=0,z=0
        jnz     j070    ;test "jnz"
        call    cpuer
j070:   jc      j080    ;test "jc"
        jpo     j080    ;test "jpo"
        jp      j090    ;test "jp"
j080:   call    cpuer
j090:   adi     0x70    ;a=76h,c=0,p=0,s=0,z=0
        jpo     j100    ;test "jpo"
        call    cpuer
j100:   jm      j110    ;test "jm"
        jz      j110    ;test "jz"
        jnc     j120    ;test "jnc"
j110:   call    cpuer
j120:   adi     0x81    ;a=f7h,c=0,p=0,s=1,z=0
        jm      j130    ;test "jm"
        call    cpuer
j130:   jz      j140    ;test "jz"
        jc      j140    ;test "jc"
        jpo     j150    ;test "jpo"
j140:   call    cpuer
j150:   adi     0xfe    ;a=f5h,c=1,p=1,s=1,z=0
        jc      j160    ;test "jc"
        call    cpuer
j160:   jz      j170    ;test "jz"
        jpo     j170    ;test "jpo"
        jm      aimm    ;test "jm"
j170:   call    cpuer
;
;
;
;test accumulator immediate instructions
;
aimm:   cpi     0       ;a=f5h,c=0,z=0
        jc      cpie    ;test "cpi" for re-set carry
        jz      cpie    ;test "cpi" for re-set zero
        cpi     0xf5    ;a=f5h,c=0,z=1
        jc      cpie    ;test "cpi" for re-set carry ("adi")
        jnz     cpie    ;test "cpi" for re-set zero
        cpi     0xff    ;a=f5h,c=1,z=0
        jz      cpie    ;test "cpi" for re-set zero
        jc      acii    ;test "cpi" for set carry
cpie:   call    cpuer
acii:   aci     0x0a    ;a=f5h+0ah+carry(1)=0,c=1
        aci     0x0a    ;a=0+0ah+carry(0)=0bh,c=0
        cpi     0x0b
        jz      suii    ;test "aci"
        call    cpuer
suii:   sui     0x0c    
        sui     0x0f    
        cpi     0xf0
        jz      sbii    ;test "sui"
        call    cpuer
sbii:   sbi     0xf1    ;a=f0h-0f1h-carry(0)=ffh,c=1
        sbi     0x0e    ;a=ffh-oeh-carry(1)=f0h,c=0
        cpi     0xf0
        jz      anii    ;test "sbi"
        call    cpuer
anii:   ani     0x55    ;a=f0h<and>55h=50h,c=0,p=1,s=0,z=0
        cpi     0x50
        jz      orii    ;test "ani"
        call    cpuer
orii:   ori     0x3a    ;a=50h<or>3ah=7ah,c=0,p=0,s=0,z=0
        cpi     0x7a
        jz      xrii    ;test "ori"
        call    cpuer
xrii:   xri     0x0f    ;a=7ah<xor>0fh=75h,c=0,p=0,s=0,z=0
        cpi     0x75
        jz      c010    ;test "xri"
        call    cpuer
;
;
;
;test calls and returns
;
c010:   ani     0      ;a=0,c=0,p=1,s=0,z=1
        cc      cpuer   ;test "cc"
        cpo     cpuer   ;test "cpo"
        cm      cpuer   ;test "cm"
        cnz     cpuer   ;test "cnz"
        cpi     0
        jz      c020    ;a=0,c=0,p=0,s=0,z=1
        call    cpuer
c020:   sui     0x77    ;a=89h,c=1,p=0,s=1,z=0
        cnc     cpuer   ;test "cnc"
        cpe     cpuer   ;test "cpe"
        cp      cpuer   ;test "cp"
        cz      cpuer   ;test "cz"
        cpi     0x89
        jz      c030    ;test for "calls" taking branch
        call    cpuer
c030:   ani     0xff    ;set flags back;
        cpo     cpoi    ;test "cpo"
        cpi     0xd9
        jz      movi    ;test "call" sequence success
        call    cpuer
cpoi:   rpe             ;test "rpe"
        adi     0x10    ;a=99h,c=0,p=0,s=1,z=0
        cpe     cpei    ;test "cpe"
        adi     0x02    ;a=d9h,c=0,p=0,s=1,z=0
        rpo             ;test "rpo"
        call    cpuer
cpei:   rpo             ;test "rpo"
        adi     0x20    ;a=b9h,c=0,p=0,s=1,z=0
        cm      cmi     ;test "cm"
        adi     0x04    ;a=d7h,c=0,p=1,s=1,z=0
        rpe             ;test "rpe"
        call    cpuer
cmi:    rp              ;test "rp"
        adi     0x80    ;a=39h,c=1,p=1,s=0,z=0
        cp      tcpi    ;test "cp"
        adi     0x80    ;a=d3h,c=0,p=0,s=1,z=0
        rm              ;test "rm"
        call    cpuer
tcpi:   rm              ;test "rm"
        adi     0x40    ;a=79h,c=0,p=0,s=0,z=0
        cnc     cnci    ;test "cnc"
        adi     0x40    ;a=53h,c=0,p=1,s=0,z=0
        rp              ;test "rp"
        call    cpuer
cnci:   rc              ;test "rc"
        adi     0x8f    ;a=08h,c=1,p=0,s=0,z=0
        cc      cci     ;test "cc"
        sui     0x02    ;a=13h,c=0,p=0,s=0,z=0
        rnc             ;test "rnc"
        call    cpuer
cci:    rnc             ;test "rnc"
        adi     0xf7    ;a=ffh,c=0,p=1,s=1,z=0
        cnz     cnzi    ;test "cnz"
        adi     0xfe    ;a=15h,c=1,p=0,s=0,z=0
        rc              ;test "rc"
        call    cpuer
cnzi:   rz              ;test "rz"
        adi     0x01    ;a=00h,c=1,p=1,s=0,z=1
        cz      czi     ;test "cz"
        adi     0xd0    ;a=17h,c=1,p=1,s=0,z=0
        rnz             ;test "rnz"
        call    cpuer
czi:    rnz             ;test "rnz"
        adi     0x47    ;a=47h,c=0,p=1,s=0,z=0
        cpi     0x47    ;a=47h,c=0,p=1,s=0,z=1
        rz              ;test "rz"
        call    cpuer
;
;
;
;test "mov","inr",and "dcr" instructions
;
movi:   mvi     a,0x77
        inr     a
        mov     b,a
        inr     b
        mov     c,b
        dcr     c
        mov     d,c
        mov     e,d
        mov     h,e
        mov     l,h
        mov     a,l     ;test "mov" a,l,h,e,d,c,b,a
        dcr     a
        mov     c,a
        mov     e,c
        mov     l,e
        mov     b,l
        mov     d,b
        mov     h,d
        mov     a,h     ;test "mov" a,h,d,b,l,e,c,a
        mov     d,a
        inr     d
        mov     l,d
        mov     c,l
        inr     c
        mov     h,c
        mov     b,h
        dcr     b
        mov     e,b
        mov     a,e     ;test "mov" a,e,b,h,c,l,d,a
        mov     e,a
        inr     e
        mov     b,e
        mov     h,b
        inr     h
        mov     c,h
        mov     l,c
        mov     d,l
        dcr     d
        mov     a,d     ;test "mov" a,d,l,c,h,b,e,a
        mov     h,a
        dcr     h
        mov     d,h
        mov     b,d
        mov     l,b
        inr     l
        mov     e,l
        dcr     e
        mov     c,e
        mov     a,c     ;test "mov" a,c,e,l,b,d,h,a
        mov     l,a
        dcr     l
        mov     h,l
        mov     e,h
        mov     d,e
        mov     c,d
        mov     b,c
        mov     a,b
        cpi     0x77
        cnz     cpuer   ;test "mov" a,b,c,d,e,h,l,a
;
;
;
;test arithmetic and logic instructions
;
        xra     a
        mvi     b,0x01
        mvi     c,0x03
        mvi     d,0x07
        mvi     e,0x0f
        mvi     h,0x1f
        mvi     l,0x3f
        add     b
        add     c
        add     d
        add     e
        add     h
        add     l
        add     a
        cpi     0xf0
        cnz     cpuer   ;test "add" b,c,d,e,h,l,a
        sub     b
        sub     c
        sub     d
        sub     e
        sub     h
        sub     l
        cpi     0x78
        cnz     cpuer   ;test "sub" b,c,d,e,h,l
        sub     a
        cnz     cpuer   ;test "sub" a
        mvi     a,0x80
        add     a
        mvi     b,0x01
        mvi     c,0x02
        mvi     d,0x03
        mvi     e,0x04
        mvi     h,0x05
        mvi     l,0x06
        adc     b
        mvi     b,0x80
        add     b
        add     b
        adc     c
        add     b
        add     b
        adc     d
        add     b
        add     b
        adc     e
        add     b
        add     b
        adc     h
        add     b
        add     b
        adc     l
        add     b
        add     b
        adc     a
        cpi     0x37
        cnz     cpuer   ;test "adc" b,c,d,e,h,l,a
        mvi     a,0x80
        add     a
        mvi     b,0x01
        sbb     b
        mvi     b,0xff
        add     b
        sbb     c
        add     b
        sbb     d
        add     b
        sbb     e
        add     b
        sbb     h
        add     b
        sbb     l
        cpi     0xe0
        cnz     cpuer   ;test "sbb" b,c,d,e,h,l
        mvi     a,0x80
        add     a
        sbb     a
        cpi     0xff
        cnz     cpuer   ;test "sbb" a
        mvi     a,0xff
        mvi     b,0xfe
        mvi     c,0xfc
        mvi     d,0xef
        mvi     e,0x7f
        mvi     h,0xf4
        mvi     l,0xbf
        ana     a
        ana     c
        ana     d
        ana     e
        ana     h
        ana     l
        ana     a
        cpi     0x24
        cnz     cpuer   ;test "ana" b,c,d,e,h,l,a
        xra     a
        mvi     b,0x01
        mvi     c,0x02
        mvi     d,0x04
        mvi     e,0x08
        mvi     h,0x10
        mvi     l,0x20
        ora     b
        ora     c
        ora     d
        ora     e
        ora     h
        ora     l
        ora     a
        cpi     0x3f
        cnz     cpuer   ;test "ora" b,c,d,e,h,l,a
        mvi     a,0
        mvi     h,0x8f
        mvi     l,0x4f
        xra     b
        xra     c
        xra     d
        xra     e
        xra     h
        xra     l
        cpi     0xcf
        cnz     cpuer   ;test "xra" b,c,d,e,h,l
        xra     a
        cnz     cpuer   ;test "xra" a
        mvi     b,0x44
        mvi     c,0x45
        mvi     d,0x46
        mvi     e,0x47
        mvi     h,(temp0 / 0xff)        ;high byte of test memory location
        mvi     l,(temp0 & 0xff)      ;low byte of test memory location
        mov     m,b
        mvi     b,0
        mov     b,m
        mvi     a,0x44
        cmp     b
        cnz     cpuer   ;test "mov" m,b and b,m
        mov     m,d
        mvi     d,0
        mov     d,m
        mvi     a,0x46
        cmp     d
        cnz     cpuer   ;test "mov" m,d and d,m
        mov     m,e
        mvi     e,0
        mov     e,m
        mvi     a,0x47
        cmp     e
        cnz     cpuer   ;test "mov" m,e and e,m
        mov     m,h
        mvi     h,(temp0 / 0xff)
        mvi     l,(temp0 & 0xff)
        mov     h,m
        mvi     a,(temp0 / 0xff)
        cmp     h
        cnz     cpuer   ;test "mov" m,h and h,m
        mov     m,l
        mvi     h,(temp0 / 0xff)
        mvi     l,(temp0 & 0xff)
        mov     l,m
        mvi     a,(temp0 & 0xff)
        cmp     l
        cnz     cpuer   ;test "mov" m,l and l,m
        mvi     h,(temp0 / 0xff)
        mvi     l,(temp0 & 0xff)
        mvi     a,0x32
        mov     m,a
        cmp     m
        cnz     cpuer   ;test "mov" m,a
        add     m
        cpi     0x64
        cnz     cpuer   ;test "add" m
        xra     a
        mov     a,m
        cpi     0x32
        cnz     cpuer   ;test "mov" a,m
        mvi     h,(temp0 / 0xff)
        mvi     l,(temp0 & 0xff)
        mov     a,m
        sub     m
        cnz     cpuer   ;test "sub" m
        mvi     a,0x80
        add     a
        adc     m
        cpi     0x33
        cnz     cpuer   ;test "adc" m
        mvi     a,0x80
        add     a
        sbb     m
        cpi     0xcd
        cnz     cpuer   ;test "sbb" m
        ana     m
        cnz     cpuer   ;test "ana" m
        mvi     a,0x25
        ora     m
        cpi     0x37
        cnz     cpuer   ;test "ora" m
        xra     m
        cpi     0x05
        cnz     cpuer   ;test "xra" m
        mvi     m,0x55
        inr     m
        dcr     m
        add     m
        cpi     0x5a
        cnz     cpuer   ;test "inr","dcr",and "mvi" m
        lxi     bc,0x12ff
        lxi     de,0x12ff
        lxi     hl,0x12ff
        inx     bc
        inx     de
        inx     hl
        mvi     a,0x13
        cmp     b
        cnz     cpuer   ;test "lxi" and "inx" b
        cmp     d
        cnz     cpuer   ;test "lxi" and "inx" d
        cmp     h
        cnz     cpuer   ;test "lxi" and "inx" h
        mvi     a,0
        cmp     c
        cnz     cpuer   ;test "lxi" and "inx" b
        cmp     e
        cnz     cpuer   ;test "lxi" and "inx" d
        cmp     l
        cnz     cpuer   ;test "lxi" and "inx" h
        dcx     bc
        dcx     de
        dcx     hl
        mvi     a,0x12
        cmp     b
        cnz     cpuer   ;test "dcx" b
        cmp     d
        cnz     cpuer   ;test "dcx" d
        cmp     h
        cnz     cpuer   ;test "dcx" h
        mvi     a,0xff
        cmp     c
        cnz     cpuer   ;test "dcx" b
        cmp     e
        cnz     cpuer   ;test "dcx" d
        cmp     l
        cnz     cpuer   ;test "dcx" h
        sta     temp0
        xra     a
        lda     temp0
        cpi     0xff
        cnz     cpuer   ;test "lda" and "sta"
        lhld    tempp
        shld    temp0
        lda     tempp
        mov     b,a
        lda     temp0
        cmp     b
        cnz     cpuer   ;test "lhld" and "shld"
        lda     tempp+1
        mov     b,a
        lda     temp0+1
        cmp     b
        cnz     cpuer   ;test "lhld" and "shld"
        mvi     a,0xaa
        sta     temp0
        mov     b,h
        mov     c,l
        xra     a
        ldax    bc
        cpi     0xaa
        cnz     cpuer   ;test "ldax" b
        inr     a
        stax    bc
        lda     temp0
        cpi     0xab
        cnz     cpuer   ;test "stax" b
        mvi     a,0x77
        sta     temp0
        lhld    tempp
        lxi     de,0x0000
        xchg
        xra     a
        ldax    de
        cpi     0x77
        cnz     cpuer   ;test "ldax" d and "xchg"
        xra     a
        add     h
        add     l
        cnz     cpuer   ;test "xchg"
        mvi     a,0xcc
        stax    de
        lda     temp0
        cpi     0xcc
        stax    de
        lda     temp0
        cpi     0xcc
        cnz     cpuer   ;test "stax" d
        lxi     hl,0x7777
        dad     hl
        mvi     a,0xee
        cmp     h
        cnz     cpuer   ;test "dad" h
        cmp     l
        cnz     cpuer   ;test "dad" h
        lxi     hl,0x5555
        lxi     bc,0xffff
        dad     bc
        mvi     a,0x55
        cnc     cpuer   ;test "dad" b
        cmp     h
        cnz     cpuer   ;test "dad" b
        mvi     a,0x54
        cmp     l
        cnz     cpuer   ;test "dad" b
        lxi     hl,0xaaaa
        lxi     de,0x3333
        dad     de
        mvi     a,0xdd
        cmp     h
        cnz     cpuer   ;test "dad" d
        cmp     l
        cnz     cpuer   ;test "dad" b
        stc
        cnc     cpuer   ;test "stc"
        cmc
        cc      cpuer   ;test "cmc
        mvi     a,0xaa
        cma     
        cpi     0x55
        cnz     cpuer   ;test "cma"
        ora     a       ;re-set auxiliary carry
        daa
        cpi     0x55
        cnz     cpuer   ;test "daa"
        mvi     a,0x88
        add     a
        daa
        cpi     0x76
        cnz     cpuer   ;test "daa"
        xra     a
        mvi     a,0xaa
        daa
        cnc     cpuer   ;test "daa"
        cpi     0x10
        cnz     cpuer   ;test "daa"
        xra     a
        mvi     a,0x9a
        daa
        cnc     cpuer   ;test "daa"
        cnz     cpuer   ;test "daa"
        stc
        mvi     a,0x42
        rlc
        cc      cpuer   ;test "rlc" for re-set carry
        rlc
        cnc     cpuer   ;test "rlc" for set carry
        cpi     0x09
        cnz     cpuer   ;test "rlc" for rotation
        rrc
        cnc     cpuer   ;test "rrc" for set carry
        rrc
        cpi     0x42
        cnz     cpuer   ;test "rrc" for rotation
        ral
        ral
        cnc     cpuer   ;test "ral" for set carry
        cpi     0x08
        cnz     cpuer   ;test "ral" for rotation
        rar
        rar
        cc      cpuer   ;test "rar" for re-set carry
        cpi     0x02
        cnz     cpuer   ;test "rar" for rotation
        lxi     bc,0x1234
        lxi     de,0xaaaa
        lxi     hl,0x5555
        xra     a
        push    b
        push    d
        push    h
        push    psw
        lxi     bc,0x0000
        lxi     de,0x0000
        lxi     hl,0x0000
        mvi     a,0xc0
        adi     0xf0
        pop     psw
        pop     h
        pop     d
        pop     b
        cc      cpuer   ;test "push psw" and "pop psw"
        cnz     cpuer   ;test "push psw" and "pop psw"
        cpo     cpuer   ;test "push psw" and "pop psw"
        cm      cpuer   ;test "push psw" and "pop psw"
        mvi     a,0x12
        cmp     b
        cnz     cpuer   ;test "push b" and "pop b"
        mvi     a,0x34
        cmp     c
        cnz     cpuer   ;test "push b" and "pop b"
        mvi     a,0xaa
        cmp     d
        cnz     cpuer   ;test "push d" and "pop d"
        cmp     e
        cnz     cpuer   ;test "push d" and "pop d"
        mvi     a,0x55
        cmp     h
        cnz     cpuer   ;test "push h" and "pop h"
        cmp     l
        cnz     cpuer   ;test "push h" and "pop h"
        lxi     hl,0x0000
        dad     sp
        shld    savstk  ;save the "old" stack-pointer;
        lxi     sp,temp4
        dcx     sp
        dcx     sp
        inx     sp
        dcx     sp
        mvi     a,0x55
        sta     temp2
        cma
        sta     temp3
        pop     b
        cmp     b
        cnz     cpuer   ;test "lxi","dad","inx",and "dcx" sp
        cma
        cmp     c
        cnz     cpuer   ;test "lxi","dad","inx", and "dcx" sp
        lxi     hl,temp4
        sphl
        lxi     hl,0x7733
        dcx     sp
        dcx     sp
        xthl
        lda     temp3
        cpi     0x77
        cnz     cpuer   ;test "sphl" and "xthl"
        lda     temp2
        cpi     0x33
        cnz     cpuer   ;test "sphl" and "xthl"
        mvi     a,0x55
        cmp     l
        cnz     cpuer   ;test "sphl" and "xthl"
        cma
        cmp     h
        cnz     cpuer   ;test "sphl" and "xthl"
        lhld    savstk  ;restore the "old" stack-pointer
        sphl
        lxi     hl,cpuok
        pchl            ;test "pchl"

cpuer:
	mvi	a, 'E'   	; hope these work ;-)
	out	0x11
	mvi	a, 'R'
	out	0x11
	mvi	a, 13
	out	0x11
	mvi	a, 10
	out	0x11

	mvi     a, 0xaa  ; set exit code (failure)
        hlt             ; stop here

cpuok:
	mvi	a, 'O'
	out	0x11
	mvi	a, 'K'
	out	0x11
	mvi	a, 13
	out	0x11
	mvi	a, 10
	out	0x11
	mvi     a, 0x55  
        hlt             ; stop here - no trap

;
; Data area in variable space
;
temp0:  db   0       ;temporary storage for cpu test memory locations
temp1:  db   0       ;temporary storage for cpu test memory locations
temp2:  db   0       ;temporary storage for cpu test memory locations
temp3:  db   0       ;temporary storage for cpu test memory locations
temp4:  db   0       ;temporary storage for cpu test memory locations
savstk: dw   0       ;temporary stack-pointer storage location

tempp:  dw    temp0   ;pointer used to test "lhld","shld",
	



	END
	