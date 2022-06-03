.global asm_altivec_read

/* r3 = ptr to array
   r4 = element count
   r5 = iterations */ 
asm_altivec_read:
   mr r6, r3
   li r7, 0
   li r9, 0
   li r8, 16
   subi r4, r4, 32 
asm_altivec_read_loop:
   lvx v8, 0, r6
   li r10, 4
   lvx v9, r10, r6
   li r10, 8
   lvx v10, r10, r6
   li r10, 12  
   lvx v11, r10, r6
   li r10, 16
   lvx v8, r10, r6
   li r10, 20
   lvx v9, r10, r6
   li r10, 24
   lvx v10, 0, r6
   li r10, 28
   lvx v11, 0, r6
   addi r7, r7, 32
   addi r6, r6, 32
   cmpld cr7, r4, r7
   bgt cr7, asm_altivec_read_loop
   li r7, 0          /* reset index */
   mr r6, r3
   subi r5, r5, 1    /* decrement iteration counter */
   cmpld cr7, r5, r9 
   bgt cr7, asm_altivec_read_loop  /* if iteration ctr greater than 0, repeat */
   blr 
