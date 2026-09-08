* circuitos nor
* FERNANDO MORAES   -  PUCRS
* revisao em 08/setembro/2026

simulator lang=spectre insensitive=no
include "/soft64/spectre28/toplevel.scs"  section=top_tt
simulator lang=spice

.param Cload=3fF mob=1.3  wn=0.15u  wp='2*wn*mob' 

.SUBCKT nor2    o1  s1  s2  vcc
M1  10  s1  vcc vcc pch_mac w=wp    l=30n
M2  o1  s2  10  vcc pch_mac w=wp    l=30n
M10 0   s1  o1  0   nch_mac w=wn    l=30n
M11 0   s2  o1  0   nch_mac w=wn    l=30n
.ENDS   nor2

* Lembrar: entrada s1 próxima à vcc e entrada s2 próxima à saída
.SUBCKT nor3    o1  s1  s2  s3  vcc   
... completar ...
.ENDS   nor3

.SUBCKT nor4    o1  s1  s2  s3  s4  vcc
... completar ...
.ENDS   nor4

.SUBCKT nor5    o1  s1  s2  s3  s4  s5  vcc
... completar ...
.ENDS   nor5

.SUBCKT nor6    o1  s1  s2  s3  s4  s5  s6  vcc
... completar ...
.ENDS   nor6

** circuito propriamente dito
X1 o2 i1 i2 vcc nor2
X2 o3 i1 i2 i3 vcc nor3
X3 o4 i1 i2 i3 i4 vcc nor4
X4 o5 i1 i2 i3 i4 i5 vcc nor5
X5 o6 i1 i2 i3 i4 i5 i6 vcc nor6

** alimentações
vcc  vcc 0  dc 0.9
v1 i1 0 pwl(... completar ...)
v2 i2 0 pwl(... completar ...)
***  entradas não utilizadas em 0v3 i3  0  dc 0
v4 i4  0  dc 0              
v5 i5  0  dc 0
v6 i6  0  dc 0

.tran 0.001N 10N

Cl1 o2 0 Cload
Cl2 o3 0 Cload
Cl3 o4 0 Cload
Cl4 o5 0 Cload
Cl5 o6 0 Cload

***  SEMANTICA DAS MEDIDAS <porta><subida/descida><entrada proxima da alim ou proxima da saida>

.measure tran n2_subida_vdd  trig v(i1)  val=0.45  td=2n fall = 1      targ v(o2)  val=0.45        rise = 1
.measure tran n2_descida_vdd trig v(i1)  val=0.45  td=2n rise = 1      targ v(o2)  val=0.45        fall = 1
.measure tran n2_subida_out  trig v(i2)  val=0.45  td=2n fall = 1      targ v(o2)  val=0.45        rise = 2
.measure tran n2_descida_out trig v(i2)  val=0.45  td=2n rise = 2      targ v(o2)  val=0.45        fall = 2

.measure tran t2_Fs   param = '1e12*n2_descida_vdd'
.measure tran t2_Fo   param = '1e12*n2_descida_out' 
.measure tran t2_Rs   param = '1e12*n2_subida_vdd'
.measure tran t2_Ro   param = '1e12*n2_subida_out'

 
 ...completar as medidas para outras NOR...


.END
