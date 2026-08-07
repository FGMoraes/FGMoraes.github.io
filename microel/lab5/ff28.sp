********** LAB5 simulação de flip-flops **********
** FERNANDO MORAES   -  PUCRS -  23/maio/2026  ***
******************* TSMC 28 nm *******************

simulator lang=spectre insensitive=no
include "/soft64/spectre28/toplevel.scs"  section=top_tt
simulator lang=spice

****************************************************************************************
** TRANSITOR SIZING AND OUTPUT LOAD USED DURING THIS SIMULATION (NOT MODIFY)
****************************************************************************************
.param wn=0.15u wp=0.2u  CL=2fF

****************************************************************************************
** BASIC GATES USED TO BUILD THE FLOPS  (NOT MODIFY)
****************************************************************************************
.subckt inv in out  vcc
MP1 out in vcc  vcc   pch_mac w=wp l=30n
MN2 out in 0    0     nch_mac w=wn l=30n
.ends inv

.subckt invX4 in out  vcc
MP1 out in vcc  vcc   pch_mac w=wp*4 l=30n
MN2 out in 0    0     nch_mac w=wn*4 l=30n
.ends invX4

.subckt inv_tg in ck nck out  vcc
MP1 1   in  vcc  vcc   pch_mac w=wp l=30n
MP2 out nck 1    vcc   pch_mac w=wp l=30n
MN1 out ck  2    0     nch_mac w=wn l=30n
MN2 2   in  0    0     nch_mac w=wn l=30n
.ends inv_tg

.SUBCKT nand2 s1 s2 o1 vcc
M1 o1 s1 vcc vcc pch_mac w=wp l=30n
M2 o1 s2 vcc vcc pch_mac w=wp l=30n
M3 0  s1 2   0   nch_mac w=wn l=30n
M4 2  s2 o1  0   nch_mac w=wn l=30n
.ENDS nand2

.subckt tg a b nb out vcc
MP1 a  nb out vcc   pch_mac w=wp l=30n
MN1 a   b out 0     nch_mac w=wn l=30n
.ends tg

.subckt clckg CLK clkG vcc
M1 n0 CLK vcc vcc pch_mac w=wp l=30n
M2 n0 clkG 0  0   nch_mac w=wn l=50n
X1 CLK n0 n1 vcc nand2
X2 n1 clkG   vcc inv
.ends clckg

****************************************************************************************
** FLIP-FLOPS DESCRIPTION 
****************************************************************************************
.subckt latch D Q ck nck vcc
X1 D   Y           vcc inv
X2 Y   ck   nck  X vcc tg
X3 X   Z           vcc inv
X4 Z   nck   ck  X vcc inv_tg
X5 X   Q           vcc inv
.ic v(X)=0.9
.ends latch

.subckt ff_static D Q NQ ck nck vcc
* X1 
* X2 
* X3 
* X4 
* X5 
* X6 
* X7 
* X8 
* X9 
.ends ff_static

.subckt ff_tspc D Q nQ ck vcc
* M3
* M2
* M1
* M6
* M5
* M4
* M9
* M8
* M7
* X1
.ends ff_tspc

.subckt ff_pulse d q clkG vcc
* M3 
* M2 
* M1 
* M6 
* M5 
* M4 
.ends ff_pulse

****************************************************************************************
** FLIP-FLOPS INSTANTIATION 
****************************************************************************************

**** circuit 1 - LATCH ***********
X1 D q_latch CK nCK vcc latch
C1 q_latch 0 CL

**** circuit 2 - FLIP-FLOPS MASTER-SLAVE 
.ic v(qE)=0 v(qT)=0 v(qP)=0 v(nqE)=1 v(nqT)=1 v(nqP)=1
* X2  
* X3  
* X4  
X5 CK clkG vcc clckg

** the 3 flops are load by an inverter 
X22 qE qE2 vcc inv
X33 qT qT2 vcc inv
X44 qP qP2 vcc inv
C21 qE2 0 CL
C31 qT2 0 CL
C41 qP2 0 CL

** circuit 3 -counter  **************
.ic v(f0)=0 v(f1)=0 v(f2)=0 v(f3)=0 v(Q0)=0.9 v(Q1)=0.9 v(Q2)=0.9 v(Q3)=0.9
* Xc0 
* Xc1 
* Xc2 
* Xc3 
C5 Q0 0 CL
C6 Q1 0 CL
C7 Q2 0 CL
C8 Q3 0 CL

** circuit 4 – clock divider **************
X6  nqD qD nqD CK nCK vcc ff_static
C61 qD  0 clms

******************************************************************
**  SIMULATION CONTROL AND CLOCK/INPUT SOURCES
******************************************************************

vcc vcc 0 dc 0.9

v1 D 0 pwl(    0n    0     0.3n   0
+            0.303n  0.9   0.7n   0.9
+            0.703n  0     0.9n   0
+            0.903n  0.9   1.3n   0.9
+           1.303n   0       2n   0
+           2.003n   0.9   2.4n   0.9
+           2.403n   0     2.7n   0
+           2.703n   0.9   3.2n   0.9
+           3.203n   0     3.4n   0
+           3.403n   0.9   3.8n   0.9
+           3.803n   0 )

v2 clk 0 pulse( 0 0.9 0.5N 0.03N 0.03N 0.5N 1N)
Xb1 clk  nCK   vcc invX4
Xb2 nCK   CK  vcc invX4

** SIMULATION TIME
.tran .01N 6N

******************************************************************
**  MEASUREMENTS
******************************************************************
.measure tran t_fr trig v(CK) val=0.45 td=0.5n rise = 1 targ v(qE) val=0.45 rise = 1
.measure tran t_fs trig v(CK) val=0.45 td=0.5n rise = 2 targ v(qE) val=0.45 fall = 1

.measure tran t_tr trig v(CK) val=0.45 td=0.5n rise = 1 targ v(qT) val=0.45 rise = 1
.measure tran t_ts trig v(CK) val=0.45 td=0.5n rise = 2 targ v(qT) val=0.45 fall = 1

.measure tran t_pr trig v(clkG) val=0.45 td=0.5n rise = 1 targ v(qP) val=0.45 rise = 1
.measure tran t_ps trig v(clkG) val=0.45 td=0.5n rise = 2 targ v(qP) val=0.45 fall = 1

.measure tran t1_F_FFD     param = 't_fs * 1e12'
.measure tran t1_R_FFD     param = 't_fr * 1e12'
.measure tran t2_F_TSPC    param = 't_ts * 1e12'
.measure tran t2_R_TSPC    param = 't_tr * 1e12'
.measure tran t3_F_PULSADO param = 't_ps * 1e12'
.measure tran t3_R_PULSADO param = 't_pr * 1e12'

.param clms=20fF
*.alter
*.param clms=80fF
*.alter
*.param clms=180fF
.end
