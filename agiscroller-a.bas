#RetroDevStudio.MetaData.BASIC:7169,BASIC V7.0 VDC
# THIS PROGRAM LOADS THE SQ1 ARCADA SCENE.
# THE IMAGES SEEMS TO BE DISTORTED
# CURSOR KEYS SCROLL THE SCREEN-RAM BUT ATTRIBUTE-RAM IS FIXED
# A VALUE OF 79 SHOULD GIVE A STABLE IMAGE

10 DEF FN W(ZZ)=PEEK(ZZ)+PEEK(ZZ+1)*256
20 BS=FN W(45)
30 BE=FN W(4624)
# DB:DATA BEGIN
# DE:DATA END
40 DB=BE+1:DE=DB+8000

50 PRINT "BASIC FROM "BS" TO "BE"."
60 PRINT "LEAVES "FRE(0)" BYTES FREE."
70 DD=PEEK(186)

80 PRINT "INSERT DATADISK":GETKEY I$
90 BLOAD "VDCBASIC2.0AC6",B0,U(DD):SYS DEC("AC6")

100 GRAPHIC 0

110 AP=32000

120 RGO 28,16:REM 64K VRAM
130 RGO 25,128:REM BITMAP MODE ON
# 2 SCANLINES PER CHAR, 156 SCANLINES (EACH VAL +1)
140 RGW 0,127:RGW 4,155:RGW 6,100:RGW 7,140:RGW 9,1
150 RGW 36,0

155 RGW 1,80

160 VMF 0,15,AP:REM SETUP PIXELS
170 VMF AP,0,16000: REM CLEAR ATTRIBUTE RAM
180 DISP 0:ATTR AP

190 PF$="SQSCROLL.VDC":A=0:GOSUB 370

# INCREASE VIRTUAL LINESIZE TO 160
210 RGW 27,80

220 PRINT "CURSORS LEFT/RIGHT: MEM START -/+  1"
240 PRINT "R SETS ADDR INC PER ROW TO  0"
250 PRINT "V SETS ADDR INC PER ROW TO 80"


260 X=0:Y=0
270 DO:GETKEY I$
#    CURSOR LEFT/RIGHT
280  IF ASC(I$)=157 THEN IF X>0 THEN X=X-1
290  IF ASC(I$)=29 THEN IF X<80 THEN X=X+1

320  IF I$="R" THEN RGW 27,0
330  IF I$="V" THEN RGW 27,80

340  ATTR AP:DISP X:PRINT X
350 LOOP

360 SLOW:BANK 15:END


370 PRINT "LOADING "PF$" ... ";
380 BLOAD (PF$),B0,P(DB),U(DD)
390 PRINT "DONE"

400 RTV DB,0,32000
410 RTV DB+32000,32000,16000
420 DISP 0
430 ATTR 32000

#400 SP=DB:TP=AP+A:FAST
#410 FOR Y=0 TO 159
#420  RTV SP,TP,80
#430  SP=SP+80:TP=TP+160
#440 NEXT:SLOW
440 SLOW

450 RETURN

