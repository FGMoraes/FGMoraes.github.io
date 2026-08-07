* FUNCAO DE TRANSFERENCIA 
* FERNANDO MORAES -  PUCRS

* modelo elétrico para uma tecnologia 0.35 um
.include tsmc035.mod

**
** 1 transistor apenas. observar que o W do transistor
** é definido como um parâmetro "wrt"
**
M1 dreno gate 0 0 nmos l=0.35e-6 W=wtr    AD=4.0P     AS=4.0P    PD=6.0U   PS=6.0U 

vds  3 0 dc 2.5
v3   3 dreno

vgs  gate 0
.dc  vgs 0 2.5 .1

.param wtr=1e-6
.alter
.param wtr=2e-6
.alter
.param wtr=4e-6
.alter
.param wtr=6e-6
.alter
.param wtr=8e-6

.END