* FERNANDO MORAES   PUCRS
* Inverter - Effect of the input ramp (slew)

.include inv.sp


X1 i1 o1 vcc inv
X2 i2 o2 vcc inv
X3 i3 o3 vcc inv
X4 i4 o4 vcc inv
X5 i5 o5 vcc inv

C1 o1 0 3fF
C2 o2 0 3fF
C3 o3 0 3fF
C4 o4 0 3fF
C5 o5 0 3fF

vin1 i1  0  pulse (1 0 1.298n 0.002N 0.002N  1N 2N)
vin2 i2  0  pulse (1 0 1.28n 0.02N  0.02N   1N 2N)
vin3 i3  0  pulse (1 0 1.22n 0.08N  0.08N   1N 2N)
vin4 i4  0  pulse (1 0 1.15n 0.15N  0.15N   1N 2N)
vin5 i5  0  pulse (1 0 1.0n 0.3N   0.3N    1N 2N)

.tran 0.001N 25N


* Measure the propagation times
.measure tran pd1 trig v(i1)  val=0.5 td=5n rise = 1 
+                 targ v(o1)  val=0.5       fall = 1
.measure tran ps1 trig v(i1)  val=0.5 td=5n fall = 1 
+                 targ v(o1)  val=0.5       rise = 1

.measure tran pd2 trig v(i2)  val=0.5 td=5n rise = 1 
+                 targ v(o2)  val=0.5       fall = 1
.measure tran ps2 trig v(i2)  val=0.5 td=5n fall = 1 
+                 targ v(o2)  val=0.5       rise = 1

.measure tran pd3 trig v(i3)  val=0.5 td=5n rise = 1 
+                 targ v(o3)  val=0.5       fall = 1
.measure tran ps3 trig v(i3)  val=0.5 td=5n fall = 1 
+                 targ v(o3)  val=0.5       rise = 1

.measure tran pd4 trig v(i4)  val=0.5 td=5n rise = 1 
+                 targ v(o4)  val=0.5       fall = 1
.measure tran ps4 trig v(i4)  val=0.5 td=5n fall = 1 
+                 targ v(o4)  val=0.5       rise = 1

.measure tran pd5 trig v(i5)  val=0.5 td=5n rise = 1 
+                 targ v(o5)  val=0.5       fall = 1
.measure tran ps5 trig v(i5)  val=0.5 td=5n fall = 1 
+                 targ v(o5)  val=0.5       rise = 1

.measure tran TD1   param = 'pd1 * 1e12'
.measure tran TS1   param = 'ps1 * 1e12'
.measure tran TD2   param = 'pd2 * 1e12'
.measure tran TS2   param = 'ps2 * 1e12'
.measure tran TD3   param = 'pd3 * 1e12'
.measure tran TS3   param = 'ps3 * 1e12'
.measure tran TD4   param = 'pd4 * 1e12'
.measure tran TS4   param = 'ps4 * 1e12'
.measure tran TD5   param = 'pd5 * 1e12'
.measure tran TS5   param = 'ps5 * 1e12'

.param wp=0.5 wn=0.2

.END
