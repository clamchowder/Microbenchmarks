.text
.global clktest
.global noptest
.global addtest
.global faddtest
.global faddlattest
.global vaddtest
.global vaddlattest
.global xaddtest
.global xaddlattest
.global multest
.global mullattest
.global fmultest
.global fmullattest
.global vmultest
.global vmullattest
.global xmultest
.global xmullattest
.global divtest
.global divlattest
.global fdivtest
.global fdivlattest
.global fmatest
.global fmalattest
.global vfmatest
.global vfmalattest
.global xfmatest
.global xfmalattest
.global fadd_fmultest
.global fadd_multest
.global fadd_mul_multest
.global fadd_fmul_fmultest
.global fma_faddtest
.global fma_fmultest
.global fma_fmul_faddtest
.global fma_fmul21test
.global loadtest
.global storetest
.global load_storetest

.global mixgr2frvecaddtest
.global mixgr2frfaddtest
.global mixgr2frfmultest
.global gr2frlattest
.global gr2frtest
.global mixgr2frtest
.global fr2grtest
.global gr2xrlattest
.global xvpermilattest
.global xvpermitest
.global mixstorefaddtest
.global mixstorefmultest
.global mixstorevecaddtest
.global xvxortest
.global xvxorlattest
.global xvfaddtest
.global xvfaddlattest
.global xvfmultest
.global xvfmullattest
.global vfaddtest
.global vfmultest 
.global xvslltest
.global xvslllattest

clktest:
  xor $r12, $r12, $r12
  xor $r13, $r13, $r13   /* r13 is just zero */
  xor $r14, $r14, $r14
  addi.d $r14, $r14, 20
  addi.d $r12, $r12, 1
clktest_loop:
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  add.d $r12, $r12, $r12
  sub.d $r4, $r4, $r14       /* iteration count = iteration count - 20 */
  bge $r4, $r13, clktest_loop /* if iteration count > 0, jump back to loop */
  jr $r1

/* r4 = iteration count */
noptest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  addi.d $r14, $r14, 20
noptest_loop:
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  sub.d $r4, $r4, $r14
  bge $r4, $r13, noptest_loop
  jr $r1

/* r4 = iteration count */
addtest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
addtest_loop:
  add.d $r12, $r12, $r14
  add.d $r13, $r13, $r14
  add.d $r15, $r15, $r14
  add.d $r16, $r16, $r14
  add.d $r17, $r17, $r14
  add.d $r12, $r12, $r14
  add.d $r13, $r13, $r14
  add.d $r15, $r15, $r14
  add.d $r16, $r16, $r14
  add.d $r17, $r17, $r14
  add.d $r12, $r12, $r14
  add.d $r13, $r13, $r14
  add.d $r15, $r15, $r14
  add.d $r16, $r16, $r14
  add.d $r17, $r17, $r14
  add.d $r12, $r12, $r14
  add.d $r13, $r13, $r14
  add.d $r15, $r15, $r14
  add.d $r16, $r16, $r14
  add.d $r17, $r17, $r14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, addtest_loop
  jr $r1


/* r4 = iteration count */
faddtest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
faddtest_loop:
  fadd.d $f12, $f12, $f14
  fadd.d $f13, $f13, $f14
  fadd.d $f15, $f15, $f14
  fadd.d $f16, $f16, $f14
  fadd.d $f17, $f17, $f14
  fadd.d $f12, $f12, $f14
  fadd.d $f13, $f13, $f14
  fadd.d $f15, $f15, $f14
  fadd.d $f16, $f16, $f14
  fadd.d $f17, $f17, $f14
  fadd.d $f12, $f12, $f14
  fadd.d $f13, $f13, $f14
  fadd.d $f15, $f15, $f14
  fadd.d $f16, $f16, $f14
  fadd.d $f17, $f17, $f14
  fadd.d $f12, $f12, $f14
  fadd.d $f13, $f13, $f14
  fadd.d $f15, $f15, $f14
  fadd.d $f16, $f16, $f14
  fadd.d $f17, $f17, $f14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, faddtest_loop
  jr $r1


faddlattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
faddlattest_loop:
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  fadd.d $f18, $f18, $f18
  sub.d $r4, $r4, $r14
  bge $r4, $r18, faddlattest_loop
  jr $r1


vaddtest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
vaddtest_loop:
  vadd.d $vr12, $vr12, $vr14
  vadd.d $vr13, $vr13, $vr14
  vadd.d $vr15, $vr15, $vr14
  vadd.d $vr16, $vr16, $vr14
  vadd.d $vr17, $vr17, $vr14
  vadd.d $vr12, $vr12, $vr14
  vadd.d $vr13, $vr13, $vr14
  vadd.d $vr15, $vr15, $vr14
  vadd.d $vr16, $vr16, $vr14
  vadd.d $vr17, $vr17, $vr14
  vadd.d $vr12, $vr12, $vr14
  vadd.d $vr13, $vr13, $vr14
  vadd.d $vr15, $vr15, $vr14
  vadd.d $vr16, $vr16, $vr14
  vadd.d $vr17, $vr17, $vr14
  vadd.d $vr12, $vr12, $vr14
  vadd.d $vr13, $vr13, $vr14
  vadd.d $vr15, $vr15, $vr14
  vadd.d $vr16, $vr16, $vr14
  vadd.d $vr17, $vr17, $vr14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, vaddtest_loop
  jr $r1


vaddlattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
vaddlattest_loop:
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  vadd.d $vr18, $vr18, $vr18
  sub.d $r4, $r4, $r14
  bge $r4, $r18, vaddlattest_loop
  jr $r1


xaddtest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
xaddtest_loop:
  xvadd.d $xr12, $xr12, $xr14
  xvadd.d $xr13, $xr13, $xr14
  xvadd.d $xr15, $xr15, $xr14
  xvadd.d $xr16, $xr16, $xr14
  xvadd.d $xr17, $xr17, $xr14
  xvadd.d $xr12, $xr12, $xr14
  xvadd.d $xr13, $xr13, $xr14
  xvadd.d $xr15, $xr15, $xr14
  xvadd.d $xr16, $xr16, $xr14
  xvadd.d $xr17, $xr17, $xr14
  xvadd.d $xr12, $xr12, $xr14
  xvadd.d $xr13, $xr13, $xr14
  xvadd.d $xr15, $xr15, $xr14
  xvadd.d $xr16, $xr16, $xr14
  xvadd.d $xr17, $xr17, $xr14
  xvadd.d $xr12, $xr12, $xr14
  xvadd.d $xr13, $xr13, $xr14
  xvadd.d $xr15, $xr15, $xr14
  xvadd.d $xr16, $xr16, $xr14
  xvadd.d $xr17, $xr17, $xr14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, xaddtest_loop
  jr $r1

xaddlattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
xaddlattest_loop:
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18
  xvadd.d $xr18, $xr18, $xr18

  sub.d $r4, $r4, $r14
  bge $r4, $r18, xaddlattest_loop
  jr $r1



/* r4 = iteration count 
   r5 = sink arr
*/
multest:
  xor $r14, $r14, $r14
  addi.d $r14, $r14, 20
  xor $r13, $r13, $r13
  addi.d $r13, $r13, 2
  move $r12, $r13
  move $r15, $r13

  st.d $r16, $r5, 0
  st.d $r17, $r5, 8
  st.d $r18, $r5, 16 
  st.d $r19, $r5, 24 
  st.d $r20, $r5, 32 
  st.d $r21, $r5, 40 
  st.d $r22, $r5, 48 
  st.d $r23, $r5, 56 

  move $r16, $r13
  move $r17, $r13
  move $r18, $r13
  move $r19, $r13
  move $r20, $r13
  move $r21, $r13
  move $r22, $r13
  move $r23, $r13
multest_loop:
  mul.d $r12, $r12, $r14
  mul.d $r13, $r13, $r14
  mul.d $r15, $r15, $r14
  mul.d $r16, $r16, $r14
  mul.d $r17, $r17, $r14
  mul.d $r18, $r18, $r14
  mul.d $r19, $r19, $r14
  mul.d $r20, $r20, $r14
  mul.d $r21, $r21, $r14
  mul.d $r22, $r22, $r14
  mul.d $r12, $r12, $r14
  mul.d $r13, $r13, $r14
  mul.d $r15, $r15, $r14
  mul.d $r16, $r16, $r14
  mul.d $r17, $r17, $r14
  mul.d $r18, $r18, $r14
  mul.d $r19, $r19, $r14
  mul.d $r20, $r20, $r14
  mul.d $r21, $r21, $r14
  mul.d $r22, $r22, $r14
  sub.d $r4, $r4, $r14
  bge $r4, $r0, multest_loop
  ld.d $r16, $r5, 0
  ld.d $r17, $r5, 8
  ld.d $r18, $r5, 16 
  ld.d $r19, $r5, 24 
  ld.d $r20, $r5, 32 
  ld.d $r21, $r5, 40 
  ld.d $r22, $r5, 48 
  ld.d $r23, $r5, 56 

  jr $r1


mullattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r18, $r18, 3
  addi.d $r14, $r14, 20
mullattest_loop:
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  mul.d $r18, $r18, $r18
  sub.d $r4, $r4, $r14
  bge $r4, $r0, mullattest_loop
  jr $r1

fmultest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
fmultest_loop:
  fmul.d $f8, $f8, $f14
  fmul.d $f9, $f9, $f14
  fmul.d $f10, $f10, $f14
  fmul.d $f11, $f11, $f14
  fmul.d $f12, $f12, $f14
  fmul.d $f13, $f13, $f14
  fmul.d $f15, $f15, $f14
  fmul.d $f16, $f16, $f14
  fmul.d $f17, $f17, $f14
  fmul.d $f18, $f18, $f14
  fmul.d $f19, $f19, $f14
  fmul.d $f20, $f20, $f14
  fmul.d $f21, $f21, $f14
  fmul.d $f22, $f22, $f14
  fmul.d $f23, $f23, $f14
  fmul.d $f8, $f8, $f14
  fmul.d $f9, $f9, $f14
  fmul.d $f10, $f10, $f14
  fmul.d $f11, $f11, $f14
  fmul.d $f12, $f12, $f14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, fmultest_loop
  jr $r1

fmullattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
fmullattest_loop:
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  fmul.d $f18, $f18, $f18
  sub.d $r4, $r4, $r14
  bge $r4, $r18, fmullattest_loop
  jr $r1


vmultest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
vmultest_loop:
  vmul.d $vr12, $vr12, $vr14
  vmul.d $vr13, $vr13, $vr14
  vmul.d $vr15, $vr15, $vr14
  vmul.d $vr16, $vr16, $vr14
  vmul.d $vr17, $vr17, $vr14
  vmul.d $vr12, $vr12, $vr14
  vmul.d $vr13, $vr13, $vr14
  vmul.d $vr15, $vr15, $vr14
  vmul.d $vr16, $vr16, $vr14
  vmul.d $vr17, $vr17, $vr14
  vmul.d $vr12, $vr12, $vr14
  vmul.d $vr13, $vr13, $vr14
  vmul.d $vr15, $vr15, $vr14
  vmul.d $vr16, $vr16, $vr14
  vmul.d $vr17, $vr17, $vr14
  vmul.d $vr12, $vr12, $vr14
  vmul.d $vr13, $vr13, $vr14
  vmul.d $vr15, $vr15, $vr14
  vmul.d $vr16, $vr16, $vr14
  vmul.d $vr17, $vr17, $vr14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, vmultest_loop
  jr $r1



vmullattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
vmullattest_loop:
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  vmul.d $vr18, $vr18, $vr18
  sub.d $r4, $r4, $r14
  bge $r4, $r18, vmullattest_loop
  jr $r1


xmultest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
  xvld $xr8, $r5, 0
  xvld $xr9, $r5, 0
  xvld $xr10, $r5, 0
  xvld $xr11, $r5, 0
  xvld $xr12, $r5, 0
  xvld $xr13, $r5, 0
  xvld $xr14, $r5, 0
  xvld $xr15, $r5, 0
  xvld $xr16, $r5, 0
  xvld $xr17, $r5, 0
  xvld $xr18, $r5, 0
xmultest_loop:
  xvmul.d $xr8, $xr8, $xr14
  xvmul.d $xr9, $xr9, $xr14
  xvmul.d $xr10, $xr10, $xr14
  xvmul.d $xr11, $xr11, $xr14
  xvmul.d $xr12, $xr12, $xr14
  xvmul.d $xr13, $xr13, $xr14
  xvmul.d $xr15, $xr15, $xr14
  xvmul.d $xr16, $xr16, $xr14
  xvmul.d $xr17, $xr17, $xr14
  xvmul.d $xr18, $xr18, $xr14
  xvmul.d $xr19, $xr19, $xr14
  xvmul.d $xr20, $xr20, $xr14
  xvmul.d $xr21, $xr21, $xr14
  xvmul.d $xr22, $xr22, $xr14
  xvmul.d $xr23, $xr23, $xr14
  xvmul.d $xr12, $xr12, $xr14
  xvmul.d $xr0, $xr0, $xr14
  xvmul.d $xr8, $xr8, $xr14
  xvmul.d $xr9, $xr9, $xr14
  xvmul.d $xr10, $xr10, $xr14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, xmultest_loop
  jr $r1



xmullattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
xmullattest_loop:
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  xvmul.d $xr18, $xr18, $xr18
  sub.d $r4, $r4, $r14
  bge $r4, $r18, xmullattest_loop
  jr $r1


/* r4 = iteration count */
divtest:
  xor $r14, $r14, $r14
  addi.d $r14, $r14, 20
  xor $r18, $r18, $r18
  addi.d $r24, $r24, 1023
  addi.d $r23, $r23, 2
  addi.d $r25, $r25, 3
  addi.d $r26, $r26, 6
  addi.d $r27, $r27, 11
  addi.d $r28, $r28, 12
  addi.d $r29, $r29, 19
  addi.d $r30, $r30, 20
  addi.d $r31, $r31, 25
divtest_loop:
  div.d $r12, $r24, $r23
  div.d $r13, $r24, $r25
  div.d $r15, $r24, $r26
  div.d $r16, $r24, $r27
  div.d $r17, $r24, $r28
  div.d $r19, $r24, $r30
  div.d $r20, $r24, $r31
  div.d $r12, $r24, $r23
  div.d $r13, $r24, $r25
  div.d $r15, $r24, $r26
  div.d $r16, $r24, $r27
  div.d $r17, $r24, $r28
  div.d $r19, $r24, $r30
  div.d $r20, $r24, $r31
  div.d $r12, $r24, $r23
  div.d $r13, $r24, $r25
  div.d $r15, $r24, $r26
  div.d $r16, $r24, $r27
  div.d $r17, $r24, $r28
  div.d $r19, $r24, $r30
  div.d $r20, $r24, $r31
  sub.d $r4, $r4, $r14
  bge $r4, $r18, divtest_loop
  jr $r1


divlattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
divlattest_loop:
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  div.d $r18, $r18, $r18
  sub.d $r4, $r4, $r14
  bge $r4, $r18, divtest_loop
  jr $r1



fdivtest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
fdivtest_loop:
  fdiv.d $f12, $f12, $f14
  fdiv.d $f13, $f13, $f14
  fdiv.d $f15, $f15, $f14
  fdiv.d $f16, $f16, $f14
  fdiv.d $f17, $f17, $f14
  fdiv.d $f12, $f12, $f14
  fdiv.d $f13, $f13, $f14
  fdiv.d $f15, $f15, $f14
  fdiv.d $f16, $f16, $f14
  fdiv.d $f17, $f17, $f14
  fdiv.d $f12, $f12, $f14
  fdiv.d $f13, $f13, $f14
  fdiv.d $f15, $f15, $f14
  fdiv.d $f16, $f16, $f14
  fdiv.d $f17, $f17, $f14
  fdiv.d $f12, $f12, $f14
  fdiv.d $f13, $f13, $f14
  fdiv.d $f15, $f15, $f14
  fdiv.d $f16, $f16, $f14
  fdiv.d $f17, $f17, $f14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, fdivtest_loop
  jr $r1


fdivlattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
fdivlattest_loop:
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  fdiv.d $f18, $f18, $f18
  sub.d $r4, $r4, $r14
  bge $r4, $r18, fdivlattest_loop
  jr $r1


fadd_fmultest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
fadd_fmultest_loop:
  fadd.d $f12, $f12, $f14
  fmul.d $f13, $f13, $f14
  fadd.d $f15, $f15, $f14
  fmul.d $f16, $f16, $f14
  fadd.d $f17, $f17, $f14
  fmul.d $f18, $f18, $f14
  fadd.d $f19, $f19, $f14
  fmul.d $f20, $f20, $f14
  fadd.d $f21, $f21, $f14
  fmul.d $f22, $f22, $f14
  fadd.d $f12, $f12, $f14
  fmul.d $f13, $f13, $f14
  fadd.d $f15, $f15, $f14
  fmul.d $f16, $f16, $f14
  fadd.d $f17, $f17, $f14
  fmul.d $f18, $f18, $f14
  fadd.d $f19, $f19, $f14
  fmul.d $f20, $f20, $f14
  fadd.d $f21, $f21, $f14
  fmul.d $f22, $f22, $f14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, fadd_fmultest_loop
  jr $r1

fadd_multest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
fadd_multest_loop:
  fadd.d $f12, $f12, $f14
  mul.d $r12, $r12, $r14
  fadd.d $f13, $f13, $f14
  mul.d $r13, $r13, $r14
  fadd.d $f15, $f15, $f14
  mul.d $r15, $r15, $r14
  fadd.d $f16, $f16, $f14
  mul.d $r16, $r16, $r14
  fadd.d $f17, $f17, $f14
  mul.d $r17, $r17, $r14
  fadd.d $f12, $f12, $f14
  mul.d $r12, $r12, $r14
  fadd.d $f13, $f13, $f14
  mul.d $r13, $r13, $r14
  fadd.d $f15, $f15, $f14
  mul.d $r15, $r15, $r14
  fadd.d $f16, $f16, $f14
  mul.d $r16, $r16, $r14
  fadd.d $f17, $f17, $f14
  mul.d $r17, $r17, $r14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, fadd_multest_loop
  jr $r1

fadd_mul_multest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  xor $r19, $r19, $r19
  xor $r20, $r20, $r20
  addi.d $r14, $r14, 24
fadd_mul_multest_loop:
  fadd.d $f12, $f12, $f14
  mul.d $r12, $r12, $r14
  mul.d $r13, $r13, $r14
  fadd.d $f13, $f13, $f14
  mul.d $r15, $r15, $r14
  mul.d $r16, $r16, $r14
  fadd.d $f15, $f15, $f14
  mul.d $r17, $r17, $r14
  mul.d $r18, $r18, $r14
  fadd.d $f16, $f16, $f14
  mul.d $r19, $r19, $r14
  mul.d $r20, $r20, $r14
  fadd.d $f12, $f12, $f14
  mul.d $r12, $r12, $r14
  mul.d $r13, $r13, $r14
  fadd.d $f13, $f13, $f14
  mul.d $r15, $r15, $r14
  mul.d $r16, $r16, $r14
  fadd.d $f15, $f15, $f14
  mul.d $r17, $r17, $r14
  mul.d $r18, $r18, $r14
  fadd.d $f16, $f16, $f14
  mul.d $r19, $r19, $r14
  mul.d $r20, $r20, $r14
  sub.d $r4, $r4, $r14
  bge $r4, $r0, fadd_mul_multest_loop
  jr $r1



fadd_fmul_fmultest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  xor $r19, $r19, $r19
  xor $r20, $r20, $r20
  addi.d $r14, $r14, 24
fadd_fmul_fmultest_loop:
  fadd.d $f12, $f12, $f14
  fmul.d $f13, $f13, $f14
  fmul.d $f15, $f15, $f14
  fadd.d $f16, $f16, $f14
  fmul.d $f17, $f17, $f14
  fmul.d $f18, $f18, $f14
  fadd.d $f19, $f19, $f14
  fmul.d $f20, $f20, $f14
  fmul.d $f21, $f21, $f14
  fadd.d $f12, $f12, $f14
  fmul.d $f13, $f13, $f14
  fmul.d $f15, $f15, $f14
  fadd.d $f16, $f16, $f14
  fmul.d $f17, $f17, $f14
  fmul.d $f18, $f18, $f14
  fadd.d $f19, $f19, $f14
  fmul.d $f20, $f20, $f14
  fmul.d $f21, $f21, $f14
  fadd.d $f12, $f12, $f14
  fmul.d $f13, $f13, $f14
  fmul.d $f15, $f15, $f14
  fadd.d $f16, $f16, $f14
  fmul.d $f17, $f17, $f14
  fmul.d $f18, $f18, $f14
  fadd.d $f19, $f19, $f14
  fmul.d $f20, $f20, $f14
  fmul.d $f21, $f21, $f14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, fadd_fmul_fmultest_loop
  jr $r1



fmatest:
  fld.d $f12, $r5, 0 
  fld.d $f13, $r5, 4 
  fld.d $f14, $r5, 4 
  fld.d $f15, $r5, 4 
  fld.d $f16, $r5, 4 
  fld.d $f17, $r5, 8 
  fld.d $f18, $r5, 4 
  fld.d $f19, $r5, 16
  fld.d $f20, $r5, 4 
  fld.d $f21, $r5, 4 
  fld.d $f22, $r5, 4 

  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
fmatest_loop:
  fmadd.d $f12, $f12, $f14, $f14
  fmadd.d $f13, $f13, $f14, $f14
  fmadd.d $f15, $f15, $f14, $f14
  fmadd.d $f16, $f16, $f14, $f14
  fmadd.d $f17, $f17, $f14, $f14
  fmadd.d $f12, $f12, $f14, $f14
  fmadd.d $f13, $f13, $f14, $f14
  fmadd.d $f15, $f15, $f14, $f14
  fmadd.d $f16, $f16, $f14, $f14
  fmadd.d $f17, $f17, $f14, $f14
  fmadd.d $f12, $f12, $f14, $f14
  fmadd.d $f13, $f13, $f14, $f14
  fmadd.d $f15, $f15, $f14, $f14
  fmadd.d $f16, $f16, $f14, $f14
  fmadd.d $f17, $f17, $f14, $f14
  fmadd.d $f12, $f12, $f14, $f14
  fmadd.d $f13, $f13, $f14, $f14
  fmadd.d $f15, $f15, $f14, $f14
  fmadd.d $f16, $f16, $f14, $f14
  fmadd.d $f17, $f17, $f14, $f14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, fmatest_loop
  jr $r1



fmalattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
fmalattest_loop:
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  fmadd.d $f18, $f18, $f18, $f18
  sub.d $r4, $r4, $r14
  bge $r4, $r18, fmalattest_loop
  jr $r1


vfmatest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
vfmatest_loop:
  vfmadd.d $vr12, $vr12, $vr14, $vr14
  vfmadd.d $vr13, $vr13, $vr14, $vr14
  vfmadd.d $vr15, $vr15, $vr14, $vr14
  vfmadd.d $vr16, $vr16, $vr14, $vr14
  vfmadd.d $vr17, $vr17, $vr14, $vr14
  vfmadd.d $vr12, $vr12, $vr14, $vr14
  vfmadd.d $vr13, $vr13, $vr14, $vr14
  vfmadd.d $vr15, $vr15, $vr14, $vr14
  vfmadd.d $vr16, $vr16, $vr14, $vr14
  vfmadd.d $vr17, $vr17, $vr14, $vr14
  vfmadd.d $vr12, $vr12, $vr14, $vr14
  vfmadd.d $vr13, $vr13, $vr14, $vr14
  vfmadd.d $vr15, $vr15, $vr14, $vr14
  vfmadd.d $vr16, $vr16, $vr14, $vr14
  vfmadd.d $vr17, $vr17, $vr14, $vr14
  vfmadd.d $vr12, $vr12, $vr14, $vr14
  vfmadd.d $vr13, $vr13, $vr14, $vr14
  vfmadd.d $vr15, $vr15, $vr14, $vr14
  vfmadd.d $vr16, $vr16, $vr14, $vr14
  vfmadd.d $vr17, $vr17, $vr14, $vr14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, vfmatest_loop
  jr $r1



vfmalattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
vfmalattest_loop:
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  vfmadd.d $vr18, $vr18, $vr18, $vr18
  sub.d $r4, $r4, $r14
  bge $r4, $r18, vfmalattest_loop
  jr $r1

xfmatest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
  xvld $xr14, $r5, 0
  xvld $xr12, $r5, 0
xfmatest_loop:
  xvfmadd.d $xr12, $xr12, $xr14, $xr14
  xvfmadd.d $xr13, $xr13, $xr14, $xr14
  xvfmadd.d $xr15, $xr15, $xr14, $xr14
  xvfmadd.d $xr16, $xr16, $xr14, $xr14
  xvfmadd.d $xr17, $xr17, $xr14, $xr14
  xvfmadd.d $xr12, $xr12, $xr14, $xr14
  xvfmadd.d $xr13, $xr13, $xr14, $xr14
  xvfmadd.d $xr15, $xr15, $xr14, $xr14
  xvfmadd.d $xr16, $xr16, $xr14, $xr14
  xvfmadd.d $xr17, $xr17, $xr14, $xr14
  xvfmadd.d $xr12, $xr12, $xr14, $xr14
  xvfmadd.d $xr13, $xr13, $xr14, $xr14
  xvfmadd.d $xr15, $xr15, $xr14, $xr14
  xvfmadd.d $xr16, $xr16, $xr14, $xr14
  xvfmadd.d $xr17, $xr17, $xr14, $xr14
  xvfmadd.d $xr12, $xr12, $xr14, $xr14
  xvfmadd.d $xr13, $xr13, $xr14, $xr14
  xvfmadd.d $xr15, $xr15, $xr14, $xr14
  xvfmadd.d $xr16, $xr16, $xr14, $xr14
  xvfmadd.d $xr17, $xr17, $xr14, $xr14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, xfmatest_loop
  jr $r1

xfmalattest:
  xor $r14, $r14, $r14
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
xfmalattest_loop:
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  xvfmadd.d $xr18, $xr18, $xr18, $xr18
  sub.d $r4, $r4, $r14
  bge $r4, $r18, xfmalattest_loop
  jr $r1

fma_faddtest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
fma_faddtest_loop:
  fmadd.d $f12, $f12, $f14, $f14
  fadd.d $f13, $f13, $f14
  fmadd.d $f15, $f15, $f14, $f14
  fadd.d $f16, $f16, $f14
  fmadd.d $f17, $f17, $f14, $f14
  fadd.d $f18, $f18, $f14
  fmadd.d $f19, $f19, $f14, $f14
  fadd.d $f20, $f20, $f14
  fmadd.d $f21, $f21, $f14, $f14
  fadd.d $f22, $f22, $f14
  fmadd.d $f12, $f12, $f14, $f14
  fadd.d $f13, $f13, $f14
  fmadd.d $f15, $f15, $f14, $f14
  fadd.d $f16, $f16, $f14
  fmadd.d $f17, $f17, $f14, $f14
  fadd.d $f18, $f18, $f14
  fmadd.d $f19, $f19, $f14, $f14
  fadd.d $f20, $f20, $f14
  fmadd.d $f21, $f21, $f14, $f14
  fadd.d $f22, $f22, $f14
  sub.d $r4, $r4, $r14
  bge $r4, $r18, fma_faddtest_loop
  jr $r1

fma_fmultest:
  fld.d $f12, $r5, 0 
  fld.d $f13, $r5, 4 
  fld.d $f14, $r5, 4 
  fld.d $f15, $r5, 4 
  fld.d $f16, $r5, 4 
  fld.d $f17, $r5, 8 
  fld.d $f18, $r5, 4 
  fld.d $f19, $r5, 16
  fld.d $f20, $r5, 4 
  fld.d $f21, $r5, 4 
  fld.d $f22, $r5, 4 
  xor $r14, $r14, $r14
  addi.d $r14, $r14, 20
fma_fmultest_loop:
  fmadd.d $f12, $f12, $f14, $f14
  fmul.d $f13, $f13, $f14
  fmadd.d $f15, $f15, $f14, $f14
  fmul.d $f16, $f16, $f14
  fmadd.d $f17, $f17, $f14, $f14
  fmul.d $f18, $f18, $f14
  fmadd.d $f19, $f19, $f14, $f14
  fmul.d $f20, $f20, $f14
  fmadd.d $f21, $f21, $f14, $f14
  fmul.d $f22, $f22, $f14
  fmadd.d $f12, $f12, $f14, $f14
  fmul.d $f13, $f13, $f14
  fmadd.d $f15, $f15, $f14, $f14
  fmul.d $f16, $f16, $f14
  fmadd.d $f17, $f17, $f14, $f14
  fmul.d $f18, $f18, $f14
  fmadd.d $f19, $f19, $f14, $f14
  fmul.d $f20, $f20, $f14
  fmadd.d $f21, $f21, $f14, $f14
  fmul.d $f22, $f22, $f14
  sub.d $r4, $r4, $r14
  bge $r4, $r0, fma_fmultest_loop
  jr $r1

fma_fmul21test:
  fld.d $f12, $r5, 0 
  fld.d $f13, $r5, 4 
  fld.d $f14, $r5, 4 
  fld.d $f15, $r5, 4 
  fld.d $f16, $r5, 4 
  fld.d $f17, $r5, 8 
  fld.d $f18, $r5, 4 
  fld.d $f19, $r5, 16
  fld.d $f20, $r5, 4 
  fld.d $f21, $r5, 4 
  fld.d $f22, $r5, 4 
  xor $r14, $r14, $r14
  addi.d $r14, $r14, 18
fma_fmul21test_loop:
  fmadd.d $f15, $f15, $f14, $f14
  fmadd.d $f18, $f18, $f14, $f14
  fmadd.d $f12, $f12, $f14, $f14
  fmadd.d $f13, $f13, $f14, $f14
  fmadd.d $f16, $f16, $f14, $f14
  fmadd.d $f17, $f17, $f14, $f14
  fmadd.d $f19, $f19, $f14, $f14
  fmadd.d $f20, $f20, $f14, $f14
  fmadd.d $f22, $f22, $f14, $f14
  fmadd.d $f12, $f12, $f14, $f14
  fmadd.d $f16, $f16, $f14, $f14
  fmadd.d $f19, $f19, $f14, $f14
  fmul.d $f15, $f15, $f14
  fmul.d $f18, $f18, $f14
  fmul.d $f21, $f21, $f14
  fmul.d $f13, $f13, $f14
  fmul.d $f17, $f17, $f14
  fmul.d $f20, $f20, $f14
  sub.d $r4, $r4, $r14
  bge $r4, $r0, fma_fmul21test_loop
  jr $r1


fma_fmul_faddtest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 18
fma_fmul_faddtest_loop:
  fmul.d $f13, $f13, $f14
  fmul.d $f18, $f18, $f14
  fmul.d $f22, $f22, $f14
  fmadd.d $f12, $f12, $f14, $f14
  fmadd.d $f17, $f17, $f14, $f14
  fmadd.d $f21, $f21, $f14, $f14
  fmadd.d $f12, $f12, $f14, $f14
  fadd.d $f15, $f15, $f14
  fadd.d $f19, $f19, $f14
  fadd.d $f23, $f23, $f14

  fmul.d $f13, $f13, $f14
  fmul.d $f18, $f18, $f14
  fmul.d $f22, $f22, $f14
  fmadd.d $f17, $f17, $f14, $f14
  fmadd.d $f21, $f21, $f14, $f14
  fadd.d $f15, $f15, $f14
  fadd.d $f19, $f19, $f14
  fadd.d $f23, $f23, $f14

  sub.d $r4, $r4, $r14
  bge $r4, $r18, fma_fmul_faddtest_loop
  jr $r1



/* r4 = iteration count, r5 = arr */
loadtest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
loadtest_loop:
  ld.d $r12, $r5, 0
  ld.d $r13, $r5, 1
  ld.d $r15, $r5, 2
  ld.d $r16, $r5, 3
  ld.d $r17, $r5, 5
  ld.d $r12, $r5, 0
  ld.d $r13, $r5, 1
  ld.d $r15, $r5, 2
  ld.d $r16, $r5, 3
  ld.d $r17, $r5, 5
  ld.d $r12, $r5, 0
  ld.d $r13, $r5, 1
  ld.d $r15, $r5, 2
  ld.d $r16, $r5, 3
  ld.d $r17, $r5, 5
  ld.d $r12, $r5, 0
  ld.d $r13, $r5, 1
  ld.d $r15, $r5, 2
  ld.d $r16, $r5, 3
  ld.d $r17, $r5, 5
  sub.d $r4, $r4, $r14
  bge $r4, $r18, loadtest_loop
  jr $r1

storetest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  addi.d $r14, $r14, 20
storetest_loop:
  st.d $r12, $r5, 0
  st.d $r13, $r5, 1
  st.d $r15, $r5, 2
  st.d $r16, $r5, 3
  st.d $r17, $r5, 5
  st.d $r12, $r5, 0
  st.d $r13, $r5, 1
  st.d $r15, $r5, 2
  st.d $r16, $r5, 3
  st.d $r17, $r5, 5
  st.d $r12, $r5, 0
  st.d $r13, $r5, 1
  st.d $r15, $r5, 2
  st.d $r16, $r5, 3
  st.d $r17, $r5, 5
  st.d $r12, $r5, 0
  st.d $r13, $r5, 1
  st.d $r15, $r5, 2
  st.d $r16, $r5, 3
  st.d $r17, $r5, 5
  sub.d $r4, $r4, $r14
  bge $r4, $r18, storetest_loop
  jr $r1



load_storetest:
  xor $r14, $r14, $r14
  xor $r13, $r13, $r13
  xor $r12, $r12, $r12
  xor $r15, $r15, $r15
  xor $r16, $r16, $r16
  xor $r17, $r17, $r17
  xor $r18, $r18, $r18
  xor $r19, $r19, $r19
  xor $r20, $r20, $r20
  xor $r24, $r24, $r24
  addi.d $r14, $r14, 24
load_storetest_loop:
  st.d $r12, $r5, 0
  ld.d $r13, $r5, 16
  st.d $r15, $r5, 0
  ld.d $r16, $r5, 16
  st.d $r17, $r5, 0
  ld.d $r18, $r5, 16
  st.d $r19, $r5, 0
  ld.d $r20, $r5, 16
  st.d $r12, $r5, 0
  ld.d $r13, $r5, 16
  st.d $r15, $r5, 0
  ld.d $r16, $r5, 16
  st.d $r17, $r5, 0
  ld.d $r18, $r5, 16
  st.d $r19, $r5, 0
  ld.d $r20, $r5, 16
  st.d $r12, $r5, 0
  ld.d $r13, $r5, 16
  st.d $r15, $r5, 0
  ld.d $r16, $r5, 16
  st.d $r17, $r5, 0
  ld.d $r18, $r5, 16
  st.d $r19, $r5, 0
  ld.d $r20, $r5, 16
  sub.d $r4, $r4, $r14
  bge $r4, $r24, load_storetest_loop
  jr $r1

xvpermilattest:
  move $r12, $r0
  addi.d $r12, $r12, 2
  move $r14, $r0
  addi.d $r14, $r14, 20
  xvld $xr1, $r5, 0
xvpermilattest_loop:
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  xvpermi.d $xr1, $xr1, 0x2
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvpermilattest_loop
  jr $r1

 xvpermitest:
  move $r12, $r0
  addi.d $r12, $r12, 2
  move $r14, $r0
  addi.d $r14, $r14, 20
  xvld $xr2, $r5, 0
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0
  xvld $xr5, $r5, 0
  xvld $xr6, $r5, 0
  xvld $xr7, $r5, 0
  xvadd.d $xr7, $xr2, $xr3
  xvadd.d $xr8, $xr2, $xr3
  xvadd.d $xr9, $xr2, $xr3
  xvadd.d $xr10, $xr2, $xr3
  xvadd.d $xr11, $xr2, $xr3
  xvadd.d $xr12, $xr2, $xr3
xvpermitest_loop:
  xvpermi.d $xr1, $xr2, 0x2
  xvpermi.d $xr1, $xr3, 0x3
  xvpermi.d $xr1, $xr4, 0x4
  xvpermi.d $xr1, $xr5, 0x5
  xvpermi.d $xr1, $xr6, 0x6
  xvpermi.d $xr1, $xr7, 0x7
  xvpermi.d $xr1, $xr8, 0x8
  xvpermi.d $xr1, $xr9, 0x2
  xvpermi.d $xr1, $xr10, 0x3
  xvpermi.d $xr1, $xr2, 0x2
  xvpermi.d $xr1, $xr3, 0x3
  xvpermi.d $xr1, $xr4, 0x4
  xvpermi.d $xr1, $xr5, 0x5
  xvpermi.d $xr1, $xr6, 0x6
  xvpermi.d $xr1, $xr7, 0x7
  xvpermi.d $xr1, $xr8, 0x8
  xvpermi.d $xr1, $xr9, 0x9
  xvpermi.d $xr1, $xr10, 0xA
  xvpermi.d $xr1, $xr11, 0xB
  xvpermi.d $xr1, $xr12, 0xC
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvpermitest_loop
  jr $r1 

gr2frlattest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 5 
gr2frlattest_loop:
  movgr2fr.d $f1, $r12
  movfr2gr.d $r12, $f1
  movgr2fr.d $f1, $r12
  movfr2gr.d $r12, $f1 
  movgr2fr.d $f1, $r12
  movfr2gr.d $r12, $f1  
  movgr2fr.d $f1, $r12
  movfr2gr.d $r12, $f1   
  movgr2fr.d $f1, $r12
  movfr2gr.d $r12, $f1    
  sub.d $r4, $r4, $r14
  bge $r4, $r0, gr2frlattest_loop 
  jr $r1

gr2xrlattest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 5
gr2xrlattest_loop:
  xvreplgr2vr.d $xr1, $r12
  xvpickve2gr.w $r12,$xr1,0x0 
   xvreplgr2vr.d $xr1, $r12
  xvpickve2gr.w $r12,$xr1,0x0  
   xvreplgr2vr.d $xr1, $r12
  xvpickve2gr.w $r12,$xr1,0x0  
   xvreplgr2vr.d $xr1, $r12
  xvpickve2gr.w $r12,$xr1,0x0  
   xvreplgr2vr.d $xr1, $r12
  xvpickve2gr.w $r12,$xr1,0x0  
  sub.d $r4, $r4, $r14
  bge $r4, $r0, gr2xrlattest_loop
  jr $r1

fr2grtest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  movgr2fr.d $f1, $r12
  move $r14, $r0
  addi.d $r14, $r14, 10 
fr2grtest_loop:
  movfr2gr.d $r12, $f1
  movfr2gr.d $r12, $f1 
  movfr2gr.d $r12, $f1  
  movfr2gr.d $r12, $f1   
  movfr2gr.d $r12, $f1    
  movfr2gr.d $r12, $f1    
  movfr2gr.d $r12, $f1    
  movfr2gr.d $r12, $f1    
  movfr2gr.d $r12, $f1    
  movfr2gr.d $r12, $f1    
  sub.d $r4, $r4, $r14
  bge $r4, $r0, fr2grtest_loop 
  jr $r1  

gr2frtest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
gr2frtest_loop:
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12 
  sub.d $r4, $r4, $r14
  bge $r4, $r0, gr2frtest_loop 
  jr $r1

mixgr2frtest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
mixgr2frtest_loop:
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12 
  movfr2gr.d $r13, $f2
  movfr2gr.d $r13, $f2 
  movfr2gr.d $r13, $f2  
  movfr2gr.d $r13, $f2   
  movfr2gr.d $r13, $f2    
  movfr2gr.d $r13, $f2    
  movfr2gr.d $r13, $f2    
  movfr2gr.d $r13, $f2    
  movfr2gr.d $r13, $f2    
  movfr2gr.d $r13, $f2     
  sub.d $r4, $r4, $r14
  bge $r4, $r0, mixgr2frtest_loop 
  jr $r1 

mixgr2frvecaddtest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0   
mixgr2frvecaddtest_loop:
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  xvadd.d $xr2, $xr3, $xr4
  xvadd.d $xr2, $xr3, $xr4
  xvadd.d $xr2, $xr3, $xr4
  xvadd.d $xr2, $xr3, $xr4
  xvadd.d $xr2, $xr3, $xr4
  sub.d $r4, $r4, $r14
  bge $r4, $r0, mixgr2frvecaddtest_loop 
  jr $r1

mixgr2frfaddtest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0   
mixgr2frfaddtest_loop:
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  xvfadd.s $xr2, $xr3, $xr4
  xvfadd.s $xr2, $xr3, $xr4
  xvfadd.s $xr2, $xr3, $xr4
  xvfadd.s $xr2, $xr3, $xr4
  xvfadd.s $xr2, $xr3, $xr4
  sub.d $r4, $r4, $r14
  bge $r4, $r0, mixgr2frfaddtest_loop 
  jr $r1



mixgr2frfmultest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0   
mixgr2frfmultest_loop:
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  movgr2fr.d $f1, $r12
  xvfmul.s $xr2, $xr3, $xr4
  xvfmul.s $xr2, $xr3, $xr4
  xvfmul.s $xr2, $xr3, $xr4
  xvfmul.s $xr2, $xr3, $xr4
  xvfmul.s $xr2, $xr3, $xr4
  sub.d $r4, $r4, $r14
  bge $r4, $r0, mixgr2frfmultest_loop 
  jr $r1 

mixstorefaddtest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0
mixstorefaddtest_loop:
  xvst $xr1, $r5, 0
  xvfadd.s $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvfadd.s $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvfadd.s $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvfadd.s $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvfadd.s $xr2, $xr3, $xr4
  sub.d $r4, $r4, $r14
  bge $r4, $r0, mixstorefaddtest_loop
  jr $r1

mixstorefmultest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0
mixstorefmultest_loop:
  xvst $xr1, $r5, 0
  xvfmul.s $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvfmul.s $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvfmul.s $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvfmul.s $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvfmul.s $xr2, $xr3, $xr4
  sub.d $r4, $r4, $r14
  bge $r4, $r0, mixstorefmultest_loop
  jr $r1 

mixstorevecaddtest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0
mixstorevecaddtest_loop:
  xvst $xr1, $r5, 0
  xvadd.d $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvadd.d $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvadd.d $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvadd.d $xr2, $xr3, $xr4
  xvst $xr1, $r5, 0
  xvadd.d $xr2, $xr3, $xr4
  sub.d $r4, $r4, $r14
  bge $r4, $r0, mixstorevecaddtest_loop
  jr $r1

xvxortest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0
  xvadd.d $xr2, $xr3, $xr5
xvxortest_loop:
  xvxor.v $xr1, $xr2, $xr3
  xvxor.v $xr1, $xr2, $xr3
  xvxor.v $xr1, $xr2, $xr3
  xvxor.v $xr1, $xr2, $xr3
  xvxor.v $xr1, $xr2, $xr3
  xvxor.v $xr1, $xr2, $xr3
  xvxor.v $xr1, $xr2, $xr3
  xvxor.v $xr1, $xr2, $xr3
  xvxor.v $xr1, $xr2, $xr3
  xvxor.v $xr1, $xr2, $xr3
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvxortest_loop
  jr $r1 

xvxorlattest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0
  xvadd.d $xr2, $xr3, $xr5
xvxorlattest_loop:
  xvxor.v $xr2, $xr2, $xr2
  xvxor.v $xr2, $xr2, $xr2
  xvxor.v $xr2, $xr2, $xr2
  xvxor.v $xr2, $xr2, $xr2
  xvxor.v $xr2, $xr2, $xr2
  xvxor.v $xr2, $xr2, $xr2
  xvxor.v $xr2, $xr2, $xr2
  xvxor.v $xr2, $xr2, $xr2
  xvxor.v $xr2, $xr2, $xr2
  xvxor.v $xr2, $xr2, $xr2
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvxorlattest_loop
  jr $r1  

xvfaddtest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 16 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0    
xvfaddtest_loop:
  xvfadd.s $xr8, $xr8, $xr3
  xvfadd.s $xr9, $xr9, $xr3
  xvfadd.s $xr10, $xr10, $xr3
  xvfadd.s $xr11, $xr11, $xr3
  xvfadd.s $xr12, $xr12, $xr3
  xvfadd.s $xr13, $xr13, $xr3
  xvfadd.s $xr14, $xr14, $xr3
  xvfadd.s $xr15, $xr15, $xr3
  xvfadd.s $xr16, $xr16, $xr3
  xvfadd.s $xr17, $xr17, $xr3
  xvfadd.s $xr18, $xr18, $xr3
  xvfadd.s $xr19, $xr19, $xr3
  xvfadd.s $xr20, $xr20, $xr3
  xvfadd.s $xr21, $xr21, $xr3
  xvfadd.s $xr22, $xr22, $xr3
  xvfadd.s $xr23, $xr23, $xr3
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvfaddtest_loop
  jr $r1  

xvfaddlattest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr8, $r5, 0    
xvfaddlattest_loop:
  xvfadd.s $xr8, $xr8, $xr8
  xvfadd.s $xr8, $xr8, $xr8
  xvfadd.s $xr8, $xr8, $xr8
  xvfadd.s $xr8, $xr8, $xr8
  xvfadd.s $xr8, $xr8, $xr8
  xvfadd.s $xr8, $xr8, $xr8
  xvfadd.s $xr8, $xr8, $xr8
  xvfadd.s $xr8, $xr8, $xr8
  xvfadd.s $xr8, $xr8, $xr8
  xvfadd.s $xr8, $xr8, $xr8
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvfaddlattest_loop
  jr $r1   

xvfmultest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 16 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0    
xvfmultest_loop:
  xvfmul.s $xr8, $xr8, $xr3
  xvfmul.s $xr9, $xr9, $xr3
  xvfmul.s $xr10, $xr10, $xr3
  xvfmul.s $xr11, $xr11, $xr3
  xvfmul.s $xr12, $xr12, $xr3
  xvfmul.s $xr13, $xr13, $xr3
  xvfmul.s $xr14, $xr14, $xr3
  xvfmul.s $xr15, $xr15, $xr3
  xvfmul.s $xr16, $xr16, $xr3
  xvfmul.s $xr17, $xr17, $xr3
  xvfmul.s $xr18, $xr18, $xr3
  xvfmul.s $xr19, $xr19, $xr3
  xvfmul.s $xr20, $xr20, $xr3
  xvfmul.s $xr21, $xr21, $xr3
  xvfmul.s $xr22, $xr22, $xr3
  xvfmul.s $xr23, $xr23, $xr3
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvfmultest_loop
  jr $r1  

xvfmullattest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr8, $r5, 0    
xvfmullattest_loop:
  xvfmul.s $xr8, $xr8, $xr8
  xvfmul.s $xr8, $xr8, $xr8
  xvfmul.s $xr8, $xr8, $xr8
  xvfmul.s $xr8, $xr8, $xr8
  xvfmul.s $xr8, $xr8, $xr8
  xvfmul.s $xr8, $xr8, $xr8
  xvfmul.s $xr8, $xr8, $xr8
  xvfmul.s $xr8, $xr8, $xr8
  xvfmul.s $xr8, $xr8, $xr8
  xvfmul.s $xr8, $xr8, $xr8
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvfmullattest_loop
  jr $r1    

vfaddtest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 16 
  vld $vr3, $r5, 0
  vld $vr4, $r5, 0    
vfaddtest_loop:
  vfadd.s $vr8, $vr8, $vr3
  vfadd.s $vr9, $vr9, $vr3
  vfadd.s $vr10, $vr10, $vr3
  vfadd.s $vr11, $vr11, $vr3
  vfadd.s $vr12, $vr12, $vr3
  vfadd.s $vr13, $vr13, $vr3
  vfadd.s $vr14, $vr14, $vr3
  vfadd.s $vr15, $vr15, $vr3
  vfadd.s $vr16, $vr16, $vr3
  vfadd.s $vr17, $vr17, $vr3
  vfadd.s $vr18, $vr18, $vr3
  vfadd.s $vr19, $vr19, $vr3
  vfadd.s $vr20, $vr20, $vr3
  vfadd.s $vr21, $vr21, $vr3
  vfadd.s $vr22, $vr22, $vr3
  vfadd.s $vr23, $vr23, $vr3
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvfaddtest_loop
  jr $r1  

vfmultest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 16 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0    
vfmultest_loop:
  vfmul.s $vr8, $vr8, $vr3
  vfmul.s $vr9, $vr9, $vr3
  vfmul.s $vr10, $vr10, $vr3
  vfmul.s $vr11, $vr11, $vr3
  vfmul.s $vr12, $vr12, $vr3
  vfmul.s $vr13, $vr13, $vr3
  vfmul.s $vr14, $vr14, $vr3
  vfmul.s $vr15, $vr15, $vr3
  vfmul.s $vr16, $vr16, $vr3
  vfmul.s $vr17, $vr17, $vr3
  vfmul.s $vr18, $vr18, $vr3
  vfmul.s $vr19, $vr19, $vr3
  vfmul.s $vr20, $vr20, $vr3
  vfmul.s $vr21, $vr21, $vr3
  vfmul.s $vr22, $vr22, $vr3
  vfmul.s $vr23, $vr23, $vr3
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvfmultest_loop
  jr $r1

xvslltest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0
  xvadd.d $xr2, $xr3, $xr5
xvslltest_loop:
  xvsll.h $xr1, $xr2, $xr3
  xvsll.h $xr1, $xr2, $xr3
  xvsll.h $xr1, $xr2, $xr3
  xvsll.h $xr1, $xr2, $xr3
  xvsll.h $xr1, $xr2, $xr3
  xvsll.h $xr1, $xr2, $xr3
  xvsll.h $xr1, $xr2, $xr3
  xvsll.h $xr1, $xr2, $xr3
  xvsll.h $xr1, $xr2, $xr3
  xvsll.h $xr1, $xr2, $xr3
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvslltest_loop
  jr $r1  

xvslllattest:
  move $r12, $r0
  addi.d $r12, $r12, 1
  move $r14, $r0
  addi.d $r14, $r14, 10 
  xvld $xr3, $r5, 0
  xvld $xr4, $r5, 0
  xvadd.d $xr2, $xr3, $xr5
xvslllattest_loop:
  xvsll.h $xr2, $xr2, $xr2
  xvsll.h $xr2, $xr2, $xr2
  xvsll.h $xr2, $xr2, $xr2
  xvsll.h $xr2, $xr2, $xr2
  xvsll.h $xr2, $xr2, $xr2
  xvsll.h $xr2, $xr2, $xr2
  xvsll.h $xr2, $xr2, $xr2
  xvsll.h $xr2, $xr2, $xr2
  xvsll.h $xr2, $xr2, $xr2
  xvsll.h $xr2, $xr2, $xr2
  sub.d $r4, $r4, $r14
  bge $r4, $r0, xvslllattest_loop
  jr $r1
