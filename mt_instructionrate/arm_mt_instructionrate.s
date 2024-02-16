.text

.global vec_int32_add_test
.global vec_int32_mul_test
.global vec_fp32_add_test
.global vec_fp32_fma_test
.global vec_fp32_rsqrt_test
.global vec_int64_add_test
/*.global vec_int64_mul_test*/
.global vec_fp64_add_test
.global vec_fp64_fma_test

/* x0 = iteration count, x1 = data */
vec_int32_add_test:
  mov x14, 24
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1] 
vec_int32_add_test_loop:
  add v16.4s, v16.4s, v16.4s
  add v17.4s, v17.4s, v17.4s
  add v18.4s, v18.4s, v18.4s
  add v19.4s, v19.4s, v19.4s
  add v20.4s, v20.4s, v20.4s
  add v21.4s, v21.4s, v21.4s 
  sub x0, x0, x14
  cmp x0, 0
  b.gt vec_int32_add_test_loop
  ret

vec_int32_mul_test:
  mov x14, 24
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1] 
vec_int32_mul_test_loop:
  mul v16.4s, v16.4s, v16.4s
  mul v17.4s, v17.4s, v17.4s
  mul v18.4s, v18.4s, v18.4s
  mul v19.4s, v19.4s, v19.4s
  mul v20.4s, v20.4s, v20.4s
  mul v21.4s, v21.4s, v21.4s 
  sub x0, x0, x14
  cmp x0, 0
  b.gt vec_int32_mul_test_loop
  ret

vec_fp32_add_test:
  mov x14, 24
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1] 
vec_fp32_add_test_loop:
  fadd v16.4s, v16.4s, v16.4s
  fadd v17.4s, v17.4s, v17.4s
  fadd v18.4s, v18.4s, v18.4s
  fadd v19.4s, v19.4s, v19.4s
  fadd v20.4s, v20.4s, v20.4s
  fadd v21.4s, v21.4s, v21.4s 
  sub x0, x0, x14
  cmp x0, 0
  b.gt vec_fp32_add_test_loop
  ret

vec_fp32_fma_test:
  mov x14, 24
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1] 
vec_fp32_fma_test_loop:
  fmla v16.4s, v16.4s, v16.4s
  fmla v17.4s, v17.4s, v17.4s
  fmla v18.4s, v18.4s, v18.4s
  fmla v19.4s, v19.4s, v19.4s
  fmla v20.4s, v20.4s, v20.4s
  fmla v21.4s, v21.4s, v21.4s 
  sub x0, x0, x14
  cmp x0, 0
  b.gt vec_fp32_fma_test_loop
  ret

vec_fp32_rsqrt_test:
  mov x14, 24
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1] 
vec_fp32_rsqrt_test_loop:
  ursqrte v16.4s, v16.4s
  ursqrte v17.4s, v17.4s
  ursqrte v18.4s, v18.4s
  ursqrte v19.4s, v19.4s
  ursqrte v20.4s, v20.4s
  ursqrte v21.4s, v21.4s 
  sub x0, x0, x14
  cmp x0, 0
  b.gt vec_fp32_rsqrt_test_loop
  ret 

vec_int64_add_test:
  mov x14, 12
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1] 
vec_int64_add_test_loop:
  add v16.2d, v16.2d, v16.2d
  add v17.2d, v17.2d, v17.2d
  add v18.2d, v18.2d, v18.2d
  add v19.2d, v19.2d, v19.2d
  add v20.2d, v20.2d, v20.2d
  add v21.2d, v21.2d, v21.2d 
  sub x0, x0, x14
  cmp x0, 0
  b.gt vec_int64_add_test_loop
  ret 
 
/*vec_int64_mul_test:
  mov x14, 12
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1] 
vec_int64_mul_test_loop:
  mul v16.2d, v16.2d, v16.2d
  mul v17.2d, v17.2d, v17.2d
  mul v18.2d, v18.2d, v18.2d
  mul v19.2d, v19.2d, v19.2d
  mul v20.2d, v20.2d, v20.2d
  mul v21.2d, v21.2d, v21.2d 
  sub x0, x0, x14
  cmp x0, 0
  b.gt vec_int64_mul_test_loop
  ret */

vec_fp64_add_test:
  mov x14, 12
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1] 
vec_fp64_add_test_loop:
  fadd v16.2d, v16.2d, v16.2d
  fadd v17.2d, v17.2d, v17.2d
  fadd v18.2d, v18.2d, v18.2d
  fadd v19.2d, v19.2d, v19.2d
  fadd v20.2d, v20.2d, v20.2d
  fadd v21.2d, v21.2d, v21.2d 
  sub x0, x0, x14
  cmp x0, 0
  b.gt vec_fp64_add_test_loop
  ret 

vec_fp64_fma_test:
  mov x14, 12
  ldr q16, [x1]
  ldr q17, [x1]
  ldr q18, [x1]
  ldr q19, [x1]
  ldr q20, [x1]
  ldr q21, [x1] 
vec_fp64_fma_test_loop:
  fmla v16.2d, v16.2d, v16.2d
  fmla v17.2d, v17.2d, v17.2d
  fmla v18.2d, v18.2d, v18.2d
  fmla v19.2d, v19.2d, v19.2d
  fmla v20.2d, v20.2d, v20.2d
  fmla v21.2d, v21.2d, v21.2d 
  sub x0, x0, x14
  cmp x0, 0
  b.gt vec_fp64_fma_test_loop
  ret
