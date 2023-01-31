
mips_instructionrate:     file format elf64-loongarch


Disassembly of section .plt:

0000000120001130 <.plt>:
   120001130:	1c00016e 	pcaddu12i	$r14,11(0xb)
   120001134:	0011bdad 	sub.d	$r13,$r13,$r15
   120001138:	28fdc1cf 	ld.d	$r15,$r14,-144(0xf70)
   12000113c:	02ff61ad 	addi.d	$r13,$r13,-40(0xfd8)
   120001140:	02fdc1cc 	addi.d	$r12,$r14,-144(0xf70)
   120001144:	004505ad 	srli.d	$r13,$r13,0x1
   120001148:	28c0218c 	ld.d	$r12,$r12,8(0x8)
   12000114c:	4c0001e0 	jirl	$r0,$r15,0

0000000120001150 <gettimeofday@plt>:
   120001150:	1c00016f 	pcaddu12i	$r15,11(0xb)
   120001154:	28fd81ef 	ld.d	$r15,$r15,-160(0xf60)
   120001158:	1c00000d 	pcaddu12i	$r13,0
   12000115c:	4c0001e0 	jirl	$r0,$r15,0

0000000120001160 <strtol@plt>:
   120001160:	1c00016f 	pcaddu12i	$r15,11(0xb)
   120001164:	28fd61ef 	ld.d	$r15,$r15,-168(0xf58)
   120001168:	1c00000d 	pcaddu12i	$r13,0
   12000116c:	4c0001e0 	jirl	$r0,$r15,0

0000000120001170 <strncmp@plt>:
   120001170:	1c00016f 	pcaddu12i	$r15,11(0xb)
   120001174:	28fd41ef 	ld.d	$r15,$r15,-176(0xf50)
   120001178:	1c00000d 	pcaddu12i	$r13,0
   12000117c:	4c0001e0 	jirl	$r0,$r15,0

0000000120001180 <printf@plt>:
   120001180:	1c00016f 	pcaddu12i	$r15,11(0xb)
   120001184:	28fd21ef 	ld.d	$r15,$r15,-184(0xf48)
   120001188:	1c00000d 	pcaddu12i	$r13,0
   12000118c:	4c0001e0 	jirl	$r0,$r15,0

0000000120001190 <aligned_alloc@plt>:
   120001190:	1c00016f 	pcaddu12i	$r15,11(0xb)
   120001194:	28fd01ef 	ld.d	$r15,$r15,-192(0xf40)
   120001198:	1c00000d 	pcaddu12i	$r13,0
   12000119c:	4c0001e0 	jirl	$r0,$r15,0

Disassembly of section .text:

00000001200011a0 <main>:
   1200011a0:	02fe0063 	addi.d	$r3,$r3,-128(0xf80)
   1200011a4:	29c1407b 	st.d	$r27,$r3,80(0x50)
   1200011a8:	29c1207c 	st.d	$r28,$r3,72(0x48)
   1200011ac:	001500bb 	move	$r27,$r5
   1200011b0:	0015009c 	move	$r28,$r4
   1200011b4:	14000025 	lu12i.w	$r5,1(0x1)
   1200011b8:	02810004 	addi.w	$r4,$r0,64(0x40)
   1200011bc:	29c1a078 	st.d	$r24,$r3,104(0x68)
   1200011c0:	29c1e061 	st.d	$r1,$r3,120(0x78)
   1200011c4:	29c1c077 	st.d	$r23,$r3,112(0x70)
   1200011c8:	29c18079 	st.d	$r25,$r3,96(0x60)
   1200011cc:	29c1607a 	st.d	$r26,$r3,88(0x58)
   1200011d0:	2bc0e078 	fst.d	$f24,$r3,56(0x38)
   1200011d4:	1c000178 	pcaddu12i	$r24,11(0xb)
   1200011d8:	28c09318 	ld.d	$r24,$r24,36(0x24)
   1200011dc:	57ffb7ff 	bl	-76(0xfffffb4) # 120001190 <aligned_alloc@plt>
   1200011e0:	29c00304 	st.d	$r4,$r24,0
   1200011e4:	0015000c 	move	$r12,$r0
   1200011e8:	0290000d 	addi.w	$r13,$r0,1024(0x400)
   1200011ec:	03400000 	andi	$r0,$r0,0x0
   1200011f0:	2980008c 	st.w	$r12,$r4,0
   1200011f4:	02c0058c 	addi.d	$r12,$r12,1(0x1)
   1200011f8:	02c01084 	addi.d	$r4,$r4,4(0x4)
   1200011fc:	5ffff58d 	bne	$r12,$r13,-12(0x3fff4) # 1200011f0 <main+0x50>
   120001200:	02800817 	addi.w	$r23,$r0,2(0x2)
   120001204:	60074efc 	blt	$r23,$r28,1868(0x74c) # 120001950 <main+0x7b0>
   120001208:	0280040c 	addi.w	$r12,$r0,1(0x1)
   12000120c:	58004f8c 	beq	$r28,$r12,76(0x4c) # 120001258 <main+0xb8>
   120001210:	1c00008c 	pcaddu12i	$r12,4(0x4)
   120001214:	02e3618c 	addi.d	$r12,$r12,-1832(0x8d8)
   120001218:	28c00185 	ld.d	$r5,$r12,0
   12000121c:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001220:	02ca1084 	addi.d	$r4,$r4,644(0x284)
   120001224:	57ff5fff 	bl	-164(0xfffff5c) # 120001180 <printf@plt>
   120001228:	581d5b97 	beq	$r28,$r23,7512(0x1d58) # 120002f80 <main+0x1de0>
   12000122c:	28c1e061 	ld.d	$r1,$r3,120(0x78)
   120001230:	28c1c077 	ld.d	$r23,$r3,112(0x70)
   120001234:	28c1a078 	ld.d	$r24,$r3,104(0x68)
   120001238:	28c18079 	ld.d	$r25,$r3,96(0x60)
   12000123c:	28c1607a 	ld.d	$r26,$r3,88(0x58)
   120001240:	28c1407b 	ld.d	$r27,$r3,80(0x50)
   120001244:	28c1207c 	ld.d	$r28,$r3,72(0x48)
   120001248:	2b80e078 	fld.d	$f24,$r3,56(0x38)
   12000124c:	00150004 	move	$r4,$r0
   120001250:	02c20063 	addi.d	$r3,$r3,128(0x80)
   120001254:	4c000020 	jirl	$r0,$r1,0
   120001258:	00150065 	move	$r5,$r3
   12000125c:	02c04064 	addi.d	$r4,$r3,16(0x10)
   120001260:	57fef3ff 	bl	-272(0xffffef0) # 120001150 <gettimeofday@plt>
   120001264:	157e11c4 	lu12i.w	$r4,-266098(0xbf08e)
   120001268:	03ac0084 	ori	$r4,$r4,0xb00
   12000126c:	00150005 	move	$r5,$r0
   120001270:	16000024 	lu32i.d	$r4,1(0x1)
   120001274:	54201c00 	bl	8220(0x201c) # 120003290 <clktest>
   120001278:	02c02065 	addi.d	$r5,$r3,8(0x8)
   12000127c:	02c08064 	addi.d	$r4,$r3,32(0x20)
   120001280:	57fed3ff 	bl	-304(0xffffed0) # 120001150 <gettimeofday@plt>
   120001284:	28c0606d 	ld.d	$r13,$r3,24(0x18)
   120001288:	28c0a06c 	ld.d	$r12,$r3,40(0x28)
   12000128c:	028fa00e 	addi.w	$r14,$r0,1000(0x3e8)
   120001290:	0011b58c 	sub.d	$r12,$r12,$r13
   120001294:	0022398f 	div.d	$r15,$r12,$r14
   120001298:	5c0009c0 	bne	$r14,$r0,8(0x8) # 1200012a0 <main+0x100>
   12000129c:	002a0007 	break	0x7
   1200012a0:	28c0806d 	ld.d	$r13,$r3,32(0x20)
   1200012a4:	28c0406c 	ld.d	$r12,$r3,16(0x10)
   1200012a8:	0011b1ad 	sub.d	$r13,$r13,$r12
   1200012ac:	001db9ad 	mul.d	$r13,$r13,$r14
   1200012b0:	0010bdad 	add.d	$r13,$r13,$r15
   1200012b4:	601cb1a0 	blt	$r13,$r0,7344(0x1cb0) # 120002f64 <main+0x1dc4>
   1200012b8:	0114a9a0 	movgr2fr.d	$f0,$r13
   1200012bc:	011d1818 	ffint.s.l	$f24,$f0
   1200012c0:	1c00008c 	pcaddu12i	$r12,4(0x4)
   1200012c4:	02e0818c 	addi.d	$r12,$r12,-2016(0x820)
   1200012c8:	2b800180 	fld.d	$f0,$r12,0
   1200012cc:	01192718 	fcvt.d.s	$f24,$f24
   1200012d0:	1c00008c 	pcaddu12i	$r12,4(0x4)
   1200012d4:	02e0818c 	addi.d	$r12,$r12,-2016(0x820)
   1200012d8:	01050318 	fmul.d	$f24,$f24,$f0
   1200012dc:	2b800180 	fld.d	$f0,$r12,0
   1200012e0:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200012e4:	02c70084 	addi.d	$r4,$r4,448(0x1c0)
   1200012e8:	157e11d7 	lu12i.w	$r23,-266098(0xbf08e)
   1200012ec:	03ac02f7 	ori	$r23,$r23,0xb00
   1200012f0:	16000037 	lu32i.d	$r23,1(0x1)
   1200012f4:	001502f9 	move	$r25,$r23
   1200012f8:	01070318 	fdiv.d	$f24,$f24,$f0
   1200012fc:	01191b18 	fcvt.s.d	$f24,$f24
   120001300:	01145718 	frecip.s	$f24,$f24
   120001304:	01192700 	fcvt.d.s	$f0,$f24
   120001308:	0114b805 	movfr2gr.d	$r5,$f0
   12000130c:	57fe77ff 	bl	-396(0xffffe74) # 120001180 <printf@plt>
   120001310:	01149700 	fmov.s	$f0,$f24
   120001314:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001318:	28fb70c6 	ld.d	$r6,$r6,-292(0xedc)
   12000131c:	001502e4 	move	$r4,$r23
   120001320:	00150005 	move	$r5,$r0
   120001324:	541e1c00 	bl	7708(0x1e1c) # 120003140 <measureFunction>
   120001328:	01192400 	fcvt.d.s	$f0,$f0
   12000132c:	0114b805 	movfr2gr.d	$r5,$f0
   120001330:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001334:	02c66084 	addi.d	$r4,$r4,408(0x198)
   120001338:	57fe4bff 	bl	-440(0xffffe48) # 120001180 <printf@plt>
   12000133c:	01149700 	fmov.s	$f0,$f24
   120001340:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001344:	28f980c6 	ld.d	$r6,$r6,-416(0xe60)
   120001348:	001502e4 	move	$r4,$r23
   12000134c:	00150005 	move	$r5,$r0
   120001350:	541df000 	bl	7664(0x1df0) # 120003140 <measureFunction>
   120001354:	01192400 	fcvt.d.s	$f0,$f0
   120001358:	0114b805 	movfr2gr.d	$r5,$f0
   12000135c:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001360:	02c61084 	addi.d	$r4,$r4,388(0x184)
   120001364:	57fe1fff 	bl	-484(0xffffe1c) # 120001180 <printf@plt>
   120001368:	01149700 	fmov.s	$f0,$f24
   12000136c:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001370:	28f770c6 	ld.d	$r6,$r6,-548(0xddc)
   120001374:	001502e4 	move	$r4,$r23
   120001378:	00150005 	move	$r5,$r0
   12000137c:	541dc400 	bl	7620(0x1dc4) # 120003140 <measureFunction>
   120001380:	01192400 	fcvt.d.s	$f0,$f0
   120001384:	0114b805 	movfr2gr.d	$r5,$f0
   120001388:	1c000064 	pcaddu12i	$r4,3(0x3)
   12000138c:	02c5c084 	addi.d	$r4,$r4,368(0x170)
   120001390:	57fdf3ff 	bl	-528(0xffffdf0) # 120001180 <printf@plt>
   120001394:	01149700 	fmov.s	$f0,$f24
   120001398:	1c000166 	pcaddu12i	$r6,11(0xb)
   12000139c:	28fa80c6 	ld.d	$r6,$r6,-352(0xea0)
   1200013a0:	001502e4 	move	$r4,$r23
   1200013a4:	00150005 	move	$r5,$r0
   1200013a8:	541d9800 	bl	7576(0x1d98) # 120003140 <measureFunction>
   1200013ac:	01145400 	frecip.s	$f0,$f0
   1200013b0:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200013b4:	02c58084 	addi.d	$r4,$r4,352(0x160)
   1200013b8:	01192400 	fcvt.d.s	$f0,$f0
   1200013bc:	0114b805 	movfr2gr.d	$r5,$f0
   1200013c0:	57fdc3ff 	bl	-576(0xffffdc0) # 120001180 <printf@plt>
   1200013c4:	01149700 	fmov.s	$f0,$f24
   1200013c8:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200013cc:	28f740c6 	ld.d	$r6,$r6,-560(0xdd0)
   1200013d0:	001502e4 	move	$r4,$r23
   1200013d4:	00150005 	move	$r5,$r0
   1200013d8:	541d6800 	bl	7528(0x1d68) # 120003140 <measureFunction>
   1200013dc:	01192400 	fcvt.d.s	$f0,$f0
   1200013e0:	0114b805 	movfr2gr.d	$r5,$f0
   1200013e4:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200013e8:	02c53084 	addi.d	$r4,$r4,332(0x14c)
   1200013ec:	57fd97ff 	bl	-620(0xffffd94) # 120001180 <printf@plt>
   1200013f0:	01149700 	fmov.s	$f0,$f24
   1200013f4:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200013f8:	28f630c6 	ld.d	$r6,$r6,-628(0xd8c)
   1200013fc:	001502e4 	move	$r4,$r23
   120001400:	00150005 	move	$r5,$r0
   120001404:	541d3c00 	bl	7484(0x1d3c) # 120003140 <measureFunction>
   120001408:	01145400 	frecip.s	$f0,$f0
   12000140c:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001410:	02c51084 	addi.d	$r4,$r4,324(0x144)
   120001414:	01192400 	fcvt.d.s	$f0,$f0
   120001418:	0114b805 	movfr2gr.d	$r5,$f0
   12000141c:	57fd67ff 	bl	-668(0xffffd64) # 120001180 <printf@plt>
   120001420:	01149700 	fmov.s	$f0,$f24
   120001424:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001428:	28f6b0c6 	ld.d	$r6,$r6,-596(0xdac)
   12000142c:	001502e4 	move	$r4,$r23
   120001430:	00150005 	move	$r5,$r0
   120001434:	541d0c00 	bl	7436(0x1d0c) # 120003140 <measureFunction>
   120001438:	01192400 	fcvt.d.s	$f0,$f0
   12000143c:	0114b805 	movfr2gr.d	$r5,$f0
   120001440:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001444:	02c4e084 	addi.d	$r4,$r4,312(0x138)
   120001448:	57fd3bff 	bl	-712(0xffffd38) # 120001180 <printf@plt>
   12000144c:	01149700 	fmov.s	$f0,$f24
   120001450:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001454:	28f460c6 	ld.d	$r6,$r6,-744(0xd18)
   120001458:	001502e4 	move	$r4,$r23
   12000145c:	00150005 	move	$r5,$r0
   120001460:	541ce000 	bl	7392(0x1ce0) # 120003140 <measureFunction>
   120001464:	01145400 	frecip.s	$f0,$f0
   120001468:	1c000064 	pcaddu12i	$r4,3(0x3)
   12000146c:	02c4c084 	addi.d	$r4,$r4,304(0x130)
   120001470:	01192400 	fcvt.d.s	$f0,$f0
   120001474:	0114b805 	movfr2gr.d	$r5,$f0
   120001478:	57fd0bff 	bl	-760(0xffffd08) # 120001180 <printf@plt>
   12000147c:	28c00305 	ld.d	$r5,$r24,0
   120001480:	01149700 	fmov.s	$f0,$f24
   120001484:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001488:	28f3d0c6 	ld.d	$r6,$r6,-780(0xcf4)
   12000148c:	001502e4 	move	$r4,$r23
   120001490:	541cb000 	bl	7344(0x1cb0) # 120003140 <measureFunction>
   120001494:	01192400 	fcvt.d.s	$f0,$f0
   120001498:	0114b805 	movfr2gr.d	$r5,$f0
   12000149c:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200014a0:	02c49084 	addi.d	$r4,$r4,292(0x124)
   1200014a4:	57fcdfff 	bl	-804(0xffffcdc) # 120001180 <printf@plt>
   1200014a8:	01149700 	fmov.s	$f0,$f24
   1200014ac:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200014b0:	28f210c6 	ld.d	$r6,$r6,-892(0xc84)
   1200014b4:	001502e4 	move	$r4,$r23
   1200014b8:	00150005 	move	$r5,$r0
   1200014bc:	541c8400 	bl	7300(0x1c84) # 120003140 <measureFunction>
   1200014c0:	01145400 	frecip.s	$f0,$f0
   1200014c4:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200014c8:	02c45084 	addi.d	$r4,$r4,276(0x114)
   1200014cc:	01192400 	fcvt.d.s	$f0,$f0
   1200014d0:	0114b805 	movfr2gr.d	$r5,$f0
   1200014d4:	57fcafff 	bl	-852(0xffffcac) # 120001180 <printf@plt>
   1200014d8:	01149700 	fmov.s	$f0,$f24
   1200014dc:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200014e0:	28f210c6 	ld.d	$r6,$r6,-892(0xc84)
   1200014e4:	001502e4 	move	$r4,$r23
   1200014e8:	00150005 	move	$r5,$r0
   1200014ec:	541c5400 	bl	7252(0x1c54) # 120003140 <measureFunction>
   1200014f0:	01192400 	fcvt.d.s	$f0,$f0
   1200014f4:	0114b805 	movfr2gr.d	$r5,$f0
   1200014f8:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200014fc:	02c42084 	addi.d	$r4,$r4,264(0x108)
   120001500:	57fc83ff 	bl	-896(0xffffc80) # 120001180 <printf@plt>
   120001504:	01149700 	fmov.s	$f0,$f24
   120001508:	1c000166 	pcaddu12i	$r6,11(0xb)
   12000150c:	28f040c6 	ld.d	$r6,$r6,-1008(0xc10)
   120001510:	001502e4 	move	$r4,$r23
   120001514:	00150005 	move	$r5,$r0
   120001518:	541c2800 	bl	7208(0x1c28) # 120003140 <measureFunction>
   12000151c:	01145400 	frecip.s	$f0,$f0
   120001520:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001524:	02c3e084 	addi.d	$r4,$r4,248(0xf8)
   120001528:	01192400 	fcvt.d.s	$f0,$f0
   12000152c:	0114b805 	movfr2gr.d	$r5,$f0
   120001530:	57fc53ff 	bl	-944(0xffffc50) # 120001180 <printf@plt>
   120001534:	01149700 	fmov.s	$f0,$f24
   120001538:	1c000166 	pcaddu12i	$r6,11(0xb)
   12000153c:	28f0e0c6 	ld.d	$r6,$r6,-968(0xc38)
   120001540:	001502e4 	move	$r4,$r23
   120001544:	00150005 	move	$r5,$r0
   120001548:	541bf800 	bl	7160(0x1bf8) # 120003140 <measureFunction>
   12000154c:	01192400 	fcvt.d.s	$f0,$f0
   120001550:	0114b805 	movfr2gr.d	$r5,$f0
   120001554:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001558:	02c39084 	addi.d	$r4,$r4,228(0xe4)
   12000155c:	57fc27ff 	bl	-988(0xffffc24) # 120001180 <printf@plt>
   120001560:	01149700 	fmov.s	$f0,$f24
   120001564:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001568:	28eef0c6 	ld.d	$r6,$r6,-1092(0xbbc)
   12000156c:	001502e4 	move	$r4,$r23
   120001570:	00150005 	move	$r5,$r0
   120001574:	541bcc00 	bl	7116(0x1bcc) # 120003140 <measureFunction>
   120001578:	01145400 	frecip.s	$f0,$f0
   12000157c:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001580:	02c37084 	addi.d	$r4,$r4,220(0xdc)
   120001584:	01192400 	fcvt.d.s	$f0,$f0
   120001588:	0114b805 	movfr2gr.d	$r5,$f0
   12000158c:	57fbf7ff 	bl	-1036(0xffffbf4) # 120001180 <printf@plt>
   120001590:	01149700 	fmov.s	$f0,$f24
   120001594:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001598:	28eeb0c6 	ld.d	$r6,$r6,-1108(0xbac)
   12000159c:	001502e4 	move	$r4,$r23
   1200015a0:	00150005 	move	$r5,$r0
   1200015a4:	541b9c00 	bl	7068(0x1b9c) # 120003140 <measureFunction>
   1200015a8:	01192400 	fcvt.d.s	$f0,$f0
   1200015ac:	0114b805 	movfr2gr.d	$r5,$f0
   1200015b0:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200015b4:	02c34084 	addi.d	$r4,$r4,208(0xd0)
   1200015b8:	57fbcbff 	bl	-1080(0xffffbc8) # 120001180 <printf@plt>
   1200015bc:	01149700 	fmov.s	$f0,$f24
   1200015c0:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200015c4:	28ed40c6 	ld.d	$r6,$r6,-1200(0xb50)
   1200015c8:	001502e4 	move	$r4,$r23
   1200015cc:	00150005 	move	$r5,$r0
   1200015d0:	541b7000 	bl	7024(0x1b70) # 120003140 <measureFunction>
   1200015d4:	01145400 	frecip.s	$f0,$f0
   1200015d8:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200015dc:	02c32084 	addi.d	$r4,$r4,200(0xc8)
   1200015e0:	01192400 	fcvt.d.s	$f0,$f0
   1200015e4:	0114b805 	movfr2gr.d	$r5,$f0
   1200015e8:	57fb9bff 	bl	-1128(0xffffb98) # 120001180 <printf@plt>
   1200015ec:	01149700 	fmov.s	$f0,$f24
   1200015f0:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200015f4:	28efe0c6 	ld.d	$r6,$r6,-1032(0xbf8)
   1200015f8:	001502e4 	move	$r4,$r23
   1200015fc:	00150005 	move	$r5,$r0
   120001600:	541b4000 	bl	6976(0x1b40) # 120003140 <measureFunction>
   120001604:	01192400 	fcvt.d.s	$f0,$f0
   120001608:	0114b805 	movfr2gr.d	$r5,$f0
   12000160c:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001610:	02c2f084 	addi.d	$r4,$r4,188(0xbc)
   120001614:	57fb6fff 	bl	-1172(0xffffb6c) # 120001180 <printf@plt>
   120001618:	01149700 	fmov.s	$f0,$f24
   12000161c:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001620:	28eb90c6 	ld.d	$r6,$r6,-1308(0xae4)
   120001624:	001502e4 	move	$r4,$r23
   120001628:	00150005 	move	$r5,$r0
   12000162c:	541b1400 	bl	6932(0x1b14) # 120003140 <measureFunction>
   120001630:	01145400 	frecip.s	$f0,$f0
   120001634:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001638:	02c2b084 	addi.d	$r4,$r4,172(0xac)
   12000163c:	01192400 	fcvt.d.s	$f0,$f0
   120001640:	0114b805 	movfr2gr.d	$r5,$f0
   120001644:	57fb3fff 	bl	-1220(0xffffb3c) # 120001180 <printf@plt>
   120001648:	01149700 	fmov.s	$f0,$f24
   12000164c:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001650:	28eb70c6 	ld.d	$r6,$r6,-1316(0xadc)
   120001654:	001502e4 	move	$r4,$r23
   120001658:	00150005 	move	$r5,$r0
   12000165c:	541ae400 	bl	6884(0x1ae4) # 120003140 <measureFunction>
   120001660:	01192400 	fcvt.d.s	$f0,$f0
   120001664:	0114b805 	movfr2gr.d	$r5,$f0
   120001668:	1c000064 	pcaddu12i	$r4,3(0x3)
   12000166c:	02c28084 	addi.d	$r4,$r4,160(0xa0)
   120001670:	57fb13ff 	bl	-1264(0xffffb10) # 120001180 <printf@plt>
   120001674:	01149700 	fmov.s	$f0,$f24
   120001678:	1c000166 	pcaddu12i	$r6,11(0xb)
   12000167c:	28ed00c6 	ld.d	$r6,$r6,-1216(0xb40)
   120001680:	001502e4 	move	$r4,$r23
   120001684:	00150005 	move	$r5,$r0
   120001688:	541ab800 	bl	6840(0x1ab8) # 120003140 <measureFunction>
   12000168c:	01145400 	frecip.s	$f0,$f0
   120001690:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001694:	02c24084 	addi.d	$r4,$r4,144(0x90)
   120001698:	01192400 	fcvt.d.s	$f0,$f0
   12000169c:	0114b805 	movfr2gr.d	$r5,$f0
   1200016a0:	57fae3ff 	bl	-1312(0xffffae0) # 120001180 <printf@plt>
   1200016a4:	01149700 	fmov.s	$f0,$f24
   1200016a8:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200016ac:	28ece0c6 	ld.d	$r6,$r6,-1224(0xb38)
   1200016b0:	001502e4 	move	$r4,$r23
   1200016b4:	00150005 	move	$r5,$r0
   1200016b8:	541a8800 	bl	6792(0x1a88) # 120003140 <measureFunction>
   1200016bc:	01192400 	fcvt.d.s	$f0,$f0
   1200016c0:	0114b805 	movfr2gr.d	$r5,$f0
   1200016c4:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200016c8:	02c1f084 	addi.d	$r4,$r4,124(0x7c)
   1200016cc:	57fab7ff 	bl	-1356(0xffffab4) # 120001180 <printf@plt>
   1200016d0:	01149700 	fmov.s	$f0,$f24
   1200016d4:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200016d8:	28eaf0c6 	ld.d	$r6,$r6,-1348(0xabc)
   1200016dc:	001502e4 	move	$r4,$r23
   1200016e0:	00150005 	move	$r5,$r0
   1200016e4:	541a5c00 	bl	6748(0x1a5c) # 120003140 <measureFunction>
   1200016e8:	01145400 	frecip.s	$f0,$f0
   1200016ec:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200016f0:	02c1b084 	addi.d	$r4,$r4,108(0x6c)
   1200016f4:	01192400 	fcvt.d.s	$f0,$f0
   1200016f8:	0114b805 	movfr2gr.d	$r5,$f0
   1200016fc:	57fa87ff 	bl	-1404(0xffffa84) # 120001180 <printf@plt>
   120001700:	01149700 	fmov.s	$f0,$f24
   120001704:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001708:	28ecb0c6 	ld.d	$r6,$r6,-1236(0xb2c)
   12000170c:	001502e4 	move	$r4,$r23
   120001710:	00150005 	move	$r5,$r0
   120001714:	541a2c00 	bl	6700(0x1a2c) # 120003140 <measureFunction>
   120001718:	01192400 	fcvt.d.s	$f0,$f0
   12000171c:	0114b805 	movfr2gr.d	$r5,$f0
   120001720:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001724:	02c16084 	addi.d	$r4,$r4,88(0x58)
   120001728:	57fa5bff 	bl	-1448(0xffffa58) # 120001180 <printf@plt>
   12000172c:	01149700 	fmov.s	$f0,$f24
   120001730:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001734:	28ea40c6 	ld.d	$r6,$r6,-1392(0xa90)
   120001738:	001502e4 	move	$r4,$r23
   12000173c:	00150005 	move	$r5,$r0
   120001740:	541a0000 	bl	6656(0x1a00) # 120003140 <measureFunction>
   120001744:	01145400 	frecip.s	$f0,$f0
   120001748:	1c000064 	pcaddu12i	$r4,3(0x3)
   12000174c:	02c14084 	addi.d	$r4,$r4,80(0x50)
   120001750:	01192400 	fcvt.d.s	$f0,$f0
   120001754:	0114b805 	movfr2gr.d	$r5,$f0
   120001758:	57fa2bff 	bl	-1496(0xffffa28) # 120001180 <printf@plt>
   12000175c:	01149700 	fmov.s	$f0,$f24
   120001760:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001764:	28eac0c6 	ld.d	$r6,$r6,-1360(0xab0)
   120001768:	001502e4 	move	$r4,$r23
   12000176c:	00150005 	move	$r5,$r0
   120001770:	5419d000 	bl	6608(0x19d0) # 120003140 <measureFunction>
   120001774:	01192400 	fcvt.d.s	$f0,$f0
   120001778:	0114b805 	movfr2gr.d	$r5,$f0
   12000177c:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001780:	02c11084 	addi.d	$r4,$r4,68(0x44)
   120001784:	57f9ffff 	bl	-1540(0xffff9fc) # 120001180 <printf@plt>
   120001788:	01149700 	fmov.s	$f0,$f24
   12000178c:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001790:	28e870c6 	ld.d	$r6,$r6,-1508(0xa1c)
   120001794:	001502e4 	move	$r4,$r23
   120001798:	00150005 	move	$r5,$r0
   12000179c:	5419a400 	bl	6564(0x19a4) # 120003140 <measureFunction>
   1200017a0:	01145400 	frecip.s	$f0,$f0
   1200017a4:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200017a8:	02c0f084 	addi.d	$r4,$r4,60(0x3c)
   1200017ac:	01192400 	fcvt.d.s	$f0,$f0
   1200017b0:	0114b805 	movfr2gr.d	$r5,$f0
   1200017b4:	57f9cfff 	bl	-1588(0xffff9cc) # 120001180 <printf@plt>
   1200017b8:	01149700 	fmov.s	$f0,$f24
   1200017bc:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200017c0:	28e4d0c6 	ld.d	$r6,$r6,-1740(0x934)
   1200017c4:	001502e4 	move	$r4,$r23
   1200017c8:	00150005 	move	$r5,$r0
   1200017cc:	54197400 	bl	6516(0x1974) # 120003140 <measureFunction>
   1200017d0:	01192400 	fcvt.d.s	$f0,$f0
   1200017d4:	0114b805 	movfr2gr.d	$r5,$f0
   1200017d8:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200017dc:	02c0c084 	addi.d	$r4,$r4,48(0x30)
   1200017e0:	57f9a3ff 	bl	-1632(0xffff9a0) # 120001180 <printf@plt>
   1200017e4:	01149700 	fmov.s	$f0,$f24
   1200017e8:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200017ec:	28e900c6 	ld.d	$r6,$r6,-1472(0xa40)
   1200017f0:	001502e4 	move	$r4,$r23
   1200017f4:	00150005 	move	$r5,$r0
   1200017f8:	54194800 	bl	6472(0x1948) # 120003140 <measureFunction>
   1200017fc:	01192400 	fcvt.d.s	$f0,$f0
   120001800:	0114b805 	movfr2gr.d	$r5,$f0
   120001804:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001808:	02c09084 	addi.d	$r4,$r4,36(0x24)
   12000180c:	57f977ff 	bl	-1676(0xffff974) # 120001180 <printf@plt>
   120001810:	01149700 	fmov.s	$f0,$f24
   120001814:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001818:	28e510c6 	ld.d	$r6,$r6,-1724(0x944)
   12000181c:	001502e4 	move	$r4,$r23
   120001820:	00150005 	move	$r5,$r0
   120001824:	54191c00 	bl	6428(0x191c) # 120003140 <measureFunction>
   120001828:	01192400 	fcvt.d.s	$f0,$f0
   12000182c:	0114b805 	movfr2gr.d	$r5,$f0
   120001830:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001834:	02c06084 	addi.d	$r4,$r4,24(0x18)
   120001838:	57f94bff 	bl	-1720(0xffff948) # 120001180 <printf@plt>
   12000183c:	01149700 	fmov.s	$f0,$f24
   120001840:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001844:	28e2a0c6 	ld.d	$r6,$r6,-1880(0x8a8)
   120001848:	001502e4 	move	$r4,$r23
   12000184c:	00150005 	move	$r5,$r0
   120001850:	5418f000 	bl	6384(0x18f0) # 120003140 <measureFunction>
   120001854:	01192400 	fcvt.d.s	$f0,$f0
   120001858:	0114b805 	movfr2gr.d	$r5,$f0
   12000185c:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001860:	02c03084 	addi.d	$r4,$r4,12(0xc)
   120001864:	57f91fff 	bl	-1764(0xffff91c) # 120001180 <printf@plt>
   120001868:	01149700 	fmov.s	$f0,$f24
   12000186c:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001870:	28e650c6 	ld.d	$r6,$r6,-1644(0x994)
   120001874:	001502e4 	move	$r4,$r23
   120001878:	00150005 	move	$r5,$r0
   12000187c:	5418c400 	bl	6340(0x18c4) # 120003140 <measureFunction>
   120001880:	01192400 	fcvt.d.s	$f0,$f0
   120001884:	0114b805 	movfr2gr.d	$r5,$f0
   120001888:	1c000064 	pcaddu12i	$r4,3(0x3)
   12000188c:	02c00084 	addi.d	$r4,$r4,0
   120001890:	57f8f3ff 	bl	-1808(0xffff8f0) # 120001180 <printf@plt>
   120001894:	01149700 	fmov.s	$f0,$f24
   120001898:	1c000166 	pcaddu12i	$r6,11(0xb)
   12000189c:	28e620c6 	ld.d	$r6,$r6,-1656(0x988)
   1200018a0:	001502e4 	move	$r4,$r23
   1200018a4:	00150005 	move	$r5,$r0
   1200018a8:	54189800 	bl	6296(0x1898) # 120003140 <measureFunction>
   1200018ac:	01192400 	fcvt.d.s	$f0,$f0
   1200018b0:	0114b805 	movfr2gr.d	$r5,$f0
   1200018b4:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200018b8:	02ffd084 	addi.d	$r4,$r4,-12(0xff4)
   1200018bc:	57f8c7ff 	bl	-1852(0xffff8c4) # 120001180 <printf@plt>
   1200018c0:	01149700 	fmov.s	$f0,$f24
   1200018c4:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200018c8:	28e1d0c6 	ld.d	$r6,$r6,-1932(0x874)
   1200018cc:	001502e4 	move	$r4,$r23
   1200018d0:	00150005 	move	$r5,$r0
   1200018d4:	54186c00 	bl	6252(0x186c) # 120003140 <measureFunction>
   1200018d8:	01192400 	fcvt.d.s	$f0,$f0
   1200018dc:	0114b805 	movfr2gr.d	$r5,$f0
   1200018e0:	1c000064 	pcaddu12i	$r4,3(0x3)
   1200018e4:	02ffa084 	addi.d	$r4,$r4,-24(0xfe8)
   1200018e8:	57f89bff 	bl	-1896(0xffff898) # 120001180 <printf@plt>
   1200018ec:	01149700 	fmov.s	$f0,$f24
   1200018f0:	1c000166 	pcaddu12i	$r6,11(0xb)
   1200018f4:	28e4a0c6 	ld.d	$r6,$r6,-1752(0x928)
   1200018f8:	001502e4 	move	$r4,$r23
   1200018fc:	1c000145 	pcaddu12i	$r5,10(0xa)
   120001900:	02dc10a5 	addi.d	$r5,$r5,1796(0x704)
   120001904:	54183c00 	bl	6204(0x183c) # 120003140 <measureFunction>
   120001908:	01192400 	fcvt.d.s	$f0,$f0
   12000190c:	0114b805 	movfr2gr.d	$r5,$f0
   120001910:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001914:	02ff8084 	addi.d	$r4,$r4,-32(0xfe0)
   120001918:	57f86bff 	bl	-1944(0xffff868) # 120001180 <printf@plt>
   12000191c:	01149700 	fmov.s	$f0,$f24
   120001920:	001502e4 	move	$r4,$r23
   120001924:	1c000166 	pcaddu12i	$r6,11(0xb)
   120001928:	28e2d0c6 	ld.d	$r6,$r6,-1868(0x8b4)
   12000192c:	1c000145 	pcaddu12i	$r5,10(0xa)
   120001930:	02db50a5 	addi.d	$r5,$r5,1748(0x6d4)
   120001934:	54180c00 	bl	6156(0x180c) # 120003140 <measureFunction>
   120001938:	01192400 	fcvt.d.s	$f0,$f0
   12000193c:	0114b805 	movfr2gr.d	$r5,$f0
   120001940:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001944:	02ff2084 	addi.d	$r4,$r4,-56(0xfc8)
   120001948:	57f83bff 	bl	-1992(0xffff838) # 120001180 <printf@plt>
   12000194c:	5003e800 	b	1000(0x3e8) # 120001d34 <main+0xb94>
   120001950:	28c04364 	ld.d	$r4,$r27,16(0x10)
   120001954:	157e11d9 	lu12i.w	$r25,-266098(0xbf08e)
   120001958:	02802806 	addi.w	$r6,$r0,10(0xa)
   12000195c:	00150005 	move	$r5,$r0
   120001960:	03ac0339 	ori	$r25,$r25,0xb00
   120001964:	57f7ffff 	bl	-2052(0xffff7fc) # 120001160 <strtol@plt>
   120001968:	16000039 	lu32i.d	$r25,1(0x1)
   12000196c:	001de499 	mul.d	$r25,$r4,$r25
   120001970:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001974:	02ec6084 	addi.d	$r4,$r4,-1256(0xb18)
   120001978:	00150325 	move	$r5,$r25
   12000197c:	57f807ff 	bl	-2044(0xffff804) # 120001180 <printf@plt>
   120001980:	1c00006c 	pcaddu12i	$r12,3(0x3)
   120001984:	02c5a18c 	addi.d	$r12,$r12,360(0x168)
   120001988:	28c00185 	ld.d	$r5,$r12,0
   12000198c:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001990:	02ec5084 	addi.d	$r4,$r4,-1260(0xb14)
   120001994:	57f7efff 	bl	-2068(0xffff7ec) # 120001180 <printf@plt>
   120001998:	28c02377 	ld.d	$r23,$r27,8(0x8)
   12000199c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   1200019a0:	1c000065 	pcaddu12i	$r5,3(0x3)
   1200019a4:	02fe00a5 	addi.d	$r5,$r5,-128(0xf80)
   1200019a8:	001502e4 	move	$r4,$r23
   1200019ac:	57f7c7ff 	bl	-2108(0xffff7c4) # 120001170 <strncmp@plt>
   1200019b0:	4003b880 	beqz	$r4,952(0x3b8) # 120001d68 <main+0xbc8>
   1200019b4:	02800c06 	addi.w	$r6,$r0,3(0x3)
   1200019b8:	1c000065 	pcaddu12i	$r5,3(0x3)
   1200019bc:	02c380a5 	addi.d	$r5,$r5,224(0xe0)
   1200019c0:	001502e4 	move	$r4,$r23
   1200019c4:	57f7afff 	bl	-2132(0xffff7ac) # 120001170 <strncmp@plt>
   1200019c8:	40155c80 	beqz	$r4,5468(0x155c) # 120002f24 <main+0x1d84>
   1200019cc:	02800c06 	addi.w	$r6,$r0,3(0x3)
   1200019d0:	1c000065 	pcaddu12i	$r5,3(0x3)
   1200019d4:	02c280a5 	addi.d	$r5,$r5,160(0xa0)
   1200019d8:	001502e4 	move	$r4,$r23
   1200019dc:	57f797ff 	bl	-2156(0xffff794) # 120001170 <strncmp@plt>
   1200019e0:	40150480 	beqz	$r4,5380(0x1504) # 120002ee4 <main+0x1d44>
   1200019e4:	02800c06 	addi.w	$r6,$r0,3(0x3)
   1200019e8:	1c000065 	pcaddu12i	$r5,3(0x3)
   1200019ec:	02fd00a5 	addi.d	$r5,$r5,-192(0xf40)
   1200019f0:	001502e4 	move	$r4,$r23
   1200019f4:	57f77fff 	bl	-2180(0xffff77c) # 120001170 <strncmp@plt>
   1200019f8:	4014a880 	beqz	$r4,5288(0x14a8) # 120002ea0 <main+0x1d00>
   1200019fc:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001a00:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001a04:	02fce0a5 	addi.d	$r5,$r5,-200(0xf38)
   120001a08:	001502e4 	move	$r4,$r23
   120001a0c:	57f767ff 	bl	-2204(0xffff764) # 120001170 <strncmp@plt>
   120001a10:	40145080 	beqz	$r4,5200(0x1450) # 120002e60 <main+0x1cc0>
   120001a14:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001a18:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001a1c:	02fca0a5 	addi.d	$r5,$r5,-216(0xf28)
   120001a20:	001502e4 	move	$r4,$r23
   120001a24:	57f74fff 	bl	-2228(0xffff74c) # 120001170 <strncmp@plt>
   120001a28:	4013f480 	beqz	$r4,5108(0x13f4) # 120002e1c <main+0x1c7c>
   120001a2c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001a30:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001a34:	02fc80a5 	addi.d	$r5,$r5,-224(0xf20)
   120001a38:	001502e4 	move	$r4,$r23
   120001a3c:	57f737ff 	bl	-2252(0xffff734) # 120001170 <strncmp@plt>
   120001a40:	40139c80 	beqz	$r4,5020(0x139c) # 120002ddc <main+0x1c3c>
   120001a44:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001a48:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001a4c:	02fc40a5 	addi.d	$r5,$r5,-240(0xf10)
   120001a50:	001502e4 	move	$r4,$r23
   120001a54:	57f71fff 	bl	-2276(0xffff71c) # 120001170 <strncmp@plt>
   120001a58:	40134080 	beqz	$r4,4928(0x1340) # 120002d98 <main+0x1bf8>
   120001a5c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001a60:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001a64:	02fc20a5 	addi.d	$r5,$r5,-248(0xf08)
   120001a68:	001502e4 	move	$r4,$r23
   120001a6c:	57f707ff 	bl	-2300(0xffff704) # 120001170 <strncmp@plt>
   120001a70:	4012e880 	beqz	$r4,4840(0x12e8) # 120002d58 <main+0x1bb8>
   120001a74:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001a78:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001a7c:	02fbe0a5 	addi.d	$r5,$r5,-264(0xef8)
   120001a80:	001502e4 	move	$r4,$r23
   120001a84:	57f6efff 	bl	-2324(0xffff6ec) # 120001170 <strncmp@plt>
   120001a88:	40128c80 	beqz	$r4,4748(0x128c) # 120002d14 <main+0x1b74>
   120001a8c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001a90:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001a94:	02ffc0a5 	addi.d	$r5,$r5,-16(0xff0)
   120001a98:	001502e4 	move	$r4,$r23
   120001a9c:	57f6d7ff 	bl	-2348(0xffff6d4) # 120001170 <strncmp@plt>
   120001aa0:	40123480 	beqz	$r4,4660(0x1234) # 120002cd4 <main+0x1b34>
   120001aa4:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001aa8:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001aac:	02fb60a5 	addi.d	$r5,$r5,-296(0xed8)
   120001ab0:	001502e4 	move	$r4,$r23
   120001ab4:	57f6bfff 	bl	-2372(0xffff6bc) # 120001170 <strncmp@plt>
   120001ab8:	4011d880 	beqz	$r4,4568(0x11d8) # 120002c90 <main+0x1af0>
   120001abc:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001ac0:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001ac4:	02fb40a5 	addi.d	$r5,$r5,-304(0xed0)
   120001ac8:	001502e4 	move	$r4,$r23
   120001acc:	57f6a7ff 	bl	-2396(0xffff6a4) # 120001170 <strncmp@plt>
   120001ad0:	40118080 	beqz	$r4,4480(0x1180) # 120002c50 <main+0x1ab0>
   120001ad4:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001ad8:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001adc:	02fb00a5 	addi.d	$r5,$r5,-320(0xec0)
   120001ae0:	001502e4 	move	$r4,$r23
   120001ae4:	57f68fff 	bl	-2420(0xffff68c) # 120001170 <strncmp@plt>
   120001ae8:	40112480 	beqz	$r4,4388(0x1124) # 120002c0c <main+0x1a6c>
   120001aec:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001af0:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001af4:	02fae0a5 	addi.d	$r5,$r5,-328(0xeb8)
   120001af8:	001502e4 	move	$r4,$r23
   120001afc:	57f677ff 	bl	-2444(0xffff674) # 120001170 <strncmp@plt>
   120001b00:	4010cc80 	beqz	$r4,4300(0x10cc) # 120002bcc <main+0x1a2c>
   120001b04:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001b08:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001b0c:	02faa0a5 	addi.d	$r5,$r5,-344(0xea8)
   120001b10:	001502e4 	move	$r4,$r23
   120001b14:	57f65fff 	bl	-2468(0xffff65c) # 120001170 <strncmp@plt>
   120001b18:	40107480 	beqz	$r4,4212(0x1074) # 120002b8c <main+0x19ec>
   120001b1c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001b20:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001b24:	02fa60a5 	addi.d	$r5,$r5,-360(0xe98)
   120001b28:	001502e4 	move	$r4,$r23
   120001b2c:	57f647ff 	bl	-2492(0xffff644) # 120001170 <strncmp@plt>
   120001b30:	40101880 	beqz	$r4,4120(0x1018) # 120002b48 <main+0x19a8>
   120001b34:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001b38:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001b3c:	02fa40a5 	addi.d	$r5,$r5,-368(0xe90)
   120001b40:	001502e4 	move	$r4,$r23
   120001b44:	57f62fff 	bl	-2516(0xffff62c) # 120001170 <strncmp@plt>
   120001b48:	400fc080 	beqz	$r4,4032(0xfc0) # 120002b08 <main+0x1968>
   120001b4c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001b50:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001b54:	02fa00a5 	addi.d	$r5,$r5,-384(0xe80)
   120001b58:	001502e4 	move	$r4,$r23
   120001b5c:	57f617ff 	bl	-2540(0xffff614) # 120001170 <strncmp@plt>
   120001b60:	400f6480 	beqz	$r4,3940(0xf64) # 120002ac4 <main+0x1924>
   120001b64:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001b68:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001b6c:	02f9e0a5 	addi.d	$r5,$r5,-392(0xe78)
   120001b70:	001502e4 	move	$r4,$r23
   120001b74:	57f5ffff 	bl	-2564(0xffff5fc) # 120001170 <strncmp@plt>
   120001b78:	400f0c80 	beqz	$r4,3852(0xf0c) # 120002a84 <main+0x18e4>
   120001b7c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001b80:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001b84:	02f9a0a5 	addi.d	$r5,$r5,-408(0xe68)
   120001b88:	001502e4 	move	$r4,$r23
   120001b8c:	57f5e7ff 	bl	-2588(0xffff5e4) # 120001170 <strncmp@plt>
   120001b90:	400eb080 	beqz	$r4,3760(0xeb0) # 120002a40 <main+0x18a0>
   120001b94:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001b98:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001b9c:	02f980a5 	addi.d	$r5,$r5,-416(0xe60)
   120001ba0:	001502e4 	move	$r4,$r23
   120001ba4:	57f5cfff 	bl	-2612(0xffff5cc) # 120001170 <strncmp@plt>
   120001ba8:	400e5880 	beqz	$r4,3672(0xe58) # 120002a00 <main+0x1860>
   120001bac:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001bb0:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001bb4:	02f940a5 	addi.d	$r5,$r5,-432(0xe50)
   120001bb8:	001502e4 	move	$r4,$r23
   120001bbc:	57f5b7ff 	bl	-2636(0xffff5b4) # 120001170 <strncmp@plt>
   120001bc0:	400dfc80 	beqz	$r4,3580(0xdfc) # 1200029bc <main+0x181c>
   120001bc4:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001bc8:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001bcc:	02f920a5 	addi.d	$r5,$r5,-440(0xe48)
   120001bd0:	001502e4 	move	$r4,$r23
   120001bd4:	57f59fff 	bl	-2660(0xffff59c) # 120001170 <strncmp@plt>
   120001bd8:	400da480 	beqz	$r4,3492(0xda4) # 12000297c <main+0x17dc>
   120001bdc:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001be0:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001be4:	02f8e0a5 	addi.d	$r5,$r5,-456(0xe38)
   120001be8:	001502e4 	move	$r4,$r23
   120001bec:	57f587ff 	bl	-2684(0xffff584) # 120001170 <strncmp@plt>
   120001bf0:	400d4880 	beqz	$r4,3400(0xd48) # 120002938 <main+0x1798>
   120001bf4:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001bf8:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001bfc:	02f8c0a5 	addi.d	$r5,$r5,-464(0xe30)
   120001c00:	001502e4 	move	$r4,$r23
   120001c04:	57f56fff 	bl	-2708(0xffff56c) # 120001170 <strncmp@plt>
   120001c08:	400cf080 	beqz	$r4,3312(0xcf0) # 1200028f8 <main+0x1758>
   120001c0c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001c10:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001c14:	02f8a0a5 	addi.d	$r5,$r5,-472(0xe28)
   120001c18:	001502e4 	move	$r4,$r23
   120001c1c:	57f557ff 	bl	-2732(0xffff554) # 120001170 <strncmp@plt>
   120001c20:	400c9880 	beqz	$r4,3224(0xc98) # 1200028b8 <main+0x1718>
   120001c24:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001c28:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001c2c:	02f880a5 	addi.d	$r5,$r5,-480(0xe20)
   120001c30:	001502e4 	move	$r4,$r23
   120001c34:	57f53fff 	bl	-2756(0xffff53c) # 120001170 <strncmp@plt>
   120001c38:	400c4080 	beqz	$r4,3136(0xc40) # 120002878 <main+0x16d8>
   120001c3c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001c40:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001c44:	02f860a5 	addi.d	$r5,$r5,-488(0xe18)
   120001c48:	001502e4 	move	$r4,$r23
   120001c4c:	57f527ff 	bl	-2780(0xffff524) # 120001170 <strncmp@plt>
   120001c50:	400be880 	beqz	$r4,3048(0xbe8) # 120002838 <main+0x1698>
   120001c54:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001c58:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001c5c:	02f840a5 	addi.d	$r5,$r5,-496(0xe10)
   120001c60:	001502e4 	move	$r4,$r23
   120001c64:	57f50fff 	bl	-2804(0xffff50c) # 120001170 <strncmp@plt>
   120001c68:	400b9080 	beqz	$r4,2960(0xb90) # 1200027f8 <main+0x1658>
   120001c6c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001c70:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001c74:	02f820a5 	addi.d	$r5,$r5,-504(0xe08)
   120001c78:	001502e4 	move	$r4,$r23
   120001c7c:	57f4f7ff 	bl	-2828(0xffff4f4) # 120001170 <strncmp@plt>
   120001c80:	400b3880 	beqz	$r4,2872(0xb38) # 1200027b8 <main+0x1618>
   120001c84:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001c88:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001c8c:	02f800a5 	addi.d	$r5,$r5,-512(0xe00)
   120001c90:	001502e4 	move	$r4,$r23
   120001c94:	57f4dfff 	bl	-2852(0xffff4dc) # 120001170 <strncmp@plt>
   120001c98:	400ae080 	beqz	$r4,2784(0xae0) # 120002778 <main+0x15d8>
   120001c9c:	02801006 	addi.w	$r6,$r0,4(0x4)
   120001ca0:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001ca4:	02f800a5 	addi.d	$r5,$r5,-512(0xe00)
   120001ca8:	001502e4 	move	$r4,$r23
   120001cac:	57f4c7ff 	bl	-2876(0xffff4c4) # 120001170 <strncmp@plt>
   120001cb0:	400a8080 	beqz	$r4,2688(0xa80) # 120002730 <main+0x1590>
   120001cb4:	02801006 	addi.w	$r6,$r0,4(0x4)
   120001cb8:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001cbc:	02f7c0a5 	addi.d	$r5,$r5,-528(0xdf0)
   120001cc0:	001502e4 	move	$r4,$r23
   120001cc4:	57f4afff 	bl	-2900(0xffff4ac) # 120001170 <strncmp@plt>
   120001cc8:	44004880 	bnez	$r4,72(0x48) # 120001d10 <main+0xb70>
   120001ccc:	1c00006c 	pcaddu12i	$r12,3(0x3)
   120001cd0:	02f8b18c 	addi.d	$r12,$r12,-468(0xe2c)
   120001cd4:	2b000180 	fld.s	$f0,$r12,0
   120001cd8:	1c000146 	pcaddu12i	$r6,10(0xa)
   120001cdc:	28d400c6 	ld.d	$r6,$r6,1280(0x500)
   120001ce0:	1c000145 	pcaddu12i	$r5,10(0xa)
   120001ce4:	02cc80a5 	addi.d	$r5,$r5,800(0x320)
   120001ce8:	00150324 	move	$r4,$r25
   120001cec:	54145400 	bl	5204(0x1454) # 120003140 <measureFunction>
   120001cf0:	01192400 	fcvt.d.s	$f0,$f0
   120001cf4:	0114b805 	movfr2gr.d	$r5,$f0
   120001cf8:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001cfc:	02f04084 	addi.d	$r4,$r4,-1008(0xc10)
   120001d00:	57f483ff 	bl	-2944(0xffff480) # 120001180 <printf@plt>
   120001d04:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120001d08:	67f5259c 	bge	$r12,$r28,-2780(0x3f524) # 12000122c <main+0x8c>
   120001d0c:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120001d10:	02801006 	addi.w	$r6,$r0,4(0x4)
   120001d14:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001d18:	02f670a5 	addi.d	$r5,$r5,-612(0xd9c)
   120001d1c:	001502e4 	move	$r4,$r23
   120001d20:	57f453ff 	bl	-2992(0xffff450) # 120001170 <strncmp@plt>
   120001d24:	47f5089f 	bnez	$r4,-2808(0x7ff508) # 12000122c <main+0x8c>
   120001d28:	1c00006c 	pcaddu12i	$r12,3(0x3)
   120001d2c:	02f7418c 	addi.d	$r12,$r12,-560(0xdd0)
   120001d30:	2b000198 	fld.s	$f24,$r12,0
   120001d34:	01149700 	fmov.s	$f0,$f24
   120001d38:	00150324 	move	$r4,$r25
   120001d3c:	1c000146 	pcaddu12i	$r6,10(0xa)
   120001d40:	28cef0c6 	ld.d	$r6,$r6,956(0x3bc)
   120001d44:	1c000145 	pcaddu12i	$r5,10(0xa)
   120001d48:	02caf0a5 	addi.d	$r5,$r5,700(0x2bc)
   120001d4c:	5413f400 	bl	5108(0x13f4) # 120003140 <measureFunction>
   120001d50:	01192400 	fcvt.d.s	$f0,$f0
   120001d54:	0114b805 	movfr2gr.d	$r5,$f0
   120001d58:	1c000064 	pcaddu12i	$r4,3(0x3)
   120001d5c:	02f5a084 	addi.d	$r4,$r4,-664(0xd68)
   120001d60:	57f423ff 	bl	-3040(0xffff420) # 120001180 <printf@plt>
   120001d64:	53f4cbff 	b	-2872(0xffff4c8) # 12000122c <main+0x8c>
   120001d68:	1c00007a 	pcaddu12i	$r26,3(0x3)
   120001d6c:	02f6435a 	addi.d	$r26,$r26,-624(0xd90)
   120001d70:	2b000358 	fld.s	$f24,$r26,0
   120001d74:	1c000146 	pcaddu12i	$r6,10(0xa)
   120001d78:	28d1f0c6 	ld.d	$r6,$r6,1148(0x47c)
   120001d7c:	00150005 	move	$r5,$r0
   120001d80:	01149700 	fmov.s	$f0,$f24
   120001d84:	00150324 	move	$r4,$r25
   120001d88:	5413b800 	bl	5048(0x13b8) # 120003140 <measureFunction>
   120001d8c:	01192400 	fcvt.d.s	$f0,$f0
   120001d90:	0114b805 	movfr2gr.d	$r5,$f0
   120001d94:	1c000044 	pcaddu12i	$r4,2(0x2)
   120001d98:	02dcd084 	addi.d	$r4,$r4,1844(0x734)
   120001d9c:	57f3e7ff 	bl	-3100(0xffff3e4) # 120001180 <printf@plt>
   120001da0:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120001da4:	67f4899c 	bge	$r12,$r28,-2936(0x3f488) # 12000122c <main+0x8c>
   120001da8:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120001dac:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001db0:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001db4:	02f3a0a5 	addi.d	$r5,$r5,-792(0xce8)
   120001db8:	001502e4 	move	$r4,$r23
   120001dbc:	57f3b7ff 	bl	-3148(0xffff3b4) # 120001170 <strncmp@plt>
   120001dc0:	47fc0c9f 	bnez	$r4,-1012(0x7ffc0c) # 1200019cc <main+0x82c>
   120001dc4:	01149700 	fmov.s	$f0,$f24
   120001dc8:	00150324 	move	$r4,$r25
   120001dcc:	00150005 	move	$r5,$r0
   120001dd0:	1c000146 	pcaddu12i	$r6,10(0xa)
   120001dd4:	28cf40c6 	ld.d	$r6,$r6,976(0x3d0)
   120001dd8:	54136800 	bl	4968(0x1368) # 120003140 <measureFunction>
   120001ddc:	01192400 	fcvt.d.s	$f0,$f0
   120001de0:	0114b805 	movfr2gr.d	$r5,$f0
   120001de4:	1c000044 	pcaddu12i	$r4,2(0x2)
   120001de8:	02dbf084 	addi.d	$r4,$r4,1788(0x6fc)
   120001dec:	57f397ff 	bl	-3180(0xffff394) # 120001180 <printf@plt>
   120001df0:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120001df4:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001df8:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001dfc:	02f1e0a5 	addi.d	$r5,$r5,-904(0xc78)
   120001e00:	001502e4 	move	$r4,$r23
   120001e04:	57f36fff 	bl	-3220(0xffff36c) # 120001170 <strncmp@plt>
   120001e08:	47fbdc9f 	bnez	$r4,-1060(0x7ffbdc) # 1200019e4 <main+0x844>
   120001e0c:	2b000340 	fld.s	$f0,$r26,0
   120001e10:	00150324 	move	$r4,$r25
   120001e14:	00150005 	move	$r5,$r0
   120001e18:	1c000146 	pcaddu12i	$r6,10(0xa)
   120001e1c:	28ccc0c6 	ld.d	$r6,$r6,816(0x330)
   120001e20:	54132000 	bl	4896(0x1320) # 120003140 <measureFunction>
   120001e24:	01192400 	fcvt.d.s	$f0,$f0
   120001e28:	0114b805 	movfr2gr.d	$r5,$f0
   120001e2c:	1c000044 	pcaddu12i	$r4,2(0x2)
   120001e30:	02db3084 	addi.d	$r4,$r4,1740(0x6cc)
   120001e34:	57f34fff 	bl	-3252(0xffff34c) # 120001180 <printf@plt>
   120001e38:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120001e3c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001e40:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001e44:	02eba0a5 	addi.d	$r5,$r5,-1304(0xae8)
   120001e48:	001502e4 	move	$r4,$r23
   120001e4c:	57f327ff 	bl	-3292(0xffff324) # 120001170 <strncmp@plt>
   120001e50:	47fbac9f 	bnez	$r4,-1108(0x7ffbac) # 1200019fc <main+0x85c>
   120001e54:	2b000340 	fld.s	$f0,$r26,0
   120001e58:	00150324 	move	$r4,$r25
   120001e5c:	00150005 	move	$r5,$r0
   120001e60:	1c000146 	pcaddu12i	$r6,10(0xa)
   120001e64:	28cf60c6 	ld.d	$r6,$r6,984(0x3d8)
   120001e68:	5412d800 	bl	4824(0x12d8) # 120003140 <measureFunction>
   120001e6c:	01145400 	frecip.s	$f0,$f0
   120001e70:	1c000044 	pcaddu12i	$r4,2(0x2)
   120001e74:	02da8084 	addi.d	$r4,$r4,1696(0x6a0)
   120001e78:	01192400 	fcvt.d.s	$f0,$f0
   120001e7c:	0114b805 	movfr2gr.d	$r5,$f0
   120001e80:	57f303ff 	bl	-3328(0xffff300) # 120001180 <printf@plt>
   120001e84:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120001e88:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001e8c:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001e90:	02eab0a5 	addi.d	$r5,$r5,-1364(0xaac)
   120001e94:	001502e4 	move	$r4,$r23
   120001e98:	57f2dbff 	bl	-3368(0xffff2d8) # 120001170 <strncmp@plt>
   120001e9c:	47fb789f 	bnez	$r4,-1160(0x7ffb78) # 120001a14 <main+0x874>
   120001ea0:	2b000340 	fld.s	$f0,$r26,0
   120001ea4:	00150324 	move	$r4,$r25
   120001ea8:	00150005 	move	$r5,$r0
   120001eac:	1c000146 	pcaddu12i	$r6,10(0xa)
   120001eb0:	28cbb0c6 	ld.d	$r6,$r6,748(0x2ec)
   120001eb4:	54128c00 	bl	4748(0x128c) # 120003140 <measureFunction>
   120001eb8:	01192400 	fcvt.d.s	$f0,$f0
   120001ebc:	0114b805 	movfr2gr.d	$r5,$f0
   120001ec0:	1c000044 	pcaddu12i	$r4,2(0x2)
   120001ec4:	02d9c084 	addi.d	$r4,$r4,1648(0x670)
   120001ec8:	57f2bbff 	bl	-3400(0xffff2b8) # 120001180 <printf@plt>
   120001ecc:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120001ed0:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001ed4:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001ed8:	02e9b0a5 	addi.d	$r5,$r5,-1428(0xa6c)
   120001edc:	001502e4 	move	$r4,$r23
   120001ee0:	57f293ff 	bl	-3440(0xffff290) # 120001170 <strncmp@plt>
   120001ee4:	47fb489f 	bnez	$r4,-1208(0x7ffb48) # 120001a2c <main+0x88c>
   120001ee8:	2b000340 	fld.s	$f0,$r26,0
   120001eec:	00150324 	move	$r4,$r25
   120001ef0:	00150005 	move	$r5,$r0
   120001ef4:	1c000146 	pcaddu12i	$r6,10(0xa)
   120001ef8:	28ca30c6 	ld.d	$r6,$r6,652(0x28c)
   120001efc:	54124400 	bl	4676(0x1244) # 120003140 <measureFunction>
   120001f00:	01145400 	frecip.s	$f0,$f0
   120001f04:	1c000044 	pcaddu12i	$r4,2(0x2)
   120001f08:	02d93084 	addi.d	$r4,$r4,1612(0x64c)
   120001f0c:	01192400 	fcvt.d.s	$f0,$f0
   120001f10:	0114b805 	movfr2gr.d	$r5,$f0
   120001f14:	57f26fff 	bl	-3476(0xffff26c) # 120001180 <printf@plt>
   120001f18:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120001f1c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001f20:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001f24:	02e8c0a5 	addi.d	$r5,$r5,-1488(0xa30)
   120001f28:	001502e4 	move	$r4,$r23
   120001f2c:	57f247ff 	bl	-3516(0xffff244) # 120001170 <strncmp@plt>
   120001f30:	47fb149f 	bnez	$r4,-1260(0x7ffb14) # 120001a44 <main+0x8a4>
   120001f34:	2b000340 	fld.s	$f0,$r26,0
   120001f38:	00150324 	move	$r4,$r25
   120001f3c:	00150005 	move	$r5,$r0
   120001f40:	1c000146 	pcaddu12i	$r6,10(0xa)
   120001f44:	28ca40c6 	ld.d	$r6,$r6,656(0x290)
   120001f48:	5411f800 	bl	4600(0x11f8) # 120003140 <measureFunction>
   120001f4c:	01192400 	fcvt.d.s	$f0,$f0
   120001f50:	0114b805 	movfr2gr.d	$r5,$f0
   120001f54:	1c000044 	pcaddu12i	$r4,2(0x2)
   120001f58:	02d89084 	addi.d	$r4,$r4,1572(0x624)
   120001f5c:	57f227ff 	bl	-3548(0xffff224) # 120001180 <printf@plt>
   120001f60:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120001f64:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001f68:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001f6c:	02e7c0a5 	addi.d	$r5,$r5,-1552(0x9f0)
   120001f70:	001502e4 	move	$r4,$r23
   120001f74:	57f1ffff 	bl	-3588(0xffff1fc) # 120001170 <strncmp@plt>
   120001f78:	47fae49f 	bnez	$r4,-1308(0x7ffae4) # 120001a5c <main+0x8bc>
   120001f7c:	2b000340 	fld.s	$f0,$r26,0
   120001f80:	00150324 	move	$r4,$r25
   120001f84:	00150005 	move	$r5,$r0
   120001f88:	1c000146 	pcaddu12i	$r6,10(0xa)
   120001f8c:	28c780c6 	ld.d	$r6,$r6,480(0x1e0)
   120001f90:	5411b000 	bl	4528(0x11b0) # 120003140 <measureFunction>
   120001f94:	01145400 	frecip.s	$f0,$f0
   120001f98:	1c000044 	pcaddu12i	$r4,2(0x2)
   120001f9c:	02d80084 	addi.d	$r4,$r4,1536(0x600)
   120001fa0:	01192400 	fcvt.d.s	$f0,$f0
   120001fa4:	0114b805 	movfr2gr.d	$r5,$f0
   120001fa8:	57f1dbff 	bl	-3624(0xffff1d8) # 120001180 <printf@plt>
   120001fac:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120001fb0:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001fb4:	1c000065 	pcaddu12i	$r5,3(0x3)
   120001fb8:	02e6d0a5 	addi.d	$r5,$r5,-1612(0x9b4)
   120001fbc:	001502e4 	move	$r4,$r23
   120001fc0:	57f1b3ff 	bl	-3664(0xffff1b0) # 120001170 <strncmp@plt>
   120001fc4:	47fab09f 	bnez	$r4,-1360(0x7ffab0) # 120001a74 <main+0x8d4>
   120001fc8:	28c00305 	ld.d	$r5,$r24,0
   120001fcc:	2b000340 	fld.s	$f0,$r26,0
   120001fd0:	00150324 	move	$r4,$r25
   120001fd4:	1c000146 	pcaddu12i	$r6,10(0xa)
   120001fd8:	28c690c6 	ld.d	$r6,$r6,420(0x1a4)
   120001fdc:	54116400 	bl	4452(0x1164) # 120003140 <measureFunction>
   120001fe0:	01192400 	fcvt.d.s	$f0,$f0
   120001fe4:	0114b805 	movfr2gr.d	$r5,$f0
   120001fe8:	1c000044 	pcaddu12i	$r4,2(0x2)
   120001fec:	02d76084 	addi.d	$r4,$r4,1496(0x5d8)
   120001ff0:	57f193ff 	bl	-3696(0xffff190) # 120001180 <printf@plt>
   120001ff4:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120001ff8:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120001ffc:	1c000065 	pcaddu12i	$r5,3(0x3)
   120002000:	02e5d0a5 	addi.d	$r5,$r5,-1676(0x974)
   120002004:	001502e4 	move	$r4,$r23
   120002008:	57f16bff 	bl	-3736(0xffff168) # 120001170 <strncmp@plt>
   12000200c:	47fa809f 	bnez	$r4,-1408(0x7ffa80) # 120001a8c <main+0x8ec>
   120002010:	2b000340 	fld.s	$f0,$r26,0
   120002014:	00150324 	move	$r4,$r25
   120002018:	00150005 	move	$r5,$r0
   12000201c:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002020:	28c450c6 	ld.d	$r6,$r6,276(0x114)
   120002024:	54111c00 	bl	4380(0x111c) # 120003140 <measureFunction>
   120002028:	01145400 	frecip.s	$f0,$f0
   12000202c:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002030:	02d6b084 	addi.d	$r4,$r4,1452(0x5ac)
   120002034:	01192400 	fcvt.d.s	$f0,$f0
   120002038:	0114b805 	movfr2gr.d	$r5,$f0
   12000203c:	57f147ff 	bl	-3772(0xffff144) # 120001180 <printf@plt>
   120002040:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002044:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120002048:	1c000065 	pcaddu12i	$r5,3(0x3)
   12000204c:	02e8e0a5 	addi.d	$r5,$r5,-1480(0xa38)
   120002050:	001502e4 	move	$r4,$r23
   120002054:	57f11fff 	bl	-3812(0xffff11c) # 120001170 <strncmp@plt>
   120002058:	47fa4c9f 	bnez	$r4,-1460(0x7ffa4c) # 120001aa4 <main+0x904>
   12000205c:	2b000340 	fld.s	$f0,$r26,0
   120002060:	00150324 	move	$r4,$r25
   120002064:	00150005 	move	$r5,$r0
   120002068:	1c000146 	pcaddu12i	$r6,10(0xa)
   12000206c:	28c3e0c6 	ld.d	$r6,$r6,248(0xf8)
   120002070:	5410d000 	bl	4304(0x10d0) # 120003140 <measureFunction>
   120002074:	01192400 	fcvt.d.s	$f0,$f0
   120002078:	0114b805 	movfr2gr.d	$r5,$f0
   12000207c:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002080:	02d61084 	addi.d	$r4,$r4,1412(0x584)
   120002084:	57f0ffff 	bl	-3844(0xffff0fc) # 120001180 <printf@plt>
   120002088:	28c02377 	ld.d	$r23,$r27,8(0x8)
   12000208c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120002090:	1c000065 	pcaddu12i	$r5,3(0x3)
   120002094:	02e3c0a5 	addi.d	$r5,$r5,-1808(0x8f0)
   120002098:	001502e4 	move	$r4,$r23
   12000209c:	57f0d7ff 	bl	-3884(0xffff0d4) # 120001170 <strncmp@plt>
   1200020a0:	47fa1c9f 	bnez	$r4,-1508(0x7ffa1c) # 120001abc <main+0x91c>
   1200020a4:	2b000340 	fld.s	$f0,$r26,0
   1200020a8:	00150324 	move	$r4,$r25
   1200020ac:	00150005 	move	$r5,$r0
   1200020b0:	1c000146 	pcaddu12i	$r6,10(0xa)
   1200020b4:	28c1a0c6 	ld.d	$r6,$r6,104(0x68)
   1200020b8:	54108800 	bl	4232(0x1088) # 120003140 <measureFunction>
   1200020bc:	01145400 	frecip.s	$f0,$f0
   1200020c0:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200020c4:	02d56084 	addi.d	$r4,$r4,1368(0x558)
   1200020c8:	01192400 	fcvt.d.s	$f0,$f0
   1200020cc:	0114b805 	movfr2gr.d	$r5,$f0
   1200020d0:	57f0b3ff 	bl	-3920(0xffff0b0) # 120001180 <printf@plt>
   1200020d4:	28c02377 	ld.d	$r23,$r27,8(0x8)
   1200020d8:	02800c06 	addi.w	$r6,$r0,3(0x3)
   1200020dc:	1c000065 	pcaddu12i	$r5,3(0x3)
   1200020e0:	02e2d0a5 	addi.d	$r5,$r5,-1868(0x8b4)
   1200020e4:	001502e4 	move	$r4,$r23
   1200020e8:	57f08bff 	bl	-3960(0xffff088) # 120001170 <strncmp@plt>
   1200020ec:	47f9e89f 	bnez	$r4,-1560(0x7ff9e8) # 120001ad4 <main+0x934>
   1200020f0:	2b000340 	fld.s	$f0,$r26,0
   1200020f4:	00150324 	move	$r4,$r25
   1200020f8:	00150005 	move	$r5,$r0
   1200020fc:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002100:	28c1d0c6 	ld.d	$r6,$r6,116(0x74)
   120002104:	54103c00 	bl	4156(0x103c) # 120003140 <measureFunction>
   120002108:	01192400 	fcvt.d.s	$f0,$f0
   12000210c:	0114b805 	movfr2gr.d	$r5,$f0
   120002110:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002114:	02d4a084 	addi.d	$r4,$r4,1320(0x528)
   120002118:	57f06bff 	bl	-3992(0xffff068) # 120001180 <printf@plt>
   12000211c:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002120:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120002124:	1c000065 	pcaddu12i	$r5,3(0x3)
   120002128:	02e1d0a5 	addi.d	$r5,$r5,-1932(0x874)
   12000212c:	001502e4 	move	$r4,$r23
   120002130:	57f043ff 	bl	-4032(0xffff040) # 120001170 <strncmp@plt>
   120002134:	47f9b89f 	bnez	$r4,-1608(0x7ff9b8) # 120001aec <main+0x94c>
   120002138:	2b000340 	fld.s	$f0,$r26,0
   12000213c:	00150324 	move	$r4,$r25
   120002140:	00150005 	move	$r5,$r0
   120002144:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002148:	28ff70c6 	ld.d	$r6,$r6,-36(0xfdc)
   12000214c:	540ff400 	bl	4084(0xff4) # 120003140 <measureFunction>
   120002150:	01145400 	frecip.s	$f0,$f0
   120002154:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002158:	02d41084 	addi.d	$r4,$r4,1284(0x504)
   12000215c:	01192400 	fcvt.d.s	$f0,$f0
   120002160:	0114b805 	movfr2gr.d	$r5,$f0
   120002164:	57f01fff 	bl	-4068(0xffff01c) # 120001180 <printf@plt>
   120002168:	28c02377 	ld.d	$r23,$r27,8(0x8)
   12000216c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120002170:	1c000065 	pcaddu12i	$r5,3(0x3)
   120002174:	02e0e0a5 	addi.d	$r5,$r5,-1992(0x838)
   120002178:	001502e4 	move	$r4,$r23
   12000217c:	57eff7ff 	bl	-4108(0xfffeff4) # 120001170 <strncmp@plt>
   120002180:	44003480 	bnez	$r4,52(0x34) # 1200021b4 <main+0x1014>
   120002184:	2b000340 	fld.s	$f0,$r26,0
   120002188:	00150005 	move	$r5,$r0
   12000218c:	00150324 	move	$r4,$r25
   120002190:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002194:	28fec0c6 	ld.d	$r6,$r6,-80(0xfb0)
   120002198:	540fa800 	bl	4008(0xfa8) # 120003140 <measureFunction>
   12000219c:	01192400 	fcvt.d.s	$f0,$f0
   1200021a0:	0114b805 	movfr2gr.d	$r5,$f0
   1200021a4:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200021a8:	02d37084 	addi.d	$r4,$r4,1244(0x4dc)
   1200021ac:	57efd7ff 	bl	-4140(0xfffefd4) # 120001180 <printf@plt>
   1200021b0:	28c02377 	ld.d	$r23,$r27,8(0x8)
   1200021b4:	02800c06 	addi.w	$r6,$r0,3(0x3)
   1200021b8:	1c000045 	pcaddu12i	$r5,2(0x2)
   1200021bc:	02df80a5 	addi.d	$r5,$r5,2016(0x7e0)
   1200021c0:	001502e4 	move	$r4,$r23
   1200021c4:	57efafff 	bl	-4180(0xfffefac) # 120001170 <strncmp@plt>
   1200021c8:	47f93c9f 	bnez	$r4,-1732(0x7ff93c) # 120001b04 <main+0x964>
   1200021cc:	2b000358 	fld.s	$f24,$r26,0
   1200021d0:	1c000146 	pcaddu12i	$r6,10(0xa)
   1200021d4:	28fd00c6 	ld.d	$r6,$r6,-192(0xf40)
   1200021d8:	00150005 	move	$r5,$r0
   1200021dc:	01149700 	fmov.s	$f0,$f24
   1200021e0:	00150324 	move	$r4,$r25
   1200021e4:	540f5c00 	bl	3932(0xf5c) # 120003140 <measureFunction>
   1200021e8:	01145400 	frecip.s	$f0,$f0
   1200021ec:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200021f0:	02d2d084 	addi.d	$r4,$r4,1204(0x4b4)
   1200021f4:	01192400 	fcvt.d.s	$f0,$f0
   1200021f8:	0114b805 	movfr2gr.d	$r5,$f0
   1200021fc:	57ef87ff 	bl	-4220(0xfffef84) # 120001180 <printf@plt>
   120002200:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002204:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120002208:	1c000045 	pcaddu12i	$r5,2(0x2)
   12000220c:	02dea0a5 	addi.d	$r5,$r5,1960(0x7a8)
   120002210:	001502e4 	move	$r4,$r23
   120002214:	57ef5fff 	bl	-4260(0xfffef5c) # 120001170 <strncmp@plt>
   120002218:	47f9049f 	bnez	$r4,-1788(0x7ff904) # 120001b1c <main+0x97c>
   12000221c:	01149700 	fmov.s	$f0,$f24
   120002220:	00150324 	move	$r4,$r25
   120002224:	00150005 	move	$r5,$r0
   120002228:	1c000146 	pcaddu12i	$r6,10(0xa)
   12000222c:	28ff00c6 	ld.d	$r6,$r6,-64(0xfc0)
   120002230:	540f1000 	bl	3856(0xf10) # 120003140 <measureFunction>
   120002234:	01192400 	fcvt.d.s	$f0,$f0
   120002238:	0114b805 	movfr2gr.d	$r5,$f0
   12000223c:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002240:	02d23084 	addi.d	$r4,$r4,1164(0x48c)
   120002244:	57ef3fff 	bl	-4292(0xfffef3c) # 120001180 <printf@plt>
   120002248:	28c02377 	ld.d	$r23,$r27,8(0x8)
   12000224c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120002250:	1c000045 	pcaddu12i	$r5,2(0x2)
   120002254:	02dda0a5 	addi.d	$r5,$r5,1896(0x768)
   120002258:	001502e4 	move	$r4,$r23
   12000225c:	57ef17ff 	bl	-4332(0xfffef14) # 120001170 <strncmp@plt>
   120002260:	47f8d49f 	bnez	$r4,-1836(0x7ff8d4) # 120001b34 <main+0x994>
   120002264:	2b000340 	fld.s	$f0,$r26,0
   120002268:	00150324 	move	$r4,$r25
   12000226c:	00150005 	move	$r5,$r0
   120002270:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002274:	28fa40c6 	ld.d	$r6,$r6,-368(0xe90)
   120002278:	540ec800 	bl	3784(0xec8) # 120003140 <measureFunction>
   12000227c:	01145400 	frecip.s	$f0,$f0
   120002280:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002284:	02d18084 	addi.d	$r4,$r4,1120(0x460)
   120002288:	01192400 	fcvt.d.s	$f0,$f0
   12000228c:	0114b805 	movfr2gr.d	$r5,$f0
   120002290:	57eef3ff 	bl	-4368(0xfffeef0) # 120001180 <printf@plt>
   120002294:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002298:	02800c06 	addi.w	$r6,$r0,3(0x3)
   12000229c:	1c000045 	pcaddu12i	$r5,2(0x2)
   1200022a0:	02dcb0a5 	addi.d	$r5,$r5,1836(0x72c)
   1200022a4:	001502e4 	move	$r4,$r23
   1200022a8:	57eecbff 	bl	-4408(0xfffeec8) # 120001170 <strncmp@plt>
   1200022ac:	47f8a09f 	bnez	$r4,-1888(0x7ff8a0) # 120001b4c <main+0x9ac>
   1200022b0:	2b000340 	fld.s	$f0,$r26,0
   1200022b4:	00150324 	move	$r4,$r25
   1200022b8:	00150005 	move	$r5,$r0
   1200022bc:	1c000146 	pcaddu12i	$r6,10(0xa)
   1200022c0:	28f9b0c6 	ld.d	$r6,$r6,-404(0xe6c)
   1200022c4:	540e7c00 	bl	3708(0xe7c) # 120003140 <measureFunction>
   1200022c8:	01192400 	fcvt.d.s	$f0,$f0
   1200022cc:	0114b805 	movfr2gr.d	$r5,$f0
   1200022d0:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200022d4:	02d0e084 	addi.d	$r4,$r4,1080(0x438)
   1200022d8:	57eeabff 	bl	-4440(0xfffeea8) # 120001180 <printf@plt>
   1200022dc:	28c02377 	ld.d	$r23,$r27,8(0x8)
   1200022e0:	02800c06 	addi.w	$r6,$r0,3(0x3)
   1200022e4:	1c000045 	pcaddu12i	$r5,2(0x2)
   1200022e8:	02dbb0a5 	addi.d	$r5,$r5,1772(0x6ec)
   1200022ec:	001502e4 	move	$r4,$r23
   1200022f0:	57ee83ff 	bl	-4480(0xfffee80) # 120001170 <strncmp@plt>
   1200022f4:	47f8709f 	bnez	$r4,-1936(0x7ff870) # 120001b64 <main+0x9c4>
   1200022f8:	2b000340 	fld.s	$f0,$r26,0
   1200022fc:	00150324 	move	$r4,$r25
   120002300:	00150005 	move	$r5,$r0
   120002304:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002308:	28fad0c6 	ld.d	$r6,$r6,-332(0xeb4)
   12000230c:	540e3400 	bl	3636(0xe34) # 120003140 <measureFunction>
   120002310:	01145400 	frecip.s	$f0,$f0
   120002314:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002318:	02d03084 	addi.d	$r4,$r4,1036(0x40c)
   12000231c:	01192400 	fcvt.d.s	$f0,$f0
   120002320:	0114b805 	movfr2gr.d	$r5,$f0
   120002324:	57ee5fff 	bl	-4516(0xfffee5c) # 120001180 <printf@plt>
   120002328:	28c02377 	ld.d	$r23,$r27,8(0x8)
   12000232c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120002330:	1c000045 	pcaddu12i	$r5,2(0x2)
   120002334:	02dac0a5 	addi.d	$r5,$r5,1712(0x6b0)
   120002338:	001502e4 	move	$r4,$r23
   12000233c:	57ee37ff 	bl	-4556(0xfffee34) # 120001170 <strncmp@plt>
   120002340:	47f83c9f 	bnez	$r4,-1988(0x7ff83c) # 120001b7c <main+0x9dc>
   120002344:	2b000340 	fld.s	$f0,$r26,0
   120002348:	00150324 	move	$r4,$r25
   12000234c:	00150005 	move	$r5,$r0
   120002350:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002354:	28fa40c6 	ld.d	$r6,$r6,-368(0xe90)
   120002358:	540de800 	bl	3560(0xde8) # 120003140 <measureFunction>
   12000235c:	01192400 	fcvt.d.s	$f0,$f0
   120002360:	0114b805 	movfr2gr.d	$r5,$f0
   120002364:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002368:	02cf7084 	addi.d	$r4,$r4,988(0x3dc)
   12000236c:	57ee17ff 	bl	-4588(0xfffee14) # 120001180 <printf@plt>
   120002370:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002374:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120002378:	1c000045 	pcaddu12i	$r5,2(0x2)
   12000237c:	02d9c0a5 	addi.d	$r5,$r5,1648(0x670)
   120002380:	001502e4 	move	$r4,$r23
   120002384:	57edefff 	bl	-4628(0xfffedec) # 120001170 <strncmp@plt>
   120002388:	47f80c9f 	bnez	$r4,-2036(0x7ff80c) # 120001b94 <main+0x9f4>
   12000238c:	2b000340 	fld.s	$f0,$r26,0
   120002390:	00150324 	move	$r4,$r25
   120002394:	00150005 	move	$r5,$r0
   120002398:	1c000146 	pcaddu12i	$r6,10(0xa)
   12000239c:	28f7e0c6 	ld.d	$r6,$r6,-520(0xdf8)
   1200023a0:	540da000 	bl	3488(0xda0) # 120003140 <measureFunction>
   1200023a4:	01145400 	frecip.s	$f0,$f0
   1200023a8:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200023ac:	02cec084 	addi.d	$r4,$r4,944(0x3b0)
   1200023b0:	01192400 	fcvt.d.s	$f0,$f0
   1200023b4:	0114b805 	movfr2gr.d	$r5,$f0
   1200023b8:	57edcbff 	bl	-4664(0xfffedc8) # 120001180 <printf@plt>
   1200023bc:	28c02377 	ld.d	$r23,$r27,8(0x8)
   1200023c0:	02800c06 	addi.w	$r6,$r0,3(0x3)
   1200023c4:	1c000045 	pcaddu12i	$r5,2(0x2)
   1200023c8:	02d8d0a5 	addi.d	$r5,$r5,1588(0x634)
   1200023cc:	001502e4 	move	$r4,$r23
   1200023d0:	57eda3ff 	bl	-4704(0xfffeda0) # 120001170 <strncmp@plt>
   1200023d4:	47f7d89f 	bnez	$r4,-2088(0x7ff7d8) # 120001bac <main+0xa0c>
   1200023d8:	2b000340 	fld.s	$f0,$r26,0
   1200023dc:	00150324 	move	$r4,$r25
   1200023e0:	00150005 	move	$r5,$r0
   1200023e4:	1c000146 	pcaddu12i	$r6,10(0xa)
   1200023e8:	28f930c6 	ld.d	$r6,$r6,-436(0xe4c)
   1200023ec:	540d5400 	bl	3412(0xd54) # 120003140 <measureFunction>
   1200023f0:	01192400 	fcvt.d.s	$f0,$f0
   1200023f4:	0114b805 	movfr2gr.d	$r5,$f0
   1200023f8:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200023fc:	02ce0084 	addi.d	$r4,$r4,896(0x380)
   120002400:	57ed83ff 	bl	-4736(0xfffed80) # 120001180 <printf@plt>
   120002404:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002408:	02800c06 	addi.w	$r6,$r0,3(0x3)
   12000240c:	1c000045 	pcaddu12i	$r5,2(0x2)
   120002410:	02d7d0a5 	addi.d	$r5,$r5,1524(0x5f4)
   120002414:	001502e4 	move	$r4,$r23
   120002418:	57ed5bff 	bl	-4776(0xfffed58) # 120001170 <strncmp@plt>
   12000241c:	47f7a89f 	bnez	$r4,-2136(0x7ff7a8) # 120001bc4 <main+0xa24>
   120002420:	2b000340 	fld.s	$f0,$r26,0
   120002424:	00150324 	move	$r4,$r25
   120002428:	00150005 	move	$r5,$r0
   12000242c:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002430:	28f650c6 	ld.d	$r6,$r6,-620(0xd94)
   120002434:	540d0c00 	bl	3340(0xd0c) # 120003140 <measureFunction>
   120002438:	01145400 	frecip.s	$f0,$f0
   12000243c:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002440:	02cd7084 	addi.d	$r4,$r4,860(0x35c)
   120002444:	01192400 	fcvt.d.s	$f0,$f0
   120002448:	0114b805 	movfr2gr.d	$r5,$f0
   12000244c:	57ed37ff 	bl	-4812(0xfffed34) # 120001180 <printf@plt>
   120002450:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002454:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120002458:	1c000045 	pcaddu12i	$r5,2(0x2)
   12000245c:	02d6e0a5 	addi.d	$r5,$r5,1464(0x5b8)
   120002460:	001502e4 	move	$r4,$r23
   120002464:	57ed0fff 	bl	-4852(0xfffed0c) # 120001170 <strncmp@plt>
   120002468:	47f7749f 	bnez	$r4,-2188(0x7ff774) # 120001bdc <main+0xa3c>
   12000246c:	2b000340 	fld.s	$f0,$r26,0
   120002470:	00150324 	move	$r4,$r25
   120002474:	00150005 	move	$r5,$r0
   120002478:	1c000146 	pcaddu12i	$r6,10(0xa)
   12000247c:	28f660c6 	ld.d	$r6,$r6,-616(0xd98)
   120002480:	540cc000 	bl	3264(0xcc0) # 120003140 <measureFunction>
   120002484:	01192400 	fcvt.d.s	$f0,$f0
   120002488:	0114b805 	movfr2gr.d	$r5,$f0
   12000248c:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002490:	02ccd084 	addi.d	$r4,$r4,820(0x334)
   120002494:	57ecefff 	bl	-4884(0xfffecec) # 120001180 <printf@plt>
   120002498:	28c02377 	ld.d	$r23,$r27,8(0x8)
   12000249c:	02800c06 	addi.w	$r6,$r0,3(0x3)
   1200024a0:	1c000045 	pcaddu12i	$r5,2(0x2)
   1200024a4:	02d5e0a5 	addi.d	$r5,$r5,1400(0x578)
   1200024a8:	001502e4 	move	$r4,$r23
   1200024ac:	57ecc7ff 	bl	-4924(0xfffecc4) # 120001170 <strncmp@plt>
   1200024b0:	47f7449f 	bnez	$r4,-2236(0x7ff744) # 120001bf4 <main+0xa54>
   1200024b4:	2b000340 	fld.s	$f0,$r26,0
   1200024b8:	00150324 	move	$r4,$r25
   1200024bc:	00150005 	move	$r5,$r0
   1200024c0:	1c000146 	pcaddu12i	$r6,10(0xa)
   1200024c4:	28f3a0c6 	ld.d	$r6,$r6,-792(0xce8)
   1200024c8:	540c7800 	bl	3192(0xc78) # 120003140 <measureFunction>
   1200024cc:	01145400 	frecip.s	$f0,$f0
   1200024d0:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200024d4:	02cc4084 	addi.d	$r4,$r4,784(0x310)
   1200024d8:	01192400 	fcvt.d.s	$f0,$f0
   1200024dc:	0114b805 	movfr2gr.d	$r5,$f0
   1200024e0:	57eca3ff 	bl	-4960(0xfffeca0) # 120001180 <printf@plt>
   1200024e4:	28c02377 	ld.d	$r23,$r27,8(0x8)
   1200024e8:	02800c06 	addi.w	$r6,$r0,3(0x3)
   1200024ec:	1c000045 	pcaddu12i	$r5,2(0x2)
   1200024f0:	02d4f0a5 	addi.d	$r5,$r5,1340(0x53c)
   1200024f4:	001502e4 	move	$r4,$r23
   1200024f8:	57ec7bff 	bl	-5000(0xfffec78) # 120001170 <strncmp@plt>
   1200024fc:	47f7109f 	bnez	$r4,-2288(0x7ff710) # 120001c0c <main+0xa6c>
   120002500:	2b000340 	fld.s	$f0,$r26,0
   120002504:	00150324 	move	$r4,$r25
   120002508:	00150005 	move	$r5,$r0
   12000250c:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002510:	28ef90c6 	ld.d	$r6,$r6,-1052(0xbe4)
   120002514:	540c2c00 	bl	3116(0xc2c) # 120003140 <measureFunction>
   120002518:	01192400 	fcvt.d.s	$f0,$f0
   12000251c:	0114b805 	movfr2gr.d	$r5,$f0
   120002520:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002524:	02cba084 	addi.d	$r4,$r4,744(0x2e8)
   120002528:	57ec5bff 	bl	-5032(0xfffec58) # 120001180 <printf@plt>
   12000252c:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002530:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120002534:	1c000045 	pcaddu12i	$r5,2(0x2)
   120002538:	02d410a5 	addi.d	$r5,$r5,1284(0x504)
   12000253c:	001502e4 	move	$r4,$r23
   120002540:	57ec33ff 	bl	-5072(0xfffec30) # 120001170 <strncmp@plt>
   120002544:	47f6e09f 	bnez	$r4,-2336(0x7ff6e0) # 120001c24 <main+0xa84>
   120002548:	2b000340 	fld.s	$f0,$r26,0
   12000254c:	00150324 	move	$r4,$r25
   120002550:	00150005 	move	$r5,$r0
   120002554:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002558:	28f350c6 	ld.d	$r6,$r6,-812(0xcd4)
   12000255c:	540be400 	bl	3044(0xbe4) # 120003140 <measureFunction>
   120002560:	01192400 	fcvt.d.s	$f0,$f0
   120002564:	0114b805 	movfr2gr.d	$r5,$f0
   120002568:	1c000044 	pcaddu12i	$r4,2(0x2)
   12000256c:	02cb0084 	addi.d	$r4,$r4,704(0x2c0)
   120002570:	57ec13ff 	bl	-5104(0xfffec10) # 120001180 <printf@plt>
   120002574:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002578:	02800c06 	addi.w	$r6,$r0,3(0x3)
   12000257c:	1c000045 	pcaddu12i	$r5,2(0x2)
   120002580:	02d330a5 	addi.d	$r5,$r5,1228(0x4cc)
   120002584:	001502e4 	move	$r4,$r23
   120002588:	57ebebff 	bl	-5144(0xfffebe8) # 120001170 <strncmp@plt>
   12000258c:	47f6b09f 	bnez	$r4,-2384(0x7ff6b0) # 120001c3c <main+0xa9c>
   120002590:	2b000340 	fld.s	$f0,$r26,0
   120002594:	00150324 	move	$r4,$r25
   120002598:	00150005 	move	$r5,$r0
   12000259c:	1c000146 	pcaddu12i	$r6,10(0xa)
   1200025a0:	28eef0c6 	ld.d	$r6,$r6,-1092(0xbbc)
   1200025a4:	540b9c00 	bl	2972(0xb9c) # 120003140 <measureFunction>
   1200025a8:	01192400 	fcvt.d.s	$f0,$f0
   1200025ac:	0114b805 	movfr2gr.d	$r5,$f0
   1200025b0:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200025b4:	02ca6084 	addi.d	$r4,$r4,664(0x298)
   1200025b8:	57ebcbff 	bl	-5176(0xfffebc8) # 120001180 <printf@plt>
   1200025bc:	28c02377 	ld.d	$r23,$r27,8(0x8)
   1200025c0:	02800c06 	addi.w	$r6,$r0,3(0x3)
   1200025c4:	1c000045 	pcaddu12i	$r5,2(0x2)
   1200025c8:	02d250a5 	addi.d	$r5,$r5,1172(0x494)
   1200025cc:	001502e4 	move	$r4,$r23
   1200025d0:	57eba3ff 	bl	-5216(0xfffeba0) # 120001170 <strncmp@plt>
   1200025d4:	47f6809f 	bnez	$r4,-2432(0x7ff680) # 120001c54 <main+0xab4>
   1200025d8:	2b000340 	fld.s	$f0,$r26,0
   1200025dc:	00150324 	move	$r4,$r25
   1200025e0:	00150005 	move	$r5,$r0
   1200025e4:	1c000146 	pcaddu12i	$r6,10(0xa)
   1200025e8:	28ec10c6 	ld.d	$r6,$r6,-1276(0xb04)
   1200025ec:	540b5400 	bl	2900(0xb54) # 120003140 <measureFunction>
   1200025f0:	01192400 	fcvt.d.s	$f0,$f0
   1200025f4:	0114b805 	movfr2gr.d	$r5,$f0
   1200025f8:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200025fc:	02c9c084 	addi.d	$r4,$r4,624(0x270)
   120002600:	57eb83ff 	bl	-5248(0xfffeb80) # 120001180 <printf@plt>
   120002604:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002608:	02800c06 	addi.w	$r6,$r0,3(0x3)
   12000260c:	1c000045 	pcaddu12i	$r5,2(0x2)
   120002610:	02d170a5 	addi.d	$r5,$r5,1116(0x45c)
   120002614:	001502e4 	move	$r4,$r23
   120002618:	57eb5bff 	bl	-5288(0xfffeb58) # 120001170 <strncmp@plt>
   12000261c:	47f6509f 	bnez	$r4,-2480(0x7ff650) # 120001c6c <main+0xacc>
   120002620:	2b000340 	fld.s	$f0,$r26,0
   120002624:	00150324 	move	$r4,$r25
   120002628:	00150005 	move	$r5,$r0
   12000262c:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002630:	28ef50c6 	ld.d	$r6,$r6,-1068(0xbd4)
   120002634:	540b0c00 	bl	2828(0xb0c) # 120003140 <measureFunction>
   120002638:	01192400 	fcvt.d.s	$f0,$f0
   12000263c:	0114b805 	movfr2gr.d	$r5,$f0
   120002640:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002644:	02c92084 	addi.d	$r4,$r4,584(0x248)
   120002648:	57eb3bff 	bl	-5320(0xfffeb38) # 120001180 <printf@plt>
   12000264c:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002650:	02800c06 	addi.w	$r6,$r0,3(0x3)
   120002654:	1c000045 	pcaddu12i	$r5,2(0x2)
   120002658:	02d090a5 	addi.d	$r5,$r5,1060(0x424)
   12000265c:	001502e4 	move	$r4,$r23
   120002660:	57eb13ff 	bl	-5360(0xfffeb10) # 120001170 <strncmp@plt>
   120002664:	47f6209f 	bnez	$r4,-2528(0x7ff620) # 120001c84 <main+0xae4>
   120002668:	2b000340 	fld.s	$f0,$r26,0
   12000266c:	00150324 	move	$r4,$r25
   120002670:	00150005 	move	$r5,$r0
   120002674:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002678:	28eeb0c6 	ld.d	$r6,$r6,-1108(0xbac)
   12000267c:	540ac400 	bl	2756(0xac4) # 120003140 <measureFunction>
   120002680:	01192400 	fcvt.d.s	$f0,$f0
   120002684:	0114b805 	movfr2gr.d	$r5,$f0
   120002688:	1c000044 	pcaddu12i	$r4,2(0x2)
   12000268c:	02c88084 	addi.d	$r4,$r4,544(0x220)
   120002690:	57eaf3ff 	bl	-5392(0xfffeaf0) # 120001180 <printf@plt>
   120002694:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002698:	02800c06 	addi.w	$r6,$r0,3(0x3)
   12000269c:	1c000045 	pcaddu12i	$r5,2(0x2)
   1200026a0:	02cfb0a5 	addi.d	$r5,$r5,1004(0x3ec)
   1200026a4:	001502e4 	move	$r4,$r23
   1200026a8:	57eacbff 	bl	-5432(0xfffeac8) # 120001170 <strncmp@plt>
   1200026ac:	47f5f09f 	bnez	$r4,-2576(0x7ff5f0) # 120001c9c <main+0xafc>
   1200026b0:	2b000340 	fld.s	$f0,$r26,0
   1200026b4:	00150324 	move	$r4,$r25
   1200026b8:	00150005 	move	$r5,$r0
   1200026bc:	1c000146 	pcaddu12i	$r6,10(0xa)
   1200026c0:	28e9f0c6 	ld.d	$r6,$r6,-1412(0xa7c)
   1200026c4:	540a7c00 	bl	2684(0xa7c) # 120003140 <measureFunction>
   1200026c8:	01192400 	fcvt.d.s	$f0,$f0
   1200026cc:	0114b805 	movfr2gr.d	$r5,$f0
   1200026d0:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200026d4:	02c7e084 	addi.d	$r4,$r4,504(0x1f8)
   1200026d8:	57eaabff 	bl	-5464(0xfffeaa8) # 120001180 <printf@plt>
   1200026dc:	28c02377 	ld.d	$r23,$r27,8(0x8)
   1200026e0:	02801006 	addi.w	$r6,$r0,4(0x4)
   1200026e4:	1c000045 	pcaddu12i	$r5,2(0x2)
   1200026e8:	02cef0a5 	addi.d	$r5,$r5,956(0x3bc)
   1200026ec:	001502e4 	move	$r4,$r23
   1200026f0:	57ea83ff 	bl	-5504(0xfffea80) # 120001170 <strncmp@plt>
   1200026f4:	47f5c09f 	bnez	$r4,-2624(0x7ff5c0) # 120001cb4 <main+0xb14>
   1200026f8:	2b000340 	fld.s	$f0,$r26,0
   1200026fc:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002700:	28ec70c6 	ld.d	$r6,$r6,-1252(0xb1c)
   120002704:	1c000145 	pcaddu12i	$r5,10(0xa)
   120002708:	02e3f0a5 	addi.d	$r5,$r5,-1796(0x8fc)
   12000270c:	00150324 	move	$r4,$r25
   120002710:	540a3000 	bl	2608(0xa30) # 120003140 <measureFunction>
   120002714:	01192400 	fcvt.d.s	$f0,$f0
   120002718:	0114b805 	movfr2gr.d	$r5,$f0
   12000271c:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002720:	02c75084 	addi.d	$r4,$r4,468(0x1d4)
   120002724:	57ea5fff 	bl	-5540(0xfffea5c) # 120001180 <printf@plt>
   120002728:	28c02377 	ld.d	$r23,$r27,8(0x8)
   12000272c:	53f58bff 	b	-2680(0xffff588) # 120001cb4 <main+0xb14>
   120002730:	1c00004c 	pcaddu12i	$r12,2(0x2)
   120002734:	02cf218c 	addi.d	$r12,$r12,968(0x3c8)
   120002738:	2b000180 	fld.s	$f0,$r12,0
   12000273c:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002740:	28eb70c6 	ld.d	$r6,$r6,-1316(0xadc)
   120002744:	1c000145 	pcaddu12i	$r5,10(0xa)
   120002748:	02e2f0a5 	addi.d	$r5,$r5,-1860(0x8bc)
   12000274c:	00150324 	move	$r4,$r25
   120002750:	5409f000 	bl	2544(0x9f0) # 120003140 <measureFunction>
   120002754:	01192400 	fcvt.d.s	$f0,$f0
   120002758:	0114b805 	movfr2gr.d	$r5,$f0
   12000275c:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002760:	02c65084 	addi.d	$r4,$r4,404(0x194)
   120002764:	57ea1fff 	bl	-5604(0xfffea1c) # 120001180 <printf@plt>
   120002768:	0280040c 	addi.w	$r12,$r0,1(0x1)
   12000276c:	67eac19c 	bge	$r12,$r28,-5440(0x3eac0) # 12000122c <main+0x8c>
   120002770:	28c02377 	ld.d	$r23,$r27,8(0x8)
   120002774:	53f543ff 	b	-2752(0xffff540) # 120001cb4 <main+0xb14>
   120002778:	1c00005a 	pcaddu12i	$r26,2(0x2)
   12000277c:	02ce035a 	addi.d	$r26,$r26,896(0x380)
   120002780:	2b000340 	fld.s	$f0,$r26,0
   120002784:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002788:	28e6d0c6 	ld.d	$r6,$r6,-1612(0x9b4)
   12000278c:	00150005 	move	$r5,$r0
   120002790:	00150324 	move	$r4,$r25
   120002794:	5409ac00 	bl	2476(0x9ac) # 120003140 <measureFunction>
   120002798:	01192400 	fcvt.d.s	$f0,$f0
   12000279c:	0114b805 	movfr2gr.d	$r5,$f0
   1200027a0:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200027a4:	02c4a084 	addi.d	$r4,$r4,296(0x128)
   1200027a8:	57e9dbff 	bl	-5672(0xfffe9d8) # 120001180 <printf@plt>
   1200027ac:	0280040c 	addi.w	$r12,$r0,1(0x1)
   1200027b0:	63ff2d9c 	blt	$r12,$r28,-212(0x3ff2c) # 1200026dc <main+0x153c>
   1200027b4:	53ea7bff 	b	-5512(0xfffea78) # 12000122c <main+0x8c>
   1200027b8:	1c00005a 	pcaddu12i	$r26,2(0x2)
   1200027bc:	02cd035a 	addi.d	$r26,$r26,832(0x340)
   1200027c0:	2b000340 	fld.s	$f0,$r26,0
   1200027c4:	1c000146 	pcaddu12i	$r6,10(0xa)
   1200027c8:	28e970c6 	ld.d	$r6,$r6,-1444(0xa5c)
   1200027cc:	00150005 	move	$r5,$r0
   1200027d0:	00150324 	move	$r4,$r25
   1200027d4:	54096c00 	bl	2412(0x96c) # 120003140 <measureFunction>
   1200027d8:	01192400 	fcvt.d.s	$f0,$f0
   1200027dc:	0114b805 	movfr2gr.d	$r5,$f0
   1200027e0:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200027e4:	02c32084 	addi.d	$r4,$r4,200(0xc8)
   1200027e8:	57e99bff 	bl	-5736(0xfffe998) # 120001180 <printf@plt>
   1200027ec:	0280040c 	addi.w	$r12,$r0,1(0x1)
   1200027f0:	63fea59c 	blt	$r12,$r28,-348(0x3fea4) # 120002694 <main+0x14f4>
   1200027f4:	53ea3bff 	b	-5576(0xfffea38) # 12000122c <main+0x8c>
   1200027f8:	1c00005a 	pcaddu12i	$r26,2(0x2)
   1200027fc:	02cc035a 	addi.d	$r26,$r26,768(0x300)
   120002800:	2b000340 	fld.s	$f0,$r26,0
   120002804:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002808:	28e7f0c6 	ld.d	$r6,$r6,-1540(0x9fc)
   12000280c:	00150005 	move	$r5,$r0
   120002810:	00150324 	move	$r4,$r25
   120002814:	54092c00 	bl	2348(0x92c) # 120003140 <measureFunction>
   120002818:	01192400 	fcvt.d.s	$f0,$f0
   12000281c:	0114b805 	movfr2gr.d	$r5,$f0
   120002820:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002824:	02c1a084 	addi.d	$r4,$r4,104(0x68)
   120002828:	57e95bff 	bl	-5800(0xfffe958) # 120001180 <printf@plt>
   12000282c:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002830:	63fe1d9c 	blt	$r12,$r28,-484(0x3fe1c) # 12000264c <main+0x14ac>
   120002834:	53e9fbff 	b	-5640(0xfffe9f8) # 12000122c <main+0x8c>
   120002838:	1c00005a 	pcaddu12i	$r26,2(0x2)
   12000283c:	02cb035a 	addi.d	$r26,$r26,704(0x2c0)
   120002840:	2b000340 	fld.s	$f0,$r26,0
   120002844:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002848:	28e290c6 	ld.d	$r6,$r6,-1884(0x8a4)
   12000284c:	00150005 	move	$r5,$r0
   120002850:	00150324 	move	$r4,$r25
   120002854:	5408ec00 	bl	2284(0x8ec) # 120003140 <measureFunction>
   120002858:	01192400 	fcvt.d.s	$f0,$f0
   12000285c:	0114b805 	movfr2gr.d	$r5,$f0
   120002860:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002864:	02c02084 	addi.d	$r4,$r4,8(0x8)
   120002868:	57e91bff 	bl	-5864(0xfffe918) # 120001180 <printf@plt>
   12000286c:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002870:	63fd959c 	blt	$r12,$r28,-620(0x3fd94) # 120002604 <main+0x1464>
   120002874:	53e9bbff 	b	-5704(0xfffe9b8) # 12000122c <main+0x8c>
   120002878:	1c00005a 	pcaddu12i	$r26,2(0x2)
   12000287c:	02ca035a 	addi.d	$r26,$r26,640(0x280)
   120002880:	2b000340 	fld.s	$f0,$r26,0
   120002884:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002888:	28e350c6 	ld.d	$r6,$r6,-1836(0x8d4)
   12000288c:	00150005 	move	$r5,$r0
   120002890:	00150324 	move	$r4,$r25
   120002894:	5408ac00 	bl	2220(0x8ac) # 120003140 <measureFunction>
   120002898:	01192400 	fcvt.d.s	$f0,$f0
   12000289c:	0114b805 	movfr2gr.d	$r5,$f0
   1200028a0:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200028a4:	02fea084 	addi.d	$r4,$r4,-88(0xfa8)
   1200028a8:	57e8dbff 	bl	-5928(0xfffe8d8) # 120001180 <printf@plt>
   1200028ac:	0280040c 	addi.w	$r12,$r0,1(0x1)
   1200028b0:	63fd0d9c 	blt	$r12,$r28,-756(0x3fd0c) # 1200025bc <main+0x141c>
   1200028b4:	53e97bff 	b	-5768(0xfffe978) # 12000122c <main+0x8c>
   1200028b8:	1c00005a 	pcaddu12i	$r26,2(0x2)
   1200028bc:	02c9035a 	addi.d	$r26,$r26,576(0x240)
   1200028c0:	2b000340 	fld.s	$f0,$r26,0
   1200028c4:	1c000146 	pcaddu12i	$r6,10(0xa)
   1200028c8:	28e590c6 	ld.d	$r6,$r6,-1692(0x964)
   1200028cc:	00150005 	move	$r5,$r0
   1200028d0:	00150324 	move	$r4,$r25
   1200028d4:	54086c00 	bl	2156(0x86c) # 120003140 <measureFunction>
   1200028d8:	01192400 	fcvt.d.s	$f0,$f0
   1200028dc:	0114b805 	movfr2gr.d	$r5,$f0
   1200028e0:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200028e4:	02fd2084 	addi.d	$r4,$r4,-184(0xf48)
   1200028e8:	57e89bff 	bl	-5992(0xfffe898) # 120001180 <printf@plt>
   1200028ec:	0280040c 	addi.w	$r12,$r0,1(0x1)
   1200028f0:	63fc859c 	blt	$r12,$r28,-892(0x3fc84) # 120002574 <main+0x13d4>
   1200028f4:	53e93bff 	b	-5832(0xfffe938) # 12000122c <main+0x8c>
   1200028f8:	1c00005a 	pcaddu12i	$r26,2(0x2)
   1200028fc:	02c8035a 	addi.d	$r26,$r26,512(0x200)
   120002900:	2b000340 	fld.s	$f0,$r26,0
   120002904:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002908:	28dfb0c6 	ld.d	$r6,$r6,2028(0x7ec)
   12000290c:	00150005 	move	$r5,$r0
   120002910:	00150324 	move	$r4,$r25
   120002914:	54082c00 	bl	2092(0x82c) # 120003140 <measureFunction>
   120002918:	01192400 	fcvt.d.s	$f0,$f0
   12000291c:	0114b805 	movfr2gr.d	$r5,$f0
   120002920:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002924:	02fba084 	addi.d	$r4,$r4,-280(0xee8)
   120002928:	57e85bff 	bl	-6056(0xfffe858) # 120001180 <printf@plt>
   12000292c:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002930:	63fbfd9c 	blt	$r12,$r28,-1028(0x3fbfc) # 12000252c <main+0x138c>
   120002934:	53e8fbff 	b	-5896(0xfffe8f8) # 12000122c <main+0x8c>
   120002938:	1c00005a 	pcaddu12i	$r26,2(0x2)
   12000293c:	02c7035a 	addi.d	$r26,$r26,448(0x1c0)
   120002940:	2b000340 	fld.s	$f0,$r26,0
   120002944:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002948:	28e190c6 	ld.d	$r6,$r6,-1948(0x864)
   12000294c:	00150005 	move	$r5,$r0
   120002950:	00150324 	move	$r4,$r25
   120002954:	5407ec00 	bl	2028(0x7ec) # 120003140 <measureFunction>
   120002958:	01145400 	frecip.s	$f0,$f0
   12000295c:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002960:	02fa1084 	addi.d	$r4,$r4,-380(0xe84)
   120002964:	01192400 	fcvt.d.s	$f0,$f0
   120002968:	0114b805 	movfr2gr.d	$r5,$f0
   12000296c:	57e817ff 	bl	-6124(0xfffe814) # 120001180 <printf@plt>
   120002970:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002974:	63fb719c 	blt	$r12,$r28,-1168(0x3fb70) # 1200024e4 <main+0x1344>
   120002978:	53e8b7ff 	b	-5964(0xfffe8b4) # 12000122c <main+0x8c>
   12000297c:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002980:	02c5f35a 	addi.d	$r26,$r26,380(0x17c)
   120002984:	2b000340 	fld.s	$f0,$r26,0
   120002988:	1c000146 	pcaddu12i	$r6,10(0xa)
   12000298c:	28e220c6 	ld.d	$r6,$r6,-1912(0x888)
   120002990:	00150005 	move	$r5,$r0
   120002994:	00150324 	move	$r4,$r25
   120002998:	5407a800 	bl	1960(0x7a8) # 120003140 <measureFunction>
   12000299c:	01192400 	fcvt.d.s	$f0,$f0
   1200029a0:	0114b805 	movfr2gr.d	$r5,$f0
   1200029a4:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200029a8:	02f87084 	addi.d	$r4,$r4,-484(0xe1c)
   1200029ac:	57e7d7ff 	bl	-6188(0xfffe7d4) # 120001180 <printf@plt>
   1200029b0:	0280040c 	addi.w	$r12,$r0,1(0x1)
   1200029b4:	63fae59c 	blt	$r12,$r28,-1308(0x3fae4) # 120002498 <main+0x12f8>
   1200029b8:	53e877ff 	b	-6028(0xfffe874) # 12000122c <main+0x8c>
   1200029bc:	1c00005a 	pcaddu12i	$r26,2(0x2)
   1200029c0:	02c4f35a 	addi.d	$r26,$r26,316(0x13c)
   1200029c4:	2b000340 	fld.s	$f0,$r26,0
   1200029c8:	1c000126 	pcaddu12i	$r6,9(0x9)
   1200029cc:	28dfe0c6 	ld.d	$r6,$r6,2040(0x7f8)
   1200029d0:	00150005 	move	$r5,$r0
   1200029d4:	00150324 	move	$r4,$r25
   1200029d8:	54076800 	bl	1896(0x768) # 120003140 <measureFunction>
   1200029dc:	01145400 	frecip.s	$f0,$f0
   1200029e0:	1c000044 	pcaddu12i	$r4,2(0x2)
   1200029e4:	02f6e084 	addi.d	$r4,$r4,-584(0xdb8)
   1200029e8:	01192400 	fcvt.d.s	$f0,$f0
   1200029ec:	0114b805 	movfr2gr.d	$r5,$f0
   1200029f0:	57e793ff 	bl	-6256(0xfffe790) # 120001180 <printf@plt>
   1200029f4:	0280040c 	addi.w	$r12,$r0,1(0x1)
   1200029f8:	63fa599c 	blt	$r12,$r28,-1448(0x3fa58) # 120002450 <main+0x12b0>
   1200029fc:	53e833ff 	b	-6096(0xfffe830) # 12000122c <main+0x8c>
   120002a00:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002a04:	02c3e35a 	addi.d	$r26,$r26,248(0xf8)
   120002a08:	2b000340 	fld.s	$f0,$r26,0
   120002a0c:	1c000146 	pcaddu12i	$r6,10(0xa)
   120002a10:	28e090c6 	ld.d	$r6,$r6,-2012(0x824)
   120002a14:	00150005 	move	$r5,$r0
   120002a18:	00150324 	move	$r4,$r25
   120002a1c:	54072400 	bl	1828(0x724) # 120003140 <measureFunction>
   120002a20:	01192400 	fcvt.d.s	$f0,$f0
   120002a24:	0114b805 	movfr2gr.d	$r5,$f0
   120002a28:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002a2c:	02f54084 	addi.d	$r4,$r4,-688(0xd50)
   120002a30:	57e753ff 	bl	-6320(0xfffe750) # 120001180 <printf@plt>
   120002a34:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002a38:	63f9cd9c 	blt	$r12,$r28,-1588(0x3f9cc) # 120002404 <main+0x1264>
   120002a3c:	53e7f3ff 	b	-6160(0xfffe7f0) # 12000122c <main+0x8c>
   120002a40:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002a44:	02c2e35a 	addi.d	$r26,$r26,184(0xb8)
   120002a48:	2b000340 	fld.s	$f0,$r26,0
   120002a4c:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002a50:	28dd10c6 	ld.d	$r6,$r6,1860(0x744)
   120002a54:	00150005 	move	$r5,$r0
   120002a58:	00150324 	move	$r4,$r25
   120002a5c:	5406e400 	bl	1764(0x6e4) # 120003140 <measureFunction>
   120002a60:	01145400 	frecip.s	$f0,$f0
   120002a64:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002a68:	02f3d084 	addi.d	$r4,$r4,-780(0xcf4)
   120002a6c:	01192400 	fcvt.d.s	$f0,$f0
   120002a70:	0114b805 	movfr2gr.d	$r5,$f0
   120002a74:	57e70fff 	bl	-6388(0xfffe70c) # 120001180 <printf@plt>
   120002a78:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002a7c:	63f9419c 	blt	$r12,$r28,-1728(0x3f940) # 1200023bc <main+0x121c>
   120002a80:	53e7afff 	b	-6228(0xfffe7ac) # 12000122c <main+0x8c>
   120002a84:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002a88:	02c1d35a 	addi.d	$r26,$r26,116(0x74)
   120002a8c:	2b000340 	fld.s	$f0,$r26,0
   120002a90:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002a94:	28dd40c6 	ld.d	$r6,$r6,1872(0x750)
   120002a98:	00150005 	move	$r5,$r0
   120002a9c:	00150324 	move	$r4,$r25
   120002aa0:	5406a000 	bl	1696(0x6a0) # 120003140 <measureFunction>
   120002aa4:	01192400 	fcvt.d.s	$f0,$f0
   120002aa8:	0114b805 	movfr2gr.d	$r5,$f0
   120002aac:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002ab0:	02f25084 	addi.d	$r4,$r4,-876(0xc94)
   120002ab4:	57e6cfff 	bl	-6452(0xfffe6cc) # 120001180 <printf@plt>
   120002ab8:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002abc:	63f8b59c 	blt	$r12,$r28,-1868(0x3f8b4) # 120002370 <main+0x11d0>
   120002ac0:	53e76fff 	b	-6292(0xfffe76c) # 12000122c <main+0x8c>
   120002ac4:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002ac8:	02c0d35a 	addi.d	$r26,$r26,52(0x34)
   120002acc:	2b000340 	fld.s	$f0,$r26,0
   120002ad0:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002ad4:	28dba0c6 	ld.d	$r6,$r6,1768(0x6e8)
   120002ad8:	00150005 	move	$r5,$r0
   120002adc:	00150324 	move	$r4,$r25
   120002ae0:	54066000 	bl	1632(0x660) # 120003140 <measureFunction>
   120002ae4:	01145400 	frecip.s	$f0,$f0
   120002ae8:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002aec:	02f0e084 	addi.d	$r4,$r4,-968(0xc38)
   120002af0:	01192400 	fcvt.d.s	$f0,$f0
   120002af4:	0114b805 	movfr2gr.d	$r5,$f0
   120002af8:	57e68bff 	bl	-6520(0xfffe688) # 120001180 <printf@plt>
   120002afc:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002b00:	63f8299c 	blt	$r12,$r28,-2008(0x3f828) # 120002328 <main+0x1188>
   120002b04:	53e72bff 	b	-6360(0xfffe728) # 12000122c <main+0x8c>
   120002b08:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002b0c:	02ffc35a 	addi.d	$r26,$r26,-16(0xff0)
   120002b10:	2b000340 	fld.s	$f0,$r26,0
   120002b14:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002b18:	28d850c6 	ld.d	$r6,$r6,1556(0x614)
   120002b1c:	00150005 	move	$r5,$r0
   120002b20:	00150324 	move	$r4,$r25
   120002b24:	54061c00 	bl	1564(0x61c) # 120003140 <measureFunction>
   120002b28:	01192400 	fcvt.d.s	$f0,$f0
   120002b2c:	0114b805 	movfr2gr.d	$r5,$f0
   120002b30:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002b34:	02ef6084 	addi.d	$r4,$r4,-1064(0xbd8)
   120002b38:	57e64bff 	bl	-6584(0xfffe648) # 120001180 <printf@plt>
   120002b3c:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002b40:	63f79d9c 	blt	$r12,$r28,-2148(0x3f79c) # 1200022dc <main+0x113c>
   120002b44:	53e6ebff 	b	-6424(0xfffe6e8) # 12000122c <main+0x8c>
   120002b48:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002b4c:	02fec35a 	addi.d	$r26,$r26,-80(0xfb0)
   120002b50:	2b000340 	fld.s	$f0,$r26,0
   120002b54:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002b58:	28d6b0c6 	ld.d	$r6,$r6,1452(0x5ac)
   120002b5c:	00150005 	move	$r5,$r0
   120002b60:	00150324 	move	$r4,$r25
   120002b64:	5405dc00 	bl	1500(0x5dc) # 120003140 <measureFunction>
   120002b68:	01145400 	frecip.s	$f0,$f0
   120002b6c:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002b70:	02edd084 	addi.d	$r4,$r4,-1164(0xb74)
   120002b74:	01192400 	fcvt.d.s	$f0,$f0
   120002b78:	0114b805 	movfr2gr.d	$r5,$f0
   120002b7c:	57e607ff 	bl	-6652(0xfffe604) # 120001180 <printf@plt>
   120002b80:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002b84:	63f7119c 	blt	$r12,$r28,-2288(0x3f710) # 120002294 <main+0x10f4>
   120002b88:	53e6a7ff 	b	-6492(0xfffe6a4) # 12000122c <main+0x8c>
   120002b8c:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002b90:	02fdb35a 	addi.d	$r26,$r26,-148(0xf6c)
   120002b94:	2b000340 	fld.s	$f0,$r26,0
   120002b98:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002b9c:	28d940c6 	ld.d	$r6,$r6,1616(0x650)
   120002ba0:	00150005 	move	$r5,$r0
   120002ba4:	00150324 	move	$r4,$r25
   120002ba8:	54059800 	bl	1432(0x598) # 120003140 <measureFunction>
   120002bac:	01192400 	fcvt.d.s	$f0,$f0
   120002bb0:	0114b805 	movfr2gr.d	$r5,$f0
   120002bb4:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002bb8:	02ec5084 	addi.d	$r4,$r4,-1260(0xb14)
   120002bbc:	57e5c7ff 	bl	-6716(0xfffe5c4) # 120001180 <printf@plt>
   120002bc0:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002bc4:	63f6859c 	blt	$r12,$r28,-2428(0x3f684) # 120002248 <main+0x10a8>
   120002bc8:	53e667ff 	b	-6556(0xfffe664) # 12000122c <main+0x8c>
   120002bcc:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002bd0:	02fcb35a 	addi.d	$r26,$r26,-212(0xf2c)
   120002bd4:	2b000340 	fld.s	$f0,$r26,0
   120002bd8:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002bdc:	28d5a0c6 	ld.d	$r6,$r6,1384(0x568)
   120002be0:	00150005 	move	$r5,$r0
   120002be4:	00150324 	move	$r4,$r25
   120002be8:	54055800 	bl	1368(0x558) # 120003140 <measureFunction>
   120002bec:	01192400 	fcvt.d.s	$f0,$f0
   120002bf0:	0114b805 	movfr2gr.d	$r5,$f0
   120002bf4:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002bf8:	02ea3084 	addi.d	$r4,$r4,-1396(0xa8c)
   120002bfc:	57e587ff 	bl	-6780(0xfffe584) # 120001180 <printf@plt>
   120002c00:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002c04:	63f5ad9c 	blt	$r12,$r28,-2644(0x3f5ac) # 1200021b0 <main+0x1010>
   120002c08:	53e627ff 	b	-6620(0xfffe624) # 12000122c <main+0x8c>
   120002c0c:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002c10:	02fbb35a 	addi.d	$r26,$r26,-276(0xeec)
   120002c14:	2b000340 	fld.s	$f0,$r26,0
   120002c18:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002c1c:	28d420c6 	ld.d	$r6,$r6,1288(0x508)
   120002c20:	00150005 	move	$r5,$r0
   120002c24:	00150324 	move	$r4,$r25
   120002c28:	54051800 	bl	1304(0x518) # 120003140 <measureFunction>
   120002c2c:	01145400 	frecip.s	$f0,$f0
   120002c30:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002c34:	02e8a084 	addi.d	$r4,$r4,-1496(0xa28)
   120002c38:	01192400 	fcvt.d.s	$f0,$f0
   120002c3c:	0114b805 	movfr2gr.d	$r5,$f0
   120002c40:	57e543ff 	bl	-6848(0xfffe540) # 120001180 <printf@plt>
   120002c44:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002c48:	63f5219c 	blt	$r12,$r28,-2784(0x3f520) # 120002168 <main+0xfc8>
   120002c4c:	53e5e3ff 	b	-6688(0xfffe5e0) # 12000122c <main+0x8c>
   120002c50:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002c54:	02faa35a 	addi.d	$r26,$r26,-344(0xea8)
   120002c58:	2b000340 	fld.s	$f0,$r26,0
   120002c5c:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002c60:	28d450c6 	ld.d	$r6,$r6,1300(0x514)
   120002c64:	00150005 	move	$r5,$r0
   120002c68:	00150324 	move	$r4,$r25
   120002c6c:	5404d400 	bl	1236(0x4d4) # 120003140 <measureFunction>
   120002c70:	01192400 	fcvt.d.s	$f0,$f0
   120002c74:	0114b805 	movfr2gr.d	$r5,$f0
   120002c78:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002c7c:	02e70084 	addi.d	$r4,$r4,-1600(0x9c0)
   120002c80:	57e503ff 	bl	-6912(0xfffe500) # 120001180 <printf@plt>
   120002c84:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002c88:	63f4959c 	blt	$r12,$r28,-2924(0x3f494) # 12000211c <main+0xf7c>
   120002c8c:	53e5a3ff 	b	-6752(0xfffe5a0) # 12000122c <main+0x8c>
   120002c90:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002c94:	02f9a35a 	addi.d	$r26,$r26,-408(0xe68)
   120002c98:	2b000340 	fld.s	$f0,$r26,0
   120002c9c:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002ca0:	28d1f0c6 	ld.d	$r6,$r6,1148(0x47c)
   120002ca4:	00150005 	move	$r5,$r0
   120002ca8:	00150324 	move	$r4,$r25
   120002cac:	54049400 	bl	1172(0x494) # 120003140 <measureFunction>
   120002cb0:	01145400 	frecip.s	$f0,$f0
   120002cb4:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002cb8:	02e59084 	addi.d	$r4,$r4,-1692(0x964)
   120002cbc:	01192400 	fcvt.d.s	$f0,$f0
   120002cc0:	0114b805 	movfr2gr.d	$r5,$f0
   120002cc4:	57e4bfff 	bl	-6980(0xfffe4bc) # 120001180 <printf@plt>
   120002cc8:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002ccc:	63f4099c 	blt	$r12,$r28,-3064(0x3f408) # 1200020d4 <main+0xf34>
   120002cd0:	53e55fff 	b	-6820(0xfffe55c) # 12000122c <main+0x8c>
   120002cd4:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002cd8:	02f8935a 	addi.d	$r26,$r26,-476(0xe24)
   120002cdc:	2b000340 	fld.s	$f0,$r26,0
   120002ce0:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002ce4:	28d200c6 	ld.d	$r6,$r6,1152(0x480)
   120002ce8:	00150005 	move	$r5,$r0
   120002cec:	00150324 	move	$r4,$r25
   120002cf0:	54045000 	bl	1104(0x450) # 120003140 <measureFunction>
   120002cf4:	01192400 	fcvt.d.s	$f0,$f0
   120002cf8:	0114b805 	movfr2gr.d	$r5,$f0
   120002cfc:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002d00:	02e41084 	addi.d	$r4,$r4,-1788(0x904)
   120002d04:	57e47fff 	bl	-7044(0xfffe47c) # 120001180 <printf@plt>
   120002d08:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002d0c:	63f37d9c 	blt	$r12,$r28,-3204(0x3f37c) # 120002088 <main+0xee8>
   120002d10:	53e51fff 	b	-6884(0xfffe51c) # 12000122c <main+0x8c>
   120002d14:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002d18:	02f7935a 	addi.d	$r26,$r26,-540(0xde4)
   120002d1c:	2b000340 	fld.s	$f0,$r26,0
   120002d20:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002d24:	28d040c6 	ld.d	$r6,$r6,1040(0x410)
   120002d28:	00150005 	move	$r5,$r0
   120002d2c:	00150324 	move	$r4,$r25
   120002d30:	54041000 	bl	1040(0x410) # 120003140 <measureFunction>
   120002d34:	01145400 	frecip.s	$f0,$f0
   120002d38:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002d3c:	02e28084 	addi.d	$r4,$r4,-1888(0x8a0)
   120002d40:	01192400 	fcvt.d.s	$f0,$f0
   120002d44:	0114b805 	movfr2gr.d	$r5,$f0
   120002d48:	57e43bff 	bl	-7112(0xfffe438) # 120001180 <printf@plt>
   120002d4c:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002d50:	63f2f19c 	blt	$r12,$r28,-3344(0x3f2f0) # 120002040 <main+0xea0>
   120002d54:	53e4dbff 	b	-6952(0xfffe4d8) # 12000122c <main+0x8c>
   120002d58:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002d5c:	02f6835a 	addi.d	$r26,$r26,-608(0xda0)
   120002d60:	28c00305 	ld.d	$r5,$r24,0
   120002d64:	2b000340 	fld.s	$f0,$r26,0
   120002d68:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002d6c:	28d040c6 	ld.d	$r6,$r6,1040(0x410)
   120002d70:	00150324 	move	$r4,$r25
   120002d74:	5403cc00 	bl	972(0x3cc) # 120003140 <measureFunction>
   120002d78:	01192400 	fcvt.d.s	$f0,$f0
   120002d7c:	0114b805 	movfr2gr.d	$r5,$f0
   120002d80:	1c000044 	pcaddu12i	$r4,2(0x2)
   120002d84:	02e10084 	addi.d	$r4,$r4,-1984(0x840)
   120002d88:	57e3fbff 	bl	-7176(0xfffe3f8) # 120001180 <printf@plt>
   120002d8c:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002d90:	63f2659c 	blt	$r12,$r28,-3484(0x3f264) # 120001ff4 <main+0xe54>
   120002d94:	53e49bff 	b	-7016(0xfffe498) # 12000122c <main+0x8c>
   120002d98:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002d9c:	02f5835a 	addi.d	$r26,$r26,-672(0xd60)
   120002da0:	2b000340 	fld.s	$f0,$r26,0
   120002da4:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002da8:	28cf10c6 	ld.d	$r6,$r6,964(0x3c4)
   120002dac:	00150005 	move	$r5,$r0
   120002db0:	00150324 	move	$r4,$r25
   120002db4:	54038c00 	bl	908(0x38c) # 120003140 <measureFunction>
   120002db8:	01145400 	frecip.s	$f0,$f0
   120002dbc:	1c000024 	pcaddu12i	$r4,1(0x1)
   120002dc0:	02df7084 	addi.d	$r4,$r4,2012(0x7dc)
   120002dc4:	01192400 	fcvt.d.s	$f0,$f0
   120002dc8:	0114b805 	movfr2gr.d	$r5,$f0
   120002dcc:	57e3b7ff 	bl	-7244(0xfffe3b4) # 120001180 <printf@plt>
   120002dd0:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002dd4:	63f1d99c 	blt	$r12,$r28,-3624(0x3f1d8) # 120001fac <main+0xe0c>
   120002dd8:	53e457ff 	b	-7084(0xfffe454) # 12000122c <main+0x8c>
   120002ddc:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002de0:	02f4735a 	addi.d	$r26,$r26,-740(0xd1c)
   120002de4:	2b000340 	fld.s	$f0,$r26,0
   120002de8:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002dec:	28cfa0c6 	ld.d	$r6,$r6,1000(0x3e8)
   120002df0:	00150005 	move	$r5,$r0
   120002df4:	00150324 	move	$r4,$r25
   120002df8:	54034800 	bl	840(0x348) # 120003140 <measureFunction>
   120002dfc:	01192400 	fcvt.d.s	$f0,$f0
   120002e00:	0114b805 	movfr2gr.d	$r5,$f0
   120002e04:	1c000024 	pcaddu12i	$r4,1(0x1)
   120002e08:	02ddd084 	addi.d	$r4,$r4,1908(0x774)
   120002e0c:	57e377ff 	bl	-7308(0xfffe374) # 120001180 <printf@plt>
   120002e10:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002e14:	63f14d9c 	blt	$r12,$r28,-3764(0x3f14c) # 120001f60 <main+0xdc0>
   120002e18:	53e417ff 	b	-7148(0xfffe414) # 12000122c <main+0x8c>
   120002e1c:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002e20:	02f3735a 	addi.d	$r26,$r26,-804(0xcdc)
   120002e24:	2b000340 	fld.s	$f0,$r26,0
   120002e28:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002e2c:	28cd60c6 	ld.d	$r6,$r6,856(0x358)
   120002e30:	00150005 	move	$r5,$r0
   120002e34:	00150324 	move	$r4,$r25
   120002e38:	54030800 	bl	776(0x308) # 120003140 <measureFunction>
   120002e3c:	01145400 	frecip.s	$f0,$f0
   120002e40:	1c000024 	pcaddu12i	$r4,1(0x1)
   120002e44:	02dc4084 	addi.d	$r4,$r4,1808(0x710)
   120002e48:	01192400 	fcvt.d.s	$f0,$f0
   120002e4c:	0114b805 	movfr2gr.d	$r5,$f0
   120002e50:	57e333ff 	bl	-7376(0xfffe330) # 120001180 <printf@plt>
   120002e54:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002e58:	63f0c19c 	blt	$r12,$r28,-3904(0x3f0c0) # 120001f18 <main+0xd78>
   120002e5c:	53e3d3ff 	b	-7216(0xfffe3d0) # 12000122c <main+0x8c>
   120002e60:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002e64:	02f2635a 	addi.d	$r26,$r26,-872(0xc98)
   120002e68:	2b000340 	fld.s	$f0,$r26,0
   120002e6c:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002e70:	28ccb0c6 	ld.d	$r6,$r6,812(0x32c)
   120002e74:	00150005 	move	$r5,$r0
   120002e78:	00150324 	move	$r4,$r25
   120002e7c:	5402c400 	bl	708(0x2c4) # 120003140 <measureFunction>
   120002e80:	01192400 	fcvt.d.s	$f0,$f0
   120002e84:	0114b805 	movfr2gr.d	$r5,$f0
   120002e88:	1c000024 	pcaddu12i	$r4,1(0x1)
   120002e8c:	02daa084 	addi.d	$r4,$r4,1704(0x6a8)
   120002e90:	57e2f3ff 	bl	-7440(0xfffe2f0) # 120001180 <printf@plt>
   120002e94:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002e98:	63f0359c 	blt	$r12,$r28,-4044(0x3f034) # 120001ecc <main+0xd2c>
   120002e9c:	53e393ff 	b	-7280(0xfffe390) # 12000122c <main+0x8c>
   120002ea0:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002ea4:	02f1635a 	addi.d	$r26,$r26,-936(0xc58)
   120002ea8:	2b000340 	fld.s	$f0,$r26,0
   120002eac:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002eb0:	28ce30c6 	ld.d	$r6,$r6,908(0x38c)
   120002eb4:	00150005 	move	$r5,$r0
   120002eb8:	00150324 	move	$r4,$r25
   120002ebc:	54028400 	bl	644(0x284) # 120003140 <measureFunction>
   120002ec0:	01145400 	frecip.s	$f0,$f0
   120002ec4:	1c000024 	pcaddu12i	$r4,1(0x1)
   120002ec8:	02d93084 	addi.d	$r4,$r4,1612(0x64c)
   120002ecc:	01192400 	fcvt.d.s	$f0,$f0
   120002ed0:	0114b805 	movfr2gr.d	$r5,$f0
   120002ed4:	57e2afff 	bl	-7508(0xfffe2ac) # 120001180 <printf@plt>
   120002ed8:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002edc:	63efa99c 	blt	$r12,$r28,-4184(0x3efa8) # 120001e84 <main+0xce4>
   120002ee0:	53e34fff 	b	-7348(0xfffe34c) # 12000122c <main+0x8c>
   120002ee4:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002ee8:	02f0535a 	addi.d	$r26,$r26,-1004(0xc14)
   120002eec:	2b000340 	fld.s	$f0,$r26,0
   120002ef0:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002ef4:	28c960c6 	ld.d	$r6,$r6,600(0x258)
   120002ef8:	00150005 	move	$r5,$r0
   120002efc:	00150324 	move	$r4,$r25
   120002f00:	54024000 	bl	576(0x240) # 120003140 <measureFunction>
   120002f04:	01192400 	fcvt.d.s	$f0,$f0
   120002f08:	0114b805 	movfr2gr.d	$r5,$f0
   120002f0c:	1c000024 	pcaddu12i	$r4,1(0x1)
   120002f10:	02d7b084 	addi.d	$r4,$r4,1516(0x5ec)
   120002f14:	57e26fff 	bl	-7572(0xfffe26c) # 120001180 <printf@plt>
   120002f18:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002f1c:	63ef1d9c 	blt	$r12,$r28,-4324(0x3ef1c) # 120001e38 <main+0xc98>
   120002f20:	53e30fff 	b	-7412(0xfffe30c) # 12000122c <main+0x8c>
   120002f24:	1c00005a 	pcaddu12i	$r26,2(0x2)
   120002f28:	02ef535a 	addi.d	$r26,$r26,-1068(0xbd4)
   120002f2c:	2b000340 	fld.s	$f0,$r26,0
   120002f30:	1c000126 	pcaddu12i	$r6,9(0x9)
   120002f34:	28c9c0c6 	ld.d	$r6,$r6,624(0x270)
   120002f38:	00150005 	move	$r5,$r0
   120002f3c:	00150324 	move	$r4,$r25
   120002f40:	54020000 	bl	512(0x200) # 120003140 <measureFunction>
   120002f44:	01192400 	fcvt.d.s	$f0,$f0
   120002f48:	0114b805 	movfr2gr.d	$r5,$f0
   120002f4c:	1c000024 	pcaddu12i	$r4,1(0x1)
   120002f50:	02d65084 	addi.d	$r4,$r4,1428(0x594)
   120002f54:	57e22fff 	bl	-7636(0xfffe22c) # 120001180 <printf@plt>
   120002f58:	0280040c 	addi.w	$r12,$r0,1(0x1)
   120002f5c:	63ee959c 	blt	$r12,$r28,-4460(0x3ee94) # 120001df0 <main+0xc50>
   120002f60:	53e2cfff 	b	-7476(0xfffe2cc) # 12000122c <main+0x8c>
   120002f64:	034005ac 	andi	$r12,$r13,0x1
   120002f68:	004505ad 	srli.d	$r13,$r13,0x1
   120002f6c:	0015358c 	or	$r12,$r12,$r13
   120002f70:	0114a980 	movgr2fr.d	$f0,$r12
   120002f74:	011d1818 	ffint.s.l	$f24,$f0
   120002f78:	0100e318 	fadd.s	$f24,$f24,$f24
   120002f7c:	53e347ff 	b	-7356(0xfffe344) # 1200012c0 <main+0x120>
   120002f80:	157e11d9 	lu12i.w	$r25,-266098(0xbf08e)
   120002f84:	03ac0339 	ori	$r25,$r25,0xb00
   120002f88:	16000039 	lu32i.d	$r25,1(0x1)
   120002f8c:	53ea0fff 	b	-5620(0xfffea0c) # 120001998 <main+0x7f8>

0000000120002f90 <_start>:
   120002f90:	00150089 	move	$r9,$r4
   120002f94:	1c000124 	pcaddu12i	$r4,9(0x9)
   120002f98:	0388d00c 	ori	$r12,$r0,0x234
   120002f9c:	1600000c 	lu32i.d	$r12,0
   120002fa0:	0300018c 	lu52i.d	$r12,$r12,0
   120002fa4:	380c3084 	ldx.d	$r4,$r4,$r12
   120002fa8:	28c00065 	ld.d	$r5,$r3,0
   120002fac:	02c02066 	addi.d	$r6,$r3,8(0x8)
   120002fb0:	00451063 	srli.d	$r3,$r3,0x4
   120002fb4:	00411063 	slli.d	$r3,$r3,0x4
   120002fb8:	1c000127 	pcaddu12i	$r7,9(0x9)
   120002fbc:	0387e00c 	ori	$r12,$r0,0x1f8
   120002fc0:	1600000c 	lu32i.d	$r12,0
   120002fc4:	0300018c 	lu52i.d	$r12,$r12,0
   120002fc8:	380c30e7 	ldx.d	$r7,$r7,$r12
   120002fcc:	1c000128 	pcaddu12i	$r8,9(0x9)
   120002fd0:	0384500c 	ori	$r12,$r0,0x114
   120002fd4:	1600000c 	lu32i.d	$r12,0
   120002fd8:	0300018c 	lu52i.d	$r12,$r12,0
   120002fdc:	380c3108 	ldx.d	$r8,$r8,$r12
   120002fe0:	0015006a 	move	$r10,$r3
   120002fe4:	1c000121 	pcaddu12i	$r1,9(0x9)
   120002fe8:	0385b00c 	ori	$r12,$r0,0x16c
   120002fec:	1600000c 	lu32i.d	$r12,0
   120002ff0:	0300018c 	lu52i.d	$r12,$r12,0
   120002ff4:	380c3021 	ldx.d	$r1,$r1,$r12
   120002ff8:	4c000021 	jirl	$r1,$r1,0
   120002ffc:	1c000121 	pcaddu12i	$r1,9(0x9)
   120003000:	0386300c 	ori	$r12,$r0,0x18c
   120003004:	1600000c 	lu32i.d	$r12,0
   120003008:	0300018c 	lu52i.d	$r12,$r12,0
   12000300c:	380c3021 	ldx.d	$r1,$r1,$r12
   120003010:	4c000021 	jirl	$r1,$r1,0
   120003014:	03400000 	andi	$r0,$r0,0x0
   120003018:	03400000 	andi	$r0,$r0,0x0
   12000301c:	03400000 	andi	$r0,$r0,0x0

0000000120003020 <deregister_tm_clones>:
   120003020:	02ffc063 	addi.d	$r3,$r3,-16(0xff0)
   120003024:	29c02076 	st.d	$r22,$r3,8(0x8)
   120003028:	02c04076 	addi.d	$r22,$r3,16(0x10)
   12000302c:	1c000124 	pcaddu12i	$r4,9(0x9)
   120003030:	02c2b084 	addi.d	$r4,$r4,172(0xac)
   120003034:	1c00012c 	pcaddu12i	$r12,9(0x9)
   120003038:	02c2918c 	addi.d	$r12,$r12,164(0xa4)
   12000303c:	58001d84 	beq	$r12,$r4,28(0x1c) # 120003058 <deregister_tm_clones+0x38>
   120003040:	1c00012c 	pcaddu12i	$r12,9(0x9)
   120003044:	28c3218c 	ld.d	$r12,$r12,200(0xc8)
   120003048:	40001180 	beqz	$r12,16(0x10) # 120003058 <deregister_tm_clones+0x38>
   12000304c:	28c02076 	ld.d	$r22,$r3,8(0x8)
   120003050:	02c04063 	addi.d	$r3,$r3,16(0x10)
   120003054:	4c000180 	jirl	$r0,$r12,0
   120003058:	28c02076 	ld.d	$r22,$r3,8(0x8)
   12000305c:	02c04063 	addi.d	$r3,$r3,16(0x10)
   120003060:	4c000020 	jirl	$r0,$r1,0
   120003064:	03400000 	andi	$r0,$r0,0x0
   120003068:	03400000 	andi	$r0,$r0,0x0
   12000306c:	03400000 	andi	$r0,$r0,0x0

0000000120003070 <register_tm_clones>:
   120003070:	1c000124 	pcaddu12i	$r4,9(0x9)
   120003074:	02c1a084 	addi.d	$r4,$r4,104(0x68)
   120003078:	1c000125 	pcaddu12i	$r5,9(0x9)
   12000307c:	02c180a5 	addi.d	$r5,$r5,96(0x60)
   120003080:	001190a5 	sub.d	$r5,$r5,$r4
   120003084:	00490ca5 	srai.d	$r5,$r5,0x3
   120003088:	02ffc063 	addi.d	$r3,$r3,-16(0xff0)
   12000308c:	0045fcac 	srli.d	$r12,$r5,0x3f
   120003090:	29c02076 	st.d	$r22,$r3,8(0x8)
   120003094:	00109585 	add.d	$r5,$r12,$r5
   120003098:	02c04076 	addi.d	$r22,$r3,16(0x10)
   12000309c:	004904a5 	srai.d	$r5,$r5,0x1
   1200030a0:	400020a0 	beqz	$r5,32(0x20) # 1200030c0 <register_tm_clones+0x50>
   1200030a4:	1c00012c 	pcaddu12i	$r12,9(0x9)
   1200030a8:	28c5918c 	ld.d	$r12,$r12,356(0x164)
   1200030ac:	40001580 	beqz	$r12,20(0x14) # 1200030c0 <register_tm_clones+0x50>
   1200030b0:	28c02076 	ld.d	$r22,$r3,8(0x8)
   1200030b4:	02c04063 	addi.d	$r3,$r3,16(0x10)
   1200030b8:	4c000180 	jirl	$r0,$r12,0
   1200030bc:	03400000 	andi	$r0,$r0,0x0
   1200030c0:	28c02076 	ld.d	$r22,$r3,8(0x8)
   1200030c4:	02c04063 	addi.d	$r3,$r3,16(0x10)
   1200030c8:	4c000020 	jirl	$r0,$r1,0
   1200030cc:	03400000 	andi	$r0,$r0,0x0

00000001200030d0 <__do_global_dtors_aux>:
   1200030d0:	02ff8063 	addi.d	$r3,$r3,-32(0xfe0)
   1200030d4:	29c04076 	st.d	$r22,$r3,16(0x10)
   1200030d8:	29c02077 	st.d	$r23,$r3,8(0x8)
   1200030dc:	29c06061 	st.d	$r1,$r3,24(0x18)
   1200030e0:	02c08076 	addi.d	$r22,$r3,32(0x20)
   1200030e4:	1c000137 	pcaddu12i	$r23,9(0x9)
   1200030e8:	02c592f7 	addi.d	$r23,$r23,356(0x164)
   1200030ec:	2a0002ec 	ld.bu	$r12,$r23,0
   1200030f0:	44001180 	bnez	$r12,16(0x10) # 120003100 <__do_global_dtors_aux+0x30>
   1200030f4:	57ff2fff 	bl	-212(0xfffff2c) # 120003020 <deregister_tm_clones>
   1200030f8:	0280040c 	addi.w	$r12,$r0,1(0x1)
   1200030fc:	290002ec 	st.b	$r12,$r23,0
   120003100:	28c06061 	ld.d	$r1,$r3,24(0x18)
   120003104:	28c04076 	ld.d	$r22,$r3,16(0x10)
   120003108:	28c02077 	ld.d	$r23,$r3,8(0x8)
   12000310c:	02c08063 	addi.d	$r3,$r3,32(0x20)
   120003110:	4c000020 	jirl	$r0,$r1,0
   120003114:	03400000 	andi	$r0,$r0,0x0
   120003118:	03400000 	andi	$r0,$r0,0x0
   12000311c:	03400000 	andi	$r0,$r0,0x0

0000000120003120 <frame_dummy>:
   120003120:	02ffc063 	addi.d	$r3,$r3,-16(0xff0)
   120003124:	29c02076 	st.d	$r22,$r3,8(0x8)
   120003128:	02c04076 	addi.d	$r22,$r3,16(0x10)
   12000312c:	28c02076 	ld.d	$r22,$r3,8(0x8)
   120003130:	02c04063 	addi.d	$r3,$r3,16(0x10)
   120003134:	53ff3fff 	b	-196(0xfffff3c) # 120003070 <register_tm_clones>
   120003138:	03400000 	andi	$r0,$r0,0x0
   12000313c:	03400000 	andi	$r0,$r0,0x0

0000000120003140 <measureFunction>:
   120003140:	02fe8063 	addi.d	$r3,$r3,-96(0xfa0)
   120003144:	29c14077 	st.d	$r23,$r3,80(0x50)
   120003148:	29c10079 	st.d	$r25,$r3,64(0x40)
   12000314c:	00150097 	move	$r23,$r4
   120003150:	001500b9 	move	$r25,$r5
   120003154:	02c08064 	addi.d	$r4,$r3,32(0x20)
   120003158:	02c04065 	addi.d	$r5,$r3,16(0x10)
   12000315c:	2b403060 	fst.s	$f0,$r3,12(0xc)
   120003160:	29c16061 	st.d	$r1,$r3,88(0x58)
   120003164:	29c12078 	st.d	$r24,$r3,72(0x48)
   120003168:	001500d8 	move	$r24,$r6
   12000316c:	57dfe7ff 	bl	-8220(0xfffdfe4) # 120001150 <gettimeofday@plt>
   120003170:	00150325 	move	$r5,$r25
   120003174:	001502e4 	move	$r4,$r23
   120003178:	4c000301 	jirl	$r1,$r24,0
   12000317c:	02c06065 	addi.d	$r5,$r3,24(0x18)
   120003180:	02c0c064 	addi.d	$r4,$r3,48(0x30)
   120003184:	57dfcfff 	bl	-8244(0xfffdfcc) # 120001150 <gettimeofday@plt>
   120003188:	28c0a06c 	ld.d	$r12,$r3,40(0x28)
   12000318c:	28c0e06d 	ld.d	$r13,$r3,56(0x38)
   120003190:	028fa00e 	addi.w	$r14,$r0,1000(0x3e8)
   120003194:	2b003060 	fld.s	$f0,$r3,12(0xc)
   120003198:	0011b1ad 	sub.d	$r13,$r13,$r12
   12000319c:	002239af 	div.d	$r15,$r13,$r14
   1200031a0:	5c0009c0 	bne	$r14,$r0,8(0x8) # 1200031a8 <measureFunction+0x68>
   1200031a4:	002a0007 	break	0x7
   1200031a8:	28c0c06c 	ld.d	$r12,$r3,48(0x30)
   1200031ac:	28c0806d 	ld.d	$r13,$r3,32(0x20)
   1200031b0:	0011b58c 	sub.d	$r12,$r12,$r13
   1200031b4:	001db98c 	mul.d	$r12,$r12,$r14
   1200031b8:	0010bd8c 	add.d	$r12,$r12,$r15
   1200031bc:	60005980 	blt	$r12,$r0,88(0x58) # 120003214 <measureFunction+0xd4>
   1200031c0:	0114a981 	movgr2fr.d	$f1,$r12
   1200031c4:	1c00004c 	pcaddu12i	$r12,2(0x2)
   1200031c8:	02e4718c 	addi.d	$r12,$r12,-1764(0x91c)
   1200031cc:	2b800182 	fld.d	$f2,$r12,0
   1200031d0:	011d1821 	ffint.s.l	$f1,$f1
   1200031d4:	01192421 	fcvt.d.s	$f1,$f1
   1200031d8:	01050821 	fmul.d	$f1,$f1,$f2
   1200031dc:	60006ae0 	blt	$r23,$r0,104(0x68) # 120003244 <measureFunction+0x104>
   1200031e0:	0114aae2 	movgr2fr.d	$f2,$r23
   1200031e4:	28c16061 	ld.d	$r1,$r3,88(0x58)
   1200031e8:	011d1842 	ffint.s.l	$f2,$f2
   1200031ec:	01192442 	fcvt.d.s	$f2,$f2
   1200031f0:	01070821 	fdiv.d	$f1,$f1,$f2
   1200031f4:	28c14077 	ld.d	$r23,$r3,80(0x50)
   1200031f8:	28c12078 	ld.d	$r24,$r3,72(0x48)
   1200031fc:	28c10079 	ld.d	$r25,$r3,64(0x40)
   120003200:	02c18063 	addi.d	$r3,$r3,96(0x60)
   120003204:	01191821 	fcvt.s.d	$f1,$f1
   120003208:	01145421 	frecip.s	$f1,$f1
   12000320c:	01068020 	fdiv.s	$f0,$f1,$f0
   120003210:	4c000020 	jirl	$r0,$r1,0
   120003214:	0340058d 	andi	$r13,$r12,0x1
   120003218:	0045058c 	srli.d	$r12,$r12,0x1
   12000321c:	001531ad 	or	$r13,$r13,$r12
   120003220:	0114a9a1 	movgr2fr.d	$f1,$r13
   120003224:	1c00004c 	pcaddu12i	$r12,2(0x2)
   120003228:	02e2f18c 	addi.d	$r12,$r12,-1860(0x8bc)
   12000322c:	011d1821 	ffint.s.l	$f1,$f1
   120003230:	01008421 	fadd.s	$f1,$f1,$f1
   120003234:	2b800182 	fld.d	$f2,$r12,0
   120003238:	01192421 	fcvt.d.s	$f1,$f1
   12000323c:	01050821 	fmul.d	$f1,$f1,$f2
   120003240:	67ffa2e0 	bge	$r23,$r0,-96(0x3ffa0) # 1200031e0 <measureFunction+0xa0>
   120003244:	034006ec 	andi	$r12,$r23,0x1
   120003248:	004506f7 	srli.d	$r23,$r23,0x1
   12000324c:	00155d8c 	or	$r12,$r12,$r23
   120003250:	0114a982 	movgr2fr.d	$f2,$r12
   120003254:	28c16061 	ld.d	$r1,$r3,88(0x58)
   120003258:	011d1842 	ffint.s.l	$f2,$f2
   12000325c:	01008842 	fadd.s	$f2,$f2,$f2
   120003260:	28c14077 	ld.d	$r23,$r3,80(0x50)
   120003264:	28c12078 	ld.d	$r24,$r3,72(0x48)
   120003268:	28c10079 	ld.d	$r25,$r3,64(0x40)
   12000326c:	01192442 	fcvt.d.s	$f2,$f2
   120003270:	01070821 	fdiv.d	$f1,$f1,$f2
   120003274:	02c18063 	addi.d	$r3,$r3,96(0x60)
   120003278:	01191821 	fcvt.s.d	$f1,$f1
   12000327c:	01145421 	frecip.s	$f1,$f1
   120003280:	01068020 	fdiv.s	$f0,$f1,$f0
   120003284:	4c000020 	jirl	$r0,$r1,0
   120003288:	03400000 	andi	$r0,$r0,0x0
   12000328c:	03400000 	andi	$r0,$r0,0x0

0000000120003290 <clktest>:
   120003290:	0015b18c 	xor	$r12,$r12,$r12
   120003294:	0015b5ad 	xor	$r13,$r13,$r13
   120003298:	0015b9ce 	xor	$r14,$r14,$r14
   12000329c:	02c051ce 	addi.d	$r14,$r14,20(0x14)
   1200032a0:	02c0058c 	addi.d	$r12,$r12,1(0x1)

00000001200032a4 <clktest_loop>:
   1200032a4:	0010b18c 	add.d	$r12,$r12,$r12
   1200032a8:	0010b18c 	add.d	$r12,$r12,$r12
   1200032ac:	0010b18c 	add.d	$r12,$r12,$r12
   1200032b0:	0010b18c 	add.d	$r12,$r12,$r12
   1200032b4:	0010b18c 	add.d	$r12,$r12,$r12
   1200032b8:	0010b18c 	add.d	$r12,$r12,$r12
   1200032bc:	0010b18c 	add.d	$r12,$r12,$r12
   1200032c0:	0010b18c 	add.d	$r12,$r12,$r12
   1200032c4:	0010b18c 	add.d	$r12,$r12,$r12
   1200032c8:	0010b18c 	add.d	$r12,$r12,$r12
   1200032cc:	0010b18c 	add.d	$r12,$r12,$r12
   1200032d0:	0010b18c 	add.d	$r12,$r12,$r12
   1200032d4:	0010b18c 	add.d	$r12,$r12,$r12
   1200032d8:	0010b18c 	add.d	$r12,$r12,$r12
   1200032dc:	0010b18c 	add.d	$r12,$r12,$r12
   1200032e0:	0010b18c 	add.d	$r12,$r12,$r12
   1200032e4:	0010b18c 	add.d	$r12,$r12,$r12
   1200032e8:	0010b18c 	add.d	$r12,$r12,$r12
   1200032ec:	0010b18c 	add.d	$r12,$r12,$r12
   1200032f0:	0010b18c 	add.d	$r12,$r12,$r12
   1200032f4:	0011b884 	sub.d	$r4,$r4,$r14
   1200032f8:	67ffac8d 	bge	$r4,$r13,-84(0x3ffac) # 1200032a4 <clktest_loop>
   1200032fc:	4c000020 	jirl	$r0,$r1,0

0000000120003300 <noptest>:
   120003300:	0015b9ce 	xor	$r14,$r14,$r14
   120003304:	0015b5ad 	xor	$r13,$r13,$r13
   120003308:	02c051ce 	addi.d	$r14,$r14,20(0x14)

000000012000330c <noptest_loop>:
   12000330c:	03400000 	andi	$r0,$r0,0x0
   120003310:	03400000 	andi	$r0,$r0,0x0
   120003314:	03400000 	andi	$r0,$r0,0x0
   120003318:	03400000 	andi	$r0,$r0,0x0
   12000331c:	03400000 	andi	$r0,$r0,0x0
   120003320:	03400000 	andi	$r0,$r0,0x0
   120003324:	03400000 	andi	$r0,$r0,0x0
   120003328:	03400000 	andi	$r0,$r0,0x0
   12000332c:	03400000 	andi	$r0,$r0,0x0
   120003330:	03400000 	andi	$r0,$r0,0x0
   120003334:	03400000 	andi	$r0,$r0,0x0
   120003338:	03400000 	andi	$r0,$r0,0x0
   12000333c:	03400000 	andi	$r0,$r0,0x0
   120003340:	03400000 	andi	$r0,$r0,0x0
   120003344:	03400000 	andi	$r0,$r0,0x0
   120003348:	03400000 	andi	$r0,$r0,0x0
   12000334c:	03400000 	andi	$r0,$r0,0x0
   120003350:	03400000 	andi	$r0,$r0,0x0
   120003354:	03400000 	andi	$r0,$r0,0x0
   120003358:	03400000 	andi	$r0,$r0,0x0
   12000335c:	0011b884 	sub.d	$r4,$r4,$r14
   120003360:	67ffac8d 	bge	$r4,$r13,-84(0x3ffac) # 12000330c <noptest_loop>
   120003364:	4c000020 	jirl	$r0,$r1,0

0000000120003368 <addtest>:
   120003368:	0015b9ce 	xor	$r14,$r14,$r14
   12000336c:	0015b5ad 	xor	$r13,$r13,$r13
   120003370:	0015b18c 	xor	$r12,$r12,$r12
   120003374:	0015bdef 	xor	$r15,$r15,$r15
   120003378:	0015c210 	xor	$r16,$r16,$r16
   12000337c:	0015c631 	xor	$r17,$r17,$r17
   120003380:	0015ca52 	xor	$r18,$r18,$r18
   120003384:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003388 <addtest_loop>:
   120003388:	0010b98c 	add.d	$r12,$r12,$r14
   12000338c:	0010b9ad 	add.d	$r13,$r13,$r14
   120003390:	0010b9ef 	add.d	$r15,$r15,$r14
   120003394:	0010ba10 	add.d	$r16,$r16,$r14
   120003398:	0010ba31 	add.d	$r17,$r17,$r14
   12000339c:	0010b98c 	add.d	$r12,$r12,$r14
   1200033a0:	0010b9ad 	add.d	$r13,$r13,$r14
   1200033a4:	0010b9ef 	add.d	$r15,$r15,$r14
   1200033a8:	0010ba10 	add.d	$r16,$r16,$r14
   1200033ac:	0010ba31 	add.d	$r17,$r17,$r14
   1200033b0:	0010b98c 	add.d	$r12,$r12,$r14
   1200033b4:	0010b9ad 	add.d	$r13,$r13,$r14
   1200033b8:	0010b9ef 	add.d	$r15,$r15,$r14
   1200033bc:	0010ba10 	add.d	$r16,$r16,$r14
   1200033c0:	0010ba31 	add.d	$r17,$r17,$r14
   1200033c4:	0010b98c 	add.d	$r12,$r12,$r14
   1200033c8:	0010b9ad 	add.d	$r13,$r13,$r14
   1200033cc:	0010b9ef 	add.d	$r15,$r15,$r14
   1200033d0:	0010ba10 	add.d	$r16,$r16,$r14
   1200033d4:	0010ba31 	add.d	$r17,$r17,$r14
   1200033d8:	0011b884 	sub.d	$r4,$r4,$r14
   1200033dc:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003388 <addtest_loop>
   1200033e0:	4c000020 	jirl	$r0,$r1,0

00000001200033e4 <faddtest>:
   1200033e4:	0015b9ce 	xor	$r14,$r14,$r14
   1200033e8:	0015b5ad 	xor	$r13,$r13,$r13
   1200033ec:	0015b18c 	xor	$r12,$r12,$r12
   1200033f0:	0015bdef 	xor	$r15,$r15,$r15
   1200033f4:	0015c210 	xor	$r16,$r16,$r16
   1200033f8:	0015c631 	xor	$r17,$r17,$r17
   1200033fc:	0015ca52 	xor	$r18,$r18,$r18
   120003400:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003404 <faddtest_loop>:
   120003404:	0101398c 	fadd.d	$f12,$f12,$f14
   120003408:	010139ad 	fadd.d	$f13,$f13,$f14
   12000340c:	010139ef 	fadd.d	$f15,$f15,$f14
   120003410:	01013a10 	fadd.d	$f16,$f16,$f14
   120003414:	01013a31 	fadd.d	$f17,$f17,$f14
   120003418:	0101398c 	fadd.d	$f12,$f12,$f14
   12000341c:	010139ad 	fadd.d	$f13,$f13,$f14
   120003420:	010139ef 	fadd.d	$f15,$f15,$f14
   120003424:	01013a10 	fadd.d	$f16,$f16,$f14
   120003428:	01013a31 	fadd.d	$f17,$f17,$f14
   12000342c:	0101398c 	fadd.d	$f12,$f12,$f14
   120003430:	010139ad 	fadd.d	$f13,$f13,$f14
   120003434:	010139ef 	fadd.d	$f15,$f15,$f14
   120003438:	01013a10 	fadd.d	$f16,$f16,$f14
   12000343c:	01013a31 	fadd.d	$f17,$f17,$f14
   120003440:	0101398c 	fadd.d	$f12,$f12,$f14
   120003444:	010139ad 	fadd.d	$f13,$f13,$f14
   120003448:	010139ef 	fadd.d	$f15,$f15,$f14
   12000344c:	01013a10 	fadd.d	$f16,$f16,$f14
   120003450:	01013a31 	fadd.d	$f17,$f17,$f14
   120003454:	0011b884 	sub.d	$r4,$r4,$r14
   120003458:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003404 <faddtest_loop>
   12000345c:	4c000020 	jirl	$r0,$r1,0

0000000120003460 <faddlattest>:
   120003460:	0015b9ce 	xor	$r14,$r14,$r14
   120003464:	0015ca52 	xor	$r18,$r18,$r18
   120003468:	02c051ce 	addi.d	$r14,$r14,20(0x14)

000000012000346c <faddlattest_loop>:
   12000346c:	01014a52 	fadd.d	$f18,$f18,$f18
   120003470:	01014a52 	fadd.d	$f18,$f18,$f18
   120003474:	01014a52 	fadd.d	$f18,$f18,$f18
   120003478:	01014a52 	fadd.d	$f18,$f18,$f18
   12000347c:	01014a52 	fadd.d	$f18,$f18,$f18
   120003480:	01014a52 	fadd.d	$f18,$f18,$f18
   120003484:	01014a52 	fadd.d	$f18,$f18,$f18
   120003488:	01014a52 	fadd.d	$f18,$f18,$f18
   12000348c:	01014a52 	fadd.d	$f18,$f18,$f18
   120003490:	01014a52 	fadd.d	$f18,$f18,$f18
   120003494:	01014a52 	fadd.d	$f18,$f18,$f18
   120003498:	01014a52 	fadd.d	$f18,$f18,$f18
   12000349c:	01014a52 	fadd.d	$f18,$f18,$f18
   1200034a0:	01014a52 	fadd.d	$f18,$f18,$f18
   1200034a4:	01014a52 	fadd.d	$f18,$f18,$f18
   1200034a8:	01014a52 	fadd.d	$f18,$f18,$f18
   1200034ac:	01014a52 	fadd.d	$f18,$f18,$f18
   1200034b0:	01014a52 	fadd.d	$f18,$f18,$f18
   1200034b4:	01014a52 	fadd.d	$f18,$f18,$f18
   1200034b8:	01014a52 	fadd.d	$f18,$f18,$f18
   1200034bc:	0011b884 	sub.d	$r4,$r4,$r14
   1200034c0:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 12000346c <faddlattest_loop>
   1200034c4:	4c000020 	jirl	$r0,$r1,0

00000001200034c8 <vaddtest>:
   1200034c8:	0015b9ce 	xor	$r14,$r14,$r14
   1200034cc:	0015b5ad 	xor	$r13,$r13,$r13
   1200034d0:	0015b18c 	xor	$r12,$r12,$r12
   1200034d4:	0015bdef 	xor	$r15,$r15,$r15
   1200034d8:	0015c210 	xor	$r16,$r16,$r16
   1200034dc:	0015c631 	xor	$r17,$r17,$r17
   1200034e0:	0015ca52 	xor	$r18,$r18,$r18
   1200034e4:	02c051ce 	addi.d	$r14,$r14,20(0x14)

00000001200034e8 <vaddtest_loop>:
   1200034e8:	700bb98c 	vadd.d	$vr12,$vr12,$vr14
   1200034ec:	700bb9ad 	vadd.d	$vr13,$vr13,$vr14
   1200034f0:	700bb9ef 	vadd.d	$vr15,$vr15,$vr14
   1200034f4:	700bba10 	vadd.d	$vr16,$vr16,$vr14
   1200034f8:	700bba31 	vadd.d	$vr17,$vr17,$vr14
   1200034fc:	700bb98c 	vadd.d	$vr12,$vr12,$vr14
   120003500:	700bb9ad 	vadd.d	$vr13,$vr13,$vr14
   120003504:	700bb9ef 	vadd.d	$vr15,$vr15,$vr14
   120003508:	700bba10 	vadd.d	$vr16,$vr16,$vr14
   12000350c:	700bba31 	vadd.d	$vr17,$vr17,$vr14
   120003510:	700bb98c 	vadd.d	$vr12,$vr12,$vr14
   120003514:	700bb9ad 	vadd.d	$vr13,$vr13,$vr14
   120003518:	700bb9ef 	vadd.d	$vr15,$vr15,$vr14
   12000351c:	700bba10 	vadd.d	$vr16,$vr16,$vr14
   120003520:	700bba31 	vadd.d	$vr17,$vr17,$vr14
   120003524:	700bb98c 	vadd.d	$vr12,$vr12,$vr14
   120003528:	700bb9ad 	vadd.d	$vr13,$vr13,$vr14
   12000352c:	700bb9ef 	vadd.d	$vr15,$vr15,$vr14
   120003530:	700bba10 	vadd.d	$vr16,$vr16,$vr14
   120003534:	700bba31 	vadd.d	$vr17,$vr17,$vr14
   120003538:	0011b884 	sub.d	$r4,$r4,$r14
   12000353c:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 1200034e8 <vaddtest_loop>
   120003540:	4c000020 	jirl	$r0,$r1,0

0000000120003544 <vaddlattest>:
   120003544:	0015b9ce 	xor	$r14,$r14,$r14
   120003548:	0015ca52 	xor	$r18,$r18,$r18
   12000354c:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003550 <vaddlattest_loop>:
   120003550:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003554:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003558:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   12000355c:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003560:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003564:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003568:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   12000356c:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003570:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003574:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003578:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   12000357c:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003580:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003584:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003588:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   12000358c:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003590:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003594:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   120003598:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   12000359c:	700bca52 	vadd.d	$vr18,$vr18,$vr18
   1200035a0:	0011b884 	sub.d	$r4,$r4,$r14
   1200035a4:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003550 <vaddlattest_loop>
   1200035a8:	4c000020 	jirl	$r0,$r1,0

00000001200035ac <xaddtest>:
   1200035ac:	0015b9ce 	xor	$r14,$r14,$r14
   1200035b0:	0015b5ad 	xor	$r13,$r13,$r13
   1200035b4:	0015b18c 	xor	$r12,$r12,$r12
   1200035b8:	0015bdef 	xor	$r15,$r15,$r15
   1200035bc:	0015c210 	xor	$r16,$r16,$r16
   1200035c0:	0015c631 	xor	$r17,$r17,$r17
   1200035c4:	0015ca52 	xor	$r18,$r18,$r18
   1200035c8:	02c051ce 	addi.d	$r14,$r14,20(0x14)

00000001200035cc <xaddtest_loop>:
   1200035cc:	740bb98c 	xvadd.d	$xr12,$xr12,$xr14
   1200035d0:	740bb9ad 	xvadd.d	$xr13,$xr13,$xr14
   1200035d4:	740bb9ef 	xvadd.d	$xr15,$xr15,$xr14
   1200035d8:	740bba10 	xvadd.d	$xr16,$xr16,$xr14
   1200035dc:	740bba31 	xvadd.d	$xr17,$xr17,$xr14
   1200035e0:	740bb98c 	xvadd.d	$xr12,$xr12,$xr14
   1200035e4:	740bb9ad 	xvadd.d	$xr13,$xr13,$xr14
   1200035e8:	740bb9ef 	xvadd.d	$xr15,$xr15,$xr14
   1200035ec:	740bba10 	xvadd.d	$xr16,$xr16,$xr14
   1200035f0:	740bba31 	xvadd.d	$xr17,$xr17,$xr14
   1200035f4:	740bb98c 	xvadd.d	$xr12,$xr12,$xr14
   1200035f8:	740bb9ad 	xvadd.d	$xr13,$xr13,$xr14
   1200035fc:	740bb9ef 	xvadd.d	$xr15,$xr15,$xr14
   120003600:	740bba10 	xvadd.d	$xr16,$xr16,$xr14
   120003604:	740bba31 	xvadd.d	$xr17,$xr17,$xr14
   120003608:	740bb98c 	xvadd.d	$xr12,$xr12,$xr14
   12000360c:	740bb9ad 	xvadd.d	$xr13,$xr13,$xr14
   120003610:	740bb9ef 	xvadd.d	$xr15,$xr15,$xr14
   120003614:	740bba10 	xvadd.d	$xr16,$xr16,$xr14
   120003618:	740bba31 	xvadd.d	$xr17,$xr17,$xr14
   12000361c:	0011b884 	sub.d	$r4,$r4,$r14
   120003620:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 1200035cc <xaddtest_loop>
   120003624:	4c000020 	jirl	$r0,$r1,0

0000000120003628 <xaddlattest>:
   120003628:	0015b9ce 	xor	$r14,$r14,$r14
   12000362c:	0015ca52 	xor	$r18,$r18,$r18
   120003630:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003634 <xaddlattest_loop>:
   120003634:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003638:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   12000363c:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003640:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003644:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003648:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   12000364c:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003650:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003654:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003658:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   12000365c:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003660:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003664:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003668:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   12000366c:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003670:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003674:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003678:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   12000367c:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003680:	740bca52 	xvadd.d	$xr18,$xr18,$xr18
   120003684:	0011b884 	sub.d	$r4,$r4,$r14
   120003688:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003634 <xaddlattest_loop>
   12000368c:	4c000020 	jirl	$r0,$r1,0

0000000120003690 <multest>:
   120003690:	0015b9ce 	xor	$r14,$r14,$r14
   120003694:	02c051ce 	addi.d	$r14,$r14,20(0x14)
   120003698:	0015b5ad 	xor	$r13,$r13,$r13
   12000369c:	02c009ad 	addi.d	$r13,$r13,2(0x2)
   1200036a0:	001501ac 	move	$r12,$r13
   1200036a4:	001501af 	move	$r15,$r13
   1200036a8:	001501b0 	move	$r16,$r13
   1200036ac:	001501b1 	move	$r17,$r13
   1200036b0:	001501b2 	move	$r18,$r13
   1200036b4:	001501b3 	move	$r19,$r13
   1200036b8:	001501b4 	move	$r20,$r13
   1200036bc:	001501b5 	move	$r21,$r13
   1200036c0:	001501b6 	move	$r22,$r13
   1200036c4:	001501b7 	move	$r23,$r13

00000001200036c8 <multest_loop>:
   1200036c8:	001db98c 	mul.d	$r12,$r12,$r14
   1200036cc:	001db9ad 	mul.d	$r13,$r13,$r14
   1200036d0:	001db9ef 	mul.d	$r15,$r15,$r14
   1200036d4:	001dba10 	mul.d	$r16,$r16,$r14
   1200036d8:	001dba31 	mul.d	$r17,$r17,$r14
   1200036dc:	001dba52 	mul.d	$r18,$r18,$r14
   1200036e0:	001dba73 	mul.d	$r19,$r19,$r14
   1200036e4:	001dba94 	mul.d	$r20,$r20,$r14
   1200036e8:	001dbab5 	mul.d	$r21,$r21,$r14
   1200036ec:	001dbad6 	mul.d	$r22,$r22,$r14
   1200036f0:	001db98c 	mul.d	$r12,$r12,$r14
   1200036f4:	001db9ad 	mul.d	$r13,$r13,$r14
   1200036f8:	001db9ef 	mul.d	$r15,$r15,$r14
   1200036fc:	001dba10 	mul.d	$r16,$r16,$r14
   120003700:	001dba31 	mul.d	$r17,$r17,$r14
   120003704:	001dba52 	mul.d	$r18,$r18,$r14
   120003708:	001dba73 	mul.d	$r19,$r19,$r14
   12000370c:	001dba94 	mul.d	$r20,$r20,$r14
   120003710:	001dbab5 	mul.d	$r21,$r21,$r14
   120003714:	001dbad6 	mul.d	$r22,$r22,$r14
   120003718:	0011b884 	sub.d	$r4,$r4,$r14
   12000371c:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 1200036c8 <multest_loop>
   120003720:	4c000020 	jirl	$r0,$r1,0

0000000120003724 <mullattest>:
   120003724:	0015b9ce 	xor	$r14,$r14,$r14
   120003728:	0015ca52 	xor	$r18,$r18,$r18
   12000372c:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003730 <mullattest_loop>:
   120003730:	001dca52 	mul.d	$r18,$r18,$r18
   120003734:	001dca52 	mul.d	$r18,$r18,$r18
   120003738:	001dca52 	mul.d	$r18,$r18,$r18
   12000373c:	001dca52 	mul.d	$r18,$r18,$r18
   120003740:	001dca52 	mul.d	$r18,$r18,$r18
   120003744:	001dca52 	mul.d	$r18,$r18,$r18
   120003748:	001dca52 	mul.d	$r18,$r18,$r18
   12000374c:	001dca52 	mul.d	$r18,$r18,$r18
   120003750:	001dca52 	mul.d	$r18,$r18,$r18
   120003754:	001dca52 	mul.d	$r18,$r18,$r18
   120003758:	001dca52 	mul.d	$r18,$r18,$r18
   12000375c:	001dca52 	mul.d	$r18,$r18,$r18
   120003760:	001dca52 	mul.d	$r18,$r18,$r18
   120003764:	001dca52 	mul.d	$r18,$r18,$r18
   120003768:	001dca52 	mul.d	$r18,$r18,$r18
   12000376c:	001dca52 	mul.d	$r18,$r18,$r18
   120003770:	001dca52 	mul.d	$r18,$r18,$r18
   120003774:	001dca52 	mul.d	$r18,$r18,$r18
   120003778:	001dca52 	mul.d	$r18,$r18,$r18
   12000377c:	001dca52 	mul.d	$r18,$r18,$r18
   120003780:	0011b884 	sub.d	$r4,$r4,$r14
   120003784:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003730 <mullattest_loop>
   120003788:	4c000020 	jirl	$r0,$r1,0

000000012000378c <fmultest>:
   12000378c:	0015b9ce 	xor	$r14,$r14,$r14
   120003790:	0015b5ad 	xor	$r13,$r13,$r13
   120003794:	0015b18c 	xor	$r12,$r12,$r12
   120003798:	0015bdef 	xor	$r15,$r15,$r15
   12000379c:	0015c210 	xor	$r16,$r16,$r16
   1200037a0:	0015c631 	xor	$r17,$r17,$r17
   1200037a4:	0015ca52 	xor	$r18,$r18,$r18
   1200037a8:	02c051ce 	addi.d	$r14,$r14,20(0x14)

00000001200037ac <fmultest_loop>:
   1200037ac:	0105398c 	fmul.d	$f12,$f12,$f14
   1200037b0:	010539ad 	fmul.d	$f13,$f13,$f14
   1200037b4:	010539ef 	fmul.d	$f15,$f15,$f14
   1200037b8:	01053a10 	fmul.d	$f16,$f16,$f14
   1200037bc:	01053a31 	fmul.d	$f17,$f17,$f14
   1200037c0:	0105398c 	fmul.d	$f12,$f12,$f14
   1200037c4:	010539ad 	fmul.d	$f13,$f13,$f14
   1200037c8:	010539ef 	fmul.d	$f15,$f15,$f14
   1200037cc:	01053a10 	fmul.d	$f16,$f16,$f14
   1200037d0:	01053a31 	fmul.d	$f17,$f17,$f14
   1200037d4:	0105398c 	fmul.d	$f12,$f12,$f14
   1200037d8:	010539ad 	fmul.d	$f13,$f13,$f14
   1200037dc:	010539ef 	fmul.d	$f15,$f15,$f14
   1200037e0:	01053a10 	fmul.d	$f16,$f16,$f14
   1200037e4:	01053a31 	fmul.d	$f17,$f17,$f14
   1200037e8:	0105398c 	fmul.d	$f12,$f12,$f14
   1200037ec:	010539ad 	fmul.d	$f13,$f13,$f14
   1200037f0:	010539ef 	fmul.d	$f15,$f15,$f14
   1200037f4:	01053a10 	fmul.d	$f16,$f16,$f14
   1200037f8:	01053a31 	fmul.d	$f17,$f17,$f14
   1200037fc:	0011b884 	sub.d	$r4,$r4,$r14
   120003800:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 1200037ac <fmultest_loop>
   120003804:	4c000020 	jirl	$r0,$r1,0

0000000120003808 <fmullattest>:
   120003808:	0015b9ce 	xor	$r14,$r14,$r14
   12000380c:	0015ca52 	xor	$r18,$r18,$r18
   120003810:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003814 <fmullattest_loop>:
   120003814:	01054a52 	fmul.d	$f18,$f18,$f18
   120003818:	01054a52 	fmul.d	$f18,$f18,$f18
   12000381c:	01054a52 	fmul.d	$f18,$f18,$f18
   120003820:	01054a52 	fmul.d	$f18,$f18,$f18
   120003824:	01054a52 	fmul.d	$f18,$f18,$f18
   120003828:	01054a52 	fmul.d	$f18,$f18,$f18
   12000382c:	01054a52 	fmul.d	$f18,$f18,$f18
   120003830:	01054a52 	fmul.d	$f18,$f18,$f18
   120003834:	01054a52 	fmul.d	$f18,$f18,$f18
   120003838:	01054a52 	fmul.d	$f18,$f18,$f18
   12000383c:	01054a52 	fmul.d	$f18,$f18,$f18
   120003840:	01054a52 	fmul.d	$f18,$f18,$f18
   120003844:	01054a52 	fmul.d	$f18,$f18,$f18
   120003848:	01054a52 	fmul.d	$f18,$f18,$f18
   12000384c:	01054a52 	fmul.d	$f18,$f18,$f18
   120003850:	01054a52 	fmul.d	$f18,$f18,$f18
   120003854:	01054a52 	fmul.d	$f18,$f18,$f18
   120003858:	01054a52 	fmul.d	$f18,$f18,$f18
   12000385c:	01054a52 	fmul.d	$f18,$f18,$f18
   120003860:	01054a52 	fmul.d	$f18,$f18,$f18
   120003864:	0011b884 	sub.d	$r4,$r4,$r14
   120003868:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003814 <fmullattest_loop>
   12000386c:	4c000020 	jirl	$r0,$r1,0

0000000120003870 <vmultest>:
   120003870:	0015b9ce 	xor	$r14,$r14,$r14
   120003874:	0015b5ad 	xor	$r13,$r13,$r13
   120003878:	0015b18c 	xor	$r12,$r12,$r12
   12000387c:	0015bdef 	xor	$r15,$r15,$r15
   120003880:	0015c210 	xor	$r16,$r16,$r16
   120003884:	0015c631 	xor	$r17,$r17,$r17
   120003888:	0015ca52 	xor	$r18,$r18,$r18
   12000388c:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003890 <vmultest_loop>:
   120003890:	7085b98c 	vmul.d	$vr12,$vr12,$vr14
   120003894:	7085b9ad 	vmul.d	$vr13,$vr13,$vr14
   120003898:	7085b9ef 	vmul.d	$vr15,$vr15,$vr14
   12000389c:	7085ba10 	vmul.d	$vr16,$vr16,$vr14
   1200038a0:	7085ba31 	vmul.d	$vr17,$vr17,$vr14
   1200038a4:	7085b98c 	vmul.d	$vr12,$vr12,$vr14
   1200038a8:	7085b9ad 	vmul.d	$vr13,$vr13,$vr14
   1200038ac:	7085b9ef 	vmul.d	$vr15,$vr15,$vr14
   1200038b0:	7085ba10 	vmul.d	$vr16,$vr16,$vr14
   1200038b4:	7085ba31 	vmul.d	$vr17,$vr17,$vr14
   1200038b8:	7085b98c 	vmul.d	$vr12,$vr12,$vr14
   1200038bc:	7085b9ad 	vmul.d	$vr13,$vr13,$vr14
   1200038c0:	7085b9ef 	vmul.d	$vr15,$vr15,$vr14
   1200038c4:	7085ba10 	vmul.d	$vr16,$vr16,$vr14
   1200038c8:	7085ba31 	vmul.d	$vr17,$vr17,$vr14
   1200038cc:	7085b98c 	vmul.d	$vr12,$vr12,$vr14
   1200038d0:	7085b9ad 	vmul.d	$vr13,$vr13,$vr14
   1200038d4:	7085b9ef 	vmul.d	$vr15,$vr15,$vr14
   1200038d8:	7085ba10 	vmul.d	$vr16,$vr16,$vr14
   1200038dc:	7085ba31 	vmul.d	$vr17,$vr17,$vr14
   1200038e0:	0011b884 	sub.d	$r4,$r4,$r14
   1200038e4:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003890 <vmultest_loop>
   1200038e8:	4c000020 	jirl	$r0,$r1,0

00000001200038ec <vmullattest>:
   1200038ec:	0015b9ce 	xor	$r14,$r14,$r14
   1200038f0:	0015ca52 	xor	$r18,$r18,$r18
   1200038f4:	02c051ce 	addi.d	$r14,$r14,20(0x14)

00000001200038f8 <vmullattest_loop>:
   1200038f8:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   1200038fc:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003900:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003904:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003908:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   12000390c:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003910:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003914:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003918:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   12000391c:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003920:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003924:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003928:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   12000392c:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003930:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003934:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003938:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   12000393c:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003940:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003944:	7085ca52 	vmul.d	$vr18,$vr18,$vr18
   120003948:	0011b884 	sub.d	$r4,$r4,$r14
   12000394c:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 1200038f8 <vmullattest_loop>
   120003950:	4c000020 	jirl	$r0,$r1,0

0000000120003954 <xmultest>:
   120003954:	0015b9ce 	xor	$r14,$r14,$r14
   120003958:	0015b5ad 	xor	$r13,$r13,$r13
   12000395c:	0015b18c 	xor	$r12,$r12,$r12
   120003960:	0015bdef 	xor	$r15,$r15,$r15
   120003964:	0015c210 	xor	$r16,$r16,$r16
   120003968:	0015c631 	xor	$r17,$r17,$r17
   12000396c:	0015ca52 	xor	$r18,$r18,$r18
   120003970:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003974 <xmultest_loop>:
   120003974:	7485b98c 	xvmul.d	$xr12,$xr12,$xr14
   120003978:	7485b9ad 	xvmul.d	$xr13,$xr13,$xr14
   12000397c:	7485b9ef 	xvmul.d	$xr15,$xr15,$xr14
   120003980:	7485ba10 	xvmul.d	$xr16,$xr16,$xr14
   120003984:	7485ba31 	xvmul.d	$xr17,$xr17,$xr14
   120003988:	7485b98c 	xvmul.d	$xr12,$xr12,$xr14
   12000398c:	7485b9ad 	xvmul.d	$xr13,$xr13,$xr14
   120003990:	7485b9ef 	xvmul.d	$xr15,$xr15,$xr14
   120003994:	7485ba10 	xvmul.d	$xr16,$xr16,$xr14
   120003998:	7485ba31 	xvmul.d	$xr17,$xr17,$xr14
   12000399c:	7485b98c 	xvmul.d	$xr12,$xr12,$xr14
   1200039a0:	7485b9ad 	xvmul.d	$xr13,$xr13,$xr14
   1200039a4:	7485b9ef 	xvmul.d	$xr15,$xr15,$xr14
   1200039a8:	7485ba10 	xvmul.d	$xr16,$xr16,$xr14
   1200039ac:	7485ba31 	xvmul.d	$xr17,$xr17,$xr14
   1200039b0:	7485b98c 	xvmul.d	$xr12,$xr12,$xr14
   1200039b4:	7485b9ad 	xvmul.d	$xr13,$xr13,$xr14
   1200039b8:	7485b9ef 	xvmul.d	$xr15,$xr15,$xr14
   1200039bc:	7485ba10 	xvmul.d	$xr16,$xr16,$xr14
   1200039c0:	7485ba31 	xvmul.d	$xr17,$xr17,$xr14
   1200039c4:	0011b884 	sub.d	$r4,$r4,$r14
   1200039c8:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003974 <xmultest_loop>
   1200039cc:	4c000020 	jirl	$r0,$r1,0

00000001200039d0 <xmullattest>:
   1200039d0:	0015b9ce 	xor	$r14,$r14,$r14
   1200039d4:	0015ca52 	xor	$r18,$r18,$r18
   1200039d8:	02c051ce 	addi.d	$r14,$r14,20(0x14)

00000001200039dc <xmullattest_loop>:
   1200039dc:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   1200039e0:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   1200039e4:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   1200039e8:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   1200039ec:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   1200039f0:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   1200039f4:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   1200039f8:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   1200039fc:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a00:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a04:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a08:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a0c:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a10:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a14:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a18:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a1c:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a20:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a24:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a28:	7485ca52 	xvmul.d	$xr18,$xr18,$xr18
   120003a2c:	0011b884 	sub.d	$r4,$r4,$r14
   120003a30:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 1200039dc <xmullattest_loop>
   120003a34:	4c000020 	jirl	$r0,$r1,0

0000000120003a38 <divtest>:
   120003a38:	0015b9ce 	xor	$r14,$r14,$r14
   120003a3c:	02c051ce 	addi.d	$r14,$r14,20(0x14)
   120003a40:	0015ca52 	xor	$r18,$r18,$r18
   120003a44:	02cfff18 	addi.d	$r24,$r24,1023(0x3ff)
   120003a48:	02c00af7 	addi.d	$r23,$r23,2(0x2)
   120003a4c:	02c00f39 	addi.d	$r25,$r25,3(0x3)
   120003a50:	02c01b5a 	addi.d	$r26,$r26,6(0x6)
   120003a54:	02c02f7b 	addi.d	$r27,$r27,11(0xb)
   120003a58:	02c0339c 	addi.d	$r28,$r28,12(0xc)
   120003a5c:	02c04fbd 	addi.d	$r29,$r29,19(0x13)
   120003a60:	02c053de 	addi.d	$r30,$r30,20(0x14)
   120003a64:	02c067ff 	addi.d	$r31,$r31,25(0x19)

0000000120003a68 <divtest_loop>:
   120003a68:	00225f0c 	div.d	$r12,$r24,$r23
   120003a6c:	0022670d 	div.d	$r13,$r24,$r25
   120003a70:	00226b0f 	div.d	$r15,$r24,$r26
   120003a74:	00226f10 	div.d	$r16,$r24,$r27
   120003a78:	00227311 	div.d	$r17,$r24,$r28
   120003a7c:	00227b13 	div.d	$r19,$r24,$r30
   120003a80:	00227f14 	div.d	$r20,$r24,$r31
   120003a84:	00225f0c 	div.d	$r12,$r24,$r23
   120003a88:	0022670d 	div.d	$r13,$r24,$r25
   120003a8c:	00226b0f 	div.d	$r15,$r24,$r26
   120003a90:	00226f10 	div.d	$r16,$r24,$r27
   120003a94:	00227311 	div.d	$r17,$r24,$r28
   120003a98:	00227b13 	div.d	$r19,$r24,$r30
   120003a9c:	00227f14 	div.d	$r20,$r24,$r31
   120003aa0:	00225f0c 	div.d	$r12,$r24,$r23
   120003aa4:	0022670d 	div.d	$r13,$r24,$r25
   120003aa8:	00226b0f 	div.d	$r15,$r24,$r26
   120003aac:	00226f10 	div.d	$r16,$r24,$r27
   120003ab0:	00227311 	div.d	$r17,$r24,$r28
   120003ab4:	00227b13 	div.d	$r19,$r24,$r30
   120003ab8:	00227f14 	div.d	$r20,$r24,$r31
   120003abc:	0011b884 	sub.d	$r4,$r4,$r14
   120003ac0:	67ffa892 	bge	$r4,$r18,-88(0x3ffa8) # 120003a68 <divtest_loop>
   120003ac4:	4c000020 	jirl	$r0,$r1,0

0000000120003ac8 <divlattest>:
   120003ac8:	0015b9ce 	xor	$r14,$r14,$r14
   120003acc:	0015ca52 	xor	$r18,$r18,$r18
   120003ad0:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003ad4 <divlattest_loop>:
   120003ad4:	00224a52 	div.d	$r18,$r18,$r18
   120003ad8:	00224a52 	div.d	$r18,$r18,$r18
   120003adc:	00224a52 	div.d	$r18,$r18,$r18
   120003ae0:	00224a52 	div.d	$r18,$r18,$r18
   120003ae4:	00224a52 	div.d	$r18,$r18,$r18
   120003ae8:	00224a52 	div.d	$r18,$r18,$r18
   120003aec:	00224a52 	div.d	$r18,$r18,$r18
   120003af0:	00224a52 	div.d	$r18,$r18,$r18
   120003af4:	00224a52 	div.d	$r18,$r18,$r18
   120003af8:	00224a52 	div.d	$r18,$r18,$r18
   120003afc:	00224a52 	div.d	$r18,$r18,$r18
   120003b00:	00224a52 	div.d	$r18,$r18,$r18
   120003b04:	00224a52 	div.d	$r18,$r18,$r18
   120003b08:	00224a52 	div.d	$r18,$r18,$r18
   120003b0c:	00224a52 	div.d	$r18,$r18,$r18
   120003b10:	00224a52 	div.d	$r18,$r18,$r18
   120003b14:	00224a52 	div.d	$r18,$r18,$r18
   120003b18:	00224a52 	div.d	$r18,$r18,$r18
   120003b1c:	00224a52 	div.d	$r18,$r18,$r18
   120003b20:	00224a52 	div.d	$r18,$r18,$r18
   120003b24:	0011b884 	sub.d	$r4,$r4,$r14
   120003b28:	67ff4092 	bge	$r4,$r18,-192(0x3ff40) # 120003a68 <divtest_loop>
   120003b2c:	4c000020 	jirl	$r0,$r1,0

0000000120003b30 <fdivtest>:
   120003b30:	0015b9ce 	xor	$r14,$r14,$r14
   120003b34:	0015b5ad 	xor	$r13,$r13,$r13
   120003b38:	0015b18c 	xor	$r12,$r12,$r12
   120003b3c:	0015bdef 	xor	$r15,$r15,$r15
   120003b40:	0015c210 	xor	$r16,$r16,$r16
   120003b44:	0015c631 	xor	$r17,$r17,$r17
   120003b48:	0015ca52 	xor	$r18,$r18,$r18
   120003b4c:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003b50 <fdivtest_loop>:
   120003b50:	0107398c 	fdiv.d	$f12,$f12,$f14
   120003b54:	010739ad 	fdiv.d	$f13,$f13,$f14
   120003b58:	010739ef 	fdiv.d	$f15,$f15,$f14
   120003b5c:	01073a10 	fdiv.d	$f16,$f16,$f14
   120003b60:	01073a31 	fdiv.d	$f17,$f17,$f14
   120003b64:	0107398c 	fdiv.d	$f12,$f12,$f14
   120003b68:	010739ad 	fdiv.d	$f13,$f13,$f14
   120003b6c:	010739ef 	fdiv.d	$f15,$f15,$f14
   120003b70:	01073a10 	fdiv.d	$f16,$f16,$f14
   120003b74:	01073a31 	fdiv.d	$f17,$f17,$f14
   120003b78:	0107398c 	fdiv.d	$f12,$f12,$f14
   120003b7c:	010739ad 	fdiv.d	$f13,$f13,$f14
   120003b80:	010739ef 	fdiv.d	$f15,$f15,$f14
   120003b84:	01073a10 	fdiv.d	$f16,$f16,$f14
   120003b88:	01073a31 	fdiv.d	$f17,$f17,$f14
   120003b8c:	0107398c 	fdiv.d	$f12,$f12,$f14
   120003b90:	010739ad 	fdiv.d	$f13,$f13,$f14
   120003b94:	010739ef 	fdiv.d	$f15,$f15,$f14
   120003b98:	01073a10 	fdiv.d	$f16,$f16,$f14
   120003b9c:	01073a31 	fdiv.d	$f17,$f17,$f14
   120003ba0:	0011b884 	sub.d	$r4,$r4,$r14
   120003ba4:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003b50 <fdivtest_loop>
   120003ba8:	4c000020 	jirl	$r0,$r1,0

0000000120003bac <fdivlattest>:
   120003bac:	0015b9ce 	xor	$r14,$r14,$r14
   120003bb0:	0015ca52 	xor	$r18,$r18,$r18
   120003bb4:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003bb8 <fdivlattest_loop>:
   120003bb8:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bbc:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bc0:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bc4:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bc8:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bcc:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bd0:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bd4:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bd8:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bdc:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003be0:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003be4:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003be8:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bec:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bf0:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bf4:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bf8:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003bfc:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003c00:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003c04:	01074a52 	fdiv.d	$f18,$f18,$f18
   120003c08:	0011b884 	sub.d	$r4,$r4,$r14
   120003c0c:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003bb8 <fdivlattest_loop>
   120003c10:	4c000020 	jirl	$r0,$r1,0

0000000120003c14 <fadd_fmultest>:
   120003c14:	0015b9ce 	xor	$r14,$r14,$r14
   120003c18:	0015b5ad 	xor	$r13,$r13,$r13
   120003c1c:	0015b18c 	xor	$r12,$r12,$r12
   120003c20:	0015bdef 	xor	$r15,$r15,$r15
   120003c24:	0015c210 	xor	$r16,$r16,$r16
   120003c28:	0015c631 	xor	$r17,$r17,$r17
   120003c2c:	0015ca52 	xor	$r18,$r18,$r18
   120003c30:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003c34 <fadd_fmultest_loop>:
   120003c34:	0101398c 	fadd.d	$f12,$f12,$f14
   120003c38:	010539ad 	fmul.d	$f13,$f13,$f14
   120003c3c:	010139ef 	fadd.d	$f15,$f15,$f14
   120003c40:	01053a10 	fmul.d	$f16,$f16,$f14
   120003c44:	01013a31 	fadd.d	$f17,$f17,$f14
   120003c48:	01053a52 	fmul.d	$f18,$f18,$f14
   120003c4c:	01013a73 	fadd.d	$f19,$f19,$f14
   120003c50:	01053a94 	fmul.d	$f20,$f20,$f14
   120003c54:	01013ab5 	fadd.d	$f21,$f21,$f14
   120003c58:	01053ad6 	fmul.d	$f22,$f22,$f14
   120003c5c:	0101398c 	fadd.d	$f12,$f12,$f14
   120003c60:	010539ad 	fmul.d	$f13,$f13,$f14
   120003c64:	010139ef 	fadd.d	$f15,$f15,$f14
   120003c68:	01053a10 	fmul.d	$f16,$f16,$f14
   120003c6c:	01013a31 	fadd.d	$f17,$f17,$f14
   120003c70:	01053a52 	fmul.d	$f18,$f18,$f14
   120003c74:	01013a73 	fadd.d	$f19,$f19,$f14
   120003c78:	01053a94 	fmul.d	$f20,$f20,$f14
   120003c7c:	01013ab5 	fadd.d	$f21,$f21,$f14
   120003c80:	01053ad6 	fmul.d	$f22,$f22,$f14
   120003c84:	0011b884 	sub.d	$r4,$r4,$r14
   120003c88:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003c34 <fadd_fmultest_loop>
   120003c8c:	4c000020 	jirl	$r0,$r1,0

0000000120003c90 <fadd_multest>:
   120003c90:	0015b9ce 	xor	$r14,$r14,$r14
   120003c94:	0015b5ad 	xor	$r13,$r13,$r13
   120003c98:	0015b18c 	xor	$r12,$r12,$r12
   120003c9c:	0015bdef 	xor	$r15,$r15,$r15
   120003ca0:	0015c210 	xor	$r16,$r16,$r16
   120003ca4:	0015c631 	xor	$r17,$r17,$r17
   120003ca8:	0015ca52 	xor	$r18,$r18,$r18
   120003cac:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003cb0 <fadd_multest_loop>:
   120003cb0:	0101398c 	fadd.d	$f12,$f12,$f14
   120003cb4:	001db98c 	mul.d	$r12,$r12,$r14
   120003cb8:	010139ad 	fadd.d	$f13,$f13,$f14
   120003cbc:	001db9ad 	mul.d	$r13,$r13,$r14
   120003cc0:	010139ef 	fadd.d	$f15,$f15,$f14
   120003cc4:	001db9ef 	mul.d	$r15,$r15,$r14
   120003cc8:	01013a10 	fadd.d	$f16,$f16,$f14
   120003ccc:	001dba10 	mul.d	$r16,$r16,$r14
   120003cd0:	01013a31 	fadd.d	$f17,$f17,$f14
   120003cd4:	001dba31 	mul.d	$r17,$r17,$r14
   120003cd8:	0101398c 	fadd.d	$f12,$f12,$f14
   120003cdc:	001db98c 	mul.d	$r12,$r12,$r14
   120003ce0:	010139ad 	fadd.d	$f13,$f13,$f14
   120003ce4:	001db9ad 	mul.d	$r13,$r13,$r14
   120003ce8:	010139ef 	fadd.d	$f15,$f15,$f14
   120003cec:	001db9ef 	mul.d	$r15,$r15,$r14
   120003cf0:	01013a10 	fadd.d	$f16,$f16,$f14
   120003cf4:	001dba10 	mul.d	$r16,$r16,$r14
   120003cf8:	01013a31 	fadd.d	$f17,$f17,$f14
   120003cfc:	001dba31 	mul.d	$r17,$r17,$r14
   120003d00:	0011b884 	sub.d	$r4,$r4,$r14
   120003d04:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003cb0 <fadd_multest_loop>
   120003d08:	4c000020 	jirl	$r0,$r1,0

0000000120003d0c <fadd_mul_multest>:
   120003d0c:	0015b9ce 	xor	$r14,$r14,$r14
   120003d10:	0015b5ad 	xor	$r13,$r13,$r13
   120003d14:	0015b18c 	xor	$r12,$r12,$r12
   120003d18:	0015bdef 	xor	$r15,$r15,$r15
   120003d1c:	0015c210 	xor	$r16,$r16,$r16
   120003d20:	0015c631 	xor	$r17,$r17,$r17
   120003d24:	0015ca52 	xor	$r18,$r18,$r18
   120003d28:	0015ce73 	xor	$r19,$r19,$r19
   120003d2c:	0015d294 	xor	$r20,$r20,$r20
   120003d30:	02c061ce 	addi.d	$r14,$r14,24(0x18)

0000000120003d34 <fadd_mul_multest_loop>:
   120003d34:	0101398c 	fadd.d	$f12,$f12,$f14
   120003d38:	001db98c 	mul.d	$r12,$r12,$r14
   120003d3c:	001db9ad 	mul.d	$r13,$r13,$r14
   120003d40:	010139ad 	fadd.d	$f13,$f13,$f14
   120003d44:	001db9ef 	mul.d	$r15,$r15,$r14
   120003d48:	001dba10 	mul.d	$r16,$r16,$r14
   120003d4c:	010139ef 	fadd.d	$f15,$f15,$f14
   120003d50:	001dba31 	mul.d	$r17,$r17,$r14
   120003d54:	001dba52 	mul.d	$r18,$r18,$r14
   120003d58:	01013a10 	fadd.d	$f16,$f16,$f14
   120003d5c:	001dba73 	mul.d	$r19,$r19,$r14
   120003d60:	001dba94 	mul.d	$r20,$r20,$r14
   120003d64:	0101398c 	fadd.d	$f12,$f12,$f14
   120003d68:	001db98c 	mul.d	$r12,$r12,$r14
   120003d6c:	001db9ad 	mul.d	$r13,$r13,$r14
   120003d70:	010139ad 	fadd.d	$f13,$f13,$f14
   120003d74:	001db9ef 	mul.d	$r15,$r15,$r14
   120003d78:	001dba10 	mul.d	$r16,$r16,$r14
   120003d7c:	010139ef 	fadd.d	$f15,$f15,$f14
   120003d80:	001dba31 	mul.d	$r17,$r17,$r14
   120003d84:	001dba52 	mul.d	$r18,$r18,$r14
   120003d88:	01013a10 	fadd.d	$f16,$f16,$f14
   120003d8c:	001dba73 	mul.d	$r19,$r19,$r14
   120003d90:	001dba94 	mul.d	$r20,$r20,$r14
   120003d94:	0011b884 	sub.d	$r4,$r4,$r14
   120003d98:	67ff9c80 	bge	$r4,$r0,-100(0x3ff9c) # 120003d34 <fadd_mul_multest_loop>
   120003d9c:	4c000020 	jirl	$r0,$r1,0

0000000120003da0 <fadd_fmul_fmultest>:
   120003da0:	0015b9ce 	xor	$r14,$r14,$r14
   120003da4:	0015b5ad 	xor	$r13,$r13,$r13
   120003da8:	0015b18c 	xor	$r12,$r12,$r12
   120003dac:	0015bdef 	xor	$r15,$r15,$r15
   120003db0:	0015c210 	xor	$r16,$r16,$r16
   120003db4:	0015c631 	xor	$r17,$r17,$r17
   120003db8:	0015ca52 	xor	$r18,$r18,$r18
   120003dbc:	0015ce73 	xor	$r19,$r19,$r19
   120003dc0:	0015d294 	xor	$r20,$r20,$r20
   120003dc4:	02c061ce 	addi.d	$r14,$r14,24(0x18)

0000000120003dc8 <fadd_fmul_fmultest_loop>:
   120003dc8:	0101398c 	fadd.d	$f12,$f12,$f14
   120003dcc:	010539ad 	fmul.d	$f13,$f13,$f14
   120003dd0:	010539ef 	fmul.d	$f15,$f15,$f14
   120003dd4:	01013a10 	fadd.d	$f16,$f16,$f14
   120003dd8:	01053a31 	fmul.d	$f17,$f17,$f14
   120003ddc:	01053a52 	fmul.d	$f18,$f18,$f14
   120003de0:	01013a73 	fadd.d	$f19,$f19,$f14
   120003de4:	01053a94 	fmul.d	$f20,$f20,$f14
   120003de8:	01053ab5 	fmul.d	$f21,$f21,$f14
   120003dec:	0101398c 	fadd.d	$f12,$f12,$f14
   120003df0:	010539ad 	fmul.d	$f13,$f13,$f14
   120003df4:	010539ef 	fmul.d	$f15,$f15,$f14
   120003df8:	01013a10 	fadd.d	$f16,$f16,$f14
   120003dfc:	01053a31 	fmul.d	$f17,$f17,$f14
   120003e00:	01053a52 	fmul.d	$f18,$f18,$f14
   120003e04:	01013a73 	fadd.d	$f19,$f19,$f14
   120003e08:	01053a94 	fmul.d	$f20,$f20,$f14
   120003e0c:	01053ab5 	fmul.d	$f21,$f21,$f14
   120003e10:	0101398c 	fadd.d	$f12,$f12,$f14
   120003e14:	010539ad 	fmul.d	$f13,$f13,$f14
   120003e18:	010539ef 	fmul.d	$f15,$f15,$f14
   120003e1c:	01013a10 	fadd.d	$f16,$f16,$f14
   120003e20:	01053a31 	fmul.d	$f17,$f17,$f14
   120003e24:	01053a52 	fmul.d	$f18,$f18,$f14
   120003e28:	01013a73 	fadd.d	$f19,$f19,$f14
   120003e2c:	01053a94 	fmul.d	$f20,$f20,$f14
   120003e30:	01053ab5 	fmul.d	$f21,$f21,$f14
   120003e34:	0011b884 	sub.d	$r4,$r4,$r14
   120003e38:	67ff9092 	bge	$r4,$r18,-112(0x3ff90) # 120003dc8 <fadd_fmul_fmultest_loop>
   120003e3c:	4c000020 	jirl	$r0,$r1,0

0000000120003e40 <fmatest>:
   120003e40:	0015b9ce 	xor	$r14,$r14,$r14
   120003e44:	0015b5ad 	xor	$r13,$r13,$r13
   120003e48:	0015b18c 	xor	$r12,$r12,$r12
   120003e4c:	0015bdef 	xor	$r15,$r15,$r15
   120003e50:	0015c210 	xor	$r16,$r16,$r16
   120003e54:	0015c631 	xor	$r17,$r17,$r17
   120003e58:	0015ca52 	xor	$r18,$r18,$r18
   120003e5c:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003e60 <fmatest_loop>:
   120003e60:	0827398c 	fmadd.d	$f12,$f12,$f14,$f14
   120003e64:	082739ad 	fmadd.d	$f13,$f13,$f14,$f14
   120003e68:	082739ef 	fmadd.d	$f15,$f15,$f14,$f14
   120003e6c:	08273a10 	fmadd.d	$f16,$f16,$f14,$f14
   120003e70:	08273a31 	fmadd.d	$f17,$f17,$f14,$f14
   120003e74:	0827398c 	fmadd.d	$f12,$f12,$f14,$f14
   120003e78:	082739ad 	fmadd.d	$f13,$f13,$f14,$f14
   120003e7c:	082739ef 	fmadd.d	$f15,$f15,$f14,$f14
   120003e80:	08273a10 	fmadd.d	$f16,$f16,$f14,$f14
   120003e84:	08273a31 	fmadd.d	$f17,$f17,$f14,$f14
   120003e88:	0827398c 	fmadd.d	$f12,$f12,$f14,$f14
   120003e8c:	082739ad 	fmadd.d	$f13,$f13,$f14,$f14
   120003e90:	082739ef 	fmadd.d	$f15,$f15,$f14,$f14
   120003e94:	08273a10 	fmadd.d	$f16,$f16,$f14,$f14
   120003e98:	08273a31 	fmadd.d	$f17,$f17,$f14,$f14
   120003e9c:	0827398c 	fmadd.d	$f12,$f12,$f14,$f14
   120003ea0:	082739ad 	fmadd.d	$f13,$f13,$f14,$f14
   120003ea4:	082739ef 	fmadd.d	$f15,$f15,$f14,$f14
   120003ea8:	08273a10 	fmadd.d	$f16,$f16,$f14,$f14
   120003eac:	08273a31 	fmadd.d	$f17,$f17,$f14,$f14
   120003eb0:	0011b884 	sub.d	$r4,$r4,$r14
   120003eb4:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003e60 <fmatest_loop>
   120003eb8:	4c000020 	jirl	$r0,$r1,0

0000000120003ebc <fmalattest>:
   120003ebc:	0015b9ce 	xor	$r14,$r14,$r14
   120003ec0:	0015ca52 	xor	$r18,$r18,$r18
   120003ec4:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003ec8 <fmalattest_loop>:
   120003ec8:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003ecc:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003ed0:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003ed4:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003ed8:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003edc:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003ee0:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003ee4:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003ee8:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003eec:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003ef0:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003ef4:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003ef8:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003efc:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003f00:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003f04:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003f08:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003f0c:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003f10:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003f14:	08294a52 	fmadd.d	$f18,$f18,$f18,$f18
   120003f18:	0011b884 	sub.d	$r4,$r4,$r14
   120003f1c:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003ec8 <fmalattest_loop>
   120003f20:	4c000020 	jirl	$r0,$r1,0

0000000120003f24 <vfmatest>:
   120003f24:	0015b9ce 	xor	$r14,$r14,$r14
   120003f28:	0015b5ad 	xor	$r13,$r13,$r13
   120003f2c:	0015b18c 	xor	$r12,$r12,$r12
   120003f30:	0015bdef 	xor	$r15,$r15,$r15
   120003f34:	0015c210 	xor	$r16,$r16,$r16
   120003f38:	0015c631 	xor	$r17,$r17,$r17
   120003f3c:	0015ca52 	xor	$r18,$r18,$r18
   120003f40:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003f44 <vfmatest_loop>:
   120003f44:	0927398c 	vfmadd.d	$vr12,$vr12,$vr14,$vr14
   120003f48:	092739ad 	vfmadd.d	$vr13,$vr13,$vr14,$vr14
   120003f4c:	092739ef 	vfmadd.d	$vr15,$vr15,$vr14,$vr14
   120003f50:	09273a10 	vfmadd.d	$vr16,$vr16,$vr14,$vr14
   120003f54:	09273a31 	vfmadd.d	$vr17,$vr17,$vr14,$vr14
   120003f58:	0927398c 	vfmadd.d	$vr12,$vr12,$vr14,$vr14
   120003f5c:	092739ad 	vfmadd.d	$vr13,$vr13,$vr14,$vr14
   120003f60:	092739ef 	vfmadd.d	$vr15,$vr15,$vr14,$vr14
   120003f64:	09273a10 	vfmadd.d	$vr16,$vr16,$vr14,$vr14
   120003f68:	09273a31 	vfmadd.d	$vr17,$vr17,$vr14,$vr14
   120003f6c:	0927398c 	vfmadd.d	$vr12,$vr12,$vr14,$vr14
   120003f70:	092739ad 	vfmadd.d	$vr13,$vr13,$vr14,$vr14
   120003f74:	092739ef 	vfmadd.d	$vr15,$vr15,$vr14,$vr14
   120003f78:	09273a10 	vfmadd.d	$vr16,$vr16,$vr14,$vr14
   120003f7c:	09273a31 	vfmadd.d	$vr17,$vr17,$vr14,$vr14
   120003f80:	0927398c 	vfmadd.d	$vr12,$vr12,$vr14,$vr14
   120003f84:	092739ad 	vfmadd.d	$vr13,$vr13,$vr14,$vr14
   120003f88:	092739ef 	vfmadd.d	$vr15,$vr15,$vr14,$vr14
   120003f8c:	09273a10 	vfmadd.d	$vr16,$vr16,$vr14,$vr14
   120003f90:	09273a31 	vfmadd.d	$vr17,$vr17,$vr14,$vr14
   120003f94:	0011b884 	sub.d	$r4,$r4,$r14
   120003f98:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003f44 <vfmatest_loop>
   120003f9c:	4c000020 	jirl	$r0,$r1,0

0000000120003fa0 <vfmalattest>:
   120003fa0:	0015b9ce 	xor	$r14,$r14,$r14
   120003fa4:	0015ca52 	xor	$r18,$r18,$r18
   120003fa8:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120003fac <vfmalattest_loop>:
   120003fac:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fb0:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fb4:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fb8:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fbc:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fc0:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fc4:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fc8:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fcc:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fd0:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fd4:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fd8:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fdc:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fe0:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fe4:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fe8:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003fec:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003ff0:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003ff4:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003ff8:	09294a52 	vfmadd.d	$vr18,$vr18,$vr18,$vr18
   120003ffc:	0011b884 	sub.d	$r4,$r4,$r14
   120004000:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120003fac <vfmalattest_loop>
   120004004:	4c000020 	jirl	$r0,$r1,0

0000000120004008 <xfmatest>:
   120004008:	0015b9ce 	xor	$r14,$r14,$r14
   12000400c:	0015b5ad 	xor	$r13,$r13,$r13
   120004010:	0015b18c 	xor	$r12,$r12,$r12
   120004014:	0015bdef 	xor	$r15,$r15,$r15
   120004018:	0015c210 	xor	$r16,$r16,$r16
   12000401c:	0015c631 	xor	$r17,$r17,$r17
   120004020:	0015ca52 	xor	$r18,$r18,$r18
   120004024:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120004028 <xfmatest_loop>:
   120004028:	0a27398c 	xvfmadd.d	$xr12,$xr12,$xr14,$xr14
   12000402c:	0a2739ad 	xvfmadd.d	$xr13,$xr13,$xr14,$xr14
   120004030:	0a2739ef 	xvfmadd.d	$xr15,$xr15,$xr14,$xr14
   120004034:	0a273a10 	xvfmadd.d	$xr16,$xr16,$xr14,$xr14
   120004038:	0a273a31 	xvfmadd.d	$xr17,$xr17,$xr14,$xr14
   12000403c:	0a27398c 	xvfmadd.d	$xr12,$xr12,$xr14,$xr14
   120004040:	0a2739ad 	xvfmadd.d	$xr13,$xr13,$xr14,$xr14
   120004044:	0a2739ef 	xvfmadd.d	$xr15,$xr15,$xr14,$xr14
   120004048:	0a273a10 	xvfmadd.d	$xr16,$xr16,$xr14,$xr14
   12000404c:	0a273a31 	xvfmadd.d	$xr17,$xr17,$xr14,$xr14
   120004050:	0a27398c 	xvfmadd.d	$xr12,$xr12,$xr14,$xr14
   120004054:	0a2739ad 	xvfmadd.d	$xr13,$xr13,$xr14,$xr14
   120004058:	0a2739ef 	xvfmadd.d	$xr15,$xr15,$xr14,$xr14
   12000405c:	0a273a10 	xvfmadd.d	$xr16,$xr16,$xr14,$xr14
   120004060:	0a273a31 	xvfmadd.d	$xr17,$xr17,$xr14,$xr14
   120004064:	0a27398c 	xvfmadd.d	$xr12,$xr12,$xr14,$xr14
   120004068:	0a2739ad 	xvfmadd.d	$xr13,$xr13,$xr14,$xr14
   12000406c:	0a2739ef 	xvfmadd.d	$xr15,$xr15,$xr14,$xr14
   120004070:	0a273a10 	xvfmadd.d	$xr16,$xr16,$xr14,$xr14
   120004074:	0a273a31 	xvfmadd.d	$xr17,$xr17,$xr14,$xr14
   120004078:	0011b884 	sub.d	$r4,$r4,$r14
   12000407c:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120004028 <xfmatest_loop>
   120004080:	4c000020 	jirl	$r0,$r1,0

0000000120004084 <xfmalattest>:
   120004084:	0015b9ce 	xor	$r14,$r14,$r14
   120004088:	0015ca52 	xor	$r18,$r18,$r18
   12000408c:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120004090 <xfmalattest_loop>:
   120004090:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   120004094:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   120004098:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   12000409c:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040a0:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040a4:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040a8:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040ac:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040b0:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040b4:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040b8:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040bc:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040c0:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040c4:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040c8:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040cc:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040d0:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040d4:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040d8:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040dc:	0a294a52 	xvfmadd.d	$xr18,$xr18,$xr18,$xr18
   1200040e0:	0011b884 	sub.d	$r4,$r4,$r14
   1200040e4:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120004090 <xfmalattest_loop>
   1200040e8:	4c000020 	jirl	$r0,$r1,0

00000001200040ec <fma_faddtest>:
   1200040ec:	0015b9ce 	xor	$r14,$r14,$r14
   1200040f0:	0015b5ad 	xor	$r13,$r13,$r13
   1200040f4:	0015b18c 	xor	$r12,$r12,$r12
   1200040f8:	0015bdef 	xor	$r15,$r15,$r15
   1200040fc:	0015c210 	xor	$r16,$r16,$r16
   120004100:	0015c631 	xor	$r17,$r17,$r17
   120004104:	0015ca52 	xor	$r18,$r18,$r18
   120004108:	02c051ce 	addi.d	$r14,$r14,20(0x14)

000000012000410c <fma_faddtest_loop>:
   12000410c:	0827398c 	fmadd.d	$f12,$f12,$f14,$f14
   120004110:	010139ad 	fadd.d	$f13,$f13,$f14
   120004114:	082739ef 	fmadd.d	$f15,$f15,$f14,$f14
   120004118:	01013a10 	fadd.d	$f16,$f16,$f14
   12000411c:	08273a31 	fmadd.d	$f17,$f17,$f14,$f14
   120004120:	01013a52 	fadd.d	$f18,$f18,$f14
   120004124:	08273a73 	fmadd.d	$f19,$f19,$f14,$f14
   120004128:	01013a94 	fadd.d	$f20,$f20,$f14
   12000412c:	08273ab5 	fmadd.d	$f21,$f21,$f14,$f14
   120004130:	01013ad6 	fadd.d	$f22,$f22,$f14
   120004134:	0827398c 	fmadd.d	$f12,$f12,$f14,$f14
   120004138:	010139ad 	fadd.d	$f13,$f13,$f14
   12000413c:	082739ef 	fmadd.d	$f15,$f15,$f14,$f14
   120004140:	01013a10 	fadd.d	$f16,$f16,$f14
   120004144:	08273a31 	fmadd.d	$f17,$f17,$f14,$f14
   120004148:	01013a52 	fadd.d	$f18,$f18,$f14
   12000414c:	08273a73 	fmadd.d	$f19,$f19,$f14,$f14
   120004150:	01013a94 	fadd.d	$f20,$f20,$f14
   120004154:	08273ab5 	fmadd.d	$f21,$f21,$f14,$f14
   120004158:	01013ad6 	fadd.d	$f22,$f22,$f14
   12000415c:	0011b884 	sub.d	$r4,$r4,$r14
   120004160:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 12000410c <fma_faddtest_loop>
   120004164:	4c000020 	jirl	$r0,$r1,0

0000000120004168 <fma_fmultest>:
   120004168:	0015b9ce 	xor	$r14,$r14,$r14
   12000416c:	0015b5ad 	xor	$r13,$r13,$r13
   120004170:	0015b18c 	xor	$r12,$r12,$r12
   120004174:	0015bdef 	xor	$r15,$r15,$r15
   120004178:	0015c210 	xor	$r16,$r16,$r16
   12000417c:	0015c631 	xor	$r17,$r17,$r17
   120004180:	0015ca52 	xor	$r18,$r18,$r18
   120004184:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120004188 <fma_fmultest_loop>:
   120004188:	0827398c 	fmadd.d	$f12,$f12,$f14,$f14
   12000418c:	010539ad 	fmul.d	$f13,$f13,$f14
   120004190:	082739ef 	fmadd.d	$f15,$f15,$f14,$f14
   120004194:	01053a10 	fmul.d	$f16,$f16,$f14
   120004198:	08273a31 	fmadd.d	$f17,$f17,$f14,$f14
   12000419c:	01053a52 	fmul.d	$f18,$f18,$f14
   1200041a0:	08273a73 	fmadd.d	$f19,$f19,$f14,$f14
   1200041a4:	01053a94 	fmul.d	$f20,$f20,$f14
   1200041a8:	08273ab5 	fmadd.d	$f21,$f21,$f14,$f14
   1200041ac:	01053ad6 	fmul.d	$f22,$f22,$f14
   1200041b0:	0827398c 	fmadd.d	$f12,$f12,$f14,$f14
   1200041b4:	010539ad 	fmul.d	$f13,$f13,$f14
   1200041b8:	082739ef 	fmadd.d	$f15,$f15,$f14,$f14
   1200041bc:	01053a10 	fmul.d	$f16,$f16,$f14
   1200041c0:	08273a31 	fmadd.d	$f17,$f17,$f14,$f14
   1200041c4:	01053a52 	fmul.d	$f18,$f18,$f14
   1200041c8:	08273a73 	fmadd.d	$f19,$f19,$f14,$f14
   1200041cc:	01053a94 	fmul.d	$f20,$f20,$f14
   1200041d0:	08273ab5 	fmadd.d	$f21,$f21,$f14,$f14
   1200041d4:	01053ad6 	fmul.d	$f22,$f22,$f14
   1200041d8:	0011b884 	sub.d	$r4,$r4,$r14
   1200041dc:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120004188 <fma_fmultest_loop>
   1200041e0:	4c000020 	jirl	$r0,$r1,0

00000001200041e4 <fma_fmul_faddtest>:
   1200041e4:	0015b9ce 	xor	$r14,$r14,$r14
   1200041e8:	0015b5ad 	xor	$r13,$r13,$r13
   1200041ec:	0015b18c 	xor	$r12,$r12,$r12
   1200041f0:	0015bdef 	xor	$r15,$r15,$r15
   1200041f4:	0015c210 	xor	$r16,$r16,$r16
   1200041f8:	0015c631 	xor	$r17,$r17,$r17
   1200041fc:	0015ca52 	xor	$r18,$r18,$r18
   120004200:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120004204 <fma_fmul_faddtest_loop>:
   120004204:	0827398c 	fmadd.d	$f12,$f12,$f14,$f14
   120004208:	010539ad 	fmul.d	$f13,$f13,$f14
   12000420c:	010139ef 	fadd.d	$f15,$f15,$f14
   120004210:	08273a31 	fmadd.d	$f17,$f17,$f14,$f14
   120004214:	01053a52 	fmul.d	$f18,$f18,$f14
   120004218:	01013a73 	fadd.d	$f19,$f19,$f14
   12000421c:	08273ab5 	fmadd.d	$f21,$f21,$f14,$f14
   120004220:	01053ad6 	fmul.d	$f22,$f22,$f14
   120004224:	01013af7 	fadd.d	$f23,$f23,$f14
   120004228:	0827398c 	fmadd.d	$f12,$f12,$f14,$f14
   12000422c:	010539ad 	fmul.d	$f13,$f13,$f14
   120004230:	010139ef 	fadd.d	$f15,$f15,$f14
   120004234:	08273a31 	fmadd.d	$f17,$f17,$f14,$f14
   120004238:	01053a52 	fmul.d	$f18,$f18,$f14
   12000423c:	01013a73 	fadd.d	$f19,$f19,$f14
   120004240:	08273ab5 	fmadd.d	$f21,$f21,$f14,$f14
   120004244:	01053ad6 	fmul.d	$f22,$f22,$f14
   120004248:	01013af7 	fadd.d	$f23,$f23,$f14
   12000424c:	0011b884 	sub.d	$r4,$r4,$r14
   120004250:	67ffb492 	bge	$r4,$r18,-76(0x3ffb4) # 120004204 <fma_fmul_faddtest_loop>
   120004254:	4c000020 	jirl	$r0,$r1,0

0000000120004258 <loadtest>:
   120004258:	0015b9ce 	xor	$r14,$r14,$r14
   12000425c:	0015b5ad 	xor	$r13,$r13,$r13
   120004260:	0015b18c 	xor	$r12,$r12,$r12
   120004264:	0015bdef 	xor	$r15,$r15,$r15
   120004268:	0015c210 	xor	$r16,$r16,$r16
   12000426c:	0015c631 	xor	$r17,$r17,$r17
   120004270:	0015ca52 	xor	$r18,$r18,$r18
   120004274:	02c051ce 	addi.d	$r14,$r14,20(0x14)

0000000120004278 <loadtest_loop>:
   120004278:	28c000ac 	ld.d	$r12,$r5,0
   12000427c:	28c004ad 	ld.d	$r13,$r5,1(0x1)
   120004280:	28c008af 	ld.d	$r15,$r5,2(0x2)
   120004284:	28c00cb0 	ld.d	$r16,$r5,3(0x3)
   120004288:	28c014b1 	ld.d	$r17,$r5,5(0x5)
   12000428c:	28c000ac 	ld.d	$r12,$r5,0
   120004290:	28c004ad 	ld.d	$r13,$r5,1(0x1)
   120004294:	28c008af 	ld.d	$r15,$r5,2(0x2)
   120004298:	28c00cb0 	ld.d	$r16,$r5,3(0x3)
   12000429c:	28c014b1 	ld.d	$r17,$r5,5(0x5)
   1200042a0:	28c000ac 	ld.d	$r12,$r5,0
   1200042a4:	28c004ad 	ld.d	$r13,$r5,1(0x1)
   1200042a8:	28c008af 	ld.d	$r15,$r5,2(0x2)
   1200042ac:	28c00cb0 	ld.d	$r16,$r5,3(0x3)
   1200042b0:	28c014b1 	ld.d	$r17,$r5,5(0x5)
   1200042b4:	28c000ac 	ld.d	$r12,$r5,0
   1200042b8:	28c004ad 	ld.d	$r13,$r5,1(0x1)
   1200042bc:	28c008af 	ld.d	$r15,$r5,2(0x2)
   1200042c0:	28c00cb0 	ld.d	$r16,$r5,3(0x3)
   1200042c4:	28c014b1 	ld.d	$r17,$r5,5(0x5)
   1200042c8:	0011b884 	sub.d	$r4,$r4,$r14
   1200042cc:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 120004278 <loadtest_loop>
   1200042d0:	4c000020 	jirl	$r0,$r1,0

00000001200042d4 <storetest>:
   1200042d4:	0015b9ce 	xor	$r14,$r14,$r14
   1200042d8:	0015b5ad 	xor	$r13,$r13,$r13
   1200042dc:	0015b18c 	xor	$r12,$r12,$r12
   1200042e0:	0015bdef 	xor	$r15,$r15,$r15
   1200042e4:	0015c210 	xor	$r16,$r16,$r16
   1200042e8:	0015c631 	xor	$r17,$r17,$r17
   1200042ec:	0015ca52 	xor	$r18,$r18,$r18
   1200042f0:	02c051ce 	addi.d	$r14,$r14,20(0x14)

00000001200042f4 <storetest_loop>:
   1200042f4:	29c000ac 	st.d	$r12,$r5,0
   1200042f8:	29c004ad 	st.d	$r13,$r5,1(0x1)
   1200042fc:	29c008af 	st.d	$r15,$r5,2(0x2)
   120004300:	29c00cb0 	st.d	$r16,$r5,3(0x3)
   120004304:	29c014b1 	st.d	$r17,$r5,5(0x5)
   120004308:	29c000ac 	st.d	$r12,$r5,0
   12000430c:	29c004ad 	st.d	$r13,$r5,1(0x1)
   120004310:	29c008af 	st.d	$r15,$r5,2(0x2)
   120004314:	29c00cb0 	st.d	$r16,$r5,3(0x3)
   120004318:	29c014b1 	st.d	$r17,$r5,5(0x5)
   12000431c:	29c000ac 	st.d	$r12,$r5,0
   120004320:	29c004ad 	st.d	$r13,$r5,1(0x1)
   120004324:	29c008af 	st.d	$r15,$r5,2(0x2)
   120004328:	29c00cb0 	st.d	$r16,$r5,3(0x3)
   12000432c:	29c014b1 	st.d	$r17,$r5,5(0x5)
   120004330:	29c000ac 	st.d	$r12,$r5,0
   120004334:	29c004ad 	st.d	$r13,$r5,1(0x1)
   120004338:	29c008af 	st.d	$r15,$r5,2(0x2)
   12000433c:	29c00cb0 	st.d	$r16,$r5,3(0x3)
   120004340:	29c014b1 	st.d	$r17,$r5,5(0x5)
   120004344:	0011b884 	sub.d	$r4,$r4,$r14
   120004348:	67ffac92 	bge	$r4,$r18,-84(0x3ffac) # 1200042f4 <storetest_loop>
   12000434c:	4c000020 	jirl	$r0,$r1,0

0000000120004350 <load_storetest>:
   120004350:	0015b9ce 	xor	$r14,$r14,$r14
   120004354:	0015b5ad 	xor	$r13,$r13,$r13
   120004358:	0015b18c 	xor	$r12,$r12,$r12
   12000435c:	0015bdef 	xor	$r15,$r15,$r15
   120004360:	0015c210 	xor	$r16,$r16,$r16
   120004364:	0015c631 	xor	$r17,$r17,$r17
   120004368:	0015ca52 	xor	$r18,$r18,$r18
   12000436c:	0015ce73 	xor	$r19,$r19,$r19
   120004370:	0015d294 	xor	$r20,$r20,$r20
   120004374:	0015e318 	xor	$r24,$r24,$r24
   120004378:	02c061ce 	addi.d	$r14,$r14,24(0x18)

000000012000437c <load_storetest_loop>:
   12000437c:	29c000ac 	st.d	$r12,$r5,0
   120004380:	28c004ad 	ld.d	$r13,$r5,1(0x1)
   120004384:	29c008af 	st.d	$r15,$r5,2(0x2)
   120004388:	28c00cb0 	ld.d	$r16,$r5,3(0x3)
   12000438c:	29c010b1 	st.d	$r17,$r5,4(0x4)
   120004390:	28c014b2 	ld.d	$r18,$r5,5(0x5)
   120004394:	29c018b3 	st.d	$r19,$r5,6(0x6)
   120004398:	28c01cb4 	ld.d	$r20,$r5,7(0x7)
   12000439c:	29c000ac 	st.d	$r12,$r5,0
   1200043a0:	28c004ad 	ld.d	$r13,$r5,1(0x1)
   1200043a4:	29c008af 	st.d	$r15,$r5,2(0x2)
   1200043a8:	28c00cb0 	ld.d	$r16,$r5,3(0x3)
   1200043ac:	29c010b1 	st.d	$r17,$r5,4(0x4)
   1200043b0:	28c014b2 	ld.d	$r18,$r5,5(0x5)
   1200043b4:	29c018b3 	st.d	$r19,$r5,6(0x6)
   1200043b8:	28c01cb4 	ld.d	$r20,$r5,7(0x7)
   1200043bc:	29c000ac 	st.d	$r12,$r5,0
   1200043c0:	28c004ad 	ld.d	$r13,$r5,1(0x1)
   1200043c4:	29c008af 	st.d	$r15,$r5,2(0x2)
   1200043c8:	28c00cb0 	ld.d	$r16,$r5,3(0x3)
   1200043cc:	29c010b1 	st.d	$r17,$r5,4(0x4)
   1200043d0:	28c014b2 	ld.d	$r18,$r5,5(0x5)
   1200043d4:	29c018b3 	st.d	$r19,$r5,6(0x6)
   1200043d8:	28c01cb4 	ld.d	$r20,$r5,7(0x7)
   1200043dc:	0011b884 	sub.d	$r4,$r4,$r14
   1200043e0:	67ff9c98 	bge	$r4,$r24,-100(0x3ff9c) # 12000437c <load_storetest_loop>
   1200043e4:	4c000020 	jirl	$r0,$r1,0

00000001200043e8 <__libc_csu_init>:
   1200043e8:	02ff0063 	addi.d	$r3,$r3,-64(0xfc0)
   1200043ec:	29c0c077 	st.d	$r23,$r3,48(0x30)
   1200043f0:	29c08079 	st.d	$r25,$r3,32(0x20)
   1200043f4:	1c000117 	pcaddu12i	$r23,8(0x8)
   1200043f8:	02e8f2f7 	addi.d	$r23,$r23,-1476(0xa3c)
   1200043fc:	1c000119 	pcaddu12i	$r25,8(0x8)
   120004400:	02e8f339 	addi.d	$r25,$r25,-1476(0xa3c)
   120004404:	0011df39 	sub.d	$r25,$r25,$r23
   120004408:	29c0e061 	st.d	$r1,$r3,56(0x38)
   12000440c:	29c0a078 	st.d	$r24,$r3,40(0x28)
   120004410:	29c0607a 	st.d	$r26,$r3,24(0x18)
   120004414:	29c0407b 	st.d	$r27,$r3,16(0x10)
   120004418:	29c0207c 	st.d	$r28,$r3,8(0x8)
   12000441c:	00490f39 	srai.d	$r25,$r25,0x3
   120004420:	40003720 	beqz	$r25,52(0x34) # 120004454 <__libc_csu_init+0x6c>
   120004424:	001500dc 	move	$r28,$r6
   120004428:	001500bb 	move	$r27,$r5
   12000442c:	0015009a 	move	$r26,$r4
   120004430:	00150018 	move	$r24,$r0
   120004434:	260002ec 	ldptr.d	$r12,$r23,0
   120004438:	00150386 	move	$r6,$r28
   12000443c:	00150365 	move	$r5,$r27
   120004440:	00150344 	move	$r4,$r26
   120004444:	02c00718 	addi.d	$r24,$r24,1(0x1)
   120004448:	4c000181 	jirl	$r1,$r12,0
   12000444c:	02c022f7 	addi.d	$r23,$r23,8(0x8)
   120004450:	5fffe738 	bne	$r25,$r24,-28(0x3ffe4) # 120004434 <__libc_csu_init+0x4c>
   120004454:	28c0e061 	ld.d	$r1,$r3,56(0x38)
   120004458:	28c0c077 	ld.d	$r23,$r3,48(0x30)
   12000445c:	28c0a078 	ld.d	$r24,$r3,40(0x28)
   120004460:	28c08079 	ld.d	$r25,$r3,32(0x20)
   120004464:	28c0607a 	ld.d	$r26,$r3,24(0x18)
   120004468:	28c0407b 	ld.d	$r27,$r3,16(0x10)
   12000446c:	28c0207c 	ld.d	$r28,$r3,8(0x8)
   120004470:	02c10063 	addi.d	$r3,$r3,64(0x40)
   120004474:	4c000020 	jirl	$r0,$r1,0

0000000120004478 <__libc_csu_fini>:
   120004478:	4c000020 	jirl	$r0,$r1,0
