.text

.global vec_int32_add_test
.global vec_int32_mul_test
.global vec_fp32_add_test
.global vec_fp32_fma_test
.global vec_fp32_isqrt_test
.global fp64_add_test
.global fp64_fma_test

/* r3 = iterations, r4 = ptr to arr */
vec_int32_add_test:
  .quad .L.vec_int32_add_test,.TOC.@tocbase,0
.L.vec_int32_add_test:
  li r9, 0
  lvx v0, r4, r9
  li r9, 16
  lvx v1, r4, r9
  li r9, 32
  lvx v2, r4, r9
  li r9, 48
  lvx v3, r4, r9
  li r9, 64
  lvx v4, r4, r9
  li r9, 80
  lvx v5, r4, r9
  li r9, 0
vec_int32_add_test_loop:
  vadduwm v0, v0, v0
  vadduwm v1, v1, v1
  vadduwm v2, v2, v2
  vadduwm v3, v3, v3
  vadduwm v4, v4, v4
  vadduwm v5, v4, v4
  addi r9, r9, 24
  cmpld cr7, r3, r9
  bgt cr7, vec_int32_add_test_loop
  blr

vec_int32_mul_test:
  .quad .L.vec_int32_mul_test,.TOC.@tocbase,0
.L.vec_int32_mul_test:
  li r9, 0
  lvx v0, r4, r9
  li r9, 16
  lvx v1, r4, r9
  li r9, 32
  lvx v2, r4, r9
  li r9, 48
  lvx v3, r4, r9
  li r9, 64
  lvx v4, r4, r9
  li r9, 80
  lvx v5, r4, r9
  li r9, 96
  lvx v6, r4, r9
  li r9, 128
  lvx v7, r4, r9
  li r9, 0
vec_int32_mul_test_loop:
  vmuleuh v0, v0, v0
  vmuleuh v1, v1, v1
  vmuleuh v2, v2, v2
  vmuleuh v3, v3, v3
  vmuleuh v4, v4, v4
  vmuleuh v5, v5, v5
  vmuleuh v6, v6, v6
  vmuleuh v7, v7, v7
  addi r9, r9, 32
  cmpld cr7, r3, r9
  bgt cr7, vec_int32_mul_test_loop
  blr 

vec_fp32_add_test:
  .quad .L.vec_fp32_add_test,.TOC.@tocbase,0
.L.vec_fp32_add_test:
  li r9, 0
  lvx v0, r4, r9
  li r9, 16
  lvx v1, r4, r9
  li r9, 32
  lvx v2, r4, r9
  li r9, 48
  lvx v3, r4, r9
  li r9, 64
  lvx v4, r4, r9
  li r9, 80
  lvx v5, r4, r9
  li r9, 96
  lvx v6, r4, r9
  li r9, 128
  lvx v7, r4, r9
  li r9, 0 
vec_fp32_add_test_loop:
  vaddfp v0, v0, v0
  vaddfp v1, v1, v1
  vaddfp v2, v2, v2
  vaddfp v3, v3, v3
  vaddfp v4, v4, v4
  vaddfp v5, v5, v5
  vaddfp v6, v6, v6
  vaddfp v7, v7, v7
  addi r9, r9, 32
  cmpld cr7, r3, r9
  bgt cr7, vec_fp32_add_test_loop
  blr  

vec_fp32_fma_test:
  .quad .L.vec_fp32_fma_test,.TOC.@tocbase,0
.L.vec_fp32_fma_test:
  li r9, 0
  lvx v0, r4, r9
  li r9, 16
  lvx v1, r4, r9
  li r9, 32
  lvx v2, r4, r9
  li r9, 48
  lvx v3, r4, r9
  li r9, 64
  lvx v4, r4, r9
  li r9, 80
  lvx v5, r4, r9
  li r9, 96
  lvx v6, r4, r9
  li r9, 128
  lvx v7, r4, r9
  li r9, 0   
vec_fp32_fma_test_loop:
  vmaddfp v0, v0, v0, v0
  vmaddfp v1, v1, v1, v1
  vmaddfp v2, v2, v2, v2
  vmaddfp v3, v3, v3, v3
  vmaddfp v4, v4, v4, v4
  vmaddfp v5, v5, v5, v5
  vmaddfp v6, v6, v6, v6
  vmaddfp v7, v7, v7, v7
  addi r9, r9, 32
  cmpld cr7, r3, r9
  bgt cr7, vec_fp32_add_test_loop
  blr   

vec_fp32_isqrt_test:
  .quad .L.vec_fp32_isqrt_test,.TOC.@tocbase,0
.L.vec_fp32_isqrt_test:
  li r9, 0
  lvx v0, r4, r9
  li r9, 16
  lvx v1, r4, r9
  li r9, 32
  lvx v2, r4, r9
  li r9, 48
  lvx v3, r4, r9
  li r9, 64
  lvx v4, r4, r9
  li r9, 80
  lvx v5, r4, r9
  li r9, 96
  lvx v6, r4, r9
  li r9, 128
  lvx v7, r4, r9
  li r9, 0  
vec_fp32_isqrt_test_loop:
  vrsqrtefp v0, v0
  vrsqrtefp v1, v1
  vrsqrtefp v2, v2
  vrsqrtefp v3, v3
  vrsqrtefp v4, v4
  vrsqrtefp v5, v5
  vrsqrtefp v6, v6
  vrsqrtefp v7, v7
  addi r9, r9, 32
  cmpld cr7, r3, r9
  bgt cr7, vec_fp32_isqrt_test_loop
  blr 

fp64_add_test:
  .quad .L.fp64_add_test,.TOC.@tocbase,0
.L.fp64_add_test:
  lfd f0, 0(r4)
  lfd f1, 8(r4)
  lfd f2, 16(r4)
  lfd f3, 24(r4)
  lfd f4, 32(r4)
  lfd f5, 40(r4)
  lfd f6, 48(r4)
  lfd f7, 56(r4)
fp64_add_test_loop:
  fadd f0, f0, f0
  fadd f1, f1, f1
  fadd f2, f2, f2
  fadd f3, f3, f3
  fadd f4, f4, f4
  fadd f5, f5, f5
  fadd f6, f6, f6
  fadd f7, f7, f7
  addi r9, r9, 8
  cmpld cr7, r3, r9
  bgt cr7, fp64_add_test_loop
  blr  

fp64_fma_test:
  .quad .L.fp64_fma_test,.TOC.@tocbase,0
.L.fp64_fma_test:
  lfd f0, 0(r4)
  lfd f1, 8(r4)
  lfd f2, 16(r4)
  lfd f3, 24(r4)
  lfd f4, 32(r4)
  lfd f5, 40(r4)
  lfd f6, 48(r4)
  lfd f7, 56(r4)
fp64_fma_test_loop:
  fmadd f0, f0, f0, f0
  fmadd f1, f1, f1, f1
  fmadd f2, f2, f2, f2
  fmadd f3, f3, f3, f3
  fmadd f4, f4, f4, f4
  fmadd f5, f5, f5, f5
  fmadd f6, f6, f6, f6
  fmadd f7, f7, f7, f7
  addi r9, r9, 8
  cmpld cr7, r3, r9
  bgt cr7, fp64_fma_test_loop
  blr   
