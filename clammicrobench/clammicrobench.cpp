#include <stdio.h>
#include<stdint.h>
#include<sys\timeb.h>
#include <stdlib.h>

#include <string.h>

extern "C" uint64_t branch1pad0(uint64_t iterations);
extern "C" uint64_t branch1pad1(uint64_t iterations);
extern "C" uint64_t branch1pad3(uint64_t iterations);
extern "C" uint64_t branch2pad0(uint64_t iterations);
extern "C" uint64_t branch2pad1(uint64_t iterations);
extern "C" uint64_t branch2pad3(uint64_t iterations);
extern "C" uint64_t branch4pad0(uint64_t iterations);
extern "C" uint64_t branch4pad1(uint64_t iterations);
extern "C" uint64_t branch4pad3(uint64_t iterations);
extern "C" uint64_t branch8pad0(uint64_t iterations);
extern "C" uint64_t branch8pad1(uint64_t iterations);
extern "C" uint64_t branch8pad3(uint64_t iterations);
extern "C" uint64_t branch16pad0(uint64_t iterations);
extern "C" uint64_t branch16pad1(uint64_t iterations);
extern "C" uint64_t branch16pad3(uint64_t iterations);
extern "C" uint64_t branch32pad0(uint64_t iterations);
extern "C" uint64_t branch32pad1(uint64_t iterations);
extern "C" uint64_t branch32pad3(uint64_t iterations);
extern "C" uint64_t branch64pad0(uint64_t iterations);
extern "C" uint64_t branch64pad1(uint64_t iterations);
extern "C" uint64_t branch64pad3(uint64_t iterations);
extern "C" uint64_t branch128pad0(uint64_t iterations);
extern "C" uint64_t branch128pad1(uint64_t iterations);
extern "C" uint64_t branch128pad3(uint64_t iterations);
extern "C" uint64_t branch256pad0(uint64_t iterations);
extern "C" uint64_t branch256pad1(uint64_t iterations);
extern "C" uint64_t branch256pad3(uint64_t iterations);
extern "C" uint64_t branch512pad0(uint64_t iterations);
extern "C" uint64_t branch512pad1(uint64_t iterations);
extern "C" uint64_t branch512pad3(uint64_t iterations);
extern "C" uint64_t branch1024pad0(uint64_t iterations);
extern "C" uint64_t branch1024pad1(uint64_t iterations);
extern "C" uint64_t branch1024pad3(uint64_t iterations);
extern "C" uint64_t branch1536pad0(uint64_t iterations);
extern "C" uint64_t branch1536pad1(uint64_t iterations);
extern "C" uint64_t branch1536pad3(uint64_t iterations);
extern "C" uint64_t branch2048pad0(uint64_t iterations);
extern "C" uint64_t branch2048pad1(uint64_t iterations);
extern "C" uint64_t branch2048pad3(uint64_t iterations);
extern "C" uint64_t branch3072pad0(uint64_t iterations);
extern "C" uint64_t branch3072pad1(uint64_t iterations);
extern "C" uint64_t branch3072pad3(uint64_t iterations);
extern "C" uint64_t branch4096pad0(uint64_t iterations);
extern "C" uint64_t branch4096pad1(uint64_t iterations);
extern "C" uint64_t branch4096pad3(uint64_t iterations);
extern "C" uint64_t branch5120pad0(uint64_t iterations);
extern "C" uint64_t branch5120pad1(uint64_t iterations);
extern "C" uint64_t branch5120pad3(uint64_t iterations);
extern "C" uint64_t branch6144pad0(uint64_t iterations);
extern "C" uint64_t branch6144pad1(uint64_t iterations);
extern "C" uint64_t branch6144pad3(uint64_t iterations);
extern "C" uint64_t branch7168pad0(uint64_t iterations);
extern "C" uint64_t branch7168pad1(uint64_t iterations);
extern "C" uint64_t branch7168pad3(uint64_t iterations);
extern "C" uint64_t branch8192pad0(uint64_t iterations);
extern "C" uint64_t branch8192pad1(uint64_t iterations);
extern "C" uint64_t branch8192pad3(uint64_t iterations);
extern "C" uint64_t branch10240pad0(uint64_t iterations);
extern "C" uint64_t branch10240pad1(uint64_t iterations);
extern "C" uint64_t branch10240pad3(uint64_t iterations);
extern "C" uint64_t branch16384pad0(uint64_t iterations);
extern "C" uint64_t branch16384pad1(uint64_t iterations);
extern "C" uint64_t branch16384pad3(uint64_t iterations);
extern "C" uint64_t branch32768pad0(uint64_t iterations);
extern "C" uint64_t branch32768pad1(uint64_t iterations);
extern "C" uint64_t branch32768pad3(uint64_t iterations);
extern "C" uint64_t rob4(uint64_t iterations, int *arr);
extern "C" uint64_t rob5(uint64_t iterations, int *arr);
extern "C" uint64_t rob6(uint64_t iterations, int *arr);
extern "C" uint64_t rob7(uint64_t iterations, int *arr);
extern "C" uint64_t rob8(uint64_t iterations, int *arr);
extern "C" uint64_t rob9(uint64_t iterations, int *arr);
extern "C" uint64_t rob10(uint64_t iterations, int *arr);
extern "C" uint64_t rob11(uint64_t iterations, int *arr);
extern "C" uint64_t rob12(uint64_t iterations, int *arr);
extern "C" uint64_t rob13(uint64_t iterations, int *arr);
extern "C" uint64_t rob14(uint64_t iterations, int *arr);
extern "C" uint64_t rob15(uint64_t iterations, int *arr);
extern "C" uint64_t rob16(uint64_t iterations, int *arr);
extern "C" uint64_t rob17(uint64_t iterations, int *arr);
extern "C" uint64_t rob18(uint64_t iterations, int *arr);
extern "C" uint64_t rob19(uint64_t iterations, int *arr);
extern "C" uint64_t rob20(uint64_t iterations, int *arr);
extern "C" uint64_t rob21(uint64_t iterations, int *arr);
extern "C" uint64_t rob22(uint64_t iterations, int *arr);
extern "C" uint64_t rob23(uint64_t iterations, int *arr);
extern "C" uint64_t rob24(uint64_t iterations, int *arr);
extern "C" uint64_t rob25(uint64_t iterations, int *arr);
extern "C" uint64_t rob26(uint64_t iterations, int *arr);
extern "C" uint64_t rob27(uint64_t iterations, int *arr);
extern "C" uint64_t rob28(uint64_t iterations, int *arr);
extern "C" uint64_t rob29(uint64_t iterations, int *arr);
extern "C" uint64_t rob30(uint64_t iterations, int *arr);
extern "C" uint64_t rob31(uint64_t iterations, int *arr);
extern "C" uint64_t rob32(uint64_t iterations, int *arr);
extern "C" uint64_t rob33(uint64_t iterations, int *arr);
extern "C" uint64_t rob34(uint64_t iterations, int *arr);
extern "C" uint64_t rob35(uint64_t iterations, int *arr);
extern "C" uint64_t rob36(uint64_t iterations, int *arr);
extern "C" uint64_t rob37(uint64_t iterations, int *arr);
extern "C" uint64_t rob38(uint64_t iterations, int *arr);
extern "C" uint64_t rob39(uint64_t iterations, int *arr);
extern "C" uint64_t rob40(uint64_t iterations, int *arr);
extern "C" uint64_t rob41(uint64_t iterations, int *arr);
extern "C" uint64_t rob42(uint64_t iterations, int *arr);
extern "C" uint64_t rob43(uint64_t iterations, int *arr);
extern "C" uint64_t rob44(uint64_t iterations, int *arr);
extern "C" uint64_t rob45(uint64_t iterations, int *arr);
extern "C" uint64_t rob46(uint64_t iterations, int *arr);
extern "C" uint64_t rob47(uint64_t iterations, int *arr);
extern "C" uint64_t rob48(uint64_t iterations, int *arr);
extern "C" uint64_t rob49(uint64_t iterations, int *arr);
extern "C" uint64_t rob50(uint64_t iterations, int *arr);
extern "C" uint64_t rob51(uint64_t iterations, int *arr);
extern "C" uint64_t rob52(uint64_t iterations, int *arr);
extern "C" uint64_t rob53(uint64_t iterations, int *arr);
extern "C" uint64_t rob54(uint64_t iterations, int *arr);
extern "C" uint64_t rob55(uint64_t iterations, int *arr);
extern "C" uint64_t rob56(uint64_t iterations, int *arr);
extern "C" uint64_t rob57(uint64_t iterations, int *arr);
extern "C" uint64_t rob58(uint64_t iterations, int *arr);
extern "C" uint64_t rob59(uint64_t iterations, int *arr);
extern "C" uint64_t rob60(uint64_t iterations, int *arr);
extern "C" uint64_t rob61(uint64_t iterations, int *arr);
extern "C" uint64_t rob62(uint64_t iterations, int *arr);
extern "C" uint64_t rob63(uint64_t iterations, int *arr);
extern "C" uint64_t rob64(uint64_t iterations, int *arr);
extern "C" uint64_t rob65(uint64_t iterations, int *arr);
extern "C" uint64_t rob66(uint64_t iterations, int *arr);
extern "C" uint64_t rob67(uint64_t iterations, int *arr);
extern "C" uint64_t rob68(uint64_t iterations, int *arr);
extern "C" uint64_t rob69(uint64_t iterations, int *arr);
extern "C" uint64_t rob70(uint64_t iterations, int *arr);
extern "C" uint64_t rob71(uint64_t iterations, int *arr);
extern "C" uint64_t rob72(uint64_t iterations, int *arr);
extern "C" uint64_t rob73(uint64_t iterations, int *arr);
extern "C" uint64_t rob74(uint64_t iterations, int *arr);
extern "C" uint64_t rob75(uint64_t iterations, int *arr);
extern "C" uint64_t rob76(uint64_t iterations, int *arr);
extern "C" uint64_t rob77(uint64_t iterations, int *arr);
extern "C" uint64_t rob78(uint64_t iterations, int *arr);
extern "C" uint64_t rob79(uint64_t iterations, int *arr);
extern "C" uint64_t rob80(uint64_t iterations, int *arr);
extern "C" uint64_t rob81(uint64_t iterations, int *arr);
extern "C" uint64_t rob82(uint64_t iterations, int *arr);
extern "C" uint64_t rob83(uint64_t iterations, int *arr);
extern "C" uint64_t rob84(uint64_t iterations, int *arr);
extern "C" uint64_t rob85(uint64_t iterations, int *arr);
extern "C" uint64_t rob86(uint64_t iterations, int *arr);
extern "C" uint64_t rob87(uint64_t iterations, int *arr);
extern "C" uint64_t rob88(uint64_t iterations, int *arr);
extern "C" uint64_t rob89(uint64_t iterations, int *arr);
extern "C" uint64_t rob90(uint64_t iterations, int *arr);
extern "C" uint64_t rob91(uint64_t iterations, int *arr);
extern "C" uint64_t rob92(uint64_t iterations, int *arr);
extern "C" uint64_t rob93(uint64_t iterations, int *arr);
extern "C" uint64_t rob94(uint64_t iterations, int *arr);
extern "C" uint64_t rob95(uint64_t iterations, int *arr);
extern "C" uint64_t rob96(uint64_t iterations, int *arr);
extern "C" uint64_t rob97(uint64_t iterations, int *arr);
extern "C" uint64_t rob98(uint64_t iterations, int *arr);
extern "C" uint64_t rob99(uint64_t iterations, int *arr);
extern "C" uint64_t rob100(uint64_t iterations, int *arr);
extern "C" uint64_t rob101(uint64_t iterations, int *arr);
extern "C" uint64_t rob102(uint64_t iterations, int *arr);
extern "C" uint64_t rob103(uint64_t iterations, int *arr);
extern "C" uint64_t rob104(uint64_t iterations, int *arr);
extern "C" uint64_t rob105(uint64_t iterations, int *arr);
extern "C" uint64_t rob106(uint64_t iterations, int *arr);
extern "C" uint64_t rob107(uint64_t iterations, int *arr);
extern "C" uint64_t rob108(uint64_t iterations, int *arr);
extern "C" uint64_t rob109(uint64_t iterations, int *arr);
extern "C" uint64_t rob110(uint64_t iterations, int *arr);
extern "C" uint64_t rob111(uint64_t iterations, int *arr);
extern "C" uint64_t rob112(uint64_t iterations, int *arr);
extern "C" uint64_t rob113(uint64_t iterations, int *arr);
extern "C" uint64_t rob114(uint64_t iterations, int *arr);
extern "C" uint64_t rob115(uint64_t iterations, int *arr);
extern "C" uint64_t rob116(uint64_t iterations, int *arr);
extern "C" uint64_t rob117(uint64_t iterations, int *arr);
extern "C" uint64_t rob118(uint64_t iterations, int *arr);
extern "C" uint64_t rob119(uint64_t iterations, int *arr);
extern "C" uint64_t rob120(uint64_t iterations, int *arr);
extern "C" uint64_t rob121(uint64_t iterations, int *arr);
extern "C" uint64_t rob122(uint64_t iterations, int *arr);
extern "C" uint64_t rob123(uint64_t iterations, int *arr);
extern "C" uint64_t rob124(uint64_t iterations, int *arr);
extern "C" uint64_t rob125(uint64_t iterations, int *arr);
extern "C" uint64_t rob126(uint64_t iterations, int *arr);
extern "C" uint64_t rob127(uint64_t iterations, int *arr);
extern "C" uint64_t rob128(uint64_t iterations, int *arr);
extern "C" uint64_t rob129(uint64_t iterations, int *arr);
extern "C" uint64_t rob130(uint64_t iterations, int *arr);
extern "C" uint64_t rob131(uint64_t iterations, int *arr);
extern "C" uint64_t rob132(uint64_t iterations, int *arr);
extern "C" uint64_t rob133(uint64_t iterations, int *arr);
extern "C" uint64_t rob134(uint64_t iterations, int *arr);
extern "C" uint64_t rob135(uint64_t iterations, int *arr);
extern "C" uint64_t rob136(uint64_t iterations, int *arr);
extern "C" uint64_t rob137(uint64_t iterations, int *arr);
extern "C" uint64_t rob138(uint64_t iterations, int *arr);
extern "C" uint64_t rob139(uint64_t iterations, int *arr);
extern "C" uint64_t rob140(uint64_t iterations, int *arr);
extern "C" uint64_t rob141(uint64_t iterations, int *arr);
extern "C" uint64_t rob142(uint64_t iterations, int *arr);
extern "C" uint64_t rob143(uint64_t iterations, int *arr);
extern "C" uint64_t rob144(uint64_t iterations, int *arr);
extern "C" uint64_t rob145(uint64_t iterations, int *arr);
extern "C" uint64_t rob146(uint64_t iterations, int *arr);
extern "C" uint64_t rob147(uint64_t iterations, int *arr);
extern "C" uint64_t rob148(uint64_t iterations, int *arr);
extern "C" uint64_t rob149(uint64_t iterations, int *arr);
extern "C" uint64_t rob150(uint64_t iterations, int *arr);
extern "C" uint64_t rob151(uint64_t iterations, int *arr);
extern "C" uint64_t rob152(uint64_t iterations, int *arr);
extern "C" uint64_t rob153(uint64_t iterations, int *arr);
extern "C" uint64_t rob154(uint64_t iterations, int *arr);
extern "C" uint64_t rob155(uint64_t iterations, int *arr);
extern "C" uint64_t rob156(uint64_t iterations, int *arr);
extern "C" uint64_t rob157(uint64_t iterations, int *arr);
extern "C" uint64_t rob158(uint64_t iterations, int *arr);
extern "C" uint64_t rob159(uint64_t iterations, int *arr);
extern "C" uint64_t rob160(uint64_t iterations, int *arr);
extern "C" uint64_t rob161(uint64_t iterations, int *arr);
extern "C" uint64_t rob162(uint64_t iterations, int *arr);
extern "C" uint64_t rob163(uint64_t iterations, int *arr);
extern "C" uint64_t rob164(uint64_t iterations, int *arr);
extern "C" uint64_t rob165(uint64_t iterations, int *arr);
extern "C" uint64_t rob166(uint64_t iterations, int *arr);
extern "C" uint64_t rob167(uint64_t iterations, int *arr);
extern "C" uint64_t rob168(uint64_t iterations, int *arr);
extern "C" uint64_t rob169(uint64_t iterations, int *arr);
extern "C" uint64_t rob170(uint64_t iterations, int *arr);
extern "C" uint64_t rob171(uint64_t iterations, int *arr);
extern "C" uint64_t rob172(uint64_t iterations, int *arr);
extern "C" uint64_t rob173(uint64_t iterations, int *arr);
extern "C" uint64_t rob174(uint64_t iterations, int *arr);
extern "C" uint64_t rob175(uint64_t iterations, int *arr);
extern "C" uint64_t rob176(uint64_t iterations, int *arr);
extern "C" uint64_t rob177(uint64_t iterations, int *arr);
extern "C" uint64_t rob178(uint64_t iterations, int *arr);
extern "C" uint64_t rob179(uint64_t iterations, int *arr);
extern "C" uint64_t rob180(uint64_t iterations, int *arr);
extern "C" uint64_t rob181(uint64_t iterations, int *arr);
extern "C" uint64_t rob182(uint64_t iterations, int *arr);
extern "C" uint64_t rob183(uint64_t iterations, int *arr);
extern "C" uint64_t rob184(uint64_t iterations, int *arr);
extern "C" uint64_t rob185(uint64_t iterations, int *arr);
extern "C" uint64_t rob186(uint64_t iterations, int *arr);
extern "C" uint64_t rob187(uint64_t iterations, int *arr);
extern "C" uint64_t rob188(uint64_t iterations, int *arr);
extern "C" uint64_t rob189(uint64_t iterations, int *arr);
extern "C" uint64_t rob190(uint64_t iterations, int *arr);
extern "C" uint64_t rob191(uint64_t iterations, int *arr);
extern "C" uint64_t rob192(uint64_t iterations, int *arr);
extern "C" uint64_t rob193(uint64_t iterations, int *arr);
extern "C" uint64_t rob194(uint64_t iterations, int *arr);
extern "C" uint64_t rob195(uint64_t iterations, int *arr);
extern "C" uint64_t rob196(uint64_t iterations, int *arr);
extern "C" uint64_t rob197(uint64_t iterations, int *arr);
extern "C" uint64_t rob198(uint64_t iterations, int *arr);
extern "C" uint64_t rob199(uint64_t iterations, int *arr);
extern "C" uint64_t rob200(uint64_t iterations, int *arr);
extern "C" uint64_t rob201(uint64_t iterations, int *arr);
extern "C" uint64_t rob202(uint64_t iterations, int *arr);
extern "C" uint64_t rob203(uint64_t iterations, int *arr);
extern "C" uint64_t rob204(uint64_t iterations, int *arr);
extern "C" uint64_t rob205(uint64_t iterations, int *arr);
extern "C" uint64_t rob206(uint64_t iterations, int *arr);
extern "C" uint64_t rob207(uint64_t iterations, int *arr);
extern "C" uint64_t rob208(uint64_t iterations, int *arr);
extern "C" uint64_t rob209(uint64_t iterations, int *arr);
extern "C" uint64_t rob210(uint64_t iterations, int *arr);
extern "C" uint64_t rob211(uint64_t iterations, int *arr);
extern "C" uint64_t rob212(uint64_t iterations, int *arr);
extern "C" uint64_t rob213(uint64_t iterations, int *arr);
extern "C" uint64_t rob214(uint64_t iterations, int *arr);
extern "C" uint64_t rob215(uint64_t iterations, int *arr);
extern "C" uint64_t rob216(uint64_t iterations, int *arr);
extern "C" uint64_t rob217(uint64_t iterations, int *arr);
extern "C" uint64_t rob218(uint64_t iterations, int *arr);
extern "C" uint64_t rob219(uint64_t iterations, int *arr);
extern "C" uint64_t rob220(uint64_t iterations, int *arr);
extern "C" uint64_t rob221(uint64_t iterations, int *arr);
extern "C" uint64_t rob222(uint64_t iterations, int *arr);
extern "C" uint64_t rob223(uint64_t iterations, int *arr);
extern "C" uint64_t rob224(uint64_t iterations, int *arr);
extern "C" uint64_t rob225(uint64_t iterations, int *arr);
extern "C" uint64_t rob226(uint64_t iterations, int *arr);
extern "C" uint64_t rob227(uint64_t iterations, int *arr);
extern "C" uint64_t rob228(uint64_t iterations, int *arr);
extern "C" uint64_t rob229(uint64_t iterations, int *arr);
extern "C" uint64_t rob230(uint64_t iterations, int *arr);
extern "C" uint64_t rob231(uint64_t iterations, int *arr);
extern "C" uint64_t rob232(uint64_t iterations, int *arr);
extern "C" uint64_t rob233(uint64_t iterations, int *arr);
extern "C" uint64_t rob234(uint64_t iterations, int *arr);
extern "C" uint64_t rob235(uint64_t iterations, int *arr);
extern "C" uint64_t rob236(uint64_t iterations, int *arr);
extern "C" uint64_t rob237(uint64_t iterations, int *arr);
extern "C" uint64_t rob238(uint64_t iterations, int *arr);
extern "C" uint64_t rob239(uint64_t iterations, int *arr);
extern "C" uint64_t rob240(uint64_t iterations, int *arr);
extern "C" uint64_t rob241(uint64_t iterations, int *arr);
extern "C" uint64_t rob242(uint64_t iterations, int *arr);
extern "C" uint64_t rob243(uint64_t iterations, int *arr);
extern "C" uint64_t rob244(uint64_t iterations, int *arr);
extern "C" uint64_t rob245(uint64_t iterations, int *arr);
extern "C" uint64_t rob246(uint64_t iterations, int *arr);
extern "C" uint64_t rob247(uint64_t iterations, int *arr);
extern "C" uint64_t rob248(uint64_t iterations, int *arr);
extern "C" uint64_t rob249(uint64_t iterations, int *arr);
extern "C" uint64_t rob250(uint64_t iterations, int *arr);
extern "C" uint64_t rob251(uint64_t iterations, int *arr);
extern "C" uint64_t rob252(uint64_t iterations, int *arr);
extern "C" uint64_t rob253(uint64_t iterations, int *arr);
extern "C" uint64_t rob254(uint64_t iterations, int *arr);
extern "C" uint64_t rob255(uint64_t iterations, int *arr);
extern "C" uint64_t rob256(uint64_t iterations, int *arr);
extern "C" uint64_t rob257(uint64_t iterations, int *arr);
extern "C" uint64_t rob258(uint64_t iterations, int *arr);
extern "C" uint64_t rob259(uint64_t iterations, int *arr);
extern "C" uint64_t rob260(uint64_t iterations, int *arr);
extern "C" uint64_t rob261(uint64_t iterations, int *arr);
extern "C" uint64_t rob262(uint64_t iterations, int *arr);
extern "C" uint64_t rob263(uint64_t iterations, int *arr);
extern "C" uint64_t rob264(uint64_t iterations, int *arr);
extern "C" uint64_t rob265(uint64_t iterations, int *arr);
extern "C" uint64_t rob266(uint64_t iterations, int *arr);
extern "C" uint64_t rob267(uint64_t iterations, int *arr);
extern "C" uint64_t rob268(uint64_t iterations, int *arr);
extern "C" uint64_t rob269(uint64_t iterations, int *arr);
extern "C" uint64_t rob270(uint64_t iterations, int *arr);
extern "C" uint64_t rob271(uint64_t iterations, int *arr);
extern "C" uint64_t rob272(uint64_t iterations, int *arr);
extern "C" uint64_t rob273(uint64_t iterations, int *arr);
extern "C" uint64_t rob274(uint64_t iterations, int *arr);
extern "C" uint64_t rob275(uint64_t iterations, int *arr);
extern "C" uint64_t rob276(uint64_t iterations, int *arr);
extern "C" uint64_t rob277(uint64_t iterations, int *arr);
extern "C" uint64_t rob278(uint64_t iterations, int *arr);
extern "C" uint64_t rob279(uint64_t iterations, int *arr);
extern "C" uint64_t rob280(uint64_t iterations, int *arr);
extern "C" uint64_t rob281(uint64_t iterations, int *arr);
extern "C" uint64_t rob282(uint64_t iterations, int *arr);
extern "C" uint64_t rob283(uint64_t iterations, int *arr);
extern "C" uint64_t rob284(uint64_t iterations, int *arr);
extern "C" uint64_t rob285(uint64_t iterations, int *arr);
extern "C" uint64_t rob286(uint64_t iterations, int *arr);
extern "C" uint64_t rob287(uint64_t iterations, int *arr);
extern "C" uint64_t rob288(uint64_t iterations, int *arr);
extern "C" uint64_t rob289(uint64_t iterations, int *arr);
extern "C" uint64_t rob290(uint64_t iterations, int *arr);
extern "C" uint64_t rob291(uint64_t iterations, int *arr);
extern "C" uint64_t rob292(uint64_t iterations, int *arr);
extern "C" uint64_t rob293(uint64_t iterations, int *arr);
extern "C" uint64_t rob294(uint64_t iterations, int *arr);
extern "C" uint64_t rob295(uint64_t iterations, int *arr);
extern "C" uint64_t rob296(uint64_t iterations, int *arr);
extern "C" uint64_t rob297(uint64_t iterations, int *arr);
extern "C" uint64_t rob298(uint64_t iterations, int *arr);
extern "C" uint64_t rob299(uint64_t iterations, int *arr);
extern "C" uint64_t rob0(uint64_t iterations, int *arr);
extern "C" uint64_t prf4(uint64_t iterations, int *arr);
extern "C" uint64_t prf8(uint64_t iterations, int *arr);
extern "C" uint64_t prf12(uint64_t iterations, int *arr);
extern "C" uint64_t prf16(uint64_t iterations, int *arr);
extern "C" uint64_t prf20(uint64_t iterations, int *arr);
extern "C" uint64_t prf24(uint64_t iterations, int *arr);
extern "C" uint64_t prf28(uint64_t iterations, int *arr);
extern "C" uint64_t prf32(uint64_t iterations, int *arr);
extern "C" uint64_t prf36(uint64_t iterations, int *arr);
extern "C" uint64_t prf40(uint64_t iterations, int *arr);
extern "C" uint64_t prf44(uint64_t iterations, int *arr);
extern "C" uint64_t prf48(uint64_t iterations, int *arr);
extern "C" uint64_t prf52(uint64_t iterations, int *arr);
extern "C" uint64_t prf56(uint64_t iterations, int *arr);
extern "C" uint64_t prf60(uint64_t iterations, int *arr);
extern "C" uint64_t prf64(uint64_t iterations, int *arr);
extern "C" uint64_t prf68(uint64_t iterations, int *arr);
extern "C" uint64_t prf72(uint64_t iterations, int *arr);
extern "C" uint64_t prf76(uint64_t iterations, int *arr);
extern "C" uint64_t prf80(uint64_t iterations, int *arr);
extern "C" uint64_t prf84(uint64_t iterations, int *arr);
extern "C" uint64_t prf88(uint64_t iterations, int *arr);
extern "C" uint64_t prf92(uint64_t iterations, int *arr);
extern "C" uint64_t prf96(uint64_t iterations, int *arr);
extern "C" uint64_t prf100(uint64_t iterations, int *arr);
extern "C" uint64_t prf104(uint64_t iterations, int *arr);
extern "C" uint64_t prf108(uint64_t iterations, int *arr);
extern "C" uint64_t prf112(uint64_t iterations, int *arr);
extern "C" uint64_t prf116(uint64_t iterations, int *arr);
extern "C" uint64_t prf120(uint64_t iterations, int *arr);
extern "C" uint64_t prf124(uint64_t iterations, int *arr);
extern "C" uint64_t prf128(uint64_t iterations, int *arr);
extern "C" uint64_t prf132(uint64_t iterations, int *arr);
extern "C" uint64_t prf136(uint64_t iterations, int *arr);
extern "C" uint64_t prf140(uint64_t iterations, int *arr);
extern "C" uint64_t prf144(uint64_t iterations, int *arr);
extern "C" uint64_t prf148(uint64_t iterations, int *arr);
extern "C" uint64_t prf152(uint64_t iterations, int *arr);
extern "C" uint64_t prf156(uint64_t iterations, int *arr);
extern "C" uint64_t prf160(uint64_t iterations, int *arr);
extern "C" uint64_t prf164(uint64_t iterations, int *arr);
extern "C" uint64_t prf168(uint64_t iterations, int *arr);
extern "C" uint64_t prf172(uint64_t iterations, int *arr);
extern "C" uint64_t prf176(uint64_t iterations, int *arr);
extern "C" uint64_t prf180(uint64_t iterations, int *arr);
extern "C" uint64_t prf184(uint64_t iterations, int *arr);
extern "C" uint64_t prf188(uint64_t iterations, int *arr);
extern "C" uint64_t prf192(uint64_t iterations, int *arr);
extern "C" uint64_t prf196(uint64_t iterations, int *arr);
extern "C" uint64_t frf4(uint64_t iterations, int *arr);
extern "C" uint64_t frf8(uint64_t iterations, int *arr);
extern "C" uint64_t frf12(uint64_t iterations, int *arr);
extern "C" uint64_t frf16(uint64_t iterations, int *arr);
extern "C" uint64_t frf20(uint64_t iterations, int *arr);
extern "C" uint64_t frf24(uint64_t iterations, int *arr);
extern "C" uint64_t frf28(uint64_t iterations, int *arr);
extern "C" uint64_t frf32(uint64_t iterations, int *arr);
extern "C" uint64_t frf36(uint64_t iterations, int *arr);
extern "C" uint64_t frf40(uint64_t iterations, int *arr);
extern "C" uint64_t frf44(uint64_t iterations, int *arr);
extern "C" uint64_t frf48(uint64_t iterations, int *arr);
extern "C" uint64_t frf52(uint64_t iterations, int *arr);
extern "C" uint64_t frf56(uint64_t iterations, int *arr);
extern "C" uint64_t frf60(uint64_t iterations, int *arr);
extern "C" uint64_t frf64(uint64_t iterations, int *arr);
extern "C" uint64_t frf68(uint64_t iterations, int *arr);
extern "C" uint64_t frf72(uint64_t iterations, int *arr);
extern "C" uint64_t frf76(uint64_t iterations, int *arr);
extern "C" uint64_t frf80(uint64_t iterations, int *arr);
extern "C" uint64_t frf84(uint64_t iterations, int *arr);
extern "C" uint64_t frf88(uint64_t iterations, int *arr);
extern "C" uint64_t frf92(uint64_t iterations, int *arr);
extern "C" uint64_t frf96(uint64_t iterations, int *arr);
extern "C" uint64_t frf100(uint64_t iterations, int *arr);
extern "C" uint64_t frf104(uint64_t iterations, int *arr);
extern "C" uint64_t frf108(uint64_t iterations, int *arr);
extern "C" uint64_t frf112(uint64_t iterations, int *arr);
extern "C" uint64_t frf116(uint64_t iterations, int *arr);
extern "C" uint64_t frf120(uint64_t iterations, int *arr);
extern "C" uint64_t frf124(uint64_t iterations, int *arr);
extern "C" uint64_t frf128(uint64_t iterations, int *arr);
extern "C" uint64_t frf132(uint64_t iterations, int *arr);
extern "C" uint64_t frf136(uint64_t iterations, int *arr);
extern "C" uint64_t frf140(uint64_t iterations, int *arr);
extern "C" uint64_t frf144(uint64_t iterations, int *arr);
extern "C" uint64_t frf148(uint64_t iterations, int *arr);
extern "C" uint64_t frf152(uint64_t iterations, int *arr);
extern "C" uint64_t frf156(uint64_t iterations, int *arr);
extern "C" uint64_t frf160(uint64_t iterations, int *arr);
extern "C" uint64_t frf164(uint64_t iterations, int *arr);
extern "C" uint64_t frf168(uint64_t iterations, int *arr);
extern "C" uint64_t frf172(uint64_t iterations, int *arr);
extern "C" uint64_t frf176(uint64_t iterations, int *arr);
extern "C" uint64_t frf180(uint64_t iterations, int *arr);
extern "C" uint64_t frf184(uint64_t iterations, int *arr);
extern "C" uint64_t frf188(uint64_t iterations, int *arr);
extern "C" uint64_t frf192(uint64_t iterations, int *arr);
extern "C" uint64_t frf196(uint64_t iterations, int *arr);
int main(int argc, char *argv[]) {
  uint64_t time_diff_ms, iterations = 500000000, structIterations = 5000000;
  float latency;
  printf("Usage: [rob/prf/branchonly] [latency list size] [struct iterations = 5000000]\n");
  if (argc > 3) { structIterations = atoi(argv[3]); }
  uint32_t list_size = 33554432;
  if (argc > 2) list_size = atoi(argv[2]);
  int* A = (int*)malloc(sizeof(int) * list_size);
  for (int i = 0; i < list_size; i++) { A[i] = i; }

  int iter = list_size;
  while (iter > 1)
  {
      iter -= 1;
      int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
      uint32_t tmp = A[iter];
      A[iter] = A[j];
      A[j] = tmp;
  }
  struct timeb start, end;
  if (argc == 1 || argc > 1 && _strnicmp(argv[1], "rob", 3) == 0) {
  printf("Testing ROB Capacity:\n");
  ftime(&start);
  rob4(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("4,%f\n", latency);

  ftime(&start);
  rob5(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("5,%f\n", latency);

  ftime(&start);
  rob6(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("6,%f\n", latency);

  ftime(&start);
  rob7(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("7,%f\n", latency);

  ftime(&start);
  rob8(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("8,%f\n", latency);

  ftime(&start);
  rob9(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("9,%f\n", latency);

  ftime(&start);
  rob10(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("10,%f\n", latency);

  ftime(&start);
  rob11(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("11,%f\n", latency);

  ftime(&start);
  rob12(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("12,%f\n", latency);

  ftime(&start);
  rob13(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("13,%f\n", latency);

  ftime(&start);
  rob14(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("14,%f\n", latency);

  ftime(&start);
  rob15(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("15,%f\n", latency);

  ftime(&start);
  rob16(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("16,%f\n", latency);

  ftime(&start);
  rob17(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("17,%f\n", latency);

  ftime(&start);
  rob18(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("18,%f\n", latency);

  ftime(&start);
  rob19(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("19,%f\n", latency);

  ftime(&start);
  rob20(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("20,%f\n", latency);

  ftime(&start);
  rob21(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("21,%f\n", latency);

  ftime(&start);
  rob22(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("22,%f\n", latency);

  ftime(&start);
  rob23(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("23,%f\n", latency);

  ftime(&start);
  rob24(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("24,%f\n", latency);

  ftime(&start);
  rob25(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("25,%f\n", latency);

  ftime(&start);
  rob26(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("26,%f\n", latency);

  ftime(&start);
  rob27(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("27,%f\n", latency);

  ftime(&start);
  rob28(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("28,%f\n", latency);

  ftime(&start);
  rob29(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("29,%f\n", latency);

  ftime(&start);
  rob30(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("30,%f\n", latency);

  ftime(&start);
  rob31(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("31,%f\n", latency);

  ftime(&start);
  rob32(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("32,%f\n", latency);

  ftime(&start);
  rob33(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("33,%f\n", latency);

  ftime(&start);
  rob34(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("34,%f\n", latency);

  ftime(&start);
  rob35(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("35,%f\n", latency);

  ftime(&start);
  rob36(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("36,%f\n", latency);

  ftime(&start);
  rob37(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("37,%f\n", latency);

  ftime(&start);
  rob38(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("38,%f\n", latency);

  ftime(&start);
  rob39(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("39,%f\n", latency);

  ftime(&start);
  rob40(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("40,%f\n", latency);

  ftime(&start);
  rob41(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("41,%f\n", latency);

  ftime(&start);
  rob42(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("42,%f\n", latency);

  ftime(&start);
  rob43(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("43,%f\n", latency);

  ftime(&start);
  rob44(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("44,%f\n", latency);

  ftime(&start);
  rob45(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("45,%f\n", latency);

  ftime(&start);
  rob46(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("46,%f\n", latency);

  ftime(&start);
  rob47(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("47,%f\n", latency);

  ftime(&start);
  rob48(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("48,%f\n", latency);

  ftime(&start);
  rob49(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("49,%f\n", latency);

  ftime(&start);
  rob50(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("50,%f\n", latency);

  ftime(&start);
  rob51(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("51,%f\n", latency);

  ftime(&start);
  rob52(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("52,%f\n", latency);

  ftime(&start);
  rob53(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("53,%f\n", latency);

  ftime(&start);
  rob54(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("54,%f\n", latency);

  ftime(&start);
  rob55(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("55,%f\n", latency);

  ftime(&start);
  rob56(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("56,%f\n", latency);

  ftime(&start);
  rob57(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("57,%f\n", latency);

  ftime(&start);
  rob58(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("58,%f\n", latency);

  ftime(&start);
  rob59(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("59,%f\n", latency);

  ftime(&start);
  rob60(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("60,%f\n", latency);

  ftime(&start);
  rob61(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("61,%f\n", latency);

  ftime(&start);
  rob62(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("62,%f\n", latency);

  ftime(&start);
  rob63(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("63,%f\n", latency);

  ftime(&start);
  rob64(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("64,%f\n", latency);

  ftime(&start);
  rob65(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("65,%f\n", latency);

  ftime(&start);
  rob66(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("66,%f\n", latency);

  ftime(&start);
  rob67(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("67,%f\n", latency);

  ftime(&start);
  rob68(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("68,%f\n", latency);

  ftime(&start);
  rob69(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("69,%f\n", latency);

  ftime(&start);
  rob70(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("70,%f\n", latency);

  ftime(&start);
  rob71(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("71,%f\n", latency);

  ftime(&start);
  rob72(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("72,%f\n", latency);

  ftime(&start);
  rob73(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("73,%f\n", latency);

  ftime(&start);
  rob74(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("74,%f\n", latency);

  ftime(&start);
  rob75(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("75,%f\n", latency);

  ftime(&start);
  rob76(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("76,%f\n", latency);

  ftime(&start);
  rob77(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("77,%f\n", latency);

  ftime(&start);
  rob78(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("78,%f\n", latency);

  ftime(&start);
  rob79(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("79,%f\n", latency);

  ftime(&start);
  rob80(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("80,%f\n", latency);

  ftime(&start);
  rob81(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("81,%f\n", latency);

  ftime(&start);
  rob82(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("82,%f\n", latency);

  ftime(&start);
  rob83(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("83,%f\n", latency);

  ftime(&start);
  rob84(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("84,%f\n", latency);

  ftime(&start);
  rob85(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("85,%f\n", latency);

  ftime(&start);
  rob86(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("86,%f\n", latency);

  ftime(&start);
  rob87(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("87,%f\n", latency);

  ftime(&start);
  rob88(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("88,%f\n", latency);

  ftime(&start);
  rob89(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("89,%f\n", latency);

  ftime(&start);
  rob90(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("90,%f\n", latency);

  ftime(&start);
  rob91(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("91,%f\n", latency);

  ftime(&start);
  rob92(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("92,%f\n", latency);

  ftime(&start);
  rob93(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("93,%f\n", latency);

  ftime(&start);
  rob94(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("94,%f\n", latency);

  ftime(&start);
  rob95(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("95,%f\n", latency);

  ftime(&start);
  rob96(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("96,%f\n", latency);

  ftime(&start);
  rob97(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("97,%f\n", latency);

  ftime(&start);
  rob98(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("98,%f\n", latency);

  ftime(&start);
  rob99(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("99,%f\n", latency);

  ftime(&start);
  rob100(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("100,%f\n", latency);

  ftime(&start);
  rob101(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("101,%f\n", latency);

  ftime(&start);
  rob102(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("102,%f\n", latency);

  ftime(&start);
  rob103(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("103,%f\n", latency);

  ftime(&start);
  rob104(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("104,%f\n", latency);

  ftime(&start);
  rob105(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("105,%f\n", latency);

  ftime(&start);
  rob106(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("106,%f\n", latency);

  ftime(&start);
  rob107(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("107,%f\n", latency);

  ftime(&start);
  rob108(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("108,%f\n", latency);

  ftime(&start);
  rob109(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("109,%f\n", latency);

  ftime(&start);
  rob110(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("110,%f\n", latency);

  ftime(&start);
  rob111(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("111,%f\n", latency);

  ftime(&start);
  rob112(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("112,%f\n", latency);

  ftime(&start);
  rob113(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("113,%f\n", latency);

  ftime(&start);
  rob114(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("114,%f\n", latency);

  ftime(&start);
  rob115(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("115,%f\n", latency);

  ftime(&start);
  rob116(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("116,%f\n", latency);

  ftime(&start);
  rob117(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("117,%f\n", latency);

  ftime(&start);
  rob118(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("118,%f\n", latency);

  ftime(&start);
  rob119(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("119,%f\n", latency);

  ftime(&start);
  rob120(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("120,%f\n", latency);

  ftime(&start);
  rob121(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("121,%f\n", latency);

  ftime(&start);
  rob122(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("122,%f\n", latency);

  ftime(&start);
  rob123(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("123,%f\n", latency);

  ftime(&start);
  rob124(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("124,%f\n", latency);

  ftime(&start);
  rob125(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("125,%f\n", latency);

  ftime(&start);
  rob126(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("126,%f\n", latency);

  ftime(&start);
  rob127(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("127,%f\n", latency);

  ftime(&start);
  rob128(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("128,%f\n", latency);

  ftime(&start);
  rob129(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("129,%f\n", latency);

  ftime(&start);
  rob130(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("130,%f\n", latency);

  ftime(&start);
  rob131(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("131,%f\n", latency);

  ftime(&start);
  rob132(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("132,%f\n", latency);

  ftime(&start);
  rob133(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("133,%f\n", latency);

  ftime(&start);
  rob134(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("134,%f\n", latency);

  ftime(&start);
  rob135(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("135,%f\n", latency);

  ftime(&start);
  rob136(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("136,%f\n", latency);

  ftime(&start);
  rob137(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("137,%f\n", latency);

  ftime(&start);
  rob138(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("138,%f\n", latency);

  ftime(&start);
  rob139(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("139,%f\n", latency);

  ftime(&start);
  rob140(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("140,%f\n", latency);

  ftime(&start);
  rob141(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("141,%f\n", latency);

  ftime(&start);
  rob142(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("142,%f\n", latency);

  ftime(&start);
  rob143(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("143,%f\n", latency);

  ftime(&start);
  rob144(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("144,%f\n", latency);

  ftime(&start);
  rob145(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("145,%f\n", latency);

  ftime(&start);
  rob146(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("146,%f\n", latency);

  ftime(&start);
  rob147(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("147,%f\n", latency);

  ftime(&start);
  rob148(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("148,%f\n", latency);

  ftime(&start);
  rob149(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("149,%f\n", latency);

  ftime(&start);
  rob150(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("150,%f\n", latency);

  ftime(&start);
  rob151(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("151,%f\n", latency);

  ftime(&start);
  rob152(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("152,%f\n", latency);

  ftime(&start);
  rob153(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("153,%f\n", latency);

  ftime(&start);
  rob154(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("154,%f\n", latency);

  ftime(&start);
  rob155(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("155,%f\n", latency);

  ftime(&start);
  rob156(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("156,%f\n", latency);

  ftime(&start);
  rob157(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("157,%f\n", latency);

  ftime(&start);
  rob158(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("158,%f\n", latency);

  ftime(&start);
  rob159(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("159,%f\n", latency);

  ftime(&start);
  rob160(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("160,%f\n", latency);

  ftime(&start);
  rob161(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("161,%f\n", latency);

  ftime(&start);
  rob162(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("162,%f\n", latency);

  ftime(&start);
  rob163(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("163,%f\n", latency);

  ftime(&start);
  rob164(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("164,%f\n", latency);

  ftime(&start);
  rob165(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("165,%f\n", latency);

  ftime(&start);
  rob166(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("166,%f\n", latency);

  ftime(&start);
  rob167(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("167,%f\n", latency);

  ftime(&start);
  rob168(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("168,%f\n", latency);

  ftime(&start);
  rob169(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("169,%f\n", latency);

  ftime(&start);
  rob170(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("170,%f\n", latency);

  ftime(&start);
  rob171(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("171,%f\n", latency);

  ftime(&start);
  rob172(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("172,%f\n", latency);

  ftime(&start);
  rob173(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("173,%f\n", latency);

  ftime(&start);
  rob174(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("174,%f\n", latency);

  ftime(&start);
  rob175(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("175,%f\n", latency);

  ftime(&start);
  rob176(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("176,%f\n", latency);

  ftime(&start);
  rob177(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("177,%f\n", latency);

  ftime(&start);
  rob178(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("178,%f\n", latency);

  ftime(&start);
  rob179(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("179,%f\n", latency);

  ftime(&start);
  rob180(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("180,%f\n", latency);

  ftime(&start);
  rob181(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("181,%f\n", latency);

  ftime(&start);
  rob182(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("182,%f\n", latency);

  ftime(&start);
  rob183(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("183,%f\n", latency);

  ftime(&start);
  rob184(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("184,%f\n", latency);

  ftime(&start);
  rob185(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("185,%f\n", latency);

  ftime(&start);
  rob186(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("186,%f\n", latency);

  ftime(&start);
  rob187(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("187,%f\n", latency);

  ftime(&start);
  rob188(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("188,%f\n", latency);

  ftime(&start);
  rob189(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("189,%f\n", latency);

  ftime(&start);
  rob190(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("190,%f\n", latency);

  ftime(&start);
  rob191(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("191,%f\n", latency);

  ftime(&start);
  rob192(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("192,%f\n", latency);

  ftime(&start);
  rob193(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("193,%f\n", latency);

  ftime(&start);
  rob194(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("194,%f\n", latency);

  ftime(&start);
  rob195(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("195,%f\n", latency);

  ftime(&start);
  rob196(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("196,%f\n", latency);

  ftime(&start);
  rob197(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("197,%f\n", latency);

  ftime(&start);
  rob198(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("198,%f\n", latency);

  ftime(&start);
  rob199(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("199,%f\n", latency);

  ftime(&start);
  rob200(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("200,%f\n", latency);

  ftime(&start);
  rob201(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("201,%f\n", latency);

  ftime(&start);
  rob202(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("202,%f\n", latency);

  ftime(&start);
  rob203(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("203,%f\n", latency);

  ftime(&start);
  rob204(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("204,%f\n", latency);

  ftime(&start);
  rob205(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("205,%f\n", latency);

  ftime(&start);
  rob206(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("206,%f\n", latency);

  ftime(&start);
  rob207(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("207,%f\n", latency);

  ftime(&start);
  rob208(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("208,%f\n", latency);

  ftime(&start);
  rob209(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("209,%f\n", latency);

  ftime(&start);
  rob210(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("210,%f\n", latency);

  ftime(&start);
  rob211(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("211,%f\n", latency);

  ftime(&start);
  rob212(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("212,%f\n", latency);

  ftime(&start);
  rob213(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("213,%f\n", latency);

  ftime(&start);
  rob214(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("214,%f\n", latency);

  ftime(&start);
  rob215(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("215,%f\n", latency);

  ftime(&start);
  rob216(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("216,%f\n", latency);

  ftime(&start);
  rob217(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("217,%f\n", latency);

  ftime(&start);
  rob218(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("218,%f\n", latency);

  ftime(&start);
  rob219(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("219,%f\n", latency);

  ftime(&start);
  rob220(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("220,%f\n", latency);

  ftime(&start);
  rob221(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("221,%f\n", latency);

  ftime(&start);
  rob222(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("222,%f\n", latency);

  ftime(&start);
  rob223(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("223,%f\n", latency);

  ftime(&start);
  rob224(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("224,%f\n", latency);

  ftime(&start);
  rob225(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("225,%f\n", latency);

  ftime(&start);
  rob226(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("226,%f\n", latency);

  ftime(&start);
  rob227(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("227,%f\n", latency);

  ftime(&start);
  rob228(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("228,%f\n", latency);

  ftime(&start);
  rob229(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("229,%f\n", latency);

  ftime(&start);
  rob230(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("230,%f\n", latency);

  ftime(&start);
  rob231(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("231,%f\n", latency);

  ftime(&start);
  rob232(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("232,%f\n", latency);

  ftime(&start);
  rob233(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("233,%f\n", latency);

  ftime(&start);
  rob234(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("234,%f\n", latency);

  ftime(&start);
  rob235(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("235,%f\n", latency);

  ftime(&start);
  rob236(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("236,%f\n", latency);

  ftime(&start);
  rob237(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("237,%f\n", latency);

  ftime(&start);
  rob238(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("238,%f\n", latency);

  ftime(&start);
  rob239(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("239,%f\n", latency);

  ftime(&start);
  rob240(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("240,%f\n", latency);

  ftime(&start);
  rob241(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("241,%f\n", latency);

  ftime(&start);
  rob242(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("242,%f\n", latency);

  ftime(&start);
  rob243(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("243,%f\n", latency);

  ftime(&start);
  rob244(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("244,%f\n", latency);

  ftime(&start);
  rob245(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("245,%f\n", latency);

  ftime(&start);
  rob246(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("246,%f\n", latency);

  ftime(&start);
  rob247(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("247,%f\n", latency);

  ftime(&start);
  rob248(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("248,%f\n", latency);

  ftime(&start);
  rob249(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("249,%f\n", latency);

  ftime(&start);
  rob250(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("250,%f\n", latency);

  ftime(&start);
  rob251(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("251,%f\n", latency);

  ftime(&start);
  rob252(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("252,%f\n", latency);

  ftime(&start);
  rob253(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("253,%f\n", latency);

  ftime(&start);
  rob254(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("254,%f\n", latency);

  ftime(&start);
  rob255(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("255,%f\n", latency);

  ftime(&start);
  rob256(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("256,%f\n", latency);

  ftime(&start);
  rob257(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("257,%f\n", latency);

  ftime(&start);
  rob258(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("258,%f\n", latency);

  ftime(&start);
  rob259(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("259,%f\n", latency);

  ftime(&start);
  rob260(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("260,%f\n", latency);

  ftime(&start);
  rob261(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("261,%f\n", latency);

  ftime(&start);
  rob262(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("262,%f\n", latency);

  ftime(&start);
  rob263(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("263,%f\n", latency);

  ftime(&start);
  rob264(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("264,%f\n", latency);

  ftime(&start);
  rob265(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("265,%f\n", latency);

  ftime(&start);
  rob266(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("266,%f\n", latency);

  ftime(&start);
  rob267(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("267,%f\n", latency);

  ftime(&start);
  rob268(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("268,%f\n", latency);

  ftime(&start);
  rob269(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("269,%f\n", latency);

  ftime(&start);
  rob270(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("270,%f\n", latency);

  ftime(&start);
  rob271(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("271,%f\n", latency);

  ftime(&start);
  rob272(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("272,%f\n", latency);

  ftime(&start);
  rob273(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("273,%f\n", latency);

  ftime(&start);
  rob274(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("274,%f\n", latency);

  ftime(&start);
  rob275(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("275,%f\n", latency);

  ftime(&start);
  rob276(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("276,%f\n", latency);

  ftime(&start);
  rob277(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("277,%f\n", latency);

  ftime(&start);
  rob278(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("278,%f\n", latency);

  ftime(&start);
  rob279(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("279,%f\n", latency);

  ftime(&start);
  rob280(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("280,%f\n", latency);

  ftime(&start);
  rob281(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("281,%f\n", latency);

  ftime(&start);
  rob282(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("282,%f\n", latency);

  ftime(&start);
  rob283(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("283,%f\n", latency);

  ftime(&start);
  rob284(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("284,%f\n", latency);

  ftime(&start);
  rob285(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("285,%f\n", latency);

  ftime(&start);
  rob286(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("286,%f\n", latency);

  ftime(&start);
  rob287(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("287,%f\n", latency);

  ftime(&start);
  rob288(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("288,%f\n", latency);

  ftime(&start);
  rob289(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("289,%f\n", latency);

  ftime(&start);
  rob290(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("290,%f\n", latency);

  ftime(&start);
  rob291(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("291,%f\n", latency);

  ftime(&start);
  rob292(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("292,%f\n", latency);

  ftime(&start);
  rob293(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("293,%f\n", latency);

  ftime(&start);
  rob294(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("294,%f\n", latency);

  ftime(&start);
  rob295(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("295,%f\n", latency);

  ftime(&start);
  rob296(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("296,%f\n", latency);

  ftime(&start);
  rob297(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("297,%f\n", latency);

  ftime(&start);
  rob298(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("298,%f\n", latency);

  ftime(&start);
  rob299(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("299,%f\n", latency);

  ftime(&start);
  rob0(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("0,%f\n", latency);

  return 0;
  }

  if (argc == 1 || argc > 1 && _strnicmp(argv[1], "prf", 3) == 0) {
  printf("Testing Register File Capacity:\n");
  ftime(&start);
  prf4(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("4,%f\n", latency);

  ftime(&start);
  prf8(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("8,%f\n", latency);

  ftime(&start);
  prf12(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("12,%f\n", latency);

  ftime(&start);
  prf16(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("16,%f\n", latency);

  ftime(&start);
  prf20(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("20,%f\n", latency);

  ftime(&start);
  prf24(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("24,%f\n", latency);

  ftime(&start);
  prf28(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("28,%f\n", latency);

  ftime(&start);
  prf32(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("32,%f\n", latency);

  ftime(&start);
  prf36(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("36,%f\n", latency);

  ftime(&start);
  prf40(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("40,%f\n", latency);

  ftime(&start);
  prf44(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("44,%f\n", latency);

  ftime(&start);
  prf48(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("48,%f\n", latency);

  ftime(&start);
  prf52(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("52,%f\n", latency);

  ftime(&start);
  prf56(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("56,%f\n", latency);

  ftime(&start);
  prf60(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("60,%f\n", latency);

  ftime(&start);
  prf64(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("64,%f\n", latency);

  ftime(&start);
  prf68(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("68,%f\n", latency);

  ftime(&start);
  prf72(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("72,%f\n", latency);

  ftime(&start);
  prf76(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("76,%f\n", latency);

  ftime(&start);
  prf80(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("80,%f\n", latency);

  ftime(&start);
  prf84(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("84,%f\n", latency);

  ftime(&start);
  prf88(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("88,%f\n", latency);

  ftime(&start);
  prf92(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("92,%f\n", latency);

  ftime(&start);
  prf96(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("96,%f\n", latency);

  ftime(&start);
  prf100(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("100,%f\n", latency);

  ftime(&start);
  prf104(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("104,%f\n", latency);

  ftime(&start);
  prf108(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("108,%f\n", latency);

  ftime(&start);
  prf112(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("112,%f\n", latency);

  ftime(&start);
  prf116(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("116,%f\n", latency);

  ftime(&start);
  prf120(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("120,%f\n", latency);

  ftime(&start);
  prf124(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("124,%f\n", latency);

  ftime(&start);
  prf128(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("128,%f\n", latency);

  ftime(&start);
  prf132(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("132,%f\n", latency);

  ftime(&start);
  prf136(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("136,%f\n", latency);

  ftime(&start);
  prf140(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("140,%f\n", latency);

  ftime(&start);
  prf144(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("144,%f\n", latency);

  ftime(&start);
  prf148(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("148,%f\n", latency);

  ftime(&start);
  prf152(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("152,%f\n", latency);

  ftime(&start);
  prf156(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("156,%f\n", latency);

  ftime(&start);
  prf160(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("160,%f\n", latency);

  ftime(&start);
  prf164(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("164,%f\n", latency);

  ftime(&start);
  prf168(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("168,%f\n", latency);

  ftime(&start);
  prf172(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("172,%f\n", latency);

  ftime(&start);
  prf176(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("176,%f\n", latency);

  ftime(&start);
  prf180(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("180,%f\n", latency);

  ftime(&start);
  prf184(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("184,%f\n", latency);

  ftime(&start);
  prf188(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("188,%f\n", latency);

  ftime(&start);
  prf192(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("192,%f\n", latency);

  ftime(&start);
  prf196(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("196,%f\n", latency);

  return 0;
  }

  if (argc == 1 || argc > 1 && strncmp(argv[1], "frf", 3) == 0) {
  printf("Testing FP Register File Capacity:\n");
  ftime(&start);
  frf4(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("4,%f\n", latency);

  ftime(&start);
  frf8(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("8,%f\n", latency);

  ftime(&start);
  frf12(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("12,%f\n", latency);

  ftime(&start);
  frf16(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("16,%f\n", latency);

  ftime(&start);
  frf20(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("20,%f\n", latency);

  ftime(&start);
  frf24(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("24,%f\n", latency);

  ftime(&start);
  frf28(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("28,%f\n", latency);

  ftime(&start);
  frf32(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("32,%f\n", latency);

  ftime(&start);
  frf36(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("36,%f\n", latency);

  ftime(&start);
  frf40(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("40,%f\n", latency);

  ftime(&start);
  frf44(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("44,%f\n", latency);

  ftime(&start);
  frf48(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("48,%f\n", latency);

  ftime(&start);
  frf52(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("52,%f\n", latency);

  ftime(&start);
  frf56(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("56,%f\n", latency);

  ftime(&start);
  frf60(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("60,%f\n", latency);

  ftime(&start);
  frf64(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("64,%f\n", latency);

  ftime(&start);
  frf68(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("68,%f\n", latency);

  ftime(&start);
  frf72(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("72,%f\n", latency);

  ftime(&start);
  frf76(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("76,%f\n", latency);

  ftime(&start);
  frf80(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("80,%f\n", latency);

  ftime(&start);
  frf84(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("84,%f\n", latency);

  ftime(&start);
  frf88(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("88,%f\n", latency);

  ftime(&start);
  frf92(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("92,%f\n", latency);

  ftime(&start);
  frf96(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("96,%f\n", latency);

  ftime(&start);
  frf100(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("100,%f\n", latency);

  ftime(&start);
  frf104(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("104,%f\n", latency);

  ftime(&start);
  frf108(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("108,%f\n", latency);

  ftime(&start);
  frf112(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("112,%f\n", latency);

  ftime(&start);
  frf116(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("116,%f\n", latency);

  ftime(&start);
  frf120(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("120,%f\n", latency);

  ftime(&start);
  frf124(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("124,%f\n", latency);

  ftime(&start);
  frf128(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("128,%f\n", latency);

  ftime(&start);
  frf132(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("132,%f\n", latency);

  ftime(&start);
  frf136(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("136,%f\n", latency);

  ftime(&start);
  frf140(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("140,%f\n", latency);

  ftime(&start);
  frf144(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("144,%f\n", latency);

  ftime(&start);
  frf148(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("148,%f\n", latency);

  ftime(&start);
  frf152(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("152,%f\n", latency);

  ftime(&start);
  frf156(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("156,%f\n", latency);

  ftime(&start);
  frf160(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("160,%f\n", latency);

  ftime(&start);
  frf164(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("164,%f\n", latency);

  ftime(&start);
  frf168(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("168,%f\n", latency);

  ftime(&start);
  frf172(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("172,%f\n", latency);

  ftime(&start);
  frf176(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("176,%f\n", latency);

  ftime(&start);
  frf180(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("180,%f\n", latency);

  ftime(&start);
  frf184(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("184,%f\n", latency);

  ftime(&start);
  frf188(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("188,%f\n", latency);

  ftime(&start);
  frf192(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("192,%f\n", latency);

  ftime(&start);
  frf196(structIterations, A);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(structIterations);
  printf("196,%f\n", latency);

  return 0;
  }

  free(A);
  printf("Branch Per 16B:\n");
  iterations = 500000000;
  ftime(&start);
  branch1pad3(500000000/1);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("1,%f\n", latency);

  ftime(&start);
  branch2pad3(500000000/2);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("2,%f\n", latency);

  ftime(&start);
  branch4pad3(500000000/4);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("4,%f\n", latency);

  ftime(&start);
  branch8pad3(500000000/8);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("8,%f\n", latency);

  ftime(&start);
  branch16pad3(500000000/16);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("16,%f\n", latency);

  ftime(&start);
  branch32pad3(500000000/32);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("32,%f\n", latency);

  ftime(&start);
  branch64pad3(500000000/64);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("64,%f\n", latency);

  ftime(&start);
  branch128pad3(500000000/128);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("128,%f\n", latency);

  ftime(&start);
  branch256pad3(500000000/256);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("256,%f\n", latency);

  ftime(&start);
  branch512pad3(500000000/512);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("512,%f\n", latency);

  ftime(&start);
  branch1024pad3(500000000/1024);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("1024,%f\n", latency);

  ftime(&start);
  branch1536pad3(500000000/1536);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("1536,%f\n", latency);

  ftime(&start);
  branch2048pad3(500000000/2048);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("2048,%f\n", latency);

  ftime(&start);
  branch3072pad3(500000000/3072);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("3072,%f\n", latency);

  ftime(&start);
  branch4096pad3(500000000/4096);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("4096,%f\n", latency);

  ftime(&start);
  branch5120pad3(500000000/5120);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("5120,%f\n", latency);

  ftime(&start);
  branch6144pad3(500000000/6144);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("6144,%f\n", latency);

  ftime(&start);
  branch7168pad3(500000000/7168);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("7168,%f\n", latency);

  ftime(&start);
  branch8192pad3(500000000/8192);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("8192,%f\n", latency);

  ftime(&start);
  branch10240pad3(500000000/10240);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("10240,%f\n", latency);

  ftime(&start);
  branch16384pad3(500000000/16384);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("16384,%f\n", latency);

  ftime(&start);
  branch32768pad3(500000000/32768);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("32768,%f\n", latency);

  printf("Branch Per 8B:\n");
  iterations = 500000000;
  ftime(&start);
  branch1pad1(500000000/1);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("1,%f\n", latency);

  ftime(&start);
  branch2pad1(500000000/2);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("2,%f\n", latency);

  ftime(&start);
  branch4pad1(500000000/4);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("4,%f\n", latency);

  ftime(&start);
  branch8pad1(500000000/8);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("8,%f\n", latency);

  ftime(&start);
  branch16pad1(500000000/16);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("16,%f\n", latency);

  ftime(&start);
  branch32pad1(500000000/32);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("32,%f\n", latency);

  ftime(&start);
  branch64pad1(500000000/64);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("64,%f\n", latency);

  ftime(&start);
  branch128pad1(500000000/128);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("128,%f\n", latency);

  ftime(&start);
  branch256pad1(500000000/256);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("256,%f\n", latency);

  ftime(&start);
  branch512pad1(500000000/512);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("512,%f\n", latency);

  ftime(&start);
  branch1024pad1(500000000/1024);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("1024,%f\n", latency);

  ftime(&start);
  branch1536pad1(500000000/1536);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("1536,%f\n", latency);

  ftime(&start);
  branch2048pad1(500000000/2048);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("2048,%f\n", latency);

  ftime(&start);
  branch3072pad1(500000000/3072);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("3072,%f\n", latency);

  ftime(&start);
  branch4096pad1(500000000/4096);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("4096,%f\n", latency);

  ftime(&start);
  branch5120pad1(500000000/5120);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("5120,%f\n", latency);

  ftime(&start);
  branch6144pad1(500000000/6144);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("6144,%f\n", latency);

  ftime(&start);
  branch7168pad1(500000000/7168);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("7168,%f\n", latency);

  ftime(&start);
  branch8192pad1(500000000/8192);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("8192,%f\n", latency);

  ftime(&start);
  branch10240pad1(500000000/10240);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("10240,%f\n", latency);

  ftime(&start);
  branch16384pad1(500000000/16384);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("16384,%f\n", latency);

  ftime(&start);
  branch32768pad1(500000000/32768);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("32768,%f\n", latency);

  printf("Branch Per 4B:\n");
  iterations = 500000000;
  ftime(&start);
  branch1pad3(500000000/1);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("1,%f\n", latency);

  ftime(&start);
  branch2pad3(500000000/2);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("2,%f\n", latency);

  ftime(&start);
  branch4pad3(500000000/4);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("4,%f\n", latency);

  ftime(&start);
  branch8pad3(500000000/8);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("8,%f\n", latency);

  ftime(&start);
  branch16pad3(500000000/16);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("16,%f\n", latency);

  ftime(&start);
  branch32pad3(500000000/32);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("32,%f\n", latency);

  ftime(&start);
  branch64pad3(500000000/64);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("64,%f\n", latency);

  ftime(&start);
  branch128pad3(500000000/128);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("128,%f\n", latency);

  ftime(&start);
  branch256pad3(500000000/256);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("256,%f\n", latency);

  ftime(&start);
  branch512pad3(500000000/512);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("512,%f\n", latency);

  ftime(&start);
  branch1024pad3(500000000/1024);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("1024,%f\n", latency);

  ftime(&start);
  branch1536pad3(500000000/1536);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("1536,%f\n", latency);

  ftime(&start);
  branch2048pad3(500000000/2048);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("2048,%f\n", latency);

  ftime(&start);
  branch3072pad3(500000000/3072);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("3072,%f\n", latency);

  ftime(&start);
  branch4096pad3(500000000/4096);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("4096,%f\n", latency);

  ftime(&start);
  branch5120pad3(500000000/5120);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("5120,%f\n", latency);

  ftime(&start);
  branch6144pad3(500000000/6144);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("6144,%f\n", latency);

  ftime(&start);
  branch7168pad3(500000000/7168);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("7168,%f\n", latency);

  ftime(&start);
  branch8192pad3(500000000/8192);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("8192,%f\n", latency);

  ftime(&start);
  branch10240pad3(500000000/10240);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("10240,%f\n", latency);

  ftime(&start);
  branch16384pad3(500000000/16384);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("16384,%f\n", latency);

  ftime(&start);
  branch32768pad3(500000000/32768);
  ftime(&end);
  time_diff_ms = 1000 * (end.time - start.time) + (end.millitm - start.millitm);
  latency = 1e6 * (float)time_diff_ms / (float)(iterations);
  printf("32768,%f\n", latency);

  return 0; }
