* FERNANDO MORAES   -  PUCRS
* revisao em 08/setembro/2026 - tecnologia 28 nm
*************************************************************
*              ==> entrada 1 e' a mais proxima do gnd 
*              ==> entrada 2 a mais proxima da saida
*              ==> demais entradas fixas em '1' para o transistor N conduzir
*
* COMPLETAR a avaliação dos tempos de subida e descida - **LER** os comentarios
*************************************************************
simulator lang=spectre insensitive=no
include "/soft64/spectre28/toplevel.scs"  section=top_tt
simulator lang=spice

.param  wp=0.2u  mob=1.3    Cload=3fF

.SUBCKT nand2 o1 s1 s2 vcc
M1   o1 s1 vcc vcc pch_mac w=wp         l=30n
M2   o1 s2 vcc vcc pch_mac w=wp         l=30n
M3   0  s1 2   0   nch_mac w='wp*2/mob' l=30n
M4   2  s2 o1  0   nch_mac w='wp*2/mob' l=30n
.ENDS nand2

.SUBCKT nand3 o1 s1 s2 s3 vcc
M1   o1 s1 vcc vcc pch_mac  w=wp         l=30n
M2   o1 s2 vcc vcc pch_mac  w=wp         l=30n
M3   o1 s3 vcc vcc pch_mac  w=wp         l=30n
M10  0  s1 4   0   nch_mac  w='wp*2/mob' l=30n
M11  4  s3 2   0   nch_mac  w='wp*2/mob' l=30n
M12  2  s2 o1  0   nch_mac  w='wp*2/mob' l=30n 
.ENDS nand3

.SUBCKT nand4 o1 s1 s2 s3 s4 vcc
M1   o1 s1 vcc vcc pch_mac  w=wp         l=30n
M2   o1 s2 vcc vcc pch_mac  w=wp         l=30n
M3   o1 s3 vcc vcc pch_mac  w=wp         l=30n
M4   o1 s4 vcc vcc pch_mac  w=wp         l=30n
M9   0  s1 6   0   nch_mac  w='wp*2/mob' l=30n 
M10  6  s4 4   0   nch_mac  w='wp*2/mob' l=30n 
M11  4  s3 2   0   nch_mac  w='wp*2/mob' l=30n  
M12  2  s2 o1  0   nch_mac  w='wp*2/mob' l=30n 
.ENDS nand4

.SUBCKT nand5 o1 s1 s2 s3 s4 s5 vcc
M1   o1 s1 vcc vcc pch_mac  w=wp          l=30n
M2   o1 s2 vcc vcc pch_mac  w=wp          l=30n
M3   o1 s3 vcc vcc pch_mac  w=wp          l=30n
M4   o1 s4 vcc vcc pch_mac  w=wp          l=30n
M5   o1 s5 vcc vcc pch_mac  w=wp          l=30n
M8   0  s1 8   0   nch_mac  w='wp*2/mob'  l=30n 
M9   8  s5 6   0   nch_mac  w='wp*2/mob'  l=30n 
M10  6  s4 4   0   nch_mac  w='wp*2/mob'  l=30n 
M11  4  s3 2   0   nch_mac  w='wp*2/mob'  l=30n  
M12  2  s2 o1  0   nch_mac  w='wp*2/mob'  l=30n   
.ENDS nand5

.SUBCKT nand6 o1 s1 s2 s3 s4 s5 s6 vcc
M1   o1 s1 vcc vcc pch_mac  w=wp         l=30n
M2   o1 s2 vcc vcc pch_mac  w=wp         l=30n
M3   o1 s3 vcc vcc pch_mac  w=wp         l=30n
M4   o1 s4 vcc vcc pch_mac  w=wp         l=30n
M5   o1 s5 vcc vcc pch_mac  w=wp         l=30n
M6   o1 s6 vcc vcc pch_mac  w=wp         l=30n
M7   0  s1 10  0   nch_mac  w='wp*2/mob' l=30n 
M8   10 s6 8   0   nch_mac  w='wp*2/mob' l=30n 
M9   8  s5 6   0   nch_mac  w='wp*2/mob' l=30n 
M10  6  s4 4   0   nch_mac  w='wp*2/mob' l=30n 
M11  4  s3 2   0   nch_mac  w='wp*2/mob' l=30n 
M12  2  s2 o1  0   nch_mac  w='wp*2/mob' l=30n 
.ENDS nand6

** circuito propriamente dito
X1 o2 i1 i2 vcc nand2
X2 o3 i1 i2 i3 vcc nand3
X3 o4 i1 i2 i3 i4 vcc nand4
X4 o5 i1 i2 i3 i4 i5 vcc nand5
X5 o6 i1 i2 i3 i4 i5 i6 vcc nand6

** caps de saida
Cl1 o2 0 Cload
Cl2 o3 0 Cload
Cl3 o4 0 Cload
Cl4 o5 0 Cload
Cl5 o6 0 Cload

** alimentações
vcc  vcc 0  dc 0.9
v1 i1 0 pwl(0 0.9   3n   0.9   3.003n 0 3.25n 0   3.253n 0.9)
v2 i2 0 pwl(0 0.9  4.5n  0.9   4.503n 0 4.75n 0   4.753n 0.9)
v3 i3  0  dc 0.9
v4 i4  0  dc 0.9
v5 i5  0  dc 0.9
v6 i6  0  dc 0.9

.tran 0.001N 10N

**
* mede o tempo para a nand de 2 entradas - os tempos em picosegundos são os que interessam
**
.measure tran n2_descida_gnd trig v(i1)  val=0.45  td=2n rise = 1      targ v(o2)  val=0.45        fall = 1
.measure tran n2_descida_out trig v(i2)  val=0.45  td=2n rise = 1      targ v(o2)  val=0.45        fall = 2
.measure tran n2_subida_gnd  trig v(i1)  val=0.45  td=2n fall = 1      targ v(o2)  val=0.45        rise = 1
.measure tran n2_subida_out  trig v(i2)  val=0.45  td=2n fall = 1      targ v(o2)  val=0.45        rise = 2

.measure tran t2_Fs   param = '1e12*n2_descida_gnd'
.measure tran t2_Fo   param = '1e12*n2_descida_out' 
.measure tran t2_Rs   param = '1e12*n2_subida_gnd'
.measure tran t2_Ro   param = '1e12*n2_subida_out'



**
*  COMPLETAR AQUI COM AS MEDIDAS PARA A NAND DE 3 ENTRADAS  (trocar o nome das medidas e o2 por o3)
**



**
*  COMPLETAR AQUI COM AS MEDIDAS PARA A NAND DE 4 ENTRADAS (trocar o nome das medidas e o2 por o4)
**

**
*  COMPLETAR AQUI COM AS MEDIDAS PARA A NAND DE 5 ENTRADAS (trocar o nome das medidas e o2 por o5)
**

**
*  COMPLETAR AQUI COM AS MEDIDAS PARA A NAND DE 6 ENTRADAS (trocar o nome das medidas e o2 por o5)
**
 
.END

