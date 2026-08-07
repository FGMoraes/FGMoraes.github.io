* FERNANDO MORAES   PUCRS
* Inverter - Calculation of the ring oscillator period

.include inv.sp

X1   o  a   vcc inv
X2   a  b   vcc inv

. . . completar aqui com mais instancias de inversores

X15  n  o  vcc inv


.ic v(o)=0 

.tran 0.001N 20N

***** medida 1 *****************************************************************

.measure tran tf  trig v(n)  val=0.5  td=1n rise = 10
+                 targ v(o)  val=0.5        fall = 10
.measure tran tr  trig v(n)  val=0.5  td=1n fall = 10
+                 targ v(o)  val=0.5        rise = 10

.measure tran periodo  param = '(tf+tr) * 1e9 * 15'
.measure tran freq     param = '1/periodo'
 

*** medida 2 *****************************************************************
 
.measure tran periodo_o  trig v(o)  val=0.5  td=1n rise = 2
+                        targ v(o)  val=0.5       rise = 3

.param wp=0.5 wn='wp/2.25'


.end
