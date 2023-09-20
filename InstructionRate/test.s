
x86_instructionrate:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64 
    1004:	48 83 ec 08          	sub    $0x8,%rsp
    1008:	48 8b 05 d9 cf 00 00 	mov    0xcfd9(%rip),%rax        # dfe8 <__gmon_start__>
    100f:	48 85 c0             	test   %rax,%rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	callq  *%rax
    1016:	48 83 c4 08          	add    $0x8,%rsp
    101a:	c3                   	retq   

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	ff 35 62 cf 00 00    	pushq  0xcf62(%rip)        # df88 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	ff 25 64 cf 00 00    	jmpq   *0xcf64(%rip)        # df90 <_GLOBAL_OFFSET_TABLE_+0x10>
    102c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000001030 <strncmp@plt>:
    1030:	ff 25 62 cf 00 00    	jmpq   *0xcf62(%rip)        # df98 <strncmp@GLIBC_2.2.5>
    1036:	68 00 00 00 00       	pushq  $0x0
    103b:	e9 e0 ff ff ff       	jmpq   1020 <.plt>

0000000000001040 <__stack_chk_fail@plt>:
    1040:	ff 25 5a cf 00 00    	jmpq   *0xcf5a(%rip)        # dfa0 <__stack_chk_fail@GLIBC_2.4>
    1046:	68 01 00 00 00       	pushq  $0x1
    104b:	e9 d0 ff ff ff       	jmpq   1020 <.plt>

0000000000001050 <gettimeofday@plt>:
    1050:	ff 25 52 cf 00 00    	jmpq   *0xcf52(%rip)        # dfa8 <gettimeofday@GLIBC_2.2.5>
    1056:	68 02 00 00 00       	pushq  $0x2
    105b:	e9 c0 ff ff ff       	jmpq   1020 <.plt>

0000000000001060 <strcmp@plt>:
    1060:	ff 25 4a cf 00 00    	jmpq   *0xcf4a(%rip)        # dfb0 <strcmp@GLIBC_2.2.5>
    1066:	68 03 00 00 00       	pushq  $0x3
    106b:	e9 b0 ff ff ff       	jmpq   1020 <.plt>

0000000000001070 <strtol@plt>:
    1070:	ff 25 42 cf 00 00    	jmpq   *0xcf42(%rip)        # dfb8 <strtol@GLIBC_2.2.5>
    1076:	68 04 00 00 00       	pushq  $0x4
    107b:	e9 a0 ff ff ff       	jmpq   1020 <.plt>

0000000000001080 <__printf_chk@plt>:
    1080:	ff 25 3a cf 00 00    	jmpq   *0xcf3a(%rip)        # dfc0 <__printf_chk@GLIBC_2.3.4>
    1086:	68 05 00 00 00       	pushq  $0x5
    108b:	e9 90 ff ff ff       	jmpq   1020 <.plt>

0000000000001090 <fwrite@plt>:
    1090:	ff 25 32 cf 00 00    	jmpq   *0xcf32(%rip)        # dfc8 <fwrite@GLIBC_2.2.5>
    1096:	68 06 00 00 00       	pushq  $0x6
    109b:	e9 80 ff ff ff       	jmpq   1020 <.plt>

00000000000010a0 <aligned_alloc@plt>:
    10a0:	ff 25 2a cf 00 00    	jmpq   *0xcf2a(%rip)        # dfd0 <aligned_alloc@GLIBC_2.16>
    10a6:	68 07 00 00 00       	pushq  $0x7
    10ab:	e9 70 ff ff ff       	jmpq   1020 <.plt>

Disassembly of section .plt.got:

00000000000010b0 <__cxa_finalize@plt>:
    10b0:	ff 25 42 cf 00 00    	jmpq   *0xcf42(%rip)        # dff8 <__cxa_finalize@GLIBC_2.2.5>
    10b6:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

00000000000010c0 <main>:
    10c0:	f3 0f 1e fa          	endbr64 
    10c4:	41 57                	push   %r15
    10c6:	41 56                	push   %r14
    10c8:	41 55                	push   %r13
    10ca:	41 54                	push   %r12
    10cc:	41 89 fc             	mov    %edi,%r12d
    10cf:	bf 40 00 00 00       	mov    $0x40,%edi
    10d4:	55                   	push   %rbp
    10d5:	48 89 f5             	mov    %rsi,%rbp
    10d8:	be 00 10 00 00       	mov    $0x1000,%esi
    10dd:	53                   	push   %rbx
    10de:	48 83 ec 58          	sub    $0x58,%rsp
    10e2:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    10e9:	00 00 
    10eb:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    10f0:	31 c0                	xor    %eax,%eax
    10f2:	e8 a9 ff ff ff       	callq  10a0 <aligned_alloc@plt>
    10f7:	66 0f 6f 0d 91 af 00 	movdqa 0xaf91(%rip),%xmm1        # c090 <_IO_stdin_used+0x1090>
    10fe:	00 
    10ff:	66 0f 6f 25 99 af 00 	movdqa 0xaf99(%rip),%xmm4        # c0a0 <_IO_stdin_used+0x10a0>
    1106:	00 
    1107:	48 89 05 f2 cf 00 00 	mov    %rax,0xcff2(%rip)        # e100 <intTestArr>
    110e:	66 0f 6f 1d 9a af 00 	movdqa 0xaf9a(%rip),%xmm3        # c0b0 <_IO_stdin_used+0x10b0>
    1115:	00 
    1116:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
    111d:	0f 1f 00             	nopl   (%rax)
    1120:	66 0f 6f c1          	movdqa %xmm1,%xmm0
    1124:	48 83 c0 10          	add    $0x10,%rax
    1128:	66 0f d4 cc          	paddq  %xmm4,%xmm1
    112c:	66 0f 6f d0          	movdqa %xmm0,%xmm2
    1130:	66 0f d4 d3          	paddq  %xmm3,%xmm2
    1134:	0f c6 c2 88          	shufps $0x88,%xmm2,%xmm0
    1138:	0f 29 40 f0          	movaps %xmm0,-0x10(%rax)
    113c:	48 39 c2             	cmp    %rax,%rdx
    113f:	75 df                	jne    1120 <main+0x60>
    1141:	49 be 00 eb 08 bf 01 	movabs $0x1bf08eb00,%r14
    1148:	00 00 00 
    114b:	41 83 fc 02          	cmp    $0x2,%r12d
    114f:	0f 8f db 35 00 00    	jg     4730 <main+0x3670>
    1155:	4c 8d 2d 94 cf 00 00 	lea    0xcf94(%rip),%r13        # e0f0 <__cpu_model>
    115c:	41 f6 45 0d 02       	testb  $0x2,0xd(%r13)
    1161:	0f 85 a7 35 00 00    	jne    470e <main+0x364e>
    1167:	41 f6 45 0d 04       	testb  $0x4,0xd(%r13)
    116c:	0f 85 7a 35 00 00    	jne    46ec <main+0x362c>
    1172:	41 f6 45 0e 02       	testb  $0x2,0xe(%r13)
    1177:	0f 85 4d 35 00 00    	jne    46ca <main+0x360a>
    117d:	b8 07 00 00 00       	mov    $0x7,%eax
    1182:	31 c9                	xor    %ecx,%ecx
    1184:	0f a2                	cpuid  
    1186:	81 e3 00 00 01 00    	and    $0x10000,%ebx
    118c:	0f 85 af 1f 00 00    	jne    3141 <main+0x2081>
    1192:	41 83 fc 01          	cmp    $0x1,%r12d
    1196:	0f 84 9c 47 00 00    	je     5938 <main+0x4878>
    119c:	f2 0f 10 05 dc ae 00 	movsd  0xaedc(%rip),%xmm0        # c080 <_IO_stdin_used+0x1080>
    11a3:	00 
    11a4:	bf 01 00 00 00       	mov    $0x1,%edi
    11a9:	b8 01 00 00 00       	mov    $0x1,%eax
    11ae:	48 8d 35 c3 a5 00 00 	lea    0xa5c3(%rip),%rsi        # b778 <_IO_stdin_used+0x778>
    11b5:	e8 c6 fe ff ff       	callq  1080 <__printf_chk@plt>
    11ba:	f3 0f 10 35 c6 ae 00 	movss  0xaec6(%rip),%xmm6        # c088 <_IO_stdin_used+0x1088>
    11c1:	00 
    11c2:	f3 0f 11 74 24 0c    	movss  %xmm6,0xc(%rsp)
    11c8:	f3 0f 11 74 24 08    	movss  %xmm6,0x8(%rsp)
    11ce:	41 83 fc 01          	cmp    $0x1,%r12d
    11d2:	0f 8e 6e 17 00 00    	jle    2946 <main+0x1886>
    11d8:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    11dc:	ba 05 00 00 00       	mov    $0x5,%edx
    11e1:	48 8d 35 86 a5 00 00 	lea    0xa586(%rip),%rsi        # b76e <_IO_stdin_used+0x76e>
    11e8:	4c 89 ef             	mov    %r13,%rdi
    11eb:	e8 40 fe ff ff       	callq  1030 <strncmp@plt>
    11f0:	85 c0                	test   %eax,%eax
    11f2:	0f 85 a3 17 00 00    	jne    299b <main+0x18db>
    11f8:	48 8d 35 79 5b 00 00 	lea    0x5b79(%rip),%rsi        # 6d78 <noptest1b>
    11ff:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1205:	4c 89 f7             	mov    %r14,%rdi
    1208:	e8 33 98 00 00       	callq  aa40 <measureFunction>
    120d:	bf 01 00 00 00       	mov    $0x1,%edi
    1212:	b8 01 00 00 00       	mov    $0x1,%eax
    1217:	48 8d 35 2e a5 00 00 	lea    0xa52e(%rip),%rsi        # b74c <_IO_stdin_used+0x74c>
    121e:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1222:	e8 59 fe ff ff       	callq  1080 <__printf_chk@plt>
    1227:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    122b:	ba 05 00 00 00       	mov    $0x5,%edx
    1230:	48 8d 35 8e 9f 00 00 	lea    0x9f8e(%rip),%rsi        # b1c5 <_IO_stdin_used+0x1c5>
    1237:	4c 89 ef             	mov    %r13,%rdi
    123a:	e8 f1 fd ff ff       	callq  1030 <strncmp@plt>
    123f:	85 c0                	test   %eax,%eax
    1241:	0f 85 70 17 00 00    	jne    29b7 <main+0x18f7>
    1247:	48 8d 35 f1 5a 00 00 	lea    0x5af1(%rip),%rsi        # 6d3f <noptest>
    124e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1254:	4c 89 f7             	mov    %r14,%rdi
    1257:	e8 e4 97 00 00       	callq  aa40 <measureFunction>
    125c:	bf 01 00 00 00       	mov    $0x1,%edi
    1261:	b8 01 00 00 00       	mov    $0x1,%eax
    1266:	48 8d 35 c4 a4 00 00 	lea    0xa4c4(%rip),%rsi        # b731 <_IO_stdin_used+0x731>
    126d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1271:	e8 0a fe ff ff       	callq  1080 <__printf_chk@plt>
    1276:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    127a:	ba 03 00 00 00       	mov    $0x3,%edx
    127f:	48 8d 35 89 9f 00 00 	lea    0x9f89(%rip),%rsi        # b20f <_IO_stdin_used+0x20f>
    1286:	4c 89 ef             	mov    %r13,%rdi
    1289:	e8 a2 fd ff ff       	callq  1030 <strncmp@plt>
    128e:	85 c0                	test   %eax,%eax
    1290:	0f 85 3d 17 00 00    	jne    29d3 <main+0x1913>
    1296:	48 8d 35 01 5b 00 00 	lea    0x5b01(%rip),%rsi        # 6d9e <addtest>
    129d:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    12a3:	4c 89 f7             	mov    %r14,%rdi
    12a6:	e8 95 97 00 00       	callq  aa40 <measureFunction>
    12ab:	bf 01 00 00 00       	mov    $0x1,%edi
    12b0:	b8 01 00 00 00       	mov    $0x1,%eax
    12b5:	48 8d 35 61 a4 00 00 	lea    0xa461(%rip),%rsi        # b71d <_IO_stdin_used+0x71d>
    12bc:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    12c0:	e8 bb fd ff ff       	callq  1080 <__printf_chk@plt>
    12c5:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    12c9:	48 8d 35 fb 9e 00 00 	lea    0x9efb(%rip),%rsi        # b1cb <_IO_stdin_used+0x1cb>
    12d0:	4c 89 ef             	mov    %r13,%rdi
    12d3:	e8 88 fd ff ff       	callq  1060 <strcmp@plt>
    12d8:	85 c0                	test   %eax,%eax
    12da:	0f 85 0a 17 00 00    	jne    29ea <main+0x192a>
    12e0:	4c 8d 3d 43 5b 00 00 	lea    0x5b43(%rip),%r15        # 6e2a <addnoptest>
    12e7:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    12ed:	4c 89 f7             	mov    %r14,%rdi
    12f0:	4c 89 fe             	mov    %r15,%rsi
    12f3:	e8 48 97 00 00       	callq  aa40 <measureFunction>
    12f8:	bf 01 00 00 00       	mov    $0x1,%edi
    12fd:	b8 01 00 00 00       	mov    $0x1,%eax
    1302:	48 8d 35 f7 a3 00 00 	lea    0xa3f7(%rip),%rsi        # b700 <_IO_stdin_used+0x700>
    1309:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    130d:	e8 6e fd ff ff       	callq  1080 <__printf_chk@plt>
    1312:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1316:	48 8d 35 b5 9e 00 00 	lea    0x9eb5(%rip),%rsi        # b1d2 <_IO_stdin_used+0x1d2>
    131d:	4c 89 ef             	mov    %r13,%rdi
    1320:	e8 3b fd ff ff       	callq  1060 <strcmp@plt>
    1325:	85 c0                	test   %eax,%eax
    1327:	0f 85 d4 16 00 00    	jne    2a01 <main+0x1941>
    132d:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1333:	4c 89 fe             	mov    %r15,%rsi
    1336:	4c 89 f7             	mov    %r14,%rdi
    1339:	e8 02 97 00 00       	callq  aa40 <measureFunction>
    133e:	bf 01 00 00 00       	mov    $0x1,%edi
    1343:	b8 01 00 00 00       	mov    $0x1,%eax
    1348:	48 8d 35 94 a3 00 00 	lea    0xa394(%rip),%rsi        # b6e3 <_IO_stdin_used+0x6e3>
    134f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1353:	e8 28 fd ff ff       	callq  1080 <__printf_chk@plt>
    1358:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    135c:	ba 06 00 00 00       	mov    $0x6,%edx
    1361:	48 8d 35 73 9e 00 00 	lea    0x9e73(%rip),%rsi        # b1db <_IO_stdin_used+0x1db>
    1368:	4c 89 ef             	mov    %r13,%rdi
    136b:	e8 c0 fc ff ff       	callq  1030 <strncmp@plt>
    1370:	85 c0                	test   %eax,%eax
    1372:	0f 85 a5 16 00 00    	jne    2a1d <main+0x195d>
    1378:	48 8d 35 c8 91 00 00 	lea    0x91c8(%rip),%rsi        # a547 <depmovtest>
    137f:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1385:	4c 89 f7             	mov    %r14,%rdi
    1388:	e8 b3 96 00 00       	callq  aa40 <measureFunction>
    138d:	bf 01 00 00 00       	mov    $0x1,%edi
    1392:	b8 01 00 00 00       	mov    $0x1,%eax
    1397:	48 8d 35 27 a3 00 00 	lea    0xa327(%rip),%rsi        # b6c5 <_IO_stdin_used+0x6c5>
    139e:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    13a2:	e8 d9 fc ff ff       	callq  1080 <__printf_chk@plt>
    13a7:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    13ab:	ba 08 00 00 00       	mov    $0x8,%edx
    13b0:	48 8d 35 22 9e 00 00 	lea    0x9e22(%rip),%rsi        # b1d9 <_IO_stdin_used+0x1d9>
    13b7:	4c 89 ef             	mov    %r13,%rdi
    13ba:	e8 71 fc ff ff       	callq  1030 <strncmp@plt>
    13bf:	85 c0                	test   %eax,%eax
    13c1:	0f 85 72 16 00 00    	jne    2a39 <main+0x1979>
    13c7:	48 8d 35 ee 91 00 00 	lea    0x91ee(%rip),%rsi        # a5bc <indepmovtest>
    13ce:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    13d4:	4c 89 f7             	mov    %r14,%rdi
    13d7:	e8 64 96 00 00       	callq  aa40 <measureFunction>
    13dc:	bf 01 00 00 00       	mov    $0x1,%edi
    13e1:	b8 01 00 00 00       	mov    $0x1,%eax
    13e6:	48 8d 35 3b ac 00 00 	lea    0xac3b(%rip),%rsi        # c028 <_IO_stdin_used+0x1028>
    13ed:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    13f1:	e8 8a fc ff ff       	callq  1080 <__printf_chk@plt>
    13f6:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    13fa:	ba 07 00 00 00       	mov    $0x7,%edx
    13ff:	48 8d 35 dc 9d 00 00 	lea    0x9ddc(%rip),%rsi        # b1e2 <_IO_stdin_used+0x1e2>
    1406:	4c 89 ef             	mov    %r13,%rdi
    1409:	e8 22 fc ff ff       	callq  1030 <strncmp@plt>
    140e:	85 c0                	test   %eax,%eax
    1410:	0f 85 3f 16 00 00    	jne    2a55 <main+0x1995>
    1416:	48 8d 35 e1 92 00 00 	lea    0x92e1(%rip),%rsi        # a6fe <xorzerotest>
    141d:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1423:	4c 89 f7             	mov    %r14,%rdi
    1426:	e8 15 96 00 00       	callq  aa40 <measureFunction>
    142b:	bf 01 00 00 00       	mov    $0x1,%edi
    1430:	b8 01 00 00 00       	mov    $0x1,%eax
    1435:	48 8d 35 71 a2 00 00 	lea    0xa271(%rip),%rsi        # b6ad <_IO_stdin_used+0x6ad>
    143c:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1440:	e8 3b fc ff ff       	callq  1080 <__printf_chk@plt>
    1445:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1449:	ba 07 00 00 00       	mov    $0x7,%edx
    144e:	48 8d 35 95 9d 00 00 	lea    0x9d95(%rip),%rsi        # b1ea <_IO_stdin_used+0x1ea>
    1455:	4c 89 ef             	mov    %r13,%rdi
    1458:	e8 d3 fb ff ff       	callq  1030 <strncmp@plt>
    145d:	85 c0                	test   %eax,%eax
    145f:	0f 85 0c 16 00 00    	jne    2a71 <main+0x19b1>
    1465:	48 8d 35 c7 91 00 00 	lea    0x91c7(%rip),%rsi        # a633 <movzerotest>
    146c:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1472:	4c 89 f7             	mov    %r14,%rdi
    1475:	e8 c6 95 00 00       	callq  aa40 <measureFunction>
    147a:	bf 01 00 00 00       	mov    $0x1,%edi
    147f:	b8 01 00 00 00       	mov    $0x1,%eax
    1484:	48 8d 35 0a a2 00 00 	lea    0xa20a(%rip),%rsi        # b695 <_IO_stdin_used+0x695>
    148b:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    148f:	e8 ec fb ff ff       	callq  1080 <__printf_chk@plt>
    1494:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1498:	ba 07 00 00 00       	mov    $0x7,%edx
    149d:	48 8d 35 4e 9d 00 00 	lea    0x9d4e(%rip),%rsi        # b1f2 <_IO_stdin_used+0x1f2>
    14a4:	4c 89 ef             	mov    %r13,%rdi
    14a7:	e8 84 fb ff ff       	callq  1030 <strncmp@plt>
    14ac:	85 c0                	test   %eax,%eax
    14ae:	0f 85 d9 15 00 00    	jne    2a8d <main+0x19cd>
    14b4:	48 8d 35 ba 92 00 00 	lea    0x92ba(%rip),%rsi        # a775 <subzerotest>
    14bb:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    14c1:	4c 89 f7             	mov    %r14,%rdi
    14c4:	e8 77 95 00 00       	callq  aa40 <measureFunction>
    14c9:	bf 01 00 00 00       	mov    $0x1,%edi
    14ce:	b8 01 00 00 00       	mov    $0x1,%eax
    14d3:	48 8d 35 a3 a1 00 00 	lea    0xa1a3(%rip),%rsi        # b67d <_IO_stdin_used+0x67d>
    14da:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    14de:	e8 9d fb ff ff       	callq  1080 <__printf_chk@plt>
    14e3:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    14e7:	ba 06 00 00 00       	mov    $0x6,%edx
    14ec:	48 8d 35 07 9d 00 00 	lea    0x9d07(%rip),%rsi        # b1fa <_IO_stdin_used+0x1fa>
    14f3:	4c 89 ef             	mov    %r13,%rdi
    14f6:	e8 35 fb ff ff       	callq  1030 <strncmp@plt>
    14fb:	85 c0                	test   %eax,%eax
    14fd:	0f 85 a6 15 00 00    	jne    2aa9 <main+0x19e9>
    1503:	48 8d 35 6d 93 00 00 	lea    0x936d(%rip),%rsi        # a877 <depinctest>
    150a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1510:	4c 89 f7             	mov    %r14,%rdi
    1513:	e8 28 95 00 00       	callq  aa40 <measureFunction>
    1518:	bf 01 00 00 00       	mov    $0x1,%edi
    151d:	b8 01 00 00 00       	mov    $0x1,%eax
    1522:	48 8d 35 3d a1 00 00 	lea    0xa13d(%rip),%rsi        # b666 <_IO_stdin_used+0x666>
    1529:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    152d:	e8 4e fb ff ff       	callq  1080 <__printf_chk@plt>
    1532:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1536:	ba 06 00 00 00       	mov    $0x6,%edx
    153b:	48 8d 35 bf 9c 00 00 	lea    0x9cbf(%rip),%rsi        # b201 <_IO_stdin_used+0x201>
    1542:	4c 89 ef             	mov    %r13,%rdi
    1545:	e8 e6 fa ff ff       	callq  1030 <strncmp@plt>
    154a:	85 c0                	test   %eax,%eax
    154c:	0f 85 73 15 00 00    	jne    2ac5 <main+0x1a05>
    1552:	48 8d 35 95 93 00 00 	lea    0x9395(%rip),%rsi        # a8ee <depdectest>
    1559:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    155f:	4c 89 f7             	mov    %r14,%rdi
    1562:	e8 d9 94 00 00       	callq  aa40 <measureFunction>
    1567:	bf 01 00 00 00       	mov    $0x1,%edi
    156c:	b8 01 00 00 00       	mov    $0x1,%eax
    1571:	48 8d 35 d7 a0 00 00 	lea    0xa0d7(%rip),%rsi        # b64f <_IO_stdin_used+0x64f>
    1578:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    157c:	e8 ff fa ff ff       	callq  1080 <__printf_chk@plt>
    1581:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1585:	ba 06 00 00 00       	mov    $0x6,%edx
    158a:	48 8d 35 70 9c 00 00 	lea    0x9c70(%rip),%rsi        # b201 <_IO_stdin_used+0x201>
    1591:	4c 89 ef             	mov    %r13,%rdi
    1594:	e8 97 fa ff ff       	callq  1030 <strncmp@plt>
    1599:	85 c0                	test   %eax,%eax
    159b:	75 33                	jne    15d0 <main+0x510>
    159d:	48 8d 35 48 92 00 00 	lea    0x9248(%rip),%rsi        # a7ec <depaddimmtest>
    15a4:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    15aa:	4c 89 f7             	mov    %r14,%rdi
    15ad:	e8 8e 94 00 00       	callq  aa40 <measureFunction>
    15b2:	bf 01 00 00 00       	mov    $0x1,%edi
    15b7:	b8 01 00 00 00       	mov    $0x1,%eax
    15bc:	48 8d 35 3d aa 00 00 	lea    0xaa3d(%rip),%rsi        # c000 <_IO_stdin_used+0x1000>
    15c3:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    15c7:	e8 b4 fa ff ff       	callq  1080 <__printf_chk@plt>
    15cc:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    15d0:	ba 06 00 00 00       	mov    $0x6,%edx
    15d5:	48 8d 35 8b a1 00 00 	lea    0xa18b(%rip),%rsi        # b767 <_IO_stdin_used+0x767>
    15dc:	4c 89 ef             	mov    %r13,%rdi
    15df:	e8 4c fa ff ff       	callq  1030 <strncmp@plt>
    15e4:	85 c0                	test   %eax,%eax
    15e6:	0f 85 f5 14 00 00    	jne    2ae1 <main+0x1a21>
    15ec:	48 8d 35 b3 56 00 00 	lea    0x56b3(%rip),%rsi        # 6ca6 <clkmovtest>
    15f3:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    15f9:	4c 89 f7             	mov    %r14,%rdi
    15fc:	e8 3f 94 00 00       	callq  aa40 <measureFunction>
    1601:	bf 01 00 00 00       	mov    $0x1,%edi
    1606:	b8 01 00 00 00       	mov    $0x1,%eax
    160b:	48 8d 35 c6 a9 00 00 	lea    0xa9c6(%rip),%rsi        # bfd8 <_IO_stdin_used+0xfd8>
    1612:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1616:	e8 65 fa ff ff       	callq  1080 <__printf_chk@plt>
    161b:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    161f:	ba 0a 00 00 00       	mov    $0xa,%edx
    1624:	48 8d 35 dd 9b 00 00 	lea    0x9bdd(%rip),%rsi        # b208 <_IO_stdin_used+0x208>
    162b:	4c 89 ef             	mov    %r13,%rdi
    162e:	e8 fd f9 ff ff       	callq  1030 <strncmp@plt>
    1633:	85 c0                	test   %eax,%eax
    1635:	0f 85 c2 14 00 00    	jne    2afd <main+0x1a3d>
    163b:	48 8d 35 62 61 00 00 	lea    0x6162(%rip),%rsi        # 77a4 <addmultest>
    1642:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1648:	4c 89 f7             	mov    %r14,%rdi
    164b:	e8 f0 93 00 00       	callq  aa40 <measureFunction>
    1650:	bf 01 00 00 00       	mov    $0x1,%edi
    1655:	b8 01 00 00 00       	mov    $0x1,%eax
    165a:	48 8d 35 d1 9f 00 00 	lea    0x9fd1(%rip),%rsi        # b632 <_IO_stdin_used+0x632>
    1661:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1665:	e8 16 fa ff ff       	callq  1080 <__printf_chk@plt>
    166a:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    166e:	ba 06 00 00 00       	mov    $0x6,%edx
    1673:	48 8d 35 99 9b 00 00 	lea    0x9b99(%rip),%rsi        # b213 <_IO_stdin_used+0x213>
    167a:	4c 89 ef             	mov    %r13,%rdi
    167d:	e8 ae f9 ff ff       	callq  1030 <strncmp@plt>
    1682:	85 c0                	test   %eax,%eax
    1684:	0f 85 8f 14 00 00    	jne    2b19 <main+0x1a59>
    168a:	48 8d 35 56 60 00 00 	lea    0x6056(%rip),%rsi        # 76e7 <jmpmultest>
    1691:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1697:	4c 89 f7             	mov    %r14,%rdi
    169a:	e8 a1 93 00 00       	callq  aa40 <measureFunction>
    169f:	bf 01 00 00 00       	mov    $0x1,%edi
    16a4:	b8 01 00 00 00       	mov    $0x1,%eax
    16a9:	48 8d 35 67 9f 00 00 	lea    0x9f67(%rip),%rsi        # b617 <_IO_stdin_used+0x617>
    16b0:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    16b4:	e8 c7 f9 ff ff       	callq  1080 <__printf_chk@plt>
    16b9:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    16bd:	ba 03 00 00 00       	mov    $0x3,%edx
    16c2:	48 8d 35 53 9b 00 00 	lea    0x9b53(%rip),%rsi        # b21c <_IO_stdin_used+0x21c>
    16c9:	4c 89 ef             	mov    %r13,%rdi
    16cc:	e8 5f f9 ff ff       	callq  1030 <strncmp@plt>
    16d1:	85 c0                	test   %eax,%eax
    16d3:	0f 85 5c 14 00 00    	jne    2b35 <main+0x1a75>
    16d9:	48 8d 35 11 5e 00 00 	lea    0x5e11(%rip),%rsi        # 74f1 <jmptest>
    16e0:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    16e6:	4c 89 f7             	mov    %r14,%rdi
    16e9:	e8 52 93 00 00       	callq  aa40 <measureFunction>
    16ee:	bf 01 00 00 00       	mov    $0x1,%edi
    16f3:	b8 01 00 00 00       	mov    $0x1,%eax
    16f8:	48 8d 35 ff 9e 00 00 	lea    0x9eff(%rip),%rsi        # b5fe <_IO_stdin_used+0x5fe>
    16ff:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1703:	e8 78 f9 ff ff       	callq  1080 <__printf_chk@plt>
    1708:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    170c:	ba 05 00 00 00       	mov    $0x5,%edx
    1711:	48 8d 35 02 9b 00 00 	lea    0x9b02(%rip),%rsi        # b21a <_IO_stdin_used+0x21a>
    1718:	4c 89 ef             	mov    %r13,%rdi
    171b:	e8 10 f9 ff ff       	callq  1030 <strncmp@plt>
    1720:	85 c0                	test   %eax,%eax
    1722:	0f 85 29 14 00 00    	jne    2b51 <main+0x1a91>
    1728:	48 8d 35 9a 5e 00 00 	lea    0x5e9a(%rip),%rsi        # 75c9 <ntjmptest>
    172f:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1735:	4c 89 f7             	mov    %r14,%rdi
    1738:	e8 03 93 00 00       	callq  aa40 <measureFunction>
    173d:	bf 01 00 00 00       	mov    $0x1,%edi
    1742:	b8 01 00 00 00       	mov    $0x1,%eax
    1747:	48 8d 35 9a 9e 00 00 	lea    0x9e9a(%rip),%rsi        # b5e8 <_IO_stdin_used+0x5e8>
    174e:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1752:	e8 29 f9 ff ff       	callq  1080 <__printf_chk@plt>
    1757:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    175b:	ba 04 00 00 00       	mov    $0x4,%edx
    1760:	48 8d 35 b9 9a 00 00 	lea    0x9ab9(%rip),%rsi        # b220 <_IO_stdin_used+0x220>
    1767:	4c 89 ef             	mov    %r13,%rdi
    176a:	e8 c1 f8 ff ff       	callq  1030 <strncmp@plt>
    176f:	85 c0                	test   %eax,%eax
    1771:	0f 85 f6 13 00 00    	jne    2b6d <main+0x1aad>
    1777:	48 8d 35 b2 8b 00 00 	lea    0x8bb2(%rip),%rsi        # a330 <pdeptest>
    177e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1784:	4c 89 f7             	mov    %r14,%rdi
    1787:	e8 b4 92 00 00       	callq  aa40 <measureFunction>
    178c:	bf 01 00 00 00       	mov    $0x1,%edi
    1791:	b8 01 00 00 00       	mov    $0x1,%eax
    1796:	48 8d 35 37 9e 00 00 	lea    0x9e37(%rip),%rsi        # b5d4 <_IO_stdin_used+0x5d4>
    179d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    17a1:	e8 da f8 ff ff       	callq  1080 <__printf_chk@plt>
    17a6:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    17aa:	ba 04 00 00 00       	mov    $0x4,%edx
    17af:	48 8d 35 6f 9a 00 00 	lea    0x9a6f(%rip),%rsi        # b225 <_IO_stdin_used+0x225>
    17b6:	4c 89 ef             	mov    %r13,%rdi
    17b9:	e8 72 f8 ff ff       	callq  1030 <strncmp@plt>
    17be:	85 c0                	test   %eax,%eax
    17c0:	0f 85 c3 13 00 00    	jne    2b89 <main+0x1ac9>
    17c6:	48 8d 35 c6 8c 00 00 	lea    0x8cc6(%rip),%rsi        # a493 <pexttest>
    17cd:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    17d3:	4c 89 f7             	mov    %r14,%rdi
    17d6:	e8 65 92 00 00       	callq  aa40 <measureFunction>
    17db:	bf 01 00 00 00       	mov    $0x1,%edi
    17e0:	b8 01 00 00 00       	mov    $0x1,%eax
    17e5:	48 8d 35 d4 9d 00 00 	lea    0x9dd4(%rip),%rsi        # b5c0 <_IO_stdin_used+0x5c0>
    17ec:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    17f0:	e8 8b f8 ff ff       	callq  1080 <__printf_chk@plt>
    17f5:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    17f9:	ba 07 00 00 00       	mov    $0x7,%edx
    17fe:	48 8d 35 25 9a 00 00 	lea    0x9a25(%rip),%rsi        # b22a <_IO_stdin_used+0x22a>
    1805:	4c 89 ef             	mov    %r13,%rdi
    1808:	e8 23 f8 ff ff       	callq  1030 <strncmp@plt>
    180d:	85 c0                	test   %eax,%eax
    180f:	0f 85 90 13 00 00    	jne    2ba5 <main+0x1ae5>
    1815:	48 8d 35 c8 8b 00 00 	lea    0x8bc8(%rip),%rsi        # a3e4 <pdepmultest>
    181c:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1822:	4c 89 f7             	mov    %r14,%rdi
    1825:	e8 16 92 00 00       	callq  aa40 <measureFunction>
    182a:	bf 01 00 00 00       	mov    $0x1,%edi
    182f:	b8 01 00 00 00       	mov    $0x1,%eax
    1834:	48 8d 35 69 9d 00 00 	lea    0x9d69(%rip),%rsi        # b5a4 <_IO_stdin_used+0x5a4>
    183b:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    183f:	e8 3c f8 ff ff       	callq  1080 <__printf_chk@plt>
    1844:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1848:	ba 03 00 00 00       	mov    $0x3,%edx
    184d:	48 8d 35 e8 99 00 00 	lea    0x99e8(%rip),%rsi        # b23c <_IO_stdin_used+0x23c>
    1854:	4c 89 ef             	mov    %r13,%rdi
    1857:	e8 d4 f7 ff ff       	callq  1030 <strncmp@plt>
    185c:	85 c0                	test   %eax,%eax
    185e:	0f 85 5d 13 00 00    	jne    2bc1 <main+0x1b01>
    1864:	48 8d 35 5b 57 00 00 	lea    0x575b(%rip),%rsi        # 6fc6 <shltest>
    186b:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1871:	4c 89 f7             	mov    %r14,%rdi
    1874:	e8 c7 91 00 00       	callq  aa40 <measureFunction>
    1879:	bf 01 00 00 00       	mov    $0x1,%edi
    187e:	b8 01 00 00 00       	mov    $0x1,%eax
    1883:	48 8d 35 03 9d 00 00 	lea    0x9d03(%rip),%rsi        # b58d <_IO_stdin_used+0x58d>
    188a:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    188e:	e8 ed f7 ff ff       	callq  1080 <__printf_chk@plt>
    1893:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1897:	ba 03 00 00 00       	mov    $0x3,%edx
    189c:	48 8d 35 8f 99 00 00 	lea    0x998f(%rip),%rsi        # b232 <_IO_stdin_used+0x232>
    18a3:	4c 89 ef             	mov    %r13,%rdi
    18a6:	e8 85 f7 ff ff       	callq  1030 <strncmp@plt>
    18ab:	85 c0                	test   %eax,%eax
    18ad:	0f 85 2a 13 00 00    	jne    2bdd <main+0x1b1d>
    18b3:	48 8d 35 80 56 00 00 	lea    0x5680(%rip),%rsi        # 6f3a <rortest>
    18ba:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    18c0:	4c 89 f7             	mov    %r14,%rdi
    18c3:	e8 78 91 00 00       	callq  aa40 <measureFunction>
    18c8:	bf 01 00 00 00       	mov    $0x1,%edi
    18cd:	b8 01 00 00 00       	mov    $0x1,%eax
    18d2:	48 8d 35 9d 9c 00 00 	lea    0x9c9d(%rip),%rsi        # b576 <_IO_stdin_used+0x576>
    18d9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    18dd:	e8 9e f7 ff ff       	callq  1080 <__printf_chk@plt>
    18e2:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    18e6:	ba 09 00 00 00       	mov    $0x9,%edx
    18eb:	48 8d 35 44 99 00 00 	lea    0x9944(%rip),%rsi        # b236 <_IO_stdin_used+0x236>
    18f2:	4c 89 ef             	mov    %r13,%rdi
    18f5:	e8 36 f7 ff ff       	callq  1030 <strncmp@plt>
    18fa:	85 c0                	test   %eax,%eax
    18fc:	0f 85 f7 12 00 00    	jne    2bf9 <main+0x1b39>
    1902:	48 8d 35 49 57 00 00 	lea    0x5749(%rip),%rsi        # 7052 <mixrorshltest>
    1909:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    190f:	4c 89 f7             	mov    %r14,%rdi
    1912:	e8 29 91 00 00       	callq  aa40 <measureFunction>
    1917:	bf 01 00 00 00       	mov    $0x1,%edi
    191c:	b8 01 00 00 00       	mov    $0x1,%eax
    1921:	48 8d 35 90 a6 00 00 	lea    0xa690(%rip),%rsi        # bfb8 <_IO_stdin_used+0xfb8>
    1928:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    192c:	e8 4f f7 ff ff       	callq  1080 <__printf_chk@plt>
    1931:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1935:	ba 03 00 00 00       	mov    $0x3,%edx
    193a:	48 8d 35 ff 98 00 00 	lea    0x98ff(%rip),%rsi        # b240 <_IO_stdin_used+0x240>
    1941:	4c 89 ef             	mov    %r13,%rdi
    1944:	e8 e7 f6 ff ff       	callq  1030 <strncmp@plt>
    1949:	85 c0                	test   %eax,%eax
    194b:	0f 85 c4 12 00 00    	jne    2c15 <main+0x1b55>
    1951:	48 8d 35 86 57 00 00 	lea    0x5786(%rip),%rsi        # 70de <mixrormultest>
    1958:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    195e:	4c 89 f7             	mov    %r14,%rdi
    1961:	e8 da 90 00 00       	callq  aa40 <measureFunction>
    1966:	bf 01 00 00 00       	mov    $0x1,%edi
    196b:	b8 01 00 00 00       	mov    $0x1,%eax
    1970:	48 8d 35 e4 9b 00 00 	lea    0x9be4(%rip),%rsi        # b55b <_IO_stdin_used+0x55b>
    1977:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    197b:	e8 00 f7 ff ff       	callq  1080 <__printf_chk@plt>
    1980:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1984:	ba 03 00 00 00       	mov    $0x3,%edx
    1989:	48 8d 35 c0 98 00 00 	lea    0x98c0(%rip),%rsi        # b250 <_IO_stdin_used+0x250>
    1990:	4c 89 ef             	mov    %r13,%rdi
    1993:	e8 98 f6 ff ff       	callq  1030 <strncmp@plt>
    1998:	85 c0                	test   %eax,%eax
    199a:	0f 85 91 12 00 00    	jne    2c31 <main+0x1b71>
    19a0:	48 8d 35 89 58 00 00 	lea    0x5889(%rip),%rsi        # 7230 <btstest>
    19a7:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    19ad:	4c 89 f7             	mov    %r14,%rdi
    19b0:	e8 8b 90 00 00       	callq  aa40 <measureFunction>
    19b5:	bf 01 00 00 00       	mov    $0x1,%edi
    19ba:	b8 01 00 00 00       	mov    $0x1,%eax
    19bf:	48 8d 35 82 9b 00 00 	lea    0x9b82(%rip),%rsi        # b548 <_IO_stdin_used+0x548>
    19c6:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    19ca:	e8 b1 f6 ff ff       	callq  1080 <__printf_chk@plt>
    19cf:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    19d3:	ba 09 00 00 00       	mov    $0x9,%edx
    19d8:	48 8d 35 6b 98 00 00 	lea    0x986b(%rip),%rsi        # b24a <_IO_stdin_used+0x24a>
    19df:	4c 89 ef             	mov    %r13,%rdi
    19e2:	e8 49 f6 ff ff       	callq  1030 <strncmp@plt>
    19e7:	85 c0                	test   %eax,%eax
    19e9:	0f 85 5e 12 00 00    	jne    2c4d <main+0x1b8d>
    19ef:	48 8d 35 33 5a 00 00 	lea    0x5a33(%rip),%rsi        # 7429 <btsmultest>
    19f6:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    19fc:	4c 89 f7             	mov    %r14,%rdi
    19ff:	e8 3c 90 00 00       	callq  aa40 <measureFunction>
    1a04:	bf 01 00 00 00       	mov    $0x1,%edi
    1a09:	b8 01 00 00 00       	mov    $0x1,%eax
    1a0e:	48 8d 35 18 9b 00 00 	lea    0x9b18(%rip),%rsi        # b52d <_IO_stdin_used+0x52d>
    1a15:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1a19:	e8 62 f6 ff ff       	callq  1080 <__printf_chk@plt>
    1a1e:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1a22:	ba 09 00 00 00       	mov    $0x9,%edx
    1a27:	48 8d 35 26 98 00 00 	lea    0x9826(%rip),%rsi        # b254 <_IO_stdin_used+0x254>
    1a2e:	4c 89 ef             	mov    %r13,%rdi
    1a31:	e8 fa f5 ff ff       	callq  1030 <strncmp@plt>
    1a36:	85 c0                	test   %eax,%eax
    1a38:	0f 85 2b 12 00 00    	jne    2c69 <main+0x1ba9>
    1a3e:	48 8d 35 4e 57 00 00 	lea    0x574e(%rip),%rsi        # 7193 <rorbtstest>
    1a45:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1a4b:	4c 89 f7             	mov    %r14,%rdi
    1a4e:	e8 ed 8f 00 00       	callq  aa40 <measureFunction>
    1a53:	bf 01 00 00 00       	mov    $0x1,%edi
    1a58:	b8 01 00 00 00       	mov    $0x1,%eax
    1a5d:	48 8d 35 ae 9a 00 00 	lea    0x9aae(%rip),%rsi        # b512 <_IO_stdin_used+0x512>
    1a64:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1a68:	e8 13 f6 ff ff       	callq  1080 <__printf_chk@plt>
    1a6d:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1a71:	ba 03 00 00 00       	mov    $0x3,%edx
    1a76:	48 8d 35 e7 97 00 00 	lea    0x97e7(%rip),%rsi        # b264 <_IO_stdin_used+0x264>
    1a7d:	4c 89 ef             	mov    %r13,%rdi
    1a80:	e8 ab f5 ff ff       	callq  1030 <strncmp@plt>
    1a85:	85 c0                	test   %eax,%eax
    1a87:	0f 85 f8 11 00 00    	jne    2c85 <main+0x1bc5>
    1a8d:	48 8d 35 3f 58 00 00 	lea    0x583f(%rip),%rsi        # 72d3 <leatest>
    1a94:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1a9a:	4c 89 f7             	mov    %r14,%rdi
    1a9d:	e8 9e 8f 00 00       	callq  aa40 <measureFunction>
    1aa2:	bf 01 00 00 00       	mov    $0x1,%edi
    1aa7:	b8 01 00 00 00       	mov    $0x1,%eax
    1aac:	48 8d 35 46 9a 00 00 	lea    0x9a46(%rip),%rsi        # b4f9 <_IO_stdin_used+0x4f9>
    1ab3:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1ab7:	e8 c4 f5 ff ff       	callq  1080 <__printf_chk@plt>
    1abc:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1ac0:	ba 09 00 00 00       	mov    $0x9,%edx
    1ac5:	48 8d 35 92 97 00 00 	lea    0x9792(%rip),%rsi        # b25e <_IO_stdin_used+0x25e>
    1acc:	4c 89 ef             	mov    %r13,%rdi
    1acf:	e8 5c f5 ff ff       	callq  1030 <strncmp@plt>
    1ad4:	85 c0                	test   %eax,%eax
    1ad6:	0f 85 c5 11 00 00    	jne    2ca1 <main+0x1be1>
    1adc:	48 8d 35 93 58 00 00 	lea    0x5893(%rip),%rsi        # 7376 <leamultest>
    1ae3:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1ae9:	4c 89 f7             	mov    %r14,%rdi
    1aec:	e8 4f 8f 00 00       	callq  aa40 <measureFunction>
    1af1:	bf 01 00 00 00       	mov    $0x1,%edi
    1af6:	b8 01 00 00 00       	mov    $0x1,%eax
    1afb:	48 8d 35 8e a4 00 00 	lea    0xa48e(%rip),%rsi        # bf90 <_IO_stdin_used+0xf90>
    1b02:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1b06:	e8 75 f5 ff ff       	callq  1080 <__printf_chk@plt>
    1b0b:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1b0f:	ba 09 00 00 00       	mov    $0x9,%edx
    1b14:	48 8d 35 5f 97 00 00 	lea    0x975f(%rip),%rsi        # b27a <_IO_stdin_used+0x27a>
    1b1b:	4c 89 ef             	mov    %r13,%rdi
    1b1e:	e8 0d f5 ff ff       	callq  1030 <strncmp@plt>
    1b23:	85 c0                	test   %eax,%eax
    1b25:	0f 85 92 11 00 00    	jne    2cbd <main+0x1bfd>
    1b2b:	48 8d 35 59 5d 00 00 	lea    0x5d59(%rip),%rsi        # 788b <add256int>
    1b32:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1b38:	4c 89 f7             	mov    %r14,%rdi
    1b3b:	e8 00 8f 00 00       	callq  aa40 <measureFunction>
    1b40:	bf 01 00 00 00       	mov    $0x1,%edi
    1b45:	b8 01 00 00 00       	mov    $0x1,%eax
    1b4a:	48 8d 35 17 a4 00 00 	lea    0xa417(%rip),%rsi        # bf68 <_IO_stdin_used+0xf68>
    1b51:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1b55:	e8 26 f5 ff ff       	callq  1080 <__printf_chk@plt>
    1b5a:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1b5e:	ba 0c 00 00 00       	mov    $0xc,%edx
    1b63:	48 8d 35 fe 96 00 00 	lea    0x96fe(%rip),%rsi        # b268 <_IO_stdin_used+0x268>
    1b6a:	4c 89 ef             	mov    %r13,%rdi
    1b6d:	e8 be f4 ff ff       	callq  1030 <strncmp@plt>
    1b72:	85 c0                	test   %eax,%eax
    1b74:	0f 85 5f 11 00 00    	jne    2cd9 <main+0x1c19>
    1b7a:	48 8d 35 c3 61 00 00 	lea    0x61c3(%rip),%rsi        # 7d44 <mixadd256int>
    1b81:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1b87:	4c 89 f7             	mov    %r14,%rdi
    1b8a:	e8 b1 8e 00 00       	callq  aa40 <measureFunction>
    1b8f:	bf 01 00 00 00       	mov    $0x1,%edi
    1b94:	b8 01 00 00 00       	mov    $0x1,%eax
    1b99:	48 8d 35 90 a3 00 00 	lea    0xa390(%rip),%rsi        # bf30 <_IO_stdin_used+0xf30>
    1ba0:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1ba4:	e8 d7 f4 ff ff       	callq  1080 <__printf_chk@plt>
    1ba9:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1bad:	ba 0e 00 00 00       	mov    $0xe,%edx
    1bb2:	48 8d 35 bc 96 00 00 	lea    0x96bc(%rip),%rsi        # b275 <_IO_stdin_used+0x275>
    1bb9:	4c 89 ef             	mov    %r13,%rdi
    1bbc:	e8 6f f4 ff ff       	callq  1030 <strncmp@plt>
    1bc1:	85 c0                	test   %eax,%eax
    1bc3:	0f 85 2c 11 00 00    	jne    2cf5 <main+0x1c35>
    1bc9:	48 8d 35 39 62 00 00 	lea    0x6239(%rip),%rsi        # 7e09 <mixadd256int11>
    1bd0:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1bd6:	4c 89 f7             	mov    %r14,%rdi
    1bd9:	e8 62 8e 00 00       	callq  aa40 <measureFunction>
    1bde:	bf 01 00 00 00       	mov    $0x1,%edi
    1be3:	b8 01 00 00 00       	mov    $0x1,%eax
    1be8:	48 8d 35 09 a3 00 00 	lea    0xa309(%rip),%rsi        # bef8 <_IO_stdin_used+0xef8>
    1bef:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1bf3:	e8 88 f4 ff ff       	callq  1080 <__printf_chk@plt>
    1bf8:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1bfc:	ba 0e 00 00 00       	mov    $0xe,%edx
    1c01:	48 8d 35 7c 96 00 00 	lea    0x967c(%rip),%rsi        # b284 <_IO_stdin_used+0x284>
    1c08:	4c 89 ef             	mov    %r13,%rdi
    1c0b:	e8 20 f4 ff ff       	callq  1030 <strncmp@plt>
    1c10:	85 c0                	test   %eax,%eax
    1c12:	0f 85 f9 10 00 00    	jne    2d11 <main+0x1c51>
    1c18:	48 8d 35 2c 5f 00 00 	lea    0x5f2c(%rip),%rsi        # 7b4b <mixadd256fpint>
    1c1f:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1c25:	4c 89 f7             	mov    %r14,%rdi
    1c28:	e8 13 8e 00 00       	callq  aa40 <measureFunction>
    1c2d:	bf 01 00 00 00       	mov    $0x1,%edi
    1c32:	b8 01 00 00 00       	mov    $0x1,%eax
    1c37:	48 8d 35 8a a2 00 00 	lea    0xa28a(%rip),%rsi        # bec8 <_IO_stdin_used+0xec8>
    1c3e:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1c42:	e8 39 f4 ff ff       	callq  1080 <__printf_chk@plt>
    1c47:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1c4b:	ba 08 00 00 00       	mov    $0x8,%edx
    1c50:	48 8d 35 3c 96 00 00 	lea    0x963c(%rip),%rsi        # b293 <_IO_stdin_used+0x293>
    1c57:	4c 89 ef             	mov    %r13,%rdi
    1c5a:	e8 d1 f3 ff ff       	callq  1030 <strncmp@plt>
    1c5f:	85 c0                	test   %eax,%eax
    1c61:	0f 85 c6 10 00 00    	jne    2d2d <main+0x1c6d>
    1c67:	48 8d 35 32 60 00 00 	lea    0x6032(%rip),%rsi        # 7ca0 <mix256fp>
    1c6e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1c74:	4c 89 f7             	mov    %r14,%rdi
    1c77:	e8 c4 8d 00 00       	callq  aa40 <measureFunction>
    1c7c:	bf 01 00 00 00       	mov    $0x1,%edi
    1c81:	b8 01 00 00 00       	mov    $0x1,%eax
    1c86:	48 8d 35 0b a2 00 00 	lea    0xa20b(%rip),%rsi        # be98 <_IO_stdin_used+0xe98>
    1c8d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1c91:	e8 ea f3 ff ff       	callq  1080 <__printf_chk@plt>
    1c96:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1c9a:	ba 0c 00 00 00       	mov    $0xc,%edx
    1c9f:	48 8d 35 f6 95 00 00 	lea    0x95f6(%rip),%rsi        # b29c <_IO_stdin_used+0x29c>
    1ca6:	4c 89 ef             	mov    %r13,%rdi
    1ca9:	e8 82 f3 ff ff       	callq  1030 <strncmp@plt>
    1cae:	85 c0                	test   %eax,%eax
    1cb0:	0f 85 93 10 00 00    	jne    2d49 <main+0x1c89>
    1cb6:	48 8d 35 f3 61 00 00 	lea    0x61f3(%rip),%rsi        # 7eb0 <latadd256int>
    1cbd:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1cc3:	4c 89 f7             	mov    %r14,%rdi
    1cc6:	e8 75 8d 00 00       	callq  aa40 <measureFunction>
    1ccb:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    1cd1:	bf 01 00 00 00       	mov    $0x1,%edi
    1cd6:	48 8d 35 8b a1 00 00 	lea    0xa18b(%rip),%rsi        # be68 <_IO_stdin_used+0xe68>
    1cdd:	b8 01 00 00 00       	mov    $0x1,%eax
    1ce2:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    1ce6:	66 0f ef c0          	pxor   %xmm0,%xmm0
    1cea:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    1cee:	e8 8d f3 ff ff       	callq  1080 <__printf_chk@plt>
    1cf3:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1cf7:	ba 0c 00 00 00       	mov    $0xc,%edx
    1cfc:	48 8d 35 a6 95 00 00 	lea    0x95a6(%rip),%rsi        # b2a9 <_IO_stdin_used+0x2a9>
    1d03:	4c 89 ef             	mov    %r13,%rdi
    1d06:	e8 25 f3 ff ff       	callq  1030 <strncmp@plt>
    1d0b:	85 c0                	test   %eax,%eax
    1d0d:	0f 85 52 10 00 00    	jne    2d65 <main+0x1ca5>
    1d13:	48 8d 35 81 65 00 00 	lea    0x6581(%rip),%rsi        # 829b <latmul256int>
    1d1a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1d20:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    1d25:	e8 16 8d 00 00       	callq  aa40 <measureFunction>
    1d2a:	f3 0f 10 74 24 0c    	movss  0xc(%rsp),%xmm6
    1d30:	bf 01 00 00 00       	mov    $0x1,%edi
    1d35:	48 8d 35 f4 a0 00 00 	lea    0xa0f4(%rip),%rsi        # be30 <_IO_stdin_used+0xe30>
    1d3c:	b8 01 00 00 00       	mov    $0x1,%eax
    1d41:	f3 0f 5e f0          	divss  %xmm0,%xmm6
    1d45:	66 0f ef c0          	pxor   %xmm0,%xmm0
    1d49:	f3 0f 5a c6          	cvtss2sd %xmm6,%xmm0
    1d4d:	e8 2e f3 ff ff       	callq  1080 <__printf_chk@plt>
    1d52:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1d56:	ba 0c 00 00 00       	mov    $0xc,%edx
    1d5b:	48 8d 35 54 95 00 00 	lea    0x9554(%rip),%rsi        # b2b6 <_IO_stdin_used+0x2b6>
    1d62:	4c 89 ef             	mov    %r13,%rdi
    1d65:	e8 c6 f2 ff ff       	callq  1030 <strncmp@plt>
    1d6a:	85 c0                	test   %eax,%eax
    1d6c:	0f 85 0f 10 00 00    	jne    2d81 <main+0x1cc1>
    1d72:	48 8d 35 d0 65 00 00 	lea    0x65d0(%rip),%rsi        # 8349 <latadd128int>
    1d79:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1d7f:	4c 89 f7             	mov    %r14,%rdi
    1d82:	e8 b9 8c 00 00       	callq  aa40 <measureFunction>
    1d87:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    1d8d:	bf 01 00 00 00       	mov    $0x1,%edi
    1d92:	48 8d 35 67 a0 00 00 	lea    0xa067(%rip),%rsi        # be00 <_IO_stdin_used+0xe00>
    1d99:	b8 01 00 00 00       	mov    $0x1,%eax
    1d9e:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    1da2:	66 0f ef c0          	pxor   %xmm0,%xmm0
    1da6:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    1daa:	e8 d1 f2 ff ff       	callq  1080 <__printf_chk@plt>
    1daf:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1db3:	ba 0c 00 00 00       	mov    $0xc,%edx
    1db8:	48 8d 35 04 95 00 00 	lea    0x9504(%rip),%rsi        # b2c3 <_IO_stdin_used+0x2c3>
    1dbf:	4c 89 ef             	mov    %r13,%rdi
    1dc2:	e8 69 f2 ff ff       	callq  1030 <strncmp@plt>
    1dc7:	85 c0                	test   %eax,%eax
    1dc9:	0f 85 ce 0f 00 00    	jne    2d9d <main+0x1cdd>
    1dcf:	48 8d 35 c6 6a 00 00 	lea    0x6ac6(%rip),%rsi        # 889c <latmul128int>
    1dd6:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1ddc:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    1de1:	e8 5a 8c 00 00       	callq  aa40 <measureFunction>
    1de6:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    1dec:	bf 01 00 00 00       	mov    $0x1,%edi
    1df1:	48 8d 35 d0 9f 00 00 	lea    0x9fd0(%rip),%rsi        # bdc8 <_IO_stdin_used+0xdc8>
    1df8:	b8 01 00 00 00       	mov    $0x1,%eax
    1dfd:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    1e01:	66 0f ef c0          	pxor   %xmm0,%xmm0
    1e05:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    1e09:	e8 72 f2 ff ff       	callq  1080 <__printf_chk@plt>
    1e0e:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1e12:	ba 0b 00 00 00       	mov    $0xb,%edx
    1e17:	48 8d 35 b2 94 00 00 	lea    0x94b2(%rip),%rsi        # b2d0 <_IO_stdin_used+0x2d0>
    1e1e:	4c 89 ef             	mov    %r13,%rdi
    1e21:	e8 0a f2 ff ff       	callq  1030 <strncmp@plt>
    1e26:	85 c0                	test   %eax,%eax
    1e28:	0f 85 8b 0f 00 00    	jne    2db9 <main+0x1cf9>
    1e2e:	48 8d 35 8c 6b 00 00 	lea    0x6b8c(%rip),%rsi        # 89c1 <latadd256fp>
    1e35:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1e3b:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    1e40:	e8 fb 8b 00 00       	callq  aa40 <measureFunction>
    1e45:	f3 0f 10 74 24 0c    	movss  0xc(%rsp),%xmm6
    1e4b:	bf 01 00 00 00       	mov    $0x1,%edi
    1e50:	48 8d 35 49 9f 00 00 	lea    0x9f49(%rip),%rsi        # bda0 <_IO_stdin_used+0xda0>
    1e57:	b8 01 00 00 00       	mov    $0x1,%eax
    1e5c:	f3 0f 5e f0          	divss  %xmm0,%xmm6
    1e60:	66 0f ef c0          	pxor   %xmm0,%xmm0
    1e64:	f3 0f 5a c6          	cvtss2sd %xmm6,%xmm0
    1e68:	e8 13 f2 ff ff       	callq  1080 <__printf_chk@plt>
    1e6d:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1e71:	ba 0b 00 00 00       	mov    $0xb,%edx
    1e76:	48 8d 35 5f 94 00 00 	lea    0x945f(%rip),%rsi        # b2dc <_IO_stdin_used+0x2dc>
    1e7d:	4c 89 ef             	mov    %r13,%rdi
    1e80:	e8 ab f1 ff ff       	callq  1030 <strncmp@plt>
    1e85:	85 c0                	test   %eax,%eax
    1e87:	0f 85 48 0f 00 00    	jne    2dd5 <main+0x1d15>
    1e8d:	48 8d 35 e7 6c 00 00 	lea    0x6ce7(%rip),%rsi        # 8b7b <latmul256fp>
    1e94:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1e9a:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    1e9f:	e8 9c 8b 00 00       	callq  aa40 <measureFunction>
    1ea4:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    1eaa:	bf 01 00 00 00       	mov    $0x1,%edi
    1eaf:	48 8d 35 c2 9e 00 00 	lea    0x9ec2(%rip),%rsi        # bd78 <_IO_stdin_used+0xd78>
    1eb6:	b8 01 00 00 00       	mov    $0x1,%eax
    1ebb:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    1ebf:	66 0f ef c0          	pxor   %xmm0,%xmm0
    1ec3:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    1ec7:	e8 b4 f1 ff ff       	callq  1080 <__printf_chk@plt>
    1ecc:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1ed0:	ba 0b 00 00 00       	mov    $0xb,%edx
    1ed5:	48 8d 35 0c 94 00 00 	lea    0x940c(%rip),%rsi        # b2e8 <_IO_stdin_used+0x2e8>
    1edc:	4c 89 ef             	mov    %r13,%rdi
    1edf:	e8 4c f1 ff ff       	callq  1030 <strncmp@plt>
    1ee4:	85 c0                	test   %eax,%eax
    1ee6:	0f 85 05 0f 00 00    	jne    2df1 <main+0x1d31>
    1eec:	48 8d 35 99 79 00 00 	lea    0x7999(%rip),%rsi        # 988c <latadd128fp>
    1ef3:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1ef9:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    1efe:	e8 3d 8b 00 00       	callq  aa40 <measureFunction>
    1f03:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    1f09:	bf 01 00 00 00       	mov    $0x1,%edi
    1f0e:	48 8d 35 3b 9e 00 00 	lea    0x9e3b(%rip),%rsi        # bd50 <_IO_stdin_used+0xd50>
    1f15:	b8 01 00 00 00       	mov    $0x1,%eax
    1f1a:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    1f1e:	66 0f ef c0          	pxor   %xmm0,%xmm0
    1f22:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    1f26:	e8 55 f1 ff ff       	callq  1080 <__printf_chk@plt>
    1f2b:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1f2f:	ba 0b 00 00 00       	mov    $0xb,%edx
    1f34:	48 8d 35 b9 93 00 00 	lea    0x93b9(%rip),%rsi        # b2f4 <_IO_stdin_used+0x2f4>
    1f3b:	4c 89 ef             	mov    %r13,%rdi
    1f3e:	e8 ed f0 ff ff       	callq  1030 <strncmp@plt>
    1f43:	85 c0                	test   %eax,%eax
    1f45:	0f 85 c2 0e 00 00    	jne    2e0d <main+0x1d4d>
    1f4b:	48 8d 35 9a 79 00 00 	lea    0x799a(%rip),%rsi        # 98ec <latmul128fp>
    1f52:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1f58:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    1f5d:	e8 de 8a 00 00       	callq  aa40 <measureFunction>
    1f62:	f3 0f 10 74 24 0c    	movss  0xc(%rsp),%xmm6
    1f68:	bf 01 00 00 00       	mov    $0x1,%edi
    1f6d:	48 8d 35 b4 9d 00 00 	lea    0x9db4(%rip),%rsi        # bd28 <_IO_stdin_used+0xd28>
    1f74:	b8 01 00 00 00       	mov    $0x1,%eax
    1f79:	f3 0f 5e f0          	divss  %xmm0,%xmm6
    1f7d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    1f81:	f3 0f 5a c6          	cvtss2sd %xmm6,%xmm0
    1f85:	e8 f6 f0 ff ff       	callq  1080 <__printf_chk@plt>
    1f8a:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1f8e:	ba 08 00 00 00       	mov    $0x8,%edx
    1f93:	48 8d 35 51 93 00 00 	lea    0x9351(%rip),%rsi        # b2eb <_IO_stdin_used+0x2eb>
    1f9a:	4c 89 ef             	mov    %r13,%rdi
    1f9d:	e8 8e f0 ff ff       	callq  1030 <strncmp@plt>
    1fa2:	85 c0                	test   %eax,%eax
    1fa4:	0f 85 7f 0e 00 00    	jne    2e29 <main+0x1d69>
    1faa:	48 8d 35 0a 7a 00 00 	lea    0x7a0a(%rip),%rsi        # 99bb <add128fp>
    1fb1:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    1fb7:	4c 89 f7             	mov    %r14,%rdi
    1fba:	e8 81 8a 00 00       	callq  aa40 <measureFunction>
    1fbf:	bf 01 00 00 00       	mov    $0x1,%edi
    1fc4:	b8 01 00 00 00       	mov    $0x1,%eax
    1fc9:	48 8d 35 38 9d 00 00 	lea    0x9d38(%rip),%rsi        # bd08 <_IO_stdin_used+0xd08>
    1fd0:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    1fd4:	e8 a7 f0 ff ff       	callq  1080 <__printf_chk@plt>
    1fd9:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    1fdd:	ba 08 00 00 00       	mov    $0x8,%edx
    1fe2:	48 8d 35 0e 93 00 00 	lea    0x930e(%rip),%rsi        # b2f7 <_IO_stdin_used+0x2f7>
    1fe9:	4c 89 ef             	mov    %r13,%rdi
    1fec:	e8 3f f0 ff ff       	callq  1030 <strncmp@plt>
    1ff1:	85 c0                	test   %eax,%eax
    1ff3:	0f 85 4c 0e 00 00    	jne    2e45 <main+0x1d85>
    1ff9:	48 8d 35 4c 79 00 00 	lea    0x794c(%rip),%rsi        # 994c <mul128fp>
    2000:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    2006:	4c 89 f7             	mov    %r14,%rdi
    2009:	e8 32 8a 00 00       	callq  aa40 <measureFunction>
    200e:	bf 01 00 00 00       	mov    $0x1,%edi
    2013:	b8 01 00 00 00       	mov    $0x1,%eax
    2018:	48 8d 35 c9 9c 00 00 	lea    0x9cc9(%rip),%rsi        # bce8 <_IO_stdin_used+0xce8>
    201f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2023:	e8 58 f0 ff ff       	callq  1080 <__printf_chk@plt>
    2028:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    202c:	ba 09 00 00 00       	mov    $0x9,%edx
    2031:	48 8d 35 81 92 00 00 	lea    0x9281(%rip),%rsi        # b2b9 <_IO_stdin_used+0x2b9>
    2038:	4c 89 ef             	mov    %r13,%rdi
    203b:	e8 f0 ef ff ff       	callq  1030 <strncmp@plt>
    2040:	85 c0                	test   %eax,%eax
    2042:	0f 85 19 0e 00 00    	jne    2e61 <main+0x1da1>
    2048:	48 8d 35 65 63 00 00 	lea    0x6365(%rip),%rsi        # 83b4 <add128int>
    204f:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    2055:	4c 89 f7             	mov    %r14,%rdi
    2058:	e8 e3 89 00 00       	callq  aa40 <measureFunction>
    205d:	bf 01 00 00 00       	mov    $0x1,%edi
    2062:	b8 01 00 00 00       	mov    $0x1,%eax
    2067:	48 8d 35 52 9c 00 00 	lea    0x9c52(%rip),%rsi        # bcc0 <_IO_stdin_used+0xcc0>
    206e:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2072:	e8 09 f0 ff ff       	callq  1080 <__printf_chk@plt>
    2077:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    207b:	ba 09 00 00 00       	mov    $0x9,%edx
    2080:	48 8d 35 4e 93 00 00 	lea    0x934e(%rip),%rsi        # b3d5 <_IO_stdin_used+0x3d5>
    2087:	4c 89 ef             	mov    %r13,%rdi
    208a:	e8 a1 ef ff ff       	callq  1030 <strncmp@plt>
    208f:	85 c0                	test   %eax,%eax
    2091:	0f 85 e6 0d 00 00    	jne    2e7d <main+0x1dbd>
    2097:	48 8d 35 7f 67 00 00 	lea    0x677f(%rip),%rsi        # 881d <mul128int>
    209e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    20a4:	4c 89 f7             	mov    %r14,%rdi
    20a7:	e8 94 89 00 00       	callq  aa40 <measureFunction>
    20ac:	bf 01 00 00 00       	mov    $0x1,%edi
    20b1:	b8 01 00 00 00       	mov    $0x1,%eax
    20b6:	48 8d 35 db 9b 00 00 	lea    0x9bdb(%rip),%rsi        # bc98 <_IO_stdin_used+0xc98>
    20bd:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    20c1:	e8 ba ef ff ff       	callq  1080 <__printf_chk@plt>
    20c6:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    20ca:	ba 06 00 00 00       	mov    $0x6,%edx
    20cf:	48 8d 35 2d 92 00 00 	lea    0x922d(%rip),%rsi        # b303 <_IO_stdin_used+0x303>
    20d6:	4c 89 ef             	mov    %r13,%rdi
    20d9:	e8 52 ef ff ff       	callq  1030 <strncmp@plt>
    20de:	85 c0                	test   %eax,%eax
    20e0:	0f 85 b3 0d 00 00    	jne    2e99 <main+0x1dd9>
    20e6:	48 8d 35 c2 6c 00 00 	lea    0x6cc2(%rip),%rsi        # 8daf <fma256>
    20ed:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    20f3:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    20f8:	e8 43 89 00 00       	callq  aa40 <measureFunction>
    20fd:	bf 01 00 00 00       	mov    $0x1,%edi
    2102:	b8 01 00 00 00       	mov    $0x1,%eax
    2107:	48 8d 35 d0 93 00 00 	lea    0x93d0(%rip),%rsi        # b4de <_IO_stdin_used+0x4de>
    210e:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2112:	e8 69 ef ff ff       	callq  1080 <__printf_chk@plt>
    2117:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    211b:	ba 06 00 00 00       	mov    $0x6,%edx
    2120:	48 8d 35 8a 90 00 00 	lea    0x908a(%rip),%rsi        # b1b1 <_IO_stdin_used+0x1b1>
    2127:	4c 89 ef             	mov    %r13,%rdi
    212a:	e8 01 ef ff ff       	callq  1030 <strncmp@plt>
    212f:	85 c0                	test   %eax,%eax
    2131:	0f 85 7e 0d 00 00    	jne    2eb5 <main+0x1df5>
    2137:	48 8d 35 29 6d 00 00 	lea    0x6d29(%rip),%rsi        # 8e67 <fma128>
    213e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    2144:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    2149:	e8 f2 88 00 00       	callq  aa40 <measureFunction>
    214e:	bf 01 00 00 00       	mov    $0x1,%edi
    2153:	b8 01 00 00 00       	mov    $0x1,%eax
    2158:	48 8d 35 64 93 00 00 	lea    0x9364(%rip),%rsi        # b4c3 <_IO_stdin_used+0x4c3>
    215f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2163:	e8 18 ef ff ff       	callq  1080 <__printf_chk@plt>
    2168:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    216c:	ba 09 00 00 00       	mov    $0x9,%edx
    2171:	48 8d 35 88 91 00 00 	lea    0x9188(%rip),%rsi        # b300 <_IO_stdin_used+0x300>
    2178:	4c 89 ef             	mov    %r13,%rdi
    217b:	e8 b0 ee ff ff       	callq  1030 <strncmp@plt>
    2180:	85 c0                	test   %eax,%eax
    2182:	0f 85 49 0d 00 00    	jne    2ed1 <main+0x1e11>
    2188:	48 8d 35 8a 75 00 00 	lea    0x758a(%rip),%rsi        # 9719 <latfma256>
    218f:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    2195:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    219a:	e8 a1 88 00 00       	callq  aa40 <measureFunction>
    219f:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    21a5:	bf 01 00 00 00       	mov    $0x1,%edi
    21aa:	48 8d 35 bf 9a 00 00 	lea    0x9abf(%rip),%rsi        # bc70 <_IO_stdin_used+0xc70>
    21b1:	b8 01 00 00 00       	mov    $0x1,%eax
    21b6:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    21ba:	66 0f ef c0          	pxor   %xmm0,%xmm0
    21be:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    21c2:	e8 b9 ee ff ff       	callq  1080 <__printf_chk@plt>
    21c7:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    21cb:	ba 09 00 00 00       	mov    $0x9,%edx
    21d0:	48 8d 35 33 91 00 00 	lea    0x9133(%rip),%rsi        # b30a <_IO_stdin_used+0x30a>
    21d7:	4c 89 ef             	mov    %r13,%rdi
    21da:	e8 51 ee ff ff       	callq  1030 <strncmp@plt>
    21df:	85 c0                	test   %eax,%eax
    21e1:	0f 85 06 0d 00 00    	jne    2eed <main+0x1e2d>
    21e7:	48 8d 35 e3 75 00 00 	lea    0x75e3(%rip),%rsi        # 97d1 <latfma128>
    21ee:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    21f4:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    21f9:	e8 42 88 00 00       	callq  aa40 <measureFunction>
    21fe:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    2204:	bf 01 00 00 00       	mov    $0x1,%edi
    2209:	48 8d 35 38 9a 00 00 	lea    0x9a38(%rip),%rsi        # bc48 <_IO_stdin_used+0xc48>
    2210:	b8 01 00 00 00       	mov    $0x1,%eax
    2215:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    2219:	66 0f ef c0          	pxor   %xmm0,%xmm0
    221d:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    2221:	e8 5a ee ff ff       	callq  1080 <__printf_chk@plt>
    2226:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    222a:	ba 06 00 00 00       	mov    $0x6,%edx
    222f:	48 8d 35 ec 90 00 00 	lea    0x90ec(%rip),%rsi        # b322 <_IO_stdin_used+0x322>
    2236:	4c 89 ef             	mov    %r13,%rdi
    2239:	e8 f2 ed ff ff       	callq  1030 <strncmp@plt>
    223e:	85 c0                	test   %eax,%eax
    2240:	0f 85 c3 0c 00 00    	jne    2f09 <main+0x1e49>
    2246:	48 8d 35 8f 68 00 00 	lea    0x688f(%rip),%rsi        # 8adc <add256fp>
    224d:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    2253:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    2258:	e8 e3 87 00 00       	callq  aa40 <measureFunction>
    225d:	bf 01 00 00 00       	mov    $0x1,%edi
    2262:	b8 01 00 00 00       	mov    $0x1,%eax
    2267:	48 8d 35 39 92 00 00 	lea    0x9239(%rip),%rsi        # b4a7 <_IO_stdin_used+0x4a7>
    226e:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2272:	e8 09 ee ff ff       	callq  1080 <__printf_chk@plt>
    2277:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    227b:	ba 06 00 00 00       	mov    $0x6,%edx
    2280:	48 8d 35 8d 90 00 00 	lea    0x908d(%rip),%rsi        # b314 <_IO_stdin_used+0x314>
    2287:	4c 89 ef             	mov    %r13,%rdi
    228a:	e8 a1 ed ff ff       	callq  1030 <strncmp@plt>
    228f:	85 c0                	test   %eax,%eax
    2291:	0f 85 8e 0c 00 00    	jne    2f25 <main+0x1e65>
    2297:	48 8d 35 9f 67 00 00 	lea    0x679f(%rip),%rsi        # 8a3d <mul256fp>
    229e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    22a4:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    22a9:	e8 92 87 00 00       	callq  aa40 <measureFunction>
    22ae:	bf 01 00 00 00       	mov    $0x1,%edi
    22b3:	b8 01 00 00 00       	mov    $0x1,%eax
    22b8:	48 8d 35 cc 91 00 00 	lea    0x91cc(%rip),%rsi        # b48b <_IO_stdin_used+0x48b>
    22bf:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    22c3:	e8 b8 ed ff ff       	callq  1080 <__printf_chk@plt>
    22c8:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    22cc:	ba 0c 00 00 00       	mov    $0xc,%edx
    22d1:	48 8d 35 44 90 00 00 	lea    0x9044(%rip),%rsi        # b31c <_IO_stdin_used+0x31c>
    22d8:	4c 89 ef             	mov    %r13,%rdi
    22db:	e8 50 ed ff ff       	callq  1030 <strncmp@plt>
    22e0:	85 c0                	test   %eax,%eax
    22e2:	0f 85 59 0c 00 00    	jne    2f41 <main+0x1e81>
    22e8:	48 8d 35 33 6c 00 00 	lea    0x6c33(%rip),%rsi        # 8f22 <mixfmafadd256>
    22ef:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    22f5:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    22fa:	48 c1 e7 09          	shl    $0x9,%rdi
    22fe:	e8 3d 87 00 00       	callq  aa40 <measureFunction>
    2303:	bf 01 00 00 00       	mov    $0x1,%edi
    2308:	b8 01 00 00 00       	mov    $0x1,%eax
    230d:	48 8d 35 0c 99 00 00 	lea    0x990c(%rip),%rsi        # bc20 <_IO_stdin_used+0xc20>
    2314:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2318:	e8 63 ed ff ff       	callq  1080 <__printf_chk@plt>
    231d:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    2321:	ba 0b 00 00 00       	mov    $0xb,%edx
    2326:	48 8d 35 fd 8f 00 00 	lea    0x8ffd(%rip),%rsi        # b32a <_IO_stdin_used+0x32a>
    232d:	4c 89 ef             	mov    %r13,%rdi
    2330:	e8 fb ec ff ff       	callq  1030 <strncmp@plt>
    2335:	85 c0                	test   %eax,%eax
    2337:	0f 85 20 0c 00 00    	jne    2f5d <main+0x1e9d>
    233d:	48 8d 35 8d 6e 00 00 	lea    0x6e8d(%rip),%rsi        # 91d1 <mixfmaadd256>
    2344:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    234a:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    234f:	48 c1 e7 09          	shl    $0x9,%rdi
    2353:	e8 e8 86 00 00       	callq  aa40 <measureFunction>
    2358:	bf 01 00 00 00       	mov    $0x1,%edi
    235d:	b8 01 00 00 00       	mov    $0x1,%eax
    2362:	48 8d 35 8f 98 00 00 	lea    0x988f(%rip),%rsi        # bbf8 <_IO_stdin_used+0xbf8>
    2369:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    236d:	e8 0e ed ff ff       	callq  1080 <__printf_chk@plt>
    2372:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    2376:	ba 0e 00 00 00       	mov    $0xe,%edx
    237b:	48 8d 35 b5 8f 00 00 	lea    0x8fb5(%rip),%rsi        # b337 <_IO_stdin_used+0x337>
    2382:	4c 89 ef             	mov    %r13,%rdi
    2385:	e8 a6 ec ff ff       	callq  1030 <strncmp@plt>
    238a:	85 c0                	test   %eax,%eax
    238c:	0f 85 e7 0b 00 00    	jne    2f79 <main+0x1eb9>
    2392:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    2398:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    239d:	48 8d 35 8c 86 00 00 	lea    0x868c(%rip),%rsi        # aa30 <mixfmaaddmem256wrapper>
    23a4:	48 c1 e7 09          	shl    $0x9,%rdi
    23a8:	e8 93 86 00 00       	callq  aa40 <measureFunction>
    23ad:	bf 01 00 00 00       	mov    $0x1,%edi
    23b2:	b8 01 00 00 00       	mov    $0x1,%eax
    23b7:	48 8d 35 0a 98 00 00 	lea    0x980a(%rip),%rsi        # bbc8 <_IO_stdin_used+0xbc8>
    23be:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    23c2:	e8 b9 ec ff ff       	callq  1080 <__printf_chk@plt>
    23c7:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    23cb:	ba 0b 00 00 00       	mov    $0xb,%edx
    23d0:	48 8d 35 70 8f 00 00 	lea    0x8f70(%rip),%rsi        # b347 <_IO_stdin_used+0x347>
    23d7:	4c 89 ef             	mov    %r13,%rdi
    23da:	e8 51 ec ff ff       	callq  1030 <strncmp@plt>
    23df:	85 c0                	test   %eax,%eax
    23e1:	75 39                	jne    241c <main+0x135c>
    23e3:	48 8d 35 98 6e 00 00 	lea    0x6e98(%rip),%rsi        # 9282 <mixfmaand256>
    23ea:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    23f0:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    23f5:	48 c1 e7 09          	shl    $0x9,%rdi
    23f9:	e8 42 86 00 00       	callq  aa40 <measureFunction>
    23fe:	bf 01 00 00 00       	mov    $0x1,%edi
    2403:	b8 01 00 00 00       	mov    $0x1,%eax
    2408:	48 8d 35 91 97 00 00 	lea    0x9791(%rip),%rsi        # bba0 <_IO_stdin_used+0xba0>
    240f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2413:	e8 68 ec ff ff       	callq  1080 <__printf_chk@plt>
    2418:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    241c:	ba 0e 00 00 00       	mov    $0xe,%edx
    2421:	48 8d 35 0f 8f 00 00 	lea    0x8f0f(%rip),%rsi        # b337 <_IO_stdin_used+0x337>
    2428:	4c 89 ef             	mov    %r13,%rdi
    242b:	e8 00 ec ff ff       	callq  1030 <strncmp@plt>
    2430:	85 c0                	test   %eax,%eax
    2432:	0f 85 5d 0b 00 00    	jne    2f95 <main+0x1ed5>
    2438:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    243e:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    2443:	48 8d 35 d6 85 00 00 	lea    0x85d6(%rip),%rsi        # aa20 <mixfmaandmem256wrapper>
    244a:	48 c1 e7 09          	shl    $0x9,%rdi
    244e:	e8 ed 85 00 00       	callq  aa40 <measureFunction>
    2453:	bf 01 00 00 00       	mov    $0x1,%edi
    2458:	b8 01 00 00 00       	mov    $0x1,%eax
    245d:	48 8d 35 e4 9b 00 00 	lea    0x9be4(%rip),%rsi        # c048 <_IO_stdin_used+0x1048>
    2464:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2468:	e8 13 ec ff ff       	callq  1080 <__printf_chk@plt>
    246d:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    2471:	ba 0d 00 00 00       	mov    $0xd,%edx
    2476:	48 8d 35 9a 8c 00 00 	lea    0x8c9a(%rip),%rsi        # b117 <_IO_stdin_used+0x117>
    247d:	4c 89 ef             	mov    %r13,%rdi
    2480:	e8 ab eb ff ff       	callq  1030 <strncmp@plt>
    2485:	85 c0                	test   %eax,%eax
    2487:	0f 85 24 0b 00 00    	jne    2fb1 <main+0x1ef1>
    248d:	48 8d 35 04 71 00 00 	lea    0x7104(%rip),%rsi        # 9598 <nemesfpumix21>
    2494:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    249a:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    249f:	48 c1 e7 09          	shl    $0x9,%rdi
    24a3:	e8 98 85 00 00       	callq  aa40 <measureFunction>
    24a8:	bf 01 00 00 00       	mov    $0x1,%edi
    24ad:	b8 01 00 00 00       	mov    $0x1,%eax
    24b2:	48 8d 35 b7 96 00 00 	lea    0x96b7(%rip),%rsi        # bb70 <_IO_stdin_used+0xb70>
    24b9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    24bd:	e8 be eb ff ff       	callq  1080 <__printf_chk@plt>
    24c2:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    24c6:	ba 0f 00 00 00       	mov    $0xf,%edx
    24cb:	48 8d 35 82 8e 00 00 	lea    0x8e82(%rip),%rsi        # b354 <_IO_stdin_used+0x354>
    24d2:	4c 89 ef             	mov    %r13,%rdi
    24d5:	e8 56 eb ff ff       	callq  1030 <strncmp@plt>
    24da:	85 c0                	test   %eax,%eax
    24dc:	0f 85 eb 0a 00 00    	jne    2fcd <main+0x1f0d>
    24e2:	48 8d 35 0b 57 00 00 	lea    0x570b(%rip),%rsi        # 7bf4 <mix256faddintadd>
    24e9:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    24ef:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    24f4:	e8 47 85 00 00       	callq  aa40 <measureFunction>
    24f9:	bf 01 00 00 00       	mov    $0x1,%edi
    24fe:	b8 01 00 00 00       	mov    $0x1,%eax
    2503:	48 8d 35 3e 96 00 00 	lea    0x963e(%rip),%rsi        # bb48 <_IO_stdin_used+0xb48>
    250a:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    250e:	e8 6d eb ff ff       	callq  1080 <__printf_chk@plt>
    2513:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    2517:	ba 08 00 00 00       	mov    $0x8,%edx
    251c:	48 8d 35 42 8e 00 00 	lea    0x8e42(%rip),%rsi        # b365 <_IO_stdin_used+0x365>
    2523:	4c 89 ef             	mov    %r13,%rdi
    2526:	e8 05 eb ff ff       	callq  1030 <strncmp@plt>
    252b:	85 c0                	test   %eax,%eax
    252d:	0f 85 b6 0a 00 00    	jne    2fe9 <main+0x1f29>
    2533:	48 8d 35 90 75 00 00 	lea    0x7590(%rip),%rsi        # 9aca <latmul16>
    253a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    2540:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    2545:	e8 f6 84 00 00       	callq  aa40 <measureFunction>
    254a:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    2550:	bf 01 00 00 00       	mov    $0x1,%edi
    2555:	48 8d 35 c4 95 00 00 	lea    0x95c4(%rip),%rsi        # bb20 <_IO_stdin_used+0xb20>
    255c:	b8 01 00 00 00       	mov    $0x1,%eax
    2561:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    2565:	66 0f ef c0          	pxor   %xmm0,%xmm0
    2569:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    256d:	e8 0e eb ff ff       	callq  1080 <__printf_chk@plt>
    2572:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    2576:	ba 08 00 00 00       	mov    $0x8,%edx
    257b:	48 8d 35 ec 8d 00 00 	lea    0x8dec(%rip),%rsi        # b36e <_IO_stdin_used+0x36e>
    2582:	4c 89 ef             	mov    %r13,%rdi
    2585:	e8 a6 ea ff ff       	callq  1030 <strncmp@plt>
    258a:	85 c0                	test   %eax,%eax
    258c:	0f 85 73 0a 00 00    	jne    3005 <main+0x1f45>
    2592:	48 8d 35 91 74 00 00 	lea    0x7491(%rip),%rsi        # 9a2a <latmul64>
    2599:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    259f:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    25a4:	e8 97 84 00 00       	callq  aa40 <measureFunction>
    25a9:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    25af:	bf 01 00 00 00       	mov    $0x1,%edi
    25b4:	48 8d 35 3d 95 00 00 	lea    0x953d(%rip),%rsi        # baf8 <_IO_stdin_used+0xaf8>
    25bb:	b8 01 00 00 00       	mov    $0x1,%eax
    25c0:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    25c4:	66 0f ef c0          	pxor   %xmm0,%xmm0
    25c8:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    25cc:	e8 af ea ff ff       	callq  1080 <__printf_chk@plt>
    25d1:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    25d5:	ba 05 00 00 00       	mov    $0x5,%edx
    25da:	48 8d 35 87 8d 00 00 	lea    0x8d87(%rip),%rsi        # b368 <_IO_stdin_used+0x368>
    25e1:	4c 89 ef             	mov    %r13,%rdi
    25e4:	e8 47 ea ff ff       	callq  1030 <strncmp@plt>
    25e9:	85 c0                	test   %eax,%eax
    25eb:	0f 85 30 0a 00 00    	jne    3021 <main+0x1f61>
    25f1:	48 8d 35 86 75 00 00 	lea    0x7586(%rip),%rsi        # 9b7e <mul16>
    25f8:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    25fe:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    2603:	e8 38 84 00 00       	callq  aa40 <measureFunction>
    2608:	bf 01 00 00 00       	mov    $0x1,%edi
    260d:	b8 01 00 00 00       	mov    $0x1,%eax
    2612:	48 8d 35 57 8e 00 00 	lea    0x8e57(%rip),%rsi        # b470 <_IO_stdin_used+0x470>
    2619:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    261d:	e8 5e ea ff ff       	callq  1080 <__printf_chk@plt>
    2622:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    2626:	ba 05 00 00 00       	mov    $0x5,%edx
    262b:	48 8d 35 5d 8d 00 00 	lea    0x8d5d(%rip),%rsi        # b38f <_IO_stdin_used+0x38f>
    2632:	4c 89 ef             	mov    %r13,%rdi
    2635:	e8 f6 e9 ff ff       	callq  1030 <strncmp@plt>
    263a:	85 c0                	test   %eax,%eax
    263c:	0f 85 fb 09 00 00    	jne    303d <main+0x1f7d>
    2642:	48 8d 35 e9 75 00 00 	lea    0x75e9(%rip),%rsi        # 9c32 <mul64>
    2649:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    264f:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    2654:	e8 e7 83 00 00       	callq  aa40 <measureFunction>
    2659:	bf 01 00 00 00       	mov    $0x1,%edi
    265e:	b8 01 00 00 00       	mov    $0x1,%eax
    2663:	48 8d 35 eb 8d 00 00 	lea    0x8deb(%rip),%rsi        # b455 <_IO_stdin_used+0x455>
    266a:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    266e:	e8 0d ea ff ff       	callq  1080 <__printf_chk@plt>
    2673:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    2677:	ba 05 00 00 00       	mov    $0x5,%edx
    267c:	48 8d 35 f4 8c 00 00 	lea    0x8cf4(%rip),%rsi        # b377 <_IO_stdin_used+0x377>
    2683:	4c 89 ef             	mov    %r13,%rdi
    2686:	e8 a5 e9 ff ff       	callq  1030 <strncmp@plt>
    268b:	85 c0                	test   %eax,%eax
    268d:	0f 85 c6 09 00 00    	jne    3059 <main+0x1f99>
    2693:	48 8d 35 7a 76 00 00 	lea    0x767a(%rip),%rsi        # 9d14 <mixmul16mul64>
    269a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    26a0:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    26a5:	e8 96 83 00 00       	callq  aa40 <measureFunction>
    26aa:	bf 01 00 00 00       	mov    $0x1,%edi
    26af:	b8 01 00 00 00       	mov    $0x1,%eax
    26b4:	48 8d 35 0d 94 00 00 	lea    0x940d(%rip),%rsi        # bac8 <_IO_stdin_used+0xac8>
    26bb:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    26bf:	e8 bc e9 ff ff       	callq  1080 <__printf_chk@plt>
    26c4:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    26c8:	ba 05 00 00 00       	mov    $0x5,%edx
    26cd:	48 8d 35 b1 8c 00 00 	lea    0x8cb1(%rip),%rsi        # b385 <_IO_stdin_used+0x385>
    26d4:	4c 89 ef             	mov    %r13,%rdi
    26d7:	e8 54 e9 ff ff       	callq  1030 <strncmp@plt>
    26dc:	85 c0                	test   %eax,%eax
    26de:	0f 85 91 09 00 00    	jne    3075 <main+0x1fb5>
    26e4:	48 8d 35 d5 76 00 00 	lea    0x76d5(%rip),%rsi        # 9dc0 <mixmul16mul64_21>
    26eb:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    26f1:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    26f6:	e8 45 83 00 00       	callq  aa40 <measureFunction>
    26fb:	bf 01 00 00 00       	mov    $0x1,%edi
    2700:	b8 01 00 00 00       	mov    $0x1,%eax
    2705:	48 8d 35 8c 93 00 00 	lea    0x938c(%rip),%rsi        # ba98 <_IO_stdin_used+0xa98>
    270c:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2710:	e8 6b e9 ff ff       	callq  1080 <__printf_chk@plt>
    2715:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    2719:	ba 07 00 00 00       	mov    $0x7,%edx
    271e:	48 8d 35 76 8c 00 00 	lea    0x8c76(%rip),%rsi        # b39b <_IO_stdin_used+0x39b>
    2725:	4c 89 ef             	mov    %r13,%rdi
    2728:	e8 03 e9 ff ff       	callq  1030 <strncmp@plt>
    272d:	85 c0                	test   %eax,%eax
    272f:	0f 85 5c 09 00 00    	jne    3091 <main+0x1fd1>
    2735:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    273b:	48 8d 35 2e 82 00 00 	lea    0x822e(%rip),%rsi        # a970 <load128wrapper>
    2742:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    2747:	e8 f4 82 00 00       	callq  aa40 <measureFunction>
    274c:	bf 01 00 00 00       	mov    $0x1,%edi
    2751:	b8 01 00 00 00       	mov    $0x1,%eax
    2756:	48 8d 35 db 8c 00 00 	lea    0x8cdb(%rip),%rsi        # b438 <_IO_stdin_used+0x438>
    275d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2761:	e8 1a e9 ff ff       	callq  1080 <__printf_chk@plt>
    2766:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    276a:	ba 0d 00 00 00       	mov    $0xd,%edx
    276f:	48 8d 35 1f 8c 00 00 	lea    0x8c1f(%rip),%rsi        # b395 <_IO_stdin_used+0x395>
    2776:	4c 89 ef             	mov    %r13,%rdi
    2779:	e8 b2 e8 ff ff       	callq  1030 <strncmp@plt>
    277e:	85 c0                	test   %eax,%eax
    2780:	0f 85 27 09 00 00    	jne    30ad <main+0x1fed>
    2786:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    278c:	48 8d 35 ed 81 00 00 	lea    0x81ed(%rip),%rsi        # a980 <spacedload128wrapper>
    2793:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    2798:	e8 a3 82 00 00       	callq  aa40 <measureFunction>
    279d:	bf 01 00 00 00       	mov    $0x1,%edi
    27a2:	b8 01 00 00 00       	mov    $0x1,%eax
    27a7:	48 8d 35 c2 92 00 00 	lea    0x92c2(%rip),%rsi        # ba70 <_IO_stdin_used+0xa70>
    27ae:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    27b2:	e8 c9 e8 ff ff       	callq  1080 <__printf_chk@plt>
    27b7:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    27bb:	ba 07 00 00 00       	mov    $0x7,%edx
    27c0:	48 8d 35 dc 8b 00 00 	lea    0x8bdc(%rip),%rsi        # b3a3 <_IO_stdin_used+0x3a3>
    27c7:	4c 89 ef             	mov    %r13,%rdi
    27ca:	e8 61 e8 ff ff       	callq  1030 <strncmp@plt>
    27cf:	85 c0                	test   %eax,%eax
    27d1:	0f 85 f2 08 00 00    	jne    30c9 <main+0x2009>
    27d7:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    27dd:	48 8d 35 bc 81 00 00 	lea    0x81bc(%rip),%rsi        # a9a0 <load256wrapper>
    27e4:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    27e9:	e8 52 82 00 00       	callq  aa40 <measureFunction>
    27ee:	bf 01 00 00 00       	mov    $0x1,%edi
    27f3:	b8 01 00 00 00       	mov    $0x1,%eax
    27f8:	48 8d 35 1c 8c 00 00 	lea    0x8c1c(%rip),%rsi        # b41b <_IO_stdin_used+0x41b>
    27ff:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2803:	e8 78 e8 ff ff       	callq  1080 <__printf_chk@plt>
    2808:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    280c:	ba 0d 00 00 00       	mov    $0xd,%edx
    2811:	48 8d 35 93 8b 00 00 	lea    0x8b93(%rip),%rsi        # b3ab <_IO_stdin_used+0x3ab>
    2818:	4c 89 ef             	mov    %r13,%rdi
    281b:	e8 10 e8 ff ff       	callq  1030 <strncmp@plt>
    2820:	85 c0                	test   %eax,%eax
    2822:	0f 85 bd 08 00 00    	jne    30e5 <main+0x2025>
    2828:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    282e:	48 8d 35 5b 81 00 00 	lea    0x815b(%rip),%rsi        # a990 <spacedstorescalarwrapper>
    2835:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    283a:	e8 01 82 00 00       	callq  aa40 <measureFunction>
    283f:	bf 01 00 00 00       	mov    $0x1,%edi
    2844:	b8 01 00 00 00       	mov    $0x1,%eax
    2849:	48 8d 35 f8 91 00 00 	lea    0x91f8(%rip),%rsi        # ba48 <_IO_stdin_used+0xa48>
    2850:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2854:	e8 27 e8 ff ff       	callq  1080 <__printf_chk@plt>
    2859:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    285d:	ba 07 00 00 00       	mov    $0x7,%edx
    2862:	48 8d 35 54 8b 00 00 	lea    0x8b54(%rip),%rsi        # b3bd <_IO_stdin_used+0x3bd>
    2869:	4c 89 ef             	mov    %r13,%rdi
    286c:	e8 bf e7 ff ff       	callq  1030 <strncmp@plt>
    2871:	85 c0                	test   %eax,%eax
    2873:	75 35                	jne    28aa <main+0x17ea>
    2875:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    287b:	48 8d 35 3e 81 00 00 	lea    0x813e(%rip),%rsi        # a9c0 <store128wrapper>
    2882:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    2887:	e8 b4 81 00 00       	callq  aa40 <measureFunction>
    288c:	bf 01 00 00 00       	mov    $0x1,%edi
    2891:	b8 01 00 00 00       	mov    $0x1,%eax
    2896:	48 8d 35 60 8b 00 00 	lea    0x8b60(%rip),%rsi        # b3fd <_IO_stdin_used+0x3fd>
    289d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    28a1:	e8 da e7 ff ff       	callq  1080 <__printf_chk@plt>
    28a6:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    28aa:	ba 07 00 00 00       	mov    $0x7,%edx
    28af:	48 8d 35 10 8b 00 00 	lea    0x8b10(%rip),%rsi        # b3c6 <_IO_stdin_used+0x3c6>
    28b6:	4c 89 ef             	mov    %r13,%rdi
    28b9:	e8 72 e7 ff ff       	callq  1030 <strncmp@plt>
    28be:	85 c0                	test   %eax,%eax
    28c0:	75 3b                	jne    28fd <main+0x183d>
    28c2:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    28c8:	48 8d 35 11 81 00 00 	lea    0x8111(%rip),%rsi        # a9e0 <store256wrapper>
    28cf:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    28d4:	e8 67 81 00 00       	callq  aa40 <measureFunction>
    28d9:	bf 01 00 00 00       	mov    $0x1,%edi
    28de:	b8 01 00 00 00       	mov    $0x1,%eax
    28e3:	48 8d 35 f5 8a 00 00 	lea    0x8af5(%rip),%rsi        # b3df <_IO_stdin_used+0x3df>
    28ea:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    28ee:	e8 8d e7 ff ff       	callq  1080 <__printf_chk@plt>
    28f3:	41 83 ec 01          	sub    $0x1,%r12d
    28f7:	7e 4d                	jle    2946 <main+0x1886>
    28f9:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    28fd:	ba 0f 00 00 00       	mov    $0xf,%edx
    2902:	48 8d 35 c6 8a 00 00 	lea    0x8ac6(%rip),%rsi        # b3cf <_IO_stdin_used+0x3cf>
    2909:	4c 89 ef             	mov    %r13,%rdi
    290c:	e8 1f e7 ff ff       	callq  1030 <strncmp@plt>
    2911:	85 c0                	test   %eax,%eax
    2913:	75 31                	jne    2946 <main+0x1886>
    2915:	48 8d 35 ff 5f 00 00 	lea    0x5fff(%rip),%rsi        # 891b <mixaddmul128int>
    291c:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    2922:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    2927:	e8 14 81 00 00       	callq  aa40 <measureFunction>
    292c:	bf 01 00 00 00       	mov    $0x1,%edi
    2931:	b8 01 00 00 00       	mov    $0x1,%eax
    2936:	48 8d 35 db 90 00 00 	lea    0x90db(%rip),%rsi        # ba18 <_IO_stdin_used+0xa18>
    293d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    2941:	e8 3a e7 ff ff       	callq  1080 <__printf_chk@plt>
    2946:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    294b:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    2952:	00 00 
    2954:	0f 85 ce 3b 00 00    	jne    6528 <main+0x5468>
    295a:	48 83 c4 58          	add    $0x58,%rsp
    295e:	31 c0                	xor    %eax,%eax
    2960:	5b                   	pop    %rbx
    2961:	5d                   	pop    %rbp
    2962:	41 5c                	pop    %r12
    2964:	41 5d                	pop    %r13
    2966:	41 5e                	pop    %r14
    2968:	41 5f                	pop    %r15
    296a:	c3                   	retq   
    296b:	ba 05 00 00 00       	mov    $0x5,%edx
    2970:	48 8d 35 f7 8d 00 00 	lea    0x8df7(%rip),%rsi        # b76e <_IO_stdin_used+0x76e>
    2977:	4c 89 ef             	mov    %r13,%rdi
    297a:	e8 b1 e6 ff ff       	callq  1030 <strncmp@plt>
    297f:	85 c0                	test   %eax,%eax
    2981:	0f 84 34 3b 00 00    	je     64bb <main+0x53fb>
    2987:	f3 0f 10 35 f9 96 00 	movss  0x96f9(%rip),%xmm6        # c088 <_IO_stdin_used+0x1088>
    298e:	00 
    298f:	f3 0f 11 74 24 0c    	movss  %xmm6,0xc(%rsp)
    2995:	f3 0f 11 74 24 08    	movss  %xmm6,0x8(%rsp)
    299b:	ba 05 00 00 00       	mov    $0x5,%edx
    29a0:	48 8d 35 1e 88 00 00 	lea    0x881e(%rip),%rsi        # b1c5 <_IO_stdin_used+0x1c5>
    29a7:	4c 89 ef             	mov    %r13,%rdi
    29aa:	e8 81 e6 ff ff       	callq  1030 <strncmp@plt>
    29af:	85 c0                	test   %eax,%eax
    29b1:	0f 84 43 2f 00 00    	je     58fa <main+0x483a>
    29b7:	ba 03 00 00 00       	mov    $0x3,%edx
    29bc:	48 8d 35 4c 88 00 00 	lea    0x884c(%rip),%rsi        # b20f <_IO_stdin_used+0x20f>
    29c3:	4c 89 ef             	mov    %r13,%rdi
    29c6:	e8 65 e6 ff ff       	callq  1030 <strncmp@plt>
    29cb:	85 c0                	test   %eax,%eax
    29cd:	0f 84 e9 2e 00 00    	je     58bc <main+0x47fc>
    29d3:	48 8d 35 f1 87 00 00 	lea    0x87f1(%rip),%rsi        # b1cb <_IO_stdin_used+0x1cb>
    29da:	4c 89 ef             	mov    %r13,%rdi
    29dd:	e8 7e e6 ff ff       	callq  1060 <strcmp@plt>
    29e2:	85 c0                	test   %eax,%eax
    29e4:	0f 84 91 2e 00 00    	je     587b <main+0x47bb>
    29ea:	48 8d 35 e1 87 00 00 	lea    0x87e1(%rip),%rsi        # b1d2 <_IO_stdin_used+0x1d2>
    29f1:	4c 89 ef             	mov    %r13,%rdi
    29f4:	e8 67 e6 ff ff       	callq  1060 <strcmp@plt>
    29f9:	85 c0                	test   %eax,%eax
    29fb:	0f 84 3c 2e 00 00    	je     583d <main+0x477d>
    2a01:	ba 06 00 00 00       	mov    $0x6,%edx
    2a06:	48 8d 35 ce 87 00 00 	lea    0x87ce(%rip),%rsi        # b1db <_IO_stdin_used+0x1db>
    2a0d:	4c 89 ef             	mov    %r13,%rdi
    2a10:	e8 1b e6 ff ff       	callq  1030 <strncmp@plt>
    2a15:	85 c0                	test   %eax,%eax
    2a17:	0f 84 e2 2d 00 00    	je     57ff <main+0x473f>
    2a1d:	ba 08 00 00 00       	mov    $0x8,%edx
    2a22:	48 8d 35 b0 87 00 00 	lea    0x87b0(%rip),%rsi        # b1d9 <_IO_stdin_used+0x1d9>
    2a29:	4c 89 ef             	mov    %r13,%rdi
    2a2c:	e8 ff e5 ff ff       	callq  1030 <strncmp@plt>
    2a31:	85 c0                	test   %eax,%eax
    2a33:	0f 84 88 2d 00 00    	je     57c1 <main+0x4701>
    2a39:	ba 07 00 00 00       	mov    $0x7,%edx
    2a3e:	48 8d 35 9d 87 00 00 	lea    0x879d(%rip),%rsi        # b1e2 <_IO_stdin_used+0x1e2>
    2a45:	4c 89 ef             	mov    %r13,%rdi
    2a48:	e8 e3 e5 ff ff       	callq  1030 <strncmp@plt>
    2a4d:	85 c0                	test   %eax,%eax
    2a4f:	0f 84 2e 2d 00 00    	je     5783 <main+0x46c3>
    2a55:	ba 07 00 00 00       	mov    $0x7,%edx
    2a5a:	48 8d 35 89 87 00 00 	lea    0x8789(%rip),%rsi        # b1ea <_IO_stdin_used+0x1ea>
    2a61:	4c 89 ef             	mov    %r13,%rdi
    2a64:	e8 c7 e5 ff ff       	callq  1030 <strncmp@plt>
    2a69:	85 c0                	test   %eax,%eax
    2a6b:	0f 84 d4 2c 00 00    	je     5745 <main+0x4685>
    2a71:	ba 07 00 00 00       	mov    $0x7,%edx
    2a76:	48 8d 35 75 87 00 00 	lea    0x8775(%rip),%rsi        # b1f2 <_IO_stdin_used+0x1f2>
    2a7d:	4c 89 ef             	mov    %r13,%rdi
    2a80:	e8 ab e5 ff ff       	callq  1030 <strncmp@plt>
    2a85:	85 c0                	test   %eax,%eax
    2a87:	0f 84 7a 2c 00 00    	je     5707 <main+0x4647>
    2a8d:	ba 06 00 00 00       	mov    $0x6,%edx
    2a92:	48 8d 35 61 87 00 00 	lea    0x8761(%rip),%rsi        # b1fa <_IO_stdin_used+0x1fa>
    2a99:	4c 89 ef             	mov    %r13,%rdi
    2a9c:	e8 8f e5 ff ff       	callq  1030 <strncmp@plt>
    2aa1:	85 c0                	test   %eax,%eax
    2aa3:	0f 84 20 2c 00 00    	je     56c9 <main+0x4609>
    2aa9:	ba 06 00 00 00       	mov    $0x6,%edx
    2aae:	48 8d 35 4c 87 00 00 	lea    0x874c(%rip),%rsi        # b201 <_IO_stdin_used+0x201>
    2ab5:	4c 89 ef             	mov    %r13,%rdi
    2ab8:	e8 73 e5 ff ff       	callq  1030 <strncmp@plt>
    2abd:	85 c0                	test   %eax,%eax
    2abf:	0f 84 c6 2b 00 00    	je     568b <main+0x45cb>
    2ac5:	ba 06 00 00 00       	mov    $0x6,%edx
    2aca:	48 8d 35 96 8c 00 00 	lea    0x8c96(%rip),%rsi        # b767 <_IO_stdin_used+0x767>
    2ad1:	4c 89 ef             	mov    %r13,%rdi
    2ad4:	e8 57 e5 ff ff       	callq  1030 <strncmp@plt>
    2ad9:	85 c0                	test   %eax,%eax
    2adb:	0f 84 6c 2b 00 00    	je     564d <main+0x458d>
    2ae1:	ba 0a 00 00 00       	mov    $0xa,%edx
    2ae6:	48 8d 35 1b 87 00 00 	lea    0x871b(%rip),%rsi        # b208 <_IO_stdin_used+0x208>
    2aed:	4c 89 ef             	mov    %r13,%rdi
    2af0:	e8 3b e5 ff ff       	callq  1030 <strncmp@plt>
    2af5:	85 c0                	test   %eax,%eax
    2af7:	0f 84 12 2b 00 00    	je     560f <main+0x454f>
    2afd:	ba 06 00 00 00       	mov    $0x6,%edx
    2b02:	48 8d 35 0a 87 00 00 	lea    0x870a(%rip),%rsi        # b213 <_IO_stdin_used+0x213>
    2b09:	4c 89 ef             	mov    %r13,%rdi
    2b0c:	e8 1f e5 ff ff       	callq  1030 <strncmp@plt>
    2b11:	85 c0                	test   %eax,%eax
    2b13:	0f 84 b8 2a 00 00    	je     55d1 <main+0x4511>
    2b19:	ba 03 00 00 00       	mov    $0x3,%edx
    2b1e:	48 8d 35 f7 86 00 00 	lea    0x86f7(%rip),%rsi        # b21c <_IO_stdin_used+0x21c>
    2b25:	4c 89 ef             	mov    %r13,%rdi
    2b28:	e8 03 e5 ff ff       	callq  1030 <strncmp@plt>
    2b2d:	85 c0                	test   %eax,%eax
    2b2f:	0f 84 5e 2a 00 00    	je     5593 <main+0x44d3>
    2b35:	ba 05 00 00 00       	mov    $0x5,%edx
    2b3a:	48 8d 35 d9 86 00 00 	lea    0x86d9(%rip),%rsi        # b21a <_IO_stdin_used+0x21a>
    2b41:	4c 89 ef             	mov    %r13,%rdi
    2b44:	e8 e7 e4 ff ff       	callq  1030 <strncmp@plt>
    2b49:	85 c0                	test   %eax,%eax
    2b4b:	0f 84 04 2a 00 00    	je     5555 <main+0x4495>
    2b51:	ba 04 00 00 00       	mov    $0x4,%edx
    2b56:	48 8d 35 c3 86 00 00 	lea    0x86c3(%rip),%rsi        # b220 <_IO_stdin_used+0x220>
    2b5d:	4c 89 ef             	mov    %r13,%rdi
    2b60:	e8 cb e4 ff ff       	callq  1030 <strncmp@plt>
    2b65:	85 c0                	test   %eax,%eax
    2b67:	0f 84 aa 29 00 00    	je     5517 <main+0x4457>
    2b6d:	ba 04 00 00 00       	mov    $0x4,%edx
    2b72:	48 8d 35 ac 86 00 00 	lea    0x86ac(%rip),%rsi        # b225 <_IO_stdin_used+0x225>
    2b79:	4c 89 ef             	mov    %r13,%rdi
    2b7c:	e8 af e4 ff ff       	callq  1030 <strncmp@plt>
    2b81:	85 c0                	test   %eax,%eax
    2b83:	0f 84 50 29 00 00    	je     54d9 <main+0x4419>
    2b89:	ba 07 00 00 00       	mov    $0x7,%edx
    2b8e:	48 8d 35 95 86 00 00 	lea    0x8695(%rip),%rsi        # b22a <_IO_stdin_used+0x22a>
    2b95:	4c 89 ef             	mov    %r13,%rdi
    2b98:	e8 93 e4 ff ff       	callq  1030 <strncmp@plt>
    2b9d:	85 c0                	test   %eax,%eax
    2b9f:	0f 84 f6 28 00 00    	je     549b <main+0x43db>
    2ba5:	ba 03 00 00 00       	mov    $0x3,%edx
    2baa:	48 8d 35 8b 86 00 00 	lea    0x868b(%rip),%rsi        # b23c <_IO_stdin_used+0x23c>
    2bb1:	4c 89 ef             	mov    %r13,%rdi
    2bb4:	e8 77 e4 ff ff       	callq  1030 <strncmp@plt>
    2bb9:	85 c0                	test   %eax,%eax
    2bbb:	0f 84 9c 28 00 00    	je     545d <main+0x439d>
    2bc1:	ba 03 00 00 00       	mov    $0x3,%edx
    2bc6:	48 8d 35 65 86 00 00 	lea    0x8665(%rip),%rsi        # b232 <_IO_stdin_used+0x232>
    2bcd:	4c 89 ef             	mov    %r13,%rdi
    2bd0:	e8 5b e4 ff ff       	callq  1030 <strncmp@plt>
    2bd5:	85 c0                	test   %eax,%eax
    2bd7:	0f 84 42 28 00 00    	je     541f <main+0x435f>
    2bdd:	ba 09 00 00 00       	mov    $0x9,%edx
    2be2:	48 8d 35 4d 86 00 00 	lea    0x864d(%rip),%rsi        # b236 <_IO_stdin_used+0x236>
    2be9:	4c 89 ef             	mov    %r13,%rdi
    2bec:	e8 3f e4 ff ff       	callq  1030 <strncmp@plt>
    2bf1:	85 c0                	test   %eax,%eax
    2bf3:	0f 84 e8 27 00 00    	je     53e1 <main+0x4321>
    2bf9:	ba 03 00 00 00       	mov    $0x3,%edx
    2bfe:	48 8d 35 3b 86 00 00 	lea    0x863b(%rip),%rsi        # b240 <_IO_stdin_used+0x240>
    2c05:	4c 89 ef             	mov    %r13,%rdi
    2c08:	e8 23 e4 ff ff       	callq  1030 <strncmp@plt>
    2c0d:	85 c0                	test   %eax,%eax
    2c0f:	0f 84 8e 27 00 00    	je     53a3 <main+0x42e3>
    2c15:	ba 03 00 00 00       	mov    $0x3,%edx
    2c1a:	48 8d 35 2f 86 00 00 	lea    0x862f(%rip),%rsi        # b250 <_IO_stdin_used+0x250>
    2c21:	4c 89 ef             	mov    %r13,%rdi
    2c24:	e8 07 e4 ff ff       	callq  1030 <strncmp@plt>
    2c29:	85 c0                	test   %eax,%eax
    2c2b:	0f 84 34 27 00 00    	je     5365 <main+0x42a5>
    2c31:	ba 09 00 00 00       	mov    $0x9,%edx
    2c36:	48 8d 35 0d 86 00 00 	lea    0x860d(%rip),%rsi        # b24a <_IO_stdin_used+0x24a>
    2c3d:	4c 89 ef             	mov    %r13,%rdi
    2c40:	e8 eb e3 ff ff       	callq  1030 <strncmp@plt>
    2c45:	85 c0                	test   %eax,%eax
    2c47:	0f 84 da 26 00 00    	je     5327 <main+0x4267>
    2c4d:	ba 09 00 00 00       	mov    $0x9,%edx
    2c52:	48 8d 35 fb 85 00 00 	lea    0x85fb(%rip),%rsi        # b254 <_IO_stdin_used+0x254>
    2c59:	4c 89 ef             	mov    %r13,%rdi
    2c5c:	e8 cf e3 ff ff       	callq  1030 <strncmp@plt>
    2c61:	85 c0                	test   %eax,%eax
    2c63:	0f 84 80 26 00 00    	je     52e9 <main+0x4229>
    2c69:	ba 03 00 00 00       	mov    $0x3,%edx
    2c6e:	48 8d 35 ef 85 00 00 	lea    0x85ef(%rip),%rsi        # b264 <_IO_stdin_used+0x264>
    2c75:	4c 89 ef             	mov    %r13,%rdi
    2c78:	e8 b3 e3 ff ff       	callq  1030 <strncmp@plt>
    2c7d:	85 c0                	test   %eax,%eax
    2c7f:	0f 84 26 26 00 00    	je     52ab <main+0x41eb>
    2c85:	ba 09 00 00 00       	mov    $0x9,%edx
    2c8a:	48 8d 35 cd 85 00 00 	lea    0x85cd(%rip),%rsi        # b25e <_IO_stdin_used+0x25e>
    2c91:	4c 89 ef             	mov    %r13,%rdi
    2c94:	e8 97 e3 ff ff       	callq  1030 <strncmp@plt>
    2c99:	85 c0                	test   %eax,%eax
    2c9b:	0f 84 cc 25 00 00    	je     526d <main+0x41ad>
    2ca1:	ba 09 00 00 00       	mov    $0x9,%edx
    2ca6:	48 8d 35 cd 85 00 00 	lea    0x85cd(%rip),%rsi        # b27a <_IO_stdin_used+0x27a>
    2cad:	4c 89 ef             	mov    %r13,%rdi
    2cb0:	e8 7b e3 ff ff       	callq  1030 <strncmp@plt>
    2cb5:	85 c0                	test   %eax,%eax
    2cb7:	0f 84 72 25 00 00    	je     522f <main+0x416f>
    2cbd:	ba 0c 00 00 00       	mov    $0xc,%edx
    2cc2:	48 8d 35 9f 85 00 00 	lea    0x859f(%rip),%rsi        # b268 <_IO_stdin_used+0x268>
    2cc9:	4c 89 ef             	mov    %r13,%rdi
    2ccc:	e8 5f e3 ff ff       	callq  1030 <strncmp@plt>
    2cd1:	85 c0                	test   %eax,%eax
    2cd3:	0f 84 18 25 00 00    	je     51f1 <main+0x4131>
    2cd9:	ba 0e 00 00 00       	mov    $0xe,%edx
    2cde:	48 8d 35 90 85 00 00 	lea    0x8590(%rip),%rsi        # b275 <_IO_stdin_used+0x275>
    2ce5:	4c 89 ef             	mov    %r13,%rdi
    2ce8:	e8 43 e3 ff ff       	callq  1030 <strncmp@plt>
    2ced:	85 c0                	test   %eax,%eax
    2cef:	0f 84 be 24 00 00    	je     51b3 <main+0x40f3>
    2cf5:	ba 0e 00 00 00       	mov    $0xe,%edx
    2cfa:	48 8d 35 83 85 00 00 	lea    0x8583(%rip),%rsi        # b284 <_IO_stdin_used+0x284>
    2d01:	4c 89 ef             	mov    %r13,%rdi
    2d04:	e8 27 e3 ff ff       	callq  1030 <strncmp@plt>
    2d09:	85 c0                	test   %eax,%eax
    2d0b:	0f 84 64 24 00 00    	je     5175 <main+0x40b5>
    2d11:	ba 08 00 00 00       	mov    $0x8,%edx
    2d16:	48 8d 35 76 85 00 00 	lea    0x8576(%rip),%rsi        # b293 <_IO_stdin_used+0x293>
    2d1d:	4c 89 ef             	mov    %r13,%rdi
    2d20:	e8 0b e3 ff ff       	callq  1030 <strncmp@plt>
    2d25:	85 c0                	test   %eax,%eax
    2d27:	0f 84 0a 24 00 00    	je     5137 <main+0x4077>
    2d2d:	ba 0c 00 00 00       	mov    $0xc,%edx
    2d32:	48 8d 35 63 85 00 00 	lea    0x8563(%rip),%rsi        # b29c <_IO_stdin_used+0x29c>
    2d39:	4c 89 ef             	mov    %r13,%rdi
    2d3c:	e8 ef e2 ff ff       	callq  1030 <strncmp@plt>
    2d41:	85 c0                	test   %eax,%eax
    2d43:	0f 84 a2 23 00 00    	je     50eb <main+0x402b>
    2d49:	ba 0c 00 00 00       	mov    $0xc,%edx
    2d4e:	48 8d 35 54 85 00 00 	lea    0x8554(%rip),%rsi        # b2a9 <_IO_stdin_used+0x2a9>
    2d55:	4c 89 ef             	mov    %r13,%rdi
    2d58:	e8 d3 e2 ff ff       	callq  1030 <strncmp@plt>
    2d5d:	85 c0                	test   %eax,%eax
    2d5f:	0f 84 38 23 00 00    	je     509d <main+0x3fdd>
    2d65:	ba 0c 00 00 00       	mov    $0xc,%edx
    2d6a:	48 8d 35 45 85 00 00 	lea    0x8545(%rip),%rsi        # b2b6 <_IO_stdin_used+0x2b6>
    2d71:	4c 89 ef             	mov    %r13,%rdi
    2d74:	e8 b7 e2 ff ff       	callq  1030 <strncmp@plt>
    2d79:	85 c0                	test   %eax,%eax
    2d7b:	0f 84 d0 22 00 00    	je     5051 <main+0x3f91>
    2d81:	ba 0c 00 00 00       	mov    $0xc,%edx
    2d86:	48 8d 35 36 85 00 00 	lea    0x8536(%rip),%rsi        # b2c3 <_IO_stdin_used+0x2c3>
    2d8d:	4c 89 ef             	mov    %r13,%rdi
    2d90:	e8 9b e2 ff ff       	callq  1030 <strncmp@plt>
    2d95:	85 c0                	test   %eax,%eax
    2d97:	0f 84 66 22 00 00    	je     5003 <main+0x3f43>
    2d9d:	ba 0b 00 00 00       	mov    $0xb,%edx
    2da2:	48 8d 35 27 85 00 00 	lea    0x8527(%rip),%rsi        # b2d0 <_IO_stdin_used+0x2d0>
    2da9:	4c 89 ef             	mov    %r13,%rdi
    2dac:	e8 7f e2 ff ff       	callq  1030 <strncmp@plt>
    2db1:	85 c0                	test   %eax,%eax
    2db3:	0f 84 fc 21 00 00    	je     4fb5 <main+0x3ef5>
    2db9:	ba 0b 00 00 00       	mov    $0xb,%edx
    2dbe:	48 8d 35 17 85 00 00 	lea    0x8517(%rip),%rsi        # b2dc <_IO_stdin_used+0x2dc>
    2dc5:	4c 89 ef             	mov    %r13,%rdi
    2dc8:	e8 63 e2 ff ff       	callq  1030 <strncmp@plt>
    2dcd:	85 c0                	test   %eax,%eax
    2dcf:	0f 84 92 21 00 00    	je     4f67 <main+0x3ea7>
    2dd5:	ba 0b 00 00 00       	mov    $0xb,%edx
    2dda:	48 8d 35 07 85 00 00 	lea    0x8507(%rip),%rsi        # b2e8 <_IO_stdin_used+0x2e8>
    2de1:	4c 89 ef             	mov    %r13,%rdi
    2de4:	e8 47 e2 ff ff       	callq  1030 <strncmp@plt>
    2de9:	85 c0                	test   %eax,%eax
    2deb:	0f 84 28 21 00 00    	je     4f19 <main+0x3e59>
    2df1:	ba 0b 00 00 00       	mov    $0xb,%edx
    2df6:	48 8d 35 f7 84 00 00 	lea    0x84f7(%rip),%rsi        # b2f4 <_IO_stdin_used+0x2f4>
    2dfd:	4c 89 ef             	mov    %r13,%rdi
    2e00:	e8 2b e2 ff ff       	callq  1030 <strncmp@plt>
    2e05:	85 c0                	test   %eax,%eax
    2e07:	0f 84 be 20 00 00    	je     4ecb <main+0x3e0b>
    2e0d:	ba 08 00 00 00       	mov    $0x8,%edx
    2e12:	48 8d 35 d2 84 00 00 	lea    0x84d2(%rip),%rsi        # b2eb <_IO_stdin_used+0x2eb>
    2e19:	4c 89 ef             	mov    %r13,%rdi
    2e1c:	e8 0f e2 ff ff       	callq  1030 <strncmp@plt>
    2e21:	85 c0                	test   %eax,%eax
    2e23:	0f 84 64 20 00 00    	je     4e8d <main+0x3dcd>
    2e29:	ba 08 00 00 00       	mov    $0x8,%edx
    2e2e:	48 8d 35 c2 84 00 00 	lea    0x84c2(%rip),%rsi        # b2f7 <_IO_stdin_used+0x2f7>
    2e35:	4c 89 ef             	mov    %r13,%rdi
    2e38:	e8 f3 e1 ff ff       	callq  1030 <strncmp@plt>
    2e3d:	85 c0                	test   %eax,%eax
    2e3f:	0f 84 0a 20 00 00    	je     4e4f <main+0x3d8f>
    2e45:	ba 09 00 00 00       	mov    $0x9,%edx
    2e4a:	48 8d 35 68 84 00 00 	lea    0x8468(%rip),%rsi        # b2b9 <_IO_stdin_used+0x2b9>
    2e51:	4c 89 ef             	mov    %r13,%rdi
    2e54:	e8 d7 e1 ff ff       	callq  1030 <strncmp@plt>
    2e59:	85 c0                	test   %eax,%eax
    2e5b:	0f 84 b0 1f 00 00    	je     4e11 <main+0x3d51>
    2e61:	ba 09 00 00 00       	mov    $0x9,%edx
    2e66:	48 8d 35 68 85 00 00 	lea    0x8568(%rip),%rsi        # b3d5 <_IO_stdin_used+0x3d5>
    2e6d:	4c 89 ef             	mov    %r13,%rdi
    2e70:	e8 bb e1 ff ff       	callq  1030 <strncmp@plt>
    2e75:	85 c0                	test   %eax,%eax
    2e77:	0f 84 56 1f 00 00    	je     4dd3 <main+0x3d13>
    2e7d:	ba 06 00 00 00       	mov    $0x6,%edx
    2e82:	48 8d 35 7a 84 00 00 	lea    0x847a(%rip),%rsi        # b303 <_IO_stdin_used+0x303>
    2e89:	4c 89 ef             	mov    %r13,%rdi
    2e8c:	e8 9f e1 ff ff       	callq  1030 <strncmp@plt>
    2e91:	85 c0                	test   %eax,%eax
    2e93:	0f 84 fa 1e 00 00    	je     4d93 <main+0x3cd3>
    2e99:	ba 06 00 00 00       	mov    $0x6,%edx
    2e9e:	48 8d 35 0c 83 00 00 	lea    0x830c(%rip),%rsi        # b1b1 <_IO_stdin_used+0x1b1>
    2ea5:	4c 89 ef             	mov    %r13,%rdi
    2ea8:	e8 83 e1 ff ff       	callq  1030 <strncmp@plt>
    2ead:	85 c0                	test   %eax,%eax
    2eaf:	0f 84 9e 1e 00 00    	je     4d53 <main+0x3c93>
    2eb5:	ba 09 00 00 00       	mov    $0x9,%edx
    2eba:	48 8d 35 3f 84 00 00 	lea    0x843f(%rip),%rsi        # b300 <_IO_stdin_used+0x300>
    2ec1:	4c 89 ef             	mov    %r13,%rdi
    2ec4:	e8 67 e1 ff ff       	callq  1030 <strncmp@plt>
    2ec9:	85 c0                	test   %eax,%eax
    2ecb:	0f 84 34 1e 00 00    	je     4d05 <main+0x3c45>
    2ed1:	ba 09 00 00 00       	mov    $0x9,%edx
    2ed6:	48 8d 35 2d 84 00 00 	lea    0x842d(%rip),%rsi        # b30a <_IO_stdin_used+0x30a>
    2edd:	4c 89 ef             	mov    %r13,%rdi
    2ee0:	e8 4b e1 ff ff       	callq  1030 <strncmp@plt>
    2ee5:	85 c0                	test   %eax,%eax
    2ee7:	0f 84 ca 1d 00 00    	je     4cb7 <main+0x3bf7>
    2eed:	ba 06 00 00 00       	mov    $0x6,%edx
    2ef2:	48 8d 35 29 84 00 00 	lea    0x8429(%rip),%rsi        # b322 <_IO_stdin_used+0x322>
    2ef9:	4c 89 ef             	mov    %r13,%rdi
    2efc:	e8 2f e1 ff ff       	callq  1030 <strncmp@plt>
    2f01:	85 c0                	test   %eax,%eax
    2f03:	0f 84 6e 1d 00 00    	je     4c77 <main+0x3bb7>
    2f09:	ba 06 00 00 00       	mov    $0x6,%edx
    2f0e:	48 8d 35 ff 83 00 00 	lea    0x83ff(%rip),%rsi        # b314 <_IO_stdin_used+0x314>
    2f15:	4c 89 ef             	mov    %r13,%rdi
    2f18:	e8 13 e1 ff ff       	callq  1030 <strncmp@plt>
    2f1d:	85 c0                	test   %eax,%eax
    2f1f:	0f 84 12 1d 00 00    	je     4c37 <main+0x3b77>
    2f25:	ba 0c 00 00 00       	mov    $0xc,%edx
    2f2a:	48 8d 35 eb 83 00 00 	lea    0x83eb(%rip),%rsi        # b31c <_IO_stdin_used+0x31c>
    2f31:	4c 89 ef             	mov    %r13,%rdi
    2f34:	e8 f7 e0 ff ff       	callq  1030 <strncmp@plt>
    2f39:	85 c0                	test   %eax,%eax
    2f3b:	0f 84 b2 1c 00 00    	je     4bf3 <main+0x3b33>
    2f41:	ba 0b 00 00 00       	mov    $0xb,%edx
    2f46:	48 8d 35 dd 83 00 00 	lea    0x83dd(%rip),%rsi        # b32a <_IO_stdin_used+0x32a>
    2f4d:	4c 89 ef             	mov    %r13,%rdi
    2f50:	e8 db e0 ff ff       	callq  1030 <strncmp@plt>
    2f55:	85 c0                	test   %eax,%eax
    2f57:	0f 84 52 1c 00 00    	je     4baf <main+0x3aef>
    2f5d:	ba 0e 00 00 00       	mov    $0xe,%edx
    2f62:	48 8d 35 ce 83 00 00 	lea    0x83ce(%rip),%rsi        # b337 <_IO_stdin_used+0x337>
    2f69:	4c 89 ef             	mov    %r13,%rdi
    2f6c:	e8 bf e0 ff ff       	callq  1030 <strncmp@plt>
    2f71:	85 c0                	test   %eax,%eax
    2f73:	0f 84 f2 1b 00 00    	je     4b6b <main+0x3aab>
    2f79:	ba 0b 00 00 00       	mov    $0xb,%edx
    2f7e:	48 8d 35 c2 83 00 00 	lea    0x83c2(%rip),%rsi        # b347 <_IO_stdin_used+0x347>
    2f85:	4c 89 ef             	mov    %r13,%rdi
    2f88:	e8 a3 e0 ff ff       	callq  1030 <strncmp@plt>
    2f8d:	85 c0                	test   %eax,%eax
    2f8f:	0f 84 92 1b 00 00    	je     4b27 <main+0x3a67>
    2f95:	ba 0d 00 00 00       	mov    $0xd,%edx
    2f9a:	48 8d 35 76 81 00 00 	lea    0x8176(%rip),%rsi        # b117 <_IO_stdin_used+0x117>
    2fa1:	4c 89 ef             	mov    %r13,%rdi
    2fa4:	e8 87 e0 ff ff       	callq  1030 <strncmp@plt>
    2fa9:	85 c0                	test   %eax,%eax
    2fab:	0f 84 32 1b 00 00    	je     4ae3 <main+0x3a23>
    2fb1:	ba 0f 00 00 00       	mov    $0xf,%edx
    2fb6:	48 8d 35 97 83 00 00 	lea    0x8397(%rip),%rsi        # b354 <_IO_stdin_used+0x354>
    2fbd:	4c 89 ef             	mov    %r13,%rdi
    2fc0:	e8 6b e0 ff ff       	callq  1030 <strncmp@plt>
    2fc5:	85 c0                	test   %eax,%eax
    2fc7:	0f 84 d6 1a 00 00    	je     4aa3 <main+0x39e3>
    2fcd:	ba 08 00 00 00       	mov    $0x8,%edx
    2fd2:	48 8d 35 8c 83 00 00 	lea    0x838c(%rip),%rsi        # b365 <_IO_stdin_used+0x365>
    2fd9:	4c 89 ef             	mov    %r13,%rdi
    2fdc:	e8 4f e0 ff ff       	callq  1030 <strncmp@plt>
    2fe1:	85 c0                	test   %eax,%eax
    2fe3:	0f 84 6c 1a 00 00    	je     4a55 <main+0x3995>
    2fe9:	ba 08 00 00 00       	mov    $0x8,%edx
    2fee:	48 8d 35 79 83 00 00 	lea    0x8379(%rip),%rsi        # b36e <_IO_stdin_used+0x36e>
    2ff5:	4c 89 ef             	mov    %r13,%rdi
    2ff8:	e8 33 e0 ff ff       	callq  1030 <strncmp@plt>
    2ffd:	85 c0                	test   %eax,%eax
    2fff:	0f 84 02 1a 00 00    	je     4a07 <main+0x3947>
    3005:	ba 05 00 00 00       	mov    $0x5,%edx
    300a:	48 8d 35 57 83 00 00 	lea    0x8357(%rip),%rsi        # b368 <_IO_stdin_used+0x368>
    3011:	4c 89 ef             	mov    %r13,%rdi
    3014:	e8 17 e0 ff ff       	callq  1030 <strncmp@plt>
    3019:	85 c0                	test   %eax,%eax
    301b:	0f 84 a6 19 00 00    	je     49c7 <main+0x3907>
    3021:	ba 05 00 00 00       	mov    $0x5,%edx
    3026:	48 8d 35 62 83 00 00 	lea    0x8362(%rip),%rsi        # b38f <_IO_stdin_used+0x38f>
    302d:	4c 89 ef             	mov    %r13,%rdi
    3030:	e8 fb df ff ff       	callq  1030 <strncmp@plt>
    3035:	85 c0                	test   %eax,%eax
    3037:	0f 84 4a 19 00 00    	je     4987 <main+0x38c7>
    303d:	ba 05 00 00 00       	mov    $0x5,%edx
    3042:	48 8d 35 2e 83 00 00 	lea    0x832e(%rip),%rsi        # b377 <_IO_stdin_used+0x377>
    3049:	4c 89 ef             	mov    %r13,%rdi
    304c:	e8 df df ff ff       	callq  1030 <strncmp@plt>
    3051:	85 c0                	test   %eax,%eax
    3053:	0f 84 ee 18 00 00    	je     4947 <main+0x3887>
    3059:	ba 05 00 00 00       	mov    $0x5,%edx
    305e:	48 8d 35 20 83 00 00 	lea    0x8320(%rip),%rsi        # b385 <_IO_stdin_used+0x385>
    3065:	4c 89 ef             	mov    %r13,%rdi
    3068:	e8 c3 df ff ff       	callq  1030 <strncmp@plt>
    306d:	85 c0                	test   %eax,%eax
    306f:	0f 84 92 18 00 00    	je     4907 <main+0x3847>
    3075:	ba 07 00 00 00       	mov    $0x7,%edx
    307a:	48 8d 35 1a 83 00 00 	lea    0x831a(%rip),%rsi        # b39b <_IO_stdin_used+0x39b>
    3081:	4c 89 ef             	mov    %r13,%rdi
    3084:	e8 a7 df ff ff       	callq  1030 <strncmp@plt>
    3089:	85 c0                	test   %eax,%eax
    308b:	0f 84 36 18 00 00    	je     48c7 <main+0x3807>
    3091:	ba 0d 00 00 00       	mov    $0xd,%edx
    3096:	48 8d 35 f8 82 00 00 	lea    0x82f8(%rip),%rsi        # b395 <_IO_stdin_used+0x395>
    309d:	4c 89 ef             	mov    %r13,%rdi
    30a0:	e8 8b df ff ff       	callq  1030 <strncmp@plt>
    30a5:	85 c0                	test   %eax,%eax
    30a7:	0f 84 da 17 00 00    	je     4887 <main+0x37c7>
    30ad:	ba 07 00 00 00       	mov    $0x7,%edx
    30b2:	48 8d 35 ea 82 00 00 	lea    0x82ea(%rip),%rsi        # b3a3 <_IO_stdin_used+0x3a3>
    30b9:	4c 89 ef             	mov    %r13,%rdi
    30bc:	e8 6f df ff ff       	callq  1030 <strncmp@plt>
    30c1:	85 c0                	test   %eax,%eax
    30c3:	0f 84 7e 17 00 00    	je     4847 <main+0x3787>
    30c9:	ba 0d 00 00 00       	mov    $0xd,%edx
    30ce:	48 8d 35 d6 82 00 00 	lea    0x82d6(%rip),%rsi        # b3ab <_IO_stdin_used+0x3ab>
    30d5:	4c 89 ef             	mov    %r13,%rdi
    30d8:	e8 53 df ff ff       	callq  1030 <strncmp@plt>
    30dd:	85 c0                	test   %eax,%eax
    30df:	0f 84 22 17 00 00    	je     4807 <main+0x3747>
    30e5:	ba 07 00 00 00       	mov    $0x7,%edx
    30ea:	48 8d 35 cc 82 00 00 	lea    0x82cc(%rip),%rsi        # b3bd <_IO_stdin_used+0x3bd>
    30f1:	4c 89 ef             	mov    %r13,%rdi
    30f4:	e8 37 df ff ff       	callq  1030 <strncmp@plt>
    30f9:	85 c0                	test   %eax,%eax
    30fb:	0f 85 a9 f7 ff ff    	jne    28aa <main+0x17ea>
    3101:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3107:	48 8d 35 b2 78 00 00 	lea    0x78b2(%rip),%rsi        # a9c0 <store128wrapper>
    310e:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    3113:	e8 28 79 00 00       	callq  aa40 <measureFunction>
    3118:	bf 01 00 00 00       	mov    $0x1,%edi
    311d:	b8 01 00 00 00       	mov    $0x1,%eax
    3122:	48 8d 35 d4 82 00 00 	lea    0x82d4(%rip),%rsi        # b3fd <_IO_stdin_used+0x3fd>
    3129:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    312d:	e8 4e df ff ff       	callq  1080 <__printf_chk@plt>
    3132:	41 83 fc 01          	cmp    $0x1,%r12d
    3136:	0f 8f 6a f7 ff ff    	jg     28a6 <main+0x17e6>
    313c:	e9 05 f8 ff ff       	jmpq   2946 <main+0x1886>
    3141:	48 8b 0d 98 af 00 00 	mov    0xaf98(%rip),%rcx        # e0e0 <stderr@@GLIBC_2.2.5>
    3148:	ba 11 00 00 00       	mov    $0x11,%edx
    314d:	be 01 00 00 00       	mov    $0x1,%esi
    3152:	48 8d 3d f2 7e 00 00 	lea    0x7ef2(%rip),%rdi        # b04b <_IO_stdin_used+0x4b>
    3159:	e8 32 df ff ff       	callq  1090 <fwrite@plt>
    315e:	41 83 fc 01          	cmp    $0x1,%r12d
    3162:	0f 84 48 33 00 00    	je     64b0 <main+0x53f0>
    3168:	f2 0f 10 05 10 8f 00 	movsd  0x8f10(%rip),%xmm0        # c080 <_IO_stdin_used+0x1080>
    316f:	00 
    3170:	bf 01 00 00 00       	mov    $0x1,%edi
    3175:	b8 01 00 00 00       	mov    $0x1,%eax
    317a:	48 8d 35 f7 85 00 00 	lea    0x85f7(%rip),%rsi        # b778 <_IO_stdin_used+0x778>
    3181:	e8 fa de ff ff       	callq  1080 <__printf_chk@plt>
    3186:	41 83 fc 01          	cmp    $0x1,%r12d
    318a:	0f 8e b6 f7 ff ff    	jle    2946 <main+0x1886>
    3190:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    3194:	ba 06 00 00 00       	mov    $0x6,%edx
    3199:	48 8d 35 70 7f 00 00 	lea    0x7f70(%rip),%rsi        # b110 <_IO_stdin_used+0x110>
    31a0:	4c 89 ef             	mov    %r13,%rdi
    31a3:	e8 88 de ff ff       	callq  1030 <strncmp@plt>
    31a8:	85 c0                	test   %eax,%eax
    31aa:	75 37                	jne    31e3 <main+0x2123>
    31ac:	48 8d 35 44 5a 00 00 	lea    0x5a44(%rip),%rsi        # 8bf7 <fma512>
    31b3:	f3 0f 10 05 cd 8e 00 	movss  0x8ecd(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    31ba:	00 
    31bb:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    31c0:	e8 7b 78 00 00       	callq  aa40 <measureFunction>
    31c5:	bf 01 00 00 00       	mov    $0x1,%edi
    31ca:	b8 01 00 00 00       	mov    $0x1,%eax
    31cf:	48 8d 35 87 7e 00 00 	lea    0x7e87(%rip),%rsi        # b05d <_IO_stdin_used+0x5d>
    31d6:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    31da:	e8 a1 de ff ff       	callq  1080 <__printf_chk@plt>
    31df:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    31e3:	ba 09 00 00 00       	mov    $0x9,%edx
    31e8:	48 8d 35 0e 7f 00 00 	lea    0x7f0e(%rip),%rsi        # b0fd <_IO_stdin_used+0xfd>
    31ef:	4c 89 ef             	mov    %r13,%rdi
    31f2:	e8 39 de ff ff       	callq  1030 <strncmp@plt>
    31f7:	85 c0                	test   %eax,%eax
    31f9:	0f 84 63 15 00 00    	je     4762 <main+0x36a2>
    31ff:	ba 0f 00 00 00       	mov    $0xf,%edx
    3204:	48 8d 35 fc 7e 00 00 	lea    0x7efc(%rip),%rsi        # b107 <_IO_stdin_used+0x107>
    320b:	4c 89 ef             	mov    %r13,%rdi
    320e:	e8 1d de ff ff       	callq  1030 <strncmp@plt>
    3213:	85 c0                	test   %eax,%eax
    3215:	0f 85 01 32 00 00    	jne    641c <main+0x535c>
    321b:	48 8d 35 b6 5a 00 00 	lea    0x5ab6(%rip),%rsi        # 8cd8 <mixfma256fma512>
    3222:	f3 0f 10 05 5e 8e 00 	movss  0x8e5e(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    3229:	00 
    322a:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    322f:	e8 0c 78 00 00       	callq  aa40 <measureFunction>
    3234:	bf 01 00 00 00       	mov    $0x1,%edi
    3239:	b8 01 00 00 00       	mov    $0x1,%eax
    323e:	48 8d 35 83 85 00 00 	lea    0x8583(%rip),%rsi        # b7c8 <_IO_stdin_used+0x7c8>
    3245:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3249:	e8 32 de ff ff       	callq  1080 <__printf_chk@plt>
    324e:	41 83 fc 01          	cmp    $0x1,%r12d
    3252:	0f 8e ee f6 ff ff    	jle    2946 <main+0x1886>
    3258:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    325c:	ba 0d 00 00 00       	mov    $0xd,%edx
    3261:	48 8d 35 af 7e 00 00 	lea    0x7eaf(%rip),%rsi        # b117 <_IO_stdin_used+0x117>
    3268:	4c 89 ef             	mov    %r13,%rdi
    326b:	e8 c0 dd ff ff       	callq  1030 <strncmp@plt>
    3270:	85 c0                	test   %eax,%eax
    3272:	0f 85 4a 31 00 00    	jne    63c2 <main+0x5302>
    3278:	48 8d 35 4a 62 00 00 	lea    0x624a(%rip),%rsi        # 94c9 <nemesfpu512mix21>
    327f:	f3 0f 10 05 01 8e 00 	movss  0x8e01(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    3286:	00 
    3287:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    328c:	48 c1 e7 09          	shl    $0x9,%rdi
    3290:	e8 ab 77 00 00       	callq  aa40 <measureFunction>
    3295:	bf 01 00 00 00       	mov    $0x1,%edi
    329a:	b8 01 00 00 00       	mov    $0x1,%eax
    329f:	48 8d 35 4a 85 00 00 	lea    0x854a(%rip),%rsi        # b7f0 <_IO_stdin_used+0x7f0>
    32a6:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    32aa:	e8 d1 dd ff ff       	callq  1080 <__printf_chk@plt>
    32af:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    32b3:	ba 09 00 00 00       	mov    $0x9,%edx
    32b8:	48 8d 35 69 7e 00 00 	lea    0x7e69(%rip),%rsi        # b128 <_IO_stdin_used+0x128>
    32bf:	4c 89 ef             	mov    %r13,%rdi
    32c2:	e8 69 dd ff ff       	callq  1030 <strncmp@plt>
    32c7:	85 c0                	test   %eax,%eax
    32c9:	0f 85 8b 30 00 00    	jne    635a <main+0x529a>
    32cf:	48 8d 35 b7 47 00 00 	lea    0x47b7(%rip),%rsi        # 7a8d <add512int>
    32d6:	f3 0f 10 05 aa 8d 00 	movss  0x8daa(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    32dd:	00 
    32de:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    32e3:	e8 58 77 00 00       	callq  aa40 <measureFunction>
    32e8:	bf 01 00 00 00       	mov    $0x1,%edi
    32ed:	b8 01 00 00 00       	mov    $0x1,%eax
    32f2:	48 8d 35 27 85 00 00 	lea    0x8527(%rip),%rsi        # b820 <_IO_stdin_used+0x820>
    32f9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    32fd:	e8 7e dd ff ff       	callq  1080 <__printf_chk@plt>
    3302:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    3306:	ba 0c 00 00 00       	mov    $0xc,%edx
    330b:	48 8d 35 13 7e 00 00 	lea    0x7e13(%rip),%rsi        # b125 <_IO_stdin_used+0x125>
    3312:	4c 89 ef             	mov    %r13,%rdi
    3315:	e8 16 dd ff ff       	callq  1030 <strncmp@plt>
    331a:	85 c0                	test   %eax,%eax
    331c:	0f 85 de 2f 00 00    	jne    6300 <main+0x5240>
    3322:	48 8d 35 87 4b 00 00 	lea    0x4b87(%rip),%rsi        # 7eb0 <latadd256int>
    3329:	f3 0f 10 05 57 8d 00 	movss  0x8d57(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    3330:	00 
    3331:	4c 89 f7             	mov    %r14,%rdi
    3334:	e8 07 77 00 00       	callq  aa40 <measureFunction>
    3339:	bf 01 00 00 00       	mov    $0x1,%edi
    333e:	b8 01 00 00 00       	mov    $0x1,%eax
    3343:	f3 0f 10 0d 3d 8d 00 	movss  0x8d3d(%rip),%xmm1        # c088 <_IO_stdin_used+0x1088>
    334a:	00 
    334b:	48 8d 35 ee 84 00 00 	lea    0x84ee(%rip),%rsi        # b840 <_IO_stdin_used+0x840>
    3352:	f3 0f 5e c8          	divss  %xmm0,%xmm1
    3356:	66 0f ef c0          	pxor   %xmm0,%xmm0
    335a:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    335e:	e8 1d dd ff ff       	callq  1080 <__printf_chk@plt>
    3363:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    3367:	ba 09 00 00 00       	mov    $0x9,%edx
    336c:	48 8d 35 d0 7d 00 00 	lea    0x7dd0(%rip),%rsi        # b143 <_IO_stdin_used+0x143>
    3373:	4c 89 ef             	mov    %r13,%rdi
    3376:	e8 b5 dc ff ff       	callq  1030 <strncmp@plt>
    337b:	85 c0                	test   %eax,%eax
    337d:	0f 85 1f 2f 00 00    	jne    62a2 <main+0x51e2>
    3383:	48 8d 35 87 45 00 00 	lea    0x4587(%rip),%rsi        # 7911 <mul512int>
    338a:	f3 0f 10 05 f6 8c 00 	movss  0x8cf6(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    3391:	00 
    3392:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    3397:	e8 a4 76 00 00       	callq  aa40 <measureFunction>
    339c:	bf 01 00 00 00       	mov    $0x1,%edi
    33a1:	b8 01 00 00 00       	mov    $0x1,%eax
    33a6:	48 8d 35 bb 84 00 00 	lea    0x84bb(%rip),%rsi        # b868 <_IO_stdin_used+0x868>
    33ad:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    33b1:	e8 ca dc ff ff       	callq  1080 <__printf_chk@plt>
    33b6:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    33ba:	ba 09 00 00 00       	mov    $0x9,%edx
    33bf:	48 8d 35 8a 7d 00 00 	lea    0x7d8a(%rip),%rsi        # b150 <_IO_stdin_used+0x150>
    33c6:	4c 89 ef             	mov    %r13,%rdi
    33c9:	e8 62 dc ff ff       	callq  1030 <strncmp@plt>
    33ce:	85 c0                	test   %eax,%eax
    33d0:	0f 85 5a 2e 00 00    	jne    6230 <main+0x5170>
    33d6:	48 8d 35 f2 45 00 00 	lea    0x45f2(%rip),%rsi        # 79cf <muldq512int>
    33dd:	f3 0f 10 05 a3 8c 00 	movss  0x8ca3(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    33e4:	00 
    33e5:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    33ea:	e8 51 76 00 00       	callq  aa40 <measureFunction>
    33ef:	bf 01 00 00 00       	mov    $0x1,%edi
    33f4:	b8 01 00 00 00       	mov    $0x1,%eax
    33f9:	48 8d 35 90 84 00 00 	lea    0x8490(%rip),%rsi        # b890 <_IO_stdin_used+0x890>
    3400:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3404:	e8 77 dc ff ff       	callq  1080 <__printf_chk@plt>
    3409:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    340d:	ba 0d 00 00 00       	mov    $0xd,%edx
    3412:	48 8d 35 19 7d 00 00 	lea    0x7d19(%rip),%rsi        # b132 <_IO_stdin_used+0x132>
    3419:	4c 89 ef             	mov    %r13,%rdi
    341c:	e8 0f dc ff ff       	callq  1030 <strncmp@plt>
    3421:	85 c0                	test   %eax,%eax
    3423:	0f 85 99 2d 00 00    	jne    61c2 <main+0x5102>
    3429:	48 8d 35 99 4d 00 00 	lea    0x4d99(%rip),%rsi        # 81c9 <latmulq512int>
    3430:	f3 0f 10 05 50 8c 00 	movss  0x8c50(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    3437:	00 
    3438:	4c 89 f7             	mov    %r14,%rdi
    343b:	e8 00 76 00 00       	callq  aa40 <measureFunction>
    3440:	bf 01 00 00 00       	mov    $0x1,%edi
    3445:	b8 01 00 00 00       	mov    $0x1,%eax
    344a:	f3 0f 10 3d 36 8c 00 	movss  0x8c36(%rip),%xmm7        # c088 <_IO_stdin_used+0x1088>
    3451:	00 
    3452:	48 8d 35 67 84 00 00 	lea    0x8467(%rip),%rsi        # b8c0 <_IO_stdin_used+0x8c0>
    3459:	f3 0f 11 7c 24 0c    	movss  %xmm7,0xc(%rsp)
    345f:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    3463:	66 0f ef c0          	pxor   %xmm0,%xmm0
    3467:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    346b:	e8 10 dc ff ff       	callq  1080 <__printf_chk@plt>
    3470:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    3474:	ba 0c 00 00 00       	mov    $0xc,%edx
    3479:	48 8d 35 c0 7c 00 00 	lea    0x7cc0(%rip),%rsi        # b140 <_IO_stdin_used+0x140>
    3480:	4c 89 ef             	mov    %r13,%rdi
    3483:	e8 a8 db ff ff       	callq  1030 <strncmp@plt>
    3488:	85 c0                	test   %eax,%eax
    348a:	0f 85 ca 2c 00 00    	jne    615a <main+0x509a>
    3490:	48 8d 35 8e 4b 00 00 	lea    0x4b8e(%rip),%rsi        # 8025 <latmul512int>
    3497:	f3 0f 10 05 e9 8b 00 	movss  0x8be9(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    349e:	00 
    349f:	4c 89 f7             	mov    %r14,%rdi
    34a2:	e8 99 75 00 00       	callq  aa40 <measureFunction>
    34a7:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    34ad:	bf 01 00 00 00       	mov    $0x1,%edi
    34b2:	48 8d 35 37 84 00 00 	lea    0x8437(%rip),%rsi        # b8f0 <_IO_stdin_used+0x8f0>
    34b9:	b8 01 00 00 00       	mov    $0x1,%eax
    34be:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    34c2:	66 0f ef c0          	pxor   %xmm0,%xmm0
    34c6:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    34ca:	e8 b1 db ff ff       	callq  1080 <__printf_chk@plt>
    34cf:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    34d3:	ba 0d 00 00 00       	mov    $0xd,%edx
    34d8:	48 8d 35 6e 7c 00 00 	lea    0x7c6e(%rip),%rsi        # b14d <_IO_stdin_used+0x14d>
    34df:	4c 89 ef             	mov    %r13,%rdi
    34e2:	e8 49 db ff ff       	callq  1030 <strncmp@plt>
    34e7:	85 c0                	test   %eax,%eax
    34e9:	0f 85 0d 2c 00 00    	jne    60fc <main+0x503c>
    34ef:	48 8d 35 01 4c 00 00 	lea    0x4c01(%rip),%rsi        # 80f7 <latmuldq512int>
    34f6:	f3 0f 10 05 8a 8b 00 	movss  0x8b8a(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    34fd:	00 
    34fe:	4c 89 f7             	mov    %r14,%rdi
    3501:	e8 3a 75 00 00       	callq  aa40 <measureFunction>
    3506:	f3 0f 10 74 24 0c    	movss  0xc(%rsp),%xmm6
    350c:	bf 01 00 00 00       	mov    $0x1,%edi
    3511:	48 8d 35 08 84 00 00 	lea    0x8408(%rip),%rsi        # b920 <_IO_stdin_used+0x920>
    3518:	b8 01 00 00 00       	mov    $0x1,%eax
    351d:	f3 0f 5e f0          	divss  %xmm0,%xmm6
    3521:	66 0f ef c0          	pxor   %xmm0,%xmm0
    3525:	f3 0f 5a c6          	cvtss2sd %xmm6,%xmm0
    3529:	e8 52 db ff ff       	callq  1080 <__printf_chk@plt>
    352e:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    3532:	ba 0b 00 00 00       	mov    $0xb,%edx
    3537:	48 8d 35 1e 7c 00 00 	lea    0x7c1e(%rip),%rsi        # b15c <_IO_stdin_used+0x15c>
    353e:	4c 89 ef             	mov    %r13,%rdi
    3541:	e8 ea da ff ff       	callq  1030 <strncmp@plt>
    3546:	85 c0                	test   %eax,%eax
    3548:	0f 85 50 2b 00 00    	jne    609e <main+0x4fde>
    354e:	48 8d 35 cd 5a 00 00 	lea    0x5acd(%rip),%rsi        # 9022 <mixfmaadd512>
    3555:	f3 0f 10 05 2b 8b 00 	movss  0x8b2b(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    355c:	00 
    355d:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    3562:	48 c1 e7 09          	shl    $0x9,%rdi
    3566:	e8 d5 74 00 00       	callq  aa40 <measureFunction>
    356b:	bf 01 00 00 00       	mov    $0x1,%edi
    3570:	b8 01 00 00 00       	mov    $0x1,%eax
    3575:	48 8d 35 dc 83 00 00 	lea    0x83dc(%rip),%rsi        # b958 <_IO_stdin_used+0x958>
    357c:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3580:	e8 fb da ff ff       	callq  1080 <__printf_chk@plt>
    3585:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    3589:	ba 0b 00 00 00       	mov    $0xb,%edx
    358e:	48 8d 35 d4 7b 00 00 	lea    0x7bd4(%rip),%rsi        # b169 <_IO_stdin_used+0x169>
    3595:	4c 89 ef             	mov    %r13,%rdi
    3598:	e8 93 da ff ff       	callq  1030 <strncmp@plt>
    359d:	85 c0                	test   %eax,%eax
    359f:	0f 85 9f 2a 00 00    	jne    6044 <main+0x4f84>
    35a5:	48 8d 35 57 5b 00 00 	lea    0x5b57(%rip),%rsi        # 9103 <mixfma512add256>
    35ac:	f3 0f 10 05 d4 8a 00 	movss  0x8ad4(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    35b3:	00 
    35b4:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    35b9:	48 c1 e7 09          	shl    $0x9,%rdi
    35bd:	e8 7e 74 00 00       	callq  aa40 <measureFunction>
    35c2:	bf 01 00 00 00       	mov    $0x1,%edi
    35c7:	b8 01 00 00 00       	mov    $0x1,%eax
    35cc:	48 8d 35 ad 83 00 00 	lea    0x83ad(%rip),%rsi        # b980 <_IO_stdin_used+0x980>
    35d3:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    35d7:	e8 a4 da ff ff       	callq  1080 <__printf_chk@plt>
    35dc:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    35e0:	ba 07 00 00 00       	mov    $0x7,%edx
    35e5:	48 8d 35 8d 7b 00 00 	lea    0x7b8d(%rip),%rsi        # b179 <_IO_stdin_used+0x179>
    35ec:	4c 89 ef             	mov    %r13,%rdi
    35ef:	e8 3c da ff ff       	callq  1030 <strncmp@plt>
    35f4:	85 c0                	test   %eax,%eax
    35f6:	0f 85 ee 29 00 00    	jne    5fea <main+0x4f2a>
    35fc:	f3 0f 10 05 84 8a 00 	movss  0x8a84(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    3603:	00 
    3604:	48 8d 35 a5 73 00 00 	lea    0x73a5(%rip),%rsi        # a9b0 <load512wrapper>
    360b:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    3610:	e8 2b 74 00 00       	callq  aa40 <measureFunction>
    3615:	bf 01 00 00 00       	mov    $0x1,%edi
    361a:	b8 01 00 00 00       	mov    $0x1,%eax
    361f:	48 8d 35 52 7a 00 00 	lea    0x7a52(%rip),%rsi        # b078 <_IO_stdin_used+0x78>
    3626:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    362a:	e8 51 da ff ff       	callq  1080 <__printf_chk@plt>
    362f:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    3633:	ba 07 00 00 00       	mov    $0x7,%edx
    3638:	48 8d 35 42 7b 00 00 	lea    0x7b42(%rip),%rsi        # b181 <_IO_stdin_used+0x181>
    363f:	4c 89 ef             	mov    %r13,%rdi
    3642:	e8 e9 d9 ff ff       	callq  1030 <strncmp@plt>
    3647:	85 c0                	test   %eax,%eax
    3649:	0f 85 41 29 00 00    	jne    5f90 <main+0x4ed0>
    364f:	f3 0f 10 05 31 8a 00 	movss  0x8a31(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    3656:	00 
    3657:	48 8d 35 a2 73 00 00 	lea    0x73a2(%rip),%rsi        # aa00 <store512wrapper>
    365e:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    3663:	e8 d8 73 00 00       	callq  aa40 <measureFunction>
    3668:	bf 01 00 00 00       	mov    $0x1,%edi
    366d:	b8 01 00 00 00       	mov    $0x1,%eax
    3672:	48 8d 35 1c 7a 00 00 	lea    0x7a1c(%rip),%rsi        # b095 <_IO_stdin_used+0x95>
    3679:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    367d:	e8 fe d9 ff ff       	callq  1080 <__printf_chk@plt>
    3682:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    3686:	ba 09 00 00 00       	mov    $0x9,%edx
    368b:	48 8d 35 f8 7a 00 00 	lea    0x7af8(%rip),%rsi        # b18a <_IO_stdin_used+0x18a>
    3692:	4c 89 ef             	mov    %r13,%rdi
    3695:	e8 96 d9 ff ff       	callq  1030 <strncmp@plt>
    369a:	85 c0                	test   %eax,%eax
    369c:	0f 85 94 28 00 00    	jne    5f36 <main+0x4e76>
    36a2:	48 8d 35 76 4d 00 00 	lea    0x4d76(%rip),%rsi        # 841f <aesenc128>
    36a9:	f3 0f 10 05 d7 89 00 	movss  0x89d7(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    36b0:	00 
    36b1:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    36b6:	e8 85 73 00 00       	callq  aa40 <measureFunction>
    36bb:	bf 01 00 00 00       	mov    $0x1,%edi
    36c0:	b8 01 00 00 00       	mov    $0x1,%eax
    36c5:	48 8d 35 e7 79 00 00 	lea    0x79e7(%rip),%rsi        # b0b3 <_IO_stdin_used+0xb3>
    36cc:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    36d0:	e8 ab d9 ff ff       	callq  1080 <__printf_chk@plt>
    36d5:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    36d9:	ba 09 00 00 00       	mov    $0x9,%edx
    36de:	48 8d 35 af 7a 00 00 	lea    0x7aaf(%rip),%rsi        # b194 <_IO_stdin_used+0x194>
    36e5:	4c 89 ef             	mov    %r13,%rdi
    36e8:	e8 43 d9 ff ff       	callq  1030 <strncmp@plt>
    36ed:	85 c0                	test   %eax,%eax
    36ef:	0f 85 e7 27 00 00    	jne    5edc <main+0x4e1c>
    36f5:	48 8d 35 87 50 00 00 	lea    0x5087(%rip),%rsi        # 8783 <aesdec128>
    36fc:	f3 0f 10 05 84 89 00 	movss  0x8984(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    3703:	00 
    3704:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    3709:	e8 32 73 00 00       	callq  aa40 <measureFunction>
    370e:	bf 01 00 00 00       	mov    $0x1,%edi
    3713:	b8 01 00 00 00       	mov    $0x1,%eax
    3718:	48 8d 35 aa 79 00 00 	lea    0x79aa(%rip),%rsi        # b0c9 <_IO_stdin_used+0xc9>
    371f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3723:	e8 58 d9 ff ff       	callq  1080 <__printf_chk@plt>
    3728:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    372c:	ba 0c 00 00 00       	mov    $0xc,%edx
    3731:	48 8d 35 66 7a 00 00 	lea    0x7a66(%rip),%rsi        # b19e <_IO_stdin_used+0x19e>
    3738:	4c 89 ef             	mov    %r13,%rdi
    373b:	e8 f0 d8 ff ff       	callq  1030 <strncmp@plt>
    3740:	85 c0                	test   %eax,%eax
    3742:	0f 85 3a 27 00 00    	jne    5e82 <main+0x4dc2>
    3748:	48 8d 35 6a 4d 00 00 	lea    0x4d6a(%rip),%rsi        # 84b9 <aesencadd128>
    374f:	f3 0f 10 05 31 89 00 	movss  0x8931(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    3756:	00 
    3757:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    375c:	e8 df 72 00 00       	callq  aa40 <measureFunction>
    3761:	bf 01 00 00 00       	mov    $0x1,%edi
    3766:	b8 01 00 00 00       	mov    $0x1,%eax
    376b:	48 8d 35 3e 82 00 00 	lea    0x823e(%rip),%rsi        # b9b0 <_IO_stdin_used+0x9b0>
    3772:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3776:	e8 05 d9 ff ff       	callq  1080 <__printf_chk@plt>
    377b:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    377f:	ba 0c 00 00 00       	mov    $0xc,%edx
    3784:	48 8d 35 20 7a 00 00 	lea    0x7a20(%rip),%rsi        # b1ab <_IO_stdin_used+0x1ab>
    378b:	4c 89 ef             	mov    %r13,%rdi
    378e:	e8 9d d8 ff ff       	callq  1030 <strncmp@plt>
    3793:	85 c0                	test   %eax,%eax
    3795:	0f 85 89 26 00 00    	jne    5e24 <main+0x4d64>
    379b:	48 8d 35 d1 4d 00 00 	lea    0x4dd1(%rip),%rsi        # 8573 <aesencfma128>
    37a2:	f3 0f 10 05 de 88 00 	movss  0x88de(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    37a9:	00 
    37aa:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    37af:	e8 8c 72 00 00       	callq  aa40 <measureFunction>
    37b4:	bf 01 00 00 00       	mov    $0x1,%edi
    37b9:	b8 01 00 00 00       	mov    $0x1,%eax
    37be:	48 8d 35 1a 79 00 00 	lea    0x791a(%rip),%rsi        # b0df <_IO_stdin_used+0xdf>
    37c5:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    37c9:	e8 b2 d8 ff ff       	callq  1080 <__printf_chk@plt>
    37ce:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    37d2:	ba 0c 00 00 00       	mov    $0xc,%edx
    37d7:	48 8d 35 da 79 00 00 	lea    0x79da(%rip),%rsi        # b1b8 <_IO_stdin_used+0x1b8>
    37de:	4c 89 ef             	mov    %r13,%rdi
    37e1:	e8 4a d8 ff ff       	callq  1030 <strncmp@plt>
    37e6:	85 c0                	test   %eax,%eax
    37e8:	0f 85 7d f1 ff ff    	jne    296b <main+0x18ab>
    37ee:	48 8d 35 f8 4e 00 00 	lea    0x4ef8(%rip),%rsi        # 86ed <aesencmul128>
    37f5:	f3 0f 10 05 8b 88 00 	movss  0x888b(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    37fc:	00 
    37fd:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    3802:	e8 39 72 00 00       	callq  aa40 <measureFunction>
    3807:	bf 01 00 00 00       	mov    $0x1,%edi
    380c:	b8 01 00 00 00       	mov    $0x1,%eax
    3811:	48 8d 35 b8 81 00 00 	lea    0x81b8(%rip),%rsi        # b9d0 <_IO_stdin_used+0x9d0>
    3818:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    381c:	e8 5f d8 ff ff       	callq  1080 <__printf_chk@plt>
    3821:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    3825:	ba 0c 00 00 00       	mov    $0xc,%edx
    382a:	48 8d 35 87 79 00 00 	lea    0x7987(%rip),%rsi        # b1b8 <_IO_stdin_used+0x1b8>
    3831:	4c 89 ef             	mov    %r13,%rdi
    3834:	e8 f7 d7 ff ff       	callq  1030 <strncmp@plt>
    3839:	85 c0                	test   %eax,%eax
    383b:	0f 85 ce 2c 00 00    	jne    650f <main+0x544f>
    3841:	f3 0f 10 35 3f 88 00 	movss  0x883f(%rip),%xmm6        # c088 <_IO_stdin_used+0x1088>
    3848:	00 
    3849:	f3 0f 11 74 24 0c    	movss  %xmm6,0xc(%rsp)
    384f:	f3 0f 11 74 24 08    	movss  %xmm6,0x8(%rsp)
    3855:	48 8d 35 d8 4d 00 00 	lea    0x4dd8(%rip),%rsi        # 8634 <aesencfadd128>
    385c:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3862:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    3867:	e8 d4 71 00 00       	callq  aa40 <measureFunction>
    386c:	bf 01 00 00 00       	mov    $0x1,%edi
    3871:	b8 01 00 00 00       	mov    $0x1,%eax
    3876:	48 8d 35 7b 81 00 00 	lea    0x817b(%rip),%rsi        # b9f8 <_IO_stdin_used+0x9f8>
    387d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3881:	e8 fa d7 ff ff       	callq  1080 <__printf_chk@plt>
    3886:	41 83 fc 01          	cmp    $0x1,%r12d
    388a:	0f 85 3e d9 ff ff    	jne    11ce <main+0x10e>
    3890:	48 8d 35 e1 34 00 00 	lea    0x34e1(%rip),%rsi        # 6d78 <noptest1b>
    3897:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    389d:	4c 89 f7             	mov    %r14,%rdi
    38a0:	e8 9b 71 00 00       	callq  aa40 <measureFunction>
    38a5:	bf 01 00 00 00       	mov    $0x1,%edi
    38aa:	b8 01 00 00 00       	mov    $0x1,%eax
    38af:	48 8d 35 96 7e 00 00 	lea    0x7e96(%rip),%rsi        # b74c <_IO_stdin_used+0x74c>
    38b6:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    38ba:	e8 c1 d7 ff ff       	callq  1080 <__printf_chk@plt>
    38bf:	48 8d 35 79 34 00 00 	lea    0x3479(%rip),%rsi        # 6d3f <noptest>
    38c6:	4c 89 f7             	mov    %r14,%rdi
    38c9:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    38cf:	e8 6c 71 00 00       	callq  aa40 <measureFunction>
    38d4:	bf 01 00 00 00       	mov    $0x1,%edi
    38d9:	b8 01 00 00 00       	mov    $0x1,%eax
    38de:	48 8d 35 4c 7e 00 00 	lea    0x7e4c(%rip),%rsi        # b731 <_IO_stdin_used+0x731>
    38e5:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    38e9:	e8 92 d7 ff ff       	callq  1080 <__printf_chk@plt>
    38ee:	48 8d 35 a9 34 00 00 	lea    0x34a9(%rip),%rsi        # 6d9e <addtest>
    38f5:	4c 89 f7             	mov    %r14,%rdi
    38f8:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    38fe:	e8 3d 71 00 00       	callq  aa40 <measureFunction>
    3903:	bf 01 00 00 00       	mov    $0x1,%edi
    3908:	b8 01 00 00 00       	mov    $0x1,%eax
    390d:	48 8d 35 09 7e 00 00 	lea    0x7e09(%rip),%rsi        # b71d <_IO_stdin_used+0x71d>
    3914:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3918:	e8 63 d7 ff ff       	callq  1080 <__printf_chk@plt>
    391d:	48 8d 2d 06 35 00 00 	lea    0x3506(%rip),%rbp        # 6e2a <addnoptest>
    3924:	4c 89 f7             	mov    %r14,%rdi
    3927:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    392d:	48 89 ee             	mov    %rbp,%rsi
    3930:	e8 0b 71 00 00       	callq  aa40 <measureFunction>
    3935:	bf 01 00 00 00       	mov    $0x1,%edi
    393a:	b8 01 00 00 00       	mov    $0x1,%eax
    393f:	48 8d 35 ba 7d 00 00 	lea    0x7dba(%rip),%rsi        # b700 <_IO_stdin_used+0x700>
    3946:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    394a:	e8 31 d7 ff ff       	callq  1080 <__printf_chk@plt>
    394f:	48 89 ee             	mov    %rbp,%rsi
    3952:	4c 89 f7             	mov    %r14,%rdi
    3955:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    395b:	e8 e0 70 00 00       	callq  aa40 <measureFunction>
    3960:	bf 01 00 00 00       	mov    $0x1,%edi
    3965:	b8 01 00 00 00       	mov    $0x1,%eax
    396a:	48 8d 35 72 7d 00 00 	lea    0x7d72(%rip),%rsi        # b6e3 <_IO_stdin_used+0x6e3>
    3971:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3975:	e8 06 d7 ff ff       	callq  1080 <__printf_chk@plt>
    397a:	48 8d 35 c6 6b 00 00 	lea    0x6bc6(%rip),%rsi        # a547 <depmovtest>
    3981:	4c 89 f7             	mov    %r14,%rdi
    3984:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    398a:	e8 b1 70 00 00       	callq  aa40 <measureFunction>
    398f:	bf 01 00 00 00       	mov    $0x1,%edi
    3994:	b8 01 00 00 00       	mov    $0x1,%eax
    3999:	48 8d 35 25 7d 00 00 	lea    0x7d25(%rip),%rsi        # b6c5 <_IO_stdin_used+0x6c5>
    39a0:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    39a4:	e8 d7 d6 ff ff       	callq  1080 <__printf_chk@plt>
    39a9:	48 8d 35 0c 6c 00 00 	lea    0x6c0c(%rip),%rsi        # a5bc <indepmovtest>
    39b0:	4c 89 f7             	mov    %r14,%rdi
    39b3:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    39b9:	e8 82 70 00 00       	callq  aa40 <measureFunction>
    39be:	bf 01 00 00 00       	mov    $0x1,%edi
    39c3:	b8 01 00 00 00       	mov    $0x1,%eax
    39c8:	48 8d 35 59 86 00 00 	lea    0x8659(%rip),%rsi        # c028 <_IO_stdin_used+0x1028>
    39cf:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    39d3:	e8 a8 d6 ff ff       	callq  1080 <__printf_chk@plt>
    39d8:	48 8d 35 1f 6d 00 00 	lea    0x6d1f(%rip),%rsi        # a6fe <xorzerotest>
    39df:	4c 89 f7             	mov    %r14,%rdi
    39e2:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    39e8:	e8 53 70 00 00       	callq  aa40 <measureFunction>
    39ed:	bf 01 00 00 00       	mov    $0x1,%edi
    39f2:	b8 01 00 00 00       	mov    $0x1,%eax
    39f7:	48 8d 35 af 7c 00 00 	lea    0x7caf(%rip),%rsi        # b6ad <_IO_stdin_used+0x6ad>
    39fe:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3a02:	e8 79 d6 ff ff       	callq  1080 <__printf_chk@plt>
    3a07:	48 8d 35 25 6c 00 00 	lea    0x6c25(%rip),%rsi        # a633 <movzerotest>
    3a0e:	4c 89 f7             	mov    %r14,%rdi
    3a11:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3a17:	e8 24 70 00 00       	callq  aa40 <measureFunction>
    3a1c:	bf 01 00 00 00       	mov    $0x1,%edi
    3a21:	b8 01 00 00 00       	mov    $0x1,%eax
    3a26:	48 8d 35 68 7c 00 00 	lea    0x7c68(%rip),%rsi        # b695 <_IO_stdin_used+0x695>
    3a2d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3a31:	e8 4a d6 ff ff       	callq  1080 <__printf_chk@plt>
    3a36:	48 8d 35 38 6d 00 00 	lea    0x6d38(%rip),%rsi        # a775 <subzerotest>
    3a3d:	4c 89 f7             	mov    %r14,%rdi
    3a40:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3a46:	e8 f5 6f 00 00       	callq  aa40 <measureFunction>
    3a4b:	bf 01 00 00 00       	mov    $0x1,%edi
    3a50:	b8 01 00 00 00       	mov    $0x1,%eax
    3a55:	48 8d 35 21 7c 00 00 	lea    0x7c21(%rip),%rsi        # b67d <_IO_stdin_used+0x67d>
    3a5c:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3a60:	e8 1b d6 ff ff       	callq  1080 <__printf_chk@plt>
    3a65:	48 8d 35 0b 6e 00 00 	lea    0x6e0b(%rip),%rsi        # a877 <depinctest>
    3a6c:	4c 89 f7             	mov    %r14,%rdi
    3a6f:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3a75:	e8 c6 6f 00 00       	callq  aa40 <measureFunction>
    3a7a:	bf 01 00 00 00       	mov    $0x1,%edi
    3a7f:	b8 01 00 00 00       	mov    $0x1,%eax
    3a84:	48 8d 35 db 7b 00 00 	lea    0x7bdb(%rip),%rsi        # b666 <_IO_stdin_used+0x666>
    3a8b:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3a8f:	e8 ec d5 ff ff       	callq  1080 <__printf_chk@plt>
    3a94:	48 8d 35 53 6e 00 00 	lea    0x6e53(%rip),%rsi        # a8ee <depdectest>
    3a9b:	4c 89 f7             	mov    %r14,%rdi
    3a9e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3aa4:	e8 97 6f 00 00       	callq  aa40 <measureFunction>
    3aa9:	bf 01 00 00 00       	mov    $0x1,%edi
    3aae:	b8 01 00 00 00       	mov    $0x1,%eax
    3ab3:	48 8d 35 95 7b 00 00 	lea    0x7b95(%rip),%rsi        # b64f <_IO_stdin_used+0x64f>
    3aba:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3abe:	e8 bd d5 ff ff       	callq  1080 <__printf_chk@plt>
    3ac3:	48 8d 35 22 6d 00 00 	lea    0x6d22(%rip),%rsi        # a7ec <depaddimmtest>
    3aca:	4c 89 f7             	mov    %r14,%rdi
    3acd:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3ad3:	e8 68 6f 00 00       	callq  aa40 <measureFunction>
    3ad8:	bf 01 00 00 00       	mov    $0x1,%edi
    3add:	b8 01 00 00 00       	mov    $0x1,%eax
    3ae2:	48 8d 35 17 85 00 00 	lea    0x8517(%rip),%rsi        # c000 <_IO_stdin_used+0x1000>
    3ae9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3aed:	e8 8e d5 ff ff       	callq  1080 <__printf_chk@plt>
    3af2:	48 8d 35 ad 31 00 00 	lea    0x31ad(%rip),%rsi        # 6ca6 <clkmovtest>
    3af9:	4c 89 f7             	mov    %r14,%rdi
    3afc:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3b02:	e8 39 6f 00 00       	callq  aa40 <measureFunction>
    3b07:	bf 01 00 00 00       	mov    $0x1,%edi
    3b0c:	b8 01 00 00 00       	mov    $0x1,%eax
    3b11:	48 8d 35 c0 84 00 00 	lea    0x84c0(%rip),%rsi        # bfd8 <_IO_stdin_used+0xfd8>
    3b18:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3b1c:	e8 5f d5 ff ff       	callq  1080 <__printf_chk@plt>
    3b21:	48 8d 35 7c 3c 00 00 	lea    0x3c7c(%rip),%rsi        # 77a4 <addmultest>
    3b28:	4c 89 f7             	mov    %r14,%rdi
    3b2b:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3b31:	e8 0a 6f 00 00       	callq  aa40 <measureFunction>
    3b36:	bf 01 00 00 00       	mov    $0x1,%edi
    3b3b:	b8 01 00 00 00       	mov    $0x1,%eax
    3b40:	48 8d 35 eb 7a 00 00 	lea    0x7aeb(%rip),%rsi        # b632 <_IO_stdin_used+0x632>
    3b47:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3b4b:	e8 30 d5 ff ff       	callq  1080 <__printf_chk@plt>
    3b50:	48 8d 35 90 3b 00 00 	lea    0x3b90(%rip),%rsi        # 76e7 <jmpmultest>
    3b57:	4c 89 f7             	mov    %r14,%rdi
    3b5a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3b60:	e8 db 6e 00 00       	callq  aa40 <measureFunction>
    3b65:	bf 01 00 00 00       	mov    $0x1,%edi
    3b6a:	b8 01 00 00 00       	mov    $0x1,%eax
    3b6f:	48 8d 35 a1 7a 00 00 	lea    0x7aa1(%rip),%rsi        # b617 <_IO_stdin_used+0x617>
    3b76:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3b7a:	e8 01 d5 ff ff       	callq  1080 <__printf_chk@plt>
    3b7f:	48 8d 35 6b 39 00 00 	lea    0x396b(%rip),%rsi        # 74f1 <jmptest>
    3b86:	4c 89 f7             	mov    %r14,%rdi
    3b89:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3b8f:	e8 ac 6e 00 00       	callq  aa40 <measureFunction>
    3b94:	bf 01 00 00 00       	mov    $0x1,%edi
    3b99:	b8 01 00 00 00       	mov    $0x1,%eax
    3b9e:	48 8d 35 59 7a 00 00 	lea    0x7a59(%rip),%rsi        # b5fe <_IO_stdin_used+0x5fe>
    3ba5:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3ba9:	e8 d2 d4 ff ff       	callq  1080 <__printf_chk@plt>
    3bae:	48 8d 35 14 3a 00 00 	lea    0x3a14(%rip),%rsi        # 75c9 <ntjmptest>
    3bb5:	4c 89 f7             	mov    %r14,%rdi
    3bb8:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3bbe:	e8 7d 6e 00 00       	callq  aa40 <measureFunction>
    3bc3:	bf 01 00 00 00       	mov    $0x1,%edi
    3bc8:	b8 01 00 00 00       	mov    $0x1,%eax
    3bcd:	48 8d 35 14 7a 00 00 	lea    0x7a14(%rip),%rsi        # b5e8 <_IO_stdin_used+0x5e8>
    3bd4:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3bd8:	e8 a3 d4 ff ff       	callq  1080 <__printf_chk@plt>
    3bdd:	48 8d 35 4c 67 00 00 	lea    0x674c(%rip),%rsi        # a330 <pdeptest>
    3be4:	4c 89 f7             	mov    %r14,%rdi
    3be7:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3bed:	e8 4e 6e 00 00       	callq  aa40 <measureFunction>
    3bf2:	bf 01 00 00 00       	mov    $0x1,%edi
    3bf7:	b8 01 00 00 00       	mov    $0x1,%eax
    3bfc:	48 8d 35 d1 79 00 00 	lea    0x79d1(%rip),%rsi        # b5d4 <_IO_stdin_used+0x5d4>
    3c03:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3c07:	e8 74 d4 ff ff       	callq  1080 <__printf_chk@plt>
    3c0c:	48 8d 35 80 68 00 00 	lea    0x6880(%rip),%rsi        # a493 <pexttest>
    3c13:	4c 89 f7             	mov    %r14,%rdi
    3c16:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3c1c:	e8 1f 6e 00 00       	callq  aa40 <measureFunction>
    3c21:	bf 01 00 00 00       	mov    $0x1,%edi
    3c26:	b8 01 00 00 00       	mov    $0x1,%eax
    3c2b:	48 8d 35 8e 79 00 00 	lea    0x798e(%rip),%rsi        # b5c0 <_IO_stdin_used+0x5c0>
    3c32:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3c36:	e8 45 d4 ff ff       	callq  1080 <__printf_chk@plt>
    3c3b:	48 8d 35 a2 67 00 00 	lea    0x67a2(%rip),%rsi        # a3e4 <pdepmultest>
    3c42:	4c 89 f7             	mov    %r14,%rdi
    3c45:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3c4b:	e8 f0 6d 00 00       	callq  aa40 <measureFunction>
    3c50:	bf 01 00 00 00       	mov    $0x1,%edi
    3c55:	b8 01 00 00 00       	mov    $0x1,%eax
    3c5a:	48 8d 35 43 79 00 00 	lea    0x7943(%rip),%rsi        # b5a4 <_IO_stdin_used+0x5a4>
    3c61:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3c65:	e8 16 d4 ff ff       	callq  1080 <__printf_chk@plt>
    3c6a:	48 8d 35 55 33 00 00 	lea    0x3355(%rip),%rsi        # 6fc6 <shltest>
    3c71:	4c 89 f7             	mov    %r14,%rdi
    3c74:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3c7a:	e8 c1 6d 00 00       	callq  aa40 <measureFunction>
    3c7f:	bf 01 00 00 00       	mov    $0x1,%edi
    3c84:	b8 01 00 00 00       	mov    $0x1,%eax
    3c89:	48 8d 35 fd 78 00 00 	lea    0x78fd(%rip),%rsi        # b58d <_IO_stdin_used+0x58d>
    3c90:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3c94:	e8 e7 d3 ff ff       	callq  1080 <__printf_chk@plt>
    3c99:	48 8d 35 9a 32 00 00 	lea    0x329a(%rip),%rsi        # 6f3a <rortest>
    3ca0:	4c 89 f7             	mov    %r14,%rdi
    3ca3:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3ca9:	e8 92 6d 00 00       	callq  aa40 <measureFunction>
    3cae:	bf 01 00 00 00       	mov    $0x1,%edi
    3cb3:	b8 01 00 00 00       	mov    $0x1,%eax
    3cb8:	48 8d 35 b7 78 00 00 	lea    0x78b7(%rip),%rsi        # b576 <_IO_stdin_used+0x576>
    3cbf:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3cc3:	e8 b8 d3 ff ff       	callq  1080 <__printf_chk@plt>
    3cc8:	48 8d 35 83 33 00 00 	lea    0x3383(%rip),%rsi        # 7052 <mixrorshltest>
    3ccf:	4c 89 f7             	mov    %r14,%rdi
    3cd2:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3cd8:	e8 63 6d 00 00       	callq  aa40 <measureFunction>
    3cdd:	bf 01 00 00 00       	mov    $0x1,%edi
    3ce2:	b8 01 00 00 00       	mov    $0x1,%eax
    3ce7:	48 8d 35 ca 82 00 00 	lea    0x82ca(%rip),%rsi        # bfb8 <_IO_stdin_used+0xfb8>
    3cee:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3cf2:	e8 89 d3 ff ff       	callq  1080 <__printf_chk@plt>
    3cf7:	48 8d 35 e0 33 00 00 	lea    0x33e0(%rip),%rsi        # 70de <mixrormultest>
    3cfe:	4c 89 f7             	mov    %r14,%rdi
    3d01:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3d07:	e8 34 6d 00 00       	callq  aa40 <measureFunction>
    3d0c:	bf 01 00 00 00       	mov    $0x1,%edi
    3d11:	b8 01 00 00 00       	mov    $0x1,%eax
    3d16:	48 8d 35 3e 78 00 00 	lea    0x783e(%rip),%rsi        # b55b <_IO_stdin_used+0x55b>
    3d1d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3d21:	e8 5a d3 ff ff       	callq  1080 <__printf_chk@plt>
    3d26:	48 8d 35 03 35 00 00 	lea    0x3503(%rip),%rsi        # 7230 <btstest>
    3d2d:	4c 89 f7             	mov    %r14,%rdi
    3d30:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3d36:	e8 05 6d 00 00       	callq  aa40 <measureFunction>
    3d3b:	bf 01 00 00 00       	mov    $0x1,%edi
    3d40:	b8 01 00 00 00       	mov    $0x1,%eax
    3d45:	48 8d 35 fc 77 00 00 	lea    0x77fc(%rip),%rsi        # b548 <_IO_stdin_used+0x548>
    3d4c:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3d50:	e8 2b d3 ff ff       	callq  1080 <__printf_chk@plt>
    3d55:	48 8d 35 cd 36 00 00 	lea    0x36cd(%rip),%rsi        # 7429 <btsmultest>
    3d5c:	4c 89 f7             	mov    %r14,%rdi
    3d5f:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3d65:	e8 d6 6c 00 00       	callq  aa40 <measureFunction>
    3d6a:	bf 01 00 00 00       	mov    $0x1,%edi
    3d6f:	b8 01 00 00 00       	mov    $0x1,%eax
    3d74:	48 8d 35 b2 77 00 00 	lea    0x77b2(%rip),%rsi        # b52d <_IO_stdin_used+0x52d>
    3d7b:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3d7f:	e8 fc d2 ff ff       	callq  1080 <__printf_chk@plt>
    3d84:	48 8d 35 08 34 00 00 	lea    0x3408(%rip),%rsi        # 7193 <rorbtstest>
    3d8b:	4c 89 f7             	mov    %r14,%rdi
    3d8e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3d94:	e8 a7 6c 00 00       	callq  aa40 <measureFunction>
    3d99:	bf 01 00 00 00       	mov    $0x1,%edi
    3d9e:	b8 01 00 00 00       	mov    $0x1,%eax
    3da3:	48 8d 35 68 77 00 00 	lea    0x7768(%rip),%rsi        # b512 <_IO_stdin_used+0x512>
    3daa:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3dae:	e8 cd d2 ff ff       	callq  1080 <__printf_chk@plt>
    3db3:	48 8d 35 19 35 00 00 	lea    0x3519(%rip),%rsi        # 72d3 <leatest>
    3dba:	4c 89 f7             	mov    %r14,%rdi
    3dbd:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3dc3:	e8 78 6c 00 00       	callq  aa40 <measureFunction>
    3dc8:	bf 01 00 00 00       	mov    $0x1,%edi
    3dcd:	b8 01 00 00 00       	mov    $0x1,%eax
    3dd2:	48 8d 35 20 77 00 00 	lea    0x7720(%rip),%rsi        # b4f9 <_IO_stdin_used+0x4f9>
    3dd9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3ddd:	e8 9e d2 ff ff       	callq  1080 <__printf_chk@plt>
    3de2:	48 8d 35 8d 35 00 00 	lea    0x358d(%rip),%rsi        # 7376 <leamultest>
    3de9:	4c 89 f7             	mov    %r14,%rdi
    3dec:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3df2:	e8 49 6c 00 00       	callq  aa40 <measureFunction>
    3df7:	bf 01 00 00 00       	mov    $0x1,%edi
    3dfc:	b8 01 00 00 00       	mov    $0x1,%eax
    3e01:	48 8d 35 88 81 00 00 	lea    0x8188(%rip),%rsi        # bf90 <_IO_stdin_used+0xf90>
    3e08:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3e0c:	e8 6f d2 ff ff       	callq  1080 <__printf_chk@plt>
    3e11:	48 8d 35 73 3a 00 00 	lea    0x3a73(%rip),%rsi        # 788b <add256int>
    3e18:	4c 89 f7             	mov    %r14,%rdi
    3e1b:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3e21:	e8 1a 6c 00 00       	callq  aa40 <measureFunction>
    3e26:	bf 01 00 00 00       	mov    $0x1,%edi
    3e2b:	b8 01 00 00 00       	mov    $0x1,%eax
    3e30:	48 8d 35 31 81 00 00 	lea    0x8131(%rip),%rsi        # bf68 <_IO_stdin_used+0xf68>
    3e37:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3e3b:	e8 40 d2 ff ff       	callq  1080 <__printf_chk@plt>
    3e40:	48 8d 35 fd 3e 00 00 	lea    0x3efd(%rip),%rsi        # 7d44 <mixadd256int>
    3e47:	4c 89 f7             	mov    %r14,%rdi
    3e4a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3e50:	e8 eb 6b 00 00       	callq  aa40 <measureFunction>
    3e55:	bf 01 00 00 00       	mov    $0x1,%edi
    3e5a:	b8 01 00 00 00       	mov    $0x1,%eax
    3e5f:	48 8d 35 ca 80 00 00 	lea    0x80ca(%rip),%rsi        # bf30 <_IO_stdin_used+0xf30>
    3e66:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3e6a:	e8 11 d2 ff ff       	callq  1080 <__printf_chk@plt>
    3e6f:	48 8d 35 93 3f 00 00 	lea    0x3f93(%rip),%rsi        # 7e09 <mixadd256int11>
    3e76:	4c 89 f7             	mov    %r14,%rdi
    3e79:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3e7f:	e8 bc 6b 00 00       	callq  aa40 <measureFunction>
    3e84:	bf 01 00 00 00       	mov    $0x1,%edi
    3e89:	b8 01 00 00 00       	mov    $0x1,%eax
    3e8e:	48 8d 35 63 80 00 00 	lea    0x8063(%rip),%rsi        # bef8 <_IO_stdin_used+0xef8>
    3e95:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3e99:	e8 e2 d1 ff ff       	callq  1080 <__printf_chk@plt>
    3e9e:	48 8d 35 a6 3c 00 00 	lea    0x3ca6(%rip),%rsi        # 7b4b <mixadd256fpint>
    3ea5:	4c 89 f7             	mov    %r14,%rdi
    3ea8:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3eae:	e8 8d 6b 00 00       	callq  aa40 <measureFunction>
    3eb3:	bf 01 00 00 00       	mov    $0x1,%edi
    3eb8:	b8 01 00 00 00       	mov    $0x1,%eax
    3ebd:	48 8d 35 04 80 00 00 	lea    0x8004(%rip),%rsi        # bec8 <_IO_stdin_used+0xec8>
    3ec4:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3ec8:	e8 b3 d1 ff ff       	callq  1080 <__printf_chk@plt>
    3ecd:	48 8d 35 cc 3d 00 00 	lea    0x3dcc(%rip),%rsi        # 7ca0 <mix256fp>
    3ed4:	4c 89 f7             	mov    %r14,%rdi
    3ed7:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3edd:	e8 5e 6b 00 00       	callq  aa40 <measureFunction>
    3ee2:	bf 01 00 00 00       	mov    $0x1,%edi
    3ee7:	b8 01 00 00 00       	mov    $0x1,%eax
    3eec:	48 8d 35 a5 7f 00 00 	lea    0x7fa5(%rip),%rsi        # be98 <_IO_stdin_used+0xe98>
    3ef3:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    3ef7:	e8 84 d1 ff ff       	callq  1080 <__printf_chk@plt>
    3efc:	48 8d 35 ad 3f 00 00 	lea    0x3fad(%rip),%rsi        # 7eb0 <latadd256int>
    3f03:	4c 89 f7             	mov    %r14,%rdi
    3f06:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3f0c:	e8 2f 6b 00 00       	callq  aa40 <measureFunction>
    3f11:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    3f17:	bf 01 00 00 00       	mov    $0x1,%edi
    3f1c:	48 8d 35 45 7f 00 00 	lea    0x7f45(%rip),%rsi        # be68 <_IO_stdin_used+0xe68>
    3f23:	b8 01 00 00 00       	mov    $0x1,%eax
    3f28:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    3f2c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    3f30:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    3f34:	e8 47 d1 ff ff       	callq  1080 <__printf_chk@plt>
    3f39:	48 8d 35 5b 43 00 00 	lea    0x435b(%rip),%rsi        # 829b <latmul256int>
    3f40:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3f46:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    3f4b:	e8 f0 6a 00 00       	callq  aa40 <measureFunction>
    3f50:	f3 0f 10 74 24 0c    	movss  0xc(%rsp),%xmm6
    3f56:	bf 01 00 00 00       	mov    $0x1,%edi
    3f5b:	48 8d 35 ce 7e 00 00 	lea    0x7ece(%rip),%rsi        # be30 <_IO_stdin_used+0xe30>
    3f62:	b8 01 00 00 00       	mov    $0x1,%eax
    3f67:	f3 0f 5e f0          	divss  %xmm0,%xmm6
    3f6b:	66 0f ef c0          	pxor   %xmm0,%xmm0
    3f6f:	f3 0f 5a c6          	cvtss2sd %xmm6,%xmm0
    3f73:	e8 08 d1 ff ff       	callq  1080 <__printf_chk@plt>
    3f78:	48 8d 35 ca 43 00 00 	lea    0x43ca(%rip),%rsi        # 8349 <latadd128int>
    3f7f:	4c 89 f7             	mov    %r14,%rdi
    3f82:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3f88:	e8 b3 6a 00 00       	callq  aa40 <measureFunction>
    3f8d:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    3f93:	bf 01 00 00 00       	mov    $0x1,%edi
    3f98:	48 8d 35 61 7e 00 00 	lea    0x7e61(%rip),%rsi        # be00 <_IO_stdin_used+0xe00>
    3f9f:	b8 01 00 00 00       	mov    $0x1,%eax
    3fa4:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    3fa8:	66 0f ef c0          	pxor   %xmm0,%xmm0
    3fac:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    3fb0:	e8 cb d0 ff ff       	callq  1080 <__printf_chk@plt>
    3fb5:	48 8d 35 e0 48 00 00 	lea    0x48e0(%rip),%rsi        # 889c <latmul128int>
    3fbc:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    3fc2:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    3fc7:	e8 74 6a 00 00       	callq  aa40 <measureFunction>
    3fcc:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    3fd2:	bf 01 00 00 00       	mov    $0x1,%edi
    3fd7:	48 8d 35 ea 7d 00 00 	lea    0x7dea(%rip),%rsi        # bdc8 <_IO_stdin_used+0xdc8>
    3fde:	b8 01 00 00 00       	mov    $0x1,%eax
    3fe3:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    3fe7:	66 0f ef c0          	pxor   %xmm0,%xmm0
    3feb:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    3fef:	e8 8c d0 ff ff       	callq  1080 <__printf_chk@plt>
    3ff4:	48 8d 35 c6 49 00 00 	lea    0x49c6(%rip),%rsi        # 89c1 <latadd256fp>
    3ffb:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4001:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4006:	e8 35 6a 00 00       	callq  aa40 <measureFunction>
    400b:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    4011:	bf 01 00 00 00       	mov    $0x1,%edi
    4016:	48 8d 35 83 7d 00 00 	lea    0x7d83(%rip),%rsi        # bda0 <_IO_stdin_used+0xda0>
    401d:	b8 01 00 00 00       	mov    $0x1,%eax
    4022:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    4026:	66 0f ef c0          	pxor   %xmm0,%xmm0
    402a:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    402e:	e8 4d d0 ff ff       	callq  1080 <__printf_chk@plt>
    4033:	48 8d 35 41 4b 00 00 	lea    0x4b41(%rip),%rsi        # 8b7b <latmul256fp>
    403a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4040:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4045:	e8 f6 69 00 00       	callq  aa40 <measureFunction>
    404a:	f3 0f 10 74 24 0c    	movss  0xc(%rsp),%xmm6
    4050:	bf 01 00 00 00       	mov    $0x1,%edi
    4055:	48 8d 35 1c 7d 00 00 	lea    0x7d1c(%rip),%rsi        # bd78 <_IO_stdin_used+0xd78>
    405c:	b8 01 00 00 00       	mov    $0x1,%eax
    4061:	f3 0f 5e f0          	divss  %xmm0,%xmm6
    4065:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4069:	f3 0f 5a c6          	cvtss2sd %xmm6,%xmm0
    406d:	e8 0e d0 ff ff       	callq  1080 <__printf_chk@plt>
    4072:	48 8d 35 13 58 00 00 	lea    0x5813(%rip),%rsi        # 988c <latadd128fp>
    4079:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    407f:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4084:	e8 b7 69 00 00       	callq  aa40 <measureFunction>
    4089:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    408f:	bf 01 00 00 00       	mov    $0x1,%edi
    4094:	48 8d 35 b5 7c 00 00 	lea    0x7cb5(%rip),%rsi        # bd50 <_IO_stdin_used+0xd50>
    409b:	b8 01 00 00 00       	mov    $0x1,%eax
    40a0:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    40a4:	66 0f ef c0          	pxor   %xmm0,%xmm0
    40a8:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    40ac:	e8 cf cf ff ff       	callq  1080 <__printf_chk@plt>
    40b1:	48 8d 35 34 58 00 00 	lea    0x5834(%rip),%rsi        # 98ec <latmul128fp>
    40b8:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    40be:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    40c3:	e8 78 69 00 00       	callq  aa40 <measureFunction>
    40c8:	f3 0f 10 74 24 0c    	movss  0xc(%rsp),%xmm6
    40ce:	bf 01 00 00 00       	mov    $0x1,%edi
    40d3:	48 8d 35 4e 7c 00 00 	lea    0x7c4e(%rip),%rsi        # bd28 <_IO_stdin_used+0xd28>
    40da:	b8 01 00 00 00       	mov    $0x1,%eax
    40df:	f3 0f 5e f0          	divss  %xmm0,%xmm6
    40e3:	66 0f ef c0          	pxor   %xmm0,%xmm0
    40e7:	f3 0f 5a c6          	cvtss2sd %xmm6,%xmm0
    40eb:	e8 90 cf ff ff       	callq  1080 <__printf_chk@plt>
    40f0:	48 8d 35 c4 58 00 00 	lea    0x58c4(%rip),%rsi        # 99bb <add128fp>
    40f7:	4c 89 f7             	mov    %r14,%rdi
    40fa:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4100:	e8 3b 69 00 00       	callq  aa40 <measureFunction>
    4105:	bf 01 00 00 00       	mov    $0x1,%edi
    410a:	b8 01 00 00 00       	mov    $0x1,%eax
    410f:	48 8d 35 f2 7b 00 00 	lea    0x7bf2(%rip),%rsi        # bd08 <_IO_stdin_used+0xd08>
    4116:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    411a:	e8 61 cf ff ff       	callq  1080 <__printf_chk@plt>
    411f:	48 8d 35 26 58 00 00 	lea    0x5826(%rip),%rsi        # 994c <mul128fp>
    4126:	4c 89 f7             	mov    %r14,%rdi
    4129:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    412f:	e8 0c 69 00 00       	callq  aa40 <measureFunction>
    4134:	bf 01 00 00 00       	mov    $0x1,%edi
    4139:	b8 01 00 00 00       	mov    $0x1,%eax
    413e:	48 8d 35 a3 7b 00 00 	lea    0x7ba3(%rip),%rsi        # bce8 <_IO_stdin_used+0xce8>
    4145:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4149:	e8 32 cf ff ff       	callq  1080 <__printf_chk@plt>
    414e:	48 8d 35 5f 42 00 00 	lea    0x425f(%rip),%rsi        # 83b4 <add128int>
    4155:	4c 89 f7             	mov    %r14,%rdi
    4158:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    415e:	e8 dd 68 00 00       	callq  aa40 <measureFunction>
    4163:	bf 01 00 00 00       	mov    $0x1,%edi
    4168:	b8 01 00 00 00       	mov    $0x1,%eax
    416d:	48 8d 35 4c 7b 00 00 	lea    0x7b4c(%rip),%rsi        # bcc0 <_IO_stdin_used+0xcc0>
    4174:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4178:	e8 03 cf ff ff       	callq  1080 <__printf_chk@plt>
    417d:	48 8d 35 99 46 00 00 	lea    0x4699(%rip),%rsi        # 881d <mul128int>
    4184:	4c 89 f7             	mov    %r14,%rdi
    4187:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    418d:	e8 ae 68 00 00       	callq  aa40 <measureFunction>
    4192:	bf 01 00 00 00       	mov    $0x1,%edi
    4197:	b8 01 00 00 00       	mov    $0x1,%eax
    419c:	48 8d 35 f5 7a 00 00 	lea    0x7af5(%rip),%rsi        # bc98 <_IO_stdin_used+0xc98>
    41a3:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    41a7:	e8 d4 ce ff ff       	callq  1080 <__printf_chk@plt>
    41ac:	48 8d 35 fc 4b 00 00 	lea    0x4bfc(%rip),%rsi        # 8daf <fma256>
    41b3:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    41b9:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    41be:	e8 7d 68 00 00       	callq  aa40 <measureFunction>
    41c3:	bf 01 00 00 00       	mov    $0x1,%edi
    41c8:	b8 01 00 00 00       	mov    $0x1,%eax
    41cd:	48 8d 35 0a 73 00 00 	lea    0x730a(%rip),%rsi        # b4de <_IO_stdin_used+0x4de>
    41d4:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    41d8:	e8 a3 ce ff ff       	callq  1080 <__printf_chk@plt>
    41dd:	48 8d 35 83 4c 00 00 	lea    0x4c83(%rip),%rsi        # 8e67 <fma128>
    41e4:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    41ea:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    41ef:	e8 4c 68 00 00       	callq  aa40 <measureFunction>
    41f4:	bf 01 00 00 00       	mov    $0x1,%edi
    41f9:	b8 01 00 00 00       	mov    $0x1,%eax
    41fe:	48 8d 35 be 72 00 00 	lea    0x72be(%rip),%rsi        # b4c3 <_IO_stdin_used+0x4c3>
    4205:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4209:	e8 72 ce ff ff       	callq  1080 <__printf_chk@plt>
    420e:	48 8d 35 04 55 00 00 	lea    0x5504(%rip),%rsi        # 9719 <latfma256>
    4215:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    421b:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4220:	e8 1b 68 00 00       	callq  aa40 <measureFunction>
    4225:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    422b:	bf 01 00 00 00       	mov    $0x1,%edi
    4230:	48 8d 35 39 7a 00 00 	lea    0x7a39(%rip),%rsi        # bc70 <_IO_stdin_used+0xc70>
    4237:	b8 01 00 00 00       	mov    $0x1,%eax
    423c:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    4240:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4244:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    4248:	e8 33 ce ff ff       	callq  1080 <__printf_chk@plt>
    424d:	48 8d 35 7d 55 00 00 	lea    0x557d(%rip),%rsi        # 97d1 <latfma128>
    4254:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    425a:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    425f:	e8 dc 67 00 00       	callq  aa40 <measureFunction>
    4264:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    426a:	bf 01 00 00 00       	mov    $0x1,%edi
    426f:	48 8d 35 d2 79 00 00 	lea    0x79d2(%rip),%rsi        # bc48 <_IO_stdin_used+0xc48>
    4276:	b8 01 00 00 00       	mov    $0x1,%eax
    427b:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    427f:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4283:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    4287:	e8 f4 cd ff ff       	callq  1080 <__printf_chk@plt>
    428c:	48 8d 35 49 48 00 00 	lea    0x4849(%rip),%rsi        # 8adc <add256fp>
    4293:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4299:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    429e:	e8 9d 67 00 00       	callq  aa40 <measureFunction>
    42a3:	bf 01 00 00 00       	mov    $0x1,%edi
    42a8:	b8 01 00 00 00       	mov    $0x1,%eax
    42ad:	48 8d 35 f3 71 00 00 	lea    0x71f3(%rip),%rsi        # b4a7 <_IO_stdin_used+0x4a7>
    42b4:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    42b8:	e8 c3 cd ff ff       	callq  1080 <__printf_chk@plt>
    42bd:	48 8d 35 79 47 00 00 	lea    0x4779(%rip),%rsi        # 8a3d <mul256fp>
    42c4:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    42ca:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    42cf:	e8 6c 67 00 00       	callq  aa40 <measureFunction>
    42d4:	bf 01 00 00 00       	mov    $0x1,%edi
    42d9:	b8 01 00 00 00       	mov    $0x1,%eax
    42de:	48 8d 35 a6 71 00 00 	lea    0x71a6(%rip),%rsi        # b48b <_IO_stdin_used+0x48b>
    42e5:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    42e9:	e8 92 cd ff ff       	callq  1080 <__printf_chk@plt>
    42ee:	48 8d 35 2d 4c 00 00 	lea    0x4c2d(%rip),%rsi        # 8f22 <mixfmafadd256>
    42f5:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    42fb:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    4300:	48 c1 e7 09          	shl    $0x9,%rdi
    4304:	e8 37 67 00 00       	callq  aa40 <measureFunction>
    4309:	bf 01 00 00 00       	mov    $0x1,%edi
    430e:	b8 01 00 00 00       	mov    $0x1,%eax
    4313:	48 8d 35 06 79 00 00 	lea    0x7906(%rip),%rsi        # bc20 <_IO_stdin_used+0xc20>
    431a:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    431e:	e8 5d cd ff ff       	callq  1080 <__printf_chk@plt>
    4323:	48 8d 35 a7 4e 00 00 	lea    0x4ea7(%rip),%rsi        # 91d1 <mixfmaadd256>
    432a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4330:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    4335:	48 c1 e7 09          	shl    $0x9,%rdi
    4339:	e8 02 67 00 00       	callq  aa40 <measureFunction>
    433e:	bf 01 00 00 00       	mov    $0x1,%edi
    4343:	b8 01 00 00 00       	mov    $0x1,%eax
    4348:	48 8d 35 a9 78 00 00 	lea    0x78a9(%rip),%rsi        # bbf8 <_IO_stdin_used+0xbf8>
    434f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4353:	e8 28 cd ff ff       	callq  1080 <__printf_chk@plt>
    4358:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    435e:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    4363:	48 c1 e7 09          	shl    $0x9,%rdi
    4367:	48 8d 35 c2 66 00 00 	lea    0x66c2(%rip),%rsi        # aa30 <mixfmaaddmem256wrapper>
    436e:	e8 cd 66 00 00       	callq  aa40 <measureFunction>
    4373:	bf 01 00 00 00       	mov    $0x1,%edi
    4378:	b8 01 00 00 00       	mov    $0x1,%eax
    437d:	48 8d 35 44 78 00 00 	lea    0x7844(%rip),%rsi        # bbc8 <_IO_stdin_used+0xbc8>
    4384:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4388:	e8 f3 cc ff ff       	callq  1080 <__printf_chk@plt>
    438d:	48 8d 35 ee 4e 00 00 	lea    0x4eee(%rip),%rsi        # 9282 <mixfmaand256>
    4394:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    439a:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    439f:	48 c1 e7 09          	shl    $0x9,%rdi
    43a3:	e8 98 66 00 00       	callq  aa40 <measureFunction>
    43a8:	bf 01 00 00 00       	mov    $0x1,%edi
    43ad:	b8 01 00 00 00       	mov    $0x1,%eax
    43b2:	48 8d 35 e7 77 00 00 	lea    0x77e7(%rip),%rsi        # bba0 <_IO_stdin_used+0xba0>
    43b9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    43bd:	e8 be cc ff ff       	callq  1080 <__printf_chk@plt>
    43c2:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    43c8:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    43cd:	48 c1 e7 09          	shl    $0x9,%rdi
    43d1:	48 8d 35 48 66 00 00 	lea    0x6648(%rip),%rsi        # aa20 <mixfmaandmem256wrapper>
    43d8:	e8 63 66 00 00       	callq  aa40 <measureFunction>
    43dd:	bf 01 00 00 00       	mov    $0x1,%edi
    43e2:	b8 01 00 00 00       	mov    $0x1,%eax
    43e7:	48 8d 35 5a 7c 00 00 	lea    0x7c5a(%rip),%rsi        # c048 <_IO_stdin_used+0x1048>
    43ee:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    43f2:	e8 89 cc ff ff       	callq  1080 <__printf_chk@plt>
    43f7:	48 8d 35 9a 51 00 00 	lea    0x519a(%rip),%rsi        # 9598 <nemesfpumix21>
    43fe:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4404:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    4409:	48 c1 e7 09          	shl    $0x9,%rdi
    440d:	e8 2e 66 00 00       	callq  aa40 <measureFunction>
    4412:	bf 01 00 00 00       	mov    $0x1,%edi
    4417:	b8 01 00 00 00       	mov    $0x1,%eax
    441c:	48 8d 35 4d 77 00 00 	lea    0x774d(%rip),%rsi        # bb70 <_IO_stdin_used+0xb70>
    4423:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4427:	e8 54 cc ff ff       	callq  1080 <__printf_chk@plt>
    442c:	48 8d 35 c1 37 00 00 	lea    0x37c1(%rip),%rsi        # 7bf4 <mix256faddintadd>
    4433:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4439:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    443e:	e8 fd 65 00 00       	callq  aa40 <measureFunction>
    4443:	bf 01 00 00 00       	mov    $0x1,%edi
    4448:	b8 01 00 00 00       	mov    $0x1,%eax
    444d:	48 8d 35 f4 76 00 00 	lea    0x76f4(%rip),%rsi        # bb48 <_IO_stdin_used+0xb48>
    4454:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4458:	e8 23 cc ff ff       	callq  1080 <__printf_chk@plt>
    445d:	48 8d 35 66 56 00 00 	lea    0x5666(%rip),%rsi        # 9aca <latmul16>
    4464:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    446a:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    446f:	e8 cc 65 00 00       	callq  aa40 <measureFunction>
    4474:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    447a:	bf 01 00 00 00       	mov    $0x1,%edi
    447f:	48 8d 35 9a 76 00 00 	lea    0x769a(%rip),%rsi        # bb20 <_IO_stdin_used+0xb20>
    4486:	b8 01 00 00 00       	mov    $0x1,%eax
    448b:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    448f:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4493:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    4497:	e8 e4 cb ff ff       	callq  1080 <__printf_chk@plt>
    449c:	48 8d 35 87 55 00 00 	lea    0x5587(%rip),%rsi        # 9a2a <latmul64>
    44a3:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    44a9:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    44ae:	e8 8d 65 00 00       	callq  aa40 <measureFunction>
    44b3:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    44b9:	bf 01 00 00 00       	mov    $0x1,%edi
    44be:	48 8d 35 33 76 00 00 	lea    0x7633(%rip),%rsi        # baf8 <_IO_stdin_used+0xaf8>
    44c5:	b8 01 00 00 00       	mov    $0x1,%eax
    44ca:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    44ce:	66 0f ef c0          	pxor   %xmm0,%xmm0
    44d2:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    44d6:	e8 a5 cb ff ff       	callq  1080 <__printf_chk@plt>
    44db:	48 8d 35 9c 56 00 00 	lea    0x569c(%rip),%rsi        # 9b7e <mul16>
    44e2:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    44e8:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    44ed:	e8 4e 65 00 00       	callq  aa40 <measureFunction>
    44f2:	bf 01 00 00 00       	mov    $0x1,%edi
    44f7:	b8 01 00 00 00       	mov    $0x1,%eax
    44fc:	48 8d 35 6d 6f 00 00 	lea    0x6f6d(%rip),%rsi        # b470 <_IO_stdin_used+0x470>
    4503:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4507:	e8 74 cb ff ff       	callq  1080 <__printf_chk@plt>
    450c:	48 8d 35 1f 57 00 00 	lea    0x571f(%rip),%rsi        # 9c32 <mul64>
    4513:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4519:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    451e:	e8 1d 65 00 00       	callq  aa40 <measureFunction>
    4523:	bf 01 00 00 00       	mov    $0x1,%edi
    4528:	b8 01 00 00 00       	mov    $0x1,%eax
    452d:	48 8d 35 21 6f 00 00 	lea    0x6f21(%rip),%rsi        # b455 <_IO_stdin_used+0x455>
    4534:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4538:	e8 43 cb ff ff       	callq  1080 <__printf_chk@plt>
    453d:	48 8d 35 d0 57 00 00 	lea    0x57d0(%rip),%rsi        # 9d14 <mixmul16mul64>
    4544:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    454a:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    454f:	e8 ec 64 00 00       	callq  aa40 <measureFunction>
    4554:	bf 01 00 00 00       	mov    $0x1,%edi
    4559:	b8 01 00 00 00       	mov    $0x1,%eax
    455e:	48 8d 35 63 75 00 00 	lea    0x7563(%rip),%rsi        # bac8 <_IO_stdin_used+0xac8>
    4565:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4569:	e8 12 cb ff ff       	callq  1080 <__printf_chk@plt>
    456e:	48 8d 35 4b 58 00 00 	lea    0x584b(%rip),%rsi        # 9dc0 <mixmul16mul64_21>
    4575:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    457b:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4580:	e8 bb 64 00 00       	callq  aa40 <measureFunction>
    4585:	bf 01 00 00 00       	mov    $0x1,%edi
    458a:	b8 01 00 00 00       	mov    $0x1,%eax
    458f:	48 8d 35 02 75 00 00 	lea    0x7502(%rip),%rsi        # ba98 <_IO_stdin_used+0xa98>
    4596:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    459a:	e8 e1 ca ff ff       	callq  1080 <__printf_chk@plt>
    459f:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    45a5:	48 8d 35 c4 63 00 00 	lea    0x63c4(%rip),%rsi        # a970 <load128wrapper>
    45ac:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    45b1:	e8 8a 64 00 00       	callq  aa40 <measureFunction>
    45b6:	bf 01 00 00 00       	mov    $0x1,%edi
    45bb:	b8 01 00 00 00       	mov    $0x1,%eax
    45c0:	48 8d 35 71 6e 00 00 	lea    0x6e71(%rip),%rsi        # b438 <_IO_stdin_used+0x438>
    45c7:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    45cb:	e8 b0 ca ff ff       	callq  1080 <__printf_chk@plt>
    45d0:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    45d6:	48 8d 35 a3 63 00 00 	lea    0x63a3(%rip),%rsi        # a980 <spacedload128wrapper>
    45dd:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    45e2:	e8 59 64 00 00       	callq  aa40 <measureFunction>
    45e7:	bf 01 00 00 00       	mov    $0x1,%edi
    45ec:	b8 01 00 00 00       	mov    $0x1,%eax
    45f1:	48 8d 35 78 74 00 00 	lea    0x7478(%rip),%rsi        # ba70 <_IO_stdin_used+0xa70>
    45f8:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    45fc:	e8 7f ca ff ff       	callq  1080 <__printf_chk@plt>
    4601:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4607:	48 8d 35 92 63 00 00 	lea    0x6392(%rip),%rsi        # a9a0 <load256wrapper>
    460e:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4613:	e8 28 64 00 00       	callq  aa40 <measureFunction>
    4618:	bf 01 00 00 00       	mov    $0x1,%edi
    461d:	b8 01 00 00 00       	mov    $0x1,%eax
    4622:	48 8d 35 f2 6d 00 00 	lea    0x6df2(%rip),%rsi        # b41b <_IO_stdin_used+0x41b>
    4629:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    462d:	e8 4e ca ff ff       	callq  1080 <__printf_chk@plt>
    4632:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4638:	48 8d 35 51 63 00 00 	lea    0x6351(%rip),%rsi        # a990 <spacedstorescalarwrapper>
    463f:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4644:	e8 f7 63 00 00       	callq  aa40 <measureFunction>
    4649:	bf 01 00 00 00       	mov    $0x1,%edi
    464e:	b8 01 00 00 00       	mov    $0x1,%eax
    4653:	48 8d 35 ee 73 00 00 	lea    0x73ee(%rip),%rsi        # ba48 <_IO_stdin_used+0xa48>
    465a:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    465e:	e8 1d ca ff ff       	callq  1080 <__printf_chk@plt>
    4663:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4669:	48 8d 35 50 63 00 00 	lea    0x6350(%rip),%rsi        # a9c0 <store128wrapper>
    4670:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4675:	e8 c6 63 00 00       	callq  aa40 <measureFunction>
    467a:	bf 01 00 00 00       	mov    $0x1,%edi
    467f:	b8 01 00 00 00       	mov    $0x1,%eax
    4684:	48 8d 35 72 6d 00 00 	lea    0x6d72(%rip),%rsi        # b3fd <_IO_stdin_used+0x3fd>
    468b:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    468f:	e8 ec c9 ff ff       	callq  1080 <__printf_chk@plt>
    4694:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    469a:	48 8d 35 3f 63 00 00 	lea    0x633f(%rip),%rsi        # a9e0 <store256wrapper>
    46a1:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    46a6:	e8 95 63 00 00       	callq  aa40 <measureFunction>
    46ab:	bf 01 00 00 00       	mov    $0x1,%edi
    46b0:	b8 01 00 00 00       	mov    $0x1,%eax
    46b5:	48 8d 35 23 6d 00 00 	lea    0x6d23(%rip),%rsi        # b3df <_IO_stdin_used+0x3df>
    46bc:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    46c0:	e8 bb c9 ff ff       	callq  1080 <__printf_chk@plt>
    46c5:	e9 4b e2 ff ff       	jmpq   2915 <main+0x1855>
    46ca:	48 8b 0d 0f 9a 00 00 	mov    0x9a0f(%rip),%rcx        # e0e0 <stderr@@GLIBC_2.2.5>
    46d1:	ba 0f 00 00 00       	mov    $0xf,%edx
    46d6:	be 01 00 00 00       	mov    $0x1,%esi
    46db:	48 8d 3d 59 69 00 00 	lea    0x6959(%rip),%rdi        # b03b <_IO_stdin_used+0x3b>
    46e2:	e8 a9 c9 ff ff       	callq  1090 <fwrite@plt>
    46e7:	e9 91 ca ff ff       	jmpq   117d <main+0xbd>
    46ec:	48 8b 0d ed 99 00 00 	mov    0x99ed(%rip),%rcx        # e0e0 <stderr@@GLIBC_2.2.5>
    46f3:	ba 0f 00 00 00       	mov    $0xf,%edx
    46f8:	be 01 00 00 00       	mov    $0x1,%esi
    46fd:	48 8d 3d 27 69 00 00 	lea    0x6927(%rip),%rdi        # b02b <_IO_stdin_used+0x2b>
    4704:	e8 87 c9 ff ff       	callq  1090 <fwrite@plt>
    4709:	e9 64 ca ff ff       	jmpq   1172 <main+0xb2>
    470e:	48 8b 0d cb 99 00 00 	mov    0x99cb(%rip),%rcx        # e0e0 <stderr@@GLIBC_2.2.5>
    4715:	ba 0e 00 00 00       	mov    $0xe,%edx
    471a:	be 01 00 00 00       	mov    $0x1,%esi
    471f:	48 8d 3d f6 68 00 00 	lea    0x68f6(%rip),%rdi        # b01c <_IO_stdin_used+0x1c>
    4726:	e8 65 c9 ff ff       	callq  1090 <fwrite@plt>
    472b:	e9 37 ca ff ff       	jmpq   1167 <main+0xa7>
    4730:	48 8b 7d 10          	mov    0x10(%rbp),%rdi
    4734:	31 f6                	xor    %esi,%esi
    4736:	ba 0a 00 00 00       	mov    $0xa,%edx
    473b:	e8 30 c9 ff ff       	callq  1070 <strtol@plt>
    4740:	48 8d 35 bd 68 00 00 	lea    0x68bd(%rip),%rsi        # b004 <_IO_stdin_used+0x4>
    4747:	bf 01 00 00 00       	mov    $0x1,%edi
    474c:	4c 69 f0 00 2f 68 59 	imul   $0x59682f00,%rax,%r14
    4753:	31 c0                	xor    %eax,%eax
    4755:	4c 89 f2             	mov    %r14,%rdx
    4758:	e8 23 c9 ff ff       	callq  1080 <__printf_chk@plt>
    475d:	e9 f3 c9 ff ff       	jmpq   1155 <main+0x95>
    4762:	48 8d 35 cf 4e 00 00 	lea    0x4ecf(%rip),%rsi        # 9638 <latfma512>
    4769:	f3 0f 10 05 17 79 00 	movss  0x7917(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    4770:	00 
    4771:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4776:	e8 c5 62 00 00       	callq  aa40 <measureFunction>
    477b:	bf 01 00 00 00       	mov    $0x1,%edi
    4780:	b8 01 00 00 00       	mov    $0x1,%eax
    4785:	f3 0f 10 2d fb 78 00 	movss  0x78fb(%rip),%xmm5        # c088 <_IO_stdin_used+0x1088>
    478c:	00 
    478d:	48 8d 35 0c 70 00 00 	lea    0x700c(%rip),%rsi        # b7a0 <_IO_stdin_used+0x7a0>
    4794:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    4798:	66 0f ef c0          	pxor   %xmm0,%xmm0
    479c:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    47a0:	e8 db c8 ff ff       	callq  1080 <__printf_chk@plt>
    47a5:	41 83 fc 01          	cmp    $0x1,%r12d
    47a9:	0f 8e 97 e1 ff ff    	jle    2946 <main+0x1886>
    47af:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
    47b3:	ba 0f 00 00 00       	mov    $0xf,%edx
    47b8:	48 8d 35 48 69 00 00 	lea    0x6948(%rip),%rsi        # b107 <_IO_stdin_used+0x107>
    47bf:	4c 89 ef             	mov    %r13,%rdi
    47c2:	e8 69 c8 ff ff       	callq  1030 <strncmp@plt>
    47c7:	85 c0                	test   %eax,%eax
    47c9:	0f 85 4d 1c 00 00    	jne    641c <main+0x535c>
    47cf:	48 8d 35 02 45 00 00 	lea    0x4502(%rip),%rsi        # 8cd8 <mixfma256fma512>
    47d6:	f3 0f 10 05 aa 78 00 	movss  0x78aa(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    47dd:	00 
    47de:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    47e3:	e8 58 62 00 00       	callq  aa40 <measureFunction>
    47e8:	bf 01 00 00 00       	mov    $0x1,%edi
    47ed:	b8 01 00 00 00       	mov    $0x1,%eax
    47f2:	48 8d 35 cf 6f 00 00 	lea    0x6fcf(%rip),%rsi        # b7c8 <_IO_stdin_used+0x7c8>
    47f9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    47fd:	e8 7e c8 ff ff       	callq  1080 <__printf_chk@plt>
    4802:	e9 51 ea ff ff       	jmpq   3258 <main+0x2198>
    4807:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    480d:	48 8d 35 7c 61 00 00 	lea    0x617c(%rip),%rsi        # a990 <spacedstorescalarwrapper>
    4814:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4819:	e8 22 62 00 00       	callq  aa40 <measureFunction>
    481e:	bf 01 00 00 00       	mov    $0x1,%edi
    4823:	b8 01 00 00 00       	mov    $0x1,%eax
    4828:	48 8d 35 19 72 00 00 	lea    0x7219(%rip),%rsi        # ba48 <_IO_stdin_used+0xa48>
    482f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4833:	e8 48 c8 ff ff       	callq  1080 <__printf_chk@plt>
    4838:	41 83 fc 01          	cmp    $0x1,%r12d
    483c:	0f 8f 17 e0 ff ff    	jg     2859 <main+0x1799>
    4842:	e9 ff e0 ff ff       	jmpq   2946 <main+0x1886>
    4847:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    484d:	48 8d 35 4c 61 00 00 	lea    0x614c(%rip),%rsi        # a9a0 <load256wrapper>
    4854:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4859:	e8 e2 61 00 00       	callq  aa40 <measureFunction>
    485e:	bf 01 00 00 00       	mov    $0x1,%edi
    4863:	b8 01 00 00 00       	mov    $0x1,%eax
    4868:	48 8d 35 ac 6b 00 00 	lea    0x6bac(%rip),%rsi        # b41b <_IO_stdin_used+0x41b>
    486f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4873:	e8 08 c8 ff ff       	callq  1080 <__printf_chk@plt>
    4878:	41 83 fc 01          	cmp    $0x1,%r12d
    487c:	0f 8f 86 df ff ff    	jg     2808 <main+0x1748>
    4882:	e9 bf e0 ff ff       	jmpq   2946 <main+0x1886>
    4887:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    488d:	48 8d 35 ec 60 00 00 	lea    0x60ec(%rip),%rsi        # a980 <spacedload128wrapper>
    4894:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4899:	e8 a2 61 00 00       	callq  aa40 <measureFunction>
    489e:	bf 01 00 00 00       	mov    $0x1,%edi
    48a3:	b8 01 00 00 00       	mov    $0x1,%eax
    48a8:	48 8d 35 c1 71 00 00 	lea    0x71c1(%rip),%rsi        # ba70 <_IO_stdin_used+0xa70>
    48af:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    48b3:	e8 c8 c7 ff ff       	callq  1080 <__printf_chk@plt>
    48b8:	41 83 fc 01          	cmp    $0x1,%r12d
    48bc:	0f 8f f5 de ff ff    	jg     27b7 <main+0x16f7>
    48c2:	e9 7f e0 ff ff       	jmpq   2946 <main+0x1886>
    48c7:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    48cd:	48 8d 35 9c 60 00 00 	lea    0x609c(%rip),%rsi        # a970 <load128wrapper>
    48d4:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    48d9:	e8 62 61 00 00       	callq  aa40 <measureFunction>
    48de:	bf 01 00 00 00       	mov    $0x1,%edi
    48e3:	b8 01 00 00 00       	mov    $0x1,%eax
    48e8:	48 8d 35 49 6b 00 00 	lea    0x6b49(%rip),%rsi        # b438 <_IO_stdin_used+0x438>
    48ef:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    48f3:	e8 88 c7 ff ff       	callq  1080 <__printf_chk@plt>
    48f8:	41 83 fc 01          	cmp    $0x1,%r12d
    48fc:	0f 8f 64 de ff ff    	jg     2766 <main+0x16a6>
    4902:	e9 3f e0 ff ff       	jmpq   2946 <main+0x1886>
    4907:	48 8d 35 b2 54 00 00 	lea    0x54b2(%rip),%rsi        # 9dc0 <mixmul16mul64_21>
    490e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4914:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4919:	e8 22 61 00 00       	callq  aa40 <measureFunction>
    491e:	bf 01 00 00 00       	mov    $0x1,%edi
    4923:	b8 01 00 00 00       	mov    $0x1,%eax
    4928:	48 8d 35 69 71 00 00 	lea    0x7169(%rip),%rsi        # ba98 <_IO_stdin_used+0xa98>
    492f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4933:	e8 48 c7 ff ff       	callq  1080 <__printf_chk@plt>
    4938:	41 83 fc 01          	cmp    $0x1,%r12d
    493c:	0f 8f d3 dd ff ff    	jg     2715 <main+0x1655>
    4942:	e9 ff df ff ff       	jmpq   2946 <main+0x1886>
    4947:	48 8d 35 c6 53 00 00 	lea    0x53c6(%rip),%rsi        # 9d14 <mixmul16mul64>
    494e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4954:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4959:	e8 e2 60 00 00       	callq  aa40 <measureFunction>
    495e:	bf 01 00 00 00       	mov    $0x1,%edi
    4963:	b8 01 00 00 00       	mov    $0x1,%eax
    4968:	48 8d 35 59 71 00 00 	lea    0x7159(%rip),%rsi        # bac8 <_IO_stdin_used+0xac8>
    496f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4973:	e8 08 c7 ff ff       	callq  1080 <__printf_chk@plt>
    4978:	41 83 fc 01          	cmp    $0x1,%r12d
    497c:	0f 8f 42 dd ff ff    	jg     26c4 <main+0x1604>
    4982:	e9 bf df ff ff       	jmpq   2946 <main+0x1886>
    4987:	48 8d 35 a4 52 00 00 	lea    0x52a4(%rip),%rsi        # 9c32 <mul64>
    498e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4994:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4999:	e8 a2 60 00 00       	callq  aa40 <measureFunction>
    499e:	bf 01 00 00 00       	mov    $0x1,%edi
    49a3:	b8 01 00 00 00       	mov    $0x1,%eax
    49a8:	48 8d 35 a6 6a 00 00 	lea    0x6aa6(%rip),%rsi        # b455 <_IO_stdin_used+0x455>
    49af:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    49b3:	e8 c8 c6 ff ff       	callq  1080 <__printf_chk@plt>
    49b8:	41 83 fc 01          	cmp    $0x1,%r12d
    49bc:	0f 8f b1 dc ff ff    	jg     2673 <main+0x15b3>
    49c2:	e9 7f df ff ff       	jmpq   2946 <main+0x1886>
    49c7:	48 8d 35 b0 51 00 00 	lea    0x51b0(%rip),%rsi        # 9b7e <mul16>
    49ce:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    49d4:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    49d9:	e8 62 60 00 00       	callq  aa40 <measureFunction>
    49de:	bf 01 00 00 00       	mov    $0x1,%edi
    49e3:	b8 01 00 00 00       	mov    $0x1,%eax
    49e8:	48 8d 35 81 6a 00 00 	lea    0x6a81(%rip),%rsi        # b470 <_IO_stdin_used+0x470>
    49ef:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    49f3:	e8 88 c6 ff ff       	callq  1080 <__printf_chk@plt>
    49f8:	41 83 fc 01          	cmp    $0x1,%r12d
    49fc:	0f 8f 20 dc ff ff    	jg     2622 <main+0x1562>
    4a02:	e9 3f df ff ff       	jmpq   2946 <main+0x1886>
    4a07:	48 8d 35 1c 50 00 00 	lea    0x501c(%rip),%rsi        # 9a2a <latmul64>
    4a0e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4a14:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4a19:	e8 22 60 00 00       	callq  aa40 <measureFunction>
    4a1e:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    4a24:	bf 01 00 00 00       	mov    $0x1,%edi
    4a29:	48 8d 35 c8 70 00 00 	lea    0x70c8(%rip),%rsi        # baf8 <_IO_stdin_used+0xaf8>
    4a30:	b8 01 00 00 00       	mov    $0x1,%eax
    4a35:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    4a39:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4a3d:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    4a41:	e8 3a c6 ff ff       	callq  1080 <__printf_chk@plt>
    4a46:	41 83 fc 01          	cmp    $0x1,%r12d
    4a4a:	0f 8f 81 db ff ff    	jg     25d1 <main+0x1511>
    4a50:	e9 f1 de ff ff       	jmpq   2946 <main+0x1886>
    4a55:	48 8d 35 6e 50 00 00 	lea    0x506e(%rip),%rsi        # 9aca <latmul16>
    4a5c:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4a62:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4a67:	e8 d4 5f 00 00       	callq  aa40 <measureFunction>
    4a6c:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    4a72:	bf 01 00 00 00       	mov    $0x1,%edi
    4a77:	48 8d 35 a2 70 00 00 	lea    0x70a2(%rip),%rsi        # bb20 <_IO_stdin_used+0xb20>
    4a7e:	b8 01 00 00 00       	mov    $0x1,%eax
    4a83:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    4a87:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4a8b:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    4a8f:	e8 ec c5 ff ff       	callq  1080 <__printf_chk@plt>
    4a94:	41 83 fc 01          	cmp    $0x1,%r12d
    4a98:	0f 8f d4 da ff ff    	jg     2572 <main+0x14b2>
    4a9e:	e9 a3 de ff ff       	jmpq   2946 <main+0x1886>
    4aa3:	48 8d 35 4a 31 00 00 	lea    0x314a(%rip),%rsi        # 7bf4 <mix256faddintadd>
    4aaa:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4ab0:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4ab5:	e8 86 5f 00 00       	callq  aa40 <measureFunction>
    4aba:	bf 01 00 00 00       	mov    $0x1,%edi
    4abf:	b8 01 00 00 00       	mov    $0x1,%eax
    4ac4:	48 8d 35 7d 70 00 00 	lea    0x707d(%rip),%rsi        # bb48 <_IO_stdin_used+0xb48>
    4acb:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4acf:	e8 ac c5 ff ff       	callq  1080 <__printf_chk@plt>
    4ad4:	41 83 fc 01          	cmp    $0x1,%r12d
    4ad8:	0f 8f 35 da ff ff    	jg     2513 <main+0x1453>
    4ade:	e9 63 de ff ff       	jmpq   2946 <main+0x1886>
    4ae3:	48 8d 35 ae 4a 00 00 	lea    0x4aae(%rip),%rsi        # 9598 <nemesfpumix21>
    4aea:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4af0:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    4af5:	48 c1 e7 09          	shl    $0x9,%rdi
    4af9:	e8 42 5f 00 00       	callq  aa40 <measureFunction>
    4afe:	bf 01 00 00 00       	mov    $0x1,%edi
    4b03:	b8 01 00 00 00       	mov    $0x1,%eax
    4b08:	48 8d 35 61 70 00 00 	lea    0x7061(%rip),%rsi        # bb70 <_IO_stdin_used+0xb70>
    4b0f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4b13:	e8 68 c5 ff ff       	callq  1080 <__printf_chk@plt>
    4b18:	41 83 fc 01          	cmp    $0x1,%r12d
    4b1c:	0f 8f a0 d9 ff ff    	jg     24c2 <main+0x1402>
    4b22:	e9 1f de ff ff       	jmpq   2946 <main+0x1886>
    4b27:	48 8d 35 54 47 00 00 	lea    0x4754(%rip),%rsi        # 9282 <mixfmaand256>
    4b2e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4b34:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    4b39:	48 c1 e7 09          	shl    $0x9,%rdi
    4b3d:	e8 fe 5e 00 00       	callq  aa40 <measureFunction>
    4b42:	bf 01 00 00 00       	mov    $0x1,%edi
    4b47:	b8 01 00 00 00       	mov    $0x1,%eax
    4b4c:	48 8d 35 4d 70 00 00 	lea    0x704d(%rip),%rsi        # bba0 <_IO_stdin_used+0xba0>
    4b53:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4b57:	e8 24 c5 ff ff       	callq  1080 <__printf_chk@plt>
    4b5c:	41 83 fc 01          	cmp    $0x1,%r12d
    4b60:	0f 8f b2 d8 ff ff    	jg     2418 <main+0x1358>
    4b66:	e9 db dd ff ff       	jmpq   2946 <main+0x1886>
    4b6b:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4b71:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    4b76:	48 8d 35 b3 5e 00 00 	lea    0x5eb3(%rip),%rsi        # aa30 <mixfmaaddmem256wrapper>
    4b7d:	48 c1 e7 09          	shl    $0x9,%rdi
    4b81:	e8 ba 5e 00 00       	callq  aa40 <measureFunction>
    4b86:	bf 01 00 00 00       	mov    $0x1,%edi
    4b8b:	b8 01 00 00 00       	mov    $0x1,%eax
    4b90:	48 8d 35 31 70 00 00 	lea    0x7031(%rip),%rsi        # bbc8 <_IO_stdin_used+0xbc8>
    4b97:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4b9b:	e8 e0 c4 ff ff       	callq  1080 <__printf_chk@plt>
    4ba0:	41 83 fc 01          	cmp    $0x1,%r12d
    4ba4:	0f 8f 1d d8 ff ff    	jg     23c7 <main+0x1307>
    4baa:	e9 97 dd ff ff       	jmpq   2946 <main+0x1886>
    4baf:	48 8d 35 1b 46 00 00 	lea    0x461b(%rip),%rsi        # 91d1 <mixfmaadd256>
    4bb6:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4bbc:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    4bc1:	48 c1 e7 09          	shl    $0x9,%rdi
    4bc5:	e8 76 5e 00 00       	callq  aa40 <measureFunction>
    4bca:	bf 01 00 00 00       	mov    $0x1,%edi
    4bcf:	b8 01 00 00 00       	mov    $0x1,%eax
    4bd4:	48 8d 35 1d 70 00 00 	lea    0x701d(%rip),%rsi        # bbf8 <_IO_stdin_used+0xbf8>
    4bdb:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4bdf:	e8 9c c4 ff ff       	callq  1080 <__printf_chk@plt>
    4be4:	41 83 fc 01          	cmp    $0x1,%r12d
    4be8:	0f 8f 84 d7 ff ff    	jg     2372 <main+0x12b2>
    4bee:	e9 53 dd ff ff       	jmpq   2946 <main+0x1886>
    4bf3:	48 8d 35 28 43 00 00 	lea    0x4328(%rip),%rsi        # 8f22 <mixfmafadd256>
    4bfa:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4c00:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    4c05:	48 c1 e7 09          	shl    $0x9,%rdi
    4c09:	e8 32 5e 00 00       	callq  aa40 <measureFunction>
    4c0e:	bf 01 00 00 00       	mov    $0x1,%edi
    4c13:	b8 01 00 00 00       	mov    $0x1,%eax
    4c18:	48 8d 35 01 70 00 00 	lea    0x7001(%rip),%rsi        # bc20 <_IO_stdin_used+0xc20>
    4c1f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4c23:	e8 58 c4 ff ff       	callq  1080 <__printf_chk@plt>
    4c28:	41 83 fc 01          	cmp    $0x1,%r12d
    4c2c:	0f 8f eb d6 ff ff    	jg     231d <main+0x125d>
    4c32:	e9 0f dd ff ff       	jmpq   2946 <main+0x1886>
    4c37:	48 8d 35 ff 3d 00 00 	lea    0x3dff(%rip),%rsi        # 8a3d <mul256fp>
    4c3e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4c44:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4c49:	e8 f2 5d 00 00       	callq  aa40 <measureFunction>
    4c4e:	bf 01 00 00 00       	mov    $0x1,%edi
    4c53:	b8 01 00 00 00       	mov    $0x1,%eax
    4c58:	48 8d 35 2c 68 00 00 	lea    0x682c(%rip),%rsi        # b48b <_IO_stdin_used+0x48b>
    4c5f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4c63:	e8 18 c4 ff ff       	callq  1080 <__printf_chk@plt>
    4c68:	41 83 fc 01          	cmp    $0x1,%r12d
    4c6c:	0f 8f 56 d6 ff ff    	jg     22c8 <main+0x1208>
    4c72:	e9 cf dc ff ff       	jmpq   2946 <main+0x1886>
    4c77:	48 8d 35 5e 3e 00 00 	lea    0x3e5e(%rip),%rsi        # 8adc <add256fp>
    4c7e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4c84:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4c89:	e8 b2 5d 00 00       	callq  aa40 <measureFunction>
    4c8e:	bf 01 00 00 00       	mov    $0x1,%edi
    4c93:	b8 01 00 00 00       	mov    $0x1,%eax
    4c98:	48 8d 35 08 68 00 00 	lea    0x6808(%rip),%rsi        # b4a7 <_IO_stdin_used+0x4a7>
    4c9f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4ca3:	e8 d8 c3 ff ff       	callq  1080 <__printf_chk@plt>
    4ca8:	41 83 fc 01          	cmp    $0x1,%r12d
    4cac:	0f 8f c5 d5 ff ff    	jg     2277 <main+0x11b7>
    4cb2:	e9 8f dc ff ff       	jmpq   2946 <main+0x1886>
    4cb7:	48 8d 35 13 4b 00 00 	lea    0x4b13(%rip),%rsi        # 97d1 <latfma128>
    4cbe:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4cc4:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4cc9:	e8 72 5d 00 00       	callq  aa40 <measureFunction>
    4cce:	f3 0f 10 74 24 0c    	movss  0xc(%rsp),%xmm6
    4cd4:	bf 01 00 00 00       	mov    $0x1,%edi
    4cd9:	48 8d 35 68 6f 00 00 	lea    0x6f68(%rip),%rsi        # bc48 <_IO_stdin_used+0xc48>
    4ce0:	b8 01 00 00 00       	mov    $0x1,%eax
    4ce5:	f3 0f 5e f0          	divss  %xmm0,%xmm6
    4ce9:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4ced:	f3 0f 5a c6          	cvtss2sd %xmm6,%xmm0
    4cf1:	e8 8a c3 ff ff       	callq  1080 <__printf_chk@plt>
    4cf6:	41 83 fc 01          	cmp    $0x1,%r12d
    4cfa:	0f 8f 26 d5 ff ff    	jg     2226 <main+0x1166>
    4d00:	e9 41 dc ff ff       	jmpq   2946 <main+0x1886>
    4d05:	48 8d 35 0d 4a 00 00 	lea    0x4a0d(%rip),%rsi        # 9719 <latfma256>
    4d0c:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4d12:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4d17:	e8 24 5d 00 00       	callq  aa40 <measureFunction>
    4d1c:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    4d22:	bf 01 00 00 00       	mov    $0x1,%edi
    4d27:	48 8d 35 42 6f 00 00 	lea    0x6f42(%rip),%rsi        # bc70 <_IO_stdin_used+0xc70>
    4d2e:	b8 01 00 00 00       	mov    $0x1,%eax
    4d33:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    4d37:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4d3b:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    4d3f:	e8 3c c3 ff ff       	callq  1080 <__printf_chk@plt>
    4d44:	41 83 fc 01          	cmp    $0x1,%r12d
    4d48:	0f 8f 79 d4 ff ff    	jg     21c7 <main+0x1107>
    4d4e:	e9 f3 db ff ff       	jmpq   2946 <main+0x1886>
    4d53:	48 8d 35 0d 41 00 00 	lea    0x410d(%rip),%rsi        # 8e67 <fma128>
    4d5a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4d60:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4d65:	e8 d6 5c 00 00       	callq  aa40 <measureFunction>
    4d6a:	bf 01 00 00 00       	mov    $0x1,%edi
    4d6f:	b8 01 00 00 00       	mov    $0x1,%eax
    4d74:	48 8d 35 48 67 00 00 	lea    0x6748(%rip),%rsi        # b4c3 <_IO_stdin_used+0x4c3>
    4d7b:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4d7f:	e8 fc c2 ff ff       	callq  1080 <__printf_chk@plt>
    4d84:	41 83 fc 01          	cmp    $0x1,%r12d
    4d88:	0f 8f da d3 ff ff    	jg     2168 <main+0x10a8>
    4d8e:	e9 b3 db ff ff       	jmpq   2946 <main+0x1886>
    4d93:	48 8d 35 15 40 00 00 	lea    0x4015(%rip),%rsi        # 8daf <fma256>
    4d9a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4da0:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4da5:	e8 96 5c 00 00       	callq  aa40 <measureFunction>
    4daa:	bf 01 00 00 00       	mov    $0x1,%edi
    4daf:	b8 01 00 00 00       	mov    $0x1,%eax
    4db4:	48 8d 35 23 67 00 00 	lea    0x6723(%rip),%rsi        # b4de <_IO_stdin_used+0x4de>
    4dbb:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4dbf:	e8 bc c2 ff ff       	callq  1080 <__printf_chk@plt>
    4dc4:	41 83 fc 01          	cmp    $0x1,%r12d
    4dc8:	0f 8f 49 d3 ff ff    	jg     2117 <main+0x1057>
    4dce:	e9 73 db ff ff       	jmpq   2946 <main+0x1886>
    4dd3:	48 8d 35 43 3a 00 00 	lea    0x3a43(%rip),%rsi        # 881d <mul128int>
    4dda:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4de0:	4c 89 f7             	mov    %r14,%rdi
    4de3:	e8 58 5c 00 00       	callq  aa40 <measureFunction>
    4de8:	bf 01 00 00 00       	mov    $0x1,%edi
    4ded:	b8 01 00 00 00       	mov    $0x1,%eax
    4df2:	48 8d 35 9f 6e 00 00 	lea    0x6e9f(%rip),%rsi        # bc98 <_IO_stdin_used+0xc98>
    4df9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4dfd:	e8 7e c2 ff ff       	callq  1080 <__printf_chk@plt>
    4e02:	41 83 fc 01          	cmp    $0x1,%r12d
    4e06:	0f 8f ba d2 ff ff    	jg     20c6 <main+0x1006>
    4e0c:	e9 35 db ff ff       	jmpq   2946 <main+0x1886>
    4e11:	48 8d 35 9c 35 00 00 	lea    0x359c(%rip),%rsi        # 83b4 <add128int>
    4e18:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4e1e:	4c 89 f7             	mov    %r14,%rdi
    4e21:	e8 1a 5c 00 00       	callq  aa40 <measureFunction>
    4e26:	bf 01 00 00 00       	mov    $0x1,%edi
    4e2b:	b8 01 00 00 00       	mov    $0x1,%eax
    4e30:	48 8d 35 89 6e 00 00 	lea    0x6e89(%rip),%rsi        # bcc0 <_IO_stdin_used+0xcc0>
    4e37:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4e3b:	e8 40 c2 ff ff       	callq  1080 <__printf_chk@plt>
    4e40:	41 83 fc 01          	cmp    $0x1,%r12d
    4e44:	0f 8f 2d d2 ff ff    	jg     2077 <main+0xfb7>
    4e4a:	e9 f7 da ff ff       	jmpq   2946 <main+0x1886>
    4e4f:	48 8d 35 f6 4a 00 00 	lea    0x4af6(%rip),%rsi        # 994c <mul128fp>
    4e56:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4e5c:	4c 89 f7             	mov    %r14,%rdi
    4e5f:	e8 dc 5b 00 00       	callq  aa40 <measureFunction>
    4e64:	bf 01 00 00 00       	mov    $0x1,%edi
    4e69:	b8 01 00 00 00       	mov    $0x1,%eax
    4e6e:	48 8d 35 73 6e 00 00 	lea    0x6e73(%rip),%rsi        # bce8 <_IO_stdin_used+0xce8>
    4e75:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4e79:	e8 02 c2 ff ff       	callq  1080 <__printf_chk@plt>
    4e7e:	41 83 fc 01          	cmp    $0x1,%r12d
    4e82:	0f 8f a0 d1 ff ff    	jg     2028 <main+0xf68>
    4e88:	e9 b9 da ff ff       	jmpq   2946 <main+0x1886>
    4e8d:	48 8d 35 27 4b 00 00 	lea    0x4b27(%rip),%rsi        # 99bb <add128fp>
    4e94:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4e9a:	4c 89 f7             	mov    %r14,%rdi
    4e9d:	e8 9e 5b 00 00       	callq  aa40 <measureFunction>
    4ea2:	bf 01 00 00 00       	mov    $0x1,%edi
    4ea7:	b8 01 00 00 00       	mov    $0x1,%eax
    4eac:	48 8d 35 55 6e 00 00 	lea    0x6e55(%rip),%rsi        # bd08 <_IO_stdin_used+0xd08>
    4eb3:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    4eb7:	e8 c4 c1 ff ff       	callq  1080 <__printf_chk@plt>
    4ebc:	41 83 fc 01          	cmp    $0x1,%r12d
    4ec0:	0f 8f 13 d1 ff ff    	jg     1fd9 <main+0xf19>
    4ec6:	e9 7b da ff ff       	jmpq   2946 <main+0x1886>
    4ecb:	48 8d 35 1a 4a 00 00 	lea    0x4a1a(%rip),%rsi        # 98ec <latmul128fp>
    4ed2:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4ed8:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4edd:	e8 5e 5b 00 00       	callq  aa40 <measureFunction>
    4ee2:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    4ee8:	bf 01 00 00 00       	mov    $0x1,%edi
    4eed:	48 8d 35 34 6e 00 00 	lea    0x6e34(%rip),%rsi        # bd28 <_IO_stdin_used+0xd28>
    4ef4:	b8 01 00 00 00       	mov    $0x1,%eax
    4ef9:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    4efd:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4f01:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    4f05:	e8 76 c1 ff ff       	callq  1080 <__printf_chk@plt>
    4f0a:	41 83 fc 01          	cmp    $0x1,%r12d
    4f0e:	0f 8f 76 d0 ff ff    	jg     1f8a <main+0xeca>
    4f14:	e9 2d da ff ff       	jmpq   2946 <main+0x1886>
    4f19:	48 8d 35 6c 49 00 00 	lea    0x496c(%rip),%rsi        # 988c <latadd128fp>
    4f20:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4f26:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4f2b:	e8 10 5b 00 00       	callq  aa40 <measureFunction>
    4f30:	f3 0f 10 74 24 0c    	movss  0xc(%rsp),%xmm6
    4f36:	bf 01 00 00 00       	mov    $0x1,%edi
    4f3b:	48 8d 35 0e 6e 00 00 	lea    0x6e0e(%rip),%rsi        # bd50 <_IO_stdin_used+0xd50>
    4f42:	b8 01 00 00 00       	mov    $0x1,%eax
    4f47:	f3 0f 5e f0          	divss  %xmm0,%xmm6
    4f4b:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4f4f:	f3 0f 5a c6          	cvtss2sd %xmm6,%xmm0
    4f53:	e8 28 c1 ff ff       	callq  1080 <__printf_chk@plt>
    4f58:	41 83 fc 01          	cmp    $0x1,%r12d
    4f5c:	0f 8f c9 cf ff ff    	jg     1f2b <main+0xe6b>
    4f62:	e9 df d9 ff ff       	jmpq   2946 <main+0x1886>
    4f67:	48 8d 35 0d 3c 00 00 	lea    0x3c0d(%rip),%rsi        # 8b7b <latmul256fp>
    4f6e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4f74:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4f79:	e8 c2 5a 00 00       	callq  aa40 <measureFunction>
    4f7e:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    4f84:	bf 01 00 00 00       	mov    $0x1,%edi
    4f89:	48 8d 35 e8 6d 00 00 	lea    0x6de8(%rip),%rsi        # bd78 <_IO_stdin_used+0xd78>
    4f90:	b8 01 00 00 00       	mov    $0x1,%eax
    4f95:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    4f99:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4f9d:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    4fa1:	e8 da c0 ff ff       	callq  1080 <__printf_chk@plt>
    4fa6:	41 83 fc 01          	cmp    $0x1,%r12d
    4faa:	0f 8f 1c cf ff ff    	jg     1ecc <main+0xe0c>
    4fb0:	e9 91 d9 ff ff       	jmpq   2946 <main+0x1886>
    4fb5:	48 8d 35 05 3a 00 00 	lea    0x3a05(%rip),%rsi        # 89c1 <latadd256fp>
    4fbc:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    4fc2:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    4fc7:	e8 74 5a 00 00       	callq  aa40 <measureFunction>
    4fcc:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    4fd2:	bf 01 00 00 00       	mov    $0x1,%edi
    4fd7:	48 8d 35 c2 6d 00 00 	lea    0x6dc2(%rip),%rsi        # bda0 <_IO_stdin_used+0xda0>
    4fde:	b8 01 00 00 00       	mov    $0x1,%eax
    4fe3:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    4fe7:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4feb:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    4fef:	e8 8c c0 ff ff       	callq  1080 <__printf_chk@plt>
    4ff4:	41 83 fc 01          	cmp    $0x1,%r12d
    4ff8:	0f 8f 6f ce ff ff    	jg     1e6d <main+0xdad>
    4ffe:	e9 43 d9 ff ff       	jmpq   2946 <main+0x1886>
    5003:	48 8d 35 92 38 00 00 	lea    0x3892(%rip),%rsi        # 889c <latmul128int>
    500a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5010:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5015:	e8 26 5a 00 00       	callq  aa40 <measureFunction>
    501a:	f3 0f 10 74 24 0c    	movss  0xc(%rsp),%xmm6
    5020:	bf 01 00 00 00       	mov    $0x1,%edi
    5025:	48 8d 35 9c 6d 00 00 	lea    0x6d9c(%rip),%rsi        # bdc8 <_IO_stdin_used+0xdc8>
    502c:	b8 01 00 00 00       	mov    $0x1,%eax
    5031:	f3 0f 5e f0          	divss  %xmm0,%xmm6
    5035:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5039:	f3 0f 5a c6          	cvtss2sd %xmm6,%xmm0
    503d:	e8 3e c0 ff ff       	callq  1080 <__printf_chk@plt>
    5042:	41 83 fc 01          	cmp    $0x1,%r12d
    5046:	0f 8f c2 cd ff ff    	jg     1e0e <main+0xd4e>
    504c:	e9 f5 d8 ff ff       	jmpq   2946 <main+0x1886>
    5051:	48 8d 35 f1 32 00 00 	lea    0x32f1(%rip),%rsi        # 8349 <latadd128int>
    5058:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    505e:	4c 89 f7             	mov    %r14,%rdi
    5061:	e8 da 59 00 00       	callq  aa40 <measureFunction>
    5066:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    506c:	bf 01 00 00 00       	mov    $0x1,%edi
    5071:	48 8d 35 88 6d 00 00 	lea    0x6d88(%rip),%rsi        # be00 <_IO_stdin_used+0xe00>
    5078:	b8 01 00 00 00       	mov    $0x1,%eax
    507d:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    5081:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5085:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    5089:	e8 f2 bf ff ff       	callq  1080 <__printf_chk@plt>
    508e:	41 83 fc 01          	cmp    $0x1,%r12d
    5092:	0f 8f 17 cd ff ff    	jg     1daf <main+0xcef>
    5098:	e9 a9 d8 ff ff       	jmpq   2946 <main+0x1886>
    509d:	48 8d 35 f7 31 00 00 	lea    0x31f7(%rip),%rsi        # 829b <latmul256int>
    50a4:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    50aa:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    50af:	e8 8c 59 00 00       	callq  aa40 <measureFunction>
    50b4:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    50ba:	bf 01 00 00 00       	mov    $0x1,%edi
    50bf:	48 8d 35 6a 6d 00 00 	lea    0x6d6a(%rip),%rsi        # be30 <_IO_stdin_used+0xe30>
    50c6:	b8 01 00 00 00       	mov    $0x1,%eax
    50cb:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    50cf:	66 0f ef c0          	pxor   %xmm0,%xmm0
    50d3:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    50d7:	e8 a4 bf ff ff       	callq  1080 <__printf_chk@plt>
    50dc:	41 83 fc 01          	cmp    $0x1,%r12d
    50e0:	0f 8f 6c cc ff ff    	jg     1d52 <main+0xc92>
    50e6:	e9 5b d8 ff ff       	jmpq   2946 <main+0x1886>
    50eb:	48 8d 35 be 2d 00 00 	lea    0x2dbe(%rip),%rsi        # 7eb0 <latadd256int>
    50f2:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    50f8:	4c 89 f7             	mov    %r14,%rdi
    50fb:	e8 40 59 00 00       	callq  aa40 <measureFunction>
    5100:	f3 0f 10 74 24 0c    	movss  0xc(%rsp),%xmm6
    5106:	bf 01 00 00 00       	mov    $0x1,%edi
    510b:	48 8d 35 56 6d 00 00 	lea    0x6d56(%rip),%rsi        # be68 <_IO_stdin_used+0xe68>
    5112:	b8 01 00 00 00       	mov    $0x1,%eax
    5117:	f3 0f 5e f0          	divss  %xmm0,%xmm6
    511b:	66 0f ef c0          	pxor   %xmm0,%xmm0
    511f:	f3 0f 5a c6          	cvtss2sd %xmm6,%xmm0
    5123:	e8 58 bf ff ff       	callq  1080 <__printf_chk@plt>
    5128:	41 83 fc 01          	cmp    $0x1,%r12d
    512c:	0f 8f c1 cb ff ff    	jg     1cf3 <main+0xc33>
    5132:	e9 0f d8 ff ff       	jmpq   2946 <main+0x1886>
    5137:	48 8d 35 62 2b 00 00 	lea    0x2b62(%rip),%rsi        # 7ca0 <mix256fp>
    513e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5144:	4c 89 f7             	mov    %r14,%rdi
    5147:	e8 f4 58 00 00       	callq  aa40 <measureFunction>
    514c:	bf 01 00 00 00       	mov    $0x1,%edi
    5151:	b8 01 00 00 00       	mov    $0x1,%eax
    5156:	48 8d 35 3b 6d 00 00 	lea    0x6d3b(%rip),%rsi        # be98 <_IO_stdin_used+0xe98>
    515d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5161:	e8 1a bf ff ff       	callq  1080 <__printf_chk@plt>
    5166:	41 83 fc 01          	cmp    $0x1,%r12d
    516a:	0f 8f 26 cb ff ff    	jg     1c96 <main+0xbd6>
    5170:	e9 d1 d7 ff ff       	jmpq   2946 <main+0x1886>
    5175:	48 8d 35 cf 29 00 00 	lea    0x29cf(%rip),%rsi        # 7b4b <mixadd256fpint>
    517c:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5182:	4c 89 f7             	mov    %r14,%rdi
    5185:	e8 b6 58 00 00       	callq  aa40 <measureFunction>
    518a:	bf 01 00 00 00       	mov    $0x1,%edi
    518f:	b8 01 00 00 00       	mov    $0x1,%eax
    5194:	48 8d 35 2d 6d 00 00 	lea    0x6d2d(%rip),%rsi        # bec8 <_IO_stdin_used+0xec8>
    519b:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    519f:	e8 dc be ff ff       	callq  1080 <__printf_chk@plt>
    51a4:	41 83 fc 01          	cmp    $0x1,%r12d
    51a8:	0f 8f 99 ca ff ff    	jg     1c47 <main+0xb87>
    51ae:	e9 93 d7 ff ff       	jmpq   2946 <main+0x1886>
    51b3:	48 8d 35 4f 2c 00 00 	lea    0x2c4f(%rip),%rsi        # 7e09 <mixadd256int11>
    51ba:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    51c0:	4c 89 f7             	mov    %r14,%rdi
    51c3:	e8 78 58 00 00       	callq  aa40 <measureFunction>
    51c8:	bf 01 00 00 00       	mov    $0x1,%edi
    51cd:	b8 01 00 00 00       	mov    $0x1,%eax
    51d2:	48 8d 35 1f 6d 00 00 	lea    0x6d1f(%rip),%rsi        # bef8 <_IO_stdin_used+0xef8>
    51d9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    51dd:	e8 9e be ff ff       	callq  1080 <__printf_chk@plt>
    51e2:	41 83 fc 01          	cmp    $0x1,%r12d
    51e6:	0f 8f 0c ca ff ff    	jg     1bf8 <main+0xb38>
    51ec:	e9 55 d7 ff ff       	jmpq   2946 <main+0x1886>
    51f1:	48 8d 35 4c 2b 00 00 	lea    0x2b4c(%rip),%rsi        # 7d44 <mixadd256int>
    51f8:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    51fe:	4c 89 f7             	mov    %r14,%rdi
    5201:	e8 3a 58 00 00       	callq  aa40 <measureFunction>
    5206:	bf 01 00 00 00       	mov    $0x1,%edi
    520b:	b8 01 00 00 00       	mov    $0x1,%eax
    5210:	48 8d 35 19 6d 00 00 	lea    0x6d19(%rip),%rsi        # bf30 <_IO_stdin_used+0xf30>
    5217:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    521b:	e8 60 be ff ff       	callq  1080 <__printf_chk@plt>
    5220:	41 83 fc 01          	cmp    $0x1,%r12d
    5224:	0f 8f 7f c9 ff ff    	jg     1ba9 <main+0xae9>
    522a:	e9 17 d7 ff ff       	jmpq   2946 <main+0x1886>
    522f:	48 8d 35 55 26 00 00 	lea    0x2655(%rip),%rsi        # 788b <add256int>
    5236:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    523c:	4c 89 f7             	mov    %r14,%rdi
    523f:	e8 fc 57 00 00       	callq  aa40 <measureFunction>
    5244:	bf 01 00 00 00       	mov    $0x1,%edi
    5249:	b8 01 00 00 00       	mov    $0x1,%eax
    524e:	48 8d 35 13 6d 00 00 	lea    0x6d13(%rip),%rsi        # bf68 <_IO_stdin_used+0xf68>
    5255:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5259:	e8 22 be ff ff       	callq  1080 <__printf_chk@plt>
    525e:	41 83 fc 01          	cmp    $0x1,%r12d
    5262:	0f 8f f2 c8 ff ff    	jg     1b5a <main+0xa9a>
    5268:	e9 d9 d6 ff ff       	jmpq   2946 <main+0x1886>
    526d:	48 8d 35 02 21 00 00 	lea    0x2102(%rip),%rsi        # 7376 <leamultest>
    5274:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    527a:	4c 89 f7             	mov    %r14,%rdi
    527d:	e8 be 57 00 00       	callq  aa40 <measureFunction>
    5282:	bf 01 00 00 00       	mov    $0x1,%edi
    5287:	b8 01 00 00 00       	mov    $0x1,%eax
    528c:	48 8d 35 fd 6c 00 00 	lea    0x6cfd(%rip),%rsi        # bf90 <_IO_stdin_used+0xf90>
    5293:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5297:	e8 e4 bd ff ff       	callq  1080 <__printf_chk@plt>
    529c:	41 83 fc 01          	cmp    $0x1,%r12d
    52a0:	0f 8f 65 c8 ff ff    	jg     1b0b <main+0xa4b>
    52a6:	e9 9b d6 ff ff       	jmpq   2946 <main+0x1886>
    52ab:	48 8d 35 21 20 00 00 	lea    0x2021(%rip),%rsi        # 72d3 <leatest>
    52b2:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    52b8:	4c 89 f7             	mov    %r14,%rdi
    52bb:	e8 80 57 00 00       	callq  aa40 <measureFunction>
    52c0:	bf 01 00 00 00       	mov    $0x1,%edi
    52c5:	b8 01 00 00 00       	mov    $0x1,%eax
    52ca:	48 8d 35 28 62 00 00 	lea    0x6228(%rip),%rsi        # b4f9 <_IO_stdin_used+0x4f9>
    52d1:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    52d5:	e8 a6 bd ff ff       	callq  1080 <__printf_chk@plt>
    52da:	41 83 fc 01          	cmp    $0x1,%r12d
    52de:	0f 8f d8 c7 ff ff    	jg     1abc <main+0x9fc>
    52e4:	e9 5d d6 ff ff       	jmpq   2946 <main+0x1886>
    52e9:	48 8d 35 a3 1e 00 00 	lea    0x1ea3(%rip),%rsi        # 7193 <rorbtstest>
    52f0:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    52f6:	4c 89 f7             	mov    %r14,%rdi
    52f9:	e8 42 57 00 00       	callq  aa40 <measureFunction>
    52fe:	bf 01 00 00 00       	mov    $0x1,%edi
    5303:	b8 01 00 00 00       	mov    $0x1,%eax
    5308:	48 8d 35 03 62 00 00 	lea    0x6203(%rip),%rsi        # b512 <_IO_stdin_used+0x512>
    530f:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5313:	e8 68 bd ff ff       	callq  1080 <__printf_chk@plt>
    5318:	41 83 fc 01          	cmp    $0x1,%r12d
    531c:	0f 8f 4b c7 ff ff    	jg     1a6d <main+0x9ad>
    5322:	e9 1f d6 ff ff       	jmpq   2946 <main+0x1886>
    5327:	48 8d 35 fb 20 00 00 	lea    0x20fb(%rip),%rsi        # 7429 <btsmultest>
    532e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5334:	4c 89 f7             	mov    %r14,%rdi
    5337:	e8 04 57 00 00       	callq  aa40 <measureFunction>
    533c:	bf 01 00 00 00       	mov    $0x1,%edi
    5341:	b8 01 00 00 00       	mov    $0x1,%eax
    5346:	48 8d 35 e0 61 00 00 	lea    0x61e0(%rip),%rsi        # b52d <_IO_stdin_used+0x52d>
    534d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5351:	e8 2a bd ff ff       	callq  1080 <__printf_chk@plt>
    5356:	41 83 fc 01          	cmp    $0x1,%r12d
    535a:	0f 8f be c6 ff ff    	jg     1a1e <main+0x95e>
    5360:	e9 e1 d5 ff ff       	jmpq   2946 <main+0x1886>
    5365:	48 8d 35 c4 1e 00 00 	lea    0x1ec4(%rip),%rsi        # 7230 <btstest>
    536c:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5372:	4c 89 f7             	mov    %r14,%rdi
    5375:	e8 c6 56 00 00       	callq  aa40 <measureFunction>
    537a:	bf 01 00 00 00       	mov    $0x1,%edi
    537f:	b8 01 00 00 00       	mov    $0x1,%eax
    5384:	48 8d 35 bd 61 00 00 	lea    0x61bd(%rip),%rsi        # b548 <_IO_stdin_used+0x548>
    538b:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    538f:	e8 ec bc ff ff       	callq  1080 <__printf_chk@plt>
    5394:	41 83 fc 01          	cmp    $0x1,%r12d
    5398:	0f 8f 31 c6 ff ff    	jg     19cf <main+0x90f>
    539e:	e9 a3 d5 ff ff       	jmpq   2946 <main+0x1886>
    53a3:	48 8d 35 34 1d 00 00 	lea    0x1d34(%rip),%rsi        # 70de <mixrormultest>
    53aa:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    53b0:	4c 89 f7             	mov    %r14,%rdi
    53b3:	e8 88 56 00 00       	callq  aa40 <measureFunction>
    53b8:	bf 01 00 00 00       	mov    $0x1,%edi
    53bd:	b8 01 00 00 00       	mov    $0x1,%eax
    53c2:	48 8d 35 92 61 00 00 	lea    0x6192(%rip),%rsi        # b55b <_IO_stdin_used+0x55b>
    53c9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    53cd:	e8 ae bc ff ff       	callq  1080 <__printf_chk@plt>
    53d2:	41 83 fc 01          	cmp    $0x1,%r12d
    53d6:	0f 8f a4 c5 ff ff    	jg     1980 <main+0x8c0>
    53dc:	e9 65 d5 ff ff       	jmpq   2946 <main+0x1886>
    53e1:	48 8d 35 6a 1c 00 00 	lea    0x1c6a(%rip),%rsi        # 7052 <mixrorshltest>
    53e8:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    53ee:	4c 89 f7             	mov    %r14,%rdi
    53f1:	e8 4a 56 00 00       	callq  aa40 <measureFunction>
    53f6:	bf 01 00 00 00       	mov    $0x1,%edi
    53fb:	b8 01 00 00 00       	mov    $0x1,%eax
    5400:	48 8d 35 b1 6b 00 00 	lea    0x6bb1(%rip),%rsi        # bfb8 <_IO_stdin_used+0xfb8>
    5407:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    540b:	e8 70 bc ff ff       	callq  1080 <__printf_chk@plt>
    5410:	41 83 fc 01          	cmp    $0x1,%r12d
    5414:	0f 8f 17 c5 ff ff    	jg     1931 <main+0x871>
    541a:	e9 27 d5 ff ff       	jmpq   2946 <main+0x1886>
    541f:	48 8d 35 14 1b 00 00 	lea    0x1b14(%rip),%rsi        # 6f3a <rortest>
    5426:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    542c:	4c 89 f7             	mov    %r14,%rdi
    542f:	e8 0c 56 00 00       	callq  aa40 <measureFunction>
    5434:	bf 01 00 00 00       	mov    $0x1,%edi
    5439:	b8 01 00 00 00       	mov    $0x1,%eax
    543e:	48 8d 35 31 61 00 00 	lea    0x6131(%rip),%rsi        # b576 <_IO_stdin_used+0x576>
    5445:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5449:	e8 32 bc ff ff       	callq  1080 <__printf_chk@plt>
    544e:	41 83 fc 01          	cmp    $0x1,%r12d
    5452:	0f 8f 8a c4 ff ff    	jg     18e2 <main+0x822>
    5458:	e9 e9 d4 ff ff       	jmpq   2946 <main+0x1886>
    545d:	48 8d 35 62 1b 00 00 	lea    0x1b62(%rip),%rsi        # 6fc6 <shltest>
    5464:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    546a:	4c 89 f7             	mov    %r14,%rdi
    546d:	e8 ce 55 00 00       	callq  aa40 <measureFunction>
    5472:	bf 01 00 00 00       	mov    $0x1,%edi
    5477:	b8 01 00 00 00       	mov    $0x1,%eax
    547c:	48 8d 35 0a 61 00 00 	lea    0x610a(%rip),%rsi        # b58d <_IO_stdin_used+0x58d>
    5483:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5487:	e8 f4 bb ff ff       	callq  1080 <__printf_chk@plt>
    548c:	41 83 fc 01          	cmp    $0x1,%r12d
    5490:	0f 8f fd c3 ff ff    	jg     1893 <main+0x7d3>
    5496:	e9 ab d4 ff ff       	jmpq   2946 <main+0x1886>
    549b:	48 8d 35 42 4f 00 00 	lea    0x4f42(%rip),%rsi        # a3e4 <pdepmultest>
    54a2:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    54a8:	4c 89 f7             	mov    %r14,%rdi
    54ab:	e8 90 55 00 00       	callq  aa40 <measureFunction>
    54b0:	bf 01 00 00 00       	mov    $0x1,%edi
    54b5:	b8 01 00 00 00       	mov    $0x1,%eax
    54ba:	48 8d 35 e3 60 00 00 	lea    0x60e3(%rip),%rsi        # b5a4 <_IO_stdin_used+0x5a4>
    54c1:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    54c5:	e8 b6 bb ff ff       	callq  1080 <__printf_chk@plt>
    54ca:	41 83 fc 01          	cmp    $0x1,%r12d
    54ce:	0f 8f 70 c3 ff ff    	jg     1844 <main+0x784>
    54d4:	e9 6d d4 ff ff       	jmpq   2946 <main+0x1886>
    54d9:	48 8d 35 b3 4f 00 00 	lea    0x4fb3(%rip),%rsi        # a493 <pexttest>
    54e0:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    54e6:	4c 89 f7             	mov    %r14,%rdi
    54e9:	e8 52 55 00 00       	callq  aa40 <measureFunction>
    54ee:	bf 01 00 00 00       	mov    $0x1,%edi
    54f3:	b8 01 00 00 00       	mov    $0x1,%eax
    54f8:	48 8d 35 c1 60 00 00 	lea    0x60c1(%rip),%rsi        # b5c0 <_IO_stdin_used+0x5c0>
    54ff:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5503:	e8 78 bb ff ff       	callq  1080 <__printf_chk@plt>
    5508:	41 83 fc 01          	cmp    $0x1,%r12d
    550c:	0f 8f e3 c2 ff ff    	jg     17f5 <main+0x735>
    5512:	e9 2f d4 ff ff       	jmpq   2946 <main+0x1886>
    5517:	48 8d 35 12 4e 00 00 	lea    0x4e12(%rip),%rsi        # a330 <pdeptest>
    551e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5524:	4c 89 f7             	mov    %r14,%rdi
    5527:	e8 14 55 00 00       	callq  aa40 <measureFunction>
    552c:	bf 01 00 00 00       	mov    $0x1,%edi
    5531:	b8 01 00 00 00       	mov    $0x1,%eax
    5536:	48 8d 35 97 60 00 00 	lea    0x6097(%rip),%rsi        # b5d4 <_IO_stdin_used+0x5d4>
    553d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5541:	e8 3a bb ff ff       	callq  1080 <__printf_chk@plt>
    5546:	41 83 fc 01          	cmp    $0x1,%r12d
    554a:	0f 8f 56 c2 ff ff    	jg     17a6 <main+0x6e6>
    5550:	e9 f1 d3 ff ff       	jmpq   2946 <main+0x1886>
    5555:	48 8d 35 6d 20 00 00 	lea    0x206d(%rip),%rsi        # 75c9 <ntjmptest>
    555c:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5562:	4c 89 f7             	mov    %r14,%rdi
    5565:	e8 d6 54 00 00       	callq  aa40 <measureFunction>
    556a:	bf 01 00 00 00       	mov    $0x1,%edi
    556f:	b8 01 00 00 00       	mov    $0x1,%eax
    5574:	48 8d 35 6d 60 00 00 	lea    0x606d(%rip),%rsi        # b5e8 <_IO_stdin_used+0x5e8>
    557b:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    557f:	e8 fc ba ff ff       	callq  1080 <__printf_chk@plt>
    5584:	41 83 fc 01          	cmp    $0x1,%r12d
    5588:	0f 8f c9 c1 ff ff    	jg     1757 <main+0x697>
    558e:	e9 b3 d3 ff ff       	jmpq   2946 <main+0x1886>
    5593:	48 8d 35 57 1f 00 00 	lea    0x1f57(%rip),%rsi        # 74f1 <jmptest>
    559a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    55a0:	4c 89 f7             	mov    %r14,%rdi
    55a3:	e8 98 54 00 00       	callq  aa40 <measureFunction>
    55a8:	bf 01 00 00 00       	mov    $0x1,%edi
    55ad:	b8 01 00 00 00       	mov    $0x1,%eax
    55b2:	48 8d 35 45 60 00 00 	lea    0x6045(%rip),%rsi        # b5fe <_IO_stdin_used+0x5fe>
    55b9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    55bd:	e8 be ba ff ff       	callq  1080 <__printf_chk@plt>
    55c2:	41 83 fc 01          	cmp    $0x1,%r12d
    55c6:	0f 8f 3c c1 ff ff    	jg     1708 <main+0x648>
    55cc:	e9 75 d3 ff ff       	jmpq   2946 <main+0x1886>
    55d1:	48 8d 35 0f 21 00 00 	lea    0x210f(%rip),%rsi        # 76e7 <jmpmultest>
    55d8:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    55de:	4c 89 f7             	mov    %r14,%rdi
    55e1:	e8 5a 54 00 00       	callq  aa40 <measureFunction>
    55e6:	bf 01 00 00 00       	mov    $0x1,%edi
    55eb:	b8 01 00 00 00       	mov    $0x1,%eax
    55f0:	48 8d 35 20 60 00 00 	lea    0x6020(%rip),%rsi        # b617 <_IO_stdin_used+0x617>
    55f7:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    55fb:	e8 80 ba ff ff       	callq  1080 <__printf_chk@plt>
    5600:	41 83 fc 01          	cmp    $0x1,%r12d
    5604:	0f 8f af c0 ff ff    	jg     16b9 <main+0x5f9>
    560a:	e9 37 d3 ff ff       	jmpq   2946 <main+0x1886>
    560f:	48 8d 35 8e 21 00 00 	lea    0x218e(%rip),%rsi        # 77a4 <addmultest>
    5616:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    561c:	4c 89 f7             	mov    %r14,%rdi
    561f:	e8 1c 54 00 00       	callq  aa40 <measureFunction>
    5624:	bf 01 00 00 00       	mov    $0x1,%edi
    5629:	b8 01 00 00 00       	mov    $0x1,%eax
    562e:	48 8d 35 fd 5f 00 00 	lea    0x5ffd(%rip),%rsi        # b632 <_IO_stdin_used+0x632>
    5635:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5639:	e8 42 ba ff ff       	callq  1080 <__printf_chk@plt>
    563e:	41 83 fc 01          	cmp    $0x1,%r12d
    5642:	0f 8f 22 c0 ff ff    	jg     166a <main+0x5aa>
    5648:	e9 f9 d2 ff ff       	jmpq   2946 <main+0x1886>
    564d:	48 8d 35 52 16 00 00 	lea    0x1652(%rip),%rsi        # 6ca6 <clkmovtest>
    5654:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    565a:	4c 89 f7             	mov    %r14,%rdi
    565d:	e8 de 53 00 00       	callq  aa40 <measureFunction>
    5662:	bf 01 00 00 00       	mov    $0x1,%edi
    5667:	b8 01 00 00 00       	mov    $0x1,%eax
    566c:	48 8d 35 65 69 00 00 	lea    0x6965(%rip),%rsi        # bfd8 <_IO_stdin_used+0xfd8>
    5673:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5677:	e8 04 ba ff ff       	callq  1080 <__printf_chk@plt>
    567c:	41 83 fc 01          	cmp    $0x1,%r12d
    5680:	0f 8f 95 bf ff ff    	jg     161b <main+0x55b>
    5686:	e9 bb d2 ff ff       	jmpq   2946 <main+0x1886>
    568b:	48 8d 35 5c 52 00 00 	lea    0x525c(%rip),%rsi        # a8ee <depdectest>
    5692:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5698:	4c 89 f7             	mov    %r14,%rdi
    569b:	e8 a0 53 00 00       	callq  aa40 <measureFunction>
    56a0:	bf 01 00 00 00       	mov    $0x1,%edi
    56a5:	b8 01 00 00 00       	mov    $0x1,%eax
    56aa:	48 8d 35 9e 5f 00 00 	lea    0x5f9e(%rip),%rsi        # b64f <_IO_stdin_used+0x64f>
    56b1:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    56b5:	e8 c6 b9 ff ff       	callq  1080 <__printf_chk@plt>
    56ba:	41 83 fc 01          	cmp    $0x1,%r12d
    56be:	0f 8f bd be ff ff    	jg     1581 <main+0x4c1>
    56c4:	e9 7d d2 ff ff       	jmpq   2946 <main+0x1886>
    56c9:	48 8d 35 a7 51 00 00 	lea    0x51a7(%rip),%rsi        # a877 <depinctest>
    56d0:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    56d6:	4c 89 f7             	mov    %r14,%rdi
    56d9:	e8 62 53 00 00       	callq  aa40 <measureFunction>
    56de:	bf 01 00 00 00       	mov    $0x1,%edi
    56e3:	b8 01 00 00 00       	mov    $0x1,%eax
    56e8:	48 8d 35 77 5f 00 00 	lea    0x5f77(%rip),%rsi        # b666 <_IO_stdin_used+0x666>
    56ef:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    56f3:	e8 88 b9 ff ff       	callq  1080 <__printf_chk@plt>
    56f8:	41 83 fc 01          	cmp    $0x1,%r12d
    56fc:	0f 8f 30 be ff ff    	jg     1532 <main+0x472>
    5702:	e9 3f d2 ff ff       	jmpq   2946 <main+0x1886>
    5707:	48 8d 35 67 50 00 00 	lea    0x5067(%rip),%rsi        # a775 <subzerotest>
    570e:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5714:	4c 89 f7             	mov    %r14,%rdi
    5717:	e8 24 53 00 00       	callq  aa40 <measureFunction>
    571c:	bf 01 00 00 00       	mov    $0x1,%edi
    5721:	b8 01 00 00 00       	mov    $0x1,%eax
    5726:	48 8d 35 50 5f 00 00 	lea    0x5f50(%rip),%rsi        # b67d <_IO_stdin_used+0x67d>
    572d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5731:	e8 4a b9 ff ff       	callq  1080 <__printf_chk@plt>
    5736:	41 83 fc 01          	cmp    $0x1,%r12d
    573a:	0f 8f a3 bd ff ff    	jg     14e3 <main+0x423>
    5740:	e9 01 d2 ff ff       	jmpq   2946 <main+0x1886>
    5745:	48 8d 35 e7 4e 00 00 	lea    0x4ee7(%rip),%rsi        # a633 <movzerotest>
    574c:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5752:	4c 89 f7             	mov    %r14,%rdi
    5755:	e8 e6 52 00 00       	callq  aa40 <measureFunction>
    575a:	bf 01 00 00 00       	mov    $0x1,%edi
    575f:	b8 01 00 00 00       	mov    $0x1,%eax
    5764:	48 8d 35 2a 5f 00 00 	lea    0x5f2a(%rip),%rsi        # b695 <_IO_stdin_used+0x695>
    576b:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    576f:	e8 0c b9 ff ff       	callq  1080 <__printf_chk@plt>
    5774:	41 83 fc 01          	cmp    $0x1,%r12d
    5778:	0f 8f 16 bd ff ff    	jg     1494 <main+0x3d4>
    577e:	e9 c3 d1 ff ff       	jmpq   2946 <main+0x1886>
    5783:	48 8d 35 74 4f 00 00 	lea    0x4f74(%rip),%rsi        # a6fe <xorzerotest>
    578a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5790:	4c 89 f7             	mov    %r14,%rdi
    5793:	e8 a8 52 00 00       	callq  aa40 <measureFunction>
    5798:	bf 01 00 00 00       	mov    $0x1,%edi
    579d:	b8 01 00 00 00       	mov    $0x1,%eax
    57a2:	48 8d 35 04 5f 00 00 	lea    0x5f04(%rip),%rsi        # b6ad <_IO_stdin_used+0x6ad>
    57a9:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    57ad:	e8 ce b8 ff ff       	callq  1080 <__printf_chk@plt>
    57b2:	41 83 fc 01          	cmp    $0x1,%r12d
    57b6:	0f 8f 89 bc ff ff    	jg     1445 <main+0x385>
    57bc:	e9 85 d1 ff ff       	jmpq   2946 <main+0x1886>
    57c1:	48 8d 35 f4 4d 00 00 	lea    0x4df4(%rip),%rsi        # a5bc <indepmovtest>
    57c8:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    57ce:	4c 89 f7             	mov    %r14,%rdi
    57d1:	e8 6a 52 00 00       	callq  aa40 <measureFunction>
    57d6:	bf 01 00 00 00       	mov    $0x1,%edi
    57db:	b8 01 00 00 00       	mov    $0x1,%eax
    57e0:	48 8d 35 41 68 00 00 	lea    0x6841(%rip),%rsi        # c028 <_IO_stdin_used+0x1028>
    57e7:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    57eb:	e8 90 b8 ff ff       	callq  1080 <__printf_chk@plt>
    57f0:	41 83 fc 01          	cmp    $0x1,%r12d
    57f4:	0f 8f fc bb ff ff    	jg     13f6 <main+0x336>
    57fa:	e9 47 d1 ff ff       	jmpq   2946 <main+0x1886>
    57ff:	48 8d 35 41 4d 00 00 	lea    0x4d41(%rip),%rsi        # a547 <depmovtest>
    5806:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    580c:	4c 89 f7             	mov    %r14,%rdi
    580f:	e8 2c 52 00 00       	callq  aa40 <measureFunction>
    5814:	bf 01 00 00 00       	mov    $0x1,%edi
    5819:	b8 01 00 00 00       	mov    $0x1,%eax
    581e:	48 8d 35 a0 5e 00 00 	lea    0x5ea0(%rip),%rsi        # b6c5 <_IO_stdin_used+0x6c5>
    5825:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5829:	e8 52 b8 ff ff       	callq  1080 <__printf_chk@plt>
    582e:	41 83 fc 01          	cmp    $0x1,%r12d
    5832:	0f 8f 6f bb ff ff    	jg     13a7 <main+0x2e7>
    5838:	e9 09 d1 ff ff       	jmpq   2946 <main+0x1886>
    583d:	48 8d 35 e6 15 00 00 	lea    0x15e6(%rip),%rsi        # 6e2a <addnoptest>
    5844:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    584a:	4c 89 f7             	mov    %r14,%rdi
    584d:	e8 ee 51 00 00       	callq  aa40 <measureFunction>
    5852:	bf 01 00 00 00       	mov    $0x1,%edi
    5857:	b8 01 00 00 00       	mov    $0x1,%eax
    585c:	48 8d 35 80 5e 00 00 	lea    0x5e80(%rip),%rsi        # b6e3 <_IO_stdin_used+0x6e3>
    5863:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5867:	e8 14 b8 ff ff       	callq  1080 <__printf_chk@plt>
    586c:	41 83 fc 01          	cmp    $0x1,%r12d
    5870:	0f 8f e2 ba ff ff    	jg     1358 <main+0x298>
    5876:	e9 cb d0 ff ff       	jmpq   2946 <main+0x1886>
    587b:	4c 8d 3d a8 15 00 00 	lea    0x15a8(%rip),%r15        # 6e2a <addnoptest>
    5882:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5888:	4c 89 f7             	mov    %r14,%rdi
    588b:	4c 89 fe             	mov    %r15,%rsi
    588e:	e8 ad 51 00 00       	callq  aa40 <measureFunction>
    5893:	bf 01 00 00 00       	mov    $0x1,%edi
    5898:	b8 01 00 00 00       	mov    $0x1,%eax
    589d:	48 8d 35 5c 5e 00 00 	lea    0x5e5c(%rip),%rsi        # b700 <_IO_stdin_used+0x700>
    58a4:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    58a8:	e8 d3 b7 ff ff       	callq  1080 <__printf_chk@plt>
    58ad:	41 83 fc 01          	cmp    $0x1,%r12d
    58b1:	0f 8f 5b ba ff ff    	jg     1312 <main+0x252>
    58b7:	e9 8a d0 ff ff       	jmpq   2946 <main+0x1886>
    58bc:	48 8d 35 db 14 00 00 	lea    0x14db(%rip),%rsi        # 6d9e <addtest>
    58c3:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    58c9:	4c 89 f7             	mov    %r14,%rdi
    58cc:	e8 6f 51 00 00       	callq  aa40 <measureFunction>
    58d1:	bf 01 00 00 00       	mov    $0x1,%edi
    58d6:	b8 01 00 00 00       	mov    $0x1,%eax
    58db:	48 8d 35 3b 5e 00 00 	lea    0x5e3b(%rip),%rsi        # b71d <_IO_stdin_used+0x71d>
    58e2:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    58e6:	e8 95 b7 ff ff       	callq  1080 <__printf_chk@plt>
    58eb:	41 83 fc 01          	cmp    $0x1,%r12d
    58ef:	0f 8f d0 b9 ff ff    	jg     12c5 <main+0x205>
    58f5:	e9 4c d0 ff ff       	jmpq   2946 <main+0x1886>
    58fa:	48 8d 35 3e 14 00 00 	lea    0x143e(%rip),%rsi        # 6d3f <noptest>
    5901:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5907:	4c 89 f7             	mov    %r14,%rdi
    590a:	e8 31 51 00 00       	callq  aa40 <measureFunction>
    590f:	bf 01 00 00 00       	mov    $0x1,%edi
    5914:	b8 01 00 00 00       	mov    $0x1,%eax
    5919:	48 8d 35 11 5e 00 00 	lea    0x5e11(%rip),%rsi        # b731 <_IO_stdin_used+0x731>
    5920:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5924:	e8 57 b7 ff ff       	callq  1080 <__printf_chk@plt>
    5929:	41 83 fc 01          	cmp    $0x1,%r12d
    592d:	0f 8f 43 b9 ff ff    	jg     1276 <main+0x1b6>
    5933:	e9 0e d0 ff ff       	jmpq   2946 <main+0x1886>
    5938:	45 31 ed             	xor    %r13d,%r13d
    593b:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    5940:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    5945:	e8 06 b7 ff ff       	callq  1050 <gettimeofday@plt>
    594a:	4c 89 f7             	mov    %r14,%rdi
    594d:	e8 f7 12 00 00       	callq  6c49 <clktest>
    5952:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    5957:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    595c:	e8 ef b6 ff ff       	callq  1050 <gettimeofday@plt>
    5961:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    5966:	48 2b 44 24 28       	sub    0x28(%rsp),%rax
    596b:	be e8 03 00 00       	mov    $0x3e8,%esi
    5970:	48 99                	cqto   
    5972:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    5977:	48 2b 4c 24 20       	sub    0x20(%rsp),%rcx
    597c:	48 f7 fe             	idiv   %rsi
    597f:	48 69 c9 e8 03 00 00 	imul   $0x3e8,%rcx,%rcx
    5986:	48 01 c1             	add    %rax,%rcx
    5989:	0f 88 03 0b 00 00    	js     6492 <main+0x53d2>
    598f:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5993:	f3 48 0f 2a c1       	cvtsi2ss %rcx,%xmm0
    5998:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    599c:	f2 0f 59 05 d4 66 00 	mulsd  0x66d4(%rip),%xmm0        # c078 <_IO_stdin_used+0x1078>
    59a3:	00 
    59a4:	4d 85 f6             	test   %r14,%r14
    59a7:	0f 88 cd 0a 00 00    	js     647a <main+0x53ba>
    59ad:	66 0f ef c9          	pxor   %xmm1,%xmm1
    59b1:	f3 49 0f 2a ce       	cvtsi2ss %r14,%xmm1
    59b6:	f3 0f 5a c9          	cvtss2sd %xmm1,%xmm1
    59ba:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
    59be:	bf 01 00 00 00       	mov    $0x1,%edi
    59c3:	f3 0f 10 2d bd 66 00 	movss  0x66bd(%rip),%xmm5        # c088 <_IO_stdin_used+0x1088>
    59ca:	00 
    59cb:	48 8d 35 a6 5d 00 00 	lea    0x5da6(%rip),%rsi        # b778 <_IO_stdin_used+0x778>
    59d2:	b8 01 00 00 00       	mov    $0x1,%eax
    59d7:	f3 0f 11 6c 24 0c    	movss  %xmm5,0xc(%rsp)
    59dd:	f2 0f 5a c0          	cvtsd2ss %xmm0,%xmm0
    59e1:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    59e5:	66 0f ef c0          	pxor   %xmm0,%xmm0
    59e9:	f3 0f 11 6c 24 08    	movss  %xmm5,0x8(%rsp)
    59ef:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    59f3:	e8 88 b6 ff ff       	callq  1080 <__printf_chk@plt>
    59f8:	45 85 ed             	test   %r13d,%r13d
    59fb:	0f 84 8f de ff ff    	je     3890 <main+0x27d0>
    5a01:	48 8d 35 ef 31 00 00 	lea    0x31ef(%rip),%rsi        # 8bf7 <fma512>
    5a08:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5a0e:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5a13:	e8 28 50 00 00       	callq  aa40 <measureFunction>
    5a18:	bf 01 00 00 00       	mov    $0x1,%edi
    5a1d:	b8 01 00 00 00       	mov    $0x1,%eax
    5a22:	48 8d 35 34 56 00 00 	lea    0x5634(%rip),%rsi        # b05d <_IO_stdin_used+0x5d>
    5a29:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5a2d:	e8 4e b6 ff ff       	callq  1080 <__printf_chk@plt>
    5a32:	48 8d 35 ff 3b 00 00 	lea    0x3bff(%rip),%rsi        # 9638 <latfma512>
    5a39:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5a3f:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5a44:	e8 f7 4f 00 00       	callq  aa40 <measureFunction>
    5a49:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    5a4f:	bf 01 00 00 00       	mov    $0x1,%edi
    5a54:	48 8d 35 45 5d 00 00 	lea    0x5d45(%rip),%rsi        # b7a0 <_IO_stdin_used+0x7a0>
    5a5b:	b8 01 00 00 00       	mov    $0x1,%eax
    5a60:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    5a64:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5a68:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    5a6c:	e8 0f b6 ff ff       	callq  1080 <__printf_chk@plt>
    5a71:	48 8d 35 60 32 00 00 	lea    0x3260(%rip),%rsi        # 8cd8 <mixfma256fma512>
    5a78:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5a7e:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5a83:	e8 b8 4f 00 00       	callq  aa40 <measureFunction>
    5a88:	bf 01 00 00 00       	mov    $0x1,%edi
    5a8d:	b8 01 00 00 00       	mov    $0x1,%eax
    5a92:	48 8d 35 2f 5d 00 00 	lea    0x5d2f(%rip),%rsi        # b7c8 <_IO_stdin_used+0x7c8>
    5a99:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5a9d:	e8 de b5 ff ff       	callq  1080 <__printf_chk@plt>
    5aa2:	48 8d 35 20 3a 00 00 	lea    0x3a20(%rip),%rsi        # 94c9 <nemesfpu512mix21>
    5aa9:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5aaf:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    5ab4:	48 c1 e7 09          	shl    $0x9,%rdi
    5ab8:	e8 83 4f 00 00       	callq  aa40 <measureFunction>
    5abd:	bf 01 00 00 00       	mov    $0x1,%edi
    5ac2:	b8 01 00 00 00       	mov    $0x1,%eax
    5ac7:	48 8d 35 22 5d 00 00 	lea    0x5d22(%rip),%rsi        # b7f0 <_IO_stdin_used+0x7f0>
    5ace:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5ad2:	e8 a9 b5 ff ff       	callq  1080 <__printf_chk@plt>
    5ad7:	48 8d 35 af 1f 00 00 	lea    0x1faf(%rip),%rsi        # 7a8d <add512int>
    5ade:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5ae4:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5ae9:	e8 52 4f 00 00       	callq  aa40 <measureFunction>
    5aee:	bf 01 00 00 00       	mov    $0x1,%edi
    5af3:	b8 01 00 00 00       	mov    $0x1,%eax
    5af8:	48 8d 35 21 5d 00 00 	lea    0x5d21(%rip),%rsi        # b820 <_IO_stdin_used+0x820>
    5aff:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5b03:	e8 78 b5 ff ff       	callq  1080 <__printf_chk@plt>
    5b08:	48 8d 35 a1 23 00 00 	lea    0x23a1(%rip),%rsi        # 7eb0 <latadd256int>
    5b0f:	4c 89 f7             	mov    %r14,%rdi
    5b12:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5b18:	e8 23 4f 00 00       	callq  aa40 <measureFunction>
    5b1d:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    5b23:	bf 01 00 00 00       	mov    $0x1,%edi
    5b28:	48 8d 35 11 5d 00 00 	lea    0x5d11(%rip),%rsi        # b840 <_IO_stdin_used+0x840>
    5b2f:	b8 01 00 00 00       	mov    $0x1,%eax
    5b34:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    5b38:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5b3c:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    5b40:	e8 3b b5 ff ff       	callq  1080 <__printf_chk@plt>
    5b45:	48 8d 35 c5 1d 00 00 	lea    0x1dc5(%rip),%rsi        # 7911 <mul512int>
    5b4c:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5b52:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5b57:	e8 e4 4e 00 00       	callq  aa40 <measureFunction>
    5b5c:	bf 01 00 00 00       	mov    $0x1,%edi
    5b61:	b8 01 00 00 00       	mov    $0x1,%eax
    5b66:	48 8d 35 fb 5c 00 00 	lea    0x5cfb(%rip),%rsi        # b868 <_IO_stdin_used+0x868>
    5b6d:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5b71:	e8 0a b5 ff ff       	callq  1080 <__printf_chk@plt>
    5b76:	48 8d 35 52 1e 00 00 	lea    0x1e52(%rip),%rsi        # 79cf <muldq512int>
    5b7d:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5b83:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5b88:	e8 b3 4e 00 00       	callq  aa40 <measureFunction>
    5b8d:	bf 01 00 00 00       	mov    $0x1,%edi
    5b92:	b8 01 00 00 00       	mov    $0x1,%eax
    5b97:	48 8d 35 f2 5c 00 00 	lea    0x5cf2(%rip),%rsi        # b890 <_IO_stdin_used+0x890>
    5b9e:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5ba2:	e8 d9 b4 ff ff       	callq  1080 <__printf_chk@plt>
    5ba7:	48 8d 35 1b 26 00 00 	lea    0x261b(%rip),%rsi        # 81c9 <latmulq512int>
    5bae:	4c 89 f7             	mov    %r14,%rdi
    5bb1:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5bb7:	e8 84 4e 00 00       	callq  aa40 <measureFunction>
    5bbc:	f3 0f 10 6c 24 0c    	movss  0xc(%rsp),%xmm5
    5bc2:	bf 01 00 00 00       	mov    $0x1,%edi
    5bc7:	48 8d 35 f2 5c 00 00 	lea    0x5cf2(%rip),%rsi        # b8c0 <_IO_stdin_used+0x8c0>
    5bce:	b8 01 00 00 00       	mov    $0x1,%eax
    5bd3:	f3 0f 5e e8          	divss  %xmm0,%xmm5
    5bd7:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5bdb:	f3 0f 5a c5          	cvtss2sd %xmm5,%xmm0
    5bdf:	e8 9c b4 ff ff       	callq  1080 <__printf_chk@plt>
    5be4:	48 8d 35 3a 24 00 00 	lea    0x243a(%rip),%rsi        # 8025 <latmul512int>
    5beb:	4c 89 f7             	mov    %r14,%rdi
    5bee:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5bf4:	e8 47 4e 00 00       	callq  aa40 <measureFunction>
    5bf9:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    5bff:	bf 01 00 00 00       	mov    $0x1,%edi
    5c04:	48 8d 35 e5 5c 00 00 	lea    0x5ce5(%rip),%rsi        # b8f0 <_IO_stdin_used+0x8f0>
    5c0b:	b8 01 00 00 00       	mov    $0x1,%eax
    5c10:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    5c14:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5c18:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    5c1c:	e8 5f b4 ff ff       	callq  1080 <__printf_chk@plt>
    5c21:	48 8d 35 cf 24 00 00 	lea    0x24cf(%rip),%rsi        # 80f7 <latmuldq512int>
    5c28:	4c 89 f7             	mov    %r14,%rdi
    5c2b:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5c31:	e8 0a 4e 00 00       	callq  aa40 <measureFunction>
    5c36:	f3 0f 10 7c 24 0c    	movss  0xc(%rsp),%xmm7
    5c3c:	bf 01 00 00 00       	mov    $0x1,%edi
    5c41:	48 8d 35 d8 5c 00 00 	lea    0x5cd8(%rip),%rsi        # b920 <_IO_stdin_used+0x920>
    5c48:	b8 01 00 00 00       	mov    $0x1,%eax
    5c4d:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    5c51:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5c55:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    5c59:	e8 22 b4 ff ff       	callq  1080 <__printf_chk@plt>
    5c5e:	48 8d 35 bd 33 00 00 	lea    0x33bd(%rip),%rsi        # 9022 <mixfmaadd512>
    5c65:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5c6b:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    5c70:	48 c1 e7 09          	shl    $0x9,%rdi
    5c74:	e8 c7 4d 00 00       	callq  aa40 <measureFunction>
    5c79:	bf 01 00 00 00       	mov    $0x1,%edi
    5c7e:	b8 01 00 00 00       	mov    $0x1,%eax
    5c83:	48 8d 35 ce 5c 00 00 	lea    0x5cce(%rip),%rsi        # b958 <_IO_stdin_used+0x958>
    5c8a:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5c8e:	e8 ed b3 ff ff       	callq  1080 <__printf_chk@plt>
    5c93:	48 8d 35 69 34 00 00 	lea    0x3469(%rip),%rsi        # 9103 <mixfma512add256>
    5c9a:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5ca0:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    5ca5:	48 c1 e7 09          	shl    $0x9,%rdi
    5ca9:	e8 92 4d 00 00       	callq  aa40 <measureFunction>
    5cae:	bf 01 00 00 00       	mov    $0x1,%edi
    5cb3:	b8 01 00 00 00       	mov    $0x1,%eax
    5cb8:	48 8d 35 c1 5c 00 00 	lea    0x5cc1(%rip),%rsi        # b980 <_IO_stdin_used+0x980>
    5cbf:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5cc3:	e8 b8 b3 ff ff       	callq  1080 <__printf_chk@plt>
    5cc8:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5cce:	48 8d 35 db 4c 00 00 	lea    0x4cdb(%rip),%rsi        # a9b0 <load512wrapper>
    5cd5:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5cda:	e8 61 4d 00 00       	callq  aa40 <measureFunction>
    5cdf:	bf 01 00 00 00       	mov    $0x1,%edi
    5ce4:	b8 01 00 00 00       	mov    $0x1,%eax
    5ce9:	48 8d 35 88 53 00 00 	lea    0x5388(%rip),%rsi        # b078 <_IO_stdin_used+0x78>
    5cf0:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5cf4:	e8 87 b3 ff ff       	callq  1080 <__printf_chk@plt>
    5cf9:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5cff:	48 8d 35 fa 4c 00 00 	lea    0x4cfa(%rip),%rsi        # aa00 <store512wrapper>
    5d06:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5d0b:	e8 30 4d 00 00       	callq  aa40 <measureFunction>
    5d10:	bf 01 00 00 00       	mov    $0x1,%edi
    5d15:	b8 01 00 00 00       	mov    $0x1,%eax
    5d1a:	48 8d 35 74 53 00 00 	lea    0x5374(%rip),%rsi        # b095 <_IO_stdin_used+0x95>
    5d21:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5d25:	e8 56 b3 ff ff       	callq  1080 <__printf_chk@plt>
    5d2a:	48 8d 35 ee 26 00 00 	lea    0x26ee(%rip),%rsi        # 841f <aesenc128>
    5d31:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5d37:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5d3c:	e8 ff 4c 00 00       	callq  aa40 <measureFunction>
    5d41:	bf 01 00 00 00       	mov    $0x1,%edi
    5d46:	b8 01 00 00 00       	mov    $0x1,%eax
    5d4b:	48 8d 35 61 53 00 00 	lea    0x5361(%rip),%rsi        # b0b3 <_IO_stdin_used+0xb3>
    5d52:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5d56:	e8 25 b3 ff ff       	callq  1080 <__printf_chk@plt>
    5d5b:	48 8d 35 21 2a 00 00 	lea    0x2a21(%rip),%rsi        # 8783 <aesdec128>
    5d62:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5d68:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5d6d:	e8 ce 4c 00 00       	callq  aa40 <measureFunction>
    5d72:	bf 01 00 00 00       	mov    $0x1,%edi
    5d77:	b8 01 00 00 00       	mov    $0x1,%eax
    5d7c:	48 8d 35 46 53 00 00 	lea    0x5346(%rip),%rsi        # b0c9 <_IO_stdin_used+0xc9>
    5d83:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5d87:	e8 f4 b2 ff ff       	callq  1080 <__printf_chk@plt>
    5d8c:	48 8d 35 26 27 00 00 	lea    0x2726(%rip),%rsi        # 84b9 <aesencadd128>
    5d93:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5d99:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5d9e:	e8 9d 4c 00 00       	callq  aa40 <measureFunction>
    5da3:	bf 01 00 00 00       	mov    $0x1,%edi
    5da8:	b8 01 00 00 00       	mov    $0x1,%eax
    5dad:	48 8d 35 fc 5b 00 00 	lea    0x5bfc(%rip),%rsi        # b9b0 <_IO_stdin_used+0x9b0>
    5db4:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5db8:	e8 c3 b2 ff ff       	callq  1080 <__printf_chk@plt>
    5dbd:	48 8d 35 af 27 00 00 	lea    0x27af(%rip),%rsi        # 8573 <aesencfma128>
    5dc4:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5dca:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5dcf:	e8 6c 4c 00 00       	callq  aa40 <measureFunction>
    5dd4:	bf 01 00 00 00       	mov    $0x1,%edi
    5dd9:	b8 01 00 00 00       	mov    $0x1,%eax
    5dde:	48 8d 35 fa 52 00 00 	lea    0x52fa(%rip),%rsi        # b0df <_IO_stdin_used+0xdf>
    5de5:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5de9:	e8 92 b2 ff ff       	callq  1080 <__printf_chk@plt>
    5dee:	48 8d 35 f8 28 00 00 	lea    0x28f8(%rip),%rsi        # 86ed <aesencmul128>
    5df5:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    5dfb:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5e00:	e8 3b 4c 00 00       	callq  aa40 <measureFunction>
    5e05:	bf 01 00 00 00       	mov    $0x1,%edi
    5e0a:	b8 01 00 00 00       	mov    $0x1,%eax
    5e0f:	48 8d 35 ba 5b 00 00 	lea    0x5bba(%rip),%rsi        # b9d0 <_IO_stdin_used+0x9d0>
    5e16:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5e1a:	e8 61 b2 ff ff       	callq  1080 <__printf_chk@plt>
    5e1f:	e9 31 da ff ff       	jmpq   3855 <main+0x2795>
    5e24:	ba 0c 00 00 00       	mov    $0xc,%edx
    5e29:	48 8d 35 88 53 00 00 	lea    0x5388(%rip),%rsi        # b1b8 <_IO_stdin_used+0x1b8>
    5e30:	4c 89 ef             	mov    %r13,%rdi
    5e33:	e8 f8 b1 ff ff       	callq  1030 <strncmp@plt>
    5e38:	85 c0                	test   %eax,%eax
    5e3a:	0f 85 2b cb ff ff    	jne    296b <main+0x18ab>
    5e40:	48 8d 35 a6 28 00 00 	lea    0x28a6(%rip),%rsi        # 86ed <aesencmul128>
    5e47:	f3 0f 10 05 39 62 00 	movss  0x6239(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    5e4e:	00 
    5e4f:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5e54:	e8 e7 4b 00 00       	callq  aa40 <measureFunction>
    5e59:	bf 01 00 00 00       	mov    $0x1,%edi
    5e5e:	b8 01 00 00 00       	mov    $0x1,%eax
    5e63:	48 8d 35 66 5b 00 00 	lea    0x5b66(%rip),%rsi        # b9d0 <_IO_stdin_used+0x9d0>
    5e6a:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5e6e:	e8 0d b2 ff ff       	callq  1080 <__printf_chk@plt>
    5e73:	41 83 fc 01          	cmp    $0x1,%r12d
    5e77:	0f 8f a4 d9 ff ff    	jg     3821 <main+0x2761>
    5e7d:	e9 c4 ca ff ff       	jmpq   2946 <main+0x1886>
    5e82:	ba 0c 00 00 00       	mov    $0xc,%edx
    5e87:	48 8d 35 1d 53 00 00 	lea    0x531d(%rip),%rsi        # b1ab <_IO_stdin_used+0x1ab>
    5e8e:	4c 89 ef             	mov    %r13,%rdi
    5e91:	e8 9a b1 ff ff       	callq  1030 <strncmp@plt>
    5e96:	85 c0                	test   %eax,%eax
    5e98:	75 8a                	jne    5e24 <main+0x4d64>
    5e9a:	48 8d 35 d2 26 00 00 	lea    0x26d2(%rip),%rsi        # 8573 <aesencfma128>
    5ea1:	f3 0f 10 05 df 61 00 	movss  0x61df(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    5ea8:	00 
    5ea9:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5eae:	e8 8d 4b 00 00       	callq  aa40 <measureFunction>
    5eb3:	bf 01 00 00 00       	mov    $0x1,%edi
    5eb8:	b8 01 00 00 00       	mov    $0x1,%eax
    5ebd:	48 8d 35 1b 52 00 00 	lea    0x521b(%rip),%rsi        # b0df <_IO_stdin_used+0xdf>
    5ec4:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5ec8:	e8 b3 b1 ff ff       	callq  1080 <__printf_chk@plt>
    5ecd:	41 83 fc 01          	cmp    $0x1,%r12d
    5ed1:	0f 8f f7 d8 ff ff    	jg     37ce <main+0x270e>
    5ed7:	e9 6a ca ff ff       	jmpq   2946 <main+0x1886>
    5edc:	ba 0c 00 00 00       	mov    $0xc,%edx
    5ee1:	48 8d 35 b6 52 00 00 	lea    0x52b6(%rip),%rsi        # b19e <_IO_stdin_used+0x19e>
    5ee8:	4c 89 ef             	mov    %r13,%rdi
    5eeb:	e8 40 b1 ff ff       	callq  1030 <strncmp@plt>
    5ef0:	85 c0                	test   %eax,%eax
    5ef2:	75 8e                	jne    5e82 <main+0x4dc2>
    5ef4:	48 8d 35 be 25 00 00 	lea    0x25be(%rip),%rsi        # 84b9 <aesencadd128>
    5efb:	f3 0f 10 05 85 61 00 	movss  0x6185(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    5f02:	00 
    5f03:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5f08:	e8 33 4b 00 00       	callq  aa40 <measureFunction>
    5f0d:	bf 01 00 00 00       	mov    $0x1,%edi
    5f12:	b8 01 00 00 00       	mov    $0x1,%eax
    5f17:	48 8d 35 92 5a 00 00 	lea    0x5a92(%rip),%rsi        # b9b0 <_IO_stdin_used+0x9b0>
    5f1e:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5f22:	e8 59 b1 ff ff       	callq  1080 <__printf_chk@plt>
    5f27:	41 83 fc 01          	cmp    $0x1,%r12d
    5f2b:	0f 8f 4a d8 ff ff    	jg     377b <main+0x26bb>
    5f31:	e9 10 ca ff ff       	jmpq   2946 <main+0x1886>
    5f36:	ba 09 00 00 00       	mov    $0x9,%edx
    5f3b:	48 8d 35 52 52 00 00 	lea    0x5252(%rip),%rsi        # b194 <_IO_stdin_used+0x194>
    5f42:	4c 89 ef             	mov    %r13,%rdi
    5f45:	e8 e6 b0 ff ff       	callq  1030 <strncmp@plt>
    5f4a:	85 c0                	test   %eax,%eax
    5f4c:	75 8e                	jne    5edc <main+0x4e1c>
    5f4e:	48 8d 35 2e 28 00 00 	lea    0x282e(%rip),%rsi        # 8783 <aesdec128>
    5f55:	f3 0f 10 05 2b 61 00 	movss  0x612b(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    5f5c:	00 
    5f5d:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5f62:	e8 d9 4a 00 00       	callq  aa40 <measureFunction>
    5f67:	bf 01 00 00 00       	mov    $0x1,%edi
    5f6c:	b8 01 00 00 00       	mov    $0x1,%eax
    5f71:	48 8d 35 51 51 00 00 	lea    0x5151(%rip),%rsi        # b0c9 <_IO_stdin_used+0xc9>
    5f78:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5f7c:	e8 ff b0 ff ff       	callq  1080 <__printf_chk@plt>
    5f81:	41 83 fc 01          	cmp    $0x1,%r12d
    5f85:	0f 8f 9d d7 ff ff    	jg     3728 <main+0x2668>
    5f8b:	e9 b6 c9 ff ff       	jmpq   2946 <main+0x1886>
    5f90:	ba 09 00 00 00       	mov    $0x9,%edx
    5f95:	48 8d 35 ee 51 00 00 	lea    0x51ee(%rip),%rsi        # b18a <_IO_stdin_used+0x18a>
    5f9c:	4c 89 ef             	mov    %r13,%rdi
    5f9f:	e8 8c b0 ff ff       	callq  1030 <strncmp@plt>
    5fa4:	85 c0                	test   %eax,%eax
    5fa6:	75 8e                	jne    5f36 <main+0x4e76>
    5fa8:	48 8d 35 70 24 00 00 	lea    0x2470(%rip),%rsi        # 841f <aesenc128>
    5faf:	f3 0f 10 05 d1 60 00 	movss  0x60d1(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    5fb6:	00 
    5fb7:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    5fbc:	e8 7f 4a 00 00       	callq  aa40 <measureFunction>
    5fc1:	bf 01 00 00 00       	mov    $0x1,%edi
    5fc6:	b8 01 00 00 00       	mov    $0x1,%eax
    5fcb:	48 8d 35 e1 50 00 00 	lea    0x50e1(%rip),%rsi        # b0b3 <_IO_stdin_used+0xb3>
    5fd2:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    5fd6:	e8 a5 b0 ff ff       	callq  1080 <__printf_chk@plt>
    5fdb:	41 83 fc 01          	cmp    $0x1,%r12d
    5fdf:	0f 8f f0 d6 ff ff    	jg     36d5 <main+0x2615>
    5fe5:	e9 5c c9 ff ff       	jmpq   2946 <main+0x1886>
    5fea:	ba 07 00 00 00       	mov    $0x7,%edx
    5fef:	48 8d 35 8b 51 00 00 	lea    0x518b(%rip),%rsi        # b181 <_IO_stdin_used+0x181>
    5ff6:	4c 89 ef             	mov    %r13,%rdi
    5ff9:	e8 32 b0 ff ff       	callq  1030 <strncmp@plt>
    5ffe:	85 c0                	test   %eax,%eax
    6000:	75 8e                	jne    5f90 <main+0x4ed0>
    6002:	f3 0f 10 05 7e 60 00 	movss  0x607e(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    6009:	00 
    600a:	48 8d 35 ef 49 00 00 	lea    0x49ef(%rip),%rsi        # aa00 <store512wrapper>
    6011:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    6016:	e8 25 4a 00 00       	callq  aa40 <measureFunction>
    601b:	bf 01 00 00 00       	mov    $0x1,%edi
    6020:	b8 01 00 00 00       	mov    $0x1,%eax
    6025:	48 8d 35 69 50 00 00 	lea    0x5069(%rip),%rsi        # b095 <_IO_stdin_used+0x95>
    602c:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    6030:	e8 4b b0 ff ff       	callq  1080 <__printf_chk@plt>
    6035:	41 83 fc 01          	cmp    $0x1,%r12d
    6039:	0f 8f 43 d6 ff ff    	jg     3682 <main+0x25c2>
    603f:	e9 02 c9 ff ff       	jmpq   2946 <main+0x1886>
    6044:	ba 07 00 00 00       	mov    $0x7,%edx
    6049:	48 8d 35 29 51 00 00 	lea    0x5129(%rip),%rsi        # b179 <_IO_stdin_used+0x179>
    6050:	4c 89 ef             	mov    %r13,%rdi
    6053:	e8 d8 af ff ff       	callq  1030 <strncmp@plt>
    6058:	85 c0                	test   %eax,%eax
    605a:	75 8e                	jne    5fea <main+0x4f2a>
    605c:	f3 0f 10 05 24 60 00 	movss  0x6024(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    6063:	00 
    6064:	48 8d 35 45 49 00 00 	lea    0x4945(%rip),%rsi        # a9b0 <load512wrapper>
    606b:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    6070:	e8 cb 49 00 00       	callq  aa40 <measureFunction>
    6075:	bf 01 00 00 00       	mov    $0x1,%edi
    607a:	b8 01 00 00 00       	mov    $0x1,%eax
    607f:	48 8d 35 f2 4f 00 00 	lea    0x4ff2(%rip),%rsi        # b078 <_IO_stdin_used+0x78>
    6086:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    608a:	e8 f1 af ff ff       	callq  1080 <__printf_chk@plt>
    608f:	41 83 fc 01          	cmp    $0x1,%r12d
    6093:	0f 8f 96 d5 ff ff    	jg     362f <main+0x256f>
    6099:	e9 a8 c8 ff ff       	jmpq   2946 <main+0x1886>
    609e:	ba 0b 00 00 00       	mov    $0xb,%edx
    60a3:	48 8d 35 bf 50 00 00 	lea    0x50bf(%rip),%rsi        # b169 <_IO_stdin_used+0x169>
    60aa:	4c 89 ef             	mov    %r13,%rdi
    60ad:	e8 7e af ff ff       	callq  1030 <strncmp@plt>
    60b2:	85 c0                	test   %eax,%eax
    60b4:	75 8e                	jne    6044 <main+0x4f84>
    60b6:	48 8d 35 46 30 00 00 	lea    0x3046(%rip),%rsi        # 9103 <mixfma512add256>
    60bd:	f3 0f 10 05 c3 5f 00 	movss  0x5fc3(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    60c4:	00 
    60c5:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    60ca:	48 c1 e7 09          	shl    $0x9,%rdi
    60ce:	e8 6d 49 00 00       	callq  aa40 <measureFunction>
    60d3:	bf 01 00 00 00       	mov    $0x1,%edi
    60d8:	b8 01 00 00 00       	mov    $0x1,%eax
    60dd:	48 8d 35 9c 58 00 00 	lea    0x589c(%rip),%rsi        # b980 <_IO_stdin_used+0x980>
    60e4:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    60e8:	e8 93 af ff ff       	callq  1080 <__printf_chk@plt>
    60ed:	41 83 fc 01          	cmp    $0x1,%r12d
    60f1:	0f 8f e5 d4 ff ff    	jg     35dc <main+0x251c>
    60f7:	e9 4a c8 ff ff       	jmpq   2946 <main+0x1886>
    60fc:	ba 0b 00 00 00       	mov    $0xb,%edx
    6101:	48 8d 35 54 50 00 00 	lea    0x5054(%rip),%rsi        # b15c <_IO_stdin_used+0x15c>
    6108:	4c 89 ef             	mov    %r13,%rdi
    610b:	e8 20 af ff ff       	callq  1030 <strncmp@plt>
    6110:	85 c0                	test   %eax,%eax
    6112:	75 8a                	jne    609e <main+0x4fde>
    6114:	48 8d 35 07 2f 00 00 	lea    0x2f07(%rip),%rsi        # 9022 <mixfmaadd512>
    611b:	f3 0f 10 05 65 5f 00 	movss  0x5f65(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    6122:	00 
    6123:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    6128:	48 c1 e7 09          	shl    $0x9,%rdi
    612c:	e8 0f 49 00 00       	callq  aa40 <measureFunction>
    6131:	bf 01 00 00 00       	mov    $0x1,%edi
    6136:	b8 01 00 00 00       	mov    $0x1,%eax
    613b:	48 8d 35 16 58 00 00 	lea    0x5816(%rip),%rsi        # b958 <_IO_stdin_used+0x958>
    6142:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    6146:	e8 35 af ff ff       	callq  1080 <__printf_chk@plt>
    614b:	41 83 fc 01          	cmp    $0x1,%r12d
    614f:	0f 8f 30 d4 ff ff    	jg     3585 <main+0x24c5>
    6155:	e9 ec c7 ff ff       	jmpq   2946 <main+0x1886>
    615a:	ba 0d 00 00 00       	mov    $0xd,%edx
    615f:	48 8d 35 e7 4f 00 00 	lea    0x4fe7(%rip),%rsi        # b14d <_IO_stdin_used+0x14d>
    6166:	4c 89 ef             	mov    %r13,%rdi
    6169:	e8 c2 ae ff ff       	callq  1030 <strncmp@plt>
    616e:	85 c0                	test   %eax,%eax
    6170:	75 8a                	jne    60fc <main+0x503c>
    6172:	48 8d 35 7e 1f 00 00 	lea    0x1f7e(%rip),%rsi        # 80f7 <latmuldq512int>
    6179:	f3 0f 10 05 07 5f 00 	movss  0x5f07(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    6180:	00 
    6181:	4c 89 f7             	mov    %r14,%rdi
    6184:	e8 b7 48 00 00       	callq  aa40 <measureFunction>
    6189:	bf 01 00 00 00       	mov    $0x1,%edi
    618e:	b8 01 00 00 00       	mov    $0x1,%eax
    6193:	f3 0f 10 0d ed 5e 00 	movss  0x5eed(%rip),%xmm1        # c088 <_IO_stdin_used+0x1088>
    619a:	00 
    619b:	48 8d 35 7e 57 00 00 	lea    0x577e(%rip),%rsi        # b920 <_IO_stdin_used+0x920>
    61a2:	f3 0f 5e c8          	divss  %xmm0,%xmm1
    61a6:	66 0f ef c0          	pxor   %xmm0,%xmm0
    61aa:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    61ae:	e8 cd ae ff ff       	callq  1080 <__printf_chk@plt>
    61b3:	41 83 fc 01          	cmp    $0x1,%r12d
    61b7:	0f 8f 71 d3 ff ff    	jg     352e <main+0x246e>
    61bd:	e9 84 c7 ff ff       	jmpq   2946 <main+0x1886>
    61c2:	ba 0c 00 00 00       	mov    $0xc,%edx
    61c7:	48 8d 35 72 4f 00 00 	lea    0x4f72(%rip),%rsi        # b140 <_IO_stdin_used+0x140>
    61ce:	4c 89 ef             	mov    %r13,%rdi
    61d1:	e8 5a ae ff ff       	callq  1030 <strncmp@plt>
    61d6:	85 c0                	test   %eax,%eax
    61d8:	75 80                	jne    615a <main+0x509a>
    61da:	48 8d 35 44 1e 00 00 	lea    0x1e44(%rip),%rsi        # 8025 <latmul512int>
    61e1:	f3 0f 10 05 9f 5e 00 	movss  0x5e9f(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    61e8:	00 
    61e9:	4c 89 f7             	mov    %r14,%rdi
    61ec:	e8 4f 48 00 00       	callq  aa40 <measureFunction>
    61f1:	bf 01 00 00 00       	mov    $0x1,%edi
    61f6:	b8 01 00 00 00       	mov    $0x1,%eax
    61fb:	f3 0f 10 3d 85 5e 00 	movss  0x5e85(%rip),%xmm7        # c088 <_IO_stdin_used+0x1088>
    6202:	00 
    6203:	48 8d 35 e6 56 00 00 	lea    0x56e6(%rip),%rsi        # b8f0 <_IO_stdin_used+0x8f0>
    620a:	f3 0f 11 7c 24 0c    	movss  %xmm7,0xc(%rsp)
    6210:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    6214:	66 0f ef c0          	pxor   %xmm0,%xmm0
    6218:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    621c:	e8 5f ae ff ff       	callq  1080 <__printf_chk@plt>
    6221:	41 83 fc 01          	cmp    $0x1,%r12d
    6225:	0f 8f a4 d2 ff ff    	jg     34cf <main+0x240f>
    622b:	e9 16 c7 ff ff       	jmpq   2946 <main+0x1886>
    6230:	ba 0d 00 00 00       	mov    $0xd,%edx
    6235:	48 8d 35 f6 4e 00 00 	lea    0x4ef6(%rip),%rsi        # b132 <_IO_stdin_used+0x132>
    623c:	4c 89 ef             	mov    %r13,%rdi
    623f:	e8 ec ad ff ff       	callq  1030 <strncmp@plt>
    6244:	85 c0                	test   %eax,%eax
    6246:	0f 85 76 ff ff ff    	jne    61c2 <main+0x5102>
    624c:	48 8d 35 76 1f 00 00 	lea    0x1f76(%rip),%rsi        # 81c9 <latmulq512int>
    6253:	f3 0f 10 05 2d 5e 00 	movss  0x5e2d(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    625a:	00 
    625b:	4c 89 f7             	mov    %r14,%rdi
    625e:	e8 dd 47 00 00       	callq  aa40 <measureFunction>
    6263:	bf 01 00 00 00       	mov    $0x1,%edi
    6268:	b8 01 00 00 00       	mov    $0x1,%eax
    626d:	f3 0f 10 3d 13 5e 00 	movss  0x5e13(%rip),%xmm7        # c088 <_IO_stdin_used+0x1088>
    6274:	00 
    6275:	48 8d 35 44 56 00 00 	lea    0x5644(%rip),%rsi        # b8c0 <_IO_stdin_used+0x8c0>
    627c:	f3 0f 11 7c 24 0c    	movss  %xmm7,0xc(%rsp)
    6282:	f3 0f 5e f8          	divss  %xmm0,%xmm7
    6286:	66 0f ef c0          	pxor   %xmm0,%xmm0
    628a:	f3 0f 5a c7          	cvtss2sd %xmm7,%xmm0
    628e:	e8 ed ad ff ff       	callq  1080 <__printf_chk@plt>
    6293:	41 83 fc 01          	cmp    $0x1,%r12d
    6297:	0f 8f d3 d1 ff ff    	jg     3470 <main+0x23b0>
    629d:	e9 a4 c6 ff ff       	jmpq   2946 <main+0x1886>
    62a2:	ba 09 00 00 00       	mov    $0x9,%edx
    62a7:	48 8d 35 a2 4e 00 00 	lea    0x4ea2(%rip),%rsi        # b150 <_IO_stdin_used+0x150>
    62ae:	4c 89 ef             	mov    %r13,%rdi
    62b1:	e8 7a ad ff ff       	callq  1030 <strncmp@plt>
    62b6:	85 c0                	test   %eax,%eax
    62b8:	0f 85 72 ff ff ff    	jne    6230 <main+0x5170>
    62be:	48 8d 35 0a 17 00 00 	lea    0x170a(%rip),%rsi        # 79cf <muldq512int>
    62c5:	f3 0f 10 05 bb 5d 00 	movss  0x5dbb(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    62cc:	00 
    62cd:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    62d2:	e8 69 47 00 00       	callq  aa40 <measureFunction>
    62d7:	bf 01 00 00 00       	mov    $0x1,%edi
    62dc:	b8 01 00 00 00       	mov    $0x1,%eax
    62e1:	48 8d 35 a8 55 00 00 	lea    0x55a8(%rip),%rsi        # b890 <_IO_stdin_used+0x890>
    62e8:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    62ec:	e8 8f ad ff ff       	callq  1080 <__printf_chk@plt>
    62f1:	41 83 fc 01          	cmp    $0x1,%r12d
    62f5:	0f 8f 0e d1 ff ff    	jg     3409 <main+0x2349>
    62fb:	e9 46 c6 ff ff       	jmpq   2946 <main+0x1886>
    6300:	ba 09 00 00 00       	mov    $0x9,%edx
    6305:	48 8d 35 37 4e 00 00 	lea    0x4e37(%rip),%rsi        # b143 <_IO_stdin_used+0x143>
    630c:	4c 89 ef             	mov    %r13,%rdi
    630f:	e8 1c ad ff ff       	callq  1030 <strncmp@plt>
    6314:	85 c0                	test   %eax,%eax
    6316:	75 8a                	jne    62a2 <main+0x51e2>
    6318:	48 8d 35 f2 15 00 00 	lea    0x15f2(%rip),%rsi        # 7911 <mul512int>
    631f:	f3 0f 10 05 61 5d 00 	movss  0x5d61(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    6326:	00 
    6327:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    632c:	e8 0f 47 00 00       	callq  aa40 <measureFunction>
    6331:	bf 01 00 00 00       	mov    $0x1,%edi
    6336:	b8 01 00 00 00       	mov    $0x1,%eax
    633b:	48 8d 35 26 55 00 00 	lea    0x5526(%rip),%rsi        # b868 <_IO_stdin_used+0x868>
    6342:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    6346:	e8 35 ad ff ff       	callq  1080 <__printf_chk@plt>
    634b:	41 83 fc 01          	cmp    $0x1,%r12d
    634f:	0f 8f 61 d0 ff ff    	jg     33b6 <main+0x22f6>
    6355:	e9 ec c5 ff ff       	jmpq   2946 <main+0x1886>
    635a:	ba 0c 00 00 00       	mov    $0xc,%edx
    635f:	48 8d 35 bf 4d 00 00 	lea    0x4dbf(%rip),%rsi        # b125 <_IO_stdin_used+0x125>
    6366:	4c 89 ef             	mov    %r13,%rdi
    6369:	e8 c2 ac ff ff       	callq  1030 <strncmp@plt>
    636e:	85 c0                	test   %eax,%eax
    6370:	75 8e                	jne    6300 <main+0x5240>
    6372:	48 8d 35 37 1b 00 00 	lea    0x1b37(%rip),%rsi        # 7eb0 <latadd256int>
    6379:	f3 0f 10 05 07 5d 00 	movss  0x5d07(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    6380:	00 
    6381:	4c 89 f7             	mov    %r14,%rdi
    6384:	e8 b7 46 00 00       	callq  aa40 <measureFunction>
    6389:	bf 01 00 00 00       	mov    $0x1,%edi
    638e:	b8 01 00 00 00       	mov    $0x1,%eax
    6393:	f3 0f 10 0d ed 5c 00 	movss  0x5ced(%rip),%xmm1        # c088 <_IO_stdin_used+0x1088>
    639a:	00 
    639b:	48 8d 35 9e 54 00 00 	lea    0x549e(%rip),%rsi        # b840 <_IO_stdin_used+0x840>
    63a2:	f3 0f 5e c8          	divss  %xmm0,%xmm1
    63a6:	66 0f ef c0          	pxor   %xmm0,%xmm0
    63aa:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    63ae:	e8 cd ac ff ff       	callq  1080 <__printf_chk@plt>
    63b3:	41 83 fc 01          	cmp    $0x1,%r12d
    63b7:	0f 8f a6 cf ff ff    	jg     3363 <main+0x22a3>
    63bd:	e9 84 c5 ff ff       	jmpq   2946 <main+0x1886>
    63c2:	ba 09 00 00 00       	mov    $0x9,%edx
    63c7:	48 8d 35 5a 4d 00 00 	lea    0x4d5a(%rip),%rsi        # b128 <_IO_stdin_used+0x128>
    63ce:	4c 89 ef             	mov    %r13,%rdi
    63d1:	e8 5a ac ff ff       	callq  1030 <strncmp@plt>
    63d6:	85 c0                	test   %eax,%eax
    63d8:	75 80                	jne    635a <main+0x529a>
    63da:	48 8d 35 ac 16 00 00 	lea    0x16ac(%rip),%rsi        # 7a8d <add512int>
    63e1:	f3 0f 10 05 9f 5c 00 	movss  0x5c9f(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    63e8:	00 
    63e9:	bf 00 2f 68 59       	mov    $0x59682f00,%edi
    63ee:	e8 4d 46 00 00       	callq  aa40 <measureFunction>
    63f3:	bf 01 00 00 00       	mov    $0x1,%edi
    63f8:	b8 01 00 00 00       	mov    $0x1,%eax
    63fd:	48 8d 35 1c 54 00 00 	lea    0x541c(%rip),%rsi        # b820 <_IO_stdin_used+0x820>
    6404:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    6408:	e8 73 ac ff ff       	callq  1080 <__printf_chk@plt>
    640d:	41 83 fc 01          	cmp    $0x1,%r12d
    6411:	0f 8f eb ce ff ff    	jg     3302 <main+0x2242>
    6417:	e9 2a c5 ff ff       	jmpq   2946 <main+0x1886>
    641c:	ba 0d 00 00 00       	mov    $0xd,%edx
    6421:	48 8d 35 ef 4c 00 00 	lea    0x4cef(%rip),%rsi        # b117 <_IO_stdin_used+0x117>
    6428:	4c 89 ef             	mov    %r13,%rdi
    642b:	e8 00 ac ff ff       	callq  1030 <strncmp@plt>
    6430:	85 c0                	test   %eax,%eax
    6432:	75 8e                	jne    63c2 <main+0x5302>
    6434:	48 8d 35 8e 30 00 00 	lea    0x308e(%rip),%rsi        # 94c9 <nemesfpu512mix21>
    643b:	f3 0f 10 05 45 5c 00 	movss  0x5c45(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    6442:	00 
    6443:	bf 05 7a d7 03       	mov    $0x3d77a05,%edi
    6448:	48 c1 e7 09          	shl    $0x9,%rdi
    644c:	e8 ef 45 00 00       	callq  aa40 <measureFunction>
    6451:	bf 01 00 00 00       	mov    $0x1,%edi
    6456:	b8 01 00 00 00       	mov    $0x1,%eax
    645b:	48 8d 35 8e 53 00 00 	lea    0x538e(%rip),%rsi        # b7f0 <_IO_stdin_used+0x7f0>
    6462:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    6466:	e8 15 ac ff ff       	callq  1080 <__printf_chk@plt>
    646b:	41 83 fc 01          	cmp    $0x1,%r12d
    646f:	0f 8f 3a ce ff ff    	jg     32af <main+0x21ef>
    6475:	e9 cc c4 ff ff       	jmpq   2946 <main+0x1886>
    647a:	4c 89 f0             	mov    %r14,%rax
    647d:	66 0f ef c9          	pxor   %xmm1,%xmm1
    6481:	48 d1 e8             	shr    %rax
    6484:	f3 48 0f 2a c8       	cvtsi2ss %rax,%xmm1
    6489:	f3 0f 58 c9          	addss  %xmm1,%xmm1
    648d:	e9 24 f5 ff ff       	jmpq   59b6 <main+0x48f6>
    6492:	48 89 c8             	mov    %rcx,%rax
    6495:	83 e1 01             	and    $0x1,%ecx
    6498:	66 0f ef c0          	pxor   %xmm0,%xmm0
    649c:	48 d1 e8             	shr    %rax
    649f:	48 09 c8             	or     %rcx,%rax
    64a2:	f3 48 0f 2a c0       	cvtsi2ss %rax,%xmm0
    64a7:	f3 0f 58 c0          	addss  %xmm0,%xmm0
    64ab:	e9 e8 f4 ff ff       	jmpq   5998 <main+0x48d8>
    64b0:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    64b6:	e9 80 f4 ff ff       	jmpq   593b <main+0x487b>
    64bb:	48 8d 35 b6 08 00 00 	lea    0x8b6(%rip),%rsi        # 6d78 <noptest1b>
    64c2:	f3 0f 10 05 be 5b 00 	movss  0x5bbe(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    64c9:	00 
    64ca:	4c 89 f7             	mov    %r14,%rdi
    64cd:	e8 6e 45 00 00       	callq  aa40 <measureFunction>
    64d2:	bf 01 00 00 00       	mov    $0x1,%edi
    64d7:	b8 01 00 00 00       	mov    $0x1,%eax
    64dc:	48 8d 35 69 52 00 00 	lea    0x5269(%rip),%rsi        # b74c <_IO_stdin_used+0x74c>
    64e3:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    64e7:	e8 94 ab ff ff       	callq  1080 <__printf_chk@plt>
    64ec:	41 83 fc 01          	cmp    $0x1,%r12d
    64f0:	0f 8e 50 c4 ff ff    	jle    2946 <main+0x1886>
    64f6:	f3 0f 10 3d 8a 5b 00 	movss  0x5b8a(%rip),%xmm7        # c088 <_IO_stdin_used+0x1088>
    64fd:	00 
    64fe:	f3 0f 11 7c 24 0c    	movss  %xmm7,0xc(%rsp)
    6504:	f3 0f 11 7c 24 08    	movss  %xmm7,0x8(%rsp)
    650a:	e9 18 ad ff ff       	jmpq   1227 <main+0x167>
    650f:	f3 0f 10 2d 71 5b 00 	movss  0x5b71(%rip),%xmm5        # c088 <_IO_stdin_used+0x1088>
    6516:	00 
    6517:	f3 0f 11 6c 24 0c    	movss  %xmm5,0xc(%rsp)
    651d:	f3 0f 11 6c 24 08    	movss  %xmm5,0x8(%rsp)
    6523:	e9 b4 ac ff ff       	jmpq   11dc <main+0x11c>
    6528:	e8 13 ab ff ff       	callq  1040 <__stack_chk_fail@plt>
    652d:	0f 1f 00             	nopl   (%rax)

0000000000006530 <get_available_features>:
    6530:	53                   	push   %rbx
    6531:	41 89 d1             	mov    %edx,%r9d
    6534:	f7 c7 00 00 00 08    	test   $0x8000000,%edi
    653a:	74 13                	je     654f <get_available_features+0x1f>
    653c:	31 c9                	xor    %ecx,%ecx
    653e:	0f 01 d0             	xgetbv 
    6541:	89 c2                	mov    %eax,%edx
    6543:	83 e2 06             	and    $0x6,%edx
    6546:	83 fa 06             	cmp    $0x6,%edx
    6549:	0f 84 4a 02 00 00    	je     6799 <get_available_features+0x269>
    654f:	45 31 db             	xor    %r11d,%r11d
    6552:	45 31 d2             	xor    %r10d,%r10d
    6555:	41 89 f0             	mov    %esi,%r8d
    6558:	41 c1 e8 0f          	shr    $0xf,%r8d
    655c:	41 83 e0 01          	and    $0x1,%r8d
    6560:	44 89 c0             	mov    %r8d,%eax
    6563:	83 c8 02             	or     $0x2,%eax
    6566:	f7 c6 00 00 80 00    	test   $0x800000,%esi
    656c:	44 0f 45 c0          	cmovne %eax,%r8d
    6570:	44 89 c0             	mov    %r8d,%eax
    6573:	83 c8 08             	or     $0x8,%eax
    6576:	f7 c6 00 00 00 02    	test   $0x2000000,%esi
    657c:	44 0f 45 c0          	cmovne %eax,%r8d
    6580:	44 89 c0             	mov    %r8d,%eax
    6583:	83 c8 10             	or     $0x10,%eax
    6586:	81 e6 00 00 00 04    	and    $0x4000000,%esi
    658c:	44 0f 45 c0          	cmovne %eax,%r8d
    6590:	44 89 c0             	mov    %r8d,%eax
    6593:	83 c8 04             	or     $0x4,%eax
    6596:	f7 c7 00 00 80 00    	test   $0x800000,%edi
    659c:	44 0f 45 c0          	cmovne %eax,%r8d
    65a0:	44 89 c0             	mov    %r8d,%eax
    65a3:	0d 00 00 04 00       	or     $0x40000,%eax
    65a8:	f7 c7 00 00 00 02    	test   $0x2000000,%edi
    65ae:	44 0f 45 c0          	cmovne %eax,%r8d
    65b2:	44 89 c0             	mov    %r8d,%eax
    65b5:	0d 00 00 08 00       	or     $0x80000,%eax
    65ba:	40 f6 c7 02          	test   $0x2,%dil
    65be:	44 0f 45 c0          	cmovne %eax,%r8d
    65c2:	44 89 c0             	mov    %r8d,%eax
    65c5:	83 c8 20             	or     $0x20,%eax
    65c8:	40 f6 c7 01          	test   $0x1,%dil
    65cc:	44 0f 45 c0          	cmovne %eax,%r8d
    65d0:	44 89 c0             	mov    %r8d,%eax
    65d3:	83 c8 40             	or     $0x40,%eax
    65d6:	f7 c7 00 02 00 00    	test   $0x200,%edi
    65dc:	44 0f 45 c0          	cmovne %eax,%r8d
    65e0:	44 89 c0             	mov    %r8d,%eax
    65e3:	0c 80                	or     $0x80,%al
    65e5:	f7 c7 00 00 08 00    	test   $0x80000,%edi
    65eb:	44 0f 45 c0          	cmovne %eax,%r8d
    65ef:	44 89 c0             	mov    %r8d,%eax
    65f2:	80 cc 01             	or     $0x1,%ah
    65f5:	f7 c7 00 00 10 00    	test   $0x100000,%edi
    65fb:	44 0f 45 c0          	cmovne %eax,%r8d
    65ff:	45 85 d2             	test   %r10d,%r10d
    6602:	74 1b                	je     661f <get_available_features+0xef>
    6604:	f7 c7 00 00 00 10    	test   $0x10000000,%edi
    660a:	74 07                	je     6613 <get_available_features+0xe3>
    660c:	41 81 c8 00 02 00 00 	or     $0x200,%r8d
    6613:	81 e7 00 10 00 00    	and    $0x1000,%edi
    6619:	0f 85 6e 01 00 00    	jne    678d <get_available_features+0x25d>
    661f:	31 f6                	xor    %esi,%esi
    6621:	41 83 f9 06          	cmp    $0x6,%r9d
    6625:	7e 50                	jle    6677 <get_available_features+0x147>
    6627:	b8 07 00 00 00       	mov    $0x7,%eax
    662c:	89 f1                	mov    %esi,%ecx
    662e:	0f a2                	cpuid  
    6630:	f6 c3 08             	test   $0x8,%bl
    6633:	74 07                	je     663c <get_available_features+0x10c>
    6635:	41 81 c8 00 00 01 00 	or     $0x10000,%r8d
    663c:	31 f6                	xor    %esi,%esi
    663e:	45 85 d2             	test   %r10d,%r10d
    6641:	74 1b                	je     665e <get_available_features+0x12e>
    6643:	f6 c3 20             	test   $0x20,%bl
    6646:	74 07                	je     664f <get_available_features+0x11f>
    6648:	41 81 c8 00 04 00 00 	or     $0x400,%r8d
    664f:	89 ce                	mov    %ecx,%esi
    6651:	81 e6 00 04 00 00    	and    $0x400,%esi
    6657:	74 05                	je     665e <get_available_features+0x12e>
    6659:	be 02 00 00 00       	mov    $0x2,%esi
    665e:	f6 c7 01             	test   $0x1,%bh
    6661:	74 07                	je     666a <get_available_features+0x13a>
    6663:	41 81 c8 00 00 02 00 	or     $0x20000,%r8d
    666a:	f6 c5 01             	test   $0x1,%ch
    666d:	74 03                	je     6672 <get_available_features+0x142>
    666f:	83 ce 01             	or     $0x1,%esi
    6672:	45 85 db             	test   %r11d,%r11d
    6675:	75 50                	jne    66c7 <get_available_features+0x197>
    6677:	b8 00 00 00 80       	mov    $0x80000000,%eax
    667c:	0f a2                	cpuid  
    667e:	3d 00 00 00 80       	cmp    $0x80000000,%eax
    6683:	76 33                	jbe    66b8 <get_available_features+0x188>
    6685:	b8 01 00 00 80       	mov    $0x80000001,%eax
    668a:	0f a2                	cpuid  
    668c:	f6 c1 40             	test   $0x40,%cl
    668f:	74 07                	je     6698 <get_available_features+0x168>
    6691:	41 81 c8 00 08 00 00 	or     $0x800,%r8d
    6698:	45 85 d2             	test   %r10d,%r10d
    669b:	74 1b                	je     66b8 <get_available_features+0x188>
    669d:	f7 c1 00 00 01 00    	test   $0x10000,%ecx
    66a3:	74 07                	je     66ac <get_available_features+0x17c>
    66a5:	41 81 c8 00 10 00 00 	or     $0x1000,%r8d
    66ac:	80 e5 08             	and    $0x8,%ch
    66af:	74 07                	je     66b8 <get_available_features+0x188>
    66b1:	41 81 c8 00 20 00 00 	or     $0x2000,%r8d
    66b8:	44 89 05 3d 7a 00 00 	mov    %r8d,0x7a3d(%rip)        # e0fc <__cpu_model+0xc>
    66bf:	5b                   	pop    %rbx
    66c0:	89 35 42 7a 00 00    	mov    %esi,0x7a42(%rip)        # e108 <__cpu_features2>
    66c6:	c3                   	retq   
    66c7:	f7 c3 00 00 01 00    	test   $0x10000,%ebx
    66cd:	74 07                	je     66d6 <get_available_features+0x1a6>
    66cf:	41 81 c8 00 80 00 00 	or     $0x8000,%r8d
    66d6:	85 db                	test   %ebx,%ebx
    66d8:	0f 88 d7 00 00 00    	js     67b5 <get_available_features+0x285>
    66de:	f7 c3 00 00 00 40    	test   $0x40000000,%ebx
    66e4:	74 07                	je     66ed <get_available_features+0x1bd>
    66e6:	41 81 c8 00 00 20 00 	or     $0x200000,%r8d
    66ed:	f7 c3 00 00 02 00    	test   $0x20000,%ebx
    66f3:	74 07                	je     66fc <get_available_features+0x1cc>
    66f5:	41 81 c8 00 00 40 00 	or     $0x400000,%r8d
    66fc:	f7 c3 00 00 00 10    	test   $0x10000000,%ebx
    6702:	74 07                	je     670b <get_available_features+0x1db>
    6704:	41 81 c8 00 00 80 00 	or     $0x800000,%r8d
    670b:	f7 c3 00 00 00 04    	test   $0x4000000,%ebx
    6711:	74 07                	je     671a <get_available_features+0x1ea>
    6713:	41 81 c8 00 00 00 02 	or     $0x2000000,%r8d
    671a:	f7 c3 00 00 00 08    	test   $0x8000000,%ebx
    6720:	74 07                	je     6729 <get_available_features+0x1f9>
    6722:	41 81 c8 00 00 00 01 	or     $0x1000000,%r8d
    6729:	81 e3 00 00 20 00    	and    $0x200000,%ebx
    672f:	74 07                	je     6738 <get_available_features+0x208>
    6731:	41 81 c8 00 00 00 08 	or     $0x8000000,%r8d
    6738:	f6 c1 02             	test   $0x2,%cl
    673b:	74 07                	je     6744 <get_available_features+0x214>
    673d:	41 81 c8 00 00 00 04 	or     $0x4000000,%r8d
    6744:	f6 c1 40             	test   $0x40,%cl
    6747:	74 07                	je     6750 <get_available_features+0x220>
    6749:	41 81 c8 00 00 00 80 	or     $0x80000000,%r8d
    6750:	f6 c5 08             	test   $0x8,%ch
    6753:	74 03                	je     6758 <get_available_features+0x228>
    6755:	83 ce 04             	or     $0x4,%esi
    6758:	f6 c5 10             	test   $0x10,%ch
    675b:	74 03                	je     6760 <get_available_features+0x230>
    675d:	83 ce 08             	or     $0x8,%esi
    6760:	80 e5 40             	and    $0x40,%ch
    6763:	74 07                	je     676c <get_available_features+0x23c>
    6765:	41 81 c8 00 00 00 40 	or     $0x40000000,%r8d
    676c:	f6 c2 04             	test   $0x4,%dl
    676f:	74 07                	je     6778 <get_available_features+0x248>
    6771:	41 81 c8 00 00 00 10 	or     $0x10000000,%r8d
    6778:	80 e2 08             	and    $0x8,%dl
    677b:	0f 84 f6 fe ff ff    	je     6677 <get_available_features+0x147>
    6781:	41 81 c8 00 00 00 20 	or     $0x20000000,%r8d
    6788:	e9 ea fe ff ff       	jmpq   6677 <get_available_features+0x147>
    678d:	41 81 c8 00 40 00 00 	or     $0x4000,%r8d
    6794:	e9 86 fe ff ff       	jmpq   661f <get_available_features+0xef>
    6799:	25 e6 00 00 00       	and    $0xe6,%eax
    679e:	45 31 db             	xor    %r11d,%r11d
    67a1:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    67a7:	3d e6 00 00 00       	cmp    $0xe6,%eax
    67ac:	41 0f 94 c3          	sete   %r11b
    67b0:	e9 a0 fd ff ff       	jmpq   6555 <get_available_features+0x25>
    67b5:	41 81 c8 00 00 10 00 	or     $0x100000,%r8d
    67bc:	e9 1d ff ff ff       	jmpq   66de <get_available_features+0x1ae>
    67c1:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
    67c8:	00 00 00 00 
    67cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000067d0 <__cpu_indicator_init>:
    67d0:	f3 0f 1e fa          	endbr64 
    67d4:	8b 05 16 79 00 00    	mov    0x7916(%rip),%eax        # e0f0 <__cpu_model>
    67da:	45 31 c9             	xor    %r9d,%r9d
    67dd:	85 c0                	test   %eax,%eax
    67df:	75 78                	jne    6859 <__cpu_indicator_init+0x89>
    67e1:	53                   	push   %rbx
    67e2:	44 89 c8             	mov    %r9d,%eax
    67e5:	0f a2                	cpuid  
    67e7:	85 c0                	test   %eax,%eax
    67e9:	0f 84 cc 00 00 00    	je     68bb <__cpu_indicator_init+0xeb>
    67ef:	44 89 c8             	mov    %r9d,%eax
    67f2:	0f a2                	cpuid  
    67f4:	41 89 da             	mov    %ebx,%r10d
    67f7:	41 89 c0             	mov    %eax,%r8d
    67fa:	85 c0                	test   %eax,%eax
    67fc:	0f 8e b9 00 00 00    	jle    68bb <__cpu_indicator_init+0xeb>
    6802:	44 89 c8             	mov    %r9d,%eax
    6805:	0f a2                	cpuid  
    6807:	85 c0                	test   %eax,%eax
    6809:	0f 84 ac 00 00 00    	je     68bb <__cpu_indicator_init+0xeb>
    680f:	b8 01 00 00 00       	mov    $0x1,%eax
    6814:	0f a2                	cpuid  
    6816:	89 d6                	mov    %edx,%esi
    6818:	89 cf                	mov    %ecx,%edi
    681a:	89 c2                	mov    %eax,%edx
    681c:	89 c1                	mov    %eax,%ecx
    681e:	c1 ea 04             	shr    $0x4,%edx
    6821:	41 89 c3             	mov    %eax,%r11d
    6824:	c1 e9 08             	shr    $0x8,%ecx
    6827:	41 c1 eb 0c          	shr    $0xc,%r11d
    682b:	83 e2 0f             	and    $0xf,%edx
    682e:	83 e1 0f             	and    $0xf,%ecx
    6831:	41 81 e3 f0 00 00 00 	and    $0xf0,%r11d
    6838:	41 81 fa 47 65 6e 75 	cmp    $0x756e6547,%r10d
    683f:	74 1c                	je     685d <__cpu_indicator_init+0x8d>
    6841:	41 81 fa 41 75 74 68 	cmp    $0x68747541,%r10d
    6848:	74 33                	je     687d <__cpu_indicator_init+0xad>
    684a:	c7 05 9c 78 00 00 03 	movl   $0x3,0x789c(%rip)        # e0f0 <__cpu_model>
    6851:	00 00 00 
    6854:	44 89 c8             	mov    %r9d,%eax
    6857:	5b                   	pop    %rbx
    6858:	c3                   	retq   
    6859:	44 89 c8             	mov    %r9d,%eax
    685c:	c3                   	retq   
    685d:	83 f9 06             	cmp    $0x6,%ecx
    6860:	0f 84 fe 00 00 00    	je     6964 <__cpu_indicator_init+0x194>
    6866:	44 89 c2             	mov    %r8d,%edx
    6869:	e8 c2 fc ff ff       	callq  6530 <get_available_features>
    686e:	45 31 c9             	xor    %r9d,%r9d
    6871:	c7 05 75 78 00 00 01 	movl   $0x1,0x7875(%rip)        # e0f0 <__cpu_model>
    6878:	00 00 00 
    687b:	eb d7                	jmp    6854 <__cpu_indicator_init+0x84>
    687d:	83 f9 0f             	cmp    $0xf,%ecx
    6880:	74 17                	je     6899 <__cpu_indicator_init+0xc9>
    6882:	44 89 c2             	mov    %r8d,%edx
    6885:	e8 a6 fc ff ff       	callq  6530 <get_available_features>
    688a:	45 31 c9             	xor    %r9d,%r9d
    688d:	c7 05 59 78 00 00 02 	movl   $0x2,0x7859(%rip)        # e0f0 <__cpu_model>
    6894:	00 00 00 
    6897:	eb bb                	jmp    6854 <__cpu_indicator_init+0x84>
    6899:	c1 e8 14             	shr    $0x14,%eax
    689c:	44 09 da             	or     %r11d,%edx
    689f:	0f b6 c0             	movzbl %al,%eax
    68a2:	83 e8 01             	sub    $0x1,%eax
    68a5:	83 f8 07             	cmp    $0x7,%eax
    68a8:	77 d8                	ja     6882 <__cpu_indicator_init+0xb2>
    68aa:	48 8d 0d 0f 58 00 00 	lea    0x580f(%rip),%rcx        # c0c0 <_IO_stdin_used+0x10c0>
    68b1:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    68b5:	48 01 c8             	add    %rcx,%rax
    68b8:	3e ff e0             	notrack jmpq *%rax
    68bb:	c7 05 2b 78 00 00 03 	movl   $0x3,0x782b(%rip)        # e0f0 <__cpu_model>
    68c2:	00 00 00 
    68c5:	41 83 c9 ff          	or     $0xffffffff,%r9d
    68c9:	eb 89                	jmp    6854 <__cpu_indicator_init+0x84>
    68cb:	c7 05 1f 78 00 00 0a 	movl   $0xa,0x781f(%rip)        # e0f4 <__cpu_model+0x4>
    68d2:	00 00 00 
    68d5:	83 fa 1f             	cmp    $0x1f,%edx
    68d8:	0f 87 05 02 00 00    	ja     6ae3 <__cpu_indicator_init+0x313>
    68de:	c7 05 10 78 00 00 0b 	movl   $0xb,0x7810(%rip)        # e0f8 <__cpu_model+0x8>
    68e5:	00 00 00 
    68e8:	eb 98                	jmp    6882 <__cpu_indicator_init+0xb2>
    68ea:	c7 05 00 78 00 00 09 	movl   $0x9,0x7800(%rip)        # e0f4 <__cpu_model+0x4>
    68f1:	00 00 00 
    68f4:	eb 8c                	jmp    6882 <__cpu_indicator_init+0xb2>
    68f6:	c7 05 f4 77 00 00 05 	movl   $0x5,0x77f4(%rip)        # e0f4 <__cpu_model+0x4>
    68fd:	00 00 00 
    6900:	83 fa 02             	cmp    $0x2,%edx
    6903:	0f 84 cb 01 00 00    	je     6ad4 <__cpu_indicator_init+0x304>
    6909:	83 fa 0f             	cmp    $0xf,%edx
    690c:	0f 87 e9 01 00 00    	ja     6afb <__cpu_indicator_init+0x32b>
    6912:	c7 05 dc 77 00 00 07 	movl   $0x7,0x77dc(%rip)        # e0f8 <__cpu_model+0x8>
    6919:	00 00 00 
    691c:	e9 61 ff ff ff       	jmpq   6882 <__cpu_indicator_init+0xb2>
    6921:	c7 05 c9 77 00 00 08 	movl   $0x8,0x77c9(%rip)        # e0f4 <__cpu_model+0x4>
    6928:	00 00 00 
    692b:	e9 52 ff ff ff       	jmpq   6882 <__cpu_indicator_init+0xb2>
    6930:	c7 05 ba 77 00 00 04 	movl   $0x4,0x77ba(%rip)        # e0f4 <__cpu_model+0x4>
    6937:	00 00 00 
    693a:	83 fa 04             	cmp    $0x4,%edx
    693d:	0f 84 e0 01 00 00    	je     6b23 <__cpu_indicator_init+0x353>
    6943:	83 fa 08             	cmp    $0x8,%edx
    6946:	0f 84 c8 01 00 00    	je     6b14 <__cpu_indicator_init+0x344>
    694c:	83 fa 02             	cmp    $0x2,%edx
    694f:	0f 85 2d ff ff ff    	jne    6882 <__cpu_indicator_init+0xb2>
    6955:	c7 05 99 77 00 00 04 	movl   $0x4,0x7799(%rip)        # e0f8 <__cpu_model+0x8>
    695c:	00 00 00 
    695f:	e9 1e ff ff ff       	jmpq   6882 <__cpu_indicator_init+0xb2>
    6964:	89 d0                	mov    %edx,%eax
    6966:	44 09 d8             	or     %r11d,%eax
    6969:	84 db                	test   %bl,%bl
    696b:	0f 85 f5 fe ff ff    	jne    6866 <__cpu_indicator_init+0x96>
    6971:	83 e8 0f             	sub    $0xf,%eax
    6974:	3d 8f 00 00 00       	cmp    $0x8f,%eax
    6979:	0f 87 e7 fe ff ff    	ja     6866 <__cpu_indicator_init+0x96>
    697f:	48 8d 15 5a 57 00 00 	lea    0x575a(%rip),%rdx        # c0e0 <_IO_stdin_used+0x10e0>
    6986:	48 63 04 82          	movslq (%rdx,%rax,4),%rax
    698a:	48 01 d0             	add    %rdx,%rax
    698d:	3e ff e0             	notrack jmpq *%rax
    6990:	c7 05 5a 77 00 00 0b 	movl   $0xb,0x775a(%rip)        # e0f4 <__cpu_model+0x4>
    6997:	00 00 00 
    699a:	e9 c7 fe ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    699f:	c7 05 4b 77 00 00 0d 	movl   $0xd,0x774b(%rip)        # e0f4 <__cpu_model+0x4>
    69a6:	00 00 00 
    69a9:	e9 b8 fe ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    69ae:	48 b8 03 00 00 00 11 	movabs $0x1100000003,%rax
    69b5:	00 00 00 
    69b8:	48 89 05 35 77 00 00 	mov    %rax,0x7735(%rip)        # e0f4 <__cpu_model+0x4>
    69bf:	e9 a2 fe ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    69c4:	c7 05 26 77 00 00 0c 	movl   $0xc,0x7726(%rip)        # e0f4 <__cpu_model+0x4>
    69cb:	00 00 00 
    69ce:	e9 93 fe ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    69d3:	c7 05 17 77 00 00 07 	movl   $0x7,0x7717(%rip)        # e0f4 <__cpu_model+0x4>
    69da:	00 00 00 
    69dd:	e9 84 fe ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    69e2:	c7 05 08 77 00 00 03 	movl   $0x3,0x7708(%rip)        # e0f4 <__cpu_model+0x4>
    69e9:	00 00 00 
    69ec:	b8 07 00 00 00       	mov    $0x7,%eax
    69f1:	31 c9                	xor    %ecx,%ecx
    69f3:	0f a2                	cpuid  
    69f5:	80 e5 08             	and    $0x8,%ch
    69f8:	0f 84 4c 01 00 00    	je     6b4a <__cpu_indicator_init+0x37a>
    69fe:	c7 05 f0 76 00 00 15 	movl   $0x15,0x76f0(%rip)        # e0f8 <__cpu_model+0x8>
    6a05:	00 00 00 
    6a08:	e9 59 fe ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6a0d:	48 b8 03 00 00 00 0f 	movabs $0xf00000003,%rax
    6a14:	00 00 00 
    6a17:	48 89 05 d6 76 00 00 	mov    %rax,0x76d6(%rip)        # e0f4 <__cpu_model+0x4>
    6a1e:	e9 43 fe ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6a23:	48 b8 03 00 00 00 0e 	movabs $0xe00000003,%rax
    6a2a:	00 00 00 
    6a2d:	48 89 05 c0 76 00 00 	mov    %rax,0x76c0(%rip)        # e0f4 <__cpu_model+0x4>
    6a34:	e9 2d fe ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6a39:	48 b8 03 00 00 00 0d 	movabs $0xd00000003,%rax
    6a40:	00 00 00 
    6a43:	48 89 05 aa 76 00 00 	mov    %rax,0x76aa(%rip)        # e0f4 <__cpu_model+0x4>
    6a4a:	e9 17 fe ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6a4f:	48 b8 03 00 00 00 0c 	movabs $0xc00000003,%rax
    6a56:	00 00 00 
    6a59:	48 89 05 94 76 00 00 	mov    %rax,0x7694(%rip)        # e0f4 <__cpu_model+0x4>
    6a60:	e9 01 fe ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6a65:	c7 05 85 76 00 00 06 	movl   $0x6,0x7685(%rip)        # e0f4 <__cpu_model+0x4>
    6a6c:	00 00 00 
    6a6f:	e9 f2 fd ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6a74:	48 b8 03 00 00 00 03 	movabs $0x300000003,%rax
    6a7b:	00 00 00 
    6a7e:	48 89 05 6f 76 00 00 	mov    %rax,0x766f(%rip)        # e0f4 <__cpu_model+0x4>
    6a85:	e9 dc fd ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6a8a:	48 b8 03 00 00 00 02 	movabs $0x200000003,%rax
    6a91:	00 00 00 
    6a94:	48 89 05 59 76 00 00 	mov    %rax,0x7659(%rip)        # e0f4 <__cpu_model+0x4>
    6a9b:	e9 c6 fd ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6aa0:	c7 05 4a 76 00 00 01 	movl   $0x1,0x764a(%rip)        # e0f4 <__cpu_model+0x4>
    6aa7:	00 00 00 
    6aaa:	e9 b7 fd ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6aaf:	48 b8 03 00 00 00 01 	movabs $0x100000003,%rax
    6ab6:	00 00 00 
    6ab9:	48 89 05 34 76 00 00 	mov    %rax,0x7634(%rip)        # e0f4 <__cpu_model+0x4>
    6ac0:	e9 a1 fd ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6ac5:	c7 05 25 76 00 00 02 	movl   $0x2,0x7625(%rip)        # e0f4 <__cpu_model+0x4>
    6acc:	00 00 00 
    6acf:	e9 92 fd ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6ad4:	c7 05 1a 76 00 00 08 	movl   $0x8,0x761a(%rip)        # e0f8 <__cpu_model+0x8>
    6adb:	00 00 00 
    6ade:	e9 9f fd ff ff       	jmpq   6882 <__cpu_indicator_init+0xb2>
    6ae3:	83 fa 2f             	cmp    $0x2f,%edx
    6ae6:	0f 86 96 fd ff ff    	jbe    6882 <__cpu_indicator_init+0xb2>
    6aec:	c7 05 02 76 00 00 14 	movl   $0x14,0x7602(%rip)        # e0f8 <__cpu_model+0x8>
    6af3:	00 00 00 
    6af6:	e9 87 fd ff ff       	jmpq   6882 <__cpu_indicator_init+0xb2>
    6afb:	83 fa 2f             	cmp    $0x2f,%edx
    6afe:	76 d4                	jbe    6ad4 <__cpu_indicator_init+0x304>
    6b00:	83 fa 4f             	cmp    $0x4f,%edx
    6b03:	77 2d                	ja     6b32 <__cpu_indicator_init+0x362>
    6b05:	c7 05 e9 75 00 00 09 	movl   $0x9,0x75e9(%rip)        # e0f8 <__cpu_model+0x8>
    6b0c:	00 00 00 
    6b0f:	e9 6e fd ff ff       	jmpq   6882 <__cpu_indicator_init+0xb2>
    6b14:	c7 05 da 75 00 00 06 	movl   $0x6,0x75da(%rip)        # e0f8 <__cpu_model+0x8>
    6b1b:	00 00 00 
    6b1e:	e9 5f fd ff ff       	jmpq   6882 <__cpu_indicator_init+0xb2>
    6b23:	c7 05 cb 75 00 00 05 	movl   $0x5,0x75cb(%rip)        # e0f8 <__cpu_model+0x8>
    6b2a:	00 00 00 
    6b2d:	e9 50 fd ff ff       	jmpq   6882 <__cpu_indicator_init+0xb2>
    6b32:	83 fa 7f             	cmp    $0x7f,%edx
    6b35:	0f 87 47 fd ff ff    	ja     6882 <__cpu_indicator_init+0xb2>
    6b3b:	c7 05 b3 75 00 00 0a 	movl   $0xa,0x75b3(%rip)        # e0f8 <__cpu_model+0x8>
    6b42:	00 00 00 
    6b45:	e9 38 fd ff ff       	jmpq   6882 <__cpu_indicator_init+0xb2>
    6b4a:	c7 05 a4 75 00 00 10 	movl   $0x10,0x75a4(%rip)        # e0f8 <__cpu_model+0x8>
    6b51:	00 00 00 
    6b54:	e9 0d fd ff ff       	jmpq   6866 <__cpu_indicator_init+0x96>
    6b59:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006b60 <_start>:
    6b60:	f3 0f 1e fa          	endbr64 
    6b64:	31 ed                	xor    %ebp,%ebp
    6b66:	49 89 d1             	mov    %rdx,%r9
    6b69:	5e                   	pop    %rsi
    6b6a:	48 89 e2             	mov    %rsp,%rdx
    6b6d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    6b71:	50                   	push   %rax
    6b72:	54                   	push   %rsp
    6b73:	4c 8d 05 66 40 00 00 	lea    0x4066(%rip),%r8        # abe0 <__libc_csu_fini>
    6b7a:	48 8d 0d ef 3f 00 00 	lea    0x3fef(%rip),%rcx        # ab70 <__libc_csu_init>
    6b81:	48 8d 3d 38 a5 ff ff 	lea    -0x5ac8(%rip),%rdi        # 10c0 <main>
    6b88:	ff 15 52 74 00 00    	callq  *0x7452(%rip)        # dfe0 <__libc_start_main@GLIBC_2.2.5>
    6b8e:	f4                   	hlt    
    6b8f:	90                   	nop

0000000000006b90 <deregister_tm_clones>:
    6b90:	48 8d 3d 49 75 00 00 	lea    0x7549(%rip),%rdi        # e0e0 <stderr@@GLIBC_2.2.5>
    6b97:	48 8d 05 42 75 00 00 	lea    0x7542(%rip),%rax        # e0e0 <stderr@@GLIBC_2.2.5>
    6b9e:	48 39 f8             	cmp    %rdi,%rax
    6ba1:	74 15                	je     6bb8 <deregister_tm_clones+0x28>
    6ba3:	48 8b 05 2e 74 00 00 	mov    0x742e(%rip),%rax        # dfd8 <_ITM_deregisterTMCloneTable>
    6baa:	48 85 c0             	test   %rax,%rax
    6bad:	74 09                	je     6bb8 <deregister_tm_clones+0x28>
    6baf:	ff e0                	jmpq   *%rax
    6bb1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6bb8:	c3                   	retq   
    6bb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006bc0 <register_tm_clones>:
    6bc0:	48 8d 3d 19 75 00 00 	lea    0x7519(%rip),%rdi        # e0e0 <stderr@@GLIBC_2.2.5>
    6bc7:	48 8d 35 12 75 00 00 	lea    0x7512(%rip),%rsi        # e0e0 <stderr@@GLIBC_2.2.5>
    6bce:	48 29 fe             	sub    %rdi,%rsi
    6bd1:	48 89 f0             	mov    %rsi,%rax
    6bd4:	48 c1 ee 3f          	shr    $0x3f,%rsi
    6bd8:	48 c1 f8 03          	sar    $0x3,%rax
    6bdc:	48 01 c6             	add    %rax,%rsi
    6bdf:	48 d1 fe             	sar    %rsi
    6be2:	74 14                	je     6bf8 <register_tm_clones+0x38>
    6be4:	48 8b 05 05 74 00 00 	mov    0x7405(%rip),%rax        # dff0 <_ITM_registerTMCloneTable>
    6beb:	48 85 c0             	test   %rax,%rax
    6bee:	74 08                	je     6bf8 <register_tm_clones+0x38>
    6bf0:	ff e0                	jmpq   *%rax
    6bf2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    6bf8:	c3                   	retq   
    6bf9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006c00 <__do_global_dtors_aux>:
    6c00:	f3 0f 1e fa          	endbr64 
    6c04:	80 3d dd 74 00 00 00 	cmpb   $0x0,0x74dd(%rip)        # e0e8 <completed.8061>
    6c0b:	75 2b                	jne    6c38 <__do_global_dtors_aux+0x38>
    6c0d:	55                   	push   %rbp
    6c0e:	48 83 3d e2 73 00 00 	cmpq   $0x0,0x73e2(%rip)        # dff8 <__cxa_finalize@GLIBC_2.2.5>
    6c15:	00 
    6c16:	48 89 e5             	mov    %rsp,%rbp
    6c19:	74 0c                	je     6c27 <__do_global_dtors_aux+0x27>
    6c1b:	48 8b 3d e6 73 00 00 	mov    0x73e6(%rip),%rdi        # e008 <__dso_handle>
    6c22:	e8 89 a4 ff ff       	callq  10b0 <__cxa_finalize@plt>
    6c27:	e8 64 ff ff ff       	callq  6b90 <deregister_tm_clones>
    6c2c:	c6 05 b5 74 00 00 01 	movb   $0x1,0x74b5(%rip)        # e0e8 <completed.8061>
    6c33:	5d                   	pop    %rbp
    6c34:	c3                   	retq   
    6c35:	0f 1f 00             	nopl   (%rax)
    6c38:	c3                   	retq   
    6c39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006c40 <frame_dummy>:
    6c40:	f3 0f 1e fa          	endbr64 
    6c44:	e9 77 ff ff ff       	jmpq   6bc0 <register_tm_clones>

0000000000006c49 <clktest>:
    6c49:	53                   	push   %rbx
    6c4a:	41 50                	push   %r8
    6c4c:	41 51                	push   %r9
    6c4e:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    6c55:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    6c5c:	48 31 db             	xor    %rbx,%rbx

0000000000006c5f <clktest_loop>:
    6c5f:	4c 01 c3             	add    %r8,%rbx
    6c62:	4c 01 c3             	add    %r8,%rbx
    6c65:	4c 01 c3             	add    %r8,%rbx
    6c68:	4c 01 c3             	add    %r8,%rbx
    6c6b:	4c 01 c3             	add    %r8,%rbx
    6c6e:	4c 01 c3             	add    %r8,%rbx
    6c71:	4c 01 c3             	add    %r8,%rbx
    6c74:	4c 01 c3             	add    %r8,%rbx
    6c77:	4c 01 c3             	add    %r8,%rbx
    6c7a:	4c 01 c3             	add    %r8,%rbx
    6c7d:	4c 01 c3             	add    %r8,%rbx
    6c80:	4c 01 c3             	add    %r8,%rbx
    6c83:	4c 01 c3             	add    %r8,%rbx
    6c86:	4c 01 c3             	add    %r8,%rbx
    6c89:	4c 01 c3             	add    %r8,%rbx
    6c8c:	4c 01 c3             	add    %r8,%rbx
    6c8f:	4c 01 c3             	add    %r8,%rbx
    6c92:	4c 01 c3             	add    %r8,%rbx
    6c95:	4c 01 c3             	add    %r8,%rbx
    6c98:	4c 01 c3             	add    %r8,%rbx
    6c9b:	4c 29 cf             	sub    %r9,%rdi
    6c9e:	75 bf                	jne    6c5f <clktest_loop>
    6ca0:	41 59                	pop    %r9
    6ca2:	41 58                	pop    %r8
    6ca4:	5b                   	pop    %rbx
    6ca5:	c3                   	retq   

0000000000006ca6 <clkmovtest>:
    6ca6:	53                   	push   %rbx
    6ca7:	41 50                	push   %r8
    6ca9:	41 51                	push   %r9
    6cab:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    6cb2:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    6cb9:	48 31 db             	xor    %rbx,%rbx

0000000000006cbc <clkmovtest_loop>:
    6cbc:	4c 01 c3             	add    %r8,%rbx
    6cbf:	49 89 d8             	mov    %rbx,%r8
    6cc2:	4c 01 c3             	add    %r8,%rbx
    6cc5:	49 89 d8             	mov    %rbx,%r8
    6cc8:	4c 01 c3             	add    %r8,%rbx
    6ccb:	49 89 d8             	mov    %rbx,%r8
    6cce:	4c 01 c3             	add    %r8,%rbx
    6cd1:	49 89 d8             	mov    %rbx,%r8
    6cd4:	4c 01 c3             	add    %r8,%rbx
    6cd7:	49 89 d8             	mov    %rbx,%r8
    6cda:	4c 01 c3             	add    %r8,%rbx
    6cdd:	49 89 d8             	mov    %rbx,%r8
    6ce0:	4c 01 c3             	add    %r8,%rbx
    6ce3:	49 89 d8             	mov    %rbx,%r8
    6ce6:	4c 01 c3             	add    %r8,%rbx
    6ce9:	49 89 d8             	mov    %rbx,%r8
    6cec:	4c 01 c3             	add    %r8,%rbx
    6cef:	49 89 d8             	mov    %rbx,%r8
    6cf2:	4c 01 c3             	add    %r8,%rbx
    6cf5:	49 89 d8             	mov    %rbx,%r8
    6cf8:	4c 01 c3             	add    %r8,%rbx
    6cfb:	49 89 d8             	mov    %rbx,%r8
    6cfe:	4c 01 c3             	add    %r8,%rbx
    6d01:	49 89 d8             	mov    %rbx,%r8
    6d04:	4c 01 c3             	add    %r8,%rbx
    6d07:	49 89 d8             	mov    %rbx,%r8
    6d0a:	4c 01 c3             	add    %r8,%rbx
    6d0d:	49 89 d8             	mov    %rbx,%r8
    6d10:	4c 01 c3             	add    %r8,%rbx
    6d13:	49 89 d8             	mov    %rbx,%r8
    6d16:	4c 01 c3             	add    %r8,%rbx
    6d19:	49 89 d8             	mov    %rbx,%r8
    6d1c:	4c 01 c3             	add    %r8,%rbx
    6d1f:	49 89 d8             	mov    %rbx,%r8
    6d22:	4c 01 c3             	add    %r8,%rbx
    6d25:	49 89 d8             	mov    %rbx,%r8
    6d28:	4c 01 c3             	add    %r8,%rbx
    6d2b:	49 89 d8             	mov    %rbx,%r8
    6d2e:	4c 01 c3             	add    %r8,%rbx
    6d31:	49 89 d8             	mov    %rbx,%r8
    6d34:	4c 29 cf             	sub    %r9,%rdi
    6d37:	75 83                	jne    6cbc <clkmovtest_loop>
    6d39:	41 59                	pop    %r9
    6d3b:	41 58                	pop    %r8
    6d3d:	5b                   	pop    %rbx
    6d3e:	c3                   	retq   

0000000000006d3f <noptest>:
    6d3f:	53                   	push   %rbx
    6d40:	41 51                	push   %r9
    6d42:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9

0000000000006d49 <noptest_loop>:
    6d49:	66 90                	xchg   %ax,%ax
    6d4b:	66 90                	xchg   %ax,%ax
    6d4d:	66 90                	xchg   %ax,%ax
    6d4f:	66 90                	xchg   %ax,%ax
    6d51:	66 90                	xchg   %ax,%ax
    6d53:	66 90                	xchg   %ax,%ax
    6d55:	66 90                	xchg   %ax,%ax
    6d57:	66 90                	xchg   %ax,%ax
    6d59:	66 90                	xchg   %ax,%ax
    6d5b:	66 90                	xchg   %ax,%ax
    6d5d:	66 90                	xchg   %ax,%ax
    6d5f:	66 90                	xchg   %ax,%ax
    6d61:	66 90                	xchg   %ax,%ax
    6d63:	66 90                	xchg   %ax,%ax
    6d65:	66 90                	xchg   %ax,%ax
    6d67:	66 90                	xchg   %ax,%ax
    6d69:	66 90                	xchg   %ax,%ax
    6d6b:	66 90                	xchg   %ax,%ax
    6d6d:	66 90                	xchg   %ax,%ax
    6d6f:	4c 29 cf             	sub    %r9,%rdi
    6d72:	75 d5                	jne    6d49 <noptest_loop>
    6d74:	41 59                	pop    %r9
    6d76:	5b                   	pop    %rbx
    6d77:	c3                   	retq   

0000000000006d78 <noptest1b>:
    6d78:	53                   	push   %rbx
    6d79:	41 51                	push   %r9
    6d7b:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9

0000000000006d82 <noptest1b_loop>:
    6d82:	90                   	nop
    6d83:	90                   	nop
    6d84:	90                   	nop
    6d85:	90                   	nop
    6d86:	90                   	nop
    6d87:	90                   	nop
    6d88:	90                   	nop
    6d89:	90                   	nop
    6d8a:	90                   	nop
    6d8b:	90                   	nop
    6d8c:	90                   	nop
    6d8d:	90                   	nop
    6d8e:	90                   	nop
    6d8f:	90                   	nop
    6d90:	90                   	nop
    6d91:	90                   	nop
    6d92:	90                   	nop
    6d93:	90                   	nop
    6d94:	90                   	nop
    6d95:	4c 29 cf             	sub    %r9,%rdi
    6d98:	75 e8                	jne    6d82 <noptest1b_loop>
    6d9a:	41 59                	pop    %r9
    6d9c:	5b                   	pop    %rbx
    6d9d:	c3                   	retq   

0000000000006d9e <addtest>:
    6d9e:	53                   	push   %rbx
    6d9f:	51                   	push   %rcx
    6da0:	41 50                	push   %r8
    6da2:	41 51                	push   %r9
    6da4:	41 52                	push   %r10
    6da6:	41 53                	push   %r11
    6da8:	41 54                	push   %r12
    6daa:	41 55                	push   %r13
    6dac:	41 56                	push   %r14
    6dae:	41 57                	push   %r15
    6db0:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    6db7:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    6dbe:	48 31 db             	xor    %rbx,%rbx
    6dc1:	48 31 c9             	xor    %rcx,%rcx
    6dc4:	4d 31 d2             	xor    %r10,%r10
    6dc7:	4d 31 db             	xor    %r11,%r11
    6dca:	4d 31 e4             	xor    %r12,%r12
    6dcd:	4d 31 ed             	xor    %r13,%r13
    6dd0:	4d 31 f6             	xor    %r14,%r14
    6dd3:	4d 31 ff             	xor    %r15,%r15

0000000000006dd6 <addtest_loop>:
    6dd6:	4d 01 c7             	add    %r8,%r15
    6dd9:	4d 01 c6             	add    %r8,%r14
    6ddc:	4d 01 c5             	add    %r8,%r13
    6ddf:	4d 01 c4             	add    %r8,%r12
    6de2:	4d 01 c3             	add    %r8,%r11
    6de5:	4d 01 c2             	add    %r8,%r10
    6de8:	4c 01 c1             	add    %r8,%rcx
    6deb:	4d 01 c7             	add    %r8,%r15
    6dee:	4d 01 c6             	add    %r8,%r14
    6df1:	4d 01 c5             	add    %r8,%r13
    6df4:	4d 01 c4             	add    %r8,%r12
    6df7:	4d 01 c3             	add    %r8,%r11
    6dfa:	4d 01 c2             	add    %r8,%r10
    6dfd:	4c 01 c1             	add    %r8,%rcx
    6e00:	4d 01 c7             	add    %r8,%r15
    6e03:	4d 01 c6             	add    %r8,%r14
    6e06:	4d 01 c5             	add    %r8,%r13
    6e09:	4d 01 c4             	add    %r8,%r12
    6e0c:	4d 01 c3             	add    %r8,%r11
    6e0f:	4d 01 c2             	add    %r8,%r10
    6e12:	4c 29 cf             	sub    %r9,%rdi
    6e15:	75 bf                	jne    6dd6 <addtest_loop>
    6e17:	41 5f                	pop    %r15
    6e19:	41 5e                	pop    %r14
    6e1b:	41 5d                	pop    %r13
    6e1d:	41 5c                	pop    %r12
    6e1f:	41 5b                	pop    %r11
    6e21:	41 5a                	pop    %r10
    6e23:	41 59                	pop    %r9
    6e25:	41 58                	pop    %r8
    6e27:	59                   	pop    %rcx
    6e28:	5b                   	pop    %rbx
    6e29:	c3                   	retq   

0000000000006e2a <addnoptest>:
    6e2a:	53                   	push   %rbx
    6e2b:	51                   	push   %rcx
    6e2c:	41 50                	push   %r8
    6e2e:	41 51                	push   %r9
    6e30:	41 52                	push   %r10
    6e32:	41 53                	push   %r11
    6e34:	41 54                	push   %r12
    6e36:	41 55                	push   %r13
    6e38:	41 56                	push   %r14
    6e3a:	41 57                	push   %r15
    6e3c:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    6e43:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    6e4a:	48 31 db             	xor    %rbx,%rbx
    6e4d:	48 31 c9             	xor    %rcx,%rcx
    6e50:	4d 31 d2             	xor    %r10,%r10
    6e53:	4d 31 db             	xor    %r11,%r11
    6e56:	4d 31 e4             	xor    %r12,%r12
    6e59:	4d 31 ed             	xor    %r13,%r13
    6e5c:	4d 31 f6             	xor    %r14,%r14
    6e5f:	4d 31 ff             	xor    %r15,%r15

0000000000006e62 <addnoptest_loop>:
    6e62:	4d 01 c7             	add    %r8,%r15
    6e65:	4d 01 c6             	add    %r8,%r14
    6e68:	4d 01 c5             	add    %r8,%r13
    6e6b:	4d 01 c4             	add    %r8,%r12
    6e6e:	90                   	nop
    6e6f:	4d 01 c2             	add    %r8,%r10
    6e72:	4c 01 c1             	add    %r8,%rcx
    6e75:	4d 01 c7             	add    %r8,%r15
    6e78:	4d 01 c6             	add    %r8,%r14
    6e7b:	90                   	nop
    6e7c:	4d 01 c4             	add    %r8,%r12
    6e7f:	4d 01 c3             	add    %r8,%r11
    6e82:	4d 01 c2             	add    %r8,%r10
    6e85:	4c 01 c1             	add    %r8,%rcx
    6e88:	90                   	nop
    6e89:	4d 01 c6             	add    %r8,%r14
    6e8c:	4d 01 c5             	add    %r8,%r13
    6e8f:	4d 01 c4             	add    %r8,%r12
    6e92:	4d 01 c3             	add    %r8,%r11
    6e95:	90                   	nop
    6e96:	4c 29 cf             	sub    %r9,%rdi
    6e99:	75 c7                	jne    6e62 <addnoptest_loop>
    6e9b:	41 5f                	pop    %r15
    6e9d:	41 5e                	pop    %r14
    6e9f:	41 5d                	pop    %r13
    6ea1:	41 5c                	pop    %r12
    6ea3:	41 5b                	pop    %r11
    6ea5:	41 5a                	pop    %r10
    6ea7:	41 59                	pop    %r9
    6ea9:	41 58                	pop    %r8
    6eab:	59                   	pop    %rcx
    6eac:	5b                   	pop    %rbx
    6ead:	c3                   	retq   

0000000000006eae <addmovtest>:
    6eae:	53                   	push   %rbx
    6eaf:	51                   	push   %rcx
    6eb0:	41 50                	push   %r8
    6eb2:	41 51                	push   %r9
    6eb4:	41 52                	push   %r10
    6eb6:	41 53                	push   %r11
    6eb8:	41 54                	push   %r12
    6eba:	41 55                	push   %r13
    6ebc:	41 56                	push   %r14
    6ebe:	41 57                	push   %r15
    6ec0:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    6ec7:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    6ece:	48 31 db             	xor    %rbx,%rbx
    6ed1:	48 31 c9             	xor    %rcx,%rcx
    6ed4:	4d 31 d2             	xor    %r10,%r10
    6ed7:	4d 31 db             	xor    %r11,%r11
    6eda:	4d 31 e4             	xor    %r12,%r12
    6edd:	4d 31 ed             	xor    %r13,%r13
    6ee0:	4d 31 f6             	xor    %r14,%r14
    6ee3:	4d 31 ff             	xor    %r15,%r15

0000000000006ee6 <addmovtest_loop>:
    6ee6:	4d 01 c7             	add    %r8,%r15
    6ee9:	4d 01 c6             	add    %r8,%r14
    6eec:	4d 01 c5             	add    %r8,%r13
    6eef:	4d 01 c4             	add    %r8,%r12
    6ef2:	4c 89 fa             	mov    %r15,%rdx
    6ef5:	4d 01 c2             	add    %r8,%r10
    6ef8:	4c 01 c1             	add    %r8,%rcx
    6efb:	4d 01 c7             	add    %r8,%r15
    6efe:	4d 01 c6             	add    %r8,%r14
    6f01:	4c 89 fa             	mov    %r15,%rdx
    6f04:	4d 01 c4             	add    %r8,%r12
    6f07:	4d 01 c3             	add    %r8,%r11
    6f0a:	4d 01 c2             	add    %r8,%r10
    6f0d:	4c 01 c1             	add    %r8,%rcx
    6f10:	4c 89 fa             	mov    %r15,%rdx
    6f13:	4d 01 c6             	add    %r8,%r14
    6f16:	4d 01 c5             	add    %r8,%r13
    6f19:	4d 01 c4             	add    %r8,%r12
    6f1c:	4d 01 c3             	add    %r8,%r11
    6f1f:	4c 89 fa             	mov    %r15,%rdx
    6f22:	4c 29 cf             	sub    %r9,%rdi
    6f25:	75 bf                	jne    6ee6 <addmovtest_loop>
    6f27:	41 5f                	pop    %r15
    6f29:	41 5e                	pop    %r14
    6f2b:	41 5d                	pop    %r13
    6f2d:	41 5c                	pop    %r12
    6f2f:	41 5b                	pop    %r11
    6f31:	41 5a                	pop    %r10
    6f33:	41 59                	pop    %r9
    6f35:	41 58                	pop    %r8
    6f37:	59                   	pop    %rcx
    6f38:	5b                   	pop    %rbx
    6f39:	c3                   	retq   

0000000000006f3a <rortest>:
    6f3a:	53                   	push   %rbx
    6f3b:	51                   	push   %rcx
    6f3c:	41 50                	push   %r8
    6f3e:	41 51                	push   %r9
    6f40:	41 52                	push   %r10
    6f42:	41 53                	push   %r11
    6f44:	41 54                	push   %r12
    6f46:	41 55                	push   %r13
    6f48:	41 56                	push   %r14
    6f4a:	41 57                	push   %r15
    6f4c:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    6f53:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    6f5a:	4c 89 c3             	mov    %r8,%rbx
    6f5d:	4c 89 c1             	mov    %r8,%rcx
    6f60:	4d 89 c2             	mov    %r8,%r10
    6f63:	4d 89 c3             	mov    %r8,%r11
    6f66:	4d 89 c4             	mov    %r8,%r12
    6f69:	4d 89 c5             	mov    %r8,%r13
    6f6c:	4d 89 c6             	mov    %r8,%r14
    6f6f:	4d 89 c7             	mov    %r8,%r15

0000000000006f72 <rortest_loop>:
    6f72:	49 d1 cf             	ror    %r15
    6f75:	49 d1 ce             	ror    %r14
    6f78:	49 d1 cd             	ror    %r13
    6f7b:	49 d1 cc             	ror    %r12
    6f7e:	49 d1 cb             	ror    %r11
    6f81:	49 d1 cf             	ror    %r15
    6f84:	49 d1 ce             	ror    %r14
    6f87:	49 d1 cd             	ror    %r13
    6f8a:	49 d1 cc             	ror    %r12
    6f8d:	49 d1 cb             	ror    %r11
    6f90:	49 d1 cf             	ror    %r15
    6f93:	49 d1 ce             	ror    %r14
    6f96:	49 d1 cd             	ror    %r13
    6f99:	49 d1 cc             	ror    %r12
    6f9c:	49 d1 cb             	ror    %r11
    6f9f:	49 d1 cf             	ror    %r15
    6fa2:	49 d1 ce             	ror    %r14
    6fa5:	49 d1 cd             	ror    %r13
    6fa8:	49 d1 cc             	ror    %r12
    6fab:	49 d1 cb             	ror    %r11
    6fae:	4c 29 cf             	sub    %r9,%rdi
    6fb1:	75 bf                	jne    6f72 <rortest_loop>
    6fb3:	41 5f                	pop    %r15
    6fb5:	41 5e                	pop    %r14
    6fb7:	41 5d                	pop    %r13
    6fb9:	41 5c                	pop    %r12
    6fbb:	41 5b                	pop    %r11
    6fbd:	41 5a                	pop    %r10
    6fbf:	41 59                	pop    %r9
    6fc1:	41 58                	pop    %r8
    6fc3:	59                   	pop    %rcx
    6fc4:	5b                   	pop    %rbx
    6fc5:	c3                   	retq   

0000000000006fc6 <shltest>:
    6fc6:	53                   	push   %rbx
    6fc7:	51                   	push   %rcx
    6fc8:	41 50                	push   %r8
    6fca:	41 51                	push   %r9
    6fcc:	41 52                	push   %r10
    6fce:	41 53                	push   %r11
    6fd0:	41 54                	push   %r12
    6fd2:	41 55                	push   %r13
    6fd4:	41 56                	push   %r14
    6fd6:	41 57                	push   %r15
    6fd8:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    6fdf:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    6fe6:	4c 89 c3             	mov    %r8,%rbx
    6fe9:	4c 89 c1             	mov    %r8,%rcx
    6fec:	4d 89 c2             	mov    %r8,%r10
    6fef:	4d 89 c3             	mov    %r8,%r11
    6ff2:	4d 89 c4             	mov    %r8,%r12
    6ff5:	4d 89 c5             	mov    %r8,%r13
    6ff8:	4d 89 c6             	mov    %r8,%r14
    6ffb:	4d 89 c7             	mov    %r8,%r15

0000000000006ffe <shltest_loop>:
    6ffe:	49 d1 e7             	shl    %r15
    7001:	49 d1 e6             	shl    %r14
    7004:	49 d1 e5             	shl    %r13
    7007:	49 d1 e4             	shl    %r12
    700a:	49 d1 e3             	shl    %r11
    700d:	49 d1 e7             	shl    %r15
    7010:	49 d1 e6             	shl    %r14
    7013:	49 d1 e5             	shl    %r13
    7016:	49 d1 e4             	shl    %r12
    7019:	49 d1 e3             	shl    %r11
    701c:	49 d1 e7             	shl    %r15
    701f:	49 d1 e6             	shl    %r14
    7022:	49 d1 e5             	shl    %r13
    7025:	49 d1 e4             	shl    %r12
    7028:	49 d1 e3             	shl    %r11
    702b:	49 d1 e7             	shl    %r15
    702e:	49 d1 e6             	shl    %r14
    7031:	49 d1 e5             	shl    %r13
    7034:	49 d1 e4             	shl    %r12
    7037:	49 d1 e3             	shl    %r11
    703a:	4c 29 cf             	sub    %r9,%rdi
    703d:	75 bf                	jne    6ffe <shltest_loop>
    703f:	41 5f                	pop    %r15
    7041:	41 5e                	pop    %r14
    7043:	41 5d                	pop    %r13
    7045:	41 5c                	pop    %r12
    7047:	41 5b                	pop    %r11
    7049:	41 5a                	pop    %r10
    704b:	41 59                	pop    %r9
    704d:	41 58                	pop    %r8
    704f:	59                   	pop    %rcx
    7050:	5b                   	pop    %rbx
    7051:	c3                   	retq   

0000000000007052 <mixrorshltest>:
    7052:	53                   	push   %rbx
    7053:	51                   	push   %rcx
    7054:	41 50                	push   %r8
    7056:	41 51                	push   %r9
    7058:	41 52                	push   %r10
    705a:	41 53                	push   %r11
    705c:	41 54                	push   %r12
    705e:	41 55                	push   %r13
    7060:	41 56                	push   %r14
    7062:	41 57                	push   %r15
    7064:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    706b:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7072:	4c 89 c3             	mov    %r8,%rbx
    7075:	4c 89 c1             	mov    %r8,%rcx
    7078:	4d 89 c2             	mov    %r8,%r10
    707b:	4d 89 c3             	mov    %r8,%r11
    707e:	4d 89 c4             	mov    %r8,%r12
    7081:	4d 89 c5             	mov    %r8,%r13
    7084:	4d 89 c6             	mov    %r8,%r14
    7087:	4d 89 c7             	mov    %r8,%r15

000000000000708a <mixrorshltest_loop>:
    708a:	49 d1 cf             	ror    %r15
    708d:	49 d1 e6             	shl    %r14
    7090:	49 d1 cd             	ror    %r13
    7093:	49 d1 e4             	shl    %r12
    7096:	49 d1 cb             	ror    %r11
    7099:	49 d1 e7             	shl    %r15
    709c:	49 d1 ce             	ror    %r14
    709f:	49 d1 e5             	shl    %r13
    70a2:	49 d1 cc             	ror    %r12
    70a5:	49 d1 e3             	shl    %r11
    70a8:	49 d1 cf             	ror    %r15
    70ab:	49 d1 e6             	shl    %r14
    70ae:	49 d1 cd             	ror    %r13
    70b1:	49 d1 e4             	shl    %r12
    70b4:	49 d1 cb             	ror    %r11
    70b7:	49 d1 e7             	shl    %r15
    70ba:	49 d1 ce             	ror    %r14
    70bd:	49 d1 e5             	shl    %r13
    70c0:	49 d1 cc             	ror    %r12
    70c3:	49 d1 e3             	shl    %r11
    70c6:	4c 29 cf             	sub    %r9,%rdi
    70c9:	75 bf                	jne    708a <mixrorshltest_loop>
    70cb:	41 5f                	pop    %r15
    70cd:	41 5e                	pop    %r14
    70cf:	41 5d                	pop    %r13
    70d1:	41 5c                	pop    %r12
    70d3:	41 5b                	pop    %r11
    70d5:	41 5a                	pop    %r10
    70d7:	41 59                	pop    %r9
    70d9:	41 58                	pop    %r8
    70db:	59                   	pop    %rcx
    70dc:	5b                   	pop    %rbx
    70dd:	c3                   	retq   

00000000000070de <mixrormultest>:
    70de:	53                   	push   %rbx
    70df:	51                   	push   %rcx
    70e0:	56                   	push   %rsi
    70e1:	52                   	push   %rdx
    70e2:	41 50                	push   %r8
    70e4:	41 51                	push   %r9
    70e6:	41 52                	push   %r10
    70e8:	41 53                	push   %r11
    70ea:	41 54                	push   %r12
    70ec:	41 55                	push   %r13
    70ee:	41 56                	push   %r14
    70f0:	41 57                	push   %r15
    70f2:	49 c7 c0 03 00 00 00 	mov    $0x3,%r8
    70f9:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7100:	4c 89 c3             	mov    %r8,%rbx
    7103:	4c 89 c1             	mov    %r8,%rcx
    7106:	4d 89 c2             	mov    %r8,%r10
    7109:	4d 89 c3             	mov    %r8,%r11
    710c:	4d 89 c4             	mov    %r8,%r12
    710f:	4d 89 c5             	mov    %r8,%r13
    7112:	4d 89 c6             	mov    %r8,%r14
    7115:	4d 89 c7             	mov    %r8,%r15

0000000000007118 <mixrormultest_loop>:
    7118:	49 d1 cf             	ror    %r15
    711b:	4d 0f af f0          	imul   %r8,%r14
    711f:	4d 89 ce             	mov    %r9,%r14
    7122:	49 d1 cd             	ror    %r13
    7125:	4d 0f af e0          	imul   %r8,%r12
    7129:	4d 89 cc             	mov    %r9,%r12
    712c:	49 d1 cb             	ror    %r11
    712f:	4d 0f af d0          	imul   %r8,%r10
    7133:	4d 89 ca             	mov    %r9,%r10
    7136:	48 d1 cb             	ror    %rbx
    7139:	49 0f af c8          	imul   %r8,%rcx
    713d:	4c 89 c9             	mov    %r9,%rcx
    7140:	48 d1 ce             	ror    %rsi
    7143:	49 0f af c0          	imul   %r8,%rax
    7147:	4c 89 c8             	mov    %r9,%rax
    714a:	49 d1 cf             	ror    %r15
    714d:	4d 0f af f0          	imul   %r8,%r14
    7151:	4d 89 ce             	mov    %r9,%r14
    7154:	49 d1 cd             	ror    %r13
    7157:	4d 0f af e0          	imul   %r8,%r12
    715b:	4d 89 cc             	mov    %r9,%r12
    715e:	49 d1 cb             	ror    %r11
    7161:	4d 0f af d0          	imul   %r8,%r10
    7165:	4d 89 ca             	mov    %r9,%r10
    7168:	48 d1 cb             	ror    %rbx
    716b:	49 0f af c8          	imul   %r8,%rcx
    716f:	4c 89 c9             	mov    %r9,%rcx
    7172:	48 d1 ce             	ror    %rsi
    7175:	49 0f af d0          	imul   %r8,%rdx
    7179:	4c 29 cf             	sub    %r9,%rdi
    717c:	75 9a                	jne    7118 <mixrormultest_loop>
    717e:	41 5f                	pop    %r15
    7180:	41 5e                	pop    %r14
    7182:	41 5d                	pop    %r13
    7184:	41 5c                	pop    %r12
    7186:	41 5b                	pop    %r11
    7188:	41 5a                	pop    %r10
    718a:	41 59                	pop    %r9
    718c:	41 58                	pop    %r8
    718e:	5a                   	pop    %rdx
    718f:	5e                   	pop    %rsi
    7190:	59                   	pop    %rcx
    7191:	5b                   	pop    %rbx
    7192:	c3                   	retq   

0000000000007193 <rorbtstest>:
    7193:	53                   	push   %rbx
    7194:	51                   	push   %rcx
    7195:	52                   	push   %rdx
    7196:	56                   	push   %rsi
    7197:	41 50                	push   %r8
    7199:	41 51                	push   %r9
    719b:	41 52                	push   %r10
    719d:	41 53                	push   %r11
    719f:	41 54                	push   %r12
    71a1:	41 55                	push   %r13
    71a3:	41 56                	push   %r14
    71a5:	41 57                	push   %r15
    71a7:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    71ae:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    71b5:	4c 89 c3             	mov    %r8,%rbx
    71b8:	4c 89 c1             	mov    %r8,%rcx
    71bb:	4d 89 c2             	mov    %r8,%r10
    71be:	4d 89 c3             	mov    %r8,%r11
    71c1:	4d 89 c4             	mov    %r8,%r12
    71c4:	4d 89 c5             	mov    %r8,%r13
    71c7:	4d 89 c6             	mov    %r8,%r14
    71ca:	4d 89 c7             	mov    %r8,%r15
    71cd:	49 ff c0             	inc    %r8

00000000000071d0 <rorbtstest_loop>:
    71d0:	4d 0f ab c7          	bts    %r8,%r15
    71d4:	49 d1 ce             	ror    %r14
    71d7:	4d 0f ab c5          	bts    %r8,%r13
    71db:	49 d1 cc             	ror    %r12
    71de:	4d 0f ab c3          	bts    %r8,%r11
    71e2:	49 d1 ca             	ror    %r10
    71e5:	4c 0f ab c1          	bts    %r8,%rcx
    71e9:	48 d1 cb             	ror    %rbx
    71ec:	4c 0f ab c2          	bts    %r8,%rdx
    71f0:	48 d1 ce             	ror    %rsi
    71f3:	4d 0f ab c7          	bts    %r8,%r15
    71f7:	49 d1 ce             	ror    %r14
    71fa:	4d 0f ab c5          	bts    %r8,%r13
    71fe:	49 d1 cc             	ror    %r12
    7201:	4d 0f ab c3          	bts    %r8,%r11
    7205:	49 d1 ca             	ror    %r10
    7208:	4c 0f ab c1          	bts    %r8,%rcx
    720c:	48 d1 cb             	ror    %rbx
    720f:	4c 0f ab c2          	bts    %r8,%rdx
    7213:	48 d1 ce             	ror    %rsi
    7216:	4c 29 cf             	sub    %r9,%rdi
    7219:	75 b5                	jne    71d0 <rorbtstest_loop>
    721b:	41 5f                	pop    %r15
    721d:	41 5e                	pop    %r14
    721f:	41 5d                	pop    %r13
    7221:	41 5c                	pop    %r12
    7223:	41 5b                	pop    %r11
    7225:	41 5a                	pop    %r10
    7227:	41 59                	pop    %r9
    7229:	41 58                	pop    %r8
    722b:	5e                   	pop    %rsi
    722c:	5a                   	pop    %rdx
    722d:	59                   	pop    %rcx
    722e:	5b                   	pop    %rbx
    722f:	c3                   	retq   

0000000000007230 <btstest>:
    7230:	53                   	push   %rbx
    7231:	51                   	push   %rcx
    7232:	41 50                	push   %r8
    7234:	41 51                	push   %r9
    7236:	41 52                	push   %r10
    7238:	41 53                	push   %r11
    723a:	41 54                	push   %r12
    723c:	41 55                	push   %r13
    723e:	41 56                	push   %r14
    7240:	41 57                	push   %r15
    7242:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    7249:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7250:	4c 89 c3             	mov    %r8,%rbx
    7253:	4c 89 c1             	mov    %r8,%rcx
    7256:	4d 89 c2             	mov    %r8,%r10
    7259:	4d 89 c3             	mov    %r8,%r11
    725c:	4d 89 c4             	mov    %r8,%r12
    725f:	4d 89 c5             	mov    %r8,%r13
    7262:	4d 89 c6             	mov    %r8,%r14
    7265:	4d 89 c7             	mov    %r8,%r15
    7268:	49 ff c0             	inc    %r8

000000000000726b <btstest_loop>:
    726b:	4d 0f ab c7          	bts    %r8,%r15
    726f:	4d 0f ab c6          	bts    %r8,%r14
    7273:	4d 0f ab c5          	bts    %r8,%r13
    7277:	4d 0f ab c4          	bts    %r8,%r12
    727b:	4d 0f ab c3          	bts    %r8,%r11
    727f:	4d 0f ab c7          	bts    %r8,%r15
    7283:	4d 0f ab c6          	bts    %r8,%r14
    7287:	4d 0f ab c5          	bts    %r8,%r13
    728b:	4d 0f ab c4          	bts    %r8,%r12
    728f:	4d 0f ab c3          	bts    %r8,%r11
    7293:	4d 0f ab c7          	bts    %r8,%r15
    7297:	4d 0f ab c6          	bts    %r8,%r14
    729b:	4d 0f ab c5          	bts    %r8,%r13
    729f:	4d 0f ab c4          	bts    %r8,%r12
    72a3:	4d 0f ab c3          	bts    %r8,%r11
    72a7:	4d 0f ab c7          	bts    %r8,%r15
    72ab:	4d 0f ab c6          	bts    %r8,%r14
    72af:	4d 0f ab c5          	bts    %r8,%r13
    72b3:	4d 0f ab c4          	bts    %r8,%r12
    72b7:	4d 0f ab c3          	bts    %r8,%r11
    72bb:	4c 29 cf             	sub    %r9,%rdi
    72be:	75 ab                	jne    726b <btstest_loop>
    72c0:	41 5f                	pop    %r15
    72c2:	41 5e                	pop    %r14
    72c4:	41 5d                	pop    %r13
    72c6:	41 5c                	pop    %r12
    72c8:	41 5b                	pop    %r11
    72ca:	41 5a                	pop    %r10
    72cc:	41 59                	pop    %r9
    72ce:	41 58                	pop    %r8
    72d0:	59                   	pop    %rcx
    72d1:	5b                   	pop    %rbx
    72d2:	c3                   	retq   

00000000000072d3 <leatest>:
    72d3:	53                   	push   %rbx
    72d4:	51                   	push   %rcx
    72d5:	41 50                	push   %r8
    72d7:	41 51                	push   %r9
    72d9:	41 52                	push   %r10
    72db:	41 53                	push   %r11
    72dd:	41 54                	push   %r12
    72df:	41 55                	push   %r13
    72e1:	41 56                	push   %r14
    72e3:	41 57                	push   %r15
    72e5:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    72ec:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    72f3:	4c 89 c3             	mov    %r8,%rbx
    72f6:	4c 89 c1             	mov    %r8,%rcx
    72f9:	4d 89 c2             	mov    %r8,%r10
    72fc:	4d 89 c3             	mov    %r8,%r11
    72ff:	4d 89 c4             	mov    %r8,%r12
    7302:	4d 89 c5             	mov    %r8,%r13
    7305:	4d 89 c6             	mov    %r8,%r14
    7308:	4d 89 c7             	mov    %r8,%r15
    730b:	49 ff c0             	inc    %r8

000000000000730e <leatest_loop>:
    730e:	4f 8d 14 d1          	lea    (%r9,%r10,8),%r10
    7312:	4f 8d 1c d9          	lea    (%r9,%r11,8),%r11
    7316:	4f 8d 24 e1          	lea    (%r9,%r12,8),%r12
    731a:	4f 8d 2c e9          	lea    (%r9,%r13,8),%r13
    731e:	4f 8d 34 f1          	lea    (%r9,%r14,8),%r14
    7322:	4f 8d 3c f9          	lea    (%r9,%r15,8),%r15
    7326:	4f 8d 14 d1          	lea    (%r9,%r10,8),%r10
    732a:	4f 8d 1c d9          	lea    (%r9,%r11,8),%r11
    732e:	4f 8d 24 e1          	lea    (%r9,%r12,8),%r12
    7332:	4f 8d 2c e9          	lea    (%r9,%r13,8),%r13
    7336:	4f 8d 34 f1          	lea    (%r9,%r14,8),%r14
    733a:	4f 8d 3c f9          	lea    (%r9,%r15,8),%r15
    733e:	4f 8d 14 d1          	lea    (%r9,%r10,8),%r10
    7342:	4f 8d 1c d9          	lea    (%r9,%r11,8),%r11
    7346:	4f 8d 24 e1          	lea    (%r9,%r12,8),%r12
    734a:	4f 8d 2c e9          	lea    (%r9,%r13,8),%r13
    734e:	4f 8d 34 f1          	lea    (%r9,%r14,8),%r14
    7352:	4f 8d 3c f9          	lea    (%r9,%r15,8),%r15
    7356:	4f 8d 14 d1          	lea    (%r9,%r10,8),%r10
    735a:	4f 8d 1c d9          	lea    (%r9,%r11,8),%r11
    735e:	4c 29 cf             	sub    %r9,%rdi
    7361:	75 ab                	jne    730e <leatest_loop>
    7363:	41 5f                	pop    %r15
    7365:	41 5e                	pop    %r14
    7367:	41 5d                	pop    %r13
    7369:	41 5c                	pop    %r12
    736b:	41 5b                	pop    %r11
    736d:	41 5a                	pop    %r10
    736f:	41 59                	pop    %r9
    7371:	41 58                	pop    %r8
    7373:	59                   	pop    %rcx
    7374:	5b                   	pop    %rbx
    7375:	c3                   	retq   

0000000000007376 <leamultest>:
    7376:	53                   	push   %rbx
    7377:	51                   	push   %rcx
    7378:	52                   	push   %rdx
    7379:	56                   	push   %rsi
    737a:	41 50                	push   %r8
    737c:	41 51                	push   %r9
    737e:	41 52                	push   %r10
    7380:	41 53                	push   %r11
    7382:	41 54                	push   %r12
    7384:	41 55                	push   %r13
    7386:	41 56                	push   %r14
    7388:	41 57                	push   %r15
    738a:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    7391:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7398:	4c 89 c3             	mov    %r8,%rbx
    739b:	4c 89 c1             	mov    %r8,%rcx
    739e:	4d 89 c2             	mov    %r8,%r10
    73a1:	4d 89 c3             	mov    %r8,%r11
    73a4:	4d 89 c4             	mov    %r8,%r12
    73a7:	4d 89 c5             	mov    %r8,%r13
    73aa:	4d 89 c6             	mov    %r8,%r14
    73ad:	4d 89 c7             	mov    %r8,%r15
    73b0:	49 ff c0             	inc    %r8

00000000000073b3 <leamultest_loop>:
    73b3:	4f 8d 3c f9          	lea    (%r9,%r15,8),%r15
    73b7:	4d 0f af f0          	imul   %r8,%r14
    73bb:	4d 89 c6             	mov    %r8,%r14
    73be:	4f 8d 2c e9          	lea    (%r9,%r13,8),%r13
    73c2:	4d 0f af e0          	imul   %r8,%r12
    73c6:	4d 89 c4             	mov    %r8,%r12
    73c9:	4f 8d 1c d9          	lea    (%r9,%r11,8),%r11
    73cd:	4d 0f af d0          	imul   %r8,%r10
    73d1:	4d 89 c2             	mov    %r8,%r10
    73d4:	49 8d 1c d9          	lea    (%r9,%rbx,8),%rbx
    73d8:	49 0f af c8          	imul   %r8,%rcx
    73dc:	4c 89 c1             	mov    %r8,%rcx
    73df:	49 8d 14 d1          	lea    (%r9,%rdx,8),%rdx
    73e3:	49 0f af c0          	imul   %r8,%rax
    73e7:	4f 8d 3c f9          	lea    (%r9,%r15,8),%r15
    73eb:	4d 0f af f0          	imul   %r8,%r14
    73ef:	4f 8d 2c e9          	lea    (%r9,%r13,8),%r13
    73f3:	4d 0f af e0          	imul   %r8,%r12
    73f7:	4f 8d 1c d9          	lea    (%r9,%r11,8),%r11
    73fb:	4d 0f af d0          	imul   %r8,%r10
    73ff:	49 8d 1c d9          	lea    (%r9,%rbx,8),%rbx
    7403:	49 0f af c8          	imul   %r8,%rcx
    7407:	49 8d 14 d1          	lea    (%r9,%rdx,8),%rdx
    740b:	49 0f af c0          	imul   %r8,%rax
    740f:	4c 29 cf             	sub    %r9,%rdi
    7412:	75 9f                	jne    73b3 <leamultest_loop>
    7414:	41 5f                	pop    %r15
    7416:	41 5e                	pop    %r14
    7418:	41 5d                	pop    %r13
    741a:	41 5c                	pop    %r12
    741c:	41 5b                	pop    %r11
    741e:	41 5a                	pop    %r10
    7420:	41 59                	pop    %r9
    7422:	41 58                	pop    %r8
    7424:	5e                   	pop    %rsi
    7425:	5a                   	pop    %rdx
    7426:	59                   	pop    %rcx
    7427:	5b                   	pop    %rbx
    7428:	c3                   	retq   

0000000000007429 <btsmultest>:
    7429:	53                   	push   %rbx
    742a:	51                   	push   %rcx
    742b:	56                   	push   %rsi
    742c:	52                   	push   %rdx
    742d:	41 50                	push   %r8
    742f:	41 51                	push   %r9
    7431:	41 52                	push   %r10
    7433:	41 53                	push   %r11
    7435:	41 54                	push   %r12
    7437:	41 55                	push   %r13
    7439:	41 56                	push   %r14
    743b:	41 57                	push   %r15
    743d:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    7444:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    744b:	4c 89 c3             	mov    %r8,%rbx
    744e:	4c 89 c2             	mov    %r8,%rdx
    7451:	4c 89 c6             	mov    %r8,%rsi
    7454:	4c 89 c1             	mov    %r8,%rcx
    7457:	4d 89 c2             	mov    %r8,%r10
    745a:	4d 89 c3             	mov    %r8,%r11
    745d:	4d 89 c4             	mov    %r8,%r12
    7460:	4d 89 c5             	mov    %r8,%r13
    7463:	4d 89 c6             	mov    %r8,%r14
    7466:	4d 89 c7             	mov    %r8,%r15
    7469:	49 ff c0             	inc    %r8

000000000000746c <btsmultest_loop>:
    746c:	4d 0f af f0          	imul   %r8,%r14
    7470:	4d 0f ab c5          	bts    %r8,%r13
    7474:	4d 89 c5             	mov    %r8,%r13
    7477:	4d 0f af e0          	imul   %r8,%r12
    747b:	4d 0f ab c3          	bts    %r8,%r11
    747f:	4d 89 c3             	mov    %r8,%r11
    7482:	4d 0f af d0          	imul   %r8,%r10
    7486:	4c 0f ab c3          	bts    %r8,%rbx
    748a:	49 0f af c8          	imul   %r8,%rcx
    748e:	4c 89 c1             	mov    %r8,%rcx
    7491:	4c 0f ab c6          	bts    %r8,%rsi
    7495:	49 0f af c0          	imul   %r8,%rax
    7499:	4c 89 c0             	mov    %r8,%rax
    749c:	4d 0f ab c7          	bts    %r8,%r15
    74a0:	4d 0f af f0          	imul   %r8,%r14
    74a4:	4d 89 c6             	mov    %r8,%r14
    74a7:	4d 0f ab c5          	bts    %r8,%r13
    74ab:	4d 0f af e0          	imul   %r8,%r12
    74af:	4d 89 c4             	mov    %r8,%r12
    74b2:	4d 0f ab c3          	bts    %r8,%r11
    74b6:	4d 0f af d0          	imul   %r8,%r10
    74ba:	4d 89 c2             	mov    %r8,%r10
    74bd:	4c 0f ab c3          	bts    %r8,%rbx
    74c1:	49 0f af c8          	imul   %r8,%rcx
    74c5:	4c 89 c1             	mov    %r8,%rcx
    74c8:	4c 0f ab c6          	bts    %r8,%rsi
    74cc:	49 0f af d0          	imul   %r8,%rdx
    74d0:	4c 89 c2             	mov    %r8,%rdx
    74d3:	4d 0f ab c3          	bts    %r8,%r11
    74d7:	4c 29 cf             	sub    %r9,%rdi
    74da:	75 90                	jne    746c <btsmultest_loop>
    74dc:	41 5f                	pop    %r15
    74de:	41 5e                	pop    %r14
    74e0:	41 5d                	pop    %r13
    74e2:	41 5c                	pop    %r12
    74e4:	41 5b                	pop    %r11
    74e6:	41 5a                	pop    %r10
    74e8:	41 59                	pop    %r9
    74ea:	41 58                	pop    %r8
    74ec:	5a                   	pop    %rdx
    74ed:	5e                   	pop    %rsi
    74ee:	59                   	pop    %rcx
    74ef:	5b                   	pop    %rbx
    74f0:	c3                   	retq   

00000000000074f1 <jmptest>:
    74f1:	56                   	push   %rsi
    74f2:	53                   	push   %rbx
    74f3:	51                   	push   %rcx
    74f4:	52                   	push   %rdx
    74f5:	41 50                	push   %r8
    74f7:	41 51                	push   %r9
    74f9:	41 52                	push   %r10
    74fb:	41 53                	push   %r11
    74fd:	41 54                	push   %r12
    74ff:	41 55                	push   %r13
    7501:	41 56                	push   %r14
    7503:	41 57                	push   %r15
    7505:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    750c:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7513:	48 31 db             	xor    %rbx,%rbx
    7516:	48 31 c9             	xor    %rcx,%rcx
    7519:	4d 31 d2             	xor    %r10,%r10
    751c:	4d 31 db             	xor    %r11,%r11
    751f:	4d 31 e4             	xor    %r12,%r12
    7522:	4d 31 ed             	xor    %r13,%r13
    7525:	4d 31 f6             	xor    %r14,%r14
    7528:	4d 31 ff             	xor    %r15,%r15
    752b:	48 31 f6             	xor    %rsi,%rsi
    752e:	4d 89 c2             	mov    %r8,%r10
    7531:	4d 89 c3             	mov    %r8,%r11
    7534:	4c 89 c6             	mov    %r8,%rsi
    7537:	4c 89 c0             	mov    %r8,%rax
    753a:	4c 89 c2             	mov    %r8,%rdx

000000000000753d <jmptest_loop>:
    753d:	eb 04                	jmp    7543 <jmptest1>
    753f:	48 83 c0 01          	add    $0x1,%rax

0000000000007543 <jmptest1>:
    7543:	eb 04                	jmp    7549 <jmptest2>
    7545:	48 83 c0 02          	add    $0x2,%rax

0000000000007549 <jmptest2>:
    7549:	eb 04                	jmp    754f <jmptest3>
    754b:	48 83 c0 03          	add    $0x3,%rax

000000000000754f <jmptest3>:
    754f:	eb 04                	jmp    7555 <jmptest4>
    7551:	48 83 c0 04          	add    $0x4,%rax

0000000000007555 <jmptest4>:
    7555:	eb 04                	jmp    755b <jmptest5>
    7557:	48 83 c0 05          	add    $0x5,%rax

000000000000755b <jmptest5>:
    755b:	eb 04                	jmp    7561 <jmptest6>
    755d:	48 83 c0 06          	add    $0x6,%rax

0000000000007561 <jmptest6>:
    7561:	eb 04                	jmp    7567 <jmptest7>
    7563:	48 83 c0 07          	add    $0x7,%rax

0000000000007567 <jmptest7>:
    7567:	eb 04                	jmp    756d <jmptest8>
    7569:	48 83 c0 08          	add    $0x8,%rax

000000000000756d <jmptest8>:
    756d:	eb 04                	jmp    7573 <jmptest9>
    756f:	48 83 c0 09          	add    $0x9,%rax

0000000000007573 <jmptest9>:
    7573:	eb 04                	jmp    7579 <jmptest10>
    7575:	48 83 c0 0a          	add    $0xa,%rax

0000000000007579 <jmptest10>:
    7579:	eb 04                	jmp    757f <jmptest11>
    757b:	48 83 c0 0b          	add    $0xb,%rax

000000000000757f <jmptest11>:
    757f:	eb 04                	jmp    7585 <jmptest12>
    7581:	48 83 c0 0c          	add    $0xc,%rax

0000000000007585 <jmptest12>:
    7585:	eb 04                	jmp    758b <jmptest13>
    7587:	48 83 c0 0d          	add    $0xd,%rax

000000000000758b <jmptest13>:
    758b:	eb 04                	jmp    7591 <jmptest14>
    758d:	48 83 c0 0e          	add    $0xe,%rax

0000000000007591 <jmptest14>:
    7591:	eb 04                	jmp    7597 <jmptest15>
    7593:	48 83 c0 0f          	add    $0xf,%rax

0000000000007597 <jmptest15>:
    7597:	eb 04                	jmp    759d <jmptest16>
    7599:	48 83 c0 10          	add    $0x10,%rax

000000000000759d <jmptest16>:
    759d:	eb 04                	jmp    75a3 <jmptest17>
    759f:	48 83 c0 11          	add    $0x11,%rax

00000000000075a3 <jmptest17>:
    75a3:	eb 04                	jmp    75a9 <jmptest18>
    75a5:	48 83 c0 12          	add    $0x12,%rax

00000000000075a9 <jmptest18>:
    75a9:	eb 04                	jmp    75af <jmptest19>
    75ab:	48 83 c0 13          	add    $0x13,%rax

00000000000075af <jmptest19>:
    75af:	4c 29 cf             	sub    %r9,%rdi
    75b2:	75 89                	jne    753d <jmptest_loop>

00000000000075b4 <jmptest_jellydonut>:
    75b4:	41 5f                	pop    %r15
    75b6:	41 5e                	pop    %r14
    75b8:	41 5d                	pop    %r13
    75ba:	41 5c                	pop    %r12
    75bc:	41 5b                	pop    %r11
    75be:	41 5a                	pop    %r10
    75c0:	41 59                	pop    %r9
    75c2:	41 58                	pop    %r8
    75c4:	5a                   	pop    %rdx
    75c5:	59                   	pop    %rcx
    75c6:	5b                   	pop    %rbx
    75c7:	5e                   	pop    %rsi
    75c8:	c3                   	retq   

00000000000075c9 <ntjmptest>:
    75c9:	56                   	push   %rsi
    75ca:	53                   	push   %rbx
    75cb:	51                   	push   %rcx
    75cc:	52                   	push   %rdx
    75cd:	41 50                	push   %r8
    75cf:	41 51                	push   %r9
    75d1:	41 52                	push   %r10
    75d3:	41 53                	push   %r11
    75d5:	41 54                	push   %r12
    75d7:	41 55                	push   %r13
    75d9:	41 56                	push   %r14
    75db:	41 57                	push   %r15
    75dd:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    75e4:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    75eb:	48 31 db             	xor    %rbx,%rbx
    75ee:	48 31 c9             	xor    %rcx,%rcx
    75f1:	4d 31 d2             	xor    %r10,%r10
    75f4:	4d 31 db             	xor    %r11,%r11
    75f7:	4d 31 e4             	xor    %r12,%r12
    75fa:	4d 31 ed             	xor    %r13,%r13
    75fd:	4d 31 f6             	xor    %r14,%r14
    7600:	4d 31 ff             	xor    %r15,%r15
    7603:	48 31 f6             	xor    %rsi,%rsi
    7606:	4d 89 c2             	mov    %r8,%r10
    7609:	4d 89 c3             	mov    %r8,%r11
    760c:	4c 89 c6             	mov    %r8,%rsi
    760f:	4c 89 c0             	mov    %r8,%rax
    7612:	4c 89 c2             	mov    %r8,%rdx

0000000000007615 <ntjmptest_loop>:
    7615:	4d 39 c1             	cmp    %r8,%r9
    7618:	0f 84 71 01 00 00    	je     778f <jmpmultest_jellydonut>
    761e:	4d 39 c1             	cmp    %r8,%r9
    7621:	0f 84 68 01 00 00    	je     778f <jmpmultest_jellydonut>
    7627:	4d 39 c1             	cmp    %r8,%r9
    762a:	0f 84 5f 01 00 00    	je     778f <jmpmultest_jellydonut>
    7630:	4d 39 c1             	cmp    %r8,%r9
    7633:	0f 84 56 01 00 00    	je     778f <jmpmultest_jellydonut>
    7639:	4d 39 c1             	cmp    %r8,%r9
    763c:	0f 84 4d 01 00 00    	je     778f <jmpmultest_jellydonut>
    7642:	4d 39 c1             	cmp    %r8,%r9
    7645:	0f 84 44 01 00 00    	je     778f <jmpmultest_jellydonut>
    764b:	4d 39 c1             	cmp    %r8,%r9
    764e:	0f 84 3b 01 00 00    	je     778f <jmpmultest_jellydonut>
    7654:	4d 39 c1             	cmp    %r8,%r9
    7657:	0f 84 32 01 00 00    	je     778f <jmpmultest_jellydonut>
    765d:	4d 39 c1             	cmp    %r8,%r9
    7660:	0f 84 29 01 00 00    	je     778f <jmpmultest_jellydonut>
    7666:	4d 39 c1             	cmp    %r8,%r9
    7669:	0f 84 20 01 00 00    	je     778f <jmpmultest_jellydonut>
    766f:	4d 39 c1             	cmp    %r8,%r9
    7672:	0f 84 17 01 00 00    	je     778f <jmpmultest_jellydonut>
    7678:	4d 39 c1             	cmp    %r8,%r9
    767b:	0f 84 0e 01 00 00    	je     778f <jmpmultest_jellydonut>
    7681:	4d 39 c1             	cmp    %r8,%r9
    7684:	0f 84 05 01 00 00    	je     778f <jmpmultest_jellydonut>
    768a:	4d 39 c1             	cmp    %r8,%r9
    768d:	0f 84 fc 00 00 00    	je     778f <jmpmultest_jellydonut>
    7693:	4d 39 c1             	cmp    %r8,%r9
    7696:	0f 84 f3 00 00 00    	je     778f <jmpmultest_jellydonut>
    769c:	4d 39 c1             	cmp    %r8,%r9
    769f:	0f 84 ea 00 00 00    	je     778f <jmpmultest_jellydonut>
    76a5:	4d 39 c1             	cmp    %r8,%r9
    76a8:	0f 84 e1 00 00 00    	je     778f <jmpmultest_jellydonut>
    76ae:	4d 39 c1             	cmp    %r8,%r9
    76b1:	0f 84 d8 00 00 00    	je     778f <jmpmultest_jellydonut>
    76b7:	4d 39 c1             	cmp    %r8,%r9
    76ba:	0f 84 cf 00 00 00    	je     778f <jmpmultest_jellydonut>
    76c0:	4d 39 c1             	cmp    %r8,%r9
    76c3:	0f 84 c6 00 00 00    	je     778f <jmpmultest_jellydonut>
    76c9:	4c 29 cf             	sub    %r9,%rdi
    76cc:	0f 85 43 ff ff ff    	jne    7615 <ntjmptest_loop>

00000000000076d2 <ntjmptest_jellydonut>:
    76d2:	41 5f                	pop    %r15
    76d4:	41 5e                	pop    %r14
    76d6:	41 5d                	pop    %r13
    76d8:	41 5c                	pop    %r12
    76da:	41 5b                	pop    %r11
    76dc:	41 5a                	pop    %r10
    76de:	41 59                	pop    %r9
    76e0:	41 58                	pop    %r8
    76e2:	5a                   	pop    %rdx
    76e3:	59                   	pop    %rcx
    76e4:	5b                   	pop    %rbx
    76e5:	5e                   	pop    %rsi
    76e6:	c3                   	retq   

00000000000076e7 <jmpmultest>:
    76e7:	56                   	push   %rsi
    76e8:	53                   	push   %rbx
    76e9:	51                   	push   %rcx
    76ea:	52                   	push   %rdx
    76eb:	41 50                	push   %r8
    76ed:	41 51                	push   %r9
    76ef:	41 52                	push   %r10
    76f1:	41 53                	push   %r11
    76f3:	41 54                	push   %r12
    76f5:	41 55                	push   %r13
    76f7:	41 56                	push   %r14
    76f9:	41 57                	push   %r15
    76fb:	49 c7 c0 02 00 00 00 	mov    $0x2,%r8
    7702:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7709:	48 31 db             	xor    %rbx,%rbx
    770c:	48 31 c9             	xor    %rcx,%rcx
    770f:	4d 31 db             	xor    %r11,%r11
    7712:	4d 31 e4             	xor    %r12,%r12
    7715:	4d 31 ed             	xor    %r13,%r13
    7718:	4d 31 f6             	xor    %r14,%r14
    771b:	4d 31 ff             	xor    %r15,%r15
    771e:	48 31 f6             	xor    %rsi,%rsi
    7721:	4d 89 c2             	mov    %r8,%r10
    7724:	4d 89 c3             	mov    %r8,%r11
    7727:	4c 89 c6             	mov    %r8,%rsi
    772a:	4c 89 c0             	mov    %r8,%rax
    772d:	4c 89 c2             	mov    %r8,%rdx

0000000000007730 <jmpmultest_loop>:
    7730:	4d 39 c1             	cmp    %r8,%r9
    7733:	74 5a                	je     778f <jmpmultest_jellydonut>
    7735:	45 0f af d0          	imul   %r8d,%r10d
    7739:	4d 39 c1             	cmp    %r8,%r9
    773c:	74 51                	je     778f <jmpmultest_jellydonut>
    773e:	41 0f af f0          	imul   %r8d,%esi
    7742:	4d 39 c1             	cmp    %r8,%r9
    7745:	74 48                	je     778f <jmpmultest_jellydonut>
    7747:	41 0f af d8          	imul   %r8d,%ebx
    774b:	4d 39 c1             	cmp    %r8,%r9
    774e:	74 3f                	je     778f <jmpmultest_jellydonut>
    7750:	41 0f af d0          	imul   %r8d,%edx
    7754:	4d 39 c1             	cmp    %r8,%r9
    7757:	74 36                	je     778f <jmpmultest_jellydonut>
    7759:	45 0f af d0          	imul   %r8d,%r10d
    775d:	4d 39 c1             	cmp    %r8,%r9
    7760:	74 2d                	je     778f <jmpmultest_jellydonut>
    7762:	41 0f af f0          	imul   %r8d,%esi
    7766:	4d 39 c1             	cmp    %r8,%r9
    7769:	74 24                	je     778f <jmpmultest_jellydonut>
    776b:	41 0f af d8          	imul   %r8d,%ebx
    776f:	4d 39 c1             	cmp    %r8,%r9
    7772:	74 1b                	je     778f <jmpmultest_jellydonut>
    7774:	41 0f af d0          	imul   %r8d,%edx
    7778:	4d 39 c1             	cmp    %r8,%r9
    777b:	74 12                	je     778f <jmpmultest_jellydonut>
    777d:	45 0f af f8          	imul   %r8d,%r15d
    7781:	4d 39 c1             	cmp    %r8,%r9
    7784:	74 09                	je     778f <jmpmultest_jellydonut>
    7786:	45 0f af f0          	imul   %r8d,%r14d
    778a:	4c 29 cf             	sub    %r9,%rdi
    778d:	75 a1                	jne    7730 <jmpmultest_loop>

000000000000778f <jmpmultest_jellydonut>:
    778f:	41 5f                	pop    %r15
    7791:	41 5e                	pop    %r14
    7793:	41 5d                	pop    %r13
    7795:	41 5c                	pop    %r12
    7797:	41 5b                	pop    %r11
    7799:	41 5a                	pop    %r10
    779b:	41 59                	pop    %r9
    779d:	41 58                	pop    %r8
    779f:	5a                   	pop    %rdx
    77a0:	59                   	pop    %rcx
    77a1:	5b                   	pop    %rbx
    77a2:	5e                   	pop    %rsi
    77a3:	c3                   	retq   

00000000000077a4 <addmultest>:
    77a4:	56                   	push   %rsi
    77a5:	53                   	push   %rbx
    77a6:	51                   	push   %rcx
    77a7:	52                   	push   %rdx
    77a8:	41 50                	push   %r8
    77aa:	41 51                	push   %r9
    77ac:	41 52                	push   %r10
    77ae:	41 53                	push   %r11
    77b0:	41 54                	push   %r12
    77b2:	41 55                	push   %r13
    77b4:	41 56                	push   %r14
    77b6:	41 57                	push   %r15
    77b8:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    77bf:	49 c7 c1 28 00 00 00 	mov    $0x28,%r9
    77c6:	48 31 db             	xor    %rbx,%rbx
    77c9:	48 31 c9             	xor    %rcx,%rcx
    77cc:	4d 31 d2             	xor    %r10,%r10
    77cf:	4d 31 db             	xor    %r11,%r11
    77d2:	4d 31 e4             	xor    %r12,%r12
    77d5:	4d 31 ed             	xor    %r13,%r13
    77d8:	4d 31 f6             	xor    %r14,%r14
    77db:	4d 31 ff             	xor    %r15,%r15
    77de:	48 31 f6             	xor    %rsi,%rsi
    77e1:	4d 89 c2             	mov    %r8,%r10
    77e4:	4d 89 c3             	mov    %r8,%r11
    77e7:	4c 89 c6             	mov    %r8,%rsi
    77ea:	4c 89 c0             	mov    %r8,%rax
    77ed:	4c 89 c2             	mov    %r8,%rdx

00000000000077f0 <addmultest_loop>:
    77f0:	4d 01 c7             	add    %r8,%r15
    77f3:	4d 01 c6             	add    %r8,%r14
    77f6:	4d 01 c5             	add    %r8,%r13
    77f9:	4d 01 c4             	add    %r8,%r12
    77fc:	4d 0f af d0          	imul   %r8,%r10
    7800:	4d 01 c7             	add    %r8,%r15
    7803:	4d 01 c6             	add    %r8,%r14
    7806:	4d 01 c5             	add    %r8,%r13
    7809:	4d 01 c4             	add    %r8,%r12
    780c:	49 0f af f0          	imul   %r8,%rsi
    7810:	4d 01 c7             	add    %r8,%r15
    7813:	4d 01 c6             	add    %r8,%r14
    7816:	4d 01 c5             	add    %r8,%r13
    7819:	4d 01 c4             	add    %r8,%r12
    781c:	49 0f af d8          	imul   %r8,%rbx
    7820:	4d 01 c7             	add    %r8,%r15
    7823:	4d 01 c7             	add    %r8,%r15
    7826:	4d 01 c5             	add    %r8,%r13
    7829:	4d 01 c4             	add    %r8,%r12
    782c:	49 0f af d0          	imul   %r8,%rdx
    7830:	4d 01 c7             	add    %r8,%r15
    7833:	4d 01 c6             	add    %r8,%r14
    7836:	4d 01 c5             	add    %r8,%r13
    7839:	4d 01 c4             	add    %r8,%r12
    783c:	4d 0f af d0          	imul   %r8,%r10
    7840:	4d 01 c7             	add    %r8,%r15
    7843:	4d 01 c6             	add    %r8,%r14
    7846:	4d 01 c5             	add    %r8,%r13
    7849:	4d 01 c4             	add    %r8,%r12
    784c:	49 0f af f0          	imul   %r8,%rsi
    7850:	4d 01 c7             	add    %r8,%r15
    7853:	4d 01 c6             	add    %r8,%r14
    7856:	4d 01 c5             	add    %r8,%r13
    7859:	4d 01 c4             	add    %r8,%r12
    785c:	49 0f af d8          	imul   %r8,%rbx
    7860:	4d 01 c7             	add    %r8,%r15
    7863:	4d 01 c5             	add    %r8,%r13
    7866:	4d 01 c4             	add    %r8,%r12
    7869:	49 0f af d0          	imul   %r8,%rdx
    786d:	4c 29 cf             	sub    %r9,%rdi
    7870:	0f 85 7a ff ff ff    	jne    77f0 <addmultest_loop>
    7876:	41 5f                	pop    %r15
    7878:	41 5e                	pop    %r14
    787a:	41 5d                	pop    %r13
    787c:	41 5c                	pop    %r12
    787e:	41 5b                	pop    %r11
    7880:	41 5a                	pop    %r10
    7882:	41 59                	pop    %r9
    7884:	41 58                	pop    %r8
    7886:	5a                   	pop    %rdx
    7887:	59                   	pop    %rcx
    7888:	5b                   	pop    %rbx
    7889:	5e                   	pop    %rsi
    788a:	c3                   	retq   

000000000000788b <add256int>:
    788b:	41 51                	push   %r9
    788d:	41 50                	push   %r8
    788f:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7896:	66 49 0f 6e c9       	movq   %r9,%xmm1
    789b:	c5 fe 6f c8          	vmovdqu %ymm0,%ymm1
    789f:	c5 fe 6f d0          	vmovdqu %ymm0,%ymm2
    78a3:	c5 fe 6f d8          	vmovdqu %ymm0,%ymm3
    78a7:	c5 fe 6f e0          	vmovdqu %ymm0,%ymm4
    78ab:	c5 fe 6f e8          	vmovdqu %ymm0,%ymm5

00000000000078af <add256int_loop>:
    78af:	c5 f5 d4 c8          	vpaddq %ymm0,%ymm1,%ymm1
    78b3:	c5 ed d4 d0          	vpaddq %ymm0,%ymm2,%ymm2
    78b7:	c5 e5 d4 d8          	vpaddq %ymm0,%ymm3,%ymm3
    78bb:	c5 dd d4 e0          	vpaddq %ymm0,%ymm4,%ymm4
    78bf:	c5 d5 d4 e8          	vpaddq %ymm0,%ymm5,%ymm5
    78c3:	c5 f5 d4 c8          	vpaddq %ymm0,%ymm1,%ymm1
    78c7:	c5 ed d4 d0          	vpaddq %ymm0,%ymm2,%ymm2
    78cb:	c5 e5 d4 d8          	vpaddq %ymm0,%ymm3,%ymm3
    78cf:	c5 dd d4 e0          	vpaddq %ymm0,%ymm4,%ymm4
    78d3:	c5 d5 d4 e8          	vpaddq %ymm0,%ymm5,%ymm5
    78d7:	c5 f5 d4 c8          	vpaddq %ymm0,%ymm1,%ymm1
    78db:	c5 ed d4 d0          	vpaddq %ymm0,%ymm2,%ymm2
    78df:	c5 e5 d4 d8          	vpaddq %ymm0,%ymm3,%ymm3
    78e3:	c5 dd d4 e0          	vpaddq %ymm0,%ymm4,%ymm4
    78e7:	c5 d5 d4 e8          	vpaddq %ymm0,%ymm5,%ymm5
    78eb:	c5 f5 d4 c8          	vpaddq %ymm0,%ymm1,%ymm1
    78ef:	c5 ed d4 d0          	vpaddq %ymm0,%ymm2,%ymm2
    78f3:	c5 e5 d4 d8          	vpaddq %ymm0,%ymm3,%ymm3
    78f7:	c5 dd d4 e0          	vpaddq %ymm0,%ymm4,%ymm4
    78fb:	c5 d5 d4 e8          	vpaddq %ymm0,%ymm5,%ymm5
    78ff:	4c 29 cf             	sub    %r9,%rdi
    7902:	75 ab                	jne    78af <add256int_loop>
    7904:	66 48 0f 7e c8       	movq   %xmm1,%rax
    7909:	c5 f8 77             	vzeroupper 
    790c:	41 58                	pop    %r8
    790e:	41 59                	pop    %r9
    7910:	c3                   	retq   

0000000000007911 <mul512int>:
    7911:	41 51                	push   %r9
    7913:	41 50                	push   %r8
    7915:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    791c:	66 49 0f 6e c9       	movq   %r9,%xmm1
    7921:	62 f2 fd 48 59 c1    	vpbroadcastq %xmm1,%zmm0
    7927:	62 f1 fe 48 6f c8    	vmovdqu64 %zmm0,%zmm1
    792d:	62 f1 fe 48 6f d0    	vmovdqu64 %zmm0,%zmm2
    7933:	62 f1 fe 48 6f d8    	vmovdqu64 %zmm0,%zmm3
    7939:	62 f1 fe 48 6f e0    	vmovdqu64 %zmm0,%zmm4
    793f:	62 f1 fe 48 6f e8    	vmovdqu64 %zmm0,%zmm5

0000000000007945 <mul512int_loop>:
    7945:	62 f2 75 48 40 c8    	vpmulld %zmm0,%zmm1,%zmm1
    794b:	62 f2 6d 48 40 d0    	vpmulld %zmm0,%zmm2,%zmm2
    7951:	62 f2 65 48 40 d8    	vpmulld %zmm0,%zmm3,%zmm3
    7957:	62 f2 5d 48 40 e0    	vpmulld %zmm0,%zmm4,%zmm4
    795d:	62 f2 55 48 40 e8    	vpmulld %zmm0,%zmm5,%zmm5
    7963:	62 f2 75 48 40 c8    	vpmulld %zmm0,%zmm1,%zmm1
    7969:	62 f2 6d 48 40 d0    	vpmulld %zmm0,%zmm2,%zmm2
    796f:	62 f2 65 48 40 d8    	vpmulld %zmm0,%zmm3,%zmm3
    7975:	62 f2 5d 48 40 e0    	vpmulld %zmm0,%zmm4,%zmm4
    797b:	62 f2 55 48 40 e8    	vpmulld %zmm0,%zmm5,%zmm5
    7981:	62 f2 75 48 40 c8    	vpmulld %zmm0,%zmm1,%zmm1
    7987:	62 f2 6d 48 40 d0    	vpmulld %zmm0,%zmm2,%zmm2
    798d:	62 f2 65 48 40 d8    	vpmulld %zmm0,%zmm3,%zmm3
    7993:	62 f2 5d 48 40 e0    	vpmulld %zmm0,%zmm4,%zmm4
    7999:	62 f2 55 48 40 e8    	vpmulld %zmm0,%zmm5,%zmm5
    799f:	62 f2 75 48 40 c8    	vpmulld %zmm0,%zmm1,%zmm1
    79a5:	62 f2 6d 48 40 d0    	vpmulld %zmm0,%zmm2,%zmm2
    79ab:	62 f2 65 48 40 d8    	vpmulld %zmm0,%zmm3,%zmm3
    79b1:	62 f2 5d 48 40 e0    	vpmulld %zmm0,%zmm4,%zmm4
    79b7:	62 f2 55 48 40 e8    	vpmulld %zmm0,%zmm5,%zmm5
    79bd:	4c 29 cf             	sub    %r9,%rdi
    79c0:	75 83                	jne    7945 <mul512int_loop>
    79c2:	66 48 0f 7e c8       	movq   %xmm1,%rax
    79c7:	c5 f8 77             	vzeroupper 
    79ca:	41 58                	pop    %r8
    79cc:	41 59                	pop    %r9
    79ce:	c3                   	retq   

00000000000079cf <muldq512int>:
    79cf:	41 51                	push   %r9
    79d1:	41 50                	push   %r8
    79d3:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    79da:	66 49 0f 6e c9       	movq   %r9,%xmm1
    79df:	62 f2 fd 48 59 c1    	vpbroadcastq %xmm1,%zmm0
    79e5:	62 f1 fe 48 6f c8    	vmovdqu64 %zmm0,%zmm1
    79eb:	62 f1 fe 48 6f d0    	vmovdqu64 %zmm0,%zmm2
    79f1:	62 f1 fe 48 6f d8    	vmovdqu64 %zmm0,%zmm3
    79f7:	62 f1 fe 48 6f e0    	vmovdqu64 %zmm0,%zmm4
    79fd:	62 f1 fe 48 6f e8    	vmovdqu64 %zmm0,%zmm5

0000000000007a03 <muldq512int_loop>:
    7a03:	62 f2 f5 48 28 c8    	vpmuldq %zmm0,%zmm1,%zmm1
    7a09:	62 f2 ed 48 28 d0    	vpmuldq %zmm0,%zmm2,%zmm2
    7a0f:	62 f2 e5 48 28 d8    	vpmuldq %zmm0,%zmm3,%zmm3
    7a15:	62 f2 dd 48 28 e0    	vpmuldq %zmm0,%zmm4,%zmm4
    7a1b:	62 f2 d5 48 28 e8    	vpmuldq %zmm0,%zmm5,%zmm5
    7a21:	62 f2 f5 48 28 c8    	vpmuldq %zmm0,%zmm1,%zmm1
    7a27:	62 f2 ed 48 28 d0    	vpmuldq %zmm0,%zmm2,%zmm2
    7a2d:	62 f2 e5 48 28 d8    	vpmuldq %zmm0,%zmm3,%zmm3
    7a33:	62 f2 dd 48 28 e0    	vpmuldq %zmm0,%zmm4,%zmm4
    7a39:	62 f2 d5 48 28 e8    	vpmuldq %zmm0,%zmm5,%zmm5
    7a3f:	62 f2 f5 48 28 c8    	vpmuldq %zmm0,%zmm1,%zmm1
    7a45:	62 f2 ed 48 28 d0    	vpmuldq %zmm0,%zmm2,%zmm2
    7a4b:	62 f2 e5 48 28 d8    	vpmuldq %zmm0,%zmm3,%zmm3
    7a51:	62 f2 dd 48 28 e0    	vpmuldq %zmm0,%zmm4,%zmm4
    7a57:	62 f2 d5 48 28 e8    	vpmuldq %zmm0,%zmm5,%zmm5
    7a5d:	62 f2 f5 48 28 c8    	vpmuldq %zmm0,%zmm1,%zmm1
    7a63:	62 f2 ed 48 28 d0    	vpmuldq %zmm0,%zmm2,%zmm2
    7a69:	62 f2 e5 48 28 d8    	vpmuldq %zmm0,%zmm3,%zmm3
    7a6f:	62 f2 dd 48 28 e0    	vpmuldq %zmm0,%zmm4,%zmm4
    7a75:	62 f2 d5 48 28 e8    	vpmuldq %zmm0,%zmm5,%zmm5
    7a7b:	4c 29 cf             	sub    %r9,%rdi
    7a7e:	75 83                	jne    7a03 <muldq512int_loop>
    7a80:	66 48 0f 7e c8       	movq   %xmm1,%rax
    7a85:	c5 f8 77             	vzeroupper 
    7a88:	41 58                	pop    %r8
    7a8a:	41 59                	pop    %r9
    7a8c:	c3                   	retq   

0000000000007a8d <add512int>:
    7a8d:	41 51                	push   %r9
    7a8f:	41 50                	push   %r8
    7a91:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7a98:	66 49 0f 6e c9       	movq   %r9,%xmm1
    7a9d:	62 f2 fd 48 59 c1    	vpbroadcastq %xmm1,%zmm0
    7aa3:	62 f1 fe 48 6f c8    	vmovdqu64 %zmm0,%zmm1
    7aa9:	62 f1 fe 48 6f d0    	vmovdqu64 %zmm0,%zmm2
    7aaf:	62 f1 fe 48 6f d8    	vmovdqu64 %zmm0,%zmm3
    7ab5:	62 f1 fe 48 6f e0    	vmovdqu64 %zmm0,%zmm4
    7abb:	62 f1 fe 48 6f e8    	vmovdqu64 %zmm0,%zmm5

0000000000007ac1 <add512int_loop>:
    7ac1:	62 f1 f5 48 d4 c8    	vpaddq %zmm0,%zmm1,%zmm1
    7ac7:	62 f1 ed 48 d4 d0    	vpaddq %zmm0,%zmm2,%zmm2
    7acd:	62 f1 e5 48 d4 d8    	vpaddq %zmm0,%zmm3,%zmm3
    7ad3:	62 f1 dd 48 d4 e0    	vpaddq %zmm0,%zmm4,%zmm4
    7ad9:	62 f1 d5 48 d4 e8    	vpaddq %zmm0,%zmm5,%zmm5
    7adf:	62 f1 f5 48 d4 c8    	vpaddq %zmm0,%zmm1,%zmm1
    7ae5:	62 f1 ed 48 d4 d0    	vpaddq %zmm0,%zmm2,%zmm2
    7aeb:	62 f1 e5 48 d4 d8    	vpaddq %zmm0,%zmm3,%zmm3
    7af1:	62 f1 dd 48 d4 e0    	vpaddq %zmm0,%zmm4,%zmm4
    7af7:	62 f1 d5 48 d4 e8    	vpaddq %zmm0,%zmm5,%zmm5
    7afd:	62 f1 f5 48 d4 c8    	vpaddq %zmm0,%zmm1,%zmm1
    7b03:	62 f1 ed 48 d4 d0    	vpaddq %zmm0,%zmm2,%zmm2
    7b09:	62 f1 e5 48 d4 d8    	vpaddq %zmm0,%zmm3,%zmm3
    7b0f:	62 f1 dd 48 d4 e0    	vpaddq %zmm0,%zmm4,%zmm4
    7b15:	62 f1 d5 48 d4 e8    	vpaddq %zmm0,%zmm5,%zmm5
    7b1b:	62 f1 f5 48 d4 c8    	vpaddq %zmm0,%zmm1,%zmm1
    7b21:	62 f1 ed 48 d4 d0    	vpaddq %zmm0,%zmm2,%zmm2
    7b27:	62 f1 e5 48 d4 d8    	vpaddq %zmm0,%zmm3,%zmm3
    7b2d:	62 f1 dd 48 d4 e0    	vpaddq %zmm0,%zmm4,%zmm4
    7b33:	62 f1 d5 48 d4 e8    	vpaddq %zmm0,%zmm5,%zmm5
    7b39:	4c 29 cf             	sub    %r9,%rdi
    7b3c:	75 83                	jne    7ac1 <add512int_loop>
    7b3e:	66 48 0f 7e c8       	movq   %xmm1,%rax
    7b43:	c5 f8 77             	vzeroupper 
    7b46:	41 58                	pop    %r8
    7b48:	41 59                	pop    %r9
    7b4a:	c3                   	retq   

0000000000007b4b <mixadd256fpint>:
    7b4b:	41 51                	push   %r9
    7b4d:	41 50                	push   %r8
    7b4f:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7b56:	66 49 0f 6e c9       	movq   %r9,%xmm1
    7b5b:	c4 e2 7d 59 c1       	vpbroadcastq %xmm1,%ymm0
    7b60:	c5 fe 6f c8          	vmovdqu %ymm0,%ymm1
    7b64:	c5 fe 6f d0          	vmovdqu %ymm0,%ymm2
    7b68:	c5 fe 6f d8          	vmovdqu %ymm0,%ymm3
    7b6c:	c5 fe 6f e0          	vmovdqu %ymm0,%ymm4
    7b70:	c5 fe 6f e8          	vmovdqu %ymm0,%ymm5
    7b74:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    7b79:	c4 e2 7d 18 f6       	vbroadcastss %xmm6,%ymm6
    7b7e:	c5 fc 10 fe          	vmovups %ymm6,%ymm7
    7b82:	c5 7c 10 c6          	vmovups %ymm6,%ymm8
    7b86:	c5 7c 10 ce          	vmovups %ymm6,%ymm9
    7b8a:	c5 7c 10 d6          	vmovups %ymm6,%ymm10
    7b8e:	c5 7c 10 de          	vmovups %ymm6,%ymm11

0000000000007b92 <mixadd256fpint_loop>:
    7b92:	c5 f5 d4 c8          	vpaddq %ymm0,%ymm1,%ymm1
    7b96:	c5 c4 58 fe          	vaddps %ymm6,%ymm7,%ymm7
    7b9a:	c5 ed d4 d0          	vpaddq %ymm0,%ymm2,%ymm2
    7b9e:	c5 3c 58 c6          	vaddps %ymm6,%ymm8,%ymm8
    7ba2:	c5 e5 d4 d8          	vpaddq %ymm0,%ymm3,%ymm3
    7ba6:	c5 34 58 ce          	vaddps %ymm6,%ymm9,%ymm9
    7baa:	c5 dd d4 e0          	vpaddq %ymm0,%ymm4,%ymm4
    7bae:	c5 2c 58 d6          	vaddps %ymm6,%ymm10,%ymm10
    7bb2:	c5 d5 d4 e8          	vpaddq %ymm0,%ymm5,%ymm5
    7bb6:	c5 24 58 de          	vaddps %ymm6,%ymm11,%ymm11
    7bba:	c5 f5 d4 c8          	vpaddq %ymm0,%ymm1,%ymm1
    7bbe:	c5 c4 58 fe          	vaddps %ymm6,%ymm7,%ymm7
    7bc2:	c5 ed d4 d0          	vpaddq %ymm0,%ymm2,%ymm2
    7bc6:	c5 3c 58 c6          	vaddps %ymm6,%ymm8,%ymm8
    7bca:	c5 e5 d4 d8          	vpaddq %ymm0,%ymm3,%ymm3
    7bce:	c5 34 58 ce          	vaddps %ymm6,%ymm9,%ymm9
    7bd2:	c5 dd d4 e0          	vpaddq %ymm0,%ymm4,%ymm4
    7bd6:	c5 2c 58 d6          	vaddps %ymm6,%ymm10,%ymm10
    7bda:	c5 d5 d4 e8          	vpaddq %ymm0,%ymm5,%ymm5
    7bde:	c5 24 58 de          	vaddps %ymm6,%ymm11,%ymm11
    7be2:	4c 29 cf             	sub    %r9,%rdi
    7be5:	75 ab                	jne    7b92 <mixadd256fpint_loop>
    7be7:	66 48 0f 7e c8       	movq   %xmm1,%rax
    7bec:	c5 f8 77             	vzeroupper 
    7bef:	41 58                	pop    %r8
    7bf1:	41 59                	pop    %r9
    7bf3:	c3                   	retq   

0000000000007bf4 <mix256faddintadd>:
    7bf4:	41 51                	push   %r9
    7bf6:	41 50                	push   %r8
    7bf8:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7bff:	66 49 0f 6e c9       	movq   %r9,%xmm1
    7c04:	c4 62 7d 59 c1       	vpbroadcastq %xmm1,%ymm8
    7c09:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    7c0e:	c4 e2 7d 18 f6       	vbroadcastss %xmm6,%ymm6
    7c13:	c5 fc 10 fe          	vmovups %ymm6,%ymm7
    7c17:	c5 7c 10 ce          	vmovups %ymm6,%ymm9
    7c1b:	c5 7c 10 de          	vmovups %ymm6,%ymm11
    7c1f:	c5 7c 10 ee          	vmovups %ymm6,%ymm13
    7c23:	c5 7c 10 fe          	vmovups %ymm6,%ymm15
    7c27:	c4 41 7e 6f d0       	vmovdqu %ymm8,%ymm10
    7c2c:	c4 41 7e 6f e0       	vmovdqu %ymm8,%ymm12
    7c31:	c4 41 7e 6f f0       	vmovdqu %ymm8,%ymm14

0000000000007c36 <mix256faddintadd_loop>:
    7c36:	c5 c4 58 fe          	vaddps %ymm6,%ymm7,%ymm7
    7c3a:	c4 41 3d fe c0       	vpaddd %ymm8,%ymm8,%ymm8
    7c3f:	c5 34 58 ce          	vaddps %ymm6,%ymm9,%ymm9
    7c43:	c4 41 2d fe d2       	vpaddd %ymm10,%ymm10,%ymm10
    7c48:	c5 24 58 de          	vaddps %ymm6,%ymm11,%ymm11
    7c4c:	c4 41 1d fe e4       	vpaddd %ymm12,%ymm12,%ymm12
    7c51:	c5 14 58 ee          	vaddps %ymm6,%ymm13,%ymm13
    7c55:	c4 41 0d fe f6       	vpaddd %ymm14,%ymm14,%ymm14
    7c5a:	c5 04 58 fe          	vaddps %ymm6,%ymm15,%ymm15
    7c5e:	c5 d5 fe ed          	vpaddd %ymm5,%ymm5,%ymm5
    7c62:	c5 c4 58 fe          	vaddps %ymm6,%ymm7,%ymm7
    7c66:	c4 41 3d fe c0       	vpaddd %ymm8,%ymm8,%ymm8
    7c6b:	c5 34 58 ce          	vaddps %ymm6,%ymm9,%ymm9
    7c6f:	c4 41 2d fe d2       	vpaddd %ymm10,%ymm10,%ymm10
    7c74:	c5 24 58 de          	vaddps %ymm6,%ymm11,%ymm11
    7c78:	c4 41 1d fe e4       	vpaddd %ymm12,%ymm12,%ymm12
    7c7d:	c5 14 58 ee          	vaddps %ymm6,%ymm13,%ymm13
    7c81:	c4 41 0d fe f6       	vpaddd %ymm14,%ymm14,%ymm14
    7c86:	c5 04 58 fe          	vaddps %ymm6,%ymm15,%ymm15
    7c8a:	c5 d5 fe ed          	vpaddd %ymm5,%ymm5,%ymm5
    7c8e:	4c 29 cf             	sub    %r9,%rdi
    7c91:	75 a3                	jne    7c36 <mix256faddintadd_loop>
    7c93:	66 48 0f 7e c8       	movq   %xmm1,%rax
    7c98:	c5 f8 77             	vzeroupper 
    7c9b:	41 58                	pop    %r8
    7c9d:	41 59                	pop    %r9
    7c9f:	c3                   	retq   

0000000000007ca0 <mix256fp>:
    7ca0:	41 51                	push   %r9
    7ca2:	41 50                	push   %r8
    7ca4:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7cab:	66 49 0f 6e c9       	movq   %r9,%xmm1
    7cb0:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    7cb5:	c4 e2 7d 18 f6       	vbroadcastss %xmm6,%ymm6
    7cba:	c5 fc 10 ee          	vmovups %ymm6,%ymm5
    7cbe:	c5 fc 10 fe          	vmovups %ymm6,%ymm7
    7cc2:	c5 7c 10 c6          	vmovups %ymm6,%ymm8
    7cc6:	c5 7c 10 ce          	vmovups %ymm6,%ymm9
    7cca:	c5 7c 10 d6          	vmovups %ymm6,%ymm10
    7cce:	c5 7c 10 de          	vmovups %ymm6,%ymm11
    7cd2:	c5 7c 10 e6          	vmovups %ymm6,%ymm12
    7cd6:	c5 7c 10 ee          	vmovups %ymm6,%ymm13
    7cda:	c5 7c 10 f6          	vmovups %ymm6,%ymm14
    7cde:	c5 7c 10 fe          	vmovups %ymm6,%ymm15

0000000000007ce2 <mix256fp_loop>:
    7ce2:	c5 c4 58 fe          	vaddps %ymm6,%ymm7,%ymm7
    7ce6:	c5 3c 59 c6          	vmulps %ymm6,%ymm8,%ymm8
    7cea:	c5 34 58 ce          	vaddps %ymm6,%ymm9,%ymm9
    7cee:	c5 2c 59 d6          	vmulps %ymm6,%ymm10,%ymm10
    7cf2:	c5 24 58 de          	vaddps %ymm6,%ymm11,%ymm11
    7cf6:	c5 1c 59 e6          	vmulps %ymm6,%ymm12,%ymm12
    7cfa:	c5 14 58 ee          	vaddps %ymm6,%ymm13,%ymm13
    7cfe:	c5 0c 59 f6          	vmulps %ymm6,%ymm14,%ymm14
    7d02:	c5 04 58 fe          	vaddps %ymm6,%ymm15,%ymm15
    7d06:	c5 d4 59 ee          	vmulps %ymm6,%ymm5,%ymm5
    7d0a:	c5 c4 58 fe          	vaddps %ymm6,%ymm7,%ymm7
    7d0e:	c5 3c 59 c6          	vmulps %ymm6,%ymm8,%ymm8
    7d12:	c5 34 58 ce          	vaddps %ymm6,%ymm9,%ymm9
    7d16:	c5 2c 59 d6          	vmulps %ymm6,%ymm10,%ymm10
    7d1a:	c5 24 58 de          	vaddps %ymm6,%ymm11,%ymm11
    7d1e:	c5 1c 59 e6          	vmulps %ymm6,%ymm12,%ymm12
    7d22:	c5 14 58 ee          	vaddps %ymm6,%ymm13,%ymm13
    7d26:	c5 0c 59 f6          	vmulps %ymm6,%ymm14,%ymm14
    7d2a:	c5 04 58 fe          	vaddps %ymm6,%ymm15,%ymm15
    7d2e:	c5 d4 59 ee          	vmulps %ymm6,%ymm5,%ymm5
    7d32:	4c 29 cf             	sub    %r9,%rdi
    7d35:	75 ab                	jne    7ce2 <mix256fp_loop>
    7d37:	66 48 0f 7e c8       	movq   %xmm1,%rax
    7d3c:	c5 f8 77             	vzeroupper 
    7d3f:	41 58                	pop    %r8
    7d41:	41 59                	pop    %r9
    7d43:	c3                   	retq   

0000000000007d44 <mixadd256int>:
    7d44:	41 51                	push   %r9
    7d46:	41 50                	push   %r8
    7d48:	41 57                	push   %r15
    7d4a:	41 56                	push   %r14
    7d4c:	41 55                	push   %r13
    7d4e:	41 54                	push   %r12
    7d50:	41 53                	push   %r11
    7d52:	49 c7 c1 1e 00 00 00 	mov    $0x1e,%r9
    7d59:	66 49 0f 6e c9       	movq   %r9,%xmm1
    7d5e:	c4 e2 7d 59 c1       	vpbroadcastq %xmm1,%ymm0
    7d63:	c5 fe 6f c8          	vmovdqu %ymm0,%ymm1
    7d67:	c5 fe 6f d0          	vmovdqu %ymm0,%ymm2
    7d6b:	c5 fe 6f d8          	vmovdqu %ymm0,%ymm3
    7d6f:	c5 fe 6f e0          	vmovdqu %ymm0,%ymm4
    7d73:	c5 fe 6f e8          	vmovdqu %ymm0,%ymm5
    7d77:	4d 89 cf             	mov    %r9,%r15
    7d7a:	4d 89 ce             	mov    %r9,%r14
    7d7d:	4d 89 cd             	mov    %r9,%r13
    7d80:	4d 89 cc             	mov    %r9,%r12
    7d83:	4d 89 cb             	mov    %r9,%r11
    7d86:	4d 89 c8             	mov    %r9,%r8

0000000000007d89 <mixadd256int_loop>:
    7d89:	4d 01 c3             	add    %r8,%r11
    7d8c:	4d 01 c4             	add    %r8,%r12
    7d8f:	4d 01 c5             	add    %r8,%r13
    7d92:	4d 01 c6             	add    %r8,%r14
    7d95:	4d 01 c7             	add    %r8,%r15
    7d98:	c5 f5 d4 c8          	vpaddq %ymm0,%ymm1,%ymm1
    7d9c:	c5 ed d4 d0          	vpaddq %ymm0,%ymm2,%ymm2
    7da0:	c5 e5 d4 d8          	vpaddq %ymm0,%ymm3,%ymm3
    7da4:	c5 dd d4 e0          	vpaddq %ymm0,%ymm4,%ymm4
    7da8:	c5 d5 d4 e8          	vpaddq %ymm0,%ymm5,%ymm5
    7dac:	4d 01 c3             	add    %r8,%r11
    7daf:	4d 01 c4             	add    %r8,%r12
    7db2:	4d 01 c5             	add    %r8,%r13
    7db5:	4d 01 c6             	add    %r8,%r14
    7db8:	4d 01 c7             	add    %r8,%r15
    7dbb:	4d 01 c3             	add    %r8,%r11
    7dbe:	4d 01 c4             	add    %r8,%r12
    7dc1:	4d 01 c5             	add    %r8,%r13
    7dc4:	4d 01 c6             	add    %r8,%r14
    7dc7:	4d 01 c7             	add    %r8,%r15
    7dca:	c5 f5 d4 c8          	vpaddq %ymm0,%ymm1,%ymm1
    7dce:	c5 ed d4 d0          	vpaddq %ymm0,%ymm2,%ymm2
    7dd2:	c5 e5 d4 d8          	vpaddq %ymm0,%ymm3,%ymm3
    7dd6:	c5 dd d4 e0          	vpaddq %ymm0,%ymm4,%ymm4
    7dda:	c5 d5 d4 e8          	vpaddq %ymm0,%ymm5,%ymm5
    7dde:	4d 01 c3             	add    %r8,%r11
    7de1:	4d 01 c4             	add    %r8,%r12
    7de4:	4d 01 c5             	add    %r8,%r13
    7de7:	4d 01 c6             	add    %r8,%r14
    7dea:	4d 01 c7             	add    %r8,%r15
    7ded:	4c 29 cf             	sub    %r9,%rdi
    7df0:	75 97                	jne    7d89 <mixadd256int_loop>
    7df2:	66 48 0f 7e c8       	movq   %xmm1,%rax
    7df7:	c5 f8 77             	vzeroupper 
    7dfa:	41 5b                	pop    %r11
    7dfc:	41 5c                	pop    %r12
    7dfe:	41 5d                	pop    %r13
    7e00:	41 5e                	pop    %r14
    7e02:	41 5f                	pop    %r15
    7e04:	41 58                	pop    %r8
    7e06:	41 59                	pop    %r9
    7e08:	c3                   	retq   

0000000000007e09 <mixadd256int11>:
    7e09:	41 51                	push   %r9
    7e0b:	41 50                	push   %r8
    7e0d:	41 57                	push   %r15
    7e0f:	41 56                	push   %r14
    7e11:	41 55                	push   %r13
    7e13:	41 54                	push   %r12
    7e15:	41 53                	push   %r11
    7e17:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7e1e:	66 49 0f 6e c9       	movq   %r9,%xmm1
    7e23:	c4 e2 7d 59 c1       	vpbroadcastq %xmm1,%ymm0
    7e28:	c5 fe 6f c8          	vmovdqu %ymm0,%ymm1
    7e2c:	c5 fe 6f d0          	vmovdqu %ymm0,%ymm2
    7e30:	c5 fe 6f d8          	vmovdqu %ymm0,%ymm3
    7e34:	c5 fe 6f e0          	vmovdqu %ymm0,%ymm4
    7e38:	c5 fe 6f e8          	vmovdqu %ymm0,%ymm5
    7e3c:	4d 89 cf             	mov    %r9,%r15
    7e3f:	4d 89 ce             	mov    %r9,%r14
    7e42:	4d 89 cd             	mov    %r9,%r13
    7e45:	4d 89 cc             	mov    %r9,%r12
    7e48:	4d 89 cb             	mov    %r9,%r11
    7e4b:	4d 89 c8             	mov    %r9,%r8

0000000000007e4e <mixadd256int11_loop>:
    7e4e:	4d 01 c3             	add    %r8,%r11
    7e51:	4d 01 c4             	add    %r8,%r12
    7e54:	4d 01 c5             	add    %r8,%r13
    7e57:	4d 01 c6             	add    %r8,%r14
    7e5a:	4d 01 c7             	add    %r8,%r15
    7e5d:	c5 f5 d4 c8          	vpaddq %ymm0,%ymm1,%ymm1
    7e61:	c5 ed d4 d0          	vpaddq %ymm0,%ymm2,%ymm2
    7e65:	c5 e5 d4 d8          	vpaddq %ymm0,%ymm3,%ymm3
    7e69:	c5 dd d4 e0          	vpaddq %ymm0,%ymm4,%ymm4
    7e6d:	c5 d5 d4 e8          	vpaddq %ymm0,%ymm5,%ymm5
    7e71:	4d 01 c3             	add    %r8,%r11
    7e74:	4d 01 c4             	add    %r8,%r12
    7e77:	4d 01 c5             	add    %r8,%r13
    7e7a:	4d 01 c6             	add    %r8,%r14
    7e7d:	4d 01 c7             	add    %r8,%r15
    7e80:	c5 f5 d4 c8          	vpaddq %ymm0,%ymm1,%ymm1
    7e84:	c5 ed d4 d0          	vpaddq %ymm0,%ymm2,%ymm2
    7e88:	c5 e5 d4 d8          	vpaddq %ymm0,%ymm3,%ymm3
    7e8c:	c5 dd d4 e0          	vpaddq %ymm0,%ymm4,%ymm4
    7e90:	c5 d5 d4 e8          	vpaddq %ymm0,%ymm5,%ymm5
    7e94:	4c 29 cf             	sub    %r9,%rdi
    7e97:	75 b5                	jne    7e4e <mixadd256int11_loop>
    7e99:	66 48 0f 7e c8       	movq   %xmm1,%rax
    7e9e:	c5 f8 77             	vzeroupper 
    7ea1:	41 5b                	pop    %r11
    7ea3:	41 5c                	pop    %r12
    7ea5:	41 5d                	pop    %r13
    7ea7:	41 5e                	pop    %r14
    7ea9:	41 5f                	pop    %r15
    7eab:	41 58                	pop    %r8
    7ead:	41 59                	pop    %r9
    7eaf:	c3                   	retq   

0000000000007eb0 <latadd256int>:
    7eb0:	41 51                	push   %r9
    7eb2:	41 50                	push   %r8
    7eb4:	41 57                	push   %r15
    7eb6:	41 56                	push   %r14
    7eb8:	41 55                	push   %r13
    7eba:	41 54                	push   %r12
    7ebc:	41 53                	push   %r11
    7ebe:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7ec5:	66 49 0f 6e c9       	movq   %r9,%xmm1
    7eca:	c4 e2 7d 59 c1       	vpbroadcastq %xmm1,%ymm0
    7ecf:	c5 fe 6f c8          	vmovdqu %ymm0,%ymm1
    7ed3:	c5 fe 6f d0          	vmovdqu %ymm0,%ymm2
    7ed7:	c5 fe 6f d8          	vmovdqu %ymm0,%ymm3
    7edb:	c5 fe 6f e0          	vmovdqu %ymm0,%ymm4
    7edf:	c5 fe 6f e8          	vmovdqu %ymm0,%ymm5

0000000000007ee3 <latadd256int_loop>:
    7ee3:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7ee7:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7eeb:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7eef:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7ef3:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7ef7:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7efb:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7eff:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f03:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f07:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f0b:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f0f:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f13:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f17:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f1b:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f1f:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f23:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f27:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f2b:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f2f:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    7f33:	4c 29 cf             	sub    %r9,%rdi
    7f36:	75 ab                	jne    7ee3 <latadd256int_loop>
    7f38:	66 48 0f 7e c8       	movq   %xmm1,%rax
    7f3d:	c5 f8 77             	vzeroupper 
    7f40:	41 5b                	pop    %r11
    7f42:	41 5c                	pop    %r12
    7f44:	41 5d                	pop    %r13
    7f46:	41 5e                	pop    %r14
    7f48:	41 5f                	pop    %r15
    7f4a:	41 58                	pop    %r8
    7f4c:	41 59                	pop    %r9
    7f4e:	c3                   	retq   

0000000000007f4f <latadd512int>:
    7f4f:	41 51                	push   %r9
    7f51:	41 50                	push   %r8
    7f53:	41 57                	push   %r15
    7f55:	41 56                	push   %r14
    7f57:	41 55                	push   %r13
    7f59:	41 54                	push   %r12
    7f5b:	41 53                	push   %r11
    7f5d:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    7f64:	66 49 0f 6e c9       	movq   %r9,%xmm1
    7f69:	62 f2 fd 48 59 c1    	vpbroadcastq %xmm1,%zmm0
    7f6f:	62 f1 fd 48 6f c8    	vmovdqa64 %zmm0,%zmm1
    7f75:	62 f1 fd 48 6f d0    	vmovdqa64 %zmm0,%zmm2
    7f7b:	62 f1 fd 48 6f d8    	vmovdqa64 %zmm0,%zmm3
    7f81:	62 f1 fd 48 6f e0    	vmovdqa64 %zmm0,%zmm4
    7f87:	62 f1 fd 48 6f e8    	vmovdqa64 %zmm0,%zmm5

0000000000007f8d <latadd51a2int_loop>:
    7f8d:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7f93:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7f99:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7f9f:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fa5:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fab:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fb1:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fb7:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fbd:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fc3:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fc9:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fcf:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fd5:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fdb:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fe1:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fe7:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fed:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7ff3:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7ff9:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    7fff:	62 f1 fd 48 d4 c0    	vpaddq %zmm0,%zmm0,%zmm0
    8005:	4c 29 cf             	sub    %r9,%rdi
    8008:	0f 85 d5 fe ff ff    	jne    7ee3 <latadd256int_loop>
    800e:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8013:	c5 f8 77             	vzeroupper 
    8016:	41 5b                	pop    %r11
    8018:	41 5c                	pop    %r12
    801a:	41 5d                	pop    %r13
    801c:	41 5e                	pop    %r14
    801e:	41 5f                	pop    %r15
    8020:	41 58                	pop    %r8
    8022:	41 59                	pop    %r9
    8024:	c3                   	retq   

0000000000008025 <latmul512int>:
    8025:	41 51                	push   %r9
    8027:	41 50                	push   %r8
    8029:	41 57                	push   %r15
    802b:	41 56                	push   %r14
    802d:	41 55                	push   %r13
    802f:	41 54                	push   %r12
    8031:	41 53                	push   %r11
    8033:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    803a:	66 49 0f 6e c9       	movq   %r9,%xmm1
    803f:	62 f2 7d 48 58 c1    	vpbroadcastd %xmm1,%zmm0
    8045:	62 f1 fe 48 6f c8    	vmovdqu64 %zmm0,%zmm1
    804b:	62 f1 fe 48 6f d0    	vmovdqu64 %zmm0,%zmm2
    8051:	62 f1 fe 48 6f d8    	vmovdqu64 %zmm0,%zmm3
    8057:	62 f1 fe 48 6f e0    	vmovdqu64 %zmm0,%zmm4
    805d:	62 f1 fe 48 6f e8    	vmovdqu64 %zmm0,%zmm5

0000000000008063 <latmul512int_loop>:
    8063:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    8069:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    806f:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    8075:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    807b:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    8081:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    8087:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    808d:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    8093:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    8099:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    809f:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    80a5:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    80ab:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    80b1:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    80b7:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    80bd:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    80c3:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    80c9:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    80cf:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    80d5:	62 f2 7d 48 40 c0    	vpmulld %zmm0,%zmm0,%zmm0
    80db:	4c 29 cf             	sub    %r9,%rdi
    80de:	75 83                	jne    8063 <latmul512int_loop>
    80e0:	66 48 0f 7e c8       	movq   %xmm1,%rax
    80e5:	c5 f8 77             	vzeroupper 
    80e8:	41 5b                	pop    %r11
    80ea:	41 5c                	pop    %r12
    80ec:	41 5d                	pop    %r13
    80ee:	41 5e                	pop    %r14
    80f0:	41 5f                	pop    %r15
    80f2:	41 58                	pop    %r8
    80f4:	41 59                	pop    %r9
    80f6:	c3                   	retq   

00000000000080f7 <latmuldq512int>:
    80f7:	41 51                	push   %r9
    80f9:	41 50                	push   %r8
    80fb:	41 57                	push   %r15
    80fd:	41 56                	push   %r14
    80ff:	41 55                	push   %r13
    8101:	41 54                	push   %r12
    8103:	41 53                	push   %r11
    8105:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    810c:	66 49 0f 6e c9       	movq   %r9,%xmm1
    8111:	62 f2 7d 48 58 c1    	vpbroadcastd %xmm1,%zmm0
    8117:	62 f1 fe 48 6f c8    	vmovdqu64 %zmm0,%zmm1
    811d:	62 f1 fe 48 6f d0    	vmovdqu64 %zmm0,%zmm2
    8123:	62 f1 fe 48 6f d8    	vmovdqu64 %zmm0,%zmm3
    8129:	62 f1 fe 48 6f e0    	vmovdqu64 %zmm0,%zmm4
    812f:	62 f1 fe 48 6f e8    	vmovdqu64 %zmm0,%zmm5

0000000000008135 <latmuldq512int_loop>:
    8135:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    813b:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    8141:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    8147:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    814d:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    8153:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    8159:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    815f:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    8165:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    816b:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    8171:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    8177:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    817d:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    8183:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    8189:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    818f:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    8195:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    819b:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    81a1:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    81a7:	62 f2 fd 48 28 c0    	vpmuldq %zmm0,%zmm0,%zmm0
    81ad:	4c 29 cf             	sub    %r9,%rdi
    81b0:	75 83                	jne    8135 <latmuldq512int_loop>
    81b2:	66 48 0f 7e c8       	movq   %xmm1,%rax
    81b7:	c5 f8 77             	vzeroupper 
    81ba:	41 5b                	pop    %r11
    81bc:	41 5c                	pop    %r12
    81be:	41 5d                	pop    %r13
    81c0:	41 5e                	pop    %r14
    81c2:	41 5f                	pop    %r15
    81c4:	41 58                	pop    %r8
    81c6:	41 59                	pop    %r9
    81c8:	c3                   	retq   

00000000000081c9 <latmulq512int>:
    81c9:	41 51                	push   %r9
    81cb:	41 50                	push   %r8
    81cd:	41 57                	push   %r15
    81cf:	41 56                	push   %r14
    81d1:	41 55                	push   %r13
    81d3:	41 54                	push   %r12
    81d5:	41 53                	push   %r11
    81d7:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    81de:	66 49 0f 6e c9       	movq   %r9,%xmm1
    81e3:	62 f2 7d 48 58 c1    	vpbroadcastd %xmm1,%zmm0
    81e9:	62 f1 fe 48 6f c8    	vmovdqu64 %zmm0,%zmm1
    81ef:	62 f1 fe 48 6f d0    	vmovdqu64 %zmm0,%zmm2
    81f5:	62 f1 fe 48 6f d8    	vmovdqu64 %zmm0,%zmm3
    81fb:	62 f1 fe 48 6f e0    	vmovdqu64 %zmm0,%zmm4
    8201:	62 f1 fe 48 6f e8    	vmovdqu64 %zmm0,%zmm5

0000000000008207 <latmulq512int_loop>:
    8207:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    820d:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8213:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8219:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    821f:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8225:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    822b:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8231:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8237:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    823d:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8243:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8249:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    824f:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8255:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    825b:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8261:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8267:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    826d:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8273:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    8279:	62 f2 fd 48 40 c0    	vpmullq %zmm0,%zmm0,%zmm0
    827f:	4c 29 cf             	sub    %r9,%rdi
    8282:	75 83                	jne    8207 <latmulq512int_loop>
    8284:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8289:	c5 f8 77             	vzeroupper 
    828c:	41 5b                	pop    %r11
    828e:	41 5c                	pop    %r12
    8290:	41 5d                	pop    %r13
    8292:	41 5e                	pop    %r14
    8294:	41 5f                	pop    %r15
    8296:	41 58                	pop    %r8
    8298:	41 59                	pop    %r9
    829a:	c3                   	retq   

000000000000829b <latmul256int>:
    829b:	41 51                	push   %r9
    829d:	41 50                	push   %r8
    829f:	41 57                	push   %r15
    82a1:	41 56                	push   %r14
    82a3:	41 55                	push   %r13
    82a5:	41 54                	push   %r12
    82a7:	41 53                	push   %r11
    82a9:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    82b0:	66 49 0f 6e c9       	movq   %r9,%xmm1
    82b5:	c5 fe 6f c8          	vmovdqu %ymm0,%ymm1
    82b9:	c5 fe 6f d0          	vmovdqu %ymm0,%ymm2
    82bd:	c5 fe 6f d8          	vmovdqu %ymm0,%ymm3
    82c1:	c5 fe 6f e0          	vmovdqu %ymm0,%ymm4
    82c5:	c5 fe 6f e8          	vmovdqu %ymm0,%ymm5

00000000000082c9 <latmul256int_loop>:
    82c9:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    82ce:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    82d3:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    82d8:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    82dd:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    82e2:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    82e7:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    82ec:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    82f1:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    82f6:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    82fb:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    8300:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    8305:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    830a:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    830f:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    8314:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    8319:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    831e:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    8323:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    8328:	c4 e2 7d 40 c0       	vpmulld %ymm0,%ymm0,%ymm0
    832d:	4c 29 cf             	sub    %r9,%rdi
    8330:	75 97                	jne    82c9 <latmul256int_loop>
    8332:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8337:	c5 f8 77             	vzeroupper 
    833a:	41 5b                	pop    %r11
    833c:	41 5c                	pop    %r12
    833e:	41 5d                	pop    %r13
    8340:	41 5e                	pop    %r14
    8342:	41 5f                	pop    %r15
    8344:	41 58                	pop    %r8
    8346:	41 59                	pop    %r9
    8348:	c3                   	retq   

0000000000008349 <latadd128int>:
    8349:	41 51                	push   %r9
    834b:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    8352:	66 49 0f 6e c9       	movq   %r9,%xmm1

0000000000008357 <latadd128int_loop>:
    8357:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    835b:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    835f:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    8363:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    8367:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    836b:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    836f:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    8373:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    8377:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    837b:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    837f:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    8383:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    8387:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    838b:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    838f:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    8393:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    8397:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    839b:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    839f:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    83a3:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    83a7:	4c 29 cf             	sub    %r9,%rdi
    83aa:	75 ab                	jne    8357 <latadd128int_loop>
    83ac:	66 48 0f 7e c8       	movq   %xmm1,%rax
    83b1:	41 59                	pop    %r9
    83b3:	c3                   	retq   

00000000000083b4 <add128int>:
    83b4:	41 51                	push   %r9
    83b6:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    83bd:	66 49 0f 6e c9       	movq   %r9,%xmm1

00000000000083c2 <add128int_loop>:
    83c2:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    83c6:	66 0f d4 c9          	paddq  %xmm1,%xmm1
    83ca:	66 0f d4 d2          	paddq  %xmm2,%xmm2
    83ce:	66 0f d4 db          	paddq  %xmm3,%xmm3
    83d2:	66 0f d4 e4          	paddq  %xmm4,%xmm4
    83d6:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    83da:	66 0f d4 c9          	paddq  %xmm1,%xmm1
    83de:	66 0f d4 d2          	paddq  %xmm2,%xmm2
    83e2:	66 0f d4 db          	paddq  %xmm3,%xmm3
    83e6:	66 0f d4 e4          	paddq  %xmm4,%xmm4
    83ea:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    83ee:	66 0f d4 c9          	paddq  %xmm1,%xmm1
    83f2:	66 0f d4 d2          	paddq  %xmm2,%xmm2
    83f6:	66 0f d4 db          	paddq  %xmm3,%xmm3
    83fa:	66 0f d4 e4          	paddq  %xmm4,%xmm4
    83fe:	66 0f d4 c0          	paddq  %xmm0,%xmm0
    8402:	66 0f d4 c9          	paddq  %xmm1,%xmm1
    8406:	66 0f d4 d2          	paddq  %xmm2,%xmm2
    840a:	66 0f d4 db          	paddq  %xmm3,%xmm3
    840e:	66 0f d4 e4          	paddq  %xmm4,%xmm4
    8412:	4c 29 cf             	sub    %r9,%rdi
    8415:	75 ab                	jne    83c2 <add128int_loop>
    8417:	66 48 0f 7e c8       	movq   %xmm1,%rax
    841c:	41 59                	pop    %r9
    841e:	c3                   	retq   

000000000000841f <aesenc128>:
    841f:	41 51                	push   %r9
    8421:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    8428:	66 49 0f 6e c9       	movq   %r9,%xmm1
    842d:	c5 fc 77             	vzeroall 
    8430:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8434:	66 0f ef c9          	pxor   %xmm1,%xmm1
    8438:	66 0f ef d2          	pxor   %xmm2,%xmm2
    843c:	66 0f ef db          	pxor   %xmm3,%xmm3
    8440:	66 0f ef e4          	pxor   %xmm4,%xmm4
    8444:	66 0f ef ed          	pxor   %xmm5,%xmm5

0000000000008448 <aesenc128_loop>:
    8448:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    844d:	66 0f 38 dc d0       	aesenc %xmm0,%xmm2
    8452:	66 0f 38 dc d8       	aesenc %xmm0,%xmm3
    8457:	66 0f 38 dc e0       	aesenc %xmm0,%xmm4
    845c:	66 0f 38 dc e8       	aesenc %xmm0,%xmm5
    8461:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    8466:	66 0f 38 dc d0       	aesenc %xmm0,%xmm2
    846b:	66 0f 38 dc d8       	aesenc %xmm0,%xmm3
    8470:	66 0f 38 dc e0       	aesenc %xmm0,%xmm4
    8475:	66 0f 38 dc e8       	aesenc %xmm0,%xmm5
    847a:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    847f:	66 0f 38 dc d0       	aesenc %xmm0,%xmm2
    8484:	66 0f 38 dc d8       	aesenc %xmm0,%xmm3
    8489:	66 0f 38 dc e0       	aesenc %xmm0,%xmm4
    848e:	66 0f 38 dc e8       	aesenc %xmm0,%xmm5
    8493:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    8498:	66 0f 38 dc d0       	aesenc %xmm0,%xmm2
    849d:	66 0f 38 dc d8       	aesenc %xmm0,%xmm3
    84a2:	66 0f 38 dc e0       	aesenc %xmm0,%xmm4
    84a7:	66 0f 38 dc e8       	aesenc %xmm0,%xmm5
    84ac:	4c 29 cf             	sub    %r9,%rdi
    84af:	75 97                	jne    8448 <aesenc128_loop>
    84b1:	66 48 0f 7e c8       	movq   %xmm1,%rax
    84b6:	41 59                	pop    %r9
    84b8:	c3                   	retq   

00000000000084b9 <aesencadd128>:
    84b9:	41 51                	push   %r9
    84bb:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    84c2:	66 49 0f 6e c9       	movq   %r9,%xmm1
    84c7:	c5 fc 77             	vzeroall 
    84ca:	66 0f ef c0          	pxor   %xmm0,%xmm0
    84ce:	66 0f ef c9          	pxor   %xmm1,%xmm1
    84d2:	66 0f ef d2          	pxor   %xmm2,%xmm2
    84d6:	66 0f ef db          	pxor   %xmm3,%xmm3
    84da:	66 0f ef e4          	pxor   %xmm4,%xmm4
    84de:	66 0f ef ed          	pxor   %xmm5,%xmm5
    84e2:	66 0f ef f6          	pxor   %xmm6,%xmm6
    84e6:	66 0f ef ff          	pxor   %xmm7,%xmm7
    84ea:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    84ef:	66 45 0f ef c9       	pxor   %xmm9,%xmm9
    84f4:	66 45 0f ef d2       	pxor   %xmm10,%xmm10
    84f9:	66 45 0f ef db       	pxor   %xmm11,%xmm11
    84fe:	66 45 0f ef e4       	pxor   %xmm12,%xmm12
    8503:	66 45 0f ef ed       	pxor   %xmm13,%xmm13

0000000000008508 <aesencadd128_loop>:
    8508:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    850d:	66 0f fe d6          	paddd  %xmm6,%xmm2
    8511:	66 0f fe de          	paddd  %xmm6,%xmm3
    8515:	66 0f fe e6          	paddd  %xmm6,%xmm4
    8519:	66 0f 38 dc e8       	aesenc %xmm0,%xmm5
    851e:	66 0f fe fe          	paddd  %xmm6,%xmm7
    8522:	66 44 0f fe c6       	paddd  %xmm6,%xmm8
    8527:	66 44 0f fe ce       	paddd  %xmm6,%xmm9
    852c:	66 44 0f 38 dc d0    	aesenc %xmm0,%xmm10
    8532:	66 0f fe d6          	paddd  %xmm6,%xmm2
    8536:	66 0f fe de          	paddd  %xmm6,%xmm3
    853a:	66 0f fe e6          	paddd  %xmm6,%xmm4
    853e:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    8543:	66 0f fe fe          	paddd  %xmm6,%xmm7
    8547:	66 44 0f fe c6       	paddd  %xmm6,%xmm8
    854c:	66 44 0f fe ce       	paddd  %xmm6,%xmm9
    8551:	66 44 0f 38 dc d0    	aesenc %xmm0,%xmm10
    8557:	66 44 0f fe de       	paddd  %xmm6,%xmm11
    855c:	66 44 0f fe e6       	paddd  %xmm6,%xmm12
    8561:	66 44 0f fe ee       	paddd  %xmm6,%xmm13
    8566:	4c 29 cf             	sub    %r9,%rdi
    8569:	75 9d                	jne    8508 <aesencadd128_loop>
    856b:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8570:	41 59                	pop    %r9
    8572:	c3                   	retq   

0000000000008573 <aesencfma128>:
    8573:	41 51                	push   %r9
    8575:	49 c7 c1 0f 00 00 00 	mov    $0xf,%r9
    857c:	66 49 0f 6e c9       	movq   %r9,%xmm1
    8581:	c5 fc 77             	vzeroall 
    8584:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8588:	66 0f ef c9          	pxor   %xmm1,%xmm1
    858c:	0f 57 d2             	xorps  %xmm2,%xmm2
    858f:	0f 57 db             	xorps  %xmm3,%xmm3
    8592:	0f 57 e4             	xorps  %xmm4,%xmm4
    8595:	66 0f ef ed          	pxor   %xmm5,%xmm5
    8599:	0f 57 f6             	xorps  %xmm6,%xmm6
    859c:	0f 57 ff             	xorps  %xmm7,%xmm7
    859f:	45 0f 57 c0          	xorps  %xmm8,%xmm8
    85a3:	45 0f 57 c9          	xorps  %xmm9,%xmm9
    85a7:	66 45 0f ef d2       	pxor   %xmm10,%xmm10
    85ac:	45 0f 57 db          	xorps  %xmm11,%xmm11
    85b0:	45 0f 57 e4          	xorps  %xmm12,%xmm12
    85b4:	45 0f 57 ed          	xorps  %xmm13,%xmm13
    85b8:	45 0f 57 f6          	xorps  %xmm14,%xmm14
    85bc:	45 0f 57 ff          	xorps  %xmm15,%xmm15
    85c0:	62 a1 7c 00 57 c0    	vxorps %xmm16,%xmm16,%xmm16
    85c6:	62 a1 74 00 57 c9    	vxorps %xmm17,%xmm17,%xmm17
    85cc:	62 a1 6c 00 57 d2    	vxorps %xmm18,%xmm18,%xmm18
    85d2:	62 a1 64 00 57 db    	vxorps %xmm19,%xmm19,%xmm19

00000000000085d8 <aesencfma128_loop>:
    85d8:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    85dd:	c4 e2 69 98 d6       	vfmadd132ps %xmm6,%xmm2,%xmm2
    85e2:	c4 e2 61 98 de       	vfmadd132ps %xmm6,%xmm3,%xmm3
    85e7:	66 0f 38 dc e8       	aesenc %xmm0,%xmm5
    85ec:	c4 e2 41 98 fe       	vfmadd132ps %xmm6,%xmm7,%xmm7
    85f1:	c4 62 39 98 c6       	vfmadd132ps %xmm6,%xmm8,%xmm8
    85f6:	66 44 0f 38 dc d0    	aesenc %xmm0,%xmm10
    85fc:	c4 62 21 98 de       	vfmadd132ps %xmm6,%xmm11,%xmm11
    8601:	c4 62 19 98 e6       	vfmadd132ps %xmm6,%xmm12,%xmm12
    8606:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    860b:	c4 62 09 98 f6       	vfmadd132ps %xmm6,%xmm14,%xmm14
    8610:	c4 62 01 98 fe       	vfmadd132ps %xmm6,%xmm15,%xmm15
    8615:	66 44 0f 38 dc d0    	aesenc %xmm0,%xmm10
    861b:	62 e2 75 00 98 ce    	vfmadd132ps %xmm6,%xmm17,%xmm17
    8621:	62 e2 6d 00 98 d6    	vfmadd132ps %xmm6,%xmm18,%xmm18
    8627:	4c 29 cf             	sub    %r9,%rdi
    862a:	75 ac                	jne    85d8 <aesencfma128_loop>
    862c:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8631:	41 59                	pop    %r9
    8633:	c3                   	retq   

0000000000008634 <aesencfadd128>:
    8634:	41 51                	push   %r9
    8636:	49 c7 c1 0f 00 00 00 	mov    $0xf,%r9
    863d:	66 49 0f 6e c9       	movq   %r9,%xmm1
    8642:	c5 fc 77             	vzeroall 
    8645:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8649:	66 0f ef c9          	pxor   %xmm1,%xmm1
    864d:	0f 57 d2             	xorps  %xmm2,%xmm2
    8650:	0f 57 db             	xorps  %xmm3,%xmm3
    8653:	0f 57 e4             	xorps  %xmm4,%xmm4
    8656:	66 0f ef ed          	pxor   %xmm5,%xmm5
    865a:	0f 57 f6             	xorps  %xmm6,%xmm6
    865d:	0f 57 ff             	xorps  %xmm7,%xmm7
    8660:	45 0f 57 c0          	xorps  %xmm8,%xmm8
    8664:	45 0f 57 c9          	xorps  %xmm9,%xmm9
    8668:	66 45 0f ef d2       	pxor   %xmm10,%xmm10
    866d:	45 0f 57 db          	xorps  %xmm11,%xmm11
    8671:	45 0f 57 e4          	xorps  %xmm12,%xmm12
    8675:	45 0f 57 ed          	xorps  %xmm13,%xmm13
    8679:	45 0f 57 f6          	xorps  %xmm14,%xmm14
    867d:	45 0f 57 ff          	xorps  %xmm15,%xmm15
    8681:	62 a1 7c 00 57 c0    	vxorps %xmm16,%xmm16,%xmm16
    8687:	62 a1 74 00 57 c9    	vxorps %xmm17,%xmm17,%xmm17
    868d:	62 a1 6c 00 57 d2    	vxorps %xmm18,%xmm18,%xmm18
    8693:	62 a1 64 00 57 db    	vxorps %xmm19,%xmm19,%xmm19

0000000000008699 <aesencfadd128_loop>:
    8699:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    869e:	c5 e8 58 d6          	vaddps %xmm6,%xmm2,%xmm2
    86a2:	c5 e0 58 de          	vaddps %xmm6,%xmm3,%xmm3
    86a6:	66 0f 38 dc e8       	aesenc %xmm0,%xmm5
    86ab:	c5 c0 58 fe          	vaddps %xmm6,%xmm7,%xmm7
    86af:	c5 38 58 c6          	vaddps %xmm6,%xmm8,%xmm8
    86b3:	66 44 0f 38 dc d0    	aesenc %xmm0,%xmm10
    86b9:	c5 20 58 de          	vaddps %xmm6,%xmm11,%xmm11
    86bd:	c5 18 58 e6          	vaddps %xmm6,%xmm12,%xmm12
    86c1:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    86c6:	c5 08 58 f6          	vaddps %xmm6,%xmm14,%xmm14
    86ca:	c5 00 58 fe          	vaddps %xmm6,%xmm15,%xmm15
    86ce:	66 44 0f 38 dc d0    	aesenc %xmm0,%xmm10
    86d4:	62 e1 74 00 58 ce    	vaddps %xmm6,%xmm17,%xmm17
    86da:	62 e1 6c 00 58 d6    	vaddps %xmm6,%xmm18,%xmm18
    86e0:	4c 29 cf             	sub    %r9,%rdi
    86e3:	7f b4                	jg     8699 <aesencfadd128_loop>
    86e5:	66 48 0f 7e c8       	movq   %xmm1,%rax
    86ea:	41 59                	pop    %r9
    86ec:	c3                   	retq   

00000000000086ed <aesencmul128>:
    86ed:	41 51                	push   %r9
    86ef:	49 c7 c1 0f 00 00 00 	mov    $0xf,%r9
    86f6:	c5 fc 77             	vzeroall 
    86f9:	66 49 0f 6e f1       	movq   %r9,%xmm6
    86fe:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8702:	66 0f ef ed          	pxor   %xmm5,%xmm5
    8706:	66 45 0f ef d2       	pxor   %xmm10,%xmm10
    870b:	0f 57 c9             	xorps  %xmm1,%xmm1
    870e:	0f 57 d2             	xorps  %xmm2,%xmm2
    8711:	0f 57 db             	xorps  %xmm3,%xmm3
    8714:	0f 57 e4             	xorps  %xmm4,%xmm4
    8717:	0f 57 ff             	xorps  %xmm7,%xmm7
    871a:	45 0f 57 c0          	xorps  %xmm8,%xmm8
    871e:	45 0f 57 db          	xorps  %xmm11,%xmm11
    8722:	45 0f 57 e4          	xorps  %xmm12,%xmm12
    8726:	45 0f 57 f6          	xorps  %xmm14,%xmm14
    872a:	45 0f 57 ff          	xorps  %xmm15,%xmm15

000000000000872e <aesencmul128_loop>:
    872e:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    8733:	66 0f d5 d6          	pmullw %xmm6,%xmm2
    8737:	66 0f d5 de          	pmullw %xmm6,%xmm3
    873b:	66 0f 38 dc e8       	aesenc %xmm0,%xmm5
    8740:	66 0f d5 fe          	pmullw %xmm6,%xmm7
    8744:	66 44 0f d5 c6       	pmullw %xmm6,%xmm8
    8749:	66 44 0f 38 dc d0    	aesenc %xmm0,%xmm10
    874f:	66 44 0f d5 de       	pmullw %xmm6,%xmm11
    8754:	66 44 0f d5 e6       	pmullw %xmm6,%xmm12
    8759:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    875e:	66 0f d5 e6          	pmullw %xmm6,%xmm4
    8762:	66 0f d5 f6          	pmullw %xmm6,%xmm6
    8766:	66 44 0f 38 dc d0    	aesenc %xmm0,%xmm10
    876c:	66 44 0f d5 ee       	pmullw %xmm6,%xmm13
    8771:	66 44 0f d5 f6       	pmullw %xmm6,%xmm14
    8776:	4c 29 cf             	sub    %r9,%rdi
    8779:	7f b3                	jg     872e <aesencmul128_loop>
    877b:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8780:	41 59                	pop    %r9
    8782:	c3                   	retq   

0000000000008783 <aesdec128>:
    8783:	41 51                	push   %r9
    8785:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    878c:	66 49 0f 6e c9       	movq   %r9,%xmm1
    8791:	c5 fc 77             	vzeroall 
    8794:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8798:	66 0f ef c9          	pxor   %xmm1,%xmm1
    879c:	66 0f ef d2          	pxor   %xmm2,%xmm2
    87a0:	66 0f ef db          	pxor   %xmm3,%xmm3
    87a4:	66 0f ef e4          	pxor   %xmm4,%xmm4
    87a8:	66 0f ef ed          	pxor   %xmm5,%xmm5

00000000000087ac <aesdec128_loop>:
    87ac:	66 0f 38 de c8       	aesdec %xmm0,%xmm1
    87b1:	66 0f 38 de d0       	aesdec %xmm0,%xmm2
    87b6:	66 0f 38 de d8       	aesdec %xmm0,%xmm3
    87bb:	66 0f 38 de e0       	aesdec %xmm0,%xmm4
    87c0:	66 0f 38 de e8       	aesdec %xmm0,%xmm5
    87c5:	66 0f 38 de c8       	aesdec %xmm0,%xmm1
    87ca:	66 0f 38 de d0       	aesdec %xmm0,%xmm2
    87cf:	66 0f 38 de d8       	aesdec %xmm0,%xmm3
    87d4:	66 0f 38 de e0       	aesdec %xmm0,%xmm4
    87d9:	66 0f 38 de e8       	aesdec %xmm0,%xmm5
    87de:	66 0f 38 de c8       	aesdec %xmm0,%xmm1
    87e3:	66 0f 38 de d0       	aesdec %xmm0,%xmm2
    87e8:	66 0f 38 de d8       	aesdec %xmm0,%xmm3
    87ed:	66 0f 38 de e0       	aesdec %xmm0,%xmm4
    87f2:	66 0f 38 de e8       	aesdec %xmm0,%xmm5
    87f7:	66 0f 38 de c8       	aesdec %xmm0,%xmm1
    87fc:	66 0f 38 de d0       	aesdec %xmm0,%xmm2
    8801:	66 0f 38 de d8       	aesdec %xmm0,%xmm3
    8806:	66 0f 38 de e0       	aesdec %xmm0,%xmm4
    880b:	66 0f 38 de e8       	aesdec %xmm0,%xmm5
    8810:	4c 29 cf             	sub    %r9,%rdi
    8813:	75 97                	jne    87ac <aesdec128_loop>
    8815:	66 48 0f 7e c8       	movq   %xmm1,%rax
    881a:	41 59                	pop    %r9
    881c:	c3                   	retq   

000000000000881d <mul128int>:
    881d:	41 51                	push   %r9
    881f:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    8826:	66 49 0f 6e c9       	movq   %r9,%xmm1

000000000000882b <mul128int_loop>:
    882b:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    8830:	66 0f 38 40 c9       	pmulld %xmm1,%xmm1
    8835:	66 0f 38 40 d2       	pmulld %xmm2,%xmm2
    883a:	66 0f 38 40 db       	pmulld %xmm3,%xmm3
    883f:	66 0f 38 40 e4       	pmulld %xmm4,%xmm4
    8844:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    8849:	66 0f 38 40 c9       	pmulld %xmm1,%xmm1
    884e:	66 0f 38 40 d2       	pmulld %xmm2,%xmm2
    8853:	66 0f 38 40 db       	pmulld %xmm3,%xmm3
    8858:	66 0f 38 40 e4       	pmulld %xmm4,%xmm4
    885d:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    8862:	66 0f 38 40 c9       	pmulld %xmm1,%xmm1
    8867:	66 0f 38 40 d2       	pmulld %xmm2,%xmm2
    886c:	66 0f 38 40 db       	pmulld %xmm3,%xmm3
    8871:	66 0f 38 40 e4       	pmulld %xmm4,%xmm4
    8876:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    887b:	66 0f 38 40 c9       	pmulld %xmm1,%xmm1
    8880:	66 0f 38 40 d2       	pmulld %xmm2,%xmm2
    8885:	66 0f 38 40 db       	pmulld %xmm3,%xmm3
    888a:	66 0f 38 40 e4       	pmulld %xmm4,%xmm4
    888f:	4c 29 cf             	sub    %r9,%rdi
    8892:	75 97                	jne    882b <mul128int_loop>
    8894:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8899:	41 59                	pop    %r9
    889b:	c3                   	retq   

000000000000889c <latmul128int>:
    889c:	41 51                	push   %r9
    889e:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    88a5:	66 49 0f 6e c9       	movq   %r9,%xmm1

00000000000088aa <latmul128int_loop>:
    88aa:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88af:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88b4:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88b9:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88be:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88c3:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88c8:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88cd:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88d2:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88d7:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88dc:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88e1:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88e6:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88eb:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88f0:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88f5:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88fa:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    88ff:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    8904:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    8909:	66 0f 38 40 c0       	pmulld %xmm0,%xmm0
    890e:	4c 29 cf             	sub    %r9,%rdi
    8911:	75 97                	jne    88aa <latmul128int_loop>
    8913:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8918:	41 59                	pop    %r9
    891a:	c3                   	retq   

000000000000891b <mixaddmul128int>:
    891b:	41 51                	push   %r9
    891d:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    8924:	66 49 0f 6e c9       	movq   %r9,%xmm1
    8929:	66 0f 6f c8          	movdqa %xmm0,%xmm1
    892d:	66 0f 6f d0          	movdqa %xmm0,%xmm2
    8931:	66 0f 6f d8          	movdqa %xmm0,%xmm3
    8935:	66 0f 6f e0          	movdqa %xmm0,%xmm4
    8939:	66 0f 6f e8          	movdqa %xmm0,%xmm5
    893d:	66 0f 6f f0          	movdqa %xmm0,%xmm6
    8941:	66 0f 6f f8          	movdqa %xmm0,%xmm7
    8945:	66 44 0f 6f c0       	movdqa %xmm0,%xmm8
    894a:	66 44 0f 6f c8       	movdqa %xmm0,%xmm9
    894f:	66 44 0f 6f d0       	movdqa %xmm0,%xmm10

0000000000008954 <mixaddmul128int_loop>:
    8954:	66 0f 38 40 c8       	pmulld %xmm0,%xmm1
    8959:	66 0f fe d0          	paddd  %xmm0,%xmm2
    895d:	66 0f 38 40 d8       	pmulld %xmm0,%xmm3
    8962:	66 0f fe e0          	paddd  %xmm0,%xmm4
    8966:	66 0f 38 40 e8       	pmulld %xmm0,%xmm5
    896b:	66 0f fe f0          	paddd  %xmm0,%xmm6
    896f:	66 0f 38 40 f8       	pmulld %xmm0,%xmm7
    8974:	66 44 0f fe c0       	paddd  %xmm0,%xmm8
    8979:	66 44 0f 38 40 c8    	pmulld %xmm0,%xmm9
    897f:	66 44 0f fe d0       	paddd  %xmm0,%xmm10
    8984:	66 0f 38 40 c8       	pmulld %xmm0,%xmm1
    8989:	66 0f fe d0          	paddd  %xmm0,%xmm2
    898d:	66 0f 38 40 d8       	pmulld %xmm0,%xmm3
    8992:	66 0f fe e0          	paddd  %xmm0,%xmm4
    8996:	66 0f 38 40 e8       	pmulld %xmm0,%xmm5
    899b:	66 0f fe f0          	paddd  %xmm0,%xmm6
    899f:	66 0f 38 40 f8       	pmulld %xmm0,%xmm7
    89a4:	66 44 0f fe c0       	paddd  %xmm0,%xmm8
    89a9:	66 44 0f 38 40 c8    	pmulld %xmm0,%xmm9
    89af:	66 44 0f fe d0       	paddd  %xmm0,%xmm10
    89b4:	4c 29 cf             	sub    %r9,%rdi
    89b7:	75 9b                	jne    8954 <mixaddmul128int_loop>
    89b9:	66 48 0f 7e c8       	movq   %xmm1,%rax
    89be:	41 59                	pop    %r9
    89c0:	c3                   	retq   

00000000000089c1 <latadd256fp>:
    89c1:	41 51                	push   %r9
    89c3:	41 50                	push   %r8
    89c5:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    89cc:	66 49 0f 6e c9       	movq   %r9,%xmm1
    89d1:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    89d6:	c4 e2 7d 18 f6       	vbroadcastss %xmm6,%ymm6

00000000000089db <latadd256fp_loop>:
    89db:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    89df:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    89e3:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    89e7:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    89eb:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    89ef:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    89f3:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    89f7:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    89fb:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    89ff:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    8a03:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    8a07:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    8a0b:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    8a0f:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    8a13:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    8a17:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    8a1b:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    8a1f:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    8a23:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    8a27:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    8a2b:	4c 29 cf             	sub    %r9,%rdi
    8a2e:	75 ab                	jne    89db <latadd256fp_loop>
    8a30:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8a35:	c5 f8 77             	vzeroupper 
    8a38:	41 58                	pop    %r8
    8a3a:	41 59                	pop    %r9
    8a3c:	c3                   	retq   

0000000000008a3d <mul256fp>:
    8a3d:	41 51                	push   %r9
    8a3f:	41 50                	push   %r8
    8a41:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    8a48:	f3 49 0f 2a c1       	cvtsi2ss %r9,%xmm0
    8a4d:	c4 e2 7d 18 f0       	vbroadcastss %xmm0,%ymm6
    8a52:	c5 fd 6f c8          	vmovdqa %ymm0,%ymm1
    8a56:	c5 fd 6f d0          	vmovdqa %ymm0,%ymm2
    8a5a:	c5 fd 6f d8          	vmovdqa %ymm0,%ymm3
    8a5e:	c5 fd 6f e0          	vmovdqa %ymm0,%ymm4
    8a62:	c5 fd 6f e8          	vmovdqa %ymm0,%ymm5
    8a66:	c5 fd 6f f0          	vmovdqa %ymm0,%ymm6
    8a6a:	c5 fd 6f f8          	vmovdqa %ymm0,%ymm7
    8a6e:	c5 7d 6f c0          	vmovdqa %ymm0,%ymm8
    8a72:	c5 7d 6f c8          	vmovdqa %ymm0,%ymm9
    8a76:	c5 7d 6f d0          	vmovdqa %ymm0,%ymm10

0000000000008a7a <mul256fp_loop>:
    8a7a:	c5 f4 59 c8          	vmulps %ymm0,%ymm1,%ymm1
    8a7e:	c5 ec 59 d0          	vmulps %ymm0,%ymm2,%ymm2
    8a82:	c5 e4 59 d8          	vmulps %ymm0,%ymm3,%ymm3
    8a86:	c5 dc 59 e0          	vmulps %ymm0,%ymm4,%ymm4
    8a8a:	c5 d4 59 e8          	vmulps %ymm0,%ymm5,%ymm5
    8a8e:	c5 cc 59 f0          	vmulps %ymm0,%ymm6,%ymm6
    8a92:	c5 c4 59 f8          	vmulps %ymm0,%ymm7,%ymm7
    8a96:	c5 3c 59 c0          	vmulps %ymm0,%ymm8,%ymm8
    8a9a:	c5 34 59 c8          	vmulps %ymm0,%ymm9,%ymm9
    8a9e:	c5 2c 59 d0          	vmulps %ymm0,%ymm10,%ymm10
    8aa2:	c5 f4 59 c8          	vmulps %ymm0,%ymm1,%ymm1
    8aa6:	c5 ec 59 d0          	vmulps %ymm0,%ymm2,%ymm2
    8aaa:	c5 e4 59 d8          	vmulps %ymm0,%ymm3,%ymm3
    8aae:	c5 dc 59 e0          	vmulps %ymm0,%ymm4,%ymm4
    8ab2:	c5 d4 59 e8          	vmulps %ymm0,%ymm5,%ymm5
    8ab6:	c5 cc 59 f0          	vmulps %ymm0,%ymm6,%ymm6
    8aba:	c5 c4 59 f8          	vmulps %ymm0,%ymm7,%ymm7
    8abe:	c5 3c 59 c0          	vmulps %ymm0,%ymm8,%ymm8
    8ac2:	c5 34 59 c8          	vmulps %ymm0,%ymm9,%ymm9
    8ac6:	c5 2c 59 d0          	vmulps %ymm0,%ymm10,%ymm10
    8aca:	4c 29 cf             	sub    %r9,%rdi
    8acd:	75 ab                	jne    8a7a <mul256fp_loop>
    8acf:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8ad4:	c5 f8 77             	vzeroupper 
    8ad7:	41 58                	pop    %r8
    8ad9:	41 59                	pop    %r9
    8adb:	c3                   	retq   

0000000000008adc <add256fp>:
    8adc:	41 51                	push   %r9
    8ade:	41 50                	push   %r8
    8ae0:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    8ae7:	f3 49 0f 2a c1       	cvtsi2ss %r9,%xmm0
    8aec:	c4 e2 7d 18 f0       	vbroadcastss %xmm0,%ymm6
    8af1:	c5 fd 6f c8          	vmovdqa %ymm0,%ymm1
    8af5:	c5 fd 6f d0          	vmovdqa %ymm0,%ymm2
    8af9:	c5 fd 6f d8          	vmovdqa %ymm0,%ymm3
    8afd:	c5 fd 6f e0          	vmovdqa %ymm0,%ymm4
    8b01:	c5 fd 6f e8          	vmovdqa %ymm0,%ymm5
    8b05:	c5 fd 6f f0          	vmovdqa %ymm0,%ymm6
    8b09:	c5 fd 6f f8          	vmovdqa %ymm0,%ymm7
    8b0d:	c5 7d 6f c0          	vmovdqa %ymm0,%ymm8
    8b11:	c5 7d 6f c8          	vmovdqa %ymm0,%ymm9
    8b15:	c5 7d 6f d0          	vmovdqa %ymm0,%ymm10

0000000000008b19 <add256fp_loop>:
    8b19:	c5 f4 58 c8          	vaddps %ymm0,%ymm1,%ymm1
    8b1d:	c5 ec 58 d0          	vaddps %ymm0,%ymm2,%ymm2
    8b21:	c5 e4 58 d8          	vaddps %ymm0,%ymm3,%ymm3
    8b25:	c5 dc 58 e0          	vaddps %ymm0,%ymm4,%ymm4
    8b29:	c5 d4 58 e8          	vaddps %ymm0,%ymm5,%ymm5
    8b2d:	c5 cc 58 f0          	vaddps %ymm0,%ymm6,%ymm6
    8b31:	c5 c4 58 f8          	vaddps %ymm0,%ymm7,%ymm7
    8b35:	c5 3c 58 c0          	vaddps %ymm0,%ymm8,%ymm8
    8b39:	c5 34 58 c8          	vaddps %ymm0,%ymm9,%ymm9
    8b3d:	c5 2c 58 d0          	vaddps %ymm0,%ymm10,%ymm10
    8b41:	c5 f4 58 c8          	vaddps %ymm0,%ymm1,%ymm1
    8b45:	c5 ec 58 d0          	vaddps %ymm0,%ymm2,%ymm2
    8b49:	c5 e4 58 d8          	vaddps %ymm0,%ymm3,%ymm3
    8b4d:	c5 dc 58 e0          	vaddps %ymm0,%ymm4,%ymm4
    8b51:	c5 d4 58 e8          	vaddps %ymm0,%ymm5,%ymm5
    8b55:	c5 cc 58 f0          	vaddps %ymm0,%ymm6,%ymm6
    8b59:	c5 c4 58 f8          	vaddps %ymm0,%ymm7,%ymm7
    8b5d:	c5 3c 58 c0          	vaddps %ymm0,%ymm8,%ymm8
    8b61:	c5 34 58 c8          	vaddps %ymm0,%ymm9,%ymm9
    8b65:	c5 2c 58 d0          	vaddps %ymm0,%ymm10,%ymm10
    8b69:	4c 29 cf             	sub    %r9,%rdi
    8b6c:	75 ab                	jne    8b19 <add256fp_loop>
    8b6e:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8b73:	c5 f8 77             	vzeroupper 
    8b76:	41 58                	pop    %r8
    8b78:	41 59                	pop    %r9
    8b7a:	c3                   	retq   

0000000000008b7b <latmul256fp>:
    8b7b:	41 51                	push   %r9
    8b7d:	41 50                	push   %r8
    8b7f:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    8b86:	66 49 0f 6e c9       	movq   %r9,%xmm1
    8b8b:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    8b90:	c4 e2 7d 18 f6       	vbroadcastss %xmm6,%ymm6

0000000000008b95 <latmul256fp_loop>:
    8b95:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8b99:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8b9d:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8ba1:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8ba5:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8ba9:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bad:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bb1:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bb5:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bb9:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bbd:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bc1:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bc5:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bc9:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bcd:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bd1:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bd5:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bd9:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8bdd:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8be1:	c5 cc 59 f6          	vmulps %ymm6,%ymm6,%ymm6
    8be5:	4c 29 cf             	sub    %r9,%rdi
    8be8:	75 ab                	jne    8b95 <latmul256fp_loop>
    8bea:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8bef:	c5 f8 77             	vzeroupper 
    8bf2:	41 58                	pop    %r8
    8bf4:	41 59                	pop    %r9
    8bf6:	c3                   	retq   

0000000000008bf7 <fma512>:
    8bf7:	41 51                	push   %r9
    8bf9:	41 50                	push   %r8
    8bfb:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    8c02:	66 49 0f 6e c9       	movq   %r9,%xmm1
    8c07:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    8c0c:	62 f2 7d 48 18 f6    	vbroadcastss %xmm6,%zmm6
    8c12:	62 f1 7c 48 10 ee    	vmovups %zmm6,%zmm5
    8c18:	62 f1 7c 48 10 fe    	vmovups %zmm6,%zmm7
    8c1e:	62 71 7c 48 10 c6    	vmovups %zmm6,%zmm8
    8c24:	62 71 7c 48 10 ce    	vmovups %zmm6,%zmm9
    8c2a:	62 71 7c 48 10 d6    	vmovups %zmm6,%zmm10
    8c30:	62 71 7c 48 10 de    	vmovups %zmm6,%zmm11
    8c36:	62 71 7c 48 10 e6    	vmovups %zmm6,%zmm12
    8c3c:	62 71 7c 48 10 ee    	vmovups %zmm6,%zmm13
    8c42:	62 71 7c 48 10 f6    	vmovups %zmm6,%zmm14
    8c48:	62 71 7c 48 10 fe    	vmovups %zmm6,%zmm15

0000000000008c4e <fma512_loop>:
    8c4e:	62 f2 55 48 98 ee    	vfmadd132ps %zmm6,%zmm5,%zmm5
    8c54:	62 f2 45 48 98 fe    	vfmadd132ps %zmm6,%zmm7,%zmm7
    8c5a:	62 72 3d 48 98 c6    	vfmadd132ps %zmm6,%zmm8,%zmm8
    8c60:	62 72 35 48 98 ce    	vfmadd132ps %zmm6,%zmm9,%zmm9
    8c66:	62 72 2d 48 98 d6    	vfmadd132ps %zmm6,%zmm10,%zmm10
    8c6c:	62 72 25 48 98 de    	vfmadd132ps %zmm6,%zmm11,%zmm11
    8c72:	62 72 1d 48 98 e6    	vfmadd132ps %zmm6,%zmm12,%zmm12
    8c78:	62 72 15 48 98 ee    	vfmadd132ps %zmm6,%zmm13,%zmm13
    8c7e:	62 72 0d 48 98 f6    	vfmadd132ps %zmm6,%zmm14,%zmm14
    8c84:	62 72 05 48 98 fe    	vfmadd132ps %zmm6,%zmm15,%zmm15
    8c8a:	62 f2 55 48 98 ee    	vfmadd132ps %zmm6,%zmm5,%zmm5
    8c90:	62 f2 45 48 98 fe    	vfmadd132ps %zmm6,%zmm7,%zmm7
    8c96:	62 72 3d 48 98 c6    	vfmadd132ps %zmm6,%zmm8,%zmm8
    8c9c:	62 72 35 48 98 ce    	vfmadd132ps %zmm6,%zmm9,%zmm9
    8ca2:	62 72 2d 48 98 d6    	vfmadd132ps %zmm6,%zmm10,%zmm10
    8ca8:	62 72 25 48 98 de    	vfmadd132ps %zmm6,%zmm11,%zmm11
    8cae:	62 72 1d 48 98 e6    	vfmadd132ps %zmm6,%zmm12,%zmm12
    8cb4:	62 72 15 48 98 ee    	vfmadd132ps %zmm6,%zmm13,%zmm13
    8cba:	62 72 0d 48 98 f6    	vfmadd132ps %zmm6,%zmm14,%zmm14
    8cc0:	62 72 05 48 98 fe    	vfmadd132ps %zmm6,%zmm15,%zmm15
    8cc6:	4c 29 cf             	sub    %r9,%rdi
    8cc9:	75 83                	jne    8c4e <fma512_loop>
    8ccb:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8cd0:	c5 f8 77             	vzeroupper 
    8cd3:	41 58                	pop    %r8
    8cd5:	41 59                	pop    %r9
    8cd7:	c3                   	retq   

0000000000008cd8 <mixfma256fma512>:
    8cd8:	41 51                	push   %r9
    8cda:	41 50                	push   %r8
    8cdc:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    8ce3:	66 49 0f 6e c9       	movq   %r9,%xmm1
    8ce8:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    8ced:	62 f2 7d 48 18 f6    	vbroadcastss %xmm6,%zmm6
    8cf3:	62 f1 7c 48 10 ee    	vmovups %zmm6,%zmm5
    8cf9:	62 f1 7c 48 10 fe    	vmovups %zmm6,%zmm7
    8cff:	62 71 7c 48 10 c6    	vmovups %zmm6,%zmm8
    8d05:	62 71 7c 48 10 ce    	vmovups %zmm6,%zmm9
    8d0b:	62 71 7c 48 10 d6    	vmovups %zmm6,%zmm10
    8d11:	62 71 7c 48 10 de    	vmovups %zmm6,%zmm11
    8d17:	62 71 7c 48 10 e6    	vmovups %zmm6,%zmm12
    8d1d:	62 71 7c 48 10 ee    	vmovups %zmm6,%zmm13
    8d23:	62 71 7c 48 10 f6    	vmovups %zmm6,%zmm14
    8d29:	62 71 7c 48 10 fe    	vmovups %zmm6,%zmm15

0000000000008d2f <mixfma256fma512_loop>:
    8d2f:	c4 e2 55 98 ee       	vfmadd132ps %ymm6,%ymm5,%ymm5
    8d34:	62 f2 45 48 98 fe    	vfmadd132ps %zmm6,%zmm7,%zmm7
    8d3a:	c4 62 3d 98 c6       	vfmadd132ps %ymm6,%ymm8,%ymm8
    8d3f:	62 72 35 48 98 ce    	vfmadd132ps %zmm6,%zmm9,%zmm9
    8d45:	c4 62 2d 98 d6       	vfmadd132ps %ymm6,%ymm10,%ymm10
    8d4a:	62 72 25 48 98 de    	vfmadd132ps %zmm6,%zmm11,%zmm11
    8d50:	c4 62 1d 98 e6       	vfmadd132ps %ymm6,%ymm12,%ymm12
    8d55:	62 72 15 48 98 ee    	vfmadd132ps %zmm6,%zmm13,%zmm13
    8d5b:	c4 62 0d 98 f6       	vfmadd132ps %ymm6,%ymm14,%ymm14
    8d60:	62 72 05 48 98 fe    	vfmadd132ps %zmm6,%zmm15,%zmm15
    8d66:	c4 e2 55 98 ee       	vfmadd132ps %ymm6,%ymm5,%ymm5
    8d6b:	62 f2 45 48 98 fe    	vfmadd132ps %zmm6,%zmm7,%zmm7
    8d71:	c4 62 3d 98 c6       	vfmadd132ps %ymm6,%ymm8,%ymm8
    8d76:	62 72 35 48 98 ce    	vfmadd132ps %zmm6,%zmm9,%zmm9
    8d7c:	c4 62 2d 98 d6       	vfmadd132ps %ymm6,%ymm10,%ymm10
    8d81:	62 72 25 48 98 de    	vfmadd132ps %zmm6,%zmm11,%zmm11
    8d87:	c4 62 1d 98 e6       	vfmadd132ps %ymm6,%ymm12,%ymm12
    8d8c:	62 72 15 48 98 ee    	vfmadd132ps %zmm6,%zmm13,%zmm13
    8d92:	c4 62 0d 98 f6       	vfmadd132ps %ymm6,%ymm14,%ymm14
    8d97:	62 72 05 48 98 fe    	vfmadd132ps %zmm6,%zmm15,%zmm15
    8d9d:	4c 29 cf             	sub    %r9,%rdi
    8da0:	75 8d                	jne    8d2f <mixfma256fma512_loop>
    8da2:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8da7:	c5 f8 77             	vzeroupper 
    8daa:	41 58                	pop    %r8
    8dac:	41 59                	pop    %r9
    8dae:	c3                   	retq   

0000000000008daf <fma256>:
    8daf:	41 51                	push   %r9
    8db1:	41 50                	push   %r8
    8db3:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    8dba:	66 49 0f 6e c9       	movq   %r9,%xmm1
    8dbf:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    8dc4:	c4 e2 7d 18 f6       	vbroadcastss %xmm6,%ymm6
    8dc9:	c5 fc 10 ee          	vmovups %ymm6,%ymm5
    8dcd:	c5 fc 10 fe          	vmovups %ymm6,%ymm7
    8dd1:	c5 7c 10 c6          	vmovups %ymm6,%ymm8
    8dd5:	c5 7c 10 ce          	vmovups %ymm6,%ymm9
    8dd9:	c5 7c 10 d6          	vmovups %ymm6,%ymm10
    8ddd:	c5 7c 10 de          	vmovups %ymm6,%ymm11
    8de1:	c5 7c 10 e6          	vmovups %ymm6,%ymm12
    8de5:	c5 7c 10 ee          	vmovups %ymm6,%ymm13
    8de9:	c5 7c 10 f6          	vmovups %ymm6,%ymm14
    8ded:	c5 7c 10 fe          	vmovups %ymm6,%ymm15

0000000000008df1 <fma256_loop>:
    8df1:	c4 e2 55 98 ee       	vfmadd132ps %ymm6,%ymm5,%ymm5
    8df6:	c4 e2 45 98 fe       	vfmadd132ps %ymm6,%ymm7,%ymm7
    8dfb:	c4 62 3d 98 c6       	vfmadd132ps %ymm6,%ymm8,%ymm8
    8e00:	c4 62 35 98 ce       	vfmadd132ps %ymm6,%ymm9,%ymm9
    8e05:	c4 62 2d 98 d6       	vfmadd132ps %ymm6,%ymm10,%ymm10
    8e0a:	c4 62 25 98 de       	vfmadd132ps %ymm6,%ymm11,%ymm11
    8e0f:	c4 62 1d 98 e6       	vfmadd132ps %ymm6,%ymm12,%ymm12
    8e14:	c4 62 15 98 ee       	vfmadd132ps %ymm6,%ymm13,%ymm13
    8e19:	c4 62 0d 98 f6       	vfmadd132ps %ymm6,%ymm14,%ymm14
    8e1e:	c4 62 05 98 fe       	vfmadd132ps %ymm6,%ymm15,%ymm15
    8e23:	c4 e2 55 98 ee       	vfmadd132ps %ymm6,%ymm5,%ymm5
    8e28:	c4 e2 45 98 fe       	vfmadd132ps %ymm6,%ymm7,%ymm7
    8e2d:	c4 62 3d 98 c6       	vfmadd132ps %ymm6,%ymm8,%ymm8
    8e32:	c4 62 35 98 ce       	vfmadd132ps %ymm6,%ymm9,%ymm9
    8e37:	c4 62 2d 98 d6       	vfmadd132ps %ymm6,%ymm10,%ymm10
    8e3c:	c4 62 25 98 de       	vfmadd132ps %ymm6,%ymm11,%ymm11
    8e41:	c4 62 1d 98 e6       	vfmadd132ps %ymm6,%ymm12,%ymm12
    8e46:	c4 62 15 98 ee       	vfmadd132ps %ymm6,%ymm13,%ymm13
    8e4b:	c4 62 0d 98 f6       	vfmadd132ps %ymm6,%ymm14,%ymm14
    8e50:	c4 62 05 98 fe       	vfmadd132ps %ymm6,%ymm15,%ymm15
    8e55:	4c 29 cf             	sub    %r9,%rdi
    8e58:	75 97                	jne    8df1 <fma256_loop>
    8e5a:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8e5f:	c5 f8 77             	vzeroupper 
    8e62:	41 58                	pop    %r8
    8e64:	41 59                	pop    %r9
    8e66:	c3                   	retq   

0000000000008e67 <fma128>:
    8e67:	41 51                	push   %r9
    8e69:	41 50                	push   %r8
    8e6b:	c5 f8 77             	vzeroupper 
    8e6e:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    8e75:	66 49 0f 6e c9       	movq   %r9,%xmm1
    8e7a:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    8e7f:	c4 e2 79 18 f6       	vbroadcastss %xmm6,%xmm6
    8e84:	c5 f8 10 ee          	vmovups %xmm6,%xmm5
    8e88:	c5 f8 10 fe          	vmovups %xmm6,%xmm7
    8e8c:	c5 78 10 c6          	vmovups %xmm6,%xmm8
    8e90:	c5 78 10 ce          	vmovups %xmm6,%xmm9
    8e94:	c5 78 10 d6          	vmovups %xmm6,%xmm10
    8e98:	c5 78 10 de          	vmovups %xmm6,%xmm11
    8e9c:	c5 78 10 e6          	vmovups %xmm6,%xmm12
    8ea0:	c5 78 10 ee          	vmovups %xmm6,%xmm13
    8ea4:	c5 78 10 f6          	vmovups %xmm6,%xmm14
    8ea8:	c5 78 10 fe          	vmovups %xmm6,%xmm15

0000000000008eac <fma128_loop>:
    8eac:	c4 e2 51 98 ee       	vfmadd132ps %xmm6,%xmm5,%xmm5
    8eb1:	c4 e2 41 98 fe       	vfmadd132ps %xmm6,%xmm7,%xmm7
    8eb6:	c4 62 39 98 c6       	vfmadd132ps %xmm6,%xmm8,%xmm8
    8ebb:	c4 62 31 98 ce       	vfmadd132ps %xmm6,%xmm9,%xmm9
    8ec0:	c4 62 29 98 d6       	vfmadd132ps %xmm6,%xmm10,%xmm10
    8ec5:	c4 62 21 98 de       	vfmadd132ps %xmm6,%xmm11,%xmm11
    8eca:	c4 62 19 98 e6       	vfmadd132ps %xmm6,%xmm12,%xmm12
    8ecf:	c4 62 11 98 ee       	vfmadd132ps %xmm6,%xmm13,%xmm13
    8ed4:	c4 62 09 98 f6       	vfmadd132ps %xmm6,%xmm14,%xmm14
    8ed9:	c4 62 01 98 fe       	vfmadd132ps %xmm6,%xmm15,%xmm15
    8ede:	c4 e2 51 98 ee       	vfmadd132ps %xmm6,%xmm5,%xmm5
    8ee3:	c4 e2 41 98 fe       	vfmadd132ps %xmm6,%xmm7,%xmm7
    8ee8:	c4 62 39 98 c6       	vfmadd132ps %xmm6,%xmm8,%xmm8
    8eed:	c4 62 31 98 ce       	vfmadd132ps %xmm6,%xmm9,%xmm9
    8ef2:	c4 62 29 98 d6       	vfmadd132ps %xmm6,%xmm10,%xmm10
    8ef7:	c4 62 21 98 de       	vfmadd132ps %xmm6,%xmm11,%xmm11
    8efc:	c4 62 19 98 e6       	vfmadd132ps %xmm6,%xmm12,%xmm12
    8f01:	c4 62 11 98 ee       	vfmadd132ps %xmm6,%xmm13,%xmm13
    8f06:	c4 62 09 98 f6       	vfmadd132ps %xmm6,%xmm14,%xmm14
    8f0b:	c4 62 01 98 fe       	vfmadd132ps %xmm6,%xmm15,%xmm15
    8f10:	4c 29 cf             	sub    %r9,%rdi
    8f13:	75 97                	jne    8eac <fma128_loop>
    8f15:	66 48 0f 7e c8       	movq   %xmm1,%rax
    8f1a:	c5 f8 77             	vzeroupper 
    8f1d:	41 58                	pop    %r8
    8f1f:	41 59                	pop    %r9
    8f21:	c3                   	retq   

0000000000008f22 <mixfmafadd256>:
    8f22:	41 51                	push   %r9
    8f24:	41 50                	push   %r8
    8f26:	49 c7 c1 1e 00 00 00 	mov    $0x1e,%r9
    8f2d:	66 49 0f 6e c9       	movq   %r9,%xmm1
    8f32:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    8f37:	c4 e2 7d 18 f6       	vbroadcastss %xmm6,%ymm6
    8f3c:	c5 fc 10 c6          	vmovups %ymm6,%ymm0
    8f40:	c5 fc 10 ce          	vmovups %ymm6,%ymm1
    8f44:	c5 fc 10 d6          	vmovups %ymm6,%ymm2
    8f48:	c5 fc 10 de          	vmovups %ymm6,%ymm3
    8f4c:	c5 fc 10 e6          	vmovups %ymm6,%ymm4
    8f50:	c5 fc 10 ee          	vmovups %ymm6,%ymm5
    8f54:	c5 fc 10 fe          	vmovups %ymm6,%ymm7
    8f58:	c5 7c 10 c6          	vmovups %ymm6,%ymm8
    8f5c:	c5 7c 10 ce          	vmovups %ymm6,%ymm9
    8f60:	c5 7c 10 d6          	vmovups %ymm6,%ymm10
    8f64:	c5 7c 10 de          	vmovups %ymm6,%ymm11
    8f68:	c5 7c 10 e6          	vmovups %ymm6,%ymm12
    8f6c:	c5 7c 10 ee          	vmovups %ymm6,%ymm13
    8f70:	c5 7c 10 f6          	vmovups %ymm6,%ymm14
    8f74:	c5 7c 10 fe          	vmovups %ymm6,%ymm15

0000000000008f78 <mixfmafadd256_loop>:
    8f78:	c4 e2 55 98 ee       	vfmadd132ps %ymm6,%ymm5,%ymm5
    8f7d:	c4 e2 45 98 fe       	vfmadd132ps %ymm6,%ymm7,%ymm7
    8f82:	c4 41 54 58 da       	vaddps %ymm10,%ymm5,%ymm11
    8f87:	c4 62 3d 98 c6       	vfmadd132ps %ymm6,%ymm8,%ymm8
    8f8c:	c4 62 35 98 ce       	vfmadd132ps %ymm6,%ymm9,%ymm9
    8f91:	c4 41 54 58 ec       	vaddps %ymm12,%ymm5,%ymm13
    8f96:	c4 62 0d 98 f6       	vfmadd132ps %ymm6,%ymm14,%ymm14
    8f9b:	c4 62 05 98 fe       	vfmadd132ps %ymm6,%ymm15,%ymm15
    8fa0:	c4 41 4c 58 ec       	vaddps %ymm12,%ymm6,%ymm13
    8fa5:	c4 e2 7d 98 ce       	vfmadd132ps %ymm6,%ymm0,%ymm1
    8faa:	c4 e2 6d 98 de       	vfmadd132ps %ymm6,%ymm2,%ymm3
    8faf:	c5 d4 58 e6          	vaddps %ymm6,%ymm5,%ymm4
    8fb3:	c4 e2 55 98 ee       	vfmadd132ps %ymm6,%ymm5,%ymm5
    8fb8:	c4 e2 45 98 fe       	vfmadd132ps %ymm6,%ymm7,%ymm7
    8fbd:	c4 41 4c 58 da       	vaddps %ymm10,%ymm6,%ymm11
    8fc2:	c4 62 3d 98 c6       	vfmadd132ps %ymm6,%ymm8,%ymm8
    8fc7:	c4 62 35 98 ce       	vfmadd132ps %ymm6,%ymm9,%ymm9
    8fcc:	c4 41 44 58 ec       	vaddps %ymm12,%ymm7,%ymm13
    8fd1:	c4 62 0d 98 f6       	vfmadd132ps %ymm6,%ymm14,%ymm14
    8fd6:	c4 62 05 98 fe       	vfmadd132ps %ymm6,%ymm15,%ymm15
    8fdb:	c4 41 54 58 ec       	vaddps %ymm12,%ymm5,%ymm13
    8fe0:	c4 e2 7d 98 ce       	vfmadd132ps %ymm6,%ymm0,%ymm1
    8fe5:	c4 e2 6d 98 de       	vfmadd132ps %ymm6,%ymm2,%ymm3
    8fea:	c5 d4 58 e6          	vaddps %ymm6,%ymm5,%ymm4
    8fee:	c4 e2 55 98 ee       	vfmadd132ps %ymm6,%ymm5,%ymm5
    8ff3:	c4 e2 45 98 fe       	vfmadd132ps %ymm6,%ymm7,%ymm7
    8ff8:	c4 41 4c 58 da       	vaddps %ymm10,%ymm6,%ymm11
    8ffd:	c4 62 3d 98 c6       	vfmadd132ps %ymm6,%ymm8,%ymm8
    9002:	c4 62 35 98 ce       	vfmadd132ps %ymm6,%ymm9,%ymm9
    9007:	c4 41 54 58 ec       	vaddps %ymm12,%ymm5,%ymm13
    900c:	4c 29 cf             	sub    %r9,%rdi
    900f:	0f 85 63 ff ff ff    	jne    8f78 <mixfmafadd256_loop>
    9015:	66 48 0f 7e c8       	movq   %xmm1,%rax
    901a:	c5 f8 77             	vzeroupper 
    901d:	41 58                	pop    %r8
    901f:	41 59                	pop    %r9
    9021:	c3                   	retq   

0000000000009022 <mixfmaadd512>:
    9022:	41 51                	push   %r9
    9024:	41 50                	push   %r8
    9026:	49 c7 c1 10 00 00 00 	mov    $0x10,%r9
    902d:	66 49 0f 6e c1       	movq   %r9,%xmm0
    9032:	62 f2 fd 48 59 c0    	vpbroadcastq %xmm0,%zmm0
    9038:	f3 49 0f 2a c9       	cvtsi2ss %r9,%xmm1
    903d:	62 f2 7d 48 18 c9    	vbroadcastss %xmm1,%zmm1
    9043:	62 f1 fd 48 6f d8    	vmovdqa64 %zmm0,%zmm3
    9049:	62 f1 fd 48 6f f0    	vmovdqa64 %zmm0,%zmm6
    904f:	62 71 fd 48 6f c8    	vmovdqa64 %zmm0,%zmm9
    9055:	62 71 fd 48 6f e0    	vmovdqa64 %zmm0,%zmm12
    905b:	62 71 fd 48 6f f8    	vmovdqa64 %zmm0,%zmm15
    9061:	62 f1 7c 48 28 d1    	vmovaps %zmm1,%zmm2
    9067:	62 f1 7c 48 28 e1    	vmovaps %zmm1,%zmm4
    906d:	62 f1 7c 48 28 e9    	vmovaps %zmm1,%zmm5
    9073:	62 f1 7c 48 28 f9    	vmovaps %zmm1,%zmm7
    9079:	62 71 7c 48 28 c1    	vmovaps %zmm1,%zmm8
    907f:	62 71 7c 48 28 d1    	vmovaps %zmm1,%zmm10
    9085:	62 71 7c 48 28 d9    	vmovaps %zmm1,%zmm11
    908b:	62 71 7c 48 28 e9    	vmovaps %zmm1,%zmm13
    9091:	62 71 7c 48 28 f1    	vmovaps %zmm1,%zmm14

0000000000009097 <mixfmaadd512_loop>:
    9097:	62 f1 85 48 d4 c0    	vpaddq %zmm0,%zmm15,%zmm0
    909d:	62 f2 75 48 98 c9    	vfmadd132ps %zmm1,%zmm1,%zmm1
    90a3:	62 f2 6d 48 98 d2    	vfmadd132ps %zmm2,%zmm2,%zmm2
    90a9:	62 f1 85 48 d4 db    	vpaddq %zmm3,%zmm15,%zmm3
    90af:	62 f2 5d 48 98 e4    	vfmadd132ps %zmm4,%zmm4,%zmm4
    90b5:	62 f2 55 48 98 ed    	vfmadd132ps %zmm5,%zmm5,%zmm5
    90bb:	62 f1 85 48 d4 f6    	vpaddq %zmm6,%zmm15,%zmm6
    90c1:	62 f2 45 48 98 ff    	vfmadd132ps %zmm7,%zmm7,%zmm7
    90c7:	62 52 3d 48 98 c0    	vfmadd132ps %zmm8,%zmm8,%zmm8
    90cd:	62 51 85 48 d4 c9    	vpaddq %zmm9,%zmm15,%zmm9
    90d3:	62 52 2d 48 98 d2    	vfmadd132ps %zmm10,%zmm10,%zmm10
    90d9:	62 52 25 48 98 db    	vfmadd132ps %zmm11,%zmm11,%zmm11
    90df:	62 51 85 48 d4 e4    	vpaddq %zmm12,%zmm15,%zmm12
    90e5:	62 52 15 48 98 ed    	vfmadd132ps %zmm13,%zmm13,%zmm13
    90eb:	62 52 0d 48 98 f6    	vfmadd132ps %zmm14,%zmm14,%zmm14
    90f1:	4c 29 cf             	sub    %r9,%rdi
    90f4:	7f a1                	jg     9097 <mixfmaadd512_loop>
    90f6:	66 48 0f 7e c8       	movq   %xmm1,%rax
    90fb:	c5 f8 77             	vzeroupper 
    90fe:	41 58                	pop    %r8
    9100:	41 59                	pop    %r9
    9102:	c3                   	retq   

0000000000009103 <mixfma512add256>:
    9103:	41 51                	push   %r9
    9105:	41 50                	push   %r8
    9107:	49 c7 c1 10 00 00 00 	mov    $0x10,%r9
    910e:	66 49 0f 6e c1       	movq   %r9,%xmm0
    9113:	c4 e2 7d 59 c0       	vpbroadcastq %xmm0,%ymm0
    9118:	f3 49 0f 2a c9       	cvtsi2ss %r9,%xmm1
    911d:	62 f2 7d 48 18 c9    	vbroadcastss %xmm1,%zmm1
    9123:	c5 fd 6f d8          	vmovdqa %ymm0,%ymm3
    9127:	c5 fd 6f f0          	vmovdqa %ymm0,%ymm6
    912b:	c5 7d 6f c8          	vmovdqa %ymm0,%ymm9
    912f:	c5 7d 6f e0          	vmovdqa %ymm0,%ymm12
    9133:	c5 7d 6f f8          	vmovdqa %ymm0,%ymm15
    9137:	62 f1 7c 48 28 d1    	vmovaps %zmm1,%zmm2
    913d:	62 f1 7c 48 28 e1    	vmovaps %zmm1,%zmm4
    9143:	62 f1 7c 48 28 e9    	vmovaps %zmm1,%zmm5
    9149:	62 f1 7c 48 28 f9    	vmovaps %zmm1,%zmm7
    914f:	62 71 7c 48 28 c1    	vmovaps %zmm1,%zmm8
    9155:	62 71 7c 48 28 d1    	vmovaps %zmm1,%zmm10
    915b:	62 71 7c 48 28 d9    	vmovaps %zmm1,%zmm11
    9161:	62 71 7c 48 28 e9    	vmovaps %zmm1,%zmm13
    9167:	62 71 7c 48 28 f1    	vmovaps %zmm1,%zmm14

000000000000916d <mixfma512add256_loop>:
    916d:	c5 85 d4 c0          	vpaddq %ymm0,%ymm15,%ymm0
    9171:	62 f2 75 48 98 c9    	vfmadd132ps %zmm1,%zmm1,%zmm1
    9177:	62 f2 6d 48 98 d2    	vfmadd132ps %zmm2,%zmm2,%zmm2
    917d:	c5 85 d4 db          	vpaddq %ymm3,%ymm15,%ymm3
    9181:	62 f2 5d 48 98 e4    	vfmadd132ps %zmm4,%zmm4,%zmm4
    9187:	62 f2 55 48 98 ed    	vfmadd132ps %zmm5,%zmm5,%zmm5
    918d:	c5 85 d4 f6          	vpaddq %ymm6,%ymm15,%ymm6
    9191:	62 f2 45 48 98 ff    	vfmadd132ps %zmm7,%zmm7,%zmm7
    9197:	62 52 3d 48 98 c0    	vfmadd132ps %zmm8,%zmm8,%zmm8
    919d:	c4 41 05 d4 c9       	vpaddq %ymm9,%ymm15,%ymm9
    91a2:	62 52 2d 48 98 d2    	vfmadd132ps %zmm10,%zmm10,%zmm10
    91a8:	62 52 25 48 98 db    	vfmadd132ps %zmm11,%zmm11,%zmm11
    91ae:	c4 41 05 d4 e4       	vpaddq %ymm12,%ymm15,%ymm12
    91b3:	62 52 15 48 98 ed    	vfmadd132ps %zmm13,%zmm13,%zmm13
    91b9:	62 52 0d 48 98 f6    	vfmadd132ps %zmm14,%zmm14,%zmm14
    91bf:	4c 29 cf             	sub    %r9,%rdi
    91c2:	7f a9                	jg     916d <mixfma512add256_loop>
    91c4:	66 48 0f 7e c8       	movq   %xmm1,%rax
    91c9:	c5 f8 77             	vzeroupper 
    91cc:	41 58                	pop    %r8
    91ce:	41 59                	pop    %r9
    91d0:	c3                   	retq   

00000000000091d1 <mixfmaadd256>:
    91d1:	41 51                	push   %r9
    91d3:	41 50                	push   %r8
    91d5:	49 c7 c1 10 00 00 00 	mov    $0x10,%r9
    91dc:	66 49 0f 6e c1       	movq   %r9,%xmm0
    91e1:	c4 e2 7d 59 c0       	vpbroadcastq %xmm0,%ymm0
    91e6:	f3 49 0f 2a c9       	cvtsi2ss %r9,%xmm1
    91eb:	c4 e2 7d 18 c9       	vbroadcastss %xmm1,%ymm1
    91f0:	c5 fd 6f d8          	vmovdqa %ymm0,%ymm3
    91f4:	c5 fd 6f f0          	vmovdqa %ymm0,%ymm6
    91f8:	c5 7d 6f c8          	vmovdqa %ymm0,%ymm9
    91fc:	c5 7d 6f e0          	vmovdqa %ymm0,%ymm12
    9200:	c5 7d 6f f8          	vmovdqa %ymm0,%ymm15
    9204:	c5 fc 28 d1          	vmovaps %ymm1,%ymm2
    9208:	c5 fc 28 e1          	vmovaps %ymm1,%ymm4
    920c:	c5 fc 28 e9          	vmovaps %ymm1,%ymm5
    9210:	c5 fc 28 f9          	vmovaps %ymm1,%ymm7
    9214:	c5 7c 28 c1          	vmovaps %ymm1,%ymm8
    9218:	c5 7c 28 d1          	vmovaps %ymm1,%ymm10
    921c:	c5 7c 28 d9          	vmovaps %ymm1,%ymm11
    9220:	c5 7c 28 e9          	vmovaps %ymm1,%ymm13
    9224:	c5 7c 28 f1          	vmovaps %ymm1,%ymm14

0000000000009228 <mixfmaadd256_loop>:
    9228:	c5 85 d4 c0          	vpaddq %ymm0,%ymm15,%ymm0
    922c:	c4 e2 75 98 c9       	vfmadd132ps %ymm1,%ymm1,%ymm1
    9231:	c4 e2 6d 98 d2       	vfmadd132ps %ymm2,%ymm2,%ymm2
    9236:	c5 85 d4 db          	vpaddq %ymm3,%ymm15,%ymm3
    923a:	c4 e2 5d 98 e4       	vfmadd132ps %ymm4,%ymm4,%ymm4
    923f:	c4 e2 55 98 ed       	vfmadd132ps %ymm5,%ymm5,%ymm5
    9244:	c5 85 d4 f6          	vpaddq %ymm6,%ymm15,%ymm6
    9248:	c4 e2 45 98 ff       	vfmadd132ps %ymm7,%ymm7,%ymm7
    924d:	c4 42 3d 98 c0       	vfmadd132ps %ymm8,%ymm8,%ymm8
    9252:	c4 41 05 d4 c9       	vpaddq %ymm9,%ymm15,%ymm9
    9257:	c4 42 2d 98 d2       	vfmadd132ps %ymm10,%ymm10,%ymm10
    925c:	c4 42 25 98 db       	vfmadd132ps %ymm11,%ymm11,%ymm11
    9261:	c4 41 05 d4 e4       	vpaddq %ymm12,%ymm15,%ymm12
    9266:	c4 42 15 98 ed       	vfmadd132ps %ymm13,%ymm13,%ymm13
    926b:	c4 42 0d 98 f6       	vfmadd132ps %ymm14,%ymm14,%ymm14
    9270:	4c 29 cf             	sub    %r9,%rdi
    9273:	7f b3                	jg     9228 <mixfmaadd256_loop>
    9275:	66 48 0f 7e c8       	movq   %xmm1,%rax
    927a:	c5 f8 77             	vzeroupper 
    927d:	41 58                	pop    %r8
    927f:	41 59                	pop    %r9
    9281:	c3                   	retq   

0000000000009282 <mixfmaand256>:
    9282:	41 51                	push   %r9
    9284:	41 50                	push   %r8
    9286:	49 c7 c1 0f 00 00 00 	mov    $0xf,%r9
    928d:	66 49 0f 6e c1       	movq   %r9,%xmm0
    9292:	c4 e2 7d 59 c0       	vpbroadcastq %xmm0,%ymm0
    9297:	f3 49 0f 2a c9       	cvtsi2ss %r9,%xmm1
    929c:	c4 e2 7d 18 c9       	vbroadcastss %xmm1,%ymm1
    92a1:	c5 fd 6f d8          	vmovdqa %ymm0,%ymm3
    92a5:	c5 fd 6f f0          	vmovdqa %ymm0,%ymm6
    92a9:	c5 7d 6f c8          	vmovdqa %ymm0,%ymm9
    92ad:	c5 7d 6f e0          	vmovdqa %ymm0,%ymm12
    92b1:	c5 7d 6f f8          	vmovdqa %ymm0,%ymm15
    92b5:	c5 fc 28 d1          	vmovaps %ymm1,%ymm2
    92b9:	c5 fc 28 e1          	vmovaps %ymm1,%ymm4
    92bd:	c5 fc 28 e9          	vmovaps %ymm1,%ymm5
    92c1:	c5 fc 28 f9          	vmovaps %ymm1,%ymm7
    92c5:	c5 7c 28 c1          	vmovaps %ymm1,%ymm8
    92c9:	c5 7c 28 d1          	vmovaps %ymm1,%ymm10
    92cd:	c5 7c 28 d9          	vmovaps %ymm1,%ymm11
    92d1:	c5 7c 28 e9          	vmovaps %ymm1,%ymm13
    92d5:	c5 7c 28 f1          	vmovaps %ymm1,%ymm14

00000000000092d9 <mixfmaand256_loop>:
    92d9:	c5 85 db c0          	vpand  %ymm0,%ymm15,%ymm0
    92dd:	c4 e2 75 98 c9       	vfmadd132ps %ymm1,%ymm1,%ymm1
    92e2:	c4 e2 6d 98 d2       	vfmadd132ps %ymm2,%ymm2,%ymm2
    92e7:	c5 85 db db          	vpand  %ymm3,%ymm15,%ymm3
    92eb:	c4 e2 5d 98 e4       	vfmadd132ps %ymm4,%ymm4,%ymm4
    92f0:	c4 e2 55 98 ed       	vfmadd132ps %ymm5,%ymm5,%ymm5
    92f5:	c5 85 db f6          	vpand  %ymm6,%ymm15,%ymm6
    92f9:	c4 e2 45 98 ff       	vfmadd132ps %ymm7,%ymm7,%ymm7
    92fe:	c4 42 3d 98 c0       	vfmadd132ps %ymm8,%ymm8,%ymm8
    9303:	c4 41 05 db c9       	vpand  %ymm9,%ymm15,%ymm9
    9308:	c4 42 2d 98 d2       	vfmadd132ps %ymm10,%ymm10,%ymm10
    930d:	c4 42 25 98 db       	vfmadd132ps %ymm11,%ymm11,%ymm11
    9312:	c4 41 05 db e4       	vpand  %ymm12,%ymm15,%ymm12
    9317:	c4 42 15 98 ed       	vfmadd132ps %ymm13,%ymm13,%ymm13
    931c:	c4 42 0d 98 f6       	vfmadd132ps %ymm14,%ymm14,%ymm14
    9321:	4c 29 cf             	sub    %r9,%rdi
    9324:	7f b3                	jg     92d9 <mixfmaand256_loop>
    9326:	66 48 0f 7e c8       	movq   %xmm1,%rax
    932b:	c5 f8 77             	vzeroupper 
    932e:	41 58                	pop    %r8
    9330:	41 59                	pop    %r9
    9332:	c3                   	retq   

0000000000009333 <mixfmaandmem256>:
    9333:	41 51                	push   %r9
    9335:	41 50                	push   %r8
    9337:	49 c7 c1 16 00 00 00 	mov    $0x16,%r9
    933e:	66 49 0f 6e c1       	movq   %r9,%xmm0
    9343:	c4 e2 7d 59 c0       	vpbroadcastq %xmm0,%ymm0
    9348:	f3 49 0f 2a c9       	cvtsi2ss %r9,%xmm1
    934d:	c4 e2 7d 18 c9       	vbroadcastss %xmm1,%ymm1
    9352:	c5 fd 6f d8          	vmovdqa %ymm0,%ymm3
    9356:	c5 fc 28 f1          	vmovaps %ymm1,%ymm6
    935a:	c5 7c 28 c9          	vmovaps %ymm1,%ymm9
    935e:	c5 7c 28 e1          	vmovaps %ymm1,%ymm12
    9362:	c5 7c 28 f9          	vmovaps %ymm1,%ymm15
    9366:	c5 fc 28 d1          	vmovaps %ymm1,%ymm2
    936a:	c5 fc 28 e1          	vmovaps %ymm1,%ymm4
    936e:	c5 fc 28 e9          	vmovaps %ymm1,%ymm5
    9372:	c5 fc 28 f9          	vmovaps %ymm1,%ymm7
    9376:	c5 7c 28 c1          	vmovaps %ymm1,%ymm8
    937a:	c5 7c 28 d1          	vmovaps %ymm1,%ymm10
    937e:	c5 7c 28 d9          	vmovaps %ymm1,%ymm11
    9382:	c5 7c 28 e9          	vmovaps %ymm1,%ymm13
    9386:	c5 7c 28 f1          	vmovaps %ymm1,%ymm14

000000000000938a <mixfmaandmem256_loop>:
    938a:	c5 fd db c0          	vpand  %ymm0,%ymm0,%ymm0
    938e:	c4 e2 75 98 c9       	vfmadd132ps %ymm1,%ymm1,%ymm1
    9393:	c4 e2 6d 98 16       	vfmadd132ps (%rsi),%ymm2,%ymm2
    9398:	c5 e5 db db          	vpand  %ymm3,%ymm3,%ymm3
    939c:	c4 e2 5d 98 e4       	vfmadd132ps %ymm4,%ymm4,%ymm4
    93a1:	c4 e2 55 98 2e       	vfmadd132ps (%rsi),%ymm5,%ymm5
    93a6:	c5 fd db c0          	vpand  %ymm0,%ymm0,%ymm0
    93aa:	c4 e2 45 98 ff       	vfmadd132ps %ymm7,%ymm7,%ymm7
    93af:	c4 62 3d 98 06       	vfmadd132ps (%rsi),%ymm8,%ymm8
    93b4:	c5 e5 db db          	vpand  %ymm3,%ymm3,%ymm3
    93b8:	c4 42 2d 98 d2       	vfmadd132ps %ymm10,%ymm10,%ymm10
    93bd:	c4 62 25 98 1e       	vfmadd132ps (%rsi),%ymm11,%ymm11
    93c2:	c5 fd db c0          	vpand  %ymm0,%ymm0,%ymm0
    93c6:	c4 42 15 98 ed       	vfmadd132ps %ymm13,%ymm13,%ymm13
    93cb:	c4 62 0d 98 36       	vfmadd132ps (%rsi),%ymm14,%ymm14
    93d0:	c5 e5 db db          	vpand  %ymm3,%ymm3,%ymm3
    93d4:	c4 e2 4d 98 f6       	vfmadd132ps %ymm6,%ymm6,%ymm6
    93d9:	c4 62 35 98 0e       	vfmadd132ps (%rsi),%ymm9,%ymm9
    93de:	c5 fd db c0          	vpand  %ymm0,%ymm0,%ymm0
    93e2:	c4 42 1d 98 e4       	vfmadd132ps %ymm12,%ymm12,%ymm12
    93e7:	c4 62 05 98 3e       	vfmadd132ps (%rsi),%ymm15,%ymm15
    93ec:	4c 29 cf             	sub    %r9,%rdi
    93ef:	7f 99                	jg     938a <mixfmaandmem256_loop>
    93f1:	66 48 0f 7e c8       	movq   %xmm1,%rax
    93f6:	c5 f8 77             	vzeroupper 
    93f9:	41 58                	pop    %r8
    93fb:	41 59                	pop    %r9
    93fd:	c3                   	retq   

00000000000093fe <mixfmaaddmem256>:
    93fe:	41 51                	push   %r9
    9400:	41 50                	push   %r8
    9402:	49 c7 c1 16 00 00 00 	mov    $0x16,%r9
    9409:	66 49 0f 6e c1       	movq   %r9,%xmm0
    940e:	c4 e2 7d 59 c0       	vpbroadcastq %xmm0,%ymm0
    9413:	f3 49 0f 2a c9       	cvtsi2ss %r9,%xmm1
    9418:	c4 e2 7d 18 c9       	vbroadcastss %xmm1,%ymm1
    941d:	c5 fd 6f d8          	vmovdqa %ymm0,%ymm3
    9421:	c5 fc 28 f1          	vmovaps %ymm1,%ymm6
    9425:	c5 7c 28 c9          	vmovaps %ymm1,%ymm9
    9429:	c5 7c 28 e1          	vmovaps %ymm1,%ymm12
    942d:	c5 7c 28 f9          	vmovaps %ymm1,%ymm15
    9431:	c5 fc 28 d1          	vmovaps %ymm1,%ymm2
    9435:	c5 fc 28 e1          	vmovaps %ymm1,%ymm4
    9439:	c5 fc 28 e9          	vmovaps %ymm1,%ymm5
    943d:	c5 fc 28 f9          	vmovaps %ymm1,%ymm7
    9441:	c5 7c 28 c1          	vmovaps %ymm1,%ymm8
    9445:	c5 7c 28 d1          	vmovaps %ymm1,%ymm10
    9449:	c5 7c 28 d9          	vmovaps %ymm1,%ymm11
    944d:	c5 7c 28 e9          	vmovaps %ymm1,%ymm13
    9451:	c5 7c 28 f1          	vmovaps %ymm1,%ymm14

0000000000009455 <mixfmaaddmem256_loop>:
    9455:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    9459:	c4 e2 75 98 c9       	vfmadd132ps %ymm1,%ymm1,%ymm1
    945e:	c4 e2 6d 98 16       	vfmadd132ps (%rsi),%ymm2,%ymm2
    9463:	c5 e5 d4 db          	vpaddq %ymm3,%ymm3,%ymm3
    9467:	c4 e2 5d 98 e4       	vfmadd132ps %ymm4,%ymm4,%ymm4
    946c:	c4 e2 55 98 2e       	vfmadd132ps (%rsi),%ymm5,%ymm5
    9471:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    9475:	c4 e2 45 98 ff       	vfmadd132ps %ymm7,%ymm7,%ymm7
    947a:	c4 62 3d 98 06       	vfmadd132ps (%rsi),%ymm8,%ymm8
    947f:	c5 e5 d4 db          	vpaddq %ymm3,%ymm3,%ymm3
    9483:	c4 42 2d 98 d2       	vfmadd132ps %ymm10,%ymm10,%ymm10
    9488:	c4 62 25 98 1e       	vfmadd132ps (%rsi),%ymm11,%ymm11
    948d:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    9491:	c4 42 15 98 ed       	vfmadd132ps %ymm13,%ymm13,%ymm13
    9496:	c4 62 0d 98 36       	vfmadd132ps (%rsi),%ymm14,%ymm14
    949b:	c5 e5 d4 db          	vpaddq %ymm3,%ymm3,%ymm3
    949f:	c4 e2 4d 98 f6       	vfmadd132ps %ymm6,%ymm6,%ymm6
    94a4:	c4 62 35 98 0e       	vfmadd132ps (%rsi),%ymm9,%ymm9
    94a9:	c5 fd d4 c0          	vpaddq %ymm0,%ymm0,%ymm0
    94ad:	c4 42 1d 98 e4       	vfmadd132ps %ymm12,%ymm12,%ymm12
    94b2:	c4 62 05 98 3e       	vfmadd132ps (%rsi),%ymm15,%ymm15
    94b7:	4c 29 cf             	sub    %r9,%rdi
    94ba:	7f 99                	jg     9455 <mixfmaaddmem256_loop>
    94bc:	66 48 0f 7e c8       	movq   %xmm1,%rax
    94c1:	c5 f8 77             	vzeroupper 
    94c4:	41 58                	pop    %r8
    94c6:	41 59                	pop    %r9
    94c8:	c3                   	retq   

00000000000094c9 <nemesfpu512mix21>:
    94c9:	41 51                	push   %r9
    94cb:	49 c7 c1 10 00 00 00 	mov    $0x10,%r9
    94d2:	f3 49 0f 2a c1       	cvtsi2ss %r9,%xmm0
    94d7:	62 f2 7d 48 18 c8    	vbroadcastss %xmm0,%zmm1
    94dd:	62 f1 fd 48 6f d1    	vmovdqa64 %zmm1,%zmm2
    94e3:	62 f1 fd 48 6f d9    	vmovdqa64 %zmm1,%zmm3
    94e9:	62 f1 fd 48 6f e1    	vmovdqa64 %zmm1,%zmm4
    94ef:	62 f1 fd 48 6f e9    	vmovdqa64 %zmm1,%zmm5
    94f5:	62 f1 fd 48 6f f1    	vmovdqa64 %zmm1,%zmm6
    94fb:	62 f1 fd 48 6f f9    	vmovdqa64 %zmm1,%zmm7
    9501:	62 71 fd 48 6f c1    	vmovdqa64 %zmm1,%zmm8
    9507:	62 71 fd 48 6f c9    	vmovdqa64 %zmm1,%zmm9
    950d:	62 71 fd 48 6f d1    	vmovdqa64 %zmm1,%zmm10
    9513:	62 71 fd 48 6f d9    	vmovdqa64 %zmm1,%zmm11
    9519:	62 71 fd 48 6f e1    	vmovdqa64 %zmm1,%zmm12
    951f:	62 71 fd 48 6f e9    	vmovdqa64 %zmm1,%zmm13
    9525:	62 71 fd 48 6f f1    	vmovdqa64 %zmm1,%zmm14
    952b:	62 71 fd 48 6f f9    	vmovdqa64 %zmm1,%zmm15

0000000000009531 <nemesfpu512mix21_loop>:
    9531:	62 f1 7c 48 58 c0    	vaddps %zmm0,%zmm0,%zmm0
    9537:	62 f2 75 48 98 c9    	vfmadd132ps %zmm1,%zmm1,%zmm1
    953d:	62 f2 6d 48 98 d2    	vfmadd132ps %zmm2,%zmm2,%zmm2
    9543:	62 f1 64 48 58 db    	vaddps %zmm3,%zmm3,%zmm3
    9549:	62 f2 5d 48 98 e4    	vfmadd132ps %zmm4,%zmm4,%zmm4
    954f:	62 f2 55 48 98 ed    	vfmadd132ps %zmm5,%zmm5,%zmm5
    9555:	62 f1 4c 48 58 f6    	vaddps %zmm6,%zmm6,%zmm6
    955b:	62 f2 45 48 98 ff    	vfmadd132ps %zmm7,%zmm7,%zmm7
    9561:	62 52 3d 48 98 c0    	vfmadd132ps %zmm8,%zmm8,%zmm8
    9567:	62 51 34 48 58 c9    	vaddps %zmm9,%zmm9,%zmm9
    956d:	62 52 2d 48 98 d2    	vfmadd132ps %zmm10,%zmm10,%zmm10
    9573:	62 52 25 48 98 db    	vfmadd132ps %zmm11,%zmm11,%zmm11
    9579:	c4 41 1c 58 e4       	vaddps %ymm12,%ymm12,%ymm12
    957e:	62 52 15 48 98 ed    	vfmadd132ps %zmm13,%zmm13,%zmm13
    9584:	62 52 0d 48 98 f6    	vfmadd132ps %zmm14,%zmm14,%zmm14
    958a:	62 51 04 48 58 ff    	vaddps %zmm15,%zmm15,%zmm15
    9590:	4c 29 cf             	sub    %r9,%rdi
    9593:	7f 9c                	jg     9531 <nemesfpu512mix21_loop>
    9595:	41 59                	pop    %r9
    9597:	c3                   	retq   

0000000000009598 <nemesfpumix21>:
    9598:	41 51                	push   %r9
    959a:	49 c7 c1 10 00 00 00 	mov    $0x10,%r9
    95a1:	f3 49 0f 2a c1       	cvtsi2ss %r9,%xmm0
    95a6:	c4 e2 7d 18 c8       	vbroadcastss %xmm0,%ymm1
    95ab:	c5 fd 6f d1          	vmovdqa %ymm1,%ymm2
    95af:	c5 fd 6f d9          	vmovdqa %ymm1,%ymm3
    95b3:	c5 fd 6f e1          	vmovdqa %ymm1,%ymm4
    95b7:	c5 fd 6f e9          	vmovdqa %ymm1,%ymm5
    95bb:	c5 fd 6f f1          	vmovdqa %ymm1,%ymm6
    95bf:	c5 fd 6f f9          	vmovdqa %ymm1,%ymm7
    95c3:	c5 7d 6f c1          	vmovdqa %ymm1,%ymm8
    95c7:	c5 7d 6f c9          	vmovdqa %ymm1,%ymm9
    95cb:	c5 7d 6f d1          	vmovdqa %ymm1,%ymm10
    95cf:	c5 7d 6f d9          	vmovdqa %ymm1,%ymm11
    95d3:	c5 7d 6f e1          	vmovdqa %ymm1,%ymm12
    95d7:	c5 7d 6f e9          	vmovdqa %ymm1,%ymm13
    95db:	c5 7d 6f f1          	vmovdqa %ymm1,%ymm14
    95df:	c5 7d 6f f9          	vmovdqa %ymm1,%ymm15

00000000000095e3 <nemesfpumix21_loop>:
    95e3:	c5 fc 58 c0          	vaddps %ymm0,%ymm0,%ymm0
    95e7:	c4 e2 75 98 c9       	vfmadd132ps %ymm1,%ymm1,%ymm1
    95ec:	c4 e2 6d 98 d2       	vfmadd132ps %ymm2,%ymm2,%ymm2
    95f1:	c5 e4 58 db          	vaddps %ymm3,%ymm3,%ymm3
    95f5:	c4 e2 5d 98 e4       	vfmadd132ps %ymm4,%ymm4,%ymm4
    95fa:	c4 e2 55 98 ed       	vfmadd132ps %ymm5,%ymm5,%ymm5
    95ff:	c5 cc 58 f6          	vaddps %ymm6,%ymm6,%ymm6
    9603:	c4 e2 45 98 ff       	vfmadd132ps %ymm7,%ymm7,%ymm7
    9608:	c4 42 3d 98 c0       	vfmadd132ps %ymm8,%ymm8,%ymm8
    960d:	c4 41 34 58 c9       	vaddps %ymm9,%ymm9,%ymm9
    9612:	c4 42 2d 98 d2       	vfmadd132ps %ymm10,%ymm10,%ymm10
    9617:	c4 42 25 98 db       	vfmadd132ps %ymm11,%ymm11,%ymm11
    961c:	c4 41 1c 58 e4       	vaddps %ymm12,%ymm12,%ymm12
    9621:	c4 42 15 98 ed       	vfmadd132ps %ymm13,%ymm13,%ymm13
    9626:	c4 42 0d 98 f6       	vfmadd132ps %ymm14,%ymm14,%ymm14
    962b:	c4 41 04 58 ff       	vaddps %ymm15,%ymm15,%ymm15
    9630:	4c 29 cf             	sub    %r9,%rdi
    9633:	7f ae                	jg     95e3 <nemesfpumix21_loop>
    9635:	41 59                	pop    %r9
    9637:	c3                   	retq   

0000000000009638 <latfma512>:
    9638:	41 51                	push   %r9
    963a:	41 50                	push   %r8
    963c:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    9643:	66 49 0f 6e c9       	movq   %r9,%xmm1
    9648:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    964d:	62 f2 7d 48 18 f6    	vbroadcastss %xmm6,%zmm6
    9653:	62 f1 7c 48 10 ee    	vmovups %zmm6,%zmm5
    9659:	62 f1 7c 48 10 fe    	vmovups %zmm6,%zmm7
    965f:	62 71 7c 48 10 c6    	vmovups %zmm6,%zmm8
    9665:	62 71 7c 48 10 ce    	vmovups %zmm6,%zmm9
    966b:	62 71 7c 48 10 d6    	vmovups %zmm6,%zmm10
    9671:	62 71 7c 48 10 de    	vmovups %zmm6,%zmm11
    9677:	62 71 7c 48 10 e6    	vmovups %zmm6,%zmm12
    967d:	62 71 7c 48 10 ee    	vmovups %zmm6,%zmm13
    9683:	62 71 7c 48 10 f6    	vmovups %zmm6,%zmm14
    9689:	62 71 7c 48 10 fe    	vmovups %zmm6,%zmm15

000000000000968f <latfma512_loop>:
    968f:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    9695:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    969b:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96a1:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96a7:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96ad:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96b3:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96b9:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96bf:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96c5:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96cb:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96d1:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96d7:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96dd:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96e3:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96e9:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96ef:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96f5:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    96fb:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    9701:	62 f2 55 48 98 fe    	vfmadd132ps %zmm6,%zmm5,%zmm7
    9707:	4c 29 cf             	sub    %r9,%rdi
    970a:	75 83                	jne    968f <latfma512_loop>
    970c:	66 48 0f 7e c8       	movq   %xmm1,%rax
    9711:	c5 f8 77             	vzeroupper 
    9714:	41 58                	pop    %r8
    9716:	41 59                	pop    %r9
    9718:	c3                   	retq   

0000000000009719 <latfma256>:
    9719:	41 51                	push   %r9
    971b:	41 50                	push   %r8
    971d:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    9724:	66 49 0f 6e c9       	movq   %r9,%xmm1
    9729:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    972e:	c4 e2 7d 18 f6       	vbroadcastss %xmm6,%ymm6
    9733:	c5 fc 10 ee          	vmovups %ymm6,%ymm5
    9737:	c5 fc 10 fe          	vmovups %ymm6,%ymm7
    973b:	c5 7c 10 c6          	vmovups %ymm6,%ymm8
    973f:	c5 7c 10 ce          	vmovups %ymm6,%ymm9
    9743:	c5 7c 10 d6          	vmovups %ymm6,%ymm10
    9747:	c5 7c 10 de          	vmovups %ymm6,%ymm11
    974b:	c5 7c 10 e6          	vmovups %ymm6,%ymm12
    974f:	c5 7c 10 ee          	vmovups %ymm6,%ymm13
    9753:	c5 7c 10 f6          	vmovups %ymm6,%ymm14
    9757:	c5 7c 10 fe          	vmovups %ymm6,%ymm15

000000000000975b <latfma256_loop>:
    975b:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    9760:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    9765:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    976a:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    976f:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    9774:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    9779:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    977e:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    9783:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    9788:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    978d:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    9792:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    9797:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    979c:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    97a1:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    97a6:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    97ab:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    97b0:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    97b5:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    97ba:	c4 e2 55 98 fe       	vfmadd132ps %ymm6,%ymm5,%ymm7
    97bf:	4c 29 cf             	sub    %r9,%rdi
    97c2:	75 97                	jne    975b <latfma256_loop>
    97c4:	66 48 0f 7e c8       	movq   %xmm1,%rax
    97c9:	c5 f8 77             	vzeroupper 
    97cc:	41 58                	pop    %r8
    97ce:	41 59                	pop    %r9
    97d0:	c3                   	retq   

00000000000097d1 <latfma128>:
    97d1:	41 51                	push   %r9
    97d3:	41 50                	push   %r8
    97d5:	c5 f8 77             	vzeroupper 
    97d8:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    97df:	66 49 0f 6e c9       	movq   %r9,%xmm1
    97e4:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6
    97e9:	c4 e2 79 18 f6       	vbroadcastss %xmm6,%xmm6
    97ee:	c5 f8 10 ee          	vmovups %xmm6,%xmm5
    97f2:	c5 f8 10 fe          	vmovups %xmm6,%xmm7
    97f6:	c5 78 10 c6          	vmovups %xmm6,%xmm8
    97fa:	c5 78 10 ce          	vmovups %xmm6,%xmm9
    97fe:	c5 78 10 d6          	vmovups %xmm6,%xmm10
    9802:	c5 78 10 de          	vmovups %xmm6,%xmm11
    9806:	c5 78 10 e6          	vmovups %xmm6,%xmm12
    980a:	c5 78 10 ee          	vmovups %xmm6,%xmm13
    980e:	c5 78 10 f6          	vmovups %xmm6,%xmm14
    9812:	c5 78 10 fe          	vmovups %xmm6,%xmm15

0000000000009816 <latfma128_loop>:
    9816:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    981b:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9820:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9825:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    982a:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    982f:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9834:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9839:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    983e:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9843:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9848:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    984d:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9852:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9857:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    985c:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9861:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9866:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    986b:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9870:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    9875:	c4 e2 51 98 fe       	vfmadd132ps %xmm6,%xmm5,%xmm7
    987a:	4c 29 cf             	sub    %r9,%rdi
    987d:	75 97                	jne    9816 <latfma128_loop>
    987f:	66 48 0f 7e c8       	movq   %xmm1,%rax
    9884:	c5 f8 77             	vzeroupper 
    9887:	41 58                	pop    %r8
    9889:	41 59                	pop    %r9
    988b:	c3                   	retq   

000000000000988c <latadd128fp>:
    988c:	41 51                	push   %r9
    988e:	41 50                	push   %r8
    9890:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    9897:	66 49 0f 6e c9       	movq   %r9,%xmm1
    989c:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6

00000000000098a1 <latadd128fp_loop>:
    98a1:	0f 58 f6             	addps  %xmm6,%xmm6
    98a4:	0f 58 f6             	addps  %xmm6,%xmm6
    98a7:	0f 58 f6             	addps  %xmm6,%xmm6
    98aa:	0f 58 f6             	addps  %xmm6,%xmm6
    98ad:	0f 58 f6             	addps  %xmm6,%xmm6
    98b0:	0f 58 f6             	addps  %xmm6,%xmm6
    98b3:	0f 58 f6             	addps  %xmm6,%xmm6
    98b6:	0f 58 f6             	addps  %xmm6,%xmm6
    98b9:	0f 58 f6             	addps  %xmm6,%xmm6
    98bc:	0f 58 f6             	addps  %xmm6,%xmm6
    98bf:	0f 58 f6             	addps  %xmm6,%xmm6
    98c2:	0f 58 f6             	addps  %xmm6,%xmm6
    98c5:	0f 58 f6             	addps  %xmm6,%xmm6
    98c8:	0f 58 f6             	addps  %xmm6,%xmm6
    98cb:	0f 58 f6             	addps  %xmm6,%xmm6
    98ce:	0f 58 f6             	addps  %xmm6,%xmm6
    98d1:	0f 58 f6             	addps  %xmm6,%xmm6
    98d4:	0f 58 f6             	addps  %xmm6,%xmm6
    98d7:	0f 58 f6             	addps  %xmm6,%xmm6
    98da:	0f 58 f6             	addps  %xmm6,%xmm6
    98dd:	4c 29 cf             	sub    %r9,%rdi
    98e0:	75 bf                	jne    98a1 <latadd128fp_loop>
    98e2:	66 48 0f 7e c8       	movq   %xmm1,%rax
    98e7:	41 58                	pop    %r8
    98e9:	41 59                	pop    %r9
    98eb:	c3                   	retq   

00000000000098ec <latmul128fp>:
    98ec:	41 51                	push   %r9
    98ee:	41 50                	push   %r8
    98f0:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    98f7:	66 49 0f 6e c9       	movq   %r9,%xmm1
    98fc:	f3 49 0f 2a f1       	cvtsi2ss %r9,%xmm6

0000000000009901 <latmul128fp_loop>:
    9901:	0f 59 f6             	mulps  %xmm6,%xmm6
    9904:	0f 59 f6             	mulps  %xmm6,%xmm6
    9907:	0f 59 f6             	mulps  %xmm6,%xmm6
    990a:	0f 59 f6             	mulps  %xmm6,%xmm6
    990d:	0f 59 f6             	mulps  %xmm6,%xmm6
    9910:	0f 59 f6             	mulps  %xmm6,%xmm6
    9913:	0f 59 f6             	mulps  %xmm6,%xmm6
    9916:	0f 59 f6             	mulps  %xmm6,%xmm6
    9919:	0f 59 f6             	mulps  %xmm6,%xmm6
    991c:	0f 59 f6             	mulps  %xmm6,%xmm6
    991f:	0f 59 f6             	mulps  %xmm6,%xmm6
    9922:	0f 59 f6             	mulps  %xmm6,%xmm6
    9925:	0f 59 f6             	mulps  %xmm6,%xmm6
    9928:	0f 59 f6             	mulps  %xmm6,%xmm6
    992b:	0f 59 f6             	mulps  %xmm6,%xmm6
    992e:	0f 59 f6             	mulps  %xmm6,%xmm6
    9931:	0f 59 f6             	mulps  %xmm6,%xmm6
    9934:	0f 59 f6             	mulps  %xmm6,%xmm6
    9937:	0f 59 f6             	mulps  %xmm6,%xmm6
    993a:	0f 59 f6             	mulps  %xmm6,%xmm6
    993d:	4c 29 cf             	sub    %r9,%rdi
    9940:	75 bf                	jne    9901 <latmul128fp_loop>
    9942:	66 48 0f 7e c8       	movq   %xmm1,%rax
    9947:	41 58                	pop    %r8
    9949:	41 59                	pop    %r9
    994b:	c3                   	retq   

000000000000994c <mul128fp>:
    994c:	41 51                	push   %r9
    994e:	41 50                	push   %r8
    9950:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    9957:	f3 49 0f 2a e1       	cvtsi2ss %r9,%xmm4
    995c:	f3 49 0f 2a d9       	cvtsi2ss %r9,%xmm3
    9961:	f3 49 0f 2a d1       	cvtsi2ss %r9,%xmm2
    9966:	f3 49 0f 2a c9       	cvtsi2ss %r9,%xmm1
    996b:	f3 49 0f 2a c1       	cvtsi2ss %r9,%xmm0

0000000000009970 <mul128fp_loop>:
    9970:	0f 59 c0             	mulps  %xmm0,%xmm0
    9973:	0f 59 c9             	mulps  %xmm1,%xmm1
    9976:	0f 59 d2             	mulps  %xmm2,%xmm2
    9979:	0f 59 db             	mulps  %xmm3,%xmm3
    997c:	0f 59 e4             	mulps  %xmm4,%xmm4
    997f:	0f 59 c0             	mulps  %xmm0,%xmm0
    9982:	0f 59 c9             	mulps  %xmm1,%xmm1
    9985:	0f 59 d2             	mulps  %xmm2,%xmm2
    9988:	0f 59 db             	mulps  %xmm3,%xmm3
    998b:	0f 59 e4             	mulps  %xmm4,%xmm4
    998e:	0f 59 c0             	mulps  %xmm0,%xmm0
    9991:	0f 59 c9             	mulps  %xmm1,%xmm1
    9994:	0f 59 d2             	mulps  %xmm2,%xmm2
    9997:	0f 59 db             	mulps  %xmm3,%xmm3
    999a:	0f 59 e4             	mulps  %xmm4,%xmm4
    999d:	0f 59 c0             	mulps  %xmm0,%xmm0
    99a0:	0f 59 c9             	mulps  %xmm1,%xmm1
    99a3:	0f 59 d2             	mulps  %xmm2,%xmm2
    99a6:	0f 59 db             	mulps  %xmm3,%xmm3
    99a9:	0f 59 e4             	mulps  %xmm4,%xmm4
    99ac:	4c 29 cf             	sub    %r9,%rdi
    99af:	75 bf                	jne    9970 <mul128fp_loop>
    99b1:	66 48 0f 7e c8       	movq   %xmm1,%rax
    99b6:	41 58                	pop    %r8
    99b8:	41 59                	pop    %r9
    99ba:	c3                   	retq   

00000000000099bb <add128fp>:
    99bb:	41 51                	push   %r9
    99bd:	41 50                	push   %r8
    99bf:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    99c6:	f3 49 0f 2a e1       	cvtsi2ss %r9,%xmm4
    99cb:	f3 49 0f 2a d9       	cvtsi2ss %r9,%xmm3
    99d0:	f3 49 0f 2a d1       	cvtsi2ss %r9,%xmm2
    99d5:	f3 49 0f 2a c9       	cvtsi2ss %r9,%xmm1
    99da:	f3 49 0f 2a c1       	cvtsi2ss %r9,%xmm0

00000000000099df <add128fp_loop>:
    99df:	0f 58 c0             	addps  %xmm0,%xmm0
    99e2:	0f 58 c9             	addps  %xmm1,%xmm1
    99e5:	0f 58 d2             	addps  %xmm2,%xmm2
    99e8:	0f 58 db             	addps  %xmm3,%xmm3
    99eb:	0f 58 e4             	addps  %xmm4,%xmm4
    99ee:	0f 58 c0             	addps  %xmm0,%xmm0
    99f1:	0f 58 c9             	addps  %xmm1,%xmm1
    99f4:	0f 58 d2             	addps  %xmm2,%xmm2
    99f7:	0f 58 db             	addps  %xmm3,%xmm3
    99fa:	0f 58 e4             	addps  %xmm4,%xmm4
    99fd:	0f 58 c0             	addps  %xmm0,%xmm0
    9a00:	0f 58 c9             	addps  %xmm1,%xmm1
    9a03:	0f 58 d2             	addps  %xmm2,%xmm2
    9a06:	0f 58 db             	addps  %xmm3,%xmm3
    9a09:	0f 58 e4             	addps  %xmm4,%xmm4
    9a0c:	0f 58 c0             	addps  %xmm0,%xmm0
    9a0f:	0f 58 c9             	addps  %xmm1,%xmm1
    9a12:	0f 58 d2             	addps  %xmm2,%xmm2
    9a15:	0f 58 db             	addps  %xmm3,%xmm3
    9a18:	0f 58 e4             	addps  %xmm4,%xmm4
    9a1b:	4c 29 cf             	sub    %r9,%rdi
    9a1e:	75 bf                	jne    99df <add128fp_loop>
    9a20:	66 48 0f 7e c8       	movq   %xmm1,%rax
    9a25:	41 58                	pop    %r8
    9a27:	41 59                	pop    %r9
    9a29:	c3                   	retq   

0000000000009a2a <latmul64>:
    9a2a:	53                   	push   %rbx
    9a2b:	51                   	push   %rcx
    9a2c:	41 50                	push   %r8
    9a2e:	41 51                	push   %r9
    9a30:	41 52                	push   %r10
    9a32:	41 53                	push   %r11
    9a34:	41 54                	push   %r12
    9a36:	41 55                	push   %r13
    9a38:	41 56                	push   %r14
    9a3a:	41 57                	push   %r15
    9a3c:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    9a43:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    9a4a:	4c 89 c3             	mov    %r8,%rbx
    9a4d:	4c 89 c1             	mov    %r8,%rcx
    9a50:	4d 89 c2             	mov    %r8,%r10
    9a53:	4d 89 c3             	mov    %r8,%r11
    9a56:	4d 89 c4             	mov    %r8,%r12
    9a59:	4d 89 c5             	mov    %r8,%r13
    9a5c:	4d 89 c6             	mov    %r8,%r14
    9a5f:	4d 89 cf             	mov    %r9,%r15

0000000000009a62 <latmul64_loop>:
    9a62:	4d 0f af f9          	imul   %r9,%r15
    9a66:	4d 0f af f9          	imul   %r9,%r15
    9a6a:	4d 0f af f9          	imul   %r9,%r15
    9a6e:	4d 0f af f9          	imul   %r9,%r15
    9a72:	4d 0f af f9          	imul   %r9,%r15
    9a76:	4d 0f af f9          	imul   %r9,%r15
    9a7a:	4d 0f af f9          	imul   %r9,%r15
    9a7e:	4d 0f af f9          	imul   %r9,%r15
    9a82:	4d 0f af f9          	imul   %r9,%r15
    9a86:	4d 0f af f9          	imul   %r9,%r15
    9a8a:	4d 0f af f9          	imul   %r9,%r15
    9a8e:	4d 0f af f9          	imul   %r9,%r15
    9a92:	4d 0f af f9          	imul   %r9,%r15
    9a96:	4d 0f af f9          	imul   %r9,%r15
    9a9a:	4d 0f af f9          	imul   %r9,%r15
    9a9e:	4d 0f af f9          	imul   %r9,%r15
    9aa2:	4d 0f af f9          	imul   %r9,%r15
    9aa6:	4d 0f af f9          	imul   %r9,%r15
    9aaa:	4d 0f af f9          	imul   %r9,%r15
    9aae:	4d 0f af f9          	imul   %r9,%r15
    9ab2:	4c 29 cf             	sub    %r9,%rdi
    9ab5:	75 ab                	jne    9a62 <latmul64_loop>
    9ab7:	41 5f                	pop    %r15
    9ab9:	41 5e                	pop    %r14
    9abb:	41 5d                	pop    %r13
    9abd:	41 5c                	pop    %r12
    9abf:	41 5b                	pop    %r11
    9ac1:	41 5a                	pop    %r10
    9ac3:	41 59                	pop    %r9
    9ac5:	41 58                	pop    %r8
    9ac7:	59                   	pop    %rcx
    9ac8:	5b                   	pop    %rbx
    9ac9:	c3                   	retq   

0000000000009aca <latmul16>:
    9aca:	53                   	push   %rbx
    9acb:	51                   	push   %rcx
    9acc:	41 50                	push   %r8
    9ace:	41 51                	push   %r9
    9ad0:	41 52                	push   %r10
    9ad2:	41 53                	push   %r11
    9ad4:	41 54                	push   %r12
    9ad6:	41 55                	push   %r13
    9ad8:	41 56                	push   %r14
    9ada:	41 57                	push   %r15
    9adc:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    9ae3:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    9aea:	4c 89 c3             	mov    %r8,%rbx
    9aed:	4c 89 c1             	mov    %r8,%rcx
    9af0:	4d 89 c2             	mov    %r8,%r10
    9af3:	4d 89 c3             	mov    %r8,%r11
    9af6:	4d 89 c4             	mov    %r8,%r12
    9af9:	4d 89 c5             	mov    %r8,%r13
    9afc:	4d 89 c6             	mov    %r8,%r14
    9aff:	4d 89 cf             	mov    %r9,%r15

0000000000009b02 <latmul16_loop>:
    9b02:	66 45 0f af f9       	imul   %r9w,%r15w
    9b07:	66 45 0f af f9       	imul   %r9w,%r15w
    9b0c:	66 45 0f af f9       	imul   %r9w,%r15w
    9b11:	66 45 0f af f9       	imul   %r9w,%r15w
    9b16:	66 45 0f af f9       	imul   %r9w,%r15w
    9b1b:	66 45 0f af f9       	imul   %r9w,%r15w
    9b20:	66 45 0f af f9       	imul   %r9w,%r15w
    9b25:	66 45 0f af f9       	imul   %r9w,%r15w
    9b2a:	66 45 0f af f9       	imul   %r9w,%r15w
    9b2f:	66 45 0f af f9       	imul   %r9w,%r15w
    9b34:	66 45 0f af f9       	imul   %r9w,%r15w
    9b39:	66 45 0f af f9       	imul   %r9w,%r15w
    9b3e:	66 45 0f af f9       	imul   %r9w,%r15w
    9b43:	66 45 0f af f9       	imul   %r9w,%r15w
    9b48:	66 45 0f af f9       	imul   %r9w,%r15w
    9b4d:	66 45 0f af f9       	imul   %r9w,%r15w
    9b52:	66 45 0f af f9       	imul   %r9w,%r15w
    9b57:	66 45 0f af f9       	imul   %r9w,%r15w
    9b5c:	66 45 0f af f9       	imul   %r9w,%r15w
    9b61:	66 45 0f af f9       	imul   %r9w,%r15w
    9b66:	4c 29 cf             	sub    %r9,%rdi
    9b69:	75 97                	jne    9b02 <latmul16_loop>
    9b6b:	41 5f                	pop    %r15
    9b6d:	41 5e                	pop    %r14
    9b6f:	41 5d                	pop    %r13
    9b71:	41 5c                	pop    %r12
    9b73:	41 5b                	pop    %r11
    9b75:	41 5a                	pop    %r10
    9b77:	41 59                	pop    %r9
    9b79:	41 58                	pop    %r8
    9b7b:	59                   	pop    %rcx
    9b7c:	5b                   	pop    %rbx
    9b7d:	c3                   	retq   

0000000000009b7e <mul16>:
    9b7e:	53                   	push   %rbx
    9b7f:	51                   	push   %rcx
    9b80:	41 50                	push   %r8
    9b82:	41 51                	push   %r9
    9b84:	41 52                	push   %r10
    9b86:	41 53                	push   %r11
    9b88:	41 54                	push   %r12
    9b8a:	41 55                	push   %r13
    9b8c:	41 56                	push   %r14
    9b8e:	41 57                	push   %r15
    9b90:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    9b97:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    9b9e:	4c 89 c3             	mov    %r8,%rbx
    9ba1:	4c 89 c1             	mov    %r8,%rcx
    9ba4:	4d 89 c2             	mov    %r8,%r10
    9ba7:	4d 89 c3             	mov    %r8,%r11
    9baa:	4d 89 c4             	mov    %r8,%r12
    9bad:	4d 89 c5             	mov    %r8,%r13
    9bb0:	4d 89 c6             	mov    %r8,%r14
    9bb3:	4d 89 cf             	mov    %r9,%r15

0000000000009bb6 <mul16_loop>:
    9bb6:	66 45 0f af f9       	imul   %r9w,%r15w
    9bbb:	66 45 0f af f1       	imul   %r9w,%r14w
    9bc0:	66 45 0f af e9       	imul   %r9w,%r13w
    9bc5:	66 45 0f af e1       	imul   %r9w,%r12w
    9bca:	66 45 0f af d9       	imul   %r9w,%r11w
    9bcf:	66 45 0f af f9       	imul   %r9w,%r15w
    9bd4:	66 45 0f af f1       	imul   %r9w,%r14w
    9bd9:	66 45 0f af e9       	imul   %r9w,%r13w
    9bde:	66 45 0f af e1       	imul   %r9w,%r12w
    9be3:	66 45 0f af d9       	imul   %r9w,%r11w
    9be8:	66 45 0f af f9       	imul   %r9w,%r15w
    9bed:	66 45 0f af f1       	imul   %r9w,%r14w
    9bf2:	66 45 0f af e9       	imul   %r9w,%r13w
    9bf7:	66 45 0f af e1       	imul   %r9w,%r12w
    9bfc:	66 45 0f af d9       	imul   %r9w,%r11w
    9c01:	66 45 0f af f9       	imul   %r9w,%r15w
    9c06:	66 45 0f af f1       	imul   %r9w,%r14w
    9c0b:	66 45 0f af e9       	imul   %r9w,%r13w
    9c10:	66 45 0f af e1       	imul   %r9w,%r12w
    9c15:	66 45 0f af d9       	imul   %r9w,%r11w
    9c1a:	4c 29 cf             	sub    %r9,%rdi
    9c1d:	75 97                	jne    9bb6 <mul16_loop>
    9c1f:	41 5f                	pop    %r15
    9c21:	41 5e                	pop    %r14
    9c23:	41 5d                	pop    %r13
    9c25:	41 5c                	pop    %r12
    9c27:	41 5b                	pop    %r11
    9c29:	41 5a                	pop    %r10
    9c2b:	41 59                	pop    %r9
    9c2d:	41 58                	pop    %r8
    9c2f:	59                   	pop    %rcx
    9c30:	5b                   	pop    %rbx
    9c31:	c3                   	retq   

0000000000009c32 <mul64>:
    9c32:	53                   	push   %rbx
    9c33:	51                   	push   %rcx
    9c34:	56                   	push   %rsi
    9c35:	41 50                	push   %r8
    9c37:	41 51                	push   %r9
    9c39:	41 52                	push   %r10
    9c3b:	41 53                	push   %r11
    9c3d:	41 54                	push   %r12
    9c3f:	41 55                	push   %r13
    9c41:	41 56                	push   %r14
    9c43:	41 57                	push   %r15
    9c45:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    9c4c:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    9c53:	4c 89 c3             	mov    %r8,%rbx
    9c56:	4c 89 c1             	mov    %r8,%rcx
    9c59:	4d 89 c2             	mov    %r8,%r10
    9c5c:	4d 89 c3             	mov    %r8,%r11
    9c5f:	4d 89 c4             	mov    %r8,%r12
    9c62:	4d 89 c5             	mov    %r8,%r13
    9c65:	4d 89 c6             	mov    %r8,%r14
    9c68:	4d 89 cf             	mov    %r9,%r15

0000000000009c6b <mul64_loop>:
    9c6b:	4d 0f af f9          	imul   %r9,%r15
    9c6f:	4d 89 cf             	mov    %r9,%r15
    9c72:	4d 0f af f1          	imul   %r9,%r14
    9c76:	4d 89 ce             	mov    %r9,%r14
    9c79:	4d 0f af e9          	imul   %r9,%r13
    9c7d:	4d 89 cd             	mov    %r9,%r13
    9c80:	4d 0f af e1          	imul   %r9,%r12
    9c84:	4d 89 cc             	mov    %r9,%r12
    9c87:	4d 0f af d9          	imul   %r9,%r11
    9c8b:	4d 89 cb             	mov    %r9,%r11
    9c8e:	4d 0f af d1          	imul   %r9,%r10
    9c92:	4d 89 ca             	mov    %r9,%r10
    9c95:	4d 0f af c1          	imul   %r9,%r8
    9c99:	4d 89 c8             	mov    %r9,%r8
    9c9c:	49 0f af d9          	imul   %r9,%rbx
    9ca0:	4c 89 cb             	mov    %r9,%rbx
    9ca3:	49 0f af c9          	imul   %r9,%rcx
    9ca7:	4c 89 c9             	mov    %r9,%rcx
    9caa:	49 0f af f1          	imul   %r9,%rsi
    9cae:	4c 89 ce             	mov    %r9,%rsi
    9cb1:	4d 0f af f9          	imul   %r9,%r15
    9cb5:	4d 89 cf             	mov    %r9,%r15
    9cb8:	4d 0f af f1          	imul   %r9,%r14
    9cbc:	4d 89 ce             	mov    %r9,%r14
    9cbf:	4d 0f af e9          	imul   %r9,%r13
    9cc3:	4d 89 cd             	mov    %r9,%r13
    9cc6:	4d 0f af e1          	imul   %r9,%r12
    9cca:	4d 89 cc             	mov    %r9,%r12
    9ccd:	4d 0f af d9          	imul   %r9,%r11
    9cd1:	4d 89 cb             	mov    %r9,%r11
    9cd4:	4d 0f af d1          	imul   %r9,%r10
    9cd8:	4d 89 ca             	mov    %r9,%r10
    9cdb:	4d 0f af c1          	imul   %r9,%r8
    9cdf:	4d 89 c8             	mov    %r9,%r8
    9ce2:	49 0f af d9          	imul   %r9,%rbx
    9ce6:	4c 89 cb             	mov    %r9,%rbx
    9ce9:	49 0f af c9          	imul   %r9,%rcx
    9ced:	4c 89 c9             	mov    %r9,%rcx
    9cf0:	49 0f af f1          	imul   %r9,%rsi
    9cf4:	4c 89 ce             	mov    %r9,%rsi
    9cf7:	4c 29 cf             	sub    %r9,%rdi
    9cfa:	0f 85 6b ff ff ff    	jne    9c6b <mul64_loop>
    9d00:	41 5f                	pop    %r15
    9d02:	41 5e                	pop    %r14
    9d04:	41 5d                	pop    %r13
    9d06:	41 5c                	pop    %r12
    9d08:	41 5b                	pop    %r11
    9d0a:	41 5a                	pop    %r10
    9d0c:	41 59                	pop    %r9
    9d0e:	41 58                	pop    %r8
    9d10:	5e                   	pop    %rsi
    9d11:	59                   	pop    %rcx
    9d12:	5b                   	pop    %rbx
    9d13:	c3                   	retq   

0000000000009d14 <mixmul16mul64>:
    9d14:	53                   	push   %rbx
    9d15:	51                   	push   %rcx
    9d16:	56                   	push   %rsi
    9d17:	41 50                	push   %r8
    9d19:	41 51                	push   %r9
    9d1b:	41 52                	push   %r10
    9d1d:	41 53                	push   %r11
    9d1f:	41 54                	push   %r12
    9d21:	41 55                	push   %r13
    9d23:	41 56                	push   %r14
    9d25:	41 57                	push   %r15
    9d27:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    9d2e:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    9d35:	4c 89 c3             	mov    %r8,%rbx
    9d38:	4c 89 c1             	mov    %r8,%rcx
    9d3b:	4d 89 c2             	mov    %r8,%r10
    9d3e:	4d 89 c3             	mov    %r8,%r11
    9d41:	4d 89 c4             	mov    %r8,%r12
    9d44:	4d 89 c5             	mov    %r8,%r13
    9d47:	4d 89 c6             	mov    %r8,%r14
    9d4a:	4d 89 cf             	mov    %r9,%r15

0000000000009d4d <mixmul16mul64_loop>:
    9d4d:	4d 0f af f9          	imul   %r9,%r15
    9d51:	66 45 0f af f1       	imul   %r9w,%r14w
    9d56:	4d 0f af e9          	imul   %r9,%r13
    9d5a:	66 45 0f af e1       	imul   %r9w,%r12w
    9d5f:	4d 0f af d9          	imul   %r9,%r11
    9d63:	66 45 0f af d1       	imul   %r9w,%r10w
    9d68:	4d 0f af c1          	imul   %r9,%r8
    9d6c:	66 41 0f af d9       	imul   %r9w,%bx
    9d71:	49 0f af c9          	imul   %r9,%rcx
    9d75:	66 41 0f af f1       	imul   %r9w,%si
    9d7a:	4d 0f af f9          	imul   %r9,%r15
    9d7e:	66 45 0f af f1       	imul   %r9w,%r14w
    9d83:	4d 0f af e9          	imul   %r9,%r13
    9d87:	66 45 0f af e1       	imul   %r9w,%r12w
    9d8c:	4d 0f af d9          	imul   %r9,%r11
    9d90:	66 45 0f af d1       	imul   %r9w,%r10w
    9d95:	4d 0f af c1          	imul   %r9,%r8
    9d99:	66 41 0f af d9       	imul   %r9w,%bx
    9d9e:	49 0f af c9          	imul   %r9,%rcx
    9da2:	66 41 0f af f1       	imul   %r9w,%si
    9da7:	4c 29 cf             	sub    %r9,%rdi
    9daa:	75 a1                	jne    9d4d <mixmul16mul64_loop>
    9dac:	41 5f                	pop    %r15
    9dae:	41 5e                	pop    %r14
    9db0:	41 5d                	pop    %r13
    9db2:	41 5c                	pop    %r12
    9db4:	41 5b                	pop    %r11
    9db6:	41 5a                	pop    %r10
    9db8:	41 59                	pop    %r9
    9dba:	41 58                	pop    %r8
    9dbc:	5e                   	pop    %rsi
    9dbd:	59                   	pop    %rcx
    9dbe:	5b                   	pop    %rbx
    9dbf:	c3                   	retq   

0000000000009dc0 <mixmul16mul64_21>:
    9dc0:	53                   	push   %rbx
    9dc1:	51                   	push   %rcx
    9dc2:	52                   	push   %rdx
    9dc3:	56                   	push   %rsi
    9dc4:	41 50                	push   %r8
    9dc6:	41 51                	push   %r9
    9dc8:	41 52                	push   %r10
    9dca:	41 53                	push   %r11
    9dcc:	41 54                	push   %r12
    9dce:	41 55                	push   %r13
    9dd0:	41 56                	push   %r14
    9dd2:	41 57                	push   %r15
    9dd4:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    9ddb:	49 c7 c1 18 00 00 00 	mov    $0x18,%r9
    9de2:	4c 89 c3             	mov    %r8,%rbx
    9de5:	4c 89 c1             	mov    %r8,%rcx
    9de8:	4c 89 c6             	mov    %r8,%rsi
    9deb:	4d 89 c2             	mov    %r8,%r10
    9dee:	4d 89 c3             	mov    %r8,%r11
    9df1:	4d 89 c4             	mov    %r8,%r12
    9df4:	4d 89 c5             	mov    %r8,%r13
    9df7:	4d 89 c6             	mov    %r8,%r14
    9dfa:	4d 89 cf             	mov    %r9,%r15

0000000000009dfd <mixmul16mul64_21_loop>:
    9dfd:	4d 0f af f9          	imul   %r9,%r15
    9e01:	66 45 0f af f1       	imul   %r9w,%r14w
    9e06:	66 45 0f af e9       	imul   %r9w,%r13w
    9e0b:	4d 0f af e1          	imul   %r9,%r12
    9e0f:	66 45 0f af d9       	imul   %r9w,%r11w
    9e14:	66 45 0f af d1       	imul   %r9w,%r10w
    9e19:	4d 0f af c1          	imul   %r9,%r8
    9e1d:	66 45 0f af f1       	imul   %r9w,%r14w
    9e22:	66 45 0f af e9       	imul   %r9w,%r13w
    9e27:	49 0f af c9          	imul   %r9,%rcx
    9e2b:	66 45 0f af d9       	imul   %r9w,%r11w
    9e30:	66 45 0f af d1       	imul   %r9w,%r10w
    9e35:	49 0f af d9          	imul   %r9,%rbx
    9e39:	66 45 0f af f1       	imul   %r9w,%r14w
    9e3e:	66 45 0f af e9       	imul   %r9w,%r13w
    9e43:	49 0f af c1          	imul   %r9,%rax
    9e47:	66 45 0f af d9       	imul   %r9w,%r11w
    9e4c:	66 45 0f af d1       	imul   %r9w,%r10w
    9e51:	49 0f af f1          	imul   %r9,%rsi
    9e55:	66 45 0f af f1       	imul   %r9w,%r14w
    9e5a:	66 45 0f af e9       	imul   %r9w,%r13w
    9e5f:	49 0f af d1          	imul   %r9,%rdx
    9e63:	66 45 0f af d9       	imul   %r9w,%r11w
    9e68:	66 45 0f af d1       	imul   %r9w,%r10w
    9e6d:	4c 29 cf             	sub    %r9,%rdi
    9e70:	7d 8b                	jge    9dfd <mixmul16mul64_21_loop>
    9e72:	41 5f                	pop    %r15
    9e74:	41 5e                	pop    %r14
    9e76:	41 5d                	pop    %r13
    9e78:	41 5c                	pop    %r12
    9e7a:	41 5b                	pop    %r11
    9e7c:	41 5a                	pop    %r10
    9e7e:	41 59                	pop    %r9
    9e80:	41 58                	pop    %r8
    9e82:	5e                   	pop    %rsi
    9e83:	5a                   	pop    %rdx
    9e84:	59                   	pop    %rcx
    9e85:	5b                   	pop    %rbx
    9e86:	c3                   	retq   

0000000000009e87 <spacedstorescalar>:
    9e87:	53                   	push   %rbx
    9e88:	51                   	push   %rcx
    9e89:	41 50                	push   %r8
    9e8b:	41 51                	push   %r9
    9e8d:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9

0000000000009e94 <spacedstorescalar_loop>:
    9e94:	48 89 3e             	mov    %rdi,(%rsi)
    9e97:	48 89 7e 40          	mov    %rdi,0x40(%rsi)
    9e9b:	48 89 be 80 00 00 00 	mov    %rdi,0x80(%rsi)
    9ea2:	48 89 be c0 00 00 00 	mov    %rdi,0xc0(%rsi)
    9ea9:	48 89 be 00 01 00 00 	mov    %rdi,0x100(%rsi)
    9eb0:	48 89 be 40 01 00 00 	mov    %rdi,0x140(%rsi)
    9eb7:	48 89 be 80 01 00 00 	mov    %rdi,0x180(%rsi)
    9ebe:	48 89 be c0 01 00 00 	mov    %rdi,0x1c0(%rsi)
    9ec5:	48 89 be 00 02 00 00 	mov    %rdi,0x200(%rsi)
    9ecc:	48 89 be 40 02 00 00 	mov    %rdi,0x240(%rsi)
    9ed3:	48 89 be 80 02 00 00 	mov    %rdi,0x280(%rsi)
    9eda:	48 89 be c0 02 00 00 	mov    %rdi,0x2c0(%rsi)
    9ee1:	48 89 be 00 03 00 00 	mov    %rdi,0x300(%rsi)
    9ee8:	48 89 be 40 03 00 00 	mov    %rdi,0x340(%rsi)
    9eef:	48 89 be 80 03 00 00 	mov    %rdi,0x380(%rsi)
    9ef6:	48 89 be c0 03 00 00 	mov    %rdi,0x3c0(%rsi)
    9efd:	48 89 be 00 04 00 00 	mov    %rdi,0x400(%rsi)
    9f04:	48 89 be 40 04 00 00 	mov    %rdi,0x440(%rsi)
    9f0b:	48 89 be 80 04 00 00 	mov    %rdi,0x480(%rsi)
    9f12:	48 89 be c0 04 00 00 	mov    %rdi,0x4c0(%rsi)
    9f19:	4c 29 cf             	sub    %r9,%rdi
    9f1c:	0f 85 72 ff ff ff    	jne    9e94 <spacedstorescalar_loop>
    9f22:	41 59                	pop    %r9
    9f24:	41 58                	pop    %r8
    9f26:	59                   	pop    %rcx
    9f27:	5b                   	pop    %rbx
    9f28:	c3                   	retq   

0000000000009f29 <spacedload128>:
    9f29:	53                   	push   %rbx
    9f2a:	51                   	push   %rcx
    9f2b:	41 50                	push   %r8
    9f2d:	41 51                	push   %r9
    9f2f:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9

0000000000009f36 <spacedload128_loop>:
    9f36:	66 44 0f 6f 16       	movdqa (%rsi),%xmm10
    9f3b:	66 44 0f 6f 5e 40    	movdqa 0x40(%rsi),%xmm11
    9f41:	66 44 0f 6f a6 80 00 	movdqa 0x80(%rsi),%xmm12
    9f48:	00 00 
    9f4a:	66 44 0f 6f ae c0 00 	movdqa 0xc0(%rsi),%xmm13
    9f51:	00 00 
    9f53:	66 44 0f 6f b6 00 01 	movdqa 0x100(%rsi),%xmm14
    9f5a:	00 00 
    9f5c:	66 44 0f 6f 96 40 01 	movdqa 0x140(%rsi),%xmm10
    9f63:	00 00 
    9f65:	66 44 0f 6f 9e 80 01 	movdqa 0x180(%rsi),%xmm11
    9f6c:	00 00 
    9f6e:	66 44 0f 6f a6 c0 01 	movdqa 0x1c0(%rsi),%xmm12
    9f75:	00 00 
    9f77:	66 44 0f 6f ae 00 02 	movdqa 0x200(%rsi),%xmm13
    9f7e:	00 00 
    9f80:	66 44 0f 6f b6 40 02 	movdqa 0x240(%rsi),%xmm14
    9f87:	00 00 
    9f89:	66 44 0f 6f 96 80 02 	movdqa 0x280(%rsi),%xmm10
    9f90:	00 00 
    9f92:	66 44 0f 6f 9e c0 02 	movdqa 0x2c0(%rsi),%xmm11
    9f99:	00 00 
    9f9b:	66 44 0f 6f a6 00 03 	movdqa 0x300(%rsi),%xmm12
    9fa2:	00 00 
    9fa4:	66 44 0f 6f ae 40 03 	movdqa 0x340(%rsi),%xmm13
    9fab:	00 00 
    9fad:	66 44 0f 6f b6 80 03 	movdqa 0x380(%rsi),%xmm14
    9fb4:	00 00 
    9fb6:	66 44 0f 6f 96 c0 03 	movdqa 0x3c0(%rsi),%xmm10
    9fbd:	00 00 
    9fbf:	66 44 0f 6f 9e 00 04 	movdqa 0x400(%rsi),%xmm11
    9fc6:	00 00 
    9fc8:	66 44 0f 6f a6 40 04 	movdqa 0x440(%rsi),%xmm12
    9fcf:	00 00 
    9fd1:	66 44 0f 6f ae 80 04 	movdqa 0x480(%rsi),%xmm13
    9fd8:	00 00 
    9fda:	66 44 0f 6f b6 c0 04 	movdqa 0x4c0(%rsi),%xmm14
    9fe1:	00 00 
    9fe3:	4c 29 cf             	sub    %r9,%rdi
    9fe6:	0f 85 4a ff ff ff    	jne    9f36 <spacedload128_loop>
    9fec:	41 59                	pop    %r9
    9fee:	41 58                	pop    %r8
    9ff0:	59                   	pop    %rcx
    9ff1:	5b                   	pop    %rbx
    9ff2:	c3                   	retq   

0000000000009ff3 <load128>:
    9ff3:	53                   	push   %rbx
    9ff4:	51                   	push   %rcx
    9ff5:	41 50                	push   %r8
    9ff7:	41 51                	push   %r9
    9ff9:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9

000000000000a000 <load128_loop>:
    a000:	66 44 0f 6f 16       	movdqa (%rsi),%xmm10
    a005:	66 44 0f 6f 1e       	movdqa (%rsi),%xmm11
    a00a:	66 44 0f 6f 26       	movdqa (%rsi),%xmm12
    a00f:	66 44 0f 6f 2e       	movdqa (%rsi),%xmm13
    a014:	66 44 0f 6f 36       	movdqa (%rsi),%xmm14
    a019:	66 44 0f 6f 16       	movdqa (%rsi),%xmm10
    a01e:	66 44 0f 6f 1e       	movdqa (%rsi),%xmm11
    a023:	66 44 0f 6f 26       	movdqa (%rsi),%xmm12
    a028:	66 44 0f 6f 2e       	movdqa (%rsi),%xmm13
    a02d:	66 44 0f 6f 36       	movdqa (%rsi),%xmm14
    a032:	66 44 0f 6f 16       	movdqa (%rsi),%xmm10
    a037:	66 44 0f 6f 1e       	movdqa (%rsi),%xmm11
    a03c:	66 44 0f 6f 26       	movdqa (%rsi),%xmm12
    a041:	66 44 0f 6f 2e       	movdqa (%rsi),%xmm13
    a046:	66 44 0f 6f 36       	movdqa (%rsi),%xmm14
    a04b:	66 44 0f 6f 16       	movdqa (%rsi),%xmm10
    a050:	66 44 0f 6f 1e       	movdqa (%rsi),%xmm11
    a055:	66 44 0f 6f 26       	movdqa (%rsi),%xmm12
    a05a:	66 44 0f 6f 2e       	movdqa (%rsi),%xmm13
    a05f:	66 44 0f 6f 36       	movdqa (%rsi),%xmm14
    a064:	4c 29 cf             	sub    %r9,%rdi
    a067:	75 97                	jne    a000 <load128_loop>
    a069:	41 59                	pop    %r9
    a06b:	41 58                	pop    %r8
    a06d:	59                   	pop    %rcx
    a06e:	5b                   	pop    %rbx
    a06f:	c3                   	retq   

000000000000a070 <load256>:
    a070:	53                   	push   %rbx
    a071:	51                   	push   %rcx
    a072:	41 50                	push   %r8
    a074:	41 51                	push   %r9
    a076:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9

000000000000a07d <load256_loop>:
    a07d:	c5 7c 28 16          	vmovaps (%rsi),%ymm10
    a081:	c5 7c 28 1e          	vmovaps (%rsi),%ymm11
    a085:	c5 7c 28 26          	vmovaps (%rsi),%ymm12
    a089:	c5 7c 28 2e          	vmovaps (%rsi),%ymm13
    a08d:	c5 7c 28 36          	vmovaps (%rsi),%ymm14
    a091:	c5 7c 28 16          	vmovaps (%rsi),%ymm10
    a095:	c5 7c 28 1e          	vmovaps (%rsi),%ymm11
    a099:	c5 7c 28 26          	vmovaps (%rsi),%ymm12
    a09d:	c5 7c 28 2e          	vmovaps (%rsi),%ymm13
    a0a1:	c5 7c 28 36          	vmovaps (%rsi),%ymm14
    a0a5:	c5 7c 28 16          	vmovaps (%rsi),%ymm10
    a0a9:	c5 7c 28 1e          	vmovaps (%rsi),%ymm11
    a0ad:	c5 7c 28 26          	vmovaps (%rsi),%ymm12
    a0b1:	c5 7c 28 2e          	vmovaps (%rsi),%ymm13
    a0b5:	c5 7c 28 36          	vmovaps (%rsi),%ymm14
    a0b9:	c5 7c 28 16          	vmovaps (%rsi),%ymm10
    a0bd:	c5 7c 28 1e          	vmovaps (%rsi),%ymm11
    a0c1:	c5 7c 28 26          	vmovaps (%rsi),%ymm12
    a0c5:	c5 7c 28 2e          	vmovaps (%rsi),%ymm13
    a0c9:	c5 7c 28 36          	vmovaps (%rsi),%ymm14
    a0cd:	4c 29 cf             	sub    %r9,%rdi
    a0d0:	75 ab                	jne    a07d <load256_loop>
    a0d2:	41 59                	pop    %r9
    a0d4:	41 58                	pop    %r8
    a0d6:	59                   	pop    %rcx
    a0d7:	5b                   	pop    %rbx
    a0d8:	c3                   	retq   

000000000000a0d9 <load512>:
    a0d9:	53                   	push   %rbx
    a0da:	51                   	push   %rcx
    a0db:	41 50                	push   %r8
    a0dd:	41 51                	push   %r9
    a0df:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9

000000000000a0e6 <load512_loop>:
    a0e6:	62 71 7c 48 28 16    	vmovaps (%rsi),%zmm10
    a0ec:	62 71 7c 48 28 1e    	vmovaps (%rsi),%zmm11
    a0f2:	62 71 7c 48 28 26    	vmovaps (%rsi),%zmm12
    a0f8:	62 71 7c 48 28 2e    	vmovaps (%rsi),%zmm13
    a0fe:	62 71 7c 48 28 36    	vmovaps (%rsi),%zmm14
    a104:	62 71 7c 48 28 16    	vmovaps (%rsi),%zmm10
    a10a:	62 71 7c 48 28 1e    	vmovaps (%rsi),%zmm11
    a110:	62 71 7c 48 28 26    	vmovaps (%rsi),%zmm12
    a116:	62 71 7c 48 28 2e    	vmovaps (%rsi),%zmm13
    a11c:	62 71 7c 48 28 36    	vmovaps (%rsi),%zmm14
    a122:	62 71 7c 48 28 16    	vmovaps (%rsi),%zmm10
    a128:	62 71 7c 48 28 1e    	vmovaps (%rsi),%zmm11
    a12e:	62 71 7c 48 28 26    	vmovaps (%rsi),%zmm12
    a134:	62 71 7c 48 28 2e    	vmovaps (%rsi),%zmm13
    a13a:	62 71 7c 48 28 36    	vmovaps (%rsi),%zmm14
    a140:	62 71 7c 48 28 16    	vmovaps (%rsi),%zmm10
    a146:	62 71 7c 48 28 1e    	vmovaps (%rsi),%zmm11
    a14c:	62 71 7c 48 28 26    	vmovaps (%rsi),%zmm12
    a152:	62 71 7c 48 28 2e    	vmovaps (%rsi),%zmm13
    a158:	62 71 7c 48 28 36    	vmovaps (%rsi),%zmm14
    a15e:	4c 29 cf             	sub    %r9,%rdi
    a161:	75 83                	jne    a0e6 <load512_loop>
    a163:	41 59                	pop    %r9
    a165:	41 58                	pop    %r8
    a167:	59                   	pop    %rcx
    a168:	5b                   	pop    %rbx
    a169:	c3                   	retq   

000000000000a16a <store128>:
    a16a:	53                   	push   %rbx
    a16b:	51                   	push   %rcx
    a16c:	41 50                	push   %r8
    a16e:	41 51                	push   %r9
    a170:	66 44 0f 6f 16       	movdqa (%rsi),%xmm10
    a175:	66 45 0f 6f da       	movdqa %xmm10,%xmm11
    a17a:	66 45 0f 6f e2       	movdqa %xmm10,%xmm12
    a17f:	66 45 0f 6f ea       	movdqa %xmm10,%xmm13
    a184:	66 45 0f 6f f2       	movdqa %xmm10,%xmm14
    a189:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9

000000000000a190 <store128_loop>:
    a190:	66 44 0f 7f 12       	movdqa %xmm10,(%rdx)
    a195:	66 44 0f 7f 1a       	movdqa %xmm11,(%rdx)
    a19a:	66 44 0f 7f 22       	movdqa %xmm12,(%rdx)
    a19f:	66 44 0f 7f 2a       	movdqa %xmm13,(%rdx)
    a1a4:	66 44 0f 7f 32       	movdqa %xmm14,(%rdx)
    a1a9:	66 44 0f 7f 12       	movdqa %xmm10,(%rdx)
    a1ae:	66 44 0f 7f 1a       	movdqa %xmm11,(%rdx)
    a1b3:	66 44 0f 7f 22       	movdqa %xmm12,(%rdx)
    a1b8:	66 44 0f 7f 2a       	movdqa %xmm13,(%rdx)
    a1bd:	66 44 0f 7f 32       	movdqa %xmm14,(%rdx)
    a1c2:	66 44 0f 7f 12       	movdqa %xmm10,(%rdx)
    a1c7:	66 44 0f 7f 1a       	movdqa %xmm11,(%rdx)
    a1cc:	66 44 0f 7f 22       	movdqa %xmm12,(%rdx)
    a1d1:	66 44 0f 7f 2a       	movdqa %xmm13,(%rdx)
    a1d6:	66 44 0f 7f 32       	movdqa %xmm14,(%rdx)
    a1db:	66 44 0f 7f 12       	movdqa %xmm10,(%rdx)
    a1e0:	66 44 0f 7f 1a       	movdqa %xmm11,(%rdx)
    a1e5:	66 44 0f 7f 22       	movdqa %xmm12,(%rdx)
    a1ea:	66 44 0f 7f 2a       	movdqa %xmm13,(%rdx)
    a1ef:	66 44 0f 7f 32       	movdqa %xmm14,(%rdx)
    a1f4:	4c 29 cf             	sub    %r9,%rdi
    a1f7:	75 97                	jne    a190 <store128_loop>
    a1f9:	41 59                	pop    %r9
    a1fb:	41 58                	pop    %r8
    a1fd:	59                   	pop    %rcx
    a1fe:	5b                   	pop    %rbx
    a1ff:	c3                   	retq   

000000000000a200 <store256>:
    a200:	53                   	push   %rbx
    a201:	51                   	push   %rcx
    a202:	41 50                	push   %r8
    a204:	41 51                	push   %r9
    a206:	c5 7c 28 16          	vmovaps (%rsi),%ymm10
    a20a:	c4 41 7c 28 da       	vmovaps %ymm10,%ymm11
    a20f:	c4 41 7c 28 e2       	vmovaps %ymm10,%ymm12
    a214:	c4 41 7c 28 ea       	vmovaps %ymm10,%ymm13
    a219:	c4 41 7c 28 f2       	vmovaps %ymm10,%ymm14
    a21e:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9

000000000000a225 <store256_loop>:
    a225:	c5 7c 29 12          	vmovaps %ymm10,(%rdx)
    a229:	c5 7c 29 1a          	vmovaps %ymm11,(%rdx)
    a22d:	c5 7c 29 22          	vmovaps %ymm12,(%rdx)
    a231:	c5 7c 29 2a          	vmovaps %ymm13,(%rdx)
    a235:	c5 7c 29 32          	vmovaps %ymm14,(%rdx)
    a239:	c5 7c 29 12          	vmovaps %ymm10,(%rdx)
    a23d:	c5 7c 29 1a          	vmovaps %ymm11,(%rdx)
    a241:	c5 7c 29 22          	vmovaps %ymm12,(%rdx)
    a245:	c5 7c 29 2a          	vmovaps %ymm13,(%rdx)
    a249:	c5 7c 29 32          	vmovaps %ymm14,(%rdx)
    a24d:	c5 7c 29 12          	vmovaps %ymm10,(%rdx)
    a251:	c5 7c 29 1a          	vmovaps %ymm11,(%rdx)
    a255:	c5 7c 29 22          	vmovaps %ymm12,(%rdx)
    a259:	c5 7c 29 2a          	vmovaps %ymm13,(%rdx)
    a25d:	c5 7c 29 32          	vmovaps %ymm14,(%rdx)
    a261:	c5 7c 29 12          	vmovaps %ymm10,(%rdx)
    a265:	c5 7c 29 1a          	vmovaps %ymm11,(%rdx)
    a269:	c5 7c 29 22          	vmovaps %ymm12,(%rdx)
    a26d:	c5 7c 29 2a          	vmovaps %ymm13,(%rdx)
    a271:	c5 7c 29 32          	vmovaps %ymm14,(%rdx)
    a275:	4c 29 cf             	sub    %r9,%rdi
    a278:	75 ab                	jne    a225 <store256_loop>
    a27a:	41 59                	pop    %r9
    a27c:	41 58                	pop    %r8
    a27e:	59                   	pop    %rcx
    a27f:	5b                   	pop    %rbx
    a280:	c3                   	retq   

000000000000a281 <store512>:
    a281:	53                   	push   %rbx
    a282:	51                   	push   %rcx
    a283:	41 50                	push   %r8
    a285:	41 51                	push   %r9
    a287:	62 71 7c 48 28 16    	vmovaps (%rsi),%zmm10
    a28d:	62 51 7c 48 28 da    	vmovaps %zmm10,%zmm11
    a293:	62 51 7c 48 28 e2    	vmovaps %zmm10,%zmm12
    a299:	62 51 7c 48 28 ea    	vmovaps %zmm10,%zmm13
    a29f:	62 51 7c 48 28 f2    	vmovaps %zmm10,%zmm14
    a2a5:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9

000000000000a2ac <store512_loop>:
    a2ac:	62 71 7c 48 29 12    	vmovaps %zmm10,(%rdx)
    a2b2:	62 71 7c 48 29 1a    	vmovaps %zmm11,(%rdx)
    a2b8:	62 71 7c 48 29 22    	vmovaps %zmm12,(%rdx)
    a2be:	62 71 7c 48 29 2a    	vmovaps %zmm13,(%rdx)
    a2c4:	62 71 7c 48 29 32    	vmovaps %zmm14,(%rdx)
    a2ca:	62 71 7c 48 29 12    	vmovaps %zmm10,(%rdx)
    a2d0:	62 71 7c 48 29 1a    	vmovaps %zmm11,(%rdx)
    a2d6:	62 71 7c 48 29 22    	vmovaps %zmm12,(%rdx)
    a2dc:	62 71 7c 48 29 2a    	vmovaps %zmm13,(%rdx)
    a2e2:	62 71 7c 48 29 32    	vmovaps %zmm14,(%rdx)
    a2e8:	62 71 7c 48 29 12    	vmovaps %zmm10,(%rdx)
    a2ee:	62 71 7c 48 29 1a    	vmovaps %zmm11,(%rdx)
    a2f4:	62 71 7c 48 29 22    	vmovaps %zmm12,(%rdx)
    a2fa:	62 71 7c 48 29 2a    	vmovaps %zmm13,(%rdx)
    a300:	62 71 7c 48 29 32    	vmovaps %zmm14,(%rdx)
    a306:	62 71 7c 48 29 12    	vmovaps %zmm10,(%rdx)
    a30c:	62 71 7c 48 29 1a    	vmovaps %zmm11,(%rdx)
    a312:	62 71 7c 48 29 22    	vmovaps %zmm12,(%rdx)
    a318:	62 71 7c 48 29 2a    	vmovaps %zmm13,(%rdx)
    a31e:	62 71 7c 48 29 32    	vmovaps %zmm14,(%rdx)
    a324:	4c 29 cf             	sub    %r9,%rdi
    a327:	75 83                	jne    a2ac <store512_loop>
    a329:	41 59                	pop    %r9
    a32b:	41 58                	pop    %r8
    a32d:	59                   	pop    %rcx
    a32e:	5b                   	pop    %rbx
    a32f:	c3                   	retq   

000000000000a330 <pdeptest>:
    a330:	53                   	push   %rbx
    a331:	51                   	push   %rcx
    a332:	41 50                	push   %r8
    a334:	41 51                	push   %r9
    a336:	41 52                	push   %r10
    a338:	41 53                	push   %r11
    a33a:	41 54                	push   %r12
    a33c:	41 55                	push   %r13
    a33e:	41 56                	push   %r14
    a340:	41 57                	push   %r15
    a342:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    a349:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    a350:	48 31 db             	xor    %rbx,%rbx
    a353:	48 31 c9             	xor    %rcx,%rcx
    a356:	4d 31 d2             	xor    %r10,%r10
    a359:	4d 31 db             	xor    %r11,%r11
    a35c:	4d 31 e4             	xor    %r12,%r12
    a35f:	4d 31 ed             	xor    %r13,%r13
    a362:	4d 31 f6             	xor    %r14,%r14
    a365:	4d 31 ff             	xor    %r15,%r15

000000000000a368 <pdeptest_loop>:
    a368:	c4 42 83 f5 f8       	pdep   %r8,%r15,%r15
    a36d:	c4 42 8b f5 f0       	pdep   %r8,%r14,%r14
    a372:	c4 42 93 f5 e8       	pdep   %r8,%r13,%r13
    a377:	c4 42 9b f5 e0       	pdep   %r8,%r12,%r12
    a37c:	c4 42 a3 f5 d8       	pdep   %r8,%r11,%r11
    a381:	c4 42 ab f5 d0       	pdep   %r8,%r10,%r10
    a386:	c4 c2 f3 f5 c8       	pdep   %r8,%rcx,%rcx
    a38b:	c4 c2 e3 f5 d8       	pdep   %r8,%rbx,%rbx
    a390:	c4 42 83 f5 f8       	pdep   %r8,%r15,%r15
    a395:	c4 42 8b f5 f0       	pdep   %r8,%r14,%r14
    a39a:	c4 42 93 f5 e8       	pdep   %r8,%r13,%r13
    a39f:	c4 42 9b f5 e0       	pdep   %r8,%r12,%r12
    a3a4:	c4 42 a3 f5 d8       	pdep   %r8,%r11,%r11
    a3a9:	c4 42 ab f5 d0       	pdep   %r8,%r10,%r10
    a3ae:	c4 c2 f3 f5 c8       	pdep   %r8,%rcx,%rcx
    a3b3:	c4 c2 e3 f5 d8       	pdep   %r8,%rbx,%rbx
    a3b8:	c4 42 83 f5 f8       	pdep   %r8,%r15,%r15
    a3bd:	c4 42 8b f5 f0       	pdep   %r8,%r14,%r14
    a3c2:	c4 42 93 f5 e8       	pdep   %r8,%r13,%r13
    a3c7:	c4 42 9b f5 e0       	pdep   %r8,%r12,%r12
    a3cc:	4c 29 cf             	sub    %r9,%rdi
    a3cf:	75 97                	jne    a368 <pdeptest_loop>
    a3d1:	41 5f                	pop    %r15
    a3d3:	41 5e                	pop    %r14
    a3d5:	41 5d                	pop    %r13
    a3d7:	41 5c                	pop    %r12
    a3d9:	41 5b                	pop    %r11
    a3db:	41 5a                	pop    %r10
    a3dd:	41 59                	pop    %r9
    a3df:	41 58                	pop    %r8
    a3e1:	59                   	pop    %rcx
    a3e2:	5b                   	pop    %rbx
    a3e3:	c3                   	retq   

000000000000a3e4 <pdepmultest>:
    a3e4:	53                   	push   %rbx
    a3e5:	51                   	push   %rcx
    a3e6:	56                   	push   %rsi
    a3e7:	41 50                	push   %r8
    a3e9:	41 51                	push   %r9
    a3eb:	41 52                	push   %r10
    a3ed:	41 53                	push   %r11
    a3ef:	41 54                	push   %r12
    a3f1:	41 55                	push   %r13
    a3f3:	41 56                	push   %r14
    a3f5:	41 57                	push   %r15
    a3f7:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    a3fe:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    a405:	48 31 db             	xor    %rbx,%rbx
    a408:	48 31 c9             	xor    %rcx,%rcx
    a40b:	48 31 f6             	xor    %rsi,%rsi
    a40e:	4d 31 d2             	xor    %r10,%r10
    a411:	4d 31 db             	xor    %r11,%r11
    a414:	4d 31 e4             	xor    %r12,%r12
    a417:	4d 31 ed             	xor    %r13,%r13
    a41a:	4d 31 f6             	xor    %r14,%r14
    a41d:	4d 31 ff             	xor    %r15,%r15

000000000000a420 <pdepmultest_loop>:
    a420:	c4 42 83 f5 f8       	pdep   %r8,%r15,%r15
    a425:	4d 0f af f1          	imul   %r9,%r14
    a429:	c4 42 93 f5 e8       	pdep   %r8,%r13,%r13
    a42e:	4d 0f af e1          	imul   %r9,%r12
    a432:	c4 42 a3 f5 d8       	pdep   %r8,%r11,%r11
    a437:	4d 0f af d1          	imul   %r9,%r10
    a43b:	c4 c2 f3 f5 c8       	pdep   %r8,%rcx,%rcx
    a440:	49 0f af d9          	imul   %r9,%rbx
    a444:	c4 42 83 f5 f8       	pdep   %r8,%r15,%r15
    a449:	49 0f af f1          	imul   %r9,%rsi
    a44d:	c4 42 83 f5 f8       	pdep   %r8,%r15,%r15
    a452:	4d 0f af f1          	imul   %r9,%r14
    a456:	c4 42 93 f5 e8       	pdep   %r8,%r13,%r13
    a45b:	4d 0f af e1          	imul   %r9,%r12
    a45f:	c4 42 a3 f5 d8       	pdep   %r8,%r11,%r11
    a464:	4d 0f af d1          	imul   %r9,%r10
    a468:	c4 c2 f3 f5 c8       	pdep   %r8,%rcx,%rcx
    a46d:	49 0f af d9          	imul   %r9,%rbx
    a471:	c4 42 83 f5 f8       	pdep   %r8,%r15,%r15
    a476:	49 0f af f1          	imul   %r9,%rsi
    a47a:	4c 29 cf             	sub    %r9,%rdi
    a47d:	75 a1                	jne    a420 <pdepmultest_loop>
    a47f:	41 5f                	pop    %r15
    a481:	41 5e                	pop    %r14
    a483:	41 5d                	pop    %r13
    a485:	41 5c                	pop    %r12
    a487:	41 5b                	pop    %r11
    a489:	41 5a                	pop    %r10
    a48b:	41 59                	pop    %r9
    a48d:	41 58                	pop    %r8
    a48f:	5e                   	pop    %rsi
    a490:	59                   	pop    %rcx
    a491:	5b                   	pop    %rbx
    a492:	c3                   	retq   

000000000000a493 <pexttest>:
    a493:	53                   	push   %rbx
    a494:	51                   	push   %rcx
    a495:	41 50                	push   %r8
    a497:	41 51                	push   %r9
    a499:	41 52                	push   %r10
    a49b:	41 53                	push   %r11
    a49d:	41 54                	push   %r12
    a49f:	41 55                	push   %r13
    a4a1:	41 56                	push   %r14
    a4a3:	41 57                	push   %r15
    a4a5:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    a4ac:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    a4b3:	48 31 db             	xor    %rbx,%rbx
    a4b6:	48 31 c9             	xor    %rcx,%rcx
    a4b9:	4d 31 d2             	xor    %r10,%r10
    a4bc:	4d 31 db             	xor    %r11,%r11
    a4bf:	4d 31 e4             	xor    %r12,%r12
    a4c2:	4d 31 ed             	xor    %r13,%r13
    a4c5:	4d 31 f6             	xor    %r14,%r14
    a4c8:	4d 31 ff             	xor    %r15,%r15

000000000000a4cb <pexttest_loop>:
    a4cb:	c4 42 82 f5 f8       	pext   %r8,%r15,%r15
    a4d0:	c4 42 8a f5 f0       	pext   %r8,%r14,%r14
    a4d5:	c4 42 92 f5 e8       	pext   %r8,%r13,%r13
    a4da:	c4 42 9a f5 e0       	pext   %r8,%r12,%r12
    a4df:	c4 42 a2 f5 d8       	pext   %r8,%r11,%r11
    a4e4:	c4 42 aa f5 d0       	pext   %r8,%r10,%r10
    a4e9:	c4 c2 f2 f5 c8       	pext   %r8,%rcx,%rcx
    a4ee:	c4 c2 e2 f5 d8       	pext   %r8,%rbx,%rbx
    a4f3:	c4 42 82 f5 f8       	pext   %r8,%r15,%r15
    a4f8:	c4 42 8a f5 f0       	pext   %r8,%r14,%r14
    a4fd:	c4 42 92 f5 e8       	pext   %r8,%r13,%r13
    a502:	c4 42 9a f5 e0       	pext   %r8,%r12,%r12
    a507:	c4 42 a2 f5 d8       	pext   %r8,%r11,%r11
    a50c:	c4 42 aa f5 d0       	pext   %r8,%r10,%r10
    a511:	c4 c2 f2 f5 c8       	pext   %r8,%rcx,%rcx
    a516:	c4 c2 e2 f5 d8       	pext   %r8,%rbx,%rbx
    a51b:	c4 42 82 f5 f8       	pext   %r8,%r15,%r15
    a520:	c4 42 8a f5 f0       	pext   %r8,%r14,%r14
    a525:	c4 42 92 f5 e8       	pext   %r8,%r13,%r13
    a52a:	c4 42 9a f5 e0       	pext   %r8,%r12,%r12
    a52f:	4c 29 cf             	sub    %r9,%rdi
    a532:	75 97                	jne    a4cb <pexttest_loop>
    a534:	41 5f                	pop    %r15
    a536:	41 5e                	pop    %r14
    a538:	41 5d                	pop    %r13
    a53a:	41 5c                	pop    %r12
    a53c:	41 5b                	pop    %r11
    a53e:	41 5a                	pop    %r10
    a540:	41 59                	pop    %r9
    a542:	41 58                	pop    %r8
    a544:	59                   	pop    %rcx
    a545:	5b                   	pop    %rbx
    a546:	c3                   	retq   

000000000000a547 <depmovtest>:
    a547:	53                   	push   %rbx
    a548:	41 50                	push   %r8
    a54a:	41 51                	push   %r9
    a54c:	41 57                	push   %r15
    a54e:	41 56                	push   %r14
    a550:	41 55                	push   %r13
    a552:	41 54                	push   %r12
    a554:	41 53                	push   %r11
    a556:	41 52                	push   %r10
    a558:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    a55f:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    a566:	48 31 db             	xor    %rbx,%rbx

000000000000a569 <depmovtest_loop>:
    a569:	4d 89 fc             	mov    %r15,%r12
    a56c:	4d 89 e6             	mov    %r12,%r14
    a56f:	4d 89 f5             	mov    %r14,%r13
    a572:	4d 89 eb             	mov    %r13,%r11
    a575:	4d 89 df             	mov    %r11,%r15
    a578:	4d 89 fc             	mov    %r15,%r12
    a57b:	4d 89 e6             	mov    %r12,%r14
    a57e:	4d 89 f5             	mov    %r14,%r13
    a581:	4d 89 eb             	mov    %r13,%r11
    a584:	4d 89 df             	mov    %r11,%r15
    a587:	4d 89 fc             	mov    %r15,%r12
    a58a:	4d 89 e6             	mov    %r12,%r14
    a58d:	4d 89 f5             	mov    %r14,%r13
    a590:	4d 89 eb             	mov    %r13,%r11
    a593:	4d 89 df             	mov    %r11,%r15
    a596:	4d 89 fc             	mov    %r15,%r12
    a599:	4d 89 e6             	mov    %r12,%r14
    a59c:	4d 89 f5             	mov    %r14,%r13
    a59f:	4d 89 eb             	mov    %r13,%r11
    a5a2:	4d 89 df             	mov    %r11,%r15
    a5a5:	4c 29 cf             	sub    %r9,%rdi
    a5a8:	75 bf                	jne    a569 <depmovtest_loop>
    a5aa:	41 5a                	pop    %r10
    a5ac:	41 5b                	pop    %r11
    a5ae:	41 5c                	pop    %r12
    a5b0:	41 5d                	pop    %r13
    a5b2:	41 5e                	pop    %r14
    a5b4:	41 5f                	pop    %r15
    a5b6:	41 59                	pop    %r9
    a5b8:	41 58                	pop    %r8
    a5ba:	5b                   	pop    %rbx
    a5bb:	c3                   	retq   

000000000000a5bc <indepmovtest>:
    a5bc:	53                   	push   %rbx
    a5bd:	51                   	push   %rcx
    a5be:	41 50                	push   %r8
    a5c0:	41 51                	push   %r9
    a5c2:	41 57                	push   %r15
    a5c4:	41 56                	push   %r14
    a5c6:	41 55                	push   %r13
    a5c8:	41 54                	push   %r12
    a5ca:	41 53                	push   %r11
    a5cc:	41 52                	push   %r10
    a5ce:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    a5d5:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    a5dc:	48 31 db             	xor    %rbx,%rbx

000000000000a5df <indepmovtest_loop>:
    a5df:	4d 89 d7             	mov    %r10,%r15
    a5e2:	4d 89 de             	mov    %r11,%r14
    a5e5:	4d 89 e5             	mov    %r12,%r13
    a5e8:	49 89 c7             	mov    %rax,%r15
    a5eb:	49 89 ce             	mov    %rcx,%r14
    a5ee:	4d 89 d7             	mov    %r10,%r15
    a5f1:	4d 89 de             	mov    %r11,%r14
    a5f4:	4d 89 e5             	mov    %r12,%r13
    a5f7:	49 89 c7             	mov    %rax,%r15
    a5fa:	49 89 ce             	mov    %rcx,%r14
    a5fd:	4d 89 d7             	mov    %r10,%r15
    a600:	4d 89 de             	mov    %r11,%r14
    a603:	4d 89 e5             	mov    %r12,%r13
    a606:	49 89 c7             	mov    %rax,%r15
    a609:	49 89 ce             	mov    %rcx,%r14
    a60c:	4d 89 d7             	mov    %r10,%r15
    a60f:	4d 89 de             	mov    %r11,%r14
    a612:	4d 89 e5             	mov    %r12,%r13
    a615:	49 89 c7             	mov    %rax,%r15
    a618:	49 89 ce             	mov    %rcx,%r14
    a61b:	4c 29 cf             	sub    %r9,%rdi
    a61e:	75 bf                	jne    a5df <indepmovtest_loop>
    a620:	41 5a                	pop    %r10
    a622:	41 5b                	pop    %r11
    a624:	41 5c                	pop    %r12
    a626:	41 5d                	pop    %r13
    a628:	41 5e                	pop    %r14
    a62a:	41 5f                	pop    %r15
    a62c:	41 59                	pop    %r9
    a62e:	41 58                	pop    %r8
    a630:	59                   	pop    %rcx
    a631:	5b                   	pop    %rbx
    a632:	c3                   	retq   

000000000000a633 <movzerotest>:
    a633:	53                   	push   %rbx
    a634:	51                   	push   %rcx
    a635:	41 50                	push   %r8
    a637:	41 51                	push   %r9
    a639:	41 57                	push   %r15
    a63b:	41 56                	push   %r14
    a63d:	41 55                	push   %r13
    a63f:	41 54                	push   %r12
    a641:	41 53                	push   %r11
    a643:	41 52                	push   %r10
    a645:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    a64c:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    a653:	48 31 db             	xor    %rbx,%rbx

000000000000a656 <movzerotest_loop>:
    a656:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a65d:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a664:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a66b:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a672:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a679:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a680:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a687:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a68e:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a695:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a69c:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a6a3:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a6aa:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a6b1:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a6b8:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a6bf:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a6c6:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a6cd:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a6d4:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a6db:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15
    a6e2:	4c 29 cf             	sub    %r9,%rdi
    a6e5:	0f 85 6b ff ff ff    	jne    a656 <movzerotest_loop>
    a6eb:	41 5a                	pop    %r10
    a6ed:	41 5b                	pop    %r11
    a6ef:	41 5c                	pop    %r12
    a6f1:	41 5d                	pop    %r13
    a6f3:	41 5e                	pop    %r14
    a6f5:	41 5f                	pop    %r15
    a6f7:	41 59                	pop    %r9
    a6f9:	41 58                	pop    %r8
    a6fb:	59                   	pop    %rcx
    a6fc:	5b                   	pop    %rbx
    a6fd:	c3                   	retq   

000000000000a6fe <xorzerotest>:
    a6fe:	53                   	push   %rbx
    a6ff:	51                   	push   %rcx
    a700:	41 50                	push   %r8
    a702:	41 51                	push   %r9
    a704:	41 57                	push   %r15
    a706:	41 56                	push   %r14
    a708:	41 55                	push   %r13
    a70a:	41 54                	push   %r12
    a70c:	41 53                	push   %r11
    a70e:	41 52                	push   %r10
    a710:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    a717:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    a71e:	48 31 db             	xor    %rbx,%rbx

000000000000a721 <xorzerotest_loop>:
    a721:	4d 31 ff             	xor    %r15,%r15
    a724:	4d 31 ff             	xor    %r15,%r15
    a727:	4d 31 ff             	xor    %r15,%r15
    a72a:	4d 31 ff             	xor    %r15,%r15
    a72d:	4d 31 ff             	xor    %r15,%r15
    a730:	4d 31 ff             	xor    %r15,%r15
    a733:	4d 31 ff             	xor    %r15,%r15
    a736:	4d 31 ff             	xor    %r15,%r15
    a739:	4d 31 ff             	xor    %r15,%r15
    a73c:	4d 31 ff             	xor    %r15,%r15
    a73f:	4d 31 ff             	xor    %r15,%r15
    a742:	4d 31 ff             	xor    %r15,%r15
    a745:	4d 31 ff             	xor    %r15,%r15
    a748:	4d 31 ff             	xor    %r15,%r15
    a74b:	4d 31 ff             	xor    %r15,%r15
    a74e:	4d 31 ff             	xor    %r15,%r15
    a751:	4d 31 ff             	xor    %r15,%r15
    a754:	4d 31 ff             	xor    %r15,%r15
    a757:	4d 31 ff             	xor    %r15,%r15
    a75a:	4d 31 ff             	xor    %r15,%r15
    a75d:	4c 29 cf             	sub    %r9,%rdi
    a760:	75 bf                	jne    a721 <xorzerotest_loop>
    a762:	41 5a                	pop    %r10
    a764:	41 5b                	pop    %r11
    a766:	41 5c                	pop    %r12
    a768:	41 5d                	pop    %r13
    a76a:	41 5e                	pop    %r14
    a76c:	41 5f                	pop    %r15
    a76e:	41 59                	pop    %r9
    a770:	41 58                	pop    %r8
    a772:	59                   	pop    %rcx
    a773:	5b                   	pop    %rbx
    a774:	c3                   	retq   

000000000000a775 <subzerotest>:
    a775:	53                   	push   %rbx
    a776:	51                   	push   %rcx
    a777:	41 50                	push   %r8
    a779:	41 51                	push   %r9
    a77b:	41 57                	push   %r15
    a77d:	41 56                	push   %r14
    a77f:	41 55                	push   %r13
    a781:	41 54                	push   %r12
    a783:	41 53                	push   %r11
    a785:	41 52                	push   %r10
    a787:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    a78e:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    a795:	48 31 db             	xor    %rbx,%rbx

000000000000a798 <subzerotest_loop>:
    a798:	4d 29 ff             	sub    %r15,%r15
    a79b:	4d 29 ff             	sub    %r15,%r15
    a79e:	4d 29 ff             	sub    %r15,%r15
    a7a1:	4d 29 ff             	sub    %r15,%r15
    a7a4:	4d 29 ff             	sub    %r15,%r15
    a7a7:	4d 29 ff             	sub    %r15,%r15
    a7aa:	4d 29 ff             	sub    %r15,%r15
    a7ad:	4d 29 ff             	sub    %r15,%r15
    a7b0:	4d 29 ff             	sub    %r15,%r15
    a7b3:	4d 29 ff             	sub    %r15,%r15
    a7b6:	4d 29 ff             	sub    %r15,%r15
    a7b9:	4d 29 ff             	sub    %r15,%r15
    a7bc:	4d 29 ff             	sub    %r15,%r15
    a7bf:	4d 29 ff             	sub    %r15,%r15
    a7c2:	4d 29 ff             	sub    %r15,%r15
    a7c5:	4d 29 ff             	sub    %r15,%r15
    a7c8:	4d 29 ff             	sub    %r15,%r15
    a7cb:	4d 29 ff             	sub    %r15,%r15
    a7ce:	4d 29 ff             	sub    %r15,%r15
    a7d1:	4d 29 ff             	sub    %r15,%r15
    a7d4:	4c 29 cf             	sub    %r9,%rdi
    a7d7:	75 bf                	jne    a798 <subzerotest_loop>
    a7d9:	41 5a                	pop    %r10
    a7db:	41 5b                	pop    %r11
    a7dd:	41 5c                	pop    %r12
    a7df:	41 5d                	pop    %r13
    a7e1:	41 5e                	pop    %r14
    a7e3:	41 5f                	pop    %r15
    a7e5:	41 59                	pop    %r9
    a7e7:	41 58                	pop    %r8
    a7e9:	59                   	pop    %rcx
    a7ea:	5b                   	pop    %rbx
    a7eb:	c3                   	retq   

000000000000a7ec <depaddimmtest>:
    a7ec:	53                   	push   %rbx
    a7ed:	51                   	push   %rcx
    a7ee:	41 50                	push   %r8
    a7f0:	41 51                	push   %r9
    a7f2:	41 57                	push   %r15
    a7f4:	41 56                	push   %r14
    a7f6:	41 55                	push   %r13
    a7f8:	41 54                	push   %r12
    a7fa:	41 53                	push   %r11
    a7fc:	41 52                	push   %r10
    a7fe:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    a805:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    a80c:	48 31 db             	xor    %rbx,%rbx

000000000000a80f <depaddimmtest_loop>:
    a80f:	49 83 c7 01          	add    $0x1,%r15
    a813:	49 83 c7 02          	add    $0x2,%r15
    a817:	49 83 c7 03          	add    $0x3,%r15
    a81b:	49 83 c7 04          	add    $0x4,%r15
    a81f:	49 83 c7 05          	add    $0x5,%r15
    a823:	49 83 c7 06          	add    $0x6,%r15
    a827:	49 83 c7 07          	add    $0x7,%r15
    a82b:	49 83 c7 08          	add    $0x8,%r15
    a82f:	49 83 c7 09          	add    $0x9,%r15
    a833:	49 83 c7 0a          	add    $0xa,%r15
    a837:	49 83 c7 0b          	add    $0xb,%r15
    a83b:	49 83 c7 0c          	add    $0xc,%r15
    a83f:	49 83 c7 0d          	add    $0xd,%r15
    a843:	49 83 c7 0e          	add    $0xe,%r15
    a847:	49 83 c7 0f          	add    $0xf,%r15
    a84b:	49 83 c7 10          	add    $0x10,%r15
    a84f:	49 83 c7 11          	add    $0x11,%r15
    a853:	49 83 c7 12          	add    $0x12,%r15
    a857:	49 83 c7 13          	add    $0x13,%r15
    a85b:	49 83 c7 14          	add    $0x14,%r15
    a85f:	4c 29 cf             	sub    %r9,%rdi
    a862:	75 ab                	jne    a80f <depaddimmtest_loop>
    a864:	41 5a                	pop    %r10
    a866:	41 5b                	pop    %r11
    a868:	41 5c                	pop    %r12
    a86a:	41 5d                	pop    %r13
    a86c:	41 5e                	pop    %r14
    a86e:	41 5f                	pop    %r15
    a870:	41 59                	pop    %r9
    a872:	41 58                	pop    %r8
    a874:	59                   	pop    %rcx
    a875:	5b                   	pop    %rbx
    a876:	c3                   	retq   

000000000000a877 <depinctest>:
    a877:	53                   	push   %rbx
    a878:	51                   	push   %rcx
    a879:	41 50                	push   %r8
    a87b:	41 51                	push   %r9
    a87d:	41 57                	push   %r15
    a87f:	41 56                	push   %r14
    a881:	41 55                	push   %r13
    a883:	41 54                	push   %r12
    a885:	41 53                	push   %r11
    a887:	41 52                	push   %r10
    a889:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    a890:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    a897:	48 31 db             	xor    %rbx,%rbx

000000000000a89a <depinctest_loop>:
    a89a:	49 ff c7             	inc    %r15
    a89d:	49 ff c7             	inc    %r15
    a8a0:	49 ff c7             	inc    %r15
    a8a3:	49 ff c7             	inc    %r15
    a8a6:	49 ff c7             	inc    %r15
    a8a9:	49 ff c7             	inc    %r15
    a8ac:	49 ff c7             	inc    %r15
    a8af:	49 ff c7             	inc    %r15
    a8b2:	49 ff c7             	inc    %r15
    a8b5:	49 ff c7             	inc    %r15
    a8b8:	49 ff c7             	inc    %r15
    a8bb:	49 ff c7             	inc    %r15
    a8be:	49 ff c7             	inc    %r15
    a8c1:	49 ff c7             	inc    %r15
    a8c4:	49 ff c7             	inc    %r15
    a8c7:	49 ff c7             	inc    %r15
    a8ca:	49 ff c7             	inc    %r15
    a8cd:	49 ff c7             	inc    %r15
    a8d0:	49 ff c7             	inc    %r15
    a8d3:	49 ff c7             	inc    %r15
    a8d6:	4c 29 cf             	sub    %r9,%rdi
    a8d9:	75 bf                	jne    a89a <depinctest_loop>
    a8db:	41 5a                	pop    %r10
    a8dd:	41 5b                	pop    %r11
    a8df:	41 5c                	pop    %r12
    a8e1:	41 5d                	pop    %r13
    a8e3:	41 5e                	pop    %r14
    a8e5:	41 5f                	pop    %r15
    a8e7:	41 59                	pop    %r9
    a8e9:	41 58                	pop    %r8
    a8eb:	59                   	pop    %rcx
    a8ec:	5b                   	pop    %rbx
    a8ed:	c3                   	retq   

000000000000a8ee <depdectest>:
    a8ee:	53                   	push   %rbx
    a8ef:	51                   	push   %rcx
    a8f0:	41 50                	push   %r8
    a8f2:	41 51                	push   %r9
    a8f4:	41 57                	push   %r15
    a8f6:	41 56                	push   %r14
    a8f8:	41 55                	push   %r13
    a8fa:	41 54                	push   %r12
    a8fc:	41 53                	push   %r11
    a8fe:	41 52                	push   %r10
    a900:	49 c7 c0 01 00 00 00 	mov    $0x1,%r8
    a907:	49 c7 c1 14 00 00 00 	mov    $0x14,%r9
    a90e:	4d 31 ff             	xor    %r15,%r15
    a911:	49 f7 d7             	not    %r15
    a914:	48 31 db             	xor    %rbx,%rbx

000000000000a917 <depdectest_loop>:
    a917:	49 ff cf             	dec    %r15
    a91a:	49 ff cf             	dec    %r15
    a91d:	49 ff cf             	dec    %r15
    a920:	49 ff cf             	dec    %r15
    a923:	49 ff cf             	dec    %r15
    a926:	49 ff cf             	dec    %r15
    a929:	49 ff cf             	dec    %r15
    a92c:	49 ff cf             	dec    %r15
    a92f:	49 ff cf             	dec    %r15
    a932:	49 ff cf             	dec    %r15
    a935:	49 ff cf             	dec    %r15
    a938:	49 ff cf             	dec    %r15
    a93b:	49 ff cf             	dec    %r15
    a93e:	49 ff cf             	dec    %r15
    a941:	49 ff cf             	dec    %r15
    a944:	49 ff cf             	dec    %r15
    a947:	49 ff cf             	dec    %r15
    a94a:	49 ff cf             	dec    %r15
    a94d:	49 ff cf             	dec    %r15
    a950:	49 ff cf             	dec    %r15
    a953:	4c 29 cf             	sub    %r9,%rdi
    a956:	75 bf                	jne    a917 <depdectest_loop>
    a958:	41 5a                	pop    %r10
    a95a:	41 5b                	pop    %r11
    a95c:	41 5c                	pop    %r12
    a95e:	41 5d                	pop    %r13
    a960:	41 5e                	pop    %r14
    a962:	41 5f                	pop    %r15
    a964:	41 59                	pop    %r9
    a966:	41 58                	pop    %r8
    a968:	59                   	pop    %rcx
    a969:	5b                   	pop    %rbx
    a96a:	c3                   	retq   
    a96b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000a970 <load128wrapper>:
    a970:	f3 0f 1e fa          	endbr64 
    a974:	48 8b 35 85 37 00 00 	mov    0x3785(%rip),%rsi        # e100 <intTestArr>
    a97b:	e9 73 f6 ff ff       	jmpq   9ff3 <load128>

000000000000a980 <spacedload128wrapper>:
    a980:	f3 0f 1e fa          	endbr64 
    a984:	48 8b 35 75 37 00 00 	mov    0x3775(%rip),%rsi        # e100 <intTestArr>
    a98b:	e9 99 f5 ff ff       	jmpq   9f29 <spacedload128>

000000000000a990 <spacedstorescalarwrapper>:
    a990:	f3 0f 1e fa          	endbr64 
    a994:	48 8b 35 65 37 00 00 	mov    0x3765(%rip),%rsi        # e100 <intTestArr>
    a99b:	e9 e7 f4 ff ff       	jmpq   9e87 <spacedstorescalar>

000000000000a9a0 <load256wrapper>:
    a9a0:	f3 0f 1e fa          	endbr64 
    a9a4:	48 8d 35 15 37 00 00 	lea    0x3715(%rip),%rsi        # e0c0 <fpTestArr>
    a9ab:	e9 c0 f6 ff ff       	jmpq   a070 <load256>

000000000000a9b0 <load512wrapper>:
    a9b0:	f3 0f 1e fa          	endbr64 
    a9b4:	48 8d 35 05 37 00 00 	lea    0x3705(%rip),%rsi        # e0c0 <fpTestArr>
    a9bb:	e9 19 f7 ff ff       	jmpq   a0d9 <load512>

000000000000a9c0 <store128wrapper>:
    a9c0:	f3 0f 1e fa          	endbr64 
    a9c4:	48 8b 35 35 37 00 00 	mov    0x3735(%rip),%rsi        # e100 <intTestArr>
    a9cb:	48 8d 15 6e 36 00 00 	lea    0x366e(%rip),%rdx        # e040 <intSinkArr>
    a9d2:	e9 93 f7 ff ff       	jmpq   a16a <store128>
    a9d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a9de:	00 00 

000000000000a9e0 <store256wrapper>:
    a9e0:	f3 0f 1e fa          	endbr64 
    a9e4:	48 8d 15 95 36 00 00 	lea    0x3695(%rip),%rdx        # e080 <fpSinkArr>
    a9eb:	48 8d 35 ce 36 00 00 	lea    0x36ce(%rip),%rsi        # e0c0 <fpTestArr>
    a9f2:	e9 09 f8 ff ff       	jmpq   a200 <store256>
    a9f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a9fe:	00 00 

000000000000aa00 <store512wrapper>:
    aa00:	f3 0f 1e fa          	endbr64 
    aa04:	48 8d 15 75 36 00 00 	lea    0x3675(%rip),%rdx        # e080 <fpSinkArr>
    aa0b:	48 8d 35 ae 36 00 00 	lea    0x36ae(%rip),%rsi        # e0c0 <fpTestArr>
    aa12:	e9 6a f8 ff ff       	jmpq   a281 <store512>
    aa17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    aa1e:	00 00 

000000000000aa20 <mixfmaandmem256wrapper>:
    aa20:	f3 0f 1e fa          	endbr64 
    aa24:	48 8d 35 95 36 00 00 	lea    0x3695(%rip),%rsi        # e0c0 <fpTestArr>
    aa2b:	e9 03 e9 ff ff       	jmpq   9333 <mixfmaandmem256>

000000000000aa30 <mixfmaaddmem256wrapper>:
    aa30:	f3 0f 1e fa          	endbr64 
    aa34:	48 8d 35 85 36 00 00 	lea    0x3685(%rip),%rsi        # e0c0 <fpTestArr>
    aa3b:	e9 be e9 ff ff       	jmpq   93fe <mixfmaaddmem256>

000000000000aa40 <measureFunction>:
    aa40:	f3 0f 1e fa          	endbr64 
    aa44:	55                   	push   %rbp
    aa45:	48 89 f5             	mov    %rsi,%rbp
    aa48:	53                   	push   %rbx
    aa49:	48 89 fb             	mov    %rdi,%rbx
    aa4c:	48 83 ec 58          	sub    $0x58,%rsp
    aa50:	f3 0f 11 44 24 0c    	movss  %xmm0,0xc(%rsp)
    aa56:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    aa5b:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    aa60:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    aa67:	00 00 
    aa69:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    aa6e:	31 c0                	xor    %eax,%eax
    aa70:	e8 db 65 ff ff       	callq  1050 <gettimeofday@plt>
    aa75:	48 89 df             	mov    %rbx,%rdi
    aa78:	ff d5                	callq  *%rbp
    aa7a:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    aa7f:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    aa84:	e8 c7 65 ff ff       	callq  1050 <gettimeofday@plt>
    aa89:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    aa8e:	48 2b 74 24 28       	sub    0x28(%rsp),%rsi
    aa93:	48 ba cf f7 53 e3 a5 	movabs $0x20c49ba5e353f7cf,%rdx
    aa9a:	9b c4 20 
    aa9d:	48 89 f0             	mov    %rsi,%rax
    aaa0:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    aaa5:	48 2b 4c 24 20       	sub    0x20(%rsp),%rcx
    aaaa:	48 c1 fe 3f          	sar    $0x3f,%rsi
    aaae:	48 f7 ea             	imul   %rdx
    aab1:	48 69 c9 e8 03 00 00 	imul   $0x3e8,%rcx,%rcx
    aab8:	48 c1 fa 07          	sar    $0x7,%rdx
    aabc:	48 29 f2             	sub    %rsi,%rdx
    aabf:	48 01 d1             	add    %rdx,%rcx
    aac2:	78 5c                	js     ab20 <measureFunction+0xe0>
    aac4:	66 0f ef c9          	pxor   %xmm1,%xmm1
    aac8:	f3 48 0f 2a c9       	cvtsi2ss %rcx,%xmm1
    aacd:	f3 0f 5a c9          	cvtss2sd %xmm1,%xmm1
    aad1:	f2 0f 59 0d 9f 15 00 	mulsd  0x159f(%rip),%xmm1        # c078 <_IO_stdin_used+0x1078>
    aad8:	00 
    aad9:	48 85 db             	test   %rbx,%rbx
    aadc:	78 62                	js     ab40 <measureFunction+0x100>
    aade:	66 0f ef c0          	pxor   %xmm0,%xmm0
    aae2:	f3 48 0f 2a c3       	cvtsi2ss %rbx,%xmm0
    aae7:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
    aaeb:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    aaf0:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    aaf7:	00 00 
    aaf9:	f2 0f 5e c8          	divsd  %xmm0,%xmm1
    aafd:	f3 0f 10 05 83 15 00 	movss  0x1583(%rip),%xmm0        # c088 <_IO_stdin_used+0x1088>
    ab04:	00 
    ab05:	f2 0f 5a c9          	cvtsd2ss %xmm1,%xmm1
    ab09:	f3 0f 5e c1          	divss  %xmm1,%xmm0
    ab0d:	f3 0f 5e 44 24 0c    	divss  0xc(%rsp),%xmm0
    ab13:	75 46                	jne    ab5b <measureFunction+0x11b>
    ab15:	48 83 c4 58          	add    $0x58,%rsp
    ab19:	5b                   	pop    %rbx
    ab1a:	5d                   	pop    %rbp
    ab1b:	c3                   	retq   
    ab1c:	0f 1f 40 00          	nopl   0x0(%rax)
    ab20:	48 89 c8             	mov    %rcx,%rax
    ab23:	83 e1 01             	and    $0x1,%ecx
    ab26:	66 0f ef c9          	pxor   %xmm1,%xmm1
    ab2a:	48 d1 e8             	shr    %rax
    ab2d:	48 09 c8             	or     %rcx,%rax
    ab30:	f3 48 0f 2a c8       	cvtsi2ss %rax,%xmm1
    ab35:	f3 0f 58 c9          	addss  %xmm1,%xmm1
    ab39:	eb 92                	jmp    aacd <measureFunction+0x8d>
    ab3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ab40:	48 89 d8             	mov    %rbx,%rax
    ab43:	83 e3 01             	and    $0x1,%ebx
    ab46:	66 0f ef c0          	pxor   %xmm0,%xmm0
    ab4a:	48 d1 e8             	shr    %rax
    ab4d:	48 09 d8             	or     %rbx,%rax
    ab50:	f3 48 0f 2a c0       	cvtsi2ss %rax,%xmm0
    ab55:	f3 0f 58 c0          	addss  %xmm0,%xmm0
    ab59:	eb 8c                	jmp    aae7 <measureFunction+0xa7>
    ab5b:	e8 e0 64 ff ff       	callq  1040 <__stack_chk_fail@plt>

000000000000ab60 <spacedload256wrapper>:
    ab60:	f3 0f 1e fa          	endbr64 
    ab64:	48 8b 35 95 35 00 00 	mov    0x3595(%rip),%rsi        # e100 <intTestArr>
    ab6b:	e9 b9 f3 ff ff       	jmpq   9f29 <spacedload128>

000000000000ab70 <__libc_csu_init>:
    ab70:	f3 0f 1e fa          	endbr64 
    ab74:	41 57                	push   %r15
    ab76:	4c 8d 3d fb 31 00 00 	lea    0x31fb(%rip),%r15        # dd78 <__init_array_start>
    ab7d:	41 56                	push   %r14
    ab7f:	49 89 d6             	mov    %rdx,%r14
    ab82:	41 55                	push   %r13
    ab84:	49 89 f5             	mov    %rsi,%r13
    ab87:	41 54                	push   %r12
    ab89:	41 89 fc             	mov    %edi,%r12d
    ab8c:	55                   	push   %rbp
    ab8d:	48 8d 2d f4 31 00 00 	lea    0x31f4(%rip),%rbp        # dd88 <__do_global_dtors_aux_fini_array_entry>
    ab94:	53                   	push   %rbx
    ab95:	4c 29 fd             	sub    %r15,%rbp
    ab98:	48 83 ec 08          	sub    $0x8,%rsp
    ab9c:	e8 5f 64 ff ff       	callq  1000 <_init>
    aba1:	48 c1 fd 03          	sar    $0x3,%rbp
    aba5:	74 1f                	je     abc6 <__libc_csu_init+0x56>
    aba7:	31 db                	xor    %ebx,%ebx
    aba9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    abb0:	4c 89 f2             	mov    %r14,%rdx
    abb3:	4c 89 ee             	mov    %r13,%rsi
    abb6:	44 89 e7             	mov    %r12d,%edi
    abb9:	41 ff 14 df          	callq  *(%r15,%rbx,8)
    abbd:	48 83 c3 01          	add    $0x1,%rbx
    abc1:	48 39 dd             	cmp    %rbx,%rbp
    abc4:	75 ea                	jne    abb0 <__libc_csu_init+0x40>
    abc6:	48 83 c4 08          	add    $0x8,%rsp
    abca:	5b                   	pop    %rbx
    abcb:	5d                   	pop    %rbp
    abcc:	41 5c                	pop    %r12
    abce:	41 5d                	pop    %r13
    abd0:	41 5e                	pop    %r14
    abd2:	41 5f                	pop    %r15
    abd4:	c3                   	retq   
    abd5:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
    abdc:	00 00 00 00 

000000000000abe0 <__libc_csu_fini>:
    abe0:	f3 0f 1e fa          	endbr64 
    abe4:	c3                   	retq   

Disassembly of section .fini:

000000000000abe8 <_fini>:
    abe8:	f3 0f 1e fa          	endbr64 
    abec:	48 83 ec 08          	sub    $0x8,%rsp
    abf0:	48 83 c4 08          	add    $0x8,%rsp
    abf4:	c3                   	retq   
