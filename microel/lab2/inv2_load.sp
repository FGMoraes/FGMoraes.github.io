* FERNANDO MORAES   PUCRS
* Inverter - simulation under different load conditions

.include inv.sp

*
*Circuit description
*
X1  iv out  vcc inv
vii out out2
C3  out2  0   cl

vin1 iv  0  pulse (1 0 0 0.01N 0.01N 1N 2N) 

.tran 0.001N 25N

* Measure the propagation times
.measure tran pHL trig v(iv)  val=0.5  td=5n rise = 1 
+                 targ v(out) val=0.5        fall = 1

.measure tran pLH  trig v(iv)  val=0.5  td=5n fall = 1 
+                  targ v(out) val=0.5        rise = 1

.measure cons_medio AVG POWER FROM=0n TO=25n

.measure tran POT  param = 'cons_medio * 1e6'
.measure tran TD   param = 'pHL * 1e12'
.measure tran TS   param = 'pLH * 1e12'


.param wp=0.5 wn=0.2 cl=1fF

.alter
.param cl=3fF
.alter
.param cl=8fF
.alter
.param cl=15fF
.alter
.param cl=25fF
.alter
.param cl=50fF

.END

