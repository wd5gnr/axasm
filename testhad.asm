	;;  Test program for hackaday badge
	ORG 0
	MVI R0,0xA
	MOV R1,2
loop:	ADD R0,R1
	JR loop
halt:	JR halt
	END
	
	
