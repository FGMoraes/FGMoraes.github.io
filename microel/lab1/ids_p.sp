* FUNCAO DE TRANSFERENCIA 
* FERNANDO MORAES

* modelo elétrico para uma tecnologia 0.35 um
.include tsmc035.mod

**
** transistor P
**
M2 DN gate vcc vcc pmos l=0.35e-6 W=4.0U    AD=8.0P     AS=8.0P    PD=8.0U   PS=8.0U 

vcc  vcc 0  dc 2.5


*** fonte de tensão apenas para medida de corrente
vdi  DN n3 

*** fonte de tensão entre o dreno e o source, variando de 0 a 2.5 volts
vd   n3 0 
.dc  vd 0 2.5 .1

****  seis valores de tensão aplicados ao gate
vg  gate 0 dc 0
.alter
vg  gate 0 dc 0.5
.alter
vg  gate 0 dc 1.0
.alter
vg  gate 0 dc 1.5
.alter
vg  gate 0 dc 2.0
.alter
vg  gate 0 dc 2.5
.END
