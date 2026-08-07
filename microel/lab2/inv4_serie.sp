* FERNANDO MORAES   PUCRS
* Inverter - Cascaded inverters – signal regeneration property

.include inv.sp

X1  i  a   vcc inv
X2  a  b   vcc inv
X3  b  c   vcc inv
X4  c  d   vcc inv
X5  d  e   vcc inv
c1 d   0 15fF

vin i  0  pulse (na nb  0   0.02N  0.02N   1N 2N) 

.tran 0.001N 25N

.param wp=0.5 wn=0.2

.param na=0.49  nb=0.51
*.alter
*..param na=novo valor  nb=novo valor
*.alter
*..param na=novo valor  nb=novo valor
.end
