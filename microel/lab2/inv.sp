* FERNANDO MORAES   PUCRS
* Description of the technology, the Inverter, and the main power supply

simulator lang=spectre insensitive=no
include "st65.scs"
simulator lang=spice

* Description of the inverter in the form of a subcircuit
.subckt inv in out  vcc
M1 out in vcc  vcc   psvtgp w=wp l=0.06
M2 out in 0    0     nsvtgp w=wn l=0.06
.ends inv

vcc vcc  0  dc 1.0