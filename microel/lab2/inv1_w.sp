* FERNANDO MORAES   PUCRS
* Inverter - simulation with variation in the sizing of the P transistors (Wp)

.include inv.sp

 
*
* Circuit description
*
X1  iv out vcc inv
C1  out  0 5fF

*
* Power supply/stimulus sources
*
vin1 iv  0  pulse (1 0 0 0.02N 0.02N 1N 2N) 


.tran 0.001N 25N

* Measure the propagation times
.measure tran pHL trig v(iv)  val=0.5  td=5n rise = 1 
+                 targ v(out) val=0.5        fall = 1

.measure tran pLH  trig v(iv)  val=0.5  td=5n fall = 1 
+                  targ v(out) val=0.5        rise = 1

.measure tran TD   param = 'pHL * 1e12'
.measure tran TS   param = 'pLH * 1e12'

.measure tran diff  param = 'TD-TS'


.param wp=0.2 wn=0.2
.alter
.param wp=0.4
.alter
.param wp=0.45
.alter
.param wp=0.5
.alter
.param wp=0.6
.alter
.param wp=0.8
.alter
.param wp=1.0


.END

