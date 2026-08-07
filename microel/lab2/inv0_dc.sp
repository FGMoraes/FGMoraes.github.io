* FERNANDO MORAES   PUCRS
* Inverter - DC simulation

.include inv.sp

*
* Circuit description
*
X1  iv out vcc inv
C1  out  0 5fF

*
* Power supply connected to the inverter input
*
vin1 iv  0
.dc vin1 0 1 .001

*
* Change in the transistors W (width)
*
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
