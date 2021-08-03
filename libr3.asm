; z80dasm 1.1.3
; command line: ./z80dasm -a -l -S libr3.sym -s libr3.sym1 -o libr3.mac -b libr3.blocks.txt LIBR3.COM

	org	00100h
BDOS:	equ 0x0005
__argc_:	equ 0x5584
__Hbss:	equ 0x5599

l0100h:
	ld hl,(00006h)		;0100
	ld sp,hl		;0103
	ld de,__Lbss		;0104
	or a			;0107
	ld hl,__Hbss		;0108
	sbc hl,de		;010b
	ld c,l			;010d
	ld b,h			;010e
	dec bc			;010f
	ld l,e			;0110
	ld h,d			;0111
	inc de			;0112
	ld (hl),000h		;0113
	ldir			;0115
	ld hl,data		;0117
	push hl			;011a
	ld hl,00080h		;011b
	ld c,(hl)		;011e
	inc hl			;011f
	ld b,000h		;0120
	add hl,bc		;0122
	ld (hl),000h		;0123
	ld hl,00081h		;0125
	push hl			;0128
	call startup		;0129
	pop bc			;012c
	pop bc			;012d
	push hl			;012e
	ld hl,(__argc_)		;012f
	push hl			;0132
	call main		;0133
	push hl			;0136
	call exit		;0137
	jp 00000h		;013a


; =============== F U N C T I O N ===========================================
; 1	sub_013dh	ok++
;
sub_013dh:					; int sub_013dh(register * st, char * p2) {
	call csv		;013d		; char loc1, loc2;
	push hl			;0140		;
	ld l,(ix+006h)		;0141		;
	ld h,(ix+007h)  ;p1	;0144		;
	push hl			;0147		;
	pop iy		;st	;0148		;
	jr l01aeh		;014a		; goto m6;
l014ch:				;		; m1:
	ld a,(iy+000h)	;*st	;014c		;
	ld e,a			;014f		;
	rla			;0150		;
	sbc a,a			;0151		;
	ld d,a			;0152		;
	ld hl,l46b4h ; ctype_+1	;0153		;
	add hl,de		;0156		;
	bit 0,(hl)		;0157		;
	ld a,e			;0159		;
	jr nz,l0161h		;015a		; if(isupper(*st) != 0) goto m2;
	ld l,a			;015c		;
	rla			;015d		;
	sbc a,a			;015e		; l = 0
	jr l0169h		;015f		; goto m3;
l0161h:				;		; m2:
	ld e,a			;0161		;
	rla			;0162		;
	sbc a,a			;0163		;
	ld d,a			;0164		;
	ld hl,00020h		;0165		;
	add hl,de		;0168		; l = 0x20 + *st;
l0169h:				;		; m3:
	ld (ix-001h),l	;loc1	;0169		; loc1 = l;
	ld l,(ix+008h)		;016c		;
	ld h,(ix+009h)     ;p2	;016f		;
	ld a,(hl)		;0172		;
	ld e,a			;0173		;
	rla			;0174		;
	sbc a,a			;0175		;
	ld d,a			;0176		;
	ld hl,l46b4h ; ctype_+1	;0177		;
	add hl,de		;017a		;
	bit 0,(hl)		;017b		;
	ld l,(ix+008h)		;017d		;
	ld h,(ix+009h)     ;p2	;0180		;
	ld a,(hl)		;0183		;
	jr nz,l018ch		;0184		; if(isupper(*p2) != 0) goto m4;
	ld l,a			;0186		;
	rla			;0187		;
	sbc a,a			;0188		;
	ld h,a			;0189		; l = (char)*p2
	jr l0194h		;018a		; goto m5;
l018ch:				;		; m4:
	ld e,a			;018c		;
	rla			;018d		;
	sbc a,a			;018e		;
	ld d,a			;018f		;
	ld hl,00020h		;0190		;
	add hl,de		;0193		; l = 0x20 + (char)*p2;
l0194h:				;		; m5:
	ld (ix-002h),l	;loc2	;0194		; loc2 = l;
	ld a,(ix-001h)	;loc1	;0197		;
	cp (ix-002h)	;loc2	;019a		;
	jr nz,l01b4h		;019d		; if(loc1 != loc2) goto m7;
	inc iy			;019f		; ++st;
	ld l,(ix+008h)		;01a1		;
	ld h,(ix+009h)     ;p2	;01a4		;
	inc hl			;01a7		;
	ld (ix+008h),l		;01a8		;
	ld (ix+009h),h     ;p2	;01ab		; ++p2;
l01aeh:				;		; m6:
	ld a,(iy+000h)		;01ae		;
	or a			;01b1		;
	jr nz,l014ch		;01b2		; if(*st != 0) goto m1;
l01b4h:				;		; m7:
	ld l,(ix+008h)		;01b4		;
	ld h,(ix+009h)     ;p2	;01b7		;
	ld a,(hl)		;01ba		;
	ld e,a			;01bb		;
	rla			;01bc		;
	sbc a,a			;01bd		;
	ld d,a			;01be		;
	ld a,(iy+000h)		;01bf		;
	ld l,a			;01c2		;
	rla			;01c3		;
	sbc a,a			;01c4		;
	ld h,a			;01c5		;
	or a			;01c6		;
	sbc hl,de		;01c7		; return *p2 - *st;
	jp cret			;01c9		; }


; =============== F U N C T I O N ===========================================
; 2	sub_01cch	ok++
;
sub_01cch:					; void sub_01cch(int p1, int p2) {
	call csv		;01cc		;
	ld l,(ix+008h)		;01cf		;
	ld h,(ix+009h)     ;p2	;01d2		;
	ld (word_4747),hl	;01d5		;     word_4747 = p2;
	ld l,(ix+006h)		;01d8		;
	ld h,(ix+007h)     ;p1	;01db		;
	ld (word_4745),hl	;01de		;
	ld a,l			;01e1		;
	or h			;01e2		;
	jp z,cret		;01e3		;     if((word_4745 = p1) != 0) {
	push hl			;01e6		;
	call sub_1304h		;01e7		;
	ld (word_4749),hl	;01ea		;         word_4749 = sub_1304h(word_4745);
	ld hl,(word_4745)	;01ed		;
	add hl,hl		;01f0		;
	ex (sp),hl		;01f1		;
	call sub_1304h		;01f2		;
	ld (word_474b),hl	;01f5		;         word_474b = sub_1304h(word_4745*2);
	jp cret			;01f8		;     }
						; }

; =============== F U N C T I O N ===========================================
; 3	sub_01fbh	ok++
;
sub_01fbh:					; char sub_01fbh(int * p1) {
	call csv		;01fb		;
	push hl			;01fe		;
	ld hl,(word_4745)	;01ff		;
	ld a,l			;0202		;
	or h			;0203		;
	jr nz,l020bh		;0204		; if(word_4745 != 0) goto m1;
	ld l,001h		;0206		;
	jp cret			;0208		; return 1;
l020bh:				;		; m1:
	ld a,(word_4745)	;020b		;
	ld (ix-001h),a	  ;l1	;020e		; l1 = word_4745;
l0211h:				;		; m2:
	ld a,(ix-001h)	  ;l1	;0211		;
	dec (ix-001h)	  ;l1	;0214		;
	or a			;0217		;
	jr nz,l021fh		;0218		; if(l1-- != 0) goto m3;
	ld l,000h		;021a		; return 0;
	jp cret			;021c		;
l021fh:				;		; m3:
	ld l,(ix+006h)		;021f		;
	ld h,(ix+007h)	  ;p1	;0222		;
	push hl			;0225		;
	ld de,(word_4747)	;0226		;
	ld a,(ix-001h)	  ;l1	;022a		;
	ld l,a			;022d		;
	rla			;022e		;
	sbc a,a			;022f		;
	ld h,a			;0230		;
	add hl,hl		;0231		;
	add hl,de		;0232		;
	ld c,(hl)		;0233		;
	inc hl			;0234		;
	ld b,(hl)		;0235		;
	push bc			;0236		;
	call sub_013dh		;0237		;
	pop bc			;023a		;
	pop bc			;023b		;
	ld a,l			;023c		;
	or h			;023d		;
	jr nz,l0211h		;023e		; if(sub_013d(word_4747[l1], p1) != 0) goto m2;
	ld de,(word_4749)	;0240		;
	ld a,(ix-001h)		;0244		;
	ld l,a			;0247		;
	rla			;0248		;
	sbc a,a			;0249		;
	ld h,a			;024a		;
	add hl,de		;024b		;
	ld (hl),001h		;024c		; word_4749[l1] = 1;
	ld a,(ix-001h)		;024e		;
	ld l,a			;0251		;
	rla			;0252		;
	sbc a,a			;0253		;
	ld h,a			;0254		;
	ld a,l			;0255		;
	inc a			;0256		;
	ld l,a			;0257		; return l1-1;
	jp cret			;0258		; }


; =============== F U N C T I O N ===========================================
; 4	sub_025bh	ok++
;
sub_025bh:					; void sub_025bh() {
	call csv		;025b		;
	push hl			;025e		;
	ld (ix-002h),000h	;025f		;
	ld (ix-001h),000h ;l1	;0263		; l1 = 0;
	jr l02a1h		;0267		; goto m3;
l0269h:						; m1:
	ld de,(word_4749)	;0269		;
	ld l,(ix-002h)		;026d		;
	ld h,(ix-001h)	;l1	;0270		;
	add hl,de		;0273		;
	ld a,(hl)		;0274		;
	or a			;0275		;
	ld l,(ix-002h)		;0276		;
	ld h,(ix-001h)	;l1	;0279		;
	jr nz,l029ah		;027c		; if(word_4749[l1] != 0) goto m2;
	push hl			;027e		;
	ld de,(word_4747)	;027f		;
	add hl,hl		;0283		;
	add hl,de		;0284		;
	ld c,(hl)		;0285		;
	inc hl			;0286		;
	ld b,(hl)		;0287		;
	push bc			;0288		;
	ld l,(ix+006h)		;0289		;
	ld h,(ix+007h)	;p1	;028c		;
	call indir		;028f		; fun(word_4747[l1], l1);
	pop bc			;0292		;
	pop bc			;0293		;
	ld l,(ix-002h)		;0294		;
	ld h,(ix-001h)	;l1	;0297		;
l029ah:						; m2:
	inc hl			;029a		;
	ld (ix-002h),l		;029b		;
	ld (ix-001h),h	;l1	;029e		; ++l1;
l02a1h:						; m3:
	ld de,(word_4745)	;02a1		;
	ld l,(ix-002h)		;02a5		;
	ld h,(ix-001h)	;l1	;02a8		;
	or a			;02ab		;
	sbc hl,de		;02ac		;
	jr nz,l0269h		;02ae		; if(l1 != word_4745) goto m1;
	jp cret			;02b0		; }



; =============== F U N C T I O N ===========================================
; 5	sub_02b3h	ok++
;
sub_02b3h:					;  void sub_02b3h(char * p1) {
	call csv		;02b3		;
	ld l,(ix+006h)		;02b6		;
	ld h,(ix+007h)     ;p1	;02b9		;
	push hl			;02bc		;
	call sub_01fbh		;02bd		;
	pop bc			;02c0		;
	ld a,l			;02c1		;
	or a			;02c2		;
	jp nz,cret		;02c3		;     if(sub_01fbh(p1) == 0)
	call sub_0789h		;02c6		;         sub_0789h();
	jp cret			;02c9		; }



; =============== F U N C T I O N ===========================================
; 6	sub_02cch	ok++
;
sub_02cch:					; void sub_02cch(char * p1) {
	call csv		;02cc		;
	ld l,(ix+006h)		;02cf		;
	ld h,(ix+007h)     ;p1	;02d2		;
	push hl			;02d5		;
	call sub_01fbh		;02d6		;
	pop bc			;02d9		;
	ld a,l			;02da		;
	or a			;02db		;
	jp nz,cret		;02dc		;     if(sub_01fbh(p1) == 0)
	call sub_0874h		;02df		;         sub_0874h();
	jp cret			;02e2		; }


; =============== F U N C T I O N ===========================================
; 7	sub_02e5h	ok++
;
sub_02e5h:					; void sub_02e5h() {
	ld hl,(word_4745)	;02e5		;
	ld a,l			;02e8		;
	or h			;02e9		;
	jr nz,l02f4h		;02ea		; if(word_4745 == 0)
	ld hl,l4160h		;02ec		;
	push hl			;02ef		;
	call sub_117ch		;02f0		; sub_117ch("delete what ?");
	pop bc			;02f3		;
l02f4h:						;
	call sub_0487h		;02f4		; sub_0487h();
	call sub_034ah		;02f7		; sub_034ah();
	ld hl,sub_02b3h		;02fa		;
	push hl			;02fd		;
	call sub_0621h		;02fe		; sub_0621h(sub_02b3h);
	ld hl,sub_12d4h		;0301		;
	ex (sp),hl		;0304		;
	call sub_025bh		;0305		; sub_025bh(sub_12d4h);
	pop bc			;0308		;
	call sub_04d6h		;0309		; sub_04d6h();
	ld hl,sub_02cch		;030c		;
	push hl			;030f		;
	call sub_0621h		;0310		; sub_0621h(sub_02cch);
	pop bc			;0313		;
	jp sub_053ch		;0314		; goto sub_053ch;
						; }


; =============== F U N C T I O N ===========================================
; 8	sub_0317h	ok++
;
sub_0317h:					; void sub_0317h(char * p1) {
	call csv		;0317		;
	ld l,(ix+006h)		;031a		;
	ld h,(ix+007h)     ;p1	;031d		;
	push hl			;0320		;
	call sub_01fbh		;0321		;
	pop bc			;0324		;
	ld a,l			;0325		;
	or a			;0326		;
	jp z,cret		;0327		;     if(sub_01fbh(p1) != 0)
	ld l,(ix+006h)		;032a		;
	ld h,(ix+007h)     ;p1	;032d		;
	push hl			;0330		;
	call sub_0912h		;0331		;         sub_0912h(p1)
	jp cret			;0334		; }

; =============== F U N C T I O N ===========================================
; 9	sub_0337h	ok++
;
sub_0337h:					; void sub_0337h() {
	call sub_0487h		;0337		; sub_0487h();
	ld hl,sub_0317h		;033a		;
	push hl			;033d		;
	call sub_0621h		;033e		; sub_0621h(sub_0317h);
	ld hl,sub_12d4h		;0341		;
	ex (sp),hl		;0344		;
	call sub_025bh		;0345		; sub_025bh(sub_12d4h);
	pop bc			;0348		;
	ret			;0349		; }


; =============== F U N C T I O N ===========================================
; 10	sub_034ah	ok++
;
sub_034ah:					; void sub_034ah() {
	ld hl,l4179h		;034a		;
	push hl			;034d		;
	ld hl,l416eh		;034e		;
	push hl			;0351		;
	call _fopen		;0352		;
	pop bc			;0355		;
	pop bc			;0356		;
	ld (word_4967),hl	;0357		;
	ld a,l			;035a		;
	or h			;035b		;
	ret nz			;035c		;     if((word_4967 = fopen("libtmp.$$$", "wb")) == 0) {
	ld hl,l416eh		;035d		;
	push hl			;0360		;
	call sub_11c4h		;0361		;         sub_11c4h("libtmp.$$$");
	pop bc			;0364		;     }
	ret			;0365		; }


; =============== F U N C T I O N ===========================================
; 11	sub_0366h	ok++
;
sub_0366h:					; int sub_0366h(p1, p2, p3, p4) {
	call csv		;0366		;
	ld l,(ix+00ch)		;0369		;
	ld h,(ix+00dh)     ;p4	;036c		;
	push hl			;036f		;
	ld l,(ix+00ah)		;0370		;
	ld h,(ix+00bh)     ;p3	;0373		;
	push hl			;0376		;
	ld l,(ix+008h)		;0377		;
	ld h,(ix+009h)     ;p2	;037a		;
	push hl			;037d		;
	ld l,(ix+006h)		;037e		;
	ld h,(ix+007h)     ;p1	;0381		;
	push hl			;0384		;
	call sub_2355h		;0385		;
	pop bc			;0388		;
	pop bc			;0389		;
	pop bc			;038a		;
	pop bc			;038b		;
	ld (ix+008h),l		;038c		;
	ld (ix+009h),h     ;p2	;038f		;
	ld e,(ix+00ah)		;0392		;
	ld d,(ix+00bh)     ;p3	;0395		;
	or a			;0398		;
	sbc hl,de		;0399		;
	jr z,l03beh		;039b		;     if((p2 = sub_2355h(p1, p2, p3, p4)) != p3) {
	ld de,(word_4967)	;039d		;
	ld l,(ix+00ch)		;03a1		;
	ld h,(ix+00dh)     ;p4	;03a4		;
	or a			;03a7		;
	sbc hl,de		;03a8		;
	jr z,l03b1h		;03aa		;
	ld hl,l4198h ;"output"	;03ac		;
	jr l03b4h		;03af		;
l03b1h:					; m1:	;
	ld hl,l4193h ;"temp"	;03b1		;
l03b4h:					; m2:	;
	push hl			;03b4		;
	ld hl,l417ch		;03b5		;
	push hl			;03b8		;
	call sub_117ch		;03b9		;         sub_117ch("Write error on %s file", (p4 - word_4967 == 0) ? "temp" : "output");
	pop bc			;03bc		;
	pop bc			;03bd		;
l03beh:					; m3:	;     }
	ld l,(ix+008h)		;03be
	ld h,(ix+009h)     ;p2	;03c1		;     return p2;
	jp cret			;03c4		; }


; =============== F U N C T I O N ===========================================
; 12	sub_03c7h	ok++
;
sub_03c7h:
	ld hl,(word_4967)	;03c7		; void sub_03c7h() {
	ld a,l			;03ca		;
	or h			;03cb		;
	ret z			;03cc		;     if(word_4967 != 0) {
	push hl			;03cd		;
	call _fclose		;03ce		;         fclose(word_4967);
	ld hl,l416eh		;03d1		;
	ex (sp),hl		;03d4		;
	call _unlink		;03d5		;         unlink("libtmp.$$$");
	pop bc			;03d8		;     }
	ret			;03d9		; }


; =============== F U N C T I O N ===========================================
; 13	sub_03dah	ok++
;
sub_03dah:					; void sub_03dah(p1) {
	call csv		;03da		; register * st;
	ld l,(ix+006h)		;03dd		;
	ld h,(ix+007h)     ;p1	;03e0		;
	ld (word_4758),hl	;03e3		; word_4758 = p1;
	ld hl,l419fh	;"rb"	;03e6		;
	push hl			;03e9		;
	ld hl,(word_4758)	;03ea		;
	push hl			;03ed		;
	call _fopen		;03ee		;
	pop bc			;03f1		;
	pop bc			;03f2		; word_4761 = fopen(word_4758, "rb")
	ld (word_4761),hl	;03f3		;
	ld a,l			;03f6		;
	or h			;03f7		;
	jr nz,l0454h		;03f8		; if(word_4761 != 0) goto m5;
	ld hl,(word_4b7e)	;03fa		;
	ld a,l			;03fd		;
	or h			;03fe		;
	jr z,l0409h		;03ff		; if(word_4b7e != 0) {
	ld hl,(word_4758)	;0401		;
	push hl			;0404		;
	call sub_11c4h		;0405		;     sub_11c4h(word_4758)
	pop bc			;0408		; }
l0409h:					; m1:	;
	ld hl,0002eh		;0409		;
	push hl			;040c		;
	ld hl,(word_4758)	;040d		;
	push hl			;0410		;
	call _strrchr		;0411		;
	pop bc			;0414		;
	pop bc			;0415		;
	push hl			;0416		;
	pop iy			;0417		; st = strrchr(word_4758, 0x2E);
	ld a,l			;0419		;
	or h			;041a		;
	jr z,l043bh		;041b		; if(st == 0) goto m2;
	ld hl,l41a2h	;".lib"	;041d		;
	push hl			;0420		;
	push iy			;0421		;
	call strcmp		;0423		;
	pop bc			;0426		;
	pop bc			;0427		;
	ld a,l			;0428		;
	or h			;0429		;
	jr z,l0448h		;042a		; if(strcmp(st, ".lib") == 0)  goto m3;
	ld hl,l41a7h	;".LIB"	;042c		;
	push hl			;042f		;
	push iy			;0430		;
	call strcmp		;0432		;
	pop bc			;0435		;
	pop bc			;0436		;
	ld a,l			;0437		;
	or h			;0438		;
	jr z,l0448h		;0439		; if(strcmp(st, ".LIB") == 0)  goto m3;
l043bh:						; m2:
	ld hl,(word_4758)	;043b		;
	push hl			;043e		;
	ld hl,l41ach		;043f		;
	push hl			;0442		;
	call sub_124dh		;0443		; sub_124dh("library file names should have .lib extension: %s", word_4758);
	pop bc			;0446		;
	pop bc			;0447		;
l0448h:						; m3:
	ld hl,00000h		;0448		;
	ld (word_4752),hl	;044b		; word_4752 = 0;
l044eh:						; m4:
	ld (word_474f),hl	;044e		; word_474f = 0;
	jp cret			;0451		; 
l0454h:						; m5:
	ld hl,(word_4761)	;0454		;
	push hl			;0457		;
	ld hl,00001h		;0458		;
	push hl			;045b		;
	ld hl,00004h		;045c		;
	push hl			;045f		;
	ld hl,arry_4969		;0460		;
	push hl			;0463		;
	call read1		;0464		;
	pop bc			;0467		;
	pop bc			;0468		;
	pop bc			;0469		;
	pop bc			;046a		;
	ld de,00001h		;046b		;
	or a			;046e		;
	sbc hl,de		;046f		;
	call nz,sub_0d14h	;0471		; if(read1(arry_4969, 4, 1, word_4761) != 1) sub_0d14h();
	ld hl,arry_4969		;0474		;
	push hl			;0477		;
	call sub_0c53h		;0478		;
	ld (word_4752),hl	;047b		; word_4752 = sub_0c53h(arry_4969);
	ld hl,arry_496b		;047e		;
	ex (sp),hl		;0481		;
	call sub_0c53h		;0482		; word_474f = sub_0c53h(arry_496b);
	jr l044eh		;0485		;
						; }


; =============== F U N C T I O N ===========================================
; 14	sub_0487h	ok++
;
sub_0487h:					; void sub_0487h() {
	ld hl,(word_4761)	;0487		;
	ld a,l			;048a		;
	or h			;048b		;
	ret z			;048c		; if(word_4761 == 0) return;
	ld hl,l41deh		;048d		;
	push hl			;0490		;
	ld hl,(word_4758)	;0491		;
	push hl			;0494		;
	call _fopen		;0495		;
	pop bc			;0498		;
	pop bc			;0499		;
	ld (word_4b6d),hl	;049a		;
	ld a,l			;049d		;
	or h			;049e		;
	jr z,l04cdh		;049f		; if((word_4b6d = fopen(word_4758, "rb")) == 0) goto m1;
	ld hl,00000h		;04a1		;
	push hl			;04a4		;
	ld de,(word_4752)	;04a5		;
	ld a,d		 	;04a9		;
	rla		 	;04aa		;
	sbc a,a		 	;04ab		;
	ld l,a		 	;04ac		;
	ld h,a		 	;04ad		;
	ex de,hl	 	;04ae 		;
	ld bc,00004h	 	;04af		;
	add hl,bc	 	;04b2		;
	ex de,hl	 	;04b3		;
	ld bc,00000h	 	;04b4		;
	adc hl,bc	 	;04b7		;
	push hl		 	;04b9		;
	push de		 	;04ba		;
	ld hl,(word_4b6d)	;04bb		;
	push hl			;04be		;
	call _fseek		;04bf		;
	pop bc			;04c2		;
	pop bc			;04c3		;
	pop bc			;04c4		;
	pop bc			;04c5		;
	ld de,0ffffh		;04c6		;
	or a			;04c9		;
	sbc hl,de		;04ca		;
	ret nz			;04cc		; if(fseek(word_4b6d,word_4752+4,0) != -1) return;
l04cdh:						; m1:
	ld hl,(word_4758)	;04cd		;
	push hl			;04d0		;
	call sub_11c4h		;04d1		; sub_11c4h(word_4758);
	pop bc			;04d4		;
	ret			;04d5		; }


; =============== F U N C T I O N ===========================================
; 15	sub_04d6h	ok++
;
sub_04d6h:					; void sub_04d6h() {
	ld hl,(word_4b7c)	;04d6		;
	ld a,l			;04d9		;
	or h			;04da		;
	jr z,l04e5h		;04db		;     if(word_4b7c != 0)
	ld hl,0x0005		;04dd		;
	push hl			;04e0		;
	call sub_12e8h		;04e1		;         sub_12e8h(5);
	pop bc			;04e4		;
l04e5h:					; m1:	;
	ld hl,(word_4761)	;04e5		;
	ld a,l			;04e8		;
	or h			;04e9		;
	ret z			;04ea		;     if(word_4761 == 0) return;
	ld hl,00000h		;04eb		;
	push hl			;04ee		;
	ld de,00004h		;04ef		;
	push hl			;04f2		;
	push de			;04f3		;
	ld hl,(word_4761)	;04f4		;
	push hl			;04f7		;
	call _fseek		;04f8		;
	pop bc			;04fb		;
	pop bc			;04fc		;
	pop bc			;04fd		;
	pop bc			;04fe		;
	ld de,0ffffh		;04ff		;
	or a			;0502		;
	sbc hl,de		;0503		;
	jr z,l0533h		;0505		;     if(fseek(word_4761, 4, 0) != -1) {
	ld hl,00000h		;0507		;
	push hl			;050a		;
	ld de,(word_4752)	;050b		;
	ld a,d			;050f		;
	rla			;0510		;
	sbc a,a			;0511		;
	ld l,a			;0512		;
	ld h,a			;0513		;
	ex de,hl		;0514		;
	ld bc,00004h		;0515		;
	add hl,bc		;0518		;
	ex de,hl		;0519		;
	ld bc,00000h		;051a		;
	adc hl,bc		;051d		;
	push hl			;051f		;
	push de			;0520		;
	ld hl,(word_4b6d)	;0521		;
	push hl			;0524		;
	call _fseek		;0525		;
	pop bc			;0528		;
	pop bc			;0529		;
	pop bc			;052a		;
	pop bc			;052b		;
	ld de,0ffffh		;052c		;
	or a			;052f		;
	sbc hl,de		;0530		;
	ret nz			;0532		;         if(fseek(word_4b6d, word_4752+4, 0) != -1) return;
l0533h:					; m2:	;     }
	ld hl,(word_4758)	;0533		;
	push hl			;0536		;
	call sub_11e5h		;0537		;     sub_11e5h(word_4758);
	pop bc			;053a		;
	ret			;053b		; }



; =============== F U N C T I O N ===========================================
; 16	sub_053ch	ok++
;
sub_053ch:					; void sub_053ch() {
	call csv		;053c		;
	push hl			;053f		;
	push hl			;0540		;
	ld hl,(word_4967)	;0541		;
	push hl			;0544		;
	call _fclose		;0545		;
	pop bc			;0548		; fclose(word_4967);
	ld hl,(word_4761)	;0549		;
	ld a,l			;054c		;
	or h			;054d		;
	jr z,l055ch		;054e		; if(word_4761 == 0) goto m1;
	push hl			;0550		;
	call _fclose		;0551		; fclose(word_4761);
	ld hl,(word_4b6d)	;0554		;
	ex (sp),hl		;0557		;
	call _fclose		;0558		; fclose(word_4b6d);
	pop bc			;055b		;
l055ch:						; m1:
	ld hl,l41e1h		;055c		;
	push hl			;055f		;
	ld hl,l416eh		;0560		;
	push hl			;0563		;
	call _fopen		;0564		;
	pop bc			;0567		;
	pop bc			;0568		;
	ld (word_4967),hl	;0569		;
	ld a,l			;056c		;
	or h			;056d		;
	jr nz,l0578h		;056e		; if((word_4967 = fopen("libtmp.$$$", "rb")) != 0) goto m2;
	ld hl,l416eh		;0570		;
	push hl			;0573		;
	call sub_11c4h		;0574		; sub_11c4h("libtmp.$$$");
	pop bc			;0577		;
l0578h:						; m2:
	ld hl,l41e4h		;0578		;
	push hl			;057b		;
	ld hl,(word_4758)	;057c		;
	push hl			;057f		;
	call _fopen		;0580		;
	pop bc			;0583		;
	pop bc			;0584		;
	ld (word_4761),hl	;0585		;
	ld a,l			;0588		;
	or h			;0589		;
	jr nz,l0594h		;058a		; if((word_4761 = fopen(word_4758, "wb")) != 0) goto m3;
	ld hl,(word_4758)	;058c		;
	push hl			;058f		;
	call sub_11c4h		;0590		; sub_11c4h(word_4758);
	pop bc			;0593		;
l0594h:						; m3:
	ld hl,arry_4969		;0594		;
	push hl			;0597		;
	ld hl,(word_475c)	;0598		;
	push hl			;059b		;
	call sub_0c31h		;059c		; sub_0c31h(word_475c, &arry_4969);
	pop bc			;059f		;
	ld hl,arry_496b		;05a0		;
	ex (sp),hl		;05a3		;
	ld hl,(word_475a)	;05a4		;
	push hl			;05a7		;
	call sub_0c31h		;05a8		; sub_0c31h(word_475a, arry_496b);
	pop bc			;05ab		;
	ld hl,(word_4761)	;05ac		;
	ex (sp),hl	;\4	;05af		;
	ld hl,00004h		;05b0		;
	push hl		;\3	;05b3		;
	ld hl,00001h		;05b4		;
	push hl		;\2	;05b7		;
	ld hl,arry_4969		;05b8		;
	push hl		;\1	;05bb		;
	call sub_0366h		;05bc		; sub_0366h(arry_4969, 1, 4, word_4761);
	pop bc			;05bf		;
	pop bc			;05c0		;
	pop bc			;05c1		;
	pop bc			;05c2		;
	ld (ix-004h),004h	;05c3		;
	ld (ix-003h),000h ;l2	;05c7		; l2 = 4;
	jr l05f6h		;05cb		; goto m5;
l05cdh:						; m4:
	ld l,(ix-002h)		;05cd		;
	ld h,(ix-001h)	;l1	;05d0		;
	push hl		;\3	;05d3		;
	ld hl,00001h		;05d4		;
	push hl		;\2	;05d7		;
	ld hl,arry_4969		;05d8		;
	push hl		;\1	;05db		;
	call sub_0366h		;05dc		; sub_0366h(arry_4969, 1, l1, word_4761);
	pop bc			;05df		;
	pop bc			;05e0		;
	pop bc			;05e1		;
	pop bc			;05e2		;
	ld e,(ix-002h)		;05e3		;
	ld d,(ix-001h)	;l1	;05e6		;
	ld l,(ix-004h)		;05e9		;
	ld h,(ix-003h)	;l2	;05ec		;
	add hl,de		;05ef		;
	ld (ix-004h),l		;05f0		;
	ld (ix-003h),h	;l2	;05f3		; l2 += l1; 
l05f6h:						; m5:
	ld hl,(word_4967)	;05f6		;
	push hl		;\4	;05f9		;
	ld hl,00200h		;05fa		;
	push hl		;\3	;05fd		;
	ld hl,00001h		;05fe		;
	push hl		;\2	;0601		;
	ld hl,arry_4969		;0602		;
	push hl		;\1	;0605		;
	call read1		;0606		;
	pop bc			;0609		;
	pop bc			;060a		;
	pop bc			;060b		;
	pop bc			;060c		;
	ld (ix-002h),l		;060d		;
	ld (ix-001h),h	;l1	;0610		;
	ld a,l			;0613		;
	or h			;0614		;
	ld hl,(word_4761) ;\4	;0615		;
	push hl			;0618		;
	jr nz,l05cdh		;0619		; if(l1 = read1(arry_4969, 1, 1, word_4967) != 0) goto m4;
	call _fclose		;061b		; fclose(word_4761);
	jp cret			;061e		; }


; =============== F U N C T I O N ===========================================
; 17	sub_0621h	ok++
;
sub_0621h:					; void sub_0621h(void (*p1)(char *, long)) {
	call csv		;0621		; int loc;
	push hl			;0624		;
	ld hl,(word_474f)	;0625		;
	ld (ix-002h),l		;0628		;
	ld (ix-001h),h	;loc	;062b		; loc = word_474f;
	jp l071bh		;062e		; goto m4;
l0631h:						; m1:
	ld hl,(word_4761)	;0631		;
	push hl			;0634		;
	ld hl,00001h		;0635		;
	push hl			;0638		;
	ld hl,0000ch		;0639		;
	push hl			;063c		;
	ld hl,arry_4969		;063d		;
	push hl			;0640		;
	call read1		;0641		;
	pop bc			;0644		;
	pop bc			;0645		;
	pop bc			;0646		;
	pop bc			;0647		;
	ld de,00001h		;0648		;
	or a			;064b		;
	sbc hl,de		;064c		;
	call nz,sub_0d14h	;064e		; if(read1(arry_4969, 0xC, 1, word_4761) != 1) sub_0d14h();
	ld hl,arry_4969		;0651		;
	push hl			;0654		;
	call sub_0c53h		;0655		;
	ld (word_4b6f),hl	;0658		; word_4b6f = sub_0c53h(arry_4969);
	ld hl,arry_496b		;065b		;
	ex (sp),hl		;065e		;
	call sub_0c53h		;065f		;
	ld (word_475f),hl	;0662		; word_475f = sub_0c53h(arry_496b);
	ld hl,arry_496d		;0665		;
	ex (sp),hl		;0668		;
	call sub_0c73h		;0669		; 
	ld (word_4763),de ;long	;066c		;
	ld (word_4765),hl	;0670		; long_4763 = sub_0c73h(arry_496d);
	ld hl,04971h		;0673		;
	ex (sp),hl		;0676		;
	call sub_0c73h		;0677		;
	ld (04b69h),de	;long	;067a		;
	ld (04b6bh),hl		;067e		; long_4b69 = sub_0c73h(arry_4971);
	ld hl,arry_4975		;0681		;
	ex (sp),hl		;0684		;
	call sub_0cb3h		;0685		; sub_0cb3h(arry_4975);
	pop bc			;0688		;
	xor a			;0689		;
	ld (byte_4751),a	;068a		;
	ld (byte_475e),a	;068d		; byte_475e = byte_4751 = 0;
	ld de,(04b69h)	;long	;0690		;
	ld hl,(04b6bh)		;0694		;
	push hl			;0697		;
	push de			;0698		;
	ld hl,arry_4975		;0699		;
	push hl			;069c		;
	ld l,(ix+006h)		;069d		;
	ld h,(ix+007h)	;p1	;06a0		;
	call indir		;06a3		; p1(arry_4975, long_4b69);
	pop bc			;06a6		;
	pop bc			;06a7		;
	pop bc			;06a8		;
	ld a,(byte_475e)	;06a9		;
	or a			;06ac		;
	jr nz,l06d9h		;06ad		; if(byte_475e != 0) goto m2;
	ld hl,00001h		;06af		;
	push hl			;06b2		;
	ld de,(word_4b6f)	;06b3		;
	ld a,d			;06b7		;
	rla			;06b8		;
	sbc a,a			;06b9		;
	ld l,a			;06ba		;
	ld h,a			;06bb		;
	push hl			;06bc		;
	push de			;06bd		;
	ld hl,(word_4761)	;06be		;
	push hl			;06c1		;
	call _fseek		;06c2		;
	pop bc			;06c5		;
	pop bc			;06c6		;
	pop bc			;06c7		;
	pop bc			;06c8		;
	ld de,0ffffh		;06c9		;
	or a			;06cc		;
	sbc hl,de		;06cd		;
	jr nz,l06d9h		;06cf		; if(fseek(word_4761, word_4b6f, 1) != -1) goto m2;
	ld hl,(word_4758)	;06d1		;
	push hl			;06d4		;
	call sub_11e5h		;06d5		; sub_11e5h(word_4758);
	pop bc			;06d8		;
l06d9h:						; m2:
	ld hl,(word_4b6d)	;06d9		;
	ld a,l			;06dc		;
	or h			;06dd		;
	jr z,l070eh		;06de		; if(word_4b6d == 0) goto m3;
	ld a,(byte_4751)	;06e0		;
	or a			;06e3		;
	jr nz,l070eh		;06e4		; if(byte_4751 != 0) goto m3;
	ld hl,00001h		;06e6		;
	push hl			;06e9		;
	ld de,(word_4763)	;06ea		;
	ld hl,(word_4765)	;06ee		;
	push hl			;06f1		;
	push de			;06f2		;
	ld hl,(word_4b6d)	;06f3		;
	push hl			;06f6		;
	call _fseek		;06f7		;
	pop bc			;06fa		;
	pop bc			;06fb		;
	pop bc			;06fc		;
	pop bc			;06fd		;
	ld de,0ffffh		;06fe		;
	or a			;0701		;
	sbc hl,de		;0702		;
	jr nz,l070eh		;0704		; if(fseek(word_4b6d, word_4763, 1) != -1) goto m3;
	ld hl,(word_4758)	;0706		;
	push hl			;0709		;
	call sub_11e5h		;070a		; sub_11e5h(word_4758);
	pop bc			;070d		;
l070eh:						; m3:
	ld l,(ix-002h)		;070e		;
	ld h,(ix-001h)		;0711		;
	dec hl			;0714		;
	ld (ix-002h),l		;0715		;
	ld (ix-001h),h		;0718		; --loc;
l071bh:						; m4:
	ld a,(ix-002h)		;071b		;
	or (ix-001h)		;071e		;
	jp nz,l0631h		;0721		; if(loc != 0) goto m1;
	jp cret			;0724		; }


; =============== F U N C T I O N ===========================================
; 18	sub_0727h	ok++
;
sub_0727h:					; void sub_0727(void (*funptr)(char *, int)) {
	call csv		;0727		; int l1, l2;
	push hl			;072a		;
	push hl			;072b		;
	ld hl,(word_475f)	;072c		;
	ld (ix-002h),l		;072f		;
	ld (ix-001h),h	;l1	;0732		; l1 = word_475f;
	jr l0779h		;0735		; goto m2;
l0737h:						; m1:
	ld hl,(word_4761)	;0737		;
	push hl			;073a		;
	call fgetc		;073b		;
	pop bc			;073e		;
	ld (ix-004h),l		;073f		;
	ld (ix-003h),h	;l2	;0742		;
	ld de,0ffffh		;0745		;
	or a			;0748		;
	sbc hl,de		;0749		;
	call z,sub_0d14h	;074b		; if((l2 = fgetc(word_4761)) == -1) sub_0d14h();
	ld hl,l4767h		;074e		;
	push hl			;0751		;
	call sub_0cb3h		;0752		; sub_0cb3h(arry_4767);
	pop bc			;0755		;
	ld l,(ix-004h)		;0756		;
	ld h,(ix-003h)	;l2	;0759		;
	push hl			;075c		;
	ld hl,l4767h		;075d		;
	push hl			;0760		;
	ld l,(ix+006h)		;0761		;
	ld h,(ix+007h)	;p1	;0764		;
	call indir		;0767		; funptr(arry_4767, l2);
	pop bc			;076a		;
	pop bc			;076b		;
	ld l,(ix-002h)		;076c		;
	ld h,(ix-001h)	;l1	;076f		;
	dec hl			;0772		;
	ld (ix-002h),l		;0773		;
	ld (ix-001h),h	;l1	;0776		; --l1;
l0779h:						; m2:
	ld a,(ix-002h)		;0779		;
	or (ix-001h)	;l1	;077c		;
	jr nz,l0737h		;077f		; if(l1 != 0) goto m1;
	ld a,001h		;0781		;
	ld (byte_475e),a	;0783		; byte_475e = 1;
	jp cret			;0786		; }


; =============== F U N C T I O N ===========================================
; 19	sub_0789h	ok++
;
sub_0789h:					; void 	sub_0789h() {
	call csv		;0789		;
	push hl			;078c		;
	push hl			;078d		;
	ld hl,(word_4967)	;078e		;
	push hl		;\4	;0791		;
	ld hl,arry_4975		;0792		;
	push hl			;0795		;
	call strlen		;0796		;
	ex de,hl		;0799		;
	ld hl,0000dh		;079a		;
	add hl,de		;079d		;
	ld (ix-002h),l		;079e		;
	ld (ix-001h),h	;l1	;07a1		; l1 = strlen(arry_4975)+0xD;
	ex (sp),hl	;\3	;07a4		;
	ld hl,00001h		;07a5		;
	push hl		;\2	;07a8		;
	ld hl,arry_4969		;07a9		;
	push hl		;\1	;07ac		;
	call sub_0366h		;07ad		; sub_0366h(arry_4969, 1, l1, word_4967);
	pop bc			;07b0		;
	pop bc			;07b1		;
	pop bc			;07b2		;
	pop bc			;07b3		;
	ld e,(ix-002h)		;07b4		;
	ld d,(ix-001h)	;l1	;07b7		;
	ld hl,(word_474d)	;07ba		;
	add hl,de		;07bd		;
	ld (word_474d),hl	;07be		; word_474d += l1;
	ld de,(word_4b6f)	;07c1		;
	ld l,(ix-002h)		;07c5		;
	ld h,(ix-001h)	;l1	;07c8		;
	add hl,de		;07cb		;
	ex de,hl		;07cc		;
	ld hl,(word_475c)	;07cd		;
	add hl,de		;07d0		;
	ld (word_475c),hl	;07d1		; word_475c += (l1 + word_4b6f);
	ld hl,(word_4b6f)	;07d4		;
	ld (ix-002h),l		;07d7		;
	ld (ix-001h),h	;l1	;07da		; l1 = word_4b6f;
	jp l085ch		;07dd		; goto m4;
l07e0h:						; m1:
	ld de,00200h		;07e0		;
	ld l,(ix-002h)		;07e3		;
	ld h,(ix-001h)	;l1	;07e6		;
	call wrelop		;07e9		;
	jp m,l07f4h		;07ec		; if(l1 < 0x200) goto m2;
	ld hl,00200h		;07ef		; hl = 0x200
	jr l07fah		;07f2		; goto m3;
l07f4h:						; m2:
	ld l,(ix-002h)		;07f4		;
	ld h,(ix-001h)	;l1	;07f7		; hl = l1;
l07fah:						; m3:
	ld (ix-004h),l		;07fa		;
	ld (ix-003h),h	;l2	;07fd		; l2 = hl;
	ld hl,(word_4761)	;0800		;
	push hl		;\4	;0803		;
	ld l,(ix-004h)		;0804		;
	ld h,(ix-003h)	;l2	;0807		;
	push hl		;\3	;080a		;
	ld hl,00001h		;080b		;
	push hl		;\2	;080e		;
	ld hl,l4767h		;080f		;
	push hl		;\1	;0812		;
	call read1		;0813		;
	pop bc			;0816		;
	pop bc			;0817		;
	pop bc			;0818		;
	pop bc			;0819		;
	ld e,(ix-004h)		;081a		;
	ld d,(ix-003h)	;l2	;081d		;
	or a			;0820		;
	sbc hl,de		;0821		;
	call nz,sub_0d14h	;0823		; if(read1(arry_4767, 1, l2, word_4761) != l2) sub_0d14h();
	ld hl,(word_4967)	;0826		;
	push hl		;\4	;0829		;
	ld l,(ix-004h)		;082a		;
	ld h,(ix-003h)	;l2	;082d		;
	push hl		;\3	;0830		;
	ld hl,00001h		;0831		;
	push hl		;\2	;0834		;
	ld hl,l4767h		;0835		;
	push hl		;\1	;0838		;
	call sub_0366h		;0839		; sub_0366h(arry_4767, 1, l2, word_4967);
	pop bc			;083c		;
	pop bc			;083d		;
	pop bc			;083e		;
	pop bc			;083f		;
	ld e,(ix-004h)		;0840		;
	ld d,(ix-003h)	;l2	;0843		;
	ld hl,(word_474d)	;0846		;
	add hl,de		;0849		;
	ld (word_474d),hl	;084a		; word_474d += l2;
	ld l,(ix-002h)		;084d		;
	ld h,(ix-001h)	;l1	;0850		;
	or a			;0853		;
	sbc hl,de		;0854		;
	ld (ix-002h),l		;0856		;
	ld (ix-001h),h	;l1	;0859		; l1 -= l2;
l085ch:						; m4:
	ld a,(ix-002h)		;085c		;
	or (ix-001h)	;l1	;085f		;
	jp nz,l07e0h		;0862		; if(l1 != 0) goto m1;
	ld hl,(word_475a)	;0865		;
	inc hl			;0868		;
	ld (word_475a),hl	;0869		; ++word_475a;
	ld a,001h		;086c		;
	ld (byte_475e),a	;086e		; byte_475e = 1;
	jp cret			;0871		; }


; =============== F U N C T I O N ===========================================
; 20	sub_0874h	ok++
;
sub_0874h:					; void sub_0874h() {
	call csv		;0874		;
	push hl			;0877		;
	push hl			;0878		;
	ld hl,(word_4763)	;0879		;
	ld (ix-002h),l		;087c		;
	ld (ix-001h),h	;l1	;087f		; l1 = word_4763;
	jp l0901h		;0882		; goto m4;
l0885h:						; m1:
	ld de,00200h		;0885		;
	ld l,(ix-002h)		;0888		;
	ld h,(ix-001h)	;l1	;088b		;
	call wrelop		;088e		;
	jp m,l0899h		;0891		;
	ld hl,00200h		;0894		;
	jr l089fh		;0897		;
l0899h:					;m2:	;
	ld l,(ix-002h)		;0899		;
	ld h,(ix-001h)		;089c		;
l089fh:					;m3:	;
	ld (ix-004h),l		;089f		;
	ld (ix-003h),h	;l2	;08a2		; l2 = (l1 < 0x200) ? l1 : 0x200;
	ld hl,(word_4b6d)	;08a5		;
	push hl		;\4	;08a8		;
	ld l,(ix-004h)		;08a9		;
	ld h,(ix-003h)		;08ac		;
	push hl		;\3	;08af		;
	ld hl,00001h		;08b0		;
	push hl		;\2	;08b3		;
	ld hl,l4767h		;08b4		;
	push hl		;\1	;08b7		;
	call read1		;08b8		;
	pop bc			;08bb		;
	pop bc			;08bc		;
	pop bc			;08bd		;
	pop bc			;08be		;
	ld e,(ix-004h)		;08bf		;
	ld d,(ix-003h)	;l2	;08c2		;
	or a			;08c5		;
	sbc hl,de		;08c6		;
	call nz,sub_0d14h	;08c8		; if(read1(arry_4767, 1, l2, word_4b6d) != l2) sub_0d14h();
	ld hl,(word_4967)	;08cb		;
	push hl		;\4	;08ce		;
	ld l,(ix-004h)		;08cf		;
	ld h,(ix-003h)		;08d2		;
	push hl		;\3	;08d5		;
	ld hl,00001h		;08d6		;
	push hl		;\2	;08d9		;
	ld hl,l4767h		;08da		;
	push hl		;\1	;08dd		;
	call sub_0366h		;08de		; sub_0366h(arry_4767, 1, l2, word_4967);
	pop bc			;08e1		;
	pop bc			;08e2		;
	pop bc			;08e3		;
	pop bc			;08e4		;
	ld e,(ix-004h)		;08e5		;
	ld d,(ix-003h)	;l2	;08e8		;
	ld hl,(word_474d)	;08eb		;
	add hl,de		;08ee		;
	ld (word_474d),hl	;08ef		; word_474d += l2;
	ld l,(ix-002h)		;08f2		;
	ld h,(ix-001h)	;l1	;08f5		;
	or a			;08f8		;
	sbc hl,de		;08f9		;
	ld (ix-002h),l		;08fb		;
	ld (ix-001h),h	;l1	;08fe		; l1 -= l2;
l0901h:						; m4:
	ld a,(ix-002h)		;0901		;
	or (ix-001h)	;l1	;0904		;
	jp nz,l0885h		;0907		; if(l1 != 0) goto m1;
	ld a,001h		;090a		;
	ld (byte_4751),a	;090c		; byte_4751 = 1;
	jp cret			;090f		; }


; =============== F U N C T I O N ===========================================
; 21	sub_0912h	ok++
;
sub_0912h:					; void sub_0912h(char * p1) {
	call csv		;0912		;
	push hl			;0915		;
	push hl			;0916		;
	ld hl,l41e7h		;0917		;
	push hl			;091a		;
	ld l,(ix+006h)		;091b		;
	ld h,(ix+007h)	;p1	;091e		;
	push hl			;0921		;
	call _fopen		;0922		;
	pop bc			;0925		;
	pop bc			;0926		;
	push hl			;0927		;
	pop iy			;0928		;
	ld a,l			;092a		;
	or h			;092b		;
	jr nz,l0939h		;092c		; if((st = fopen(p1, "wb")) != 0) goto m1;
	ld l,(ix+006h)		;092e		;
	ld h,(ix+007h)	;p1	;0931		;
	push hl			;0934		;
	call sub_11c4h		;0935		; sub_11c4h(p1);
	pop bc			;0938		;
l0939h:						; m1:
	ld hl,(word_4763)	;0939		;
	ld (ix-002h),l		;093c		;
	ld (ix-001h),h	;l1	;093f		; l1 = word_4763;
	jp l09b8h		;0942		; goto m5;
l0945h:						; m2:
	ld de,00200h		;0945		;
	ld l,(ix-002h)		;0948		;
	ld h,(ix-001h)	;l1	;094b		;
	call wrelop		;094e		;
	jp m,l0959h		;0951		;
	ld hl,00200h		;0954		;
	jr l095fh		;0957		;
l0959h:					;m3:	;
	ld l,(ix-002h)		;0959		;
	ld h,(ix-001h)	;l1	;095c		;
l095fh:					;m4:	;
	ld (ix-004h),l		;095f		;
	ld (ix-003h),h	;l2	;0962		; l2 = (l1 < 0x200) ? l1 : 0x200;
	ld hl,(word_4b6d)	;0965		;
	push hl			;0968		;
	ld l,(ix-004h)		;0969		;
	ld h,(ix-003h)	;l2	;096c		;
	push hl			;096f		;
	ld hl,00001h		;0970		;
	push hl			;0973		;
	ld hl,l4767h		;0974		;
	push hl			;0977		;
	call read1		;0978		;
	pop bc			;097b		;
	pop bc			;097c		;
	pop bc			;097d		;
	pop bc			;097e		;
	ld e,(ix-004h)		;097f		;
	ld d,(ix-003h)	;l2	;0982		;
	or a			;0985		;
	sbc hl,de		;0986		;
	call nz,sub_0d14h	;0988		; if(read1(arry_4767, 1, l2, word_4b6d) != l2) sub_0d14h();
	push iy			;098b		;
	ld l,(ix-004h)		;098d		;
	ld h,(ix-003h)		;0990		;
	push hl			;0993		;
	ld hl,00001h		;0994		;
	push hl			;0997		;
	ld hl,l4767h		;0998		;
	push hl			;099b		;
	call sub_0366h		;099c		; sub_0366h(arry_4767, 1, l2, st);
	pop bc			;099f		;
	pop bc			;09a0		;
	pop bc			;09a1		;
	pop bc			;09a2		;
	ld e,(ix-004h)		;09a3		;
	ld d,(ix-003h)		;09a6		;
	ld l,(ix-002h)		;09a9		;
	ld h,(ix-001h)		;09ac		;
	or a			;09af		;
	sbc hl,de		;09b0		;
	ld (ix-002h),l		;09b2		;
	ld (ix-001h),h		;09b5		; l1 -= l2;
l09b8h:						; m5:
	ld a,(ix-002h)		;09b8		;
	or (ix-001h)		;09bb		;
	jr nz,l0945h		;09be		; if(l1 != 0) goto m2;
	push iy			;09c0		;
	call _fclose		;09c2		; fclose(st);
	ld a,001h		;09c5		;
	ld (byte_4751),a	;09c7		; byte_4751 = 1;
	jp cret			;09ca		; }


; =============== F U N C T I O N ===========================================
; 22	sub_09cdh	ok++
;
sub_09cdh:					; void sub_09cdh(char * p1) {
	call ncsv		;09cd		;
	defw 0xfffa		;09d0		;
	ld   hl,41eah		;09d2		;
	push hl			;09d5		;
	ld l,(ix+006h)		;09d6		;
	ld h,(ix+007h)	;p1	;09d9		;
	push hl			;09dc		;
	call _fopen		;09dd		;
	pop bc			;09e0		;
	pop bc			;09e1		;
	push hl			;09e2		;
	pop iy			;09e3		;
	ld a,l			;09e5		;
	or h			;09e6		;
	jr nz,l09f4h		;09e7		; if((st = fopen(p1, "rb")) == 0)
	ld l,(ix+006h)		;09e9		;
	ld h,(ix+007h)	;p1	;09ec		;
	push hl			;09ef		;
	call sub_11c4h		;09f0		;     sub_11c4h(p1);
	pop bc			;09f3		;
l09f4h:					;m1:	;
	ld (ix-006h),000h	;09f4		;
	ld (ix-005h),000h ;l3	;09f8		; l3  = 0;
	ld de,(word_474b)	;09fc		;
	ld l,(ix+008h)		;0a00		;
	ld h,(ix+009h)	;p2	;0a03		;
	add hl,hl		;0a06		;
	add hl,de		;0a07		;
	ld c,(hl)		;0a08		;
	inc hl			;0a09		;
	ld b,(hl)		;0a0a		;
	ld (ix-002h),c		;0a0b		;
	ld (ix-001h),b	;l1	;0a0e		; l1 = *((int *)word_474b+p2);
	jr l0a56h		;0a11		; goto m3;
l0a13h:						; m2:
	ld hl,(word_4967)	;0a13		;
	push hl		;\4	;0a16		;
	ld l,(ix-004h)		;0a17		;
	ld h,(ix-003h)	;l2	;0a1a		;
	push hl		;\3	;0a1d		;
	ld hl,00001h		;0a1e		;
	push hl		;\2	;0a21		;
	ld hl,l4767h		;0a22		;
	push hl		;\1	;0a25		;
	call sub_0366h		;0a26		; sub_0366h(arry_4767, 1, l2, word_4967);
	pop bc			;0a29		;
	pop bc			;0a2a		;
	pop bc			;0a2b		;
	pop bc			;0a2c		;
	ld e,(ix-004h)		;0a2d		;
	ld d,(ix-003h)	;l2	;0a30		;
	ld l,(ix-006h)		;0a33		;
	ld h,(ix-005h)	;l3	;0a36		;
	add hl,de		;0a39		;
	ld (ix-006h),l		;0a3a		;
	ld (ix-005h),h	;l3	;0a3d		; l3 += l2;
	ld hl,(word_474d)	;0a40		;
	add hl,de		;0a43		;
	ld (word_474d),hl	;0a44		; word_474d += l2;
	ld l,(ix-002h)		;0a47		;
	ld h,(ix-001h)	;l1	;0a4a		;
	or a			;0a4d		;
	sbc hl,de		;0a4e		;
	ld (ix-002h),l		;0a50		;
	ld (ix-001h),h	;l1	;0a53		; l1 -= l2;
l0a56h:						; m3:
	push iy		;\4	;0a56		;
	ld e,(ix-002h)		;0a58		;
	ld d,(ix-001h)	;l1	;0a5b		;
	ld hl,00200h		;0a5e		;
	call wrelop		;0a61		;
	jr c,l0a6eh		;0a64		;
	ld l,(ix-002h)		;0a66		;
	ld h,(ix-001h)	;l1	;0a69		;
	jr l0a71h		;0a6c		;
l0a6eh:					; m4:	;
	ld hl,00200h		;0a6e		;
l0a71h:					; m5:	;
	push hl		;\3	;0a71		;
	ld hl,00001h		;0a72		;
	push hl		;\2	;0a75		;
	ld hl,l4767h		;0a76		;
	push hl		;\1	;0a79		;
	call read1		;0a7a		;
	pop bc			;0a7d		;
	pop bc			;0a7e		;
	pop bc			;0a7f		;
	pop bc			;0a80		;
	ld (ix-004h),l		;0a81		;
	ld (ix-003h),h	;l2	;0a84		;
	ld a,l			;0a87		;
	or h			;0a88		;
	jr nz,l0a13h		;0a89		; if(read1(arry_4767, 1, (0x200 < l1) ? 0x200 : l1, st) != l2) goto m2;
	push iy			;0a8b		;
	call _fclose		;0a8d		; fclose(st);
	jp cret			;0a90		; }

struct aaa {
    char *  i1;
    char    i2;
}

; =============== F U N C T I O N ===========================================
; 23	sub_0a93h	ok++
;
sub_0a93h:					; sub_0a93h(char * p1, int p2) {
	call ncsv		;0a93		; register struct aaa * st;
	defw 0xfffa		;0a96		;
	ld   l,(ix+06h)		;0a98		;
	ld   h,(ix+07h)	;p1	;0a9b		;
	push hl			;0a9e		;
	call sub_14aeh		;0a9f		;
	pop bc			;0aa2		;
	ex de,hl		;0aa3		;
	ld (ix-002h),e		;0aa4		;
	ld (ix-001h),d	;l1	;0aa7		; l1 = sub_14aeh(p1);
	push de		;\	;0aaa		;
	ld de,(word_474b)	;0aab		;
	ld l,(ix+008h)		;0aaf		;
	ld h,(ix+009h)	;p2	;0ab2		;
	add hl,hl		;0ab5		;
	add hl,de		;0ab6		;
	pop de		;/	;0ab7		;
	ld (hl),e		;0ab8		;
	inc hl			;0ab9		;
	ld (hl),d		;0aba		; word_474b[p2] = l1;
	ld de,word_4d8d		;0abb		;
	ld hl,(word_4d84)	;0abe		;
	or a			;0ac1		;
	sbc hl,de		;0ac2		;
	ld de,00003h		;0ac4		;
	call adiv		;0ac7		;
	ld (ix-006h),l		;0aca		;
	ld (ix-005h),h	;l3	;0acd		; l3 = (word_4d84-word_4d8d)/3;
	add hl,hl		;0ad0		;
	ld (ix-004h),l		;0ad1		;
	ld (ix-003h),h	;l2	;0ad4		; l2 = l3*2;
	ld iy,word_4d8d		;0ad7		; st = word_4d8d;
	jr l0afbh		;0adb		; goto m2;
l0addh:						; m1:
	ld l,(iy+000h)		;0add		;
	ld h,(iy+001h)	;st->i1	;0ae0		;
	push hl			;0ae3		;
	call strlen		;0ae4		;
	pop bc			;0ae7		;
	ex de,hl		;0ae8		;
	ld l,(ix-004h)		;0ae9		;
	ld h,(ix-003h)	;l2	;0aec		;
	add hl,de		;0aef		;
	ld (ix-004h),l		;0af0		;
	ld (ix-003h),h	;l2	;0af3		; l2 += strlen(st->i1);
	ld de,00003h		;0af6		;
	add iy,de		;0af9		; ++st;
l0afbh:						; m2:
	ld de,(word_4d84)	;0afb		;
	push iy			;0aff		;
	pop hl			;0b01		;
	or a			;0b02		;
	sbc hl,de		;0b03		;
	jr nz,l0addh		;0b05		; if(st != word_4d84) goto m1;
	ld l,(ix+006h)		;0b07		;
	ld h,(ix+007h)	;p1	;0b0a		;
	push hl			;0b0d		;
	call strlen		;0b0e		;
	ld e,(ix-004h)		;0b11		;
	ld d,(ix-003h)	;l2	;0b14		;
	add hl,de		;0b17		;
	ld de,0000dh		;0b18		;
	add hl,de		;0b1b		;
	ex de,hl		;0b1c		;
	ld hl,(word_475c)	;0b1d		;
	add hl,de		;0b20		;
	ld (word_475c),hl	;0b21		; word_475c += (strlen(p1) + l2 + 0xD);
	ld hl,arry_4969		;0b24		;
	ex (sp),hl		;0b27		;
	ld l,(ix-004h)		;0b28		;
	ld h,(ix-003h)	;l2	;0b2b		;
	push hl			;0b2e		;
	call sub_0c31h		;0b2f		; sub_0c31h(l2, arry_4969);
	pop bc			;0b32		;
	ld hl,arry_496b		;0b33		;
	ex (sp),hl		;0b36		;
	ld l,(ix-006h)		;0b37		;
	ld h,(ix-005h)	;l3	;0b3a		;
	push hl			;0b3d		;
	call sub_0c31h		;0b3e		; sub_0c31h(l3, arry_496b);
	pop bc			;0b41		;
	ld hl,arry_496d		;0b42		;
	ex (sp),hl		;0b45		;
	ld e,(ix-002h)		;0b46		;
	ld d,(ix-001h)	;l1	;0b49		;
	ld hl,00000h		;0b4c		;
	push hl			;0b4f		;
	push de			;0b50		;
	call sub_0bd5h		;0b51		; sub_0bd5h(l1, arry_496d);
	pop bc			;0b54		;
	pop bc			;0b55		;
	ld hl,04971h		;0b56		;
	ex (sp),hl		;0b59		;
	ld de,(word_4754)	;0b5a		;
	ld hl,(word_4756)	;0b5e		;
	push hl			;0b61		;
	push de			;0b62		;
	call sub_0bd5h		;0b63		; sub_0bd5h(long_4754, arry_4971);
	pop bc			;0b66		;
	pop bc			;0b67		;
	ld hl,(word_4967)	;0b68		;
	ex (sp),hl	;\4	;0b6b		;
	ld hl,0000ch		;0b6c		;
	push hl		;\3	;0b6f		;
	ld hl,00001h		;0b70		;
	push hl		;\2	;0b73		;
	ld hl,arry_4969		;0b74		;
	push hl		;\1	;0b77		;
	call sub_0366h		;0b78		; sub_0366h(arry_4969, 1, 0xC, word_4967);
	pop bc			;0b7b		;
	pop bc			;0b7c		;
	pop bc			;0b7d		;
	ld de,0000ch		;0b7e		;
	ld hl,(word_474d)	;0b81		;
	add hl,de		;0b84		;
	ld (word_474d),hl	;0b85		; word_474d += 0xC;
	ld l,(ix+006h)		;0b88		;
	ld h,(ix+007h)	;p1	;0b8b		;
	ex (sp),hl		;0b8e		;
	call sub_0ce7h		;0b8f		; sub_0ce7h(p1);
	pop bc			;0b92		;
	ld iy,word_4d8d		;0b93		; st = word_4d8d;
	jr l0bbfh		;0b97		; goto m4;
l0b99h:						; m3:
	ld hl,(word_4967)	;0b99		;
	push hl			;0b9c		;
	ld l,(iy+002h)	;st->i2	;0b9d		;
	ld h,000h		;0ba0		;
	push hl			;0ba2		;
	call _fputc		;0ba3		; fputc(st->i2, word_4967);
	pop bc			;0ba6		;
	pop bc			;0ba7		;
	ld hl,(word_474d)	;0ba8		;
	inc hl			;0bab		;
	ld (word_474d),hl	;0bac		; ++word_474d;
	ld l,(iy+000h)		;0baf		;
	ld h,(iy+001h)	;st->i1	;0bb2		;
	push hl			;0bb5		;
	call sub_0ce7h		;0bb6		; sub_0ce7h(st->i1);
	pop bc			;0bb9		;
	ld de,00003h		;0bba		;
	add iy,de		;0bbd		; ++st;
l0bbfh:						; m4:
	ld de,(word_4d84)	;0bbf		;
	push iy			;0bc3		;
	pop hl			;0bc5		;
	or a			;0bc6		;
	sbc hl,de		;0bc7		;
	jr nz,l0b99h		;0bc9		; if(st != word_4d84) goto m3;
	ld hl,(word_475a)	;0bcb		;
	inc hl			;0bce		;
	ld (word_475a),hl	;0bcf		; ++word_475a;
	jp cret			;0bd2		; }


; =============== F U N C T I O N ===========================================
; 24	sub_0bd5h	ok++
;
sub_0bd5h:					; void sub_0bd5h(long p1, char * p2) {
	call csv		;0bd5		;
	ld a,(ix+006h)		;0bd8		;
	ld l,(ix+00ah)	;	;0bdb		;
	ld h,(ix+00bh)	;p2	;0bde		;
	ld (hl),a		;0be1		; *p2 = p1;
	ld b,008h		;0be2		;
	ld e,a			;0be4		;
	ld d,(ix+007h)		;0be5		;
	ld l,(ix+008h)		;0be8		;
	ld h,(ix+009h)	;p1	;0beb		;
	call llrsh		;0bee		;
	ld l,(ix+00ah)		;0bf1		;
	ld h,(ix+00bh)	;p2	;0bf4		;
	inc hl			;0bf7		;
	ld (hl),e		;0bf8		; *(p2+1) = p1 >> 8;
	ld b,010h		;0bf9		;
	ld e,(ix+006h)	;	;0bfb		;
	ld d,(ix+007h)	;	;0bfe		;
	ld l,(ix+008h)	;	;0c01		;
	ld h,(ix+009h)	;p1	;0c04		;
	call llrsh		;0c07		;
	ld l,(ix+00ah)	;	;0c0a		;
	ld h,(ix+00bh)	;p2	;0c0d		;
	inc hl			;0c10		;
	inc hl			;0c11		;
	ld (hl),e		;0c12		; *(p2+2) = p1 >> 0x10;
	ld b,018h		;0c13		;
	ld e,(ix+006h)	;	;0c15		;
	ld d,(ix+007h)	;	;0c18		;
	ld l,(ix+008h)	;	;0c1b		;
	ld h,(ix+009h)	;p1	;0c1e		;
	call llrsh		;0c21		;
	ld l,(ix+00ah)	;	;0c24		;
	ld h,(ix+00bh)	;p2	;0c27		;
	inc hl			;0c2a		;
	inc hl			;0c2b		;
	inc hl			;0c2c		;
	ld (hl),e		;0c2d		; *(p2+3) = p1 >> 0x18;
	jp cret			;0c2e		; }


; =============== F U N C T I O N ===========================================
; 25	sub_0c31h	ok++
;
sub_0c31h:					; sub_0c31h(int p1, char * p2) {
	call csv		;0c31		;
	ld a,(ix+006h)	;p1	;0c34		;
	ld l,(ix+008h)		;0c37		;
	ld h,(ix+009h)	;p2	;0c3a		;
	ld (hl),a		;0c3d		; *p2 = p1;
	ld b,008h		;0c3e		;
	ld l,a			;0c40		;
	ld h,(ix+007h)	;p1	;0c41		;
	call shlr		;0c44		;
	ld a,l			;0c47		;
	ld l,(ix+008h)		;0c48		;
	ld h,(ix+009h)	;p2	;0c4b		;
	inc hl			;0c4e		;
	ld (hl),a		;0c4f		; *(p2+1) = p1 >> 8;
	jp cret			;0c50		; }


; =============== F U N C T I O N ===========================================
; 26	sub_0c53h	ok++
;
sub_0c53h:					; uint sub_0c53h(register char * p1) {
	call csv		;0c53		;
	ld l,(ix+006h)		;0c56		;
	ld h,(ix+007h)	;p1	;0c59		;
	push hl			;0c5c		;
	pop iy			;0c5d		;
	ld b,008h		;0c5f		;
	ld l,(iy+001h)		;0c61		;
	ld h,000h		;0c64		;
	call sub_40c2h ;shal <<	;0c66		;
	ex de,hl		;0c69		;
	ld l,(iy+000h)		;0c6a		;
	ld h,000h		;0c6d		;
	add hl,de		;0c6f		; return *p1 + (*(p1+1) << 8);
	jp cret			;0c70		; }


; =============== F U N C T I O N ===========================================
; 27	sub_0c73h	conv_atol	ok++
;
sub_0c73h:					; long sub_0c73h(register char * p1) {
	call csv		;0c73		;
	ld l,(ix+006h)		;0c76		;
	ld h,(ix+007h)	;p1	;0c79		;
	push hl			;0c7c		;
	pop iy			;0c7d		;
	ld b,018h		;0c7f		;
	ld l,(iy+003h)		;0c81		;
	ld h,000h		;0c84		;
	call sub_40c2h ;shal <<	;0c86		;
	ex de,hl		;0c89		;
	push de		;\	;0c8a		;
	ld b,010h		;0c8b		;
	ld l,(iy+002h)		;0c8d		;
	ld h,000h		;0c90		;
	call sub_40c2h ;shal <<	;0c92		;
	ex de,hl		;0c95		;
	push de		;\	;0c96		;
	ld b,008h		;0c97		;
	ld l,(iy+001h)		;0c99		;
	ld h,000h		;0c9c		;
	call sub_40c2h ;shal <<	;0c9e		;
	ex de,hl		;0ca1		;
	ld l,(iy+000h)		;0ca2		;
	ld h,000h		;0ca5		;
	add hl,de		;0ca7		;
	pop de		;/	;0ca8		;
	add hl,de		;0ca9		;
	pop de		;/	;0caa		;
	add hl,de		;0cab		;
	ex de,hl		;0cac		;
	ld hl,00000h		;0cad		; return *p1 + (*(p1+1) << 8) + (*(p1+2) << 0x10) + (*(p1+3) << 0x18);
	jp cret			;0cb0		; }


; =============== F U N C T I O N ===========================================
; 28	sub_0cb3h	ok++
;
sub_0cb3h:					; void sub_0cb3h(register char * p1) {
	call csv		;0cb3		; int  l1;
	push hl			;0cb6		;
	ld l,(ix+006h)		;0cb7		;
	ld h,(ix+007h)	;p1	;0cba		;
	push hl			;0cbd		;
	pop iy			;0cbe		;
l0cc0h:						; m1:
	ld hl,(word_4761)	;0cc0		;
	push hl			;0cc3		;
	call fgetc		;0cc4		;
	pop bc			;0cc7		;
	ld (ix-002h),l		;0cc8		;
	ld (ix-001h),h	;l1	;0ccb		;
	ld de,0ffffh		;0cce		;
	or a			;0cd1		;
	sbc hl,de		;0cd2		;
	call z,sub_0d14h	;0cd4		; if((l1 = fgetc(word_4761)) == -1) sub_0d14h();
	ld a,(ix-002h)		;0cd7		;
	ld (iy+000h),a		;0cda		; *p1 = l1;
	inc iy			;0cdd		; ++p1;
	or (ix-001h)		;0cdf		;
	jr nz,l0cc0h		;0ce2		; if(l1 != 0) goto m1;
	jp cret			;0ce4		; }


; =============== F U N C T I O N ===========================================
; 29	sub_0ce7h	ok++
;
sub_0ce7h:					; void sub_0ce7h(register char * p1) {
	call csv		;0ce7		;
	ld l,(ix+006h)		;0cea		;
	ld h,(ix+007h)	;p1	;0ced		;
	push hl			;0cf0		;
	pop iy			;0cf1		;
l0cf3h:						; m1:
	ld hl,(word_474d)	;0cf3		;
	inc hl			;0cf6		;
	ld (word_474d),hl	;0cf7		; ++word_474d;
	ld hl,(word_4967)	;0cfa		;
	push hl		;\	;0cfd		;
	ld a,(iy+000h)		;0cfe		;
	inc iy			;0d01		; ++st;
	ld l,a			;0d03		;
	rla			;0d04		;
	sbc a,a			;0d05		;
	ld h,a			;0d06		;
	push hl			;0d07		;
	call _fputc		;0d08		;
	pop bc			;0d0b		;
	pop bc			;0d0c		;
	ld a,l			;0d0d		;
	or h			;0d0e		;
	jr nz,l0cf3h		;0d0f		; if(fputc(*p1, word_4967) != 0) goto m1;
	jp cret			;0d11		; }


; =============== F U N C T I O N ===========================================
; 30	sub_0d14h	ok++
;
sub_0d14h:					; void sub_0d14h() {
	ld hl,l41edh		;0d14		;
	push hl			;0d17		;
	ld hl,(word_4758)	;0d18		;
	push hl			;0d1b		;
	call sub_1294h ;b_f_frm	;0d1c		;     b_f_frm(word_4758, "unexpected end of file");
	pop bc			;0d1f		;
	pop bc			;0d20		;
	ret			;0d21		; }


; =============== F U N C T I O N ===========================================
; 31	sub_0d22h	ok++
;
sub_0d22h:					; sub_0d22h(char * p1, char p2) {
	call csv		;0d22		;
	ld a,(ix+008h)	;p2	;0d25		;
	or a			;0d28		;
	jr z,l0d33h		;0d29		;
	ld a,(byte_4b73)	;0d2b		;
	ld l,a			;0d2e		;
	ld h,000h		;0d2f		;
	jr l0d39h		;0d31		;
l0d33h:					; m1:	;
	ld a,(byte_4b72)	;0d33		;
	ld l,a			;0d36		;
	ld h,000h		;0d37		;
l0d39h:					; m2:	;
	ld a,l			;0d39		;
	or h			;0d3a		;
	jp z,cret		;0d3b		; if(((p2 == 0) ? byte_4b72 : byte_4b73) == 0) return;
	ld l,(ix+006h)		;0d3e		;
	ld h,(ix+007h)	;p1	;0d41		;
	push hl			;0d44		;
	ld hl,(word_4b74)	;0d45		;
	push hl			;0d48		;
	call strcmp		;0d49		;
	pop bc			;0d4c		;
	pop bc			;0d4d		;
	ld a,l			;0d4e		;
	or h			;0d4f		;
	jr z,l0d6eh		;0d50		; if(strcmp(word_4b74, p1) == 0) goto m3;
	ld l,(ix+006h)		;0d52		;
	ld h,(ix+007h)	;p1	;0d55		;
	ld a,(hl)		;0d58		;
	cp 05fh		;'_'	;0d59		;
	jp nz,cret		;0d5b		; if(*p1 != '_') return;
	inc hl			;0d5e		;
	push hl			;0d5f		;
	ld hl,(word_4b74)	;0d60		;
	push hl			;0d63		;
	call strcmp		;0d64		;
	pop bc			;0d67		;
	pop bc			;0d68		;
	ld a,l			;0d69		;
	or h			;0d6a		;
	jp nz,cret		;0d6b		; if(strcmp(word_4b74, p1+1) != 0) return;
l0d6eh:						; m3:
	ld a,001h		;0d6e		;
	ld (byte_4b76),a	;0d70		; byte_4b76 = 1;
	ld a,(ix+008h)	;p2	;0d73		;
	ld (byte_4b71),a	;0d76		; byte_4b71 = p2;
	jp cret			;0d79		; }


; =============== F U N C T I O N ===========================================
; 32	sub_0d7ch	ok++
;
sub_0d7ch:					; void sub_0d7ch(char * p1) {
	call csv		;0d7c		;
	ld l,(ix+006h)		;0d7f		;
	ld h,(ix+007h)		;0d82		;
	push hl			;0d85		;
	call sub_01fbh		;0d86		;
	pop bc			;0d89		;
	ld a,l			;0d8a		;
	or a			;0d8b		;
	jp z,cret		;0d8c		; if(sub_01fbh(p1) == 0) return;
	ld hl,(word_4b74)	;0d8f		;
	ld a,l			;0d92		;
	or h			;0d93		;
	jr z,l0da9h		;0d94		; if(word_4b74 != 0) {
	xor a			;0d96		;
	ld (byte_4b76),a	;0d97		;     byte_4b76 = 0;
	ld hl,sub_0d22h		;0d9a		;
	push hl			;0d9d		;
	call sub_0727h		;0d9e		;     sub_0727h(sub_0d22h);
	pop bc			;0da1		;
	ld a,(byte_4b76)	;0da2		;
	or a			;0da5		;
	jp z,cret		;0da6		;     if(byte_4b76 == 0) return;
l0da9h:					; m1:	; }
	ld l,(ix+006h)		;0da9		;
	ld h,(ix+007h)		;0dac		;
	push hl			;0daf		;
	ld hl,l422ch		;0db0		;
	push hl			;0db3		;
	call _printf		;0db4		;
	pop bc			;0db7		; printf("%-15.15s", p1);
	pop bc			;0db8		;
	ld hl,(word_4b74)	;0db9		;
	ld a,l			;0dbc		;
	or h			;0dbd		;
	jr z,l0de8h		;0dbe		; if(word_4b74 != 0)
	ld b,007h		;0dc0		;
	ld a,(byte_4b71)	;0dc2		;
	call brelop		;0dc5		;
	jr nc,l0ddbh		;0dc8		;
	ld a,(byte_4b71)	;0dca		;
	ld e,a			;0dcd		;
	ld d,000h		;0dce		;
	ld hl,arry_4204		;0dd0		;
	add hl,de		;0dd3		;
	ld a,(hl)		;0dd4		;
	ld l,a			;0dd5		;
	rla			;0dd6		;
	sbc a,a			;0dd7		;
	ld h,a			;0dd8		;
	jr l0ddeh		;0dd9		;
l0ddbh:					; m2:	;
	ld hl,0003fh		;0ddb		;
l0ddeh:					; m3:	;
	push hl			;0dde		;
	ld hl,l4235h		;0ddf	" %c"	;
	push hl			;0de2		;
	call _printf		;0de3		;     printf(" %c", (byte_4b71 >= 7) ? 03f : arry_4204[byte_4b71]);
	pop bc			;0de6		;
	pop bc			;0de7		;
l0de8h:					; m4:	;
	ld hl,0000ah		;0de8		;
	push hl			;0deb		;
	call _putchar		;0dec		; putchar('\n');
	jp cret			;0def		; }


; =============== F U N C T I O N ===========================================
; 33	sub_0df2h	ok++
;
sub_0df2h:					; void sub_0df2h(char * p1, char * p2) {
	call csv		;0df2		;
	ld l,(ix+006h)		;0df5		;
	ld h,(ix+007h)	;p1	;0df8		;
	ld a,(hl)		;0dfb		;
	or a			;0dfc		;
	jr z,l0e30h		;0dfd		; if(*p1 == 0) goto m3;
	ld l,(ix+008h)		;0dff		;
	ld h,(ix+009h)	;p2	;0e02		;
	ld (word_4b74),hl	;0e05		; word_4b74 = p2;
l0e08h:						; m1:
	ld l,(ix+006h)		;0e08		;
	ld h,(ix+007h)	;p1	;0e0b		;
	ld a,(hl)		;0e0e		;
	cp 064h			;0e0f		;
	jr z,l0e3ah		;0e11		; if(*p1 == 'd') goto m4;
	cp 075h			;0e13		;
	jr z,l0e41h		;0e15		; if(*p1 == 'u') goto m5;
	ld hl,l420ch		;0e17		;
	push hl			;0e1a		;
	call sub_117ch		;0e1b		; sub_117ch("Subkeys: d(defined) u(ndefined)");
	pop bc			;0e1e		;
l0e1fh:						; m2:
	ld l,(ix+006h)		;0e1f		;
	ld h,(ix+007h)	;p1	;0e22		;
	inc hl			;0e25		;
	ld (ix+006h),l		;0e26		;
	ld (ix+007h),h	;p1	;0e29		;
	ld a,(hl)		;0e2c		;
	or a			;0e2d		;
	jr nz,l0e08h		;0e2e		; if(*(++p1) != 0) goto m1;
l0e30h:						; m3:
	ld hl,sub_0d7ch		;0e30		;
	push hl			;0e33		;
	call sub_0621h		;0e34		; sub_0621h(sub_0d7ch);
	jp cret			;0e37		; return;
l0e3ah:						; m4:
	ld a,001h		;0e3a		;
	ld (byte_4b72),a	;0e3c		; byte_4b72 = 1;
	jr l0e1fh		;0e3f		; goto m2;
l0e41h:						; m5:
	ld a,001h		;0e41		;
	ld (byte_4b73),a	;0e43		; byte_4b73 = 1;
	jr l0e1fh		;0e46		; goto m2;
						; }


; =============== F U N C T I O N ===========================================
; 34	sub_0e48h	ok++
;
sub_0e48h:					; void sub_0e48h(char * p1, int p2) {
	call csv		;0e48		;
	ld de,(word_4b77)	;0e4b		;
	ld hl,(word_4b79)	;0e4f		;
	call wrelop		;0e52		;
	jp m,l0e66h		;0e55		; if(word_4b79 >= word_4b77) {
	ld hl,l4239h		;0e58		;
	push hl			;0e5b		;
	call _printf		;0e5c		;     printf("\t\t");
	pop bc			;0e5f		;
	ld hl,00000h		;0e60		;     word_4b79 = 0;
	ld (word_4b79),hl	;0e63		; }
l0e66h:					; m1:	;
	ld l,(ix+006h)		;0e66		;
	ld h,(ix+007h)	;p1	;0e69		;
	push hl		;\	;0e6c		;
	ld de,00007h		;0e6d		;
	ld l,(ix+008h)		;0e70		;
	ld h,(ix+009h)	;p2	;0e73		;
	call wrelop		;0e76		;
	jp p,l0e8dh		;0e79		;
	ld e,(ix+008h)		;0e7c		;
	ld d,(ix+009h)	;p2	;0e7f		;
	ld hl,arry_4204		;0e82		;
	add hl,de		;0e85		;
	ld a,(hl)		;0e86		;
	ld l,a			;0e87		;
	rla			;0e88		;
	sbc a,a			;0e89		;
	ld h,a			;0e8a		;
	jr l0e90h		;0e8b		;
l0e8dh:					;m2:	;
	ld hl,0003fh		;0e8d	;hl='?' ;
l0e90h:					;m3:	;
	push hl			;0e90		;
	ld hl,l423ch		;0e91		;
	push hl			;0e94		;
	call _printf		;0e95		; printf("%c %-12.12s", ((p2 >= 7) ? '?' : arry_4204[p2]), p1);
	pop bc			;0e98		;
	pop bc			;0e99		;
	pop bc			;0e9a		;
	ld de,(word_4b77)	;0e9b		;
	ld hl,(word_4b79)	;0e9f		;
	inc hl			;0ea2		;
	ld (word_4b79),hl	;0ea3		;
	call wrelop		;0ea6		;
	jp m,l0eb7h		;0ea9		; if(++word_4b79 < word_4b77) {
	ld hl,l4248h		;0eac		;
	push hl			;0eaf		;
	call _printf		;0eb0		;     printf("\n");
	pop bc			;0eb3		;
	jp cret			;0eb4		;     return;
l0eb7h:					; m4:	; }
	ld hl,l424ah		;0eb7		;
	push hl			;0eba		;
	call _printf		;0ebb		; printf("  ");
	jp cret			;0ebe		; }



; =============== F U N C T I O N ===========================================
; 35	sub_0ec1h	ok++
;
sub_0ec1h:					; void sub_0ec1h(char * p1) {
	call csv		;0ec1		;
	ld l,(ix+006h)		;0ec4		;
	ld h,(ix+007h)	;p1	;0ec7		;
	push hl			;0eca		;
	call sub_01fbh		;0ecb		;
	pop bc			;0ece		;
	ld a,l			;0ecf		;
	or a			;0ed0		;
	jp z,cret		;0ed1		; if(sub_01fbh(p1) == 0) return;
	ld l,(ix+006h)		;0ed4		;
	ld h,(ix+007h)	;p1	;0ed7		;
	push hl			;0eda		;
	ld hl,l424dh		;0edb		;
	push hl			;0ede		;
	call _printf		;0edf		; printf("%-16.15s", p1);
	pop bc			;0ee2		;
	ld hl,00000h		;0ee3		;
	ld (word_4b79),hl	;0ee6		; word_4b79 = 0;
	ld hl,sub_0e48h		;0ee9		;
	ex (sp),hl		;0eec		;
	call sub_0727h		;0eed		;
	pop bc			;0ef0		; sub_0727h(sub_0e48h);
	ld hl,(word_4b79)	;0ef1		;
	ld a,l			;0ef4		;
	or h			;0ef5		;
	jp z,cret		;0ef6		; if(word_4b79 == 0) return;
	ld de,(word_4b77)	;0ef9		;
	call wrelop		;0efd		;
	jp p,cret		;0f00		; if(word_4b79 >= word_4b77) return;
	ld hl,0000ah		;0f03		;
	push hl			;0f06		;
	call _putchar		;0f07		; putchar('\n');
	jp cret			;0f0a		; }


; =============== F U N C T I O N ===========================================
; 36	sub_0f0dh	ok++
;
sub_0f0dh:					; void sub_0f0dh() {
	ld de,(word_4256)	;0f0d		;
	ld hl,0fff0h	;-16	;0f11		;
	add hl,de		;0f14		;
	ld de,00010h	;16	;0f15		;
	call adiv		;0f18		;
	ld (word_4b77),hl	;0f1b		;
	ld a,l			;0f1e		;
	or h			;0f1f		;
	jr nz,l0f28h		;0f20		; if((word_4b77 = (word_4256 -16)/16) == 0)
	ld hl,00001h		;0f22		;
	ld (word_4b77),hl	;0f25		;     word_4b77 = 1;
l0f28h:
	ld hl,sub_0ec1h		;0f28		;
	push hl			;0f2b		;
	call sub_0621h		;0f2c		; sub_0621h(sub_0ec1h);
	ld hl,sub_12d4h		;0f2f		;
	ex (sp),hl		;0f32		;
	call sub_025bh		;0f33		; sub_025bh(sub_12d4h);
	pop bc			;0f36		;
	ret			;0f37		; }


; =============== F U N C T I O N ===========================================
; 37
;
main:						; int main(argc, argv) char ** argv; {
	call csv		;0f38		;
	push hl			;0f3b		;
	push hl			;0f3c		;
	ld hl,00001h		;0f3d		;
	push hl			;0f40		;
	push hl			;0f41		;
	call _signal		;0f42		;
	pop bc			;0f45		;
	pop bc			;0f46		;
	ld de,00001h		;0f47		;
	or a			;0f4a		;
	sbc hl,de		;0f4b		;
	jr z,l0f5bh		;0f4d		; if(signal(1, 1) != 1)
	ld hl,sub_12fbh		;0f4f		;
	push hl			;0f52		;
	ld l,e			;0f53		;
	ld h,d			;0f54		;
	push hl			;0f55		;
	call _signal		;0f56		;     signal(1, sub_12fbh);
	pop bc			;0f59		;
	pop bc			;0f5a		;
l0f5bh:				;	; m1:	;
	ld de,00001h		;0f5b		;
	ld l,(ix+006h)		;0f5e		;
	ld h,(ix+007h)	;argc	;0f61		;
	or a			;0f64		;
	sbc hl,de		;0f65		;
	jr nz,l0f85h		;0f67		; if(argc == 1) {
	ld hl,l42ebh		;0f69	"libr"	;
	push hl			;0f6c		;
	ld hl,00000h		;0f6d		;
	push hl			;0f70		;
	call __getargs		;0f71		;
	pop bc			;0f74		;
	pop bc			;0f75		;
	ld (ix+008h),l		;0f76		;
	ld (ix+009h),h		;0f79		;     argv = _getargs(0, "libr");
	ld hl,(__argc_)		;0f7c		;
	ld (ix+006h),l		;0f7f		;
	ld (ix+007h),h	;argc	;0f82		;     argc = _argc_;
l0f85h:				;	; m2:	; }
	ld hl,__iob		;0f85		;
	push hl			;0f88		;
	call _fclose		;0f89		; fclose(stdin);
	pop bc			;0f8c		;
	ld l,(ix+006h)		;0f8d		;
	ld h,(ix+007h)	;argc	;0f90		;
	dec hl			;0f93		;
	ld (ix+006h),l		;0f94		;
	ld (ix+007h),h	;argc	;0f97		; --argc;
	ld l,(ix+008h)		;0f9a		;
	ld h,(ix+009h)	;argv	;0f9d		;
	inc hl			;0fa0		;
	inc hl			;0fa1		;
	ld (ix+008h),l		;0fa2		;
	ld (ix+009h),h	;argv	;0fa5		; ++argv;	
	jr l0fdfh		;0fa8		; goto m5;
l0faah:				;		; m3:
	ld l,(ix+008h)		;0faa		;
	ld h,(ix+009h)	;argv	;0fad		;
	ld c,(hl)		;0fb0		;
	inc hl			;0fb1		;
	ld b,(hl)		;0fb2		;
	inc bc			;0fb3		;
	ld (ix-002h),c		;0fb4		;
	ld (ix-001h),b	;l1	;0fb7		; l1 = *argv;
l0fbah:				;		; m4:
	ld l,(ix-002h)		;0fba		;
	ld h,(ix-001h)	;l1	;0fbd		;
	ld a,(hl)		;0fc0		;
	or a			;0fc1		;
	jr nz,l0fe9h		;0fc2		; if(*l1 != 0) goto m6;
	ld l,(ix+006h)		;0fc4		;
	ld h,(ix+007h)	;argc	;0fc7		;
	dec hl			;0fca		;
	ld (ix+006h),l		;0fcb		;
	ld (ix+007h),h	;argc	;0fce		; --argc;
	ld l,(ix+008h)		;0fd1		;
	ld h,(ix+009h)	;argv	;0fd4		;
	inc hl			;0fd7		;
	inc hl			;0fd8		;
	ld (ix+008h),l		;0fd9		;
	ld (ix+009h),h	;argv	;0fdc		; ++argv;
l0fdfh:				;		; m5:
	ld a,(ix+006h)		;0fdf		;
	or (ix+007h)	;argc	;0fe2		;
	jr nz,l1045h		;0fe5		; if(argc != 0) goto m10;
	jr l1055h		;0fe7		; goto m11;
l0fe9h:				;		; m6:
	ld l,(ix-002h)		;0fe9
	ld h,(ix-001h)	;l1	;0fec
	ld a,(hl)		;0fef
	inc hl			;0ff0
	ld (ix-002h),l		;0ff1
	ld (ix-001h),h	;l1	;0ff4		; 
	cp 050h		;'P'	;0ff7
	jr z,l1018h		;0ff9		; if(*l1++ == 'P') goto m9;
	cp 057h		;'W'	;0ffb
	jr z,l1011h		;0ffd		; if(*l1 == 'W') goto m8;
	cp 070h		;'p'	;0fff
	jr z,l1018h		;1001		; if(*l1 == 'p') goto m9;
	cp 077h		;'w'	;1003
	jr z,l1011h		;1005		; if(*l1 == 'w') goto m8;
l1007h:				;		; m7:
	ld hl,msg_425e		;1007		;
	push hl			;100a		;
	call sub_117ch		;100b		; sub_117ch(msg_425e);
	pop bc			;100e		;
	jr l0fbah		;100f		; goto m4;
l1011h:				;		; m8:
	ld a,001h		;1011		;
	ld (byte_4b7b),a	;1013		; byte_4b7b = 1;
	jr l0fbah		;1016		; goto m4;
l1018h:				;		; m9:
	ld l,(ix-002h)		;1018		;
	ld h,(ix-001h)	;l1	;101b		;
	ld a,(hl)		;101e		;
	ld e,a			;101f		;
	rla			;1020		;
	sbc a,a			;1021		;
	ld d,a			;1022		;
	ld hl,l46b4h		;1023		;
	add hl,de		;1026		;
	bit 2,(hl)		;1027		;
	jr z,l1007h		;1029		; if(isdigit(l1) == 0) goto m7;
	ld l,(ix-002h)		;102b		;
	ld h,(ix-001h)	;l1	;102e		;
	push hl			;1031		;
	call atoi		;1032		;
	pop bc			;1035		;
	ld (word_4256),hl	;1036		; word_4256 = atoi(l1);
	ld hl,arry_42f0		;1039		;
	ld (ix-002h),l		;103c		;
	ld (ix-001h),h	;l1	;103f		; l1 = arry_42f0;
	jp l0fbah		;1042		; goto m4;
l1045h:				;		; m10:
	ld l,(ix+008h)		;1045		;
	ld h,(ix+009h)	;argv	;1048		;
	ld a,(hl)		;104b		;
	inc hl			;104c		;
	ld h,(hl)		;104d		;
	ld l,a			;104e		;
	ld a,(hl)		;104f		;
	cp 02dh		;'-'	;1050		;
	jp z,l0faah		;1052		; if(**argv == '-') goto m3;
l1055h:				;		; m11:
	ld de,00002h		;1055		;
	ld l,(ix+006h)		;1058		;
	ld h,(ix+007h)	;argc	;105b		;
	call wrelop		;105e		;
	jp p,l106ch		;1061		; if(argc < 2)
	ld hl,msg_425e		;1064		;
	push hl			;1067		;
	call sub_117ch		;1068		;     sub_117ch(msg_425e);
	pop bc			;106b		;
l106ch:				;	; m12:	;
	ld l,(ix+008h)		;106c		;
	ld h,(ix+009h)	;argv	;106f		;
	ld c,(hl)		;1072		;
	inc hl			;1073		;
	ld b,(hl)		;1074		;
	ld (ix-004h),c		;1075		;
	ld (ix-003h),b	;l2	;1078		; l2 = *argv;
	ld l,(ix+006h)		;107b		;
	ld h,(ix+007h)	;argc	;107e		;
	dec hl			;1081		;
	ld (ix+006h),l		;1082		;
	ld (ix+007h),h	;argc	;1085		; --argc;	
	ld l,(ix+008h)		;1088		;
	ld h,(ix+009h)	;argv	;108b		;
	inc hl			;108e		;
	inc hl			;108f		;
	ld (ix+008h),l		;1090		;
	ld (ix+009h),h	;argv	;1093		; ++argv;
	ld l,c			;1096		;
	ld h,b		;l2	;1097		;
	ld a,(hl)		;1098		;
	ld e,a			;1099		;
	rla			;109a		;
	sbc a,a			;109b		;
	ld d,a			;109c		;
	ld hl,l46b4h		;109d _ctype_+1	;
	add hl,de		;10a0		;
	bit 0,(hl)		;10a1 isupper()	;
	ld l,c			;10a3		;
	ld h,b			;10a4		;
	ld a,(hl)		;10a5		;
	jr nz,l10aeh		;10a6		;
	ld l,a			;10a8		;
	rla			;10a9		;
	sbc a,a			;10aa		;
	ld h,a			;10ab		;
	jr l10b6h		;10ac		;
l10aeh:				;	; m13:	;
	ld e,a			;10ae		;
	rla			;10af		;
	sbc a,a			;10b0		;
	ld d,a			;10b1		;
	ld hl,00020h		;10b2		;
	add hl,de		;10b5		;
l10b6h:				;	; m14:	;
	push hl			;10b6		;
	ld hl,arry_4258	"rdxms" ;10b7		;
	push hl			;10ba		;
	call index		;10bb		;
	pop bc			;10be		;
	pop bc			;10bf		;
	ld (ix-002h),l		;10c0		;
	ld (ix-001h),h	;l1	;10c3		; l1 = index(arry_4258, (isupper(*l2) != 0) ? *l2 + ' ' : *l2);
	ld a,l			;10c6		;
	or h			;10c7		;
	jr nz,l10d2h		;10c8		; if(l1 == 0)
	ld hl,l42a4h		;10ca		;
	push hl			;10cd		;
	call sub_117ch		;10ce		;     sub_117ch("Keys: r(eplace), d(elete), (e)x(tract), m(odules), s(ymbols)");
	pop bc			;10d1		;
l10d2h:				;	; m15:	;
	ld de,arry_4258	"rdxms" ;10d2		;
	ld l,(ix-002h)		;10d5		;
	ld h,(ix-001h)	;l1	;10d8		;
	or a			;10db		;
	sbc hl,de		;10dc		;
	ld (word_4b7e),hl	;10de		; word_4b7e = l1 - arry_4258;
	ld l,(ix-004h)		;10e1		;
	ld h,(ix-003h)	;l2	;10e4		;
	inc hl			;10e7		;
	ld a,(hl)		;10e8		;
	or a			;10e9		;
	jr z,l1116h		;10ea		; if(*(l2+1) == 0) goto m16;
	ld l,(ix+008h)		;10ec		;
	ld h,(ix+009h)	;argv	;10ef		;
	ld c,(hl)		;10f2		;
	inc hl			;10f3		;
	ld b,(hl)		;10f4		;
	ld (ix-002h),c		;10f5		;
	ld (ix-001h),b	;l1	;10f8		; l1 = *argv;
	ld l,(ix+006h)		;10fb		;
	ld h,(ix+007h)	;argc	;10fe		;
	dec hl			;1101		;
	ld (ix+006h),l		;1102		;
	ld (ix+007h),h	;argc	;1105		; --argc;
	ld l,(ix+008h)		;1108		;
	ld h,(ix+009h)	;argv	;110b		;
	inc hl			;110e		;
	inc hl			;110f		;
	ld (ix+008h),l		;1110		;
	ld (ix+009h),h	;argv	;1113		; ++argv;
l1116h:				;		; m16:
	ld a,(ix+006h)		;1116		;
	or (ix+007h)	;argc	;1119		;
	jr nz,l1126h		;111c		; if(argc != 0) goto m17;
	ld hl,msg_425e		;111e		;
	push hl			;1121		;
	call sub_117ch		;1122		; sub_117ch(msg_425e);
	pop bc			;1125		;
l1126h:				;		; m17:
	ld l,(ix+008h)		;1126		;
	ld h,(ix+009h)	;argv	;1129		;
	ld c,(hl)		;112c		;
	inc hl			;112d		;
	ld b,(hl)		;112e		;
	push bc			;112f		;
	call sub_03dah		;1130		; sub_03dah(*argv);
	pop bc			;1133		;
	ld l,(ix+008h)		;1134		;
	ld h,(ix+009h)	;argv	;1137		;
	inc hl			;113a		;
	inc hl			;113b		;
	push hl		;\2	;113c		;
	ld l,(ix+006h)		;113d		;
	ld h,(ix+007h)	;argc	;1140		;
	dec hl			;1143		;
	push hl		;\1	;1144		;
	call sub_01cch		;1145		; sub_01cch(argc-1, argv+1);
	pop bc			;1148		;
	pop bc			;1149		;
	ld l,(ix-002h)		;114a		;
	ld h,(ix-001h)	;l1	;114d		;
	push hl		;\2	;1150		;
	ld l,(ix-004h)		;1151		;
	ld h,(ix-003h)	;l2	;1154		;
	inc hl			;1157		;
	push hl		;\1	;1158		;
	ld de,l42e1h ;func_42e1	;1159		;
	ld hl,(word_4b7e)	;115c		;
	add hl,hl		;115f		;
	add hl,de		;1160		;
	ld a,(hl)		;1161		;
	inc hl			;1162		;
	ld h,(hl)		;1163		;
	ld l,a			;1164		;
	call indir		;1165		; func_42e1[word_4b7e](l2, l1);
	pop bc			;1168		;
	pop bc			;1169		;
	ld hl,(word_4b7c)	;116a		;
	ld a,l			;116d		;
	or h			;116e		;
	ld hl,00001h		;116f		;
	jr nz,l1175h		;1172		;
	dec hl			;1174		;
l1175h:				;	; m18:  ;
	push hl			;1175		;
	call sub_12e8h		;1176		; sub_12e8h(word_4b7c != 0);
	jp cret			;1179		; }

; =============== F U N C T I O N ===========================================
; 38	sub_117ch	ok++
;
sub_117ch:					; void sub_117ch(p1, p2, p3, p4, p5) {
	call csv		;117c		;
	ld l,(ix+00eh)		;117f		;
	ld h,(ix+00fh)	;p5	;1182		;
	push hl			;1185		;
	ld l,(ix+00ch)		;1186		;
	ld h,(ix+00dh)	;p4	;1189		;
	push hl			;118c		;
	ld l,(ix+00ah)		;118d		;
	ld h,(ix+00bh)	;p3	;1190		;
	push hl			;1193		;
	ld l,(ix+008h)		;1194		;
	ld h,(ix+009h)	;p2	;1197		;
	push hl			;119a		;
	ld l,(ix+006h)		;119b		;
	ld h,(ix+007h)	;p1	;119e		;
	push hl			;11a1		;
	ld hl,__iob16		;11a2		;
	push hl			;11a5		;
	call _fprintf		;11a6		; fprintf(stderr, p1, p2, p3, p4, p5);
	ld hl,0000ch		;11a9		;
	add hl,sp		;11ac		;
	ld sp,hl		;11ad		;
	ld hl,__iob16		;11ae		;
	push hl			;11b1		;
	ld hl,0000ah		;11b2		;
	push hl			;11b5		;
	call _fputc		;11b6		; fputc('\n', stderr);
	pop bc			;11b9		;
	ld hl,00006h		;11ba		;
	ex (sp),hl		;11bd		;
	call sub_12e8h		;11be		; sub_12e8h(6);
	jp cret			;11c1		; }


; =============== F U N C T I O N ===========================================
; 39	sub_11c4h	ok++
;
sub_11c4h:					; void sub_11c4h(char * p1) {
	call csv		;11c4		;
	ld l,(ix+006h)		;11c7		;
	ld h,(ix+007h)	;p1	;11ca		;
	push hl			;11cd		;
	ld hl,l42f1h		;11ce		;
	push hl			;11d1		;
	ld hl,__iob16		;11d2		;
	push hl			;11d5		;
	call _fprintf		;11d6		;     fprintf(stderr, "Can't open %s\n", p1);
	pop bc			;11d9		;
	pop bc			;11da		;
	ld hl,00002h		;11db		;
	ex (sp),hl		;11de		;
	call sub_12e8h		;11df		;     sub_12e8h(2);
	jp cret			;11e2		; }


; =============== F U N C T I O N ===========================================
; 40	sub_11e5h	ok++
;
sub_11e5h:					; void sub_11e5h(char * p1) {
	call csv		;11e5		;
	ld l,(ix+006h)		;11e8		;
	ld h,(ix+007h)		;11eb		;
	push hl			;11ee		;
	ld hl,l4300h		;11ef		;
	push hl			;11f2		;
	ld hl,__iob16		;11f3		;
	push hl			;11f6		;
	call _fprintf		;11f7		;     fprintf(stderr, "Seek error on %s\n", p1);
	pop bc			;11fa		;
	pop bc			;11fb		;
	ld hl,00003h		;11fc		;
	ex (sp),hl		;11ff		;
	call sub_12e8h		;1200		;     sub_12e8h(3);
	jp cret			;1203		; }


; =============== F U N C T I O N ===========================================
; 41	sub_1206h	ok++
;
sub_1206h:					; void sub_1206h(p1, p2, p3, p4, p5) {
	call csv		;1206		;
	ld l,(ix+00eh)		;1209		;
	ld h,(ix+00fh)		;120c		;
	push hl			;120f		;
	ld l,(ix+00ch)		;1210		;
	ld h,(ix+00dh)		;1213		;
	push hl			;1216		;
	ld l,(ix+00ah)		;1217		;
	ld h,(ix+00bh)		;121a		;
	push hl			;121d		;
	ld l,(ix+008h)		;121e		;
	ld h,(ix+009h)		;1221		;
	push hl			;1224		;
	ld l,(ix+006h)		;1225		;
	ld h,(ix+007h)		;1228		;
	push hl			;122b		;
	ld hl,__iob16		;122c		;
	push hl			;122f		;
	call _fprintf		;1230		; fprintf(stderr, p1, p2, p3, p4, p5);
	ld hl,0000ch		;1233		;
	add hl,sp		;1236		;
	ld sp,hl		;1237		;
	ld hl,__iob16		;1238		;
	push hl			;123b		;
	ld hl,0000ah		;123c		;
	push hl			;123f		;
	call _fputc		;1240		; fputc('\n', stderr);
	ld hl,(word_4b7c)	;1243		;
	inc hl			;1246		;
	ld (word_4b7c),hl	;1247		; ++word_4b7c;
	jp cret			;124a		; }


; =============== F U N C T I O N ===========================================
; 42	warning		sub_124dh	ok++
;
sub_124dh:					; void sub_124dh(p1, p2, p3, p4, p5) {
	call csv		;124d		;
	ld a,(byte_4b7b)	;1250		;
	or a			;1253		;
	jp nz,cret		;1254		; if(byte_4b7b != 0)  return;
	ld l,(ix+00eh)		;1257		;
	ld h,(ix+00fh)	;p5	;125a		;
	push hl			;125d		;
	ld l,(ix+00ch)		;125e		;
	ld h,(ix+00dh)	;p4	;1261		;
	push hl			;1264		;
	ld l,(ix+00ah)		;1265		;
	ld h,(ix+00bh)	;p3	;1268		;
	push hl			;126b		;
	ld l,(ix+008h)		;126c		;
	ld h,(ix+009h)	;p2	;126f		;
	push hl			;1272		;
	ld l,(ix+006h)		;1273		;
	ld h,(ix+007h)	;p1	;1276		;
	push hl			;1279		;
	ld hl,__iob16		;127a		;
	push hl			;127d		;
	call _fprintf		;127e		; fprintf(stderr, p1, p2, p3, p4, p5)
	ld hl,0000ch		;1281		;
	add hl,sp		;1284		;
	ld sp,hl		;1285		;
	ld hl,l4312h		;1286		;
	push hl			;1289		;
	ld hl,__iob16		;128a		;
	push hl			;128d		;
	call _fprintf		;128e		; fprintf(stderr, " (warning)\n");
	jp cret			;1291		; }


; =============== F U N C T I O N ===========================================
; 43	 b_f_frm	ok++
;
sub_1294h:					; void sub_1294h(char * p1, p2, p3, p4, p5, p6) {
	call csv		;1294		;
	ld l,(ix+006h)		;1297		;
	ld h,(ix+007h)	;p1	;129a		;
	push hl			;129d		;
	ld hl,l431eh		;129e		;
	push hl			;12a1		;
	ld hl,__iob16		;12a2		;
	push hl			;12a5		;
	call _fprintf		;12a6		; fprintf(stderr, "bad file format: %s\n", p1);
	pop bc			;12a9		;
	pop bc			;12aa		;
	ld l,(ix+010h)		;12ab		;
	ld h,(ix+011h)	;p6	;12ae		;
	ex (sp),hl		;12b1		;
	ld l,(ix+00eh)		;12b2		;
	ld h,(ix+00fh)	;p5	;12b5		;
	push hl			;12b8		;
	ld l,(ix+00ch)		;12b9		;
	ld h,(ix+00dh)	;p4	;12bc		;
	push hl			;12bf		;
	ld l,(ix+00ah)		;12c0		;
	ld h,(ix+00bh)	;p3	;12c3		;
	push hl			;12c6		;
	ld l,(ix+008h)		;12c7		;
	ld h,(ix+009h)	;p2	;12ca		;
	push hl			;12cd		;
	call sub_117ch		;12ce		; sub_117ch(p2, p3, p4, p5, p6);
	jp cret			;12d1		; }



; =============== F U N C T I O N ===========================================
; 44	sub_12d4h	ok++
;
sub_12d4h:					; void sub_12d4h(char *p1) {
	call csv		;12d4		;
	ld l,(ix+006h)		;12d7		;
	ld h,(ix+007h)	;p1	;12da		;
	push hl			;12dd		;
	ld hl,l4333h		;12de		;
	push hl			;12e1		;
	call sub_1206h		;12e2		;     sub_1206h("no such module: %s", p1);
	jp cret			;12e5		; }


; =============== F U N C T I O N ===========================================
; 45	sub_12e8h	ok++
;
sub_12e8h:					; void sub_12e8h(int p1) {
	call csv		;12e8		;
	call sub_03c7h		;12eb		;     sub_03c7h();
	ld l,(ix+006h)		;12ee		;
	ld h,(ix+007h)	;p1	;12f1		;
	push hl			;12f4		;
	call exit		;12f5		; exit(p1)
	jp cret			;12f8		; }


; =============== F U N C T I O N ===========================================
; 46	sub_12fbh	ok++
;
sub_12fbh:					; void sub_12fbh() {
	ld hl,00004h		;12fb		;
	push hl			;12fe		;
	call sub_12e8h		;12ff		;     sub_12e8h(4);
	pop bc			;1302		;
	ret			;1303		; }


; =============== F U N C T I O N ===========================================
; 47	allocmem	sub_1304h	ok++
;
sub_1304h:					; char * sub_1304h(p1) {
	call csv		;1304		;     char * l1;
	push hl			;1307		;     register char * st;
	ld l,(ix+006h)		;1308		;
	ld h,(ix+007h)	;p1	;130b		;
	push hl			;130e		;
	call _malloc		;130f		;
	pop bc			;1312		;
	ld (ix-002h),l		;1313		;
	ld (ix-001h),h	;l1	;1316		;     l1 = _malloc(p1);
	ld a,l			;1319		;
	or h			;131a		;
	jr nz,l1325h		;131b		;     if(l1 == 0)
	ld hl,l4346h		;131d		;
	push hl			;1320		;
	call sub_117ch		;1321		;         sub_117ch("Cannot get memory");
	pop bc			;1324		;
l1325h:					;m1:	;
	ld l,(ix-002h)		;1325		;
	ld h,(ix-001h)	;l1	;1328		;
	push hl			;132b		;
	pop iy			;132c		;     st = l1;
	jr l1336h		;132e		;     goto m3;
l1330h:						; m2:
	ld (iy+000h),000h	;1330		;     *st = 0;
	inc iy			;1334		;     ++st;
l1336h:						; m3:
	ld l,(ix+006h)		;1336		;
	ld h,(ix+007h)	;p1	;1339		;
	dec hl			;133c		;
	ld (ix+006h),l		;133d		;
	ld (ix+007h),h	;p1	;1340		;
	inc hl			;1343		;
	ld a,l			;1344		;
	or h			;1345		;
	jr nz,l1330h		;1346		;     if(p1-- != 0) goto m2;
	ld l,(ix-002h)		;1348		;
	ld h,(ix-001h)	;l1	;134b		;     return l1;
	jp cret			;134e		; }


; =============== F U N C T I O N ===========================================
; 48
;
sub_1351h:					; void sub_1351h() {
	call csv		;1351		;
	push hl			;1354		;
	ld hl,(word_4d8b)	;1355		;
	push hl			;1358		;
	ld hl,(word_4d82)	;1359		;
	push hl			;135c		;
	ld hl,00001h		;135d		;
	push hl			;1360		;
	ld hl,arry_4b81		;1361		;
	push hl			;1364		;
	call read1		;1365		;
	pop bc			;1368		;
	pop bc			;1369		;
	pop bc			;136a		;
	pop bc			;136b		;
	ld de,(word_4d82)	;136c		;
	or a			;1370		;
	sbc hl,de		;1371		;
	jr z,l1382h		;1373		; if(read1(arry_4b81, 1, word_4d82, word_4d8b) != word_4d82)
	ld hl,l435eh		;1375		;
	push hl			;1378		;
	ld hl,(word_5369)	;1379		;
	push hl			;137c		;
	call sub_1294h ;b_f_frm	;137d		;     b_f_frm(word_5369, "incomplete ident record");
	pop bc			;1380		;
	pop bc			;1381		;
l1382h:				;	; m1:	;
	ld a,(byte_4b80)	;1382		;
	or a			;1385		;
	ld (ix-001h),000h ;l1	;1386		; l1 = 0;
	jr z,l13f5h		;138a		; if(byte_4b80 == 0) goto m9;
	jr l13aah		;138c		; goto m4;
l138eh:				;		; m2:
	ld e,(ix-001h)	;l1	;138e		;
	ld d,000h		;1391		;
	ld hl,arry_4b81		;1393		;
	add hl,de		;1396		;
	ld a,(hl)		;1397		;
	ld hl,arry_4358		;1398		;
	add hl,de		;139b		;
	cp (hl)			;139c		;
	jr z,l13a7h		;139d		; if(arry_4b81[l1] != arry_4358[l1])
	ld hl,l4376h		;139f		;
	push hl			;13a2		;
	call sub_1294h ;b_f_frm	;13a3		;     b_f_frm("ident records do not match");
	pop bc			;13a6		;
l13a7h:				;	; m3:	;
	inc (ix-001h)	;l1	;13a7		; l1++;
l13aah:				;		; m4:
	ld b,004h		;13aa		;
	ld a,(ix-001h)	;l1	;13ac		;
	call brelop		;13af		;
	jr c,l138eh		;13b2		; if(l1 < 4) goto m2;
	ld (ix-001h),000h ;l1	;13b4		; l1 = 0;
	jr l13d6h		;13b8		; goto m7;
l13bah:				;		; m5:
	ld e,(ix-001h)		;13ba		;
	ld d,000h		;13bd		;
	ld hl,arry_4b85		;13bf		;
	add hl,de		;13c2		;
	ld a,(hl)		;13c3		;
	ld hl,arry_435c		;13c4		;
	add hl,de		;13c7		;
	cp (hl)			;13c8		;
	jr z,l13d3h		;13c9		; if(arry_4b85[l1] != arry_435c[l1])
	ld hl,l4391h		;13cb		;
	push hl			;13ce		;
	call sub_1294h ;b_f_frm	;13cf		;     b_f_frm("ident records do not match");
	pop bc			;13d2		;
l13d3h:				;	; m6:	;
	inc (ix-001h)		;13d3		; l1++;
l13d6h:				;		; m7:
	ld b,002h		;13d6		;
	ld a,(ix-001h)		;13d8		;
	call brelop		;13db		;
	jr c,l13bah		;13de		; if(l1 < 2) goto m5;
	jp cret			;13e0		; return;
l13e3h:				;		; m8:
	ld e,(ix-001h)		;13e3		;
	ld d,000h		;13e6		;
	ld hl,arry_4b81		;13e8		;
	add hl,de		;13eb		;
	ld a,(hl)		;13ec		;
	ld hl,arry_4358		;13ed		;
	add hl,de		;13f0		;
	ld (hl),a		;13f1		; arry_4358[l1] = arry_4b81[l1];
	inc (ix-001h)		;13f2		; l1++;
l13f5h:				;		; m9:
	ld b,004h		;13f5		;
	ld a,(ix-001h)		;13f7		;
	call brelop		;13fa		;
	jr c,l13e3h		;13fd		; if(l1 < 4) goto m8;
	ld (ix-001h),000h	;13ff		; l1 = 0;
	jr l1417h		;1403		; goto m11;
l1405h:				;		; m10:
	ld e,(ix-001h)		;1405		;
	ld d,000h		;1408		;
	ld hl,arry_4b85		;140a		;
	add hl,de		;140d		;
	ld a,(hl)		;140e		;
	ld hl,arry_435c		;140f		;
	add hl,de		;1412		;
	ld (hl),a		;1413		; arry_435c[l1] = arry_4b85[l1];
	inc (ix-001h)		;1414		; l1++;
l1417h:				;		; m11:
	ld b,002h		;1417		;
	ld a,(ix-001h)		;1419		;
	call brelop		;141c		;
	jr c,l1405h		;141f		; if(l1 < 2) goto m10;
	ld a,001h		;1421		;
	ld (byte_4b80),a	;1423		; byte_4b80 = 1;
	jp cret			;1426		; }


; =============== F U N C T I O N ===========================================
; 49	calc_val	sub_1429h	ok++
;
sub_1429h:					; int sub_1429h(char * p1) {
	call csv		;1429		;
	ld e,(ix+006h)		;142c		;
	ld d,(ix+007h)	;p1	;142f		; de=p1
	ld a,(arry_435c)	;1432		;
	ld l,a			;1435		;
	ld h,000h		;1436		; hl=(uint)arry_435c[0]
	add hl,de		;1438		; hl=(uint)arry_435c[0]+p1
	ld e,(hl)		;1439		;
	ld d,000h		;143a		; de=(uint)*((uint)arry_435c[0]+p1)
	push de		;\	;143c		;
	ld b,008h		;143d		;
	ld e,(ix+006h)		;143f		;
	ld d,(ix+007h)	;p1	;1442		; de=p1
	ld hl,l435dh		;1445		;
	ld l,(hl)		;1448		;
	ld h,000h		;1449		; hl=(uint)arry_435c[1]
	add hl,de		;144b		; hl=(uint)arry_435c[1]+p1
	ld l,(hl)		;144c		;
	ld h,000h		;144d		; hl=(uint)*((uint)arry_435c[1]+p1)
	call sub_40c2h ;shal <<	;144f		;
	pop de		;/	;1452		;
	add hl,de		;1453		; return (((uint)*((uint)arry_435c[1]+p1)) << 8) + (uint)*((uint)arry_435c[0]+p1);
	jp cret			;1454		; }


; =============== F U N C T I O N ===========================================
; 50	sub_1457h	ok++
;
sub_1457h:					; void sub_1457h(char * p1, char p2) {
	call csv		;1457		; register * st;
	ld de,word_5369		;145a		;
	ld hl,(word_4d84)	;145d		;
	or a			;1460		;
	sbc hl,de		;1461		;
	jr nz,l1472h		;1463		; if(word_4d84 == &word_5369)
	ld hl,(word_5369)	;1465		;
	push hl			;1468		;
	ld hl,l43ach		;1469		;
	push hl			;146c		;
	call sub_117ch		;146d		;     sub_117ch("Too many symbols in %s", word_5369);
	pop bc			;1470		;
	pop bc			;1471		;
l1472h:					;m1:	;
	ld a,(ix+008h)	;p2	;1472		;
	ld iy,(word_4d84)	;1475		; st = word_4d84;
	ld (iy+002h),a		;1479		;
	cp 006h			;147c		;
	jr z,l1485h		;147e		; if((word_4d84->i1=p2)  != 6)
	ld a,001h		;1480		;
	ld (byte_4d8a),a	;1482		;     byte_4d8a = 1;
l1485h:					;m2:	;
	ld l,(ix+006h)		;1485		;
	ld h,(ix+007h)	;p1	;1488		;
	push hl		;\	;148b		;
	push hl			;148c		;
	call strlen		;148d		;
	pop bc			;1490		;
	inc hl			;1491		;
	push hl			;1492		;
	call sub_1304h ;allocmem;1493		;
	pop bc			;1496		;
	ex de,hl		;1497		;
	ld hl,(word_4d84)	;1498		;
	ld (hl),e		;149b		;
	inc hl			;149c		;
	ld (hl),d		;149d		; word_4d84->i1 = allocmem(strlen(p1)+1);
	push de		;\1	;149e		;
	call strcpy		;149f		; strcpy(word_4d84->i1, p1);
	ld hl,(word_4d84)	;14a2		;
	inc hl			;14a5		;
	inc hl			;14a6		;
	inc hl			;14a7		;
	ld (word_4d84),hl	;14a8		; ++word_4d84;
	jp cret			;14ab		; }


; =============== F U N C T I O N ===========================================
; 51	sub_14aeh	ok++
;
sub_14aeh:					; int sub_14aeh(p1) {
	call csv		;14ae		;
	ld hl,l43c3h		;14b1	"rb"	;
	push hl			;14b4		;
	ld l,(ix+006h)		;14b5		;
	ld h,(ix+007h)	;p1	;14b8		;
	ld (word_5369),hl	;14bb		; word_5369 = p1;
	push hl			;14be		;
	call _fopen		;14bf		;
	pop bc			;14c2		;
	pop bc			;14c3		;
	ld (word_4d8b),hl	;14c4		; word_4d8b = fopen(word_5369, "rb");
	ld a,l			;14c7		;
	or h			;14c8		;
	jr nz,l14d3h		;14c9		; if(word_4d8b == 0)
	ld hl,(word_5369)	;14cb		;
	push hl			;14ce		;
	call sub_11c4h		;14cf		;     sub_11c4h(word_5369);
	pop bc			;14d2		;
l14d3h:				;	; m1:	;
	xor a			;14d3		;
	ld (byte_4d8a),a	;14d4		; byte_4d8a = 0;
	ld de,00000h		;14d7		;
	ld l,e			;14da		;
	ld h,d			;14db		;
	ld (04d86h),de		;14dc		;
	ld (04d88h),hl		;14e0		; long_4d86 = 0;
	ld hl,word_4d8d		;14e3		;
	ld (word_4d84),hl	;14e6		; word_4d84 = strc_4d8d;
l14e9h:				;		; m2:
	call sub_1568h		;14e9		; sub_1568h();
	ld a,(byte_4d81)	;14ec		;
	cp 004h			;14ef		;
	jr z,l1500h		;14f1		; if(byte_4d81 == 4) goto m3;
	cp 006h			;14f3		;
	jr z,l150ah		;14f5		; if(byte_4d81 == 6) goto m5;
	cp 007h			;14f7		;
	jr z,l1505h		;14f9		; if(byte_4d81 == 7) goto m4;
	call sub_15fbh		;14fb		; sub_15fbh();
	jr l14e9h		;14fe		; goto m2;
l1500h:				;		; m3:
	call sub_162ah		;1500		; sub_162ah();
	jr l14e9h		;1503		; goto m2;
l1505h:				;		; m4:
	call sub_1351h		;1505		; sub_1351h();
	jr l14e9h		;1508		; goto m2;
l150ah:				;		; m5:
	ld hl,(word_4d8b)	;150a		;
	push hl			;150d		;
	call _fclose		;150e		; fclose(word_4d8b);
	pop bc			;1511		;
	ld de,00000h		;1512		;
	ld hl,00001h		;1515		;
	push hl			;1518		;
	push de			;1519		;
	ld de,(04d86h)		;151a		;
	ld hl,(04d88h)		;151e		;
	call lrelop		;1521		;
	jp m,l152fh		;1524		; if(long_4d86 > 1)
	ld hl,l43c6h		;1527		;
	push hl			;152a		;
	call sub_117ch		;152b		;     sub_117ch("file too big");
	pop bc			;152e		;
l152fh:				;	; m6:	;
	ld a,(byte_4d8a)	;152f		;
	or a			;1532		;
	jr nz,l1542h		;1533		; if(byte_4d8a == 0)
	ld hl,(word_5369)	;1535		;
	push hl			;1538		;
	ld hl,l43d3h		;1539		;
	push hl			;153c		;
	call sub_124dh ;warning	;153d		;     warning("module %s defines no symbols", word_5369);
	pop bc			;1540		;
	pop bc			;1541		;
l1542h:				;	; m7:	;
	ld hl,(04d86h)		;1542		; return long_4d86;
	jp cret			;1545		; }


; =============== F U N C T I O N ===========================================
; 52	sub_1548h	ok++
;
sub_1548h:					; int sub_1548h(char * p1) {
	call csv		;1548		;
	ld l,(ix+006h)		;154b
	ld h,(ix+007h)	;p1	;154e
	push hl			;1551
	pop iy			;1552		; st = p1;
	ld b,008h		;1554
	ld l,(iy+001h)		;1556
	ld h,000h		;1559
	call sub_40c2h ;shal <<	;155b
	ex de,hl		;155e		;
	ld l,(iy+000h)		;155f
	ld h,000h		;1562		;
	add hl,de		;1564		; return (uint)*((uint)(st+1)) + (*((int)st) << 8);
	jp cret			;1565		; }


; =============== F U N C T I O N ===========================================
; 53	sub_1568h	ok++
;
sub_1568h:					; void sub_1568h() {
	ld hl,(word_4d8b)	;1568		;
	push hl		;\4	;156b		;
	ld hl,00001h		;156c		;
	push hl		;\3	;156f		;
	ld hl,00003h		;1570		;
	push hl		;\2	;1573		;
	ld hl,arry_4b81		;1574		;
	push hl		;\1	;1577		;
	call read1		;1578		;
	pop bc			;157b		;
	pop bc			;157c		;
	pop bc			;157d		;
	pop bc			;157e		;
	ld de,00001h		;157f		;
	or a			;1582		;
	sbc hl,de		;1583		;
	jr z,l1594h		;1585		; if(read1(arry_4b81, 3, 1, word_4d8b) != 1)
	ld hl,l43f0h		;1587		;
	push hl			;158a		;
	ld hl,(word_5369)	;158b		;
	push hl			;158e		;
	call sub_1294h ;b_f_frm	;158f		;     sub_1294h(word_5369, "no end record found");
	pop bc			;1592		;
	pop bc			;1593		;
l1594h:					;m1:	;
	ld hl,byte_4b83		;1594		;
	ld a,(hl)		;1597		;
	ld (byte_4d81),a	;1598		;
	or a			;159b		;
	jr z,l15a5h		;159c		; if((byte_4d81 = byte_4b83) == 0) goto m2;
	ld b,009h		;159e		;
	call brelop		;15a0		;
	jr c,l15bah		;15a3		; if(byte_4d81 < 9) goto m3;
l15a5h:						; m2:
	ld a,(byte_4d81)	;15a5		;
	ld l,a			;15a8		;
	ld h,000h		;15a9		;
	push hl			;15ab		;
	ld hl,l4404h		;15ac		;
	push hl			;15af		;
	ld hl,(word_5369)	;15b0		;
	push hl			;15b3		;
	call sub_1294h ;b_f_frm	;15b4		;     b_f_frm(word_5369, "unknown record type: %d", (uint)byte_4d81);
	pop bc			;15b7		;
	pop bc			;15b8		;
	pop bc			;15b9		;
l15bah:						; m3:
	ld hl,arry_4b81		;15ba		;
	push hl			;15bd		;
	call sub_1548h		;15be		;
	pop bc			;15c1		;
	ld (word_4d82),hl	;15c2		;
	ex de,hl		;15c5		;
	ld hl,sub_01fbh+2	;15c6 0x01FD	;
	call wrelop		;15c9		;
	jp p,l15e6h		;15cc		; if(0x01FD < (word_4d82 = sub_1548h(arry_4b81)))
	ld hl,(word_4d82)	;15cf		;
	push hl			;15d2		;
	ld hl,00003h		;15d3		;
	push hl			;15d6		;
	ld hl,l441ch		;15d7		;
	push hl			;15da		;
	ld hl,(word_5369)	;15db		;
	push hl			;15de		;
	call sub_1294h ;b_f_frm	;15df		;     b_f_frm(word_5369, "record too long: %d+%d", 3, word_4d82);
	pop bc			;15e2		;
	pop bc			;15e3		;
	pop bc			;15e4		;
	pop bc			;15e5		;
l15e6h:					;m4:	;
	ld de,(word_4d82)	;15e6		;
	inc de			;15ea		;
	inc de			;15eb		;
	inc de			;15ec		;
	ld a,d			;15ed		;
	rla			;15ee		;
	sbc a,a			;15ef		;
	ld l,a			;15f0		;
	ld h,a			;15f1		;
	push hl			;15f2		;
	push de			;15f3		;
	ld hl,04d86h		;15f4		;
	call asaladd		;15f7		; long_4d86 += (word_4d82+1);
	ret			;15fa		; }


; =============== F U N C T I O N ===========================================
; 54	sub_15fbh	ok++
;
sub_15fbh:					; void sub_15fbh() {
	ld hl,00001h		;15fb		;
	push hl			;15fe		;
	ld de,(word_4d82)	;15ff		;
	ld a,d			;1603		;
	rla			;1604		;
	sbc a,a			;1605		;
	ld l,a			;1606		;
	ld h,a			;1607		;
	push hl			;1608		;
	push de			;1609		;
	ld hl,(word_4d8b)	;160a		;
	push hl			;160d		;
	call _fseek		;160e		;
	pop bc			;1611		;
	pop bc			;1612		;
	pop bc			;1613		;
	pop bc			;1614		;
	ld de,0ffffh		;1615		;
	or a			;1618		;
	sbc hl,de		;1619		;
	ret nz			;161b		; if(fseek(word_4d8b, word_4d82, 1) != -1) return;
	ld hl,l4433h		;161c		;
	push hl			;161f		;
	ld hl,(word_5369)	;1620		;
	push hl			;1623		;
	call sub_1294h ;b_f_frm	;1624		; b_f_frm(word_5369, "incomplete record");
	pop bc			;1627		;
	pop bc			;1628		;
	ret			;1629		; }


; =============== F U N C T I O N ===========================================
; 55	sub_162ah	ok++
;
sub_162ah:					; void sub_162ah() {
	call ncsv		;162a		; char * l1;
	defw 0xfffb		;162d		; int l2;
	ld hl,(word_4d8b)	;162f		; char l3;
	push hl		;\4	;1632		; register chat * st;
	ld hl,(word_4d82)	;1633		;
	push hl		;\3	;1636		;
	ld hl,00001h		;1637		;
	push hl		;\2	;163a		;
	ld hl,arry_4b81		;163b		;
	push hl		;\1	;163e		;
	call read1		;163f		;
	pop bc			;1642		;
	pop bc			;1643		;
	pop bc			;1644		;
	pop bc			;1645		;
	ld de,(word_4d82)	;1646		;
	or a			;164a		;
	sbc hl,de		;164b		;
	jr z,l165ch		;164d		; if(read1(arry_4b81, 1, word_4d82, word_4d8b) != word_4d82)
	ld hl,l4445h		;164f		;
	push hl			;1652		;
	ld hl,(word_5369)	;1653		;
	push hl			;1656		;
	call sub_1294h ;b_f_frm	;1657		;     b_f_frm(word_5369, "incomplete symbol record");
	pop bc			;165a		;
	pop bc			;165b		;
l165ch:					;m1:	;
	ld iy,arry_4b81		;165c		; st = arry_4b81;
	jp l16d3h		;1660		; goto m8;
l1663h:						; m2:
	push iy			;1663		;
	pop hl			;1665		;
	inc hl			;1666		;
	inc hl			;1667		;
	inc hl			;1668		;
	inc hl			;1669		;
	push hl			;166a		;
	call sub_1429h		;166b		;
	pop bc			;166e		;
	ld (ix-004h),l		;166f		;
	ld (ix-003h),h	;l2	;1672		; l2 = sub_1429h(st+4);
	ld a,l			;1675		;
	and 00fh		;1676		;
	ld (ix-005h),a	;l3	;1678		; l3 = l2 & 0xF;
	push iy			;167b		;
	pop de			;167d		;
	ld hl,00006h		;167e		;
	add hl,de		;1681		;
	ld (ix-002h),l		;1682		;
	ld (ix-001h),h	;l1	;1685		; l1 = st+6
l1688h:						; m3:
	ld l,(ix-002h)		;1688		;
	ld h,(ix-001h)	;l1	;168b		;
	ld a,(hl)		;168e		;
	inc hl			;168f		;
	ld (ix-002h),l		;1690		;
	ld (ix-001h),h	;l1	;1693		;
	or a			;1696		;
	jr nz,l1688h		;1697		; if(*(l1++) != 0) goto m3;
	bit 4,(ix-004h)		;1699		;
	ld a,(ix-005h)	;l3	;169d		;
	jr z,l16a5h		;16a0		; if(bittst(l2,4) == 0) goto m4;
	or a			;16a2		;
	jr z,l16b0h		;16a3		; if(l3 == 0) goto m5;
l16a5h:						; m4:
	cp 002h			;16a5		;
	jr z,l16b0h		;16a7		; if(l3 == 2) goto m5;
	ld a,(ix-005h)	;l3	;16a9		;
	cp 006h			;16ac		;
	jr nz,l16c2h		;16ae		; if(l3 != 6) goto m6;
l16b0h:						; m5:
	ld l,(ix-005h)	;l3	;16b0		;
	ld h,000h		;16b3		;
	push hl			;16b5		;
	ld l,(ix-002h)		;16b6		;
	ld h,(ix-001h)	;l1	;16b9		;
	push hl			;16bc		;
	call sub_1457h		;16bd		; sub_1457h(l1, l2);
	pop bc			;16c0		;
	pop bc			;16c1		;
l16c2h:						; m6:
	ld l,(ix-002h)		;16c2		;
	ld h,(ix-001h)	;l1	;16c5		;
	push hl			;16c8		;
	pop iy			;16c9		; st = l1;
l16cbh:						; m7:
	ld a,(iy+000h)		;16cb		;
	inc iy			;16ce		;
	or a			;16d0		;
	jr nz,l16cbh		;16d1		; if(*(st++) != 0) goto m7;
l16d3h:						; m8:
	ld de,(word_4d82)	;16d3		;
	ld hl,arry_4b81		;16d7		;
	add hl,de		;16da		;
	ex de,hl		;16db		;
	push iy			;16dc		;
	pop hl			;16de		;
	call wrelop		;16df		;
	jp c,l1663h		;16e2		; if(st < arry_4b81[word_4d82]) goto m2;
	jp cret			;16e5		; }



; =============== F U N C T I O N ===========================================
; 56	sub_16e8h	ok++
;
sub_16e8h:					; void sub_16e8h(char * p1) {
	call csv		;16e8		;
	ld l,(ix+006h)		;16eb		;
	ld h,(ix+007h)	;p1	;16ee		;
	push hl			;16f1		;
	call sub_01fbh		;16f2		;
	pop bc			;16f5		;
	ld a,l			;16f6		;
	or a			;16f7		;
	jr z,l171bh		;16f8		; if(sub_01fbh(p1) != 0) {
	ld l,(ix+006h)		;16fa		;
	ld h,(ix+007h)	;p1	;16fd		;
	push hl			;1700		;
	call sub_01fbh		;1701		;
	ld e,l			;1704		;
	ld d,000h		;1705		;
	ld hl,0ffffh		;1707		;
	add hl,de		;170a		;
	ex (sp),hl		;170b		;
	ld l,(ix+006h)		;170c		;
	ld h,(ix+007h)	;p1	;170f		;
	push hl			;1712		;
	call sub_0a93h		;1713		;     sub_0a93h(p1, (uint)sub_01fbh(p1) - 1);
	pop bc			;1716		;
	pop bc			;1717		;
	jp cret			;1718		;     return;
l171bh:					; m1:	; }
	call sub_0789h		;171b		; sub_0789h();
	jp cret			;171e		; }



; =============== F U N C T I O N ===========================================
; 57	sub_1721h	ok++
;
sub_1721h:					; void sub_1721h(char * p1) {
	call csv		;1721		;
	ld l,(ix+006h)		;1724		;
	ld h,(ix+007h)	;p1	;1727		;
	push hl			;172a		;
	call sub_01fbh		;172b		;
	pop bc			;172e		;
	ld a,l			;172f		;
	or a			;1730		;
	jr z,l1754h		;1731		; if(sub_01fbh(p1) != 0) goto m1;
	ld l,(ix+006h)		;1733		;
	ld h,(ix+007h)	;p1	;1736		;
	push hl			;1739		;
	call sub_01fbh		;173a		;
	ld e,l			;173d		;
	ld d,000h		;173e		;
	ld hl,0ffffh		;1740		;
	add hl,de		;1743		;
	ex (sp),hl		;1744		;
	ld l,(ix+006h)		;1745		;
	ld h,(ix+007h)	;p1	;1748		;
	push hl			;174b		;
	call sub_09cdh		;174c		;     sub_09cdh(p1, (uint)sub_01fbh(p1) - 1);
	pop bc			;174f		;
	pop bc			;1750		;
	jp cret			;1751		;     return;
l1754h:					; m1:	; }
	call sub_0874h		;1754		; sub_0874h();
	jp cret			;1757		; }



; =============== F U N C T I O N ===========================================
; 58	sub_175ah	ok++
;
sub_175ah:					; void sub_175ah() {
	ld hl,(word_4745)	;175a		;
	ld a,l			;175d		;
	or h			;175e		;
	jr nz,l1769h		;175f		; if(word_4745 == 0)
	ld hl,l445eh		;1761		;
	push hl			;1764		;
	call sub_117ch		;1765		;     sub_117ch("replace what ?");
	pop bc			;1768		;
l1769h:					; m1:	;
	call sub_0487h		;1769		; sub_0487h();
	call sub_034ah		;176c		; sub_034ah();
	ld hl,sub_16e8h		;176f		;
	push hl			;1772		;
	call sub_0621h		;1773		; sub_0621h(sub_16e8h);
	ld hl,sub_0a93h		;1776		;
	ex (sp),hl		;1779		;
	call sub_025bh		;177a		; sub_025bh(sub_0a93h);
	pop bc			;177d		;
	call sub_04d6h		;177e		; sub_04d6h();
	ld hl,sub_1721h		;1781		;
	push hl			;1784		;
	call sub_0621h		;1785		; sub_0621h(sub_1721h);
	ld hl,sub_09cdh		;1788		;
	ex (sp),hl		;178b		;
	call sub_025bh		;178c		; sub_025bh(sub_09cdh);
	pop bc			;178f		;
	jp sub_053ch		;1790		; sub_053ch();
						; }
						
; ===========================================================================

; =============== F U N C T I O N ===========================================
; 59
;
__getargs:
	call ncsv		;1793
	defw -684
	ld hl,0
	ld (05373h),hl		;179b
	ld a,l			;179e
	ld hl,05372h		;179f
	ld (hl),a		;17a2
	ld hl,05371h		;17a3
	ld (hl),a		;17a6
	ld (05370h),a		;17a7
	ld (ix-034h),a		;17aa
	ld l,(ix+008h)		;17ad
	ld h,(ix+009h)		;17b0
	ld (0536eh),hl		;17b3
	ld l,(ix+006h)		;17b6
	ld h,(ix+007h)		;17b9
	ld (0536bh),hl		;17bc
	ld a,l			;17bf
	or h			;17c0
	ld hl,00001h		;17c1
	jr z,l17c7h		;17c4
	dec hl			;17c6
l17c7h:
	ld a,l			;17c7
	ld (0536dh),a		;17c8
	or a			;17cb
	jr z,l17d4h		;17cc
	ld hl,l446dh		;17ce	"\"
	ld (0536bh),hl		;17d1
l17d4h:
	push ix			;17d4
	pop de			;17d6
	ld hl,0fe38h		;17d7
	add hl,de		;17da
	ld de,(0536eh)		;17db
	ld (hl),e		;17df
	inc hl			;17e0
	ld (hl),d		;17e1
	ld (ix-032h),001h	;17e2
	ld (ix-031h),000h	;17e6
	jp l1b69h		;17ea
l17edh:
	ld de,000c8h		;17ed
	ld l,(ix-032h)		;17f0
	ld h,(ix-031h)		;17f3
	or a			;17f6
	sbc hl,de		;17f7
	jr nz,l1808h		;17f9
	ld hl,00000h		;17fb
	push hl			;17fe
	ld hl,l446fh		;17ff	"too many arguments"
	push hl			;1802
	call _error		;1803
	pop bc			;1806
	pop bc			;1807
l1808h:
	call _nxtch		;1808
	ld a,l			;180b
	ld (ix-033h),a		;180c
	ld l,a			;180f
	rla			;1810
	sbc a,a			;1811
	ld h,a			;1812
	push hl			;1813
	call _isseparator	;1814
	pop bc			;1817
	ld a,l			;1818
	or a			;1819
	jr nz,l1808h		;181a
	ld a,(ix-033h)		;181c
	or a			;181f
	jp z,l1b71h		;1820
	push ix			;1823
	pop de			;1825
	ld hl,0fd54h		;1826
	add hl,de		;1829
	push hl			;182a
	pop iy			;182b
	ld l,a			;182d
	rla			;182e
	sbc a,a			;182f
	ld h,a			;1830
	push hl			;1831
	call sub_1eeah		;1832
	pop bc			;1835
	ld a,l			;1836
	or a			;1837
	ld a,(ix-033h)		;1838
	jp z,l18cfh		;183b
	ld (iy+000h),a		;183e
	inc iy			;1841
	cp 03eh			;1843
	jp nz,l18f9h		;1845
	ld hl,(0536bh)		;1848
	ld a,(hl)		;184b
	cp 03eh			;184c
	jp nz,l18f9h		;184e
	call _nxtch		;1851
	ld e,l			;1854
	ld (iy+000h),e		;1855
	inc iy			;1858
	jp l18f9h		;185a
l185dh:
	push ix			;185d
	pop de			;185f
	ld hl,0fdb8h		;1860
	add hl,de		;1863
	push iy			;1864
	pop de			;1866
	or a			;1867
	sbc hl,de		;1868
	jr nz,l1879h		;186a
	ld hl,00000h		;186c
	push hl			;186f
	ld hl,l4482h		;1870	"argument too long"
	push hl			;1873
	call _error		;1874
	pop bc			;1877
	pop bc			;1878
l1879h:
	ld a,(ix-033h)		;1879
	cp (ix-034h)		;187c
	jr nz,l1887h		;187f
	ld (ix-034h),000h	;1881
	jr l18b0h		;1885
l1887h:
	ld a,(ix-034h)		;1887
	or a			;188a
	jr nz,l189dh		;188b
	ld a,(ix-033h)		;188d
	cp 027h			;1890
	jr z,l1898h		;1892
	cp 022h			;1894
	jr nz,l189dh		;1896
l1898h:
	ld (ix-034h),a		;1898
	jr l18b0h		;189b
l189dh:
	ld a,(ix-034h)		;189d
	or a			;18a0
	ld a,(ix-033h)		;18a1
	jr z,l18abh		;18a4
	or 080h			;18a6
	ld (ix-033h),a		;18a8
l18abh:
	ld (iy+000h),a		;18ab
	inc iy			;18ae
l18b0h:
	ld a,(ix-034h)		;18b0
	or a			;18b3
	jr nz,l18c7h		;18b4
	ld hl,(0536bh)		;18b6
	ld a,(hl)		;18b9
	ld l,a			;18ba
	rla			;18bb
	sbc a,a			;18bc
	ld h,a			;18bd
	push hl			;18be
	call sub_1eeah		;18bf
	pop bc			;18c2
	ld a,l			;18c3
	or a			;18c4
	jr nz,l18f9h		;18c5
l18c7h:
	call _nxtch		;18c7
	ld e,l			;18ca
	ld (ix-033h),e		;18cb
	ld a,e			;18ce
l18cfh:
	or a			;18cf
	jr z,l18f9h		;18d0
	ld a,(ix-034h)		;18d2
	or a			;18d5
	jr nz,l185dh		;18d6
	ld a,(ix-033h)		;18d8
	ld l,a			;18db
	rla			;18dc
	sbc a,a			;18dd
	ld h,a			;18de
	push hl			;18df
	call sub_1eeah		;18e0
	pop bc			;18e3
	ld a,l			;18e4
	or a			;18e5
	jr nz,l18f9h		;18e6
	ld a,(ix-033h)		;18e8
	ld l,a			;18eb
	rla			;18ec
	sbc a,a			;18ed
	ld h,a			;18ee
	push hl			;18ef
	call _isseparator	;18f0
	pop bc			;18f3
	ld a,l			;18f4
	or a			;18f5
	jp z,l185dh		;18f6
l18f9h:
	ld (iy+000h),000h	;18f9
	push ix			;18fd
	pop de			;18ff
	ld hl,0fd54h		;1900
	add hl,de		;1903
	push hl			;1904
	call sub_1eb3h		;1905
	pop bc			;1908
	ld a,l			;1909
	or a			;190a
	push ix			;190b
	pop de			;190d
	ld hl,0fd54h		;190e
	jp z,l1b15h		;1911
	add hl,de		;1914
	push hl			;1915
	pop iy			;1916
	jr l191ch		;1918
l191ah:
	inc iy			;191a
l191ch:
	ld a,(iy+000h)		;191c
	ld e,a			;191f
	rla			;1920
	sbc a,a			;1921
	ld d,a			;1922
	ld hl,l46b4h		;1923 __ctype_+1
	add hl,de		;1926
	bit 2,(hl)		;1927 isdigit()
	jr nz,l191ah		;1929
	ld a,e			;192b
	cp 03ah			;192c
	jr nz,l1944h		;192e
	push ix			;1930
	pop de			;1932
	ld hl,0fd54h		;1933
	add hl,de		;1936
	push iy			;1937
	pop de			;1939
	or a			;193a
	sbc hl,de		;193b
	jr z,l1944h		;193d
	ld hl,00001h		;193f
	jr l1947h		;1942
l1944h:
	ld hl,00000h		;1944
l1947h:
	ld (ix-034h),l		;1947
	push ix			;194a
	pop de			;194c
	ld hl,0fd54h		;194d
	add hl,de		;1950
	push hl			;1951
	push ix			;1952
	pop de			;1954
	ld hl,0ffd4h		;1955
	add hl,de		;1958
	push hl			;1959
	call _setfcb		;195a
	pop bc			;195d
	push ix			;195e
	pop de			;1960
	ld hl,0fdb8h		;1961
	add hl,de		;1964
	ex (sp),hl		;1965
	ld hl,0001ah		;1966
	push hl			;1969
	call bdos		;196a
	pop bc			;196d
	pop bc			;196e
	call _getuid		;196f
	ld (ix-033h),l		;1972
	ld l,(ix-003h)		;1975
	ld h,000h		;1978
	push hl			;197a
	call _setuid		;197b
	push ix			;197e
	pop de			;1980
	ld hl,0ffd4h		;1981
	add hl,de		;1984
	ex (sp),hl		;1985
	ld hl,00011h		;1986
	push hl			;1989
	call bdos		;198a
	pop bc			;198d
	pop bc			;198e
	ld h,000h		;198f
	ld (ix-038h),l		;1991
	ld (ix-037h),h		;1994
	ld de,000ffh		;1997
	or a			;199a
	sbc hl,de		;199b
	jp z,l1ae6h		;199d
l19a0h:
	push ix			;19a0
	pop de			;19a2
	ld hl,0fd54h		;19a3
	add hl,de		;19a6
	push hl			;19a7
	pop iy			;19a8
	ld a,(ix-034h)		;19aa
	or a			;19ad
	jr z,l19cch		;19ae
	ld l,(ix-003h)		;19b0
	ld h,000h		;19b3
	push hl			;19b5
	ld hl,l4494h		;19b6	"%u:"
	push hl			;19b9
	push iy			;19ba
	call _sprintf		;19bc
	pop bc			;19bf
	pop bc			;19c0
	pop bc			;19c1
	push iy			;19c2
	call strlen		;19c4
	pop bc			;19c7
	ld e,l			;19c8
	ld d,h			;19c9
	add iy,de		;19ca
l19cch:
	ld a,(ix-02ch)		;19cc
	or a			;19cf
	jr z,l19e2h		;19d0
	ld l,a			;19d2
	ld h,000h		;19d3
	add a,040h		;19d5
	ld (iy+000h),a		;19d7
	inc iy			;19da
	ld (iy+000h),03ah	;19dc
	inc iy			;19e0
l19e2h:
	push ix			;19e2
	pop de			;19e4
	ld b,005h		;19e5
	ld l,(ix-038h)		;19e7
	ld h,(ix-037h)		;19ea
	call sub_40c2h ;shal <<	;19ed
	add hl,de		;19f0
	ld de,0fdb8h		;19f1
	add hl,de		;19f4
	ld (ix-02eh),l		;19f5
	ld (ix-02dh),h		;19f8
	inc hl			;19fb
	ld (ix-030h),l		;19fc
	ld (ix-02fh),h		;19ff
	jr l1a19h		;1a02
l1a04h:
	ld l,(ix-030h)		;1a04
	ld h,(ix-02fh)		;1a07
	ld a,(hl)		;1a0a
	inc hl			;1a0b
	ld (ix-030h),l		;1a0c
	ld (ix-02fh),h		;1a0f
	and 07fh		;1a12
	ld (iy+000h),a		;1a14
	inc iy			;1a17
l1a19h:
	ld l,(ix-030h)		;1a19
	ld h,(ix-02fh)		;1a1c
	ld a,(hl)		;1a1f
	cp 020h			;1a20
	jr z,l1a3ah		;1a22
	ld e,(ix-02eh)		;1a24
	ld d,(ix-02dh)		;1a27
	ld hl,00009h		;1a2a
	add hl,de		;1a2d
	ex de,hl		;1a2e
	ld l,(ix-030h)		;1a2f
	ld h,(ix-02fh)		;1a32
	call wrelop		;1a35
	jr c,l1a04h		;1a38
l1a3ah:
	ld (iy+000h),02eh	;1a3a
	inc iy			;1a3e
	ld e,(ix-02eh)		;1a40
	ld d,(ix-02dh)		;1a43
	ld hl,00009h		;1a46
	add hl,de		;1a49
	ld (ix-030h),l		;1a4a
	ld (ix-02fh),h		;1a4d
	jr l1a67h		;1a50
l1a52h:
	ld l,(ix-030h)		;1a52
	ld h,(ix-02fh)		;1a55
	ld a,(hl)		;1a58
	inc hl			;1a59
	ld (ix-030h),l		;1a5a
	ld (ix-02fh),h		;1a5d
	and 07fh		;1a60
	ld (iy+000h),a		;1a62
	inc iy			;1a65
l1a67h:
	ld l,(ix-030h)		;1a67
	ld h,(ix-02fh)		;1a6a
	ld a,(hl)		;1a6d
	cp 020h			;1a6e
	jr z,l1a88h		;1a70
	ld e,(ix-02eh)		;1a72
	ld d,(ix-02dh)		;1a75
	ld hl,0000ch		;1a78
	add hl,de		;1a7b
	ex de,hl		;1a7c
	ld l,(ix-030h)		;1a7d
	ld h,(ix-02fh)		;1a80
	call wrelop		;1a83
	jr c,l1a52h		;1a86
l1a88h:
	ld (iy+000h),000h	;1a88
	inc iy			;1a8c
	push ix			;1a8e
	pop de			;1a90
	ld hl,0fd54h		;1a91
	add hl,de		;1a94
	push hl			;1a95
	push ix			;1a96
	pop de			;1a98
	ld hl,0fd54h		;1a99
	add hl,de		;1a9c
	ex de,hl		;1a9d
	push iy			;1a9e
	pop hl			;1aa0
	or a			;1aa1
	sbc hl,de		;1aa2
	inc hl			;1aa4
	push hl			;1aa5
	call _alloc		;1aa6
	pop bc			;1aa9
	push hl			;1aaa
	push ix			;1aab
	pop de			;1aad
	ld l,(ix-032h)		;1aae
	ld h,(ix-031h)		;1ab1
	inc hl			;1ab4
	ld (ix-032h),l		;1ab5
	ld (ix-031h),h		;1ab8
	dec hl			;1abb
	add hl,hl		;1abc
	add hl,de		;1abd
	ld de,0fe38h		;1abe
	add hl,de		;1ac1
	pop de			;1ac2
	ld (hl),e		;1ac3
	inc hl			;1ac4
	ld (hl),d		;1ac5
	push de			;1ac6
	call strcpy		;1ac7
	pop bc			;1aca
	ld hl,00012h		;1acb
	ex (sp),hl		;1ace
	call bdos		;1acf
	pop bc			;1ad2
	ld h,000h		;1ad3
	ld (ix-038h),l		;1ad5
	ld (ix-037h),h		;1ad8
	ld de,000ffh		;1adb
	or a			;1ade
	sbc hl,de		;1adf
	jp nz,l19a0h		;1ae1
	jr l1b07h		;1ae4
l1ae6h:
	ld a,(ix-033h)		;1ae6
	ld l,a			;1ae9
	rla			;1aea
	sbc a,a			;1aeb
	ld h,a			;1aec
	push hl			;1aed
	call _setuid		;1aee
	ld hl,00000h		;1af1
	ex (sp),hl		;1af4
	ld hl,l4498h		;1af5	": no match"
	push hl			;1af8
	push ix			;1af9
	pop de			;1afb
	ld hl,0fd54h		;1afc
	add hl,de		;1aff
	push hl			;1b00
	call _error		;1b01
	pop bc			;1b04
	pop bc			;1b05
	pop bc			;1b06
l1b07h:
	ld a,(ix-033h)		;1b07
	ld l,a			;1b0a
	rla			;1b0b
	sbc a,a			;1b0c
	ld h,a			;1b0d
	push hl			;1b0e
	call _setuid		;1b0f
	pop bc			;1b12
	jr l1b69h		;1b13
l1b15h:
	add hl,de		;1b15
	ex de,hl		;1b16
	push iy			;1b17
	pop hl			;1b19
	or a			;1b1a
	sbc hl,de		;1b1b
	inc hl			;1b1d
	push hl			;1b1e
	call _alloc		;1b1f
	pop bc			;1b22
	ex de,hl		;1b23
	push de			;1b24
	pop iy			;1b25
	push de			;1b27
	push ix			;1b28
	pop de			;1b2a
	ld l,(ix-032h)		;1b2b
	ld h,(ix-031h)		;1b2e
	inc hl			;1b31
	ld (ix-032h),l		;1b32
	ld (ix-031h),h		;1b35
	dec hl			;1b38
	add hl,hl		;1b39
	add hl,de		;1b3a
	ld de,0fe38h		;1b3b
	add hl,de		;1b3e
	pop de			;1b3f
	ld (hl),e		;1b40
	inc hl			;1b41
	ld (hl),d		;1b42
	push ix			;1b43
	pop de			;1b45
	ld hl,0fd54h		;1b46
	add hl,de		;1b49
	ld (ix-030h),l		;1b4a
	ld (ix-02fh),h		;1b4d
l1b50h:
	ld l,(ix-030h)		;1b50
	ld h,(ix-02fh)		;1b53
	ld a,(hl)		;1b56
	and 07fh		;1b57
	ld (iy+000h),a		;1b59
	inc iy			;1b5c
	ld a,(hl)		;1b5e
	inc hl			;1b5f
	ld (ix-030h),l		;1b60
	ld (ix-02fh),h		;1b63
	or a			;1b66
	jr nz,l1b50h		;1b67
l1b69h:
	ld hl,(0536bh)		;1b69
	ld a,(hl)		;1b6c
	or a			;1b6d
	jp nz,l17edh		;1b6e
l1b71h:
	ld hl,00000h		;1b71
	ld (ix-038h),l		;1b74
	ld (ix-037h),h		;1b77
	ld (ix-036h),l		;1b7a
	ld (ix-035h),h		;1b7d
	jp l1c9ch		;1b80
l1b83h:
	push ix			;1b83
	pop de			;1b85
	ld l,(ix-038h)		;1b86
	ld h,(ix-037h)		;1b89
	add hl,hl		;1b8c
	add hl,de		;1b8d
	ld de,0fe38h		;1b8e
	add hl,de		;1b91
	ld a,(hl)		;1b92
	inc hl			;1b93
	ld h,(hl)		;1b94
	ld l,a			;1b95
	ld a,(hl)		;1b96
	ld (ix-033h),a		;1b97
	ld l,a			;1b9a
	rla			;1b9b
	sbc a,a			;1b9c
	ld h,a			;1b9d
	push hl			;1b9e
	call sub_1eeah		;1b9f
	pop bc			;1ba2
	ld a,l			;1ba3
	or a			;1ba4
	jp z,l1c63h		;1ba5
	ld e,(ix-038h)		;1ba8
	ld d,(ix-037h)		;1bab
	ld l,(ix-032h)		;1bae
	ld h,(ix-031h)		;1bb1
	dec hl			;1bb4
	or a			;1bb5
	sbc hl,de		;1bb6
	jr nz,l1bdbh		;1bb8
	ld hl,00000h		;1bba
	push hl			;1bbd
	push ix			;1bbe
	pop de			;1bc0
	ld l,(ix-038h)		;1bc1
	ld h,(ix-037h)		;1bc4
	add hl,hl		;1bc7
	add hl,de		;1bc8
	ld de,0fe38h		;1bc9
	add hl,de		;1bcc
	ld c,(hl)		;1bcd
	inc hl			;1bce
	ld b,(hl)		;1bcf
	push bc			;1bd0
	ld hl,l44a3h		;1bd1	"no name after "
	push hl			;1bd4
	call _error		;1bd5
	pop bc			;1bd8
	pop bc			;1bd9
	pop bc			;1bda
l1bdbh:
	ld a,(ix-033h)		;1bdb
	cp 03ch			;1bde
	jr nz,l1c0bh		;1be0
	ld hl,__iob		;1be2
	push hl			;1be5
	ld hl,l44b8h		;1be6	"r"
	push hl			;1be9
	push ix			;1bea
	pop de			;1bec
	ld l,(ix-038h)		;1bed
	ld h,(ix-037h)		;1bf0
	inc hl			;1bf3
	add hl,hl		;1bf4
	add hl,de		;1bf5
	ld de,0fe38h		;1bf6
	add hl,de		;1bf9
	ld c,(hl)		;1bfa
	inc hl			;1bfb
	ld b,(hl)		;1bfc
	push bc			;1bfd
	ld hl,l44b2h		;1bfe	"input"
	push hl			;1c01
	call _redirect		;1c02
	pop bc			;1c05
	pop bc			;1c06
	pop bc			;1c07
	pop bc			;1c08
	jr l1c54h		;1c09
l1c0bh:
	push ix			;1c0b
	pop de			;1c0d
	ld l,(ix-038h)		;1c0e
	ld h,(ix-037h)		;1c11
	add hl,hl		;1c14
	add hl,de		;1c15
	ld de,0fe38h		;1c16
	add hl,de		;1c19
	ld a,(hl)		;1c1a
	inc hl			;1c1b
	ld h,(hl)		;1c1c
	ld l,a			;1c1d
	inc hl			;1c1e
	ld a,(hl)		;1c1f
	cp 03eh			;1c20
	jr z,l1c29h		;1c22
	ld hl,l44bch		;1c24	"w"
	jr l1c2ch		;1c27
l1c29h:
	ld hl,l44bah		;1c29	"a"
l1c2ch:
	push hl			;1c2c
	pop iy			;1c2d
	ld hl,__iob8		;1c2f
	push hl			;1c32
	push iy			;1c33
	push ix			;1c35
	pop de			;1c37
	ld l,(ix-038h)		;1c38
	ld h,(ix-037h)		;1c3b
	inc hl			;1c3e
	add hl,hl		;1c3f
	add hl,de		;1c40
	ld de,0fe38h		;1c41
	add hl,de		;1c44
	ld c,(hl)		;1c45
	inc hl			;1c46
	ld b,(hl)		;1c47
	push bc			;1c48
	ld hl,l44beh		;1c49	"output"
	push hl			;1c4c
	call _redirect		;1c4d
	pop bc			;1c50
	pop bc			;1c51
	pop bc			;1c52
	pop bc			;1c53
l1c54h:
	ld l,(ix-038h)		;1c54
	ld h,(ix-037h)		;1c57
	inc hl			;1c5a
	ld (ix-038h),l		;1c5b
	ld (ix-037h),h		;1c5e
	jr l1c8fh		;1c61
l1c63h:
	push ix			;1c63
	pop de			;1c65
	ld l,(ix-038h)		;1c66
	ld h,(ix-037h)		;1c69
	add hl,hl		;1c6c
	add hl,de		;1c6d
	ld de,0fe38h		;1c6e
	add hl,de		;1c71
	ld c,(hl)		;1c72
	inc hl			;1c73
	ld b,(hl)		;1c74
	push ix			;1c75
	pop de			;1c77
	ld l,(ix-036h)		;1c78
	ld h,(ix-035h)		;1c7b
	inc hl			;1c7e
	ld (ix-036h),l		;1c7f
	ld (ix-035h),h		;1c82
	dec hl			;1c85
	add hl,hl		;1c86
	add hl,de		;1c87
	ld de,0fe38h		;1c88
	add hl,de		;1c8b
	ld (hl),c		;1c8c
	inc hl			;1c8d
	ld (hl),b		;1c8e
l1c8fh:
	ld l,(ix-038h)		;1c8f
	ld h,(ix-037h)		;1c92
	inc hl			;1c95
	ld (ix-038h),l		;1c96
	ld (ix-037h),h		;1c99
l1c9ch:
	ld e,(ix-032h)		;1c9c
	ld d,(ix-031h)		;1c9f
	ld l,(ix-038h)		;1ca2
	ld h,(ix-037h)		;1ca5
	call wrelop		;1ca8
	jp c,l1b83h		;1cab
	ld l,(ix-036h)		;1cae
	ld h,(ix-035h)		;1cb1
	ld (__argc_),hl		;1cb4
	push ix			;1cb7
	pop de			;1cb9
	ld l,(ix-036h)		;1cba
	ld h,(ix-035h)		;1cbd
	inc hl			;1cc0
	ld (ix-036h),l		;1cc1
	ld (ix-035h),h		;1cc4
	dec hl			;1cc7
	add hl,hl		;1cc8
	add hl,de		;1cc9
	ld de,0fe38h		;1cca
	add hl,de		;1ccd
	ld de,00000h		;1cce
	ld (hl),e		;1cd1
	inc hl			;1cd2
	ld (hl),d		;1cd3
	ld l,(ix-036h)		;1cd4
	ld h,(ix-035h)		;1cd7
	add hl,hl		;1cda
	push hl			;1cdb
	call _alloc		;1cdc
	ld (ix-002h),l		;1cdf
	ld (ix-001h),h		;1ce2
	ld l,(ix-036h)		;1ce5
	ld h,(ix-035h)		;1ce8
	add hl,hl		;1ceb
	ex (sp),hl		;1cec
	ld l,(ix-002h)		;1ced
	ld h,(ix-001h)		;1cf0
	push hl			;1cf3
	push ix			;1cf4
	pop de			;1cf6
	ld hl,0fe38h		;1cf7
	add hl,de		;1cfa
	push hl			;1cfb
	call movmem		;1cfc
	pop bc			;1cff
	pop bc			;1d00
	pop bc			;1d01
	ld l,(ix-002h)		;1d02
	ld h,(ix-001h)		;1d05
	jp cret			;1d08


; =============== F U N C T I O N ===========================================
;
;
_nxtch:
	call csv		;1d0b		;
	ld a,(0536dh)		;1d0e
	or a			;1d11
	ld hl,(0536bh)		;1d12
	ld a,(hl)		;1d15
	jr z,l1d6bh		;1d16
	cp 05ch			;1d18
	jr nz,l1d67h		;1d1a
	ld iy,(0536bh)		;1d1c
	ld a,(iy+001h)		;1d20
	or a			;1d23
	jr nz,l1d67h		;1d24
	ld hl,(05373h)		;1d26
	ld a,l			;1d29
	or h			;1d2a
	jr nz,l1d38h		;1d2b

	ld hl,l0100h		;1d2d
	push hl			;1d30
	call _alloc		;1d31
	pop bc			;1d34
	ld (05373h),hl		;1d35
l1d38h:
	ld hl,l451ah		;1d38
	ld l,(hl)		;1d3b
	ld h,000h		;1d3c
	push hl			;1d3e
	call _isatty		;1d3f
	pop bc			;1d42
	ld a,l			;1d43
	or h			;1d44
	jr z,l1d59h		;1d45

	ld hl,(0536eh)		;1d47
	push hl			;1d4a
	ld hl,l44c5h		;1d4b	"%s> "
	push hl			;1d4e
	ld hl,__iob16		;1d4f
	push hl			;1d52
	call _fprintf		;1d53
	pop bc			;1d56
	pop bc			;1d57
	pop bc			;1d58
l1d59h:
	ld hl,(05373h)		;1d59
	push hl			;1d5c
	call _gets		;1d5d
	pop bc			;1d60
	ld hl,(05373h)		;1d61
	ld (0536bh),hl		;1d64
l1d67h:
	ld hl,(0536bh)		;1d67
	ld a,(hl)		;1d6a
l1d6bh:
	or a			;1d6b
	jr z,l1d7ah		;1d6c
	ld hl,(0536bh)		;1d6e
	inc hl			;1d71
	ld (0536bh),hl		;1d72
	dec hl			;1d75
	ld l,(hl)		;1d76
	jp cret			;1d77
l1d7ah:
	ld l,000h		;1d7a
	jp cret			;1d7c



; =============== F U N C T I O N ===========================================
;							;
;
_error:
	call csv		;1d7f
	push hl			;1d82
	push ix			;1d83
	pop de			;1d85
	ld hl,00006h		;1d86
	add hl,de		;1d89
	ld (ix-002h),l		;1d8a
	ld (ix-001h),h		;1d8d
	jr l1da7h		;1d90
l1d92h:
	ld l,(ix-002h)		;1d92
	ld h,(ix-001h)		;1d95
	ld c,(hl)		;1d98
	inc hl			;1d99
	ld b,(hl)		;1d9a
	inc hl			;1d9b
	ld (ix-002h),l		;1d9c
	ld (ix-001h),h		;1d9f
	push bc			;1da2
	call _sputs		;1da3
	pop bc			;1da6
l1da7h:
	ld l,(ix-002h)		;1da7
	ld h,(ix-001h)		;1daa
	ld a,(hl)		;1dad
	inc hl			;1dae
	or (hl)			;1daf
	jr nz,l1d92h		;1db0
	ld hl,l44cah		;1db2	"\n"
	push hl			;1db5
	call _sputs		;1db6
	ld hl,0ffffh		;1db9
	ex (sp),hl		;1dbc
	call exit		;1dbd
	jp cret			;1dc0

; =============== F U N C T I O N =======================================
;
;	sputs		From libary
;
_sputs:						; void sputs(register char * st) {
	call csv		;1dc3
	ld l,(ix+006h)		;1dc6
	ld h,(ix+007h)		;1dc9
	push hl			;1dcc
	pop iy			;1dcd
	jr l1df8h		;1dcf		; while(*st != 0) {
l1dd1h:						; m1:
	ld a,(iy+000h)		;1dd1
	cp 00ah			;1dd4
	jr nz,l1de5h		;1dd6		;     if(*st == '\n') bdos(2, '\r');
	ld hl,0000dh		;1dd8
	push hl			;1ddb
	ld hl,00002h		;1ddc
	push hl			;1ddf
	call bdos		;1de0	  
	pop bc			;1de3
	pop bc			;1de4
l1de5h:						; m2:
	ld a,(iy+000h)		;1de5
	inc iy			;1de8
	ld l,a			;1dea
	rla			;1deb
	sbc a,a			;1dec
	ld h,a			;1ded
	push hl			;1dee
	ld hl,00002h		;1def
	push hl			;1df2
	call bdos		;1df3		;      bdos(2, *(st++));
	pop bc			;1df6		; }
	pop bc			;1df7
l1df8h:	; m3:
	ld a,(iy+000h)		;1df8
	or a			;1dfb
	jr nz,l1dd1h		;1dfc
	jp cret			;1dfe

; =============== F U N C T I O N =======================================
;
; 	alloc	from library
;
_alloc:					  	; char * alloc(n) short n; {
	call csv		;1e01	  	;      char *	bp;
	push hl			;1e04
	ld l,(ix+006h)		;1e05
	ld h,(ix+007h)		;1e08
	push hl			;1e0b
	call sbrk		;1e0c
	pop bc			;1e0f
	ld (ix-002h),l		;1e10
	ld (ix-001h),h		;1e13
	ld de,0ffffh		;1e16
	or a			;1e19
	sbc hl,de		;1e1a
	jr nz,l1e2bh		;1e1c	  	;     if((bp = sbrk(n)) == (char *)-1)
	ld hl,00000h		;1e1e
	push hl			;1e21
	ld hl,l44cch		;1e22	
	push hl			;1e25
	call _error		;1e26	  	;         error("no room for arguments", 0);
	pop bc			;1e29
	pop bc			;1e2a
l1e2bh:		;
	ld l,(ix-002h)		;1e2b
	ld h,(ix-001h)		;1e2e	  	;     return bp;
	jp cret			;1e31		; }


; =============== F U N C T I O N =======================================
;
;	redirect	from library
						; static void redirect(str_name, file_name, mode, stream)
						; char *	str_name, * file_name, * mode; FILE *	stream; {
_redirect:
	call csv		;1e34
	ld de,__iob		;1e37
	ld l,(ix+00ch)		;1e3a
	ld h,(ix+00dh) ;p4 	;1e3d
	or a			;1e40
	sbc hl,de		;1e41
	ld de,00008h		;1e43
	call adiv		;1e46
	ld de,05370h  ;_redone	;1e49
	add hl,de		;1e4c
	ld a,(hl)		;1e4d
	inc (hl)		;1e4e
	or a			;1e4f
	jr z,l1e6ch		;1e50

	ld hl,00000h		;1e52		;
	push hl			;1e55		;
	ld hl,l44edh		;1e56		;
	push hl			;1e59		;
	ld l,(ix+006h)	;p1 	;1e5a		;
	ld h,(ix+007h)		;1e5d		;
	push hl			;1e60		;
	ld hl,l44e2h		;1e61		;
	push hl			;1e64		;
	call _error		;1e65		; error("Ambiguous ", p1, " redirection", 0);
	pop bc			;1e68		;
	pop bc			;1e69		;
	pop bc			;1e6a		;
	pop bc			;1e6b		;
l1e6ch:
	ld l,(ix+00ch)		;1e6c		;
	ld h,(ix+00dh) 	;p4 	;1e6f		;
	push hl			;1e72		;
	ld l,(ix+00ah)		;1e73		;
	ld h,(ix+00bh)	;p3	;1e76		;
	push hl			;1e79		;
	ld l,(ix+008h)		;1e7a		;
	ld h,(ix+009h)	;p2	;1e7d		;
	push hl			;1e80		;
	call _freopen		;1e81 		;
	pop bc			;1e84		;
	pop bc			;1e85		;
	pop bc			;1e86		;
	ld e,(ix+00ch)		;1e87		;
	ld d,(ix+00dh)	;p4	;1e8a		;
	or a			;1e8d		;
	sbc hl,de		;1e8e		;
	jp z,cret		;1e90		; if(freopen(p2, p3, p4) == p4) return;

	ld hl,00000h		;1e93		;
	push hl			;1e96		;
	ld l,(ix+006h)		;1e97		;
	ld h,(ix+007h)	;p1	;1e9a		;
	push hl			;1e9d		;
	ld hl,l4506h		;1e9e		;
	push hl			;1ea1		;
	ld l,(ix+008h)		;1ea2		;
	ld h,(ix+009h)	;p2	;1ea5		;
	push hl			;1ea8		;
	ld hl,l44fah		;1ea9		;
	push hl			;1eac		;
	call _error		;1ead		; error("Can't open ", p2, " for ", p1, 0);
	jp cret			;1eb0		; return;

;	End _redirect				; }

; =============== F U N C T I O N =======================================
;
;	Test wildcard characters ('*' '?')	from library
;
_iswild:					; int iswild(int par) {
sub_1eb3h:
	call csv		;1eb3
	ld hl,0002ah		;1eb6
	push hl			;1eb9
	ld l,(ix+006h)		;1eba
	ld h,(ix+007h)		;1ebd
	push hl			;1ec0
	call index		;1ec1
	pop bc			;1ec4
	pop bc			;1ec5
	ld a,l			;1ec6
	or h			;1ec7
	jr nz,l1edeh		;1ec8
	ld hl,0003fh		;1eca
	push hl			;1ecd
	ld l,(ix+006h)		;1ece
	ld h,(ix+007h)		;1ed1
	push hl			;1ed4
	call index		;1ed5
	pop bc			;1ed8
	pop bc			;1ed9
	ld a,l			;1eda
	or h			;1edb
	jr z,l1ee4h		;1edc
l1edeh:
	ld hl,00001h		;1ede
	jp cret			;1ee1
l1ee4h:
	ld hl,00000h		;1ee4
	jp cret			;1ee7


;	End _iswild

; =============== F U N C T I O N =======================================
;
;	Test ('<' '>')		from library
;
_isspecial:						; int isspecial(char par) {
sub_1eeah:
	call csv		;1eea
	ld a,(ix+006h)		;1eed
	cp 03ch			;1ef0
	jr z,l1ef8h		;1ef2
	cp 03eh			;1ef4
	jr nz,l1efeh		;1ef6
l1ef8h:
	ld hl,00001h		;1ef8
	jp cret			;1efb
l1efeh:
	ld hl,00000h		;1efe
	jp cret			;1f01


;	End _isspecial

; =============== F U N C T I O N =======================================
;
;	Test delimiter (' ', '\t' or '\n')	from library
;
_isseparator:						; int isseparator(char par) {
	call csv		;1f04
	ld a,(ix+006h)		;1f07
	cp 020h			;1f0a
	jr z,l1f16h		;1f0c
	cp 009h			;1f0e
	jr z,l1f16h		;1f10
	cp 00ah			;1f12
	jr nz,l1f1ch		;1f14
l1f16h:
	ld hl,00001h		;1f16
	jp cret			;1f19
l1f1ch:
	ld hl,00000h		;1f1c
	jp cret			;1f1f


; =============== F U N C T I O N =======================================
;
;	printf		from library
;
_printf:
	call csv		;1f22
	push ix			;1f25
	pop de			;1f27
	ld hl,00008h		;1f28
	add hl,de		;1f2b
	push hl			;1f2c
	ld l,(ix+006h)		;1f2d
	ld h,(ix+007h)		;1f30
	push hl			;1f33
	ld hl,__iob8		;1f34
	push hl			;1f37
	call __doprnt		;1f38
	pop bc			;1f3b
	pop bc			;1f3c
	pop bc			;1f3d
	jp cret			;1f3e


; =============== F U N C T I O N =======================================
;
;	fprintf		from library
;
_fprintf:
	call csv		;1f41
	push ix			;1f44
	pop de			;1f46
	ld hl,0000ah		;1f47
	add hl,de		;1f4a
	push hl			;1f4b
	ld l,(ix+008h)		;1f4c
	ld h,(ix+009h)		;1f4f
	push hl			;1f52
	ld l,(ix+006h)		;1f53
	ld h,(ix+007h)		;1f56
	push hl			;1f59
	call __doprnt		;1f5a
	pop bc			;1f5d
	pop bc			;1f5e
	pop bc			;1f5f
	jp cret			;1f60


; =============== F U N C T I O N =======================================
;
;	sprintf		From library
;
_sprintf:
	call csv		;1f63
	ld hl,07fffh		;1f66
	ld (05377h),hl		;1f69
	ld l,(ix+006h)		;1f6c
	ld h,(ix+007h)		;1f6f
	ld (05375h),hl		;1f72
	ld hl,0537bh		;1f75
	ld (hl),0c2h		;1f78
	push ix			;1f7a
	pop de			;1f7c
	ld hl,0000ah		;1f7d
	add hl,de		;1f80
	push hl			;1f81
	ld l,(ix+008h)		;1f82
	ld h,(ix+009h)		;1f85
	push hl			;1f88
	ld hl,05375h		;1f89
	push hl			;1f8c
	call __doprnt		;1f8d
	pop bc			;1f90
	pop bc			;1f91
	pop bc			;1f92
	ld hl,(05375h)		;1f93
	ld (hl),000h		;1f96
	ld e,(ix+006h)		;1f98
	ld d,(ix+007h)		;1f9b
	or a			;1f9e
	sbc hl,de		;1f9f
	jp cret	;1fa1


; =============== F U N C T I O N =======================================
;
;	pputc		From library
;
_pputc:
	call csv		;1fa4
	ld hl,(05380h)		;1fa7
	push hl			;1faa
	ld a,(ix+006h)		;1fab
	ld l,a			;1fae
	rla			;1faf
	sbc a,a			;1fb0
	ld h,a			;1fb1
	push hl			;1fb2
	call _fputc		;1fb3
	jp cret			;1fb6


; =============== F U N C T I O N =======================================
;
;	icvt		From library
;
_icvt:
	call csv		;1fb9
	ld l,(ix+006h)		;1fbc
	ld h,(ix+007h)		;1fbf
	push hl			;1fc2
	pop iy			;1fc3
	push hl			;1fc5
	call atoi		;1fc6
	pop bc			;1fc9
	ld a,l			;1fca
	ld (0537dh),a		;1fcb
	jr l1fd2h		;1fce
l1fd0h:
	inc iy			;1fd0
l1fd2h:
	ld e,(iy+000h)		;1fd2
	ld d,000h		;1fd5
	ld hl,l46b4h		;1fd7 __ctype_+1
	add hl,de		;1fda
	bit 2,(hl)		;1fdb isdigit()
	jr nz,l1fd0h		;1fdd
	push iy			;1fdf
	pop hl			;1fe1
	jp cret			;1fe2


; =============== F U N C T I O N =======================================
;
;	_doprnt		From library
;
__doprnt:
	call  ncsv	;-9	;1fe5
	defw  0fff7h		;1fe8
	rst 38h			;1fe9
	ld l,(ix+008h)		;1fea
	ld h,(ix+009h)		;1fed
	push hl			;1ff0
	pop iy			;1ff1
	ld l,(ix+006h)		;1ff3
	ld h,(ix+007h)		;1ff6
	ld (05380h),hl		;1ff9
	jp l2288h		;1ffc
l1fffh:
	ld a,(ix-001h)		;1fff
	cp 025h			;2002
	jr z,l2012h		;2004
	ld l,a			;2006
	rla			;2007
	sbc a,a			;2008
	ld h,a			;2009
	push hl			;200a
	call _pputc		;200b
	pop bc			;200e
	jp l2288h		;200f
l2012h:
	ld (ix-005h),00ah	;2012
	ld (ix-006h),000h	;2016
	ld (ix-008h),000h	;201a
	ld (ix-003h),000h	;201e
	ld (ix-009h),001h	;2022
	ld a,(iy+000h)		;2026
	cp 02dh			;2029
	jr nz,l2032h		;202b
	inc iy			;202d
	inc (ix-003h)		;202f
l2032h:
	ld a,(iy+000h)		;2032
	cp 030h			;2035
	ld hl,00001h		;2037
	jr z,l203dh		;203a
	dec hl			;203c
l203dh:
	ld (ix-002h),l		;203d
	ld e,(iy+000h)		;2040
	ld d,000h		;2043
	ld hl,l46b4h		;2045 __ctype_+1
	add hl,de		;2048
	bit 2,(hl)		;2049 isdigit()
	jr z,l205eh		;204b
	push iy			;204d
	call _icvt		;204f
	pop bc			;2052
	push hl			;2053
	pop iy			;2054
	ld a,(0537dh)		;2056
	ld (ix-006h),a		;2059
	jr l2079h		;205c
l205eh:
	ld a,(iy+000h)		;205e
	cp 02ah			;2061
	jr nz,l2079h		;2063
	ld l,(ix+00ah)		;2065
	ld h,(ix+00bh)		;2068
	ld a,(hl)		;206b
	inc hl			;206c
	inc hl			;206d
	ld (ix+00ah),l		;206e
	ld (ix+00bh),h		;2071
	ld (ix-006h),a		;2074
	inc iy			;2077
l2079h:
	ld a,(iy+000h)		;2079
	cp 02eh			;207c
	jr nz,l20b0h		;207e
	inc iy			;2080
	ld a,(iy+000h)		;2082
	cp 02ah			;2085
	jr nz,l209fh		;2087
	ld l,(ix+00ah)		;2089
	ld h,(ix+00bh)		;208c
	ld a,(hl)		;208f
	inc hl			;2090
	inc hl			;2091
	ld (ix+00ah),l		;2092
	ld (ix+00bh),h		;2095
	ld (ix-007h),a		;2098
	inc iy			;209b
	jr l20c3h		;209d
l209fh:
	push iy			;209f
	call _icvt		;20a1
	pop bc			;20a4
	push hl			;20a5
	pop iy			;20a6
	ld a,(0537dh)		;20a8
	ld (ix-007h),a		;20ab
	jr l20c3h		;20ae
l20b0h:
	ld a,(ix-002h)		;20b0
	or a			;20b3
	jr nz,l20bbh		;20b4
	ld hl,00000h		;20b6
	jr l20c0h		;20b9
l20bbh:
	ld l,(ix-006h)		;20bb
	ld h,000h		;20be
l20c0h:
	ld (ix-007h),l		;20c0
l20c3h:
	ld a,(iy+000h)		;20c3
	cp 06ch			;20c6
	jr nz,l20d0h		;20c8
	inc iy			;20ca
	ld (ix-009h),002h	;20cc
l20d0h:
	ld a,(iy+000h)		;20d0
	inc iy			;20d3
	ld (ix-001h),a		;20d5
	or a			;20d8
	jp z,cret		;20d9
	cp 044h			;20dc
	jp z,l215dh		;20de
	cp 04fh			;20e1
	jr z,l2107h		;20e3
	cp 058h			;20e5
	jp z,l2163h		;20e7
	cp 063h			;20ea
	jp z,l2214h		;20ec
	cp 064h			;20ef
	jr z,l215dh		;20f1
	cp 06fh			;20f3
	jr z,l2107h		;20f5
	cp 073h			;20f7
	jp z,l2169h		;20f9
	cp 075h			;20fc
	jr z,l210bh		;20fe
	cp 078h			;2100
	jr z,l2163h		;2102
	jp l2226h		;2104
l2107h:
	ld (ix-005h),008h	;2107
l210bh:
	ld a,(ix-003h)		;210b
	or a			;210e
	jr z,l211bh		;210f
	ld a,(ix-006h)		;2111
	ld (ix-003h),a		;2114
	ld (ix-006h),000h	;2117
l211bh:
	ld a,(ix-001h)		;211b
	ld e,a			;211e
	rla			;211f
	sbc a,a			;2120
	ld d,a			;2121
	ld hl,l46b4h		;2122 __ctype_+1
	add hl,de		;2125
	bit 0,(hl)		;2126 isupper()
	jr z,l212eh		;2128
	ld (ix-009h),002h	;212a
l212eh:
	ld hl,_pputc		;212e
	push hl			;2131
	ld l,(ix-005h)		;2132
	ld h,000h		;2135
	push hl			;2137
	ld l,(ix-008h)		;2138
	push hl			;213b
	ld l,(ix-006h)		;213c
	push hl			;213f
	ld l,(ix-007h)		;2140
	push hl			;2143
	ld a,(ix-009h)		;2144
	cp 001h			;2147
	jp z,l2234h		;2149
	ld l,(ix+00ah)		;214c
	ld h,(ix+00bh)		;214f
	ld e,(hl)		;2152
	inc hl			;2153
	ld d,(hl)		;2154
	inc hl			;2155
	ld a,(hl)		;2156
	inc hl			;2157
	ld h,(hl)		;2158
	ld l,a			;2159
	jp l224dh		;215a
l215dh:
	ld (ix-008h),001h	;215d
	jr l210bh		;2161
l2163h:
	ld (ix-005h),010h	;2163
	jr l210bh		;2167
l2169h:
	ld l,(ix+00ah)		;2169
	ld h,(ix+00bh)		;216c
	ld c,(hl)		;216f
	inc hl			;2170
	ld b,(hl)		;2171
	ld (0537eh),bc		;2172
	inc hl			;2176
	ld (ix+00ah),l		;2177
	ld (ix+00bh),h		;217a
	ld l,c			;217d
	ld h,b			;217e
	ld a,l			;217f
	or h			;2180
	jr nz,l2189h		;2181
	ld hl,l450ch		;2183	"(null)"
	ld (0537eh),hl		;2186
l2189h:
	ld hl,(0537eh)		;2189
	push hl			;218c
	call strlen		;218d
	pop bc			;2190
	ld (ix-004h),l		;2191
l2194h:
	ld a,(ix-007h)		;2194
	or a			;2197
	jr z,l21a8h		;2198
	ld b,(ix-004h)		;219a
	call brelop		;219d
	jr nc,l21a8h		;21a0
	ld a,(ix-007h)		;21a2
	ld (ix-004h),a		;21a5
l21a8h:
	ld b,(ix-006h)		;21a8
	ld a,(ix-004h)		;21ab
	call brelop		;21ae
	jr nc,l21beh		;21b1
	ld a,(ix-006h)		;21b3
	sub (ix-004h)		;21b6
	ld (ix-006h),a		;21b9
	jr l21c2h		;21bc
l21beh:
	ld (ix-006h),000h	;21be
l21c2h:
	ld a,(ix-003h)		;21c2
	or a			;21c5
	jr nz,l21eeh		;21c6
	jr l21d2h		;21c8
l21cah:
	ld hl,00020h		;21ca
	push hl			;21cd
	call _pputc		;21ce
	pop bc			;21d1
l21d2h:
	ld a,(ix-006h)		;21d2
	dec (ix-006h)		;21d5
	or a			;21d8
	jr nz,l21cah		;21d9
	jr l21eeh		;21db
l21ddh:
	ld hl,(0537eh)		;21dd
	ld a,(hl)		;21e0
	inc hl			;21e1
	ld (0537eh),hl		;21e2
	ld l,a			;21e5
	rla			;21e6
	sbc a,a			;21e7
	ld h,a			;21e8
	push hl			;21e9
	call _pputc		;21ea
	pop bc			;21ed
l21eeh:
	ld a,(ix-004h)		;21ee
	dec (ix-004h)		;21f1
	or a			;21f4
	jr nz,l21ddh		;21f5
	ld a,(ix-003h)		;21f7
	or a			;21fa
	jp z,l2288h		;21fb
	jr l2208h		;21fe
l2200h:
	ld hl,00020h		;2200
	push hl			;2203
	call _pputc		;2204
	pop bc			;2207
l2208h:
	ld a,(ix-006h)		;2208
	dec (ix-006h)		;220b
	or a			;220e
	jr nz,l2200h		;220f
	jp l2288h		;2211
l2214h:
	ld l,(ix+00ah)		;2214
	ld h,(ix+00bh)		;2217
	ld a,(hl)		;221a
	inc hl			;221b
	inc hl			;221c
	ld (ix+00ah),l		;221d
	ld (ix+00bh),h		;2220
	ld (ix-001h),a		;2223
l2226h:
	push ix			;2226
	pop hl			;2228
	dec hl			;2229
	ld (0537eh),hl		;222a
	ld (ix-004h),001h	;222d
	jp l2194h		;2231
l2234h:
	ld a,(ix-008h)		;2234
	or a			;2237
	ld l,(ix+00ah)		;2238
	ld h,(ix+00bh)		;223b
	ld e,(hl)		;223e
	inc hl			;223f
	ld d,(hl)		;2240
	jr nz,l2248h		;2241
	ld hl,00000h		;2243
	jr l224dh		;2246
l2248h:
	ld a,d			;2248
	rla			;2249
	sbc a,a			;224a
	ld l,a			;224b
	ld h,a			;224c
l224dh:
	push hl			;224d
	push de			;224e
	call __pnum		;224f
	exx			;2252
	ld hl,0000eh		;2253
	add hl,sp		;2256
	ld sp,hl		;2257
	exx			;2258
	ld (ix-006h),l		;2259
	ld l,(ix-009h)		;225c
	ld h,000h		;225f
	add hl,hl		;2261
	ex de,hl		;2262
	ld l,(ix+00ah)		;2263
	ld h,(ix+00bh)		;2266
	add hl,de		;2269
	ld (ix+00ah),l		;226a
	ld (ix+00bh),h		;226d
	jr l227ah		;2270
l2272h:
	ld hl,00020h		;2272
	push hl			;2275
	call _pputc		;2276
	pop bc			;2279
l227ah:
	ld b,(ix-003h)		;227a
	dec (ix-003h)		;227d
	ld a,(ix-006h)		;2280
	call brelop		;2283
	jr c,l2272h		;2286
l2288h:
	ld a,(iy+000h)		;2288
	inc iy			;228b
	ld (ix-001h),a		;228d
	or a			;2290
	jp nz,l1fffh		;2291
	jp cret			;2294

;	End _doprnt

; =============== F U N C T I O N =======================================
;	
;	fgets	From library
;
_fgets:
	call csv		;2297
	push hl			;229a
	push hl			;229b
	ld l,(ix+00ah)		;229c
	ld h,(ix+00bh)		;229f
	push hl			;22a2
	pop iy			;22a3
	ld l,(ix+006h)		;22a5
	ld h,(ix+007h)		;22a8
	ld (ix-002h),l		;22ab
	ld (ix-001h),h		;22ae
l22b1h:
	ld l,(ix+008h)		;22b1
	ld h,(ix+009h)		;22b4
	dec hl			;22b7
	ld (ix+008h),l		;22b8
	ld (ix+009h),h		;22bb
	inc hl			;22be
	ld a,l			;22bf
	or h			;22c0
	jr z,l22edh		;22c1
	push iy			;22c3
	call fgetc		;22c5
	pop bc			;22c8
	ld (ix-004h),l		;22c9
	ld (ix-003h),h		;22cc
	ld de,0ffffh		;22cf
	or a			;22d2
	sbc hl,de		;22d3
	jr z,l22edh		;22d5
	ld a,(ix-004h)		;22d7
	ld l,(ix+006h)		;22da
	ld h,(ix+007h)		;22dd
	inc hl			;22e0
	ld (ix+006h),l		;22e1
	ld (ix+007h),h		;22e4
	dec hl			;22e7
	ld (hl),a		;22e8
	cp 00ah			;22e9
	jr nz,l22b1h		;22eb
l22edh:
	ld l,(ix+006h)		;22ed
	ld h,(ix+007h)		;22f0
	ld (hl),000h		;22f3
	ld e,(ix-002h)		;22f5
	ld d,(ix-001h)		;22f8
	or a			;22fb
	sbc hl,de		;22fc
	jr nz,l2306h		;22fe
	ld hl,00000h		;2300
	jp cret			;2303
l2306h:
	ld l,(ix-002h)		;2306
	ld h,(ix-001h)		;2309
	jp cret			;230c


; =============== F U N C T I O N =======================================
;
;	gets	From library
;
_gets:
	call csv		;230f
	ld hl,__iob		;2312
	push hl			;2315
	ld hl,0ffffh		;2316
	push hl			;2319
	ld l,(ix+006h)		;231a
	ld h,(ix+007h)		;231d
	push hl			;2320
	call _fgets		;2321
	pop bc			;2324
	pop bc			;2325
	pop bc			;2326
	ld (ix+006h),l		;2327
	ld (ix+007h),h		;232a
	ld a,l			;232d
	or h			;232e
	jr nz,l2337h		;232f
	ld hl,00000h		;2331
	jp cret			;2334
l2337h:
	ld l,(ix+006h)		;2337
	ld h,(ix+007h)		;233a
	push hl			;233d
	call strlen		;233e
	pop bc			;2341
	ex de,hl		;2342
	ld hl,0ffffh		;2343
	add hl,de		;2346
	ld e,(ix+006h)		;2347
	ld d,(ix+007h)		;234a
	add hl,de		;234d
	ld (hl),000h		;234e
	ld l,e			;2350
	ld h,d			;2351
	jp cret			;2352


; =============== F U N C T I O N =======================================
;
;	sub_2355h	From library	ok++
;
sub_2355h:					; sub_2355h(char *p1, int p2, int p3, FILE * p4) {
	call csv		;2355		; int l1;
	push hl			;2358		; char * l2;
	push hl			;2359		; FILE * st;
	ld l,(ix+00ch)		;235a		;
	ld h,(ix+00dh)	;p4	;235d		;
	push hl			;2360		;
	pop iy			;2361		; st = p4;
	ld e,(ix+00ah)		;2363		;
	ld d,(ix+00bh)	;p3	;2366		;
	ld l,(ix+008h)		;2369		;
	ld h,(ix+009h)	;p2	;236c		;
	call lmul		;236f		;
	ld (ix-002h),l		;2372		;
	ld (ix-001h),h	;l1	;2375		; l1 = p2*p3;
	ld l,(ix+006h)		;2378		;
	ld h,(ix+007h)	;p1	;237b		;
	ld (ix-004h),l		;237e		;
	ld (ix-003h),h	;l2	;2381		; l2 = p1;
	jr l23b5h		;2384		; goto m2;
l2386h:						; m1:
	push iy		;\	;2386		;
	ld l,(ix-004h)		;2388		;
	ld h,(ix-003h)	;l2	;238b		;
	ld a,(hl)		;238e		;
	inc hl			;238f		;
	ld (ix-004h),l		;2390		;
	ld (ix-003h),h	;l2	;2393		; 
	ld l,a			;2396		;
	rla			;2397		;
	sbc a,a			;2398		;
	ld h,a			;2399		;
	push hl		;\	;239a		;
	call _fputc		;239b		;
	pop bc			;239e		;
	pop bc			;239f		;
	ld de,0ffffh		;23a0		;
	or a			;23a3		;
	sbc hl,de		;23a4		;
	jr z,l23bdh		;23a6		; if(fputc(*(l2++), st) == -1) goto m3;
	ld l,(ix-002h)		;23a8		;
	ld h,(ix-001h)	;l1	;23ab		;
	add hl,de		;23ae		;
	ld (ix-002h),l		;23af		;
	ld (ix-001h),h	;l1	;23b2		; l1 += -1;
l23b5h:						; m2:
	ld a,(ix-002h)		;23b5		;
	or (ix-001h)	;l1	;23b8		;
	jr nz,l2386h		;23bb		; if(l1 != 0) goto m1;
l23bdh:						; m3:
	ld e,(ix+008h)		;23bd		;
	ld d,(ix+009h)	;p2	;23c0		;
	ld l,(ix-002h)		;23c3		;
	ld h,(ix-001h)	;l1	;23c6		;
	add hl,de		;23c9		;
	ld de,0ffffh		;23ca		;
	add hl,de		;23cd		;
	ld e,(ix+008h)		;23ce		;
	ld d,(ix+009h)	;p2	;23d1		;
	call ldiv		;23d4		;
	ex de,hl		;23d7		;
	ld l,(ix+00ah)		;23d8		;
	ld h,(ix+00bh)	;p3	;23db		;
	or a			;23de		;
	sbc hl,de		;23df		; return p3-(l1+p2-1)/p2;
	jp cret			;23e1		;
;
	ld hl,__iob		;23e4		;
	push hl			;23e7		;
	call fgetc		;23e8		; fgetc(stdin);
	pop bc			;23eb		;
	ret			;23ec		; }


; =============== F U N C T I O N =======================================
;
;	putchar	From library
;
_putchar:
	call csv		;23ed
	ld hl,__iob8		;23f0
	push hl			;23f3
	ld l,(ix+006h)		;23f4
	ld h,(ix+007h)		;23f7
	push hl			;23fa
	call _fputc		;23fb
	pop bc			;23fe
	pop bc			;23ff
	jp cret			;2400


; =============== F U N C T I O N =======================================
;
;	fputc	From library
;
_fputc:
	pop de			;2403
	pop bc			;2404
	ld b,000h		;2405
	ex (sp),iy		;2407
	bit 1,(iy+006h)		;2409
	jr z,l2456h		;240d
	bit 7,(iy+006h)		;240f
	jr nz,l2429h		;2413
	ld a,c			;2415
	cp 00ah			;2416
	jr nz,l2429h		;2418
	push bc			;241a
	push de			;241b
	push iy			;241c
	ld hl,0000dh		;241e
	push hl			;2421
	call _fputc		;2422
	pop hl			;2425
	pop bc			;2426
	pop de			;2427
	pop bc			;2428
l2429h:
	ld l,(iy+002h)		;2429
	ld h,(iy+003h)		;242c
	ld a,l			;242f
	or h			;2430
	jr z,l244fh		;2431
	dec hl			;2433
	ld (iy+002h),l		;2434
	ld (iy+003h),h		;2437
	ld l,(iy+000h)		;243a
	ld h,(iy+001h)		;243d
	ld (hl),c		;2440
	inc hl			;2441
	ld (iy+000h),l		;2442
	ld (iy+001h),h		;2445
l2448h:
	ex (sp),iy		;2448
	push bc			;244a
	push de			;244b
	ld l,c			;244c
	ld h,b			;244d
	ret			;244e
l244fh:
	ex (sp),iy		;244f
	push bc			;2451
	push de			;2452
	jp __flsbuf		;2453
l2456h:
	ld bc,0ffffh		;2456
	jr l2448h		;2459


; =============== F U N C T I O N =======================================
;
;
__flsbuf:
	call csv		;245b
	ld l,(ix+008h)		;245e
	ld h,(ix+009h)		;2461
	push hl			;2464
	pop iy			;2465
	bit 1,(iy+006h)		;2467
	jp z,l24eeh		;246b
	ld a,(iy+004h)		;246e
	or (iy+005h)		;2471
	jr nz,l24b0h		;2474
	ld (iy+002h),000h	;2476
	ld (iy+003h),000h	;247a
	ld hl,00001h		;247e
	push hl			;2481
	push ix			;2482
	pop de			;2484
	ld hl,00006h		;2485
	add hl,de		;2488
	push hl			;2489
	ld l,(iy+007h)		;248a
	ld h,000h		;248d
	push hl			;248f
	call _write		;2490
	pop bc			;2493
	pop bc			;2494
	pop bc			;2495
	ld de,00001h		;2496
	or a			;2499
	sbc hl,de		;249a
	jr nz,l24a6h		;249c
l249eh:
	ld l,(ix+006h)		;249e
	ld h,000h		;24a1
	jp cret			;24a3
l24a6h:
	set 5,(iy+006h)		;24a6
l24aah:
	ld hl,0ffffh		;24aa
	jp cret			;24ad
l24b0h:
	ld hl,00200h		;24b0
	push hl			;24b3
	ld l,(iy+004h)		;24b4
	ld h,(iy+005h)		;24b7
	push hl			;24ba
	ld l,(iy+007h)		;24bb
	ld h,000h		;24be
	push hl			;24c0
	call _write		;24c1
	pop bc			;24c4
	pop bc			;24c5
	pop bc			;24c6
	ld de,00200h		;24c7
	or a			;24ca
	sbc hl,de		;24cb
	jr z,l24d3h		;24cd
	set 5,(iy+006h)		;24cf
l24d3h:
	ld (iy+002h),0ffh	;24d3
	ld (iy+003h),001h	;24d7
	ld a,(ix+006h)		;24db
	ld l,(iy+004h)		;24de
	ld h,(iy+005h)		;24e1
	ld (hl),a		;24e4
	inc hl			;24e5
	ld (iy+000h),l		;24e6
	ld (iy+001h),h		;24e9
	jr l24fah		;24ec
l24eeh:
	set 5,(iy+006h)		;24ee
	ld (iy+002h),000h	;24f2
	ld (iy+003h),000h	;24f6
l24fah:
	bit 5,(iy+006h)		;24fa
	jr z,l249eh		;24fe
	jr l24aah		;2500


; =============== F U N C T I O N =======================================
;
;	fopen from library
;
_fopen:
	call csv		;2502
	ld iy,__iob		;2505
	jr l2518h		;2509
l250bh:
	ld a,(iy+006h)		;250b
	and 003h		;250e
	or a			;2510
	jr z,l2523h		;2511
	ld de,00008h		;2513
	add iy,de		;2516
l2518h:
	ld de,__fcb		;2518
	push iy			;251b
	pop hl			;251d
	or a			;251e
	sbc hl,de		;251f
	jr nz,l250bh		;2521
l2523h:
	ld de,__fcb		;2523
	push iy			;2526
	pop hl			;2528
	or a			;2529
	sbc hl,de		;252a
	jr nz,l2534h		;252c
	ld hl,00000h		;252e
	jp cret			;2531
l2534h:
	push iy			;2534
	ld l,(ix+008h)		;2536
	ld h,(ix+009h)		;2539
	push hl			;253c
	ld l,(ix+006h)		;253d
	ld h,(ix+007h)		;2540
	push hl			;2543
	call _freopen		;2544
	pop bc			;2547
	pop bc			;2548
	pop bc			;2549
	jp cret			;254a


; =============== F U N C T I O N =======================================
;
;	freopen		from library
;
_freopen:
	call csv		;254d
	push hl			;2550
	ld l,(ix+00ah)		;2551
	ld h,(ix+00bh)		;2554
	push hl			;2557
	pop iy			;2558
	push hl			;255a
	call _fclose		;255b
	pop bc			;255e
	ld (ix-001h),000h	;255f
	ld a,(iy+006h)		;2563
	and 004h		;2566
	ld (iy+006h),a		;2568
	ld l,(ix+008h)		;256b
	ld h,(ix+009h)		;256e
	ld a,(hl)		;2571
	cp 061h			;2572
	jr z,l2581h		;2574
	cp 072h			;2576
	jr z,l2584h		;2578
	cp 077h			;257a
	jr nz,l2594h		;257c
	inc (ix-001h)		;257e
l2581h:
	inc (ix-001h)		;2581
l2584h:
	ld l,(ix+008h)		;2584
	ld h,(ix+009h)		;2587
	inc hl			;258a
	ld a,(hl)		;258b
	cp 062h			;258c
	jr nz,l2594h		;258e
	ld (iy+006h),080h	;2590
l2594h:
	ld a,(ix-001h)		;2594
	or a			;2597
	jr z,l25afh		;2598
	cp 001h			;259a
	jr z,l25c4h		;259c
	cp 002h			;259e
	jr z,l25dch		;25a0
l25a2h:
	ld a,(iy+007h)		;25a2
	or a			;25a5
	jp p,l25eeh		;25a6
l25a9h:
	ld hl,00000h		;25a9
	jp cret			;25ac
l25afh:
	ld hl,00000h		;25af
	push hl			;25b2
	ld l,(ix+006h)		;25b3
	ld h,(ix+007h)		;25b6
	push hl			;25b9
	call _open		;25ba
	pop bc			;25bd
	pop bc			;25be
l25bfh:
	ld (iy+007h),l		;25bf
	jr l25a2h		;25c2
l25c4h:
	ld hl,00001h		;25c4
	push hl			;25c7
	ld l,(ix+006h)		;25c8
	ld h,(ix+007h)		;25cb
	push hl			;25ce
	call _open		;25cf
	pop bc			;25d2
	pop bc			;25d3
	ld a,l			;25d4
	ld (iy+007h),a		;25d5
	or a			;25d8
	jp p,l25a2h		;25d9
l25dch:
	ld hl,l01b4h+2		;25dc
	push hl			;25df
	ld l,(ix+006h)		;25e0
	ld h,(ix+007h)		;25e3
	push hl			;25e6
	call _creat		;25e7
	pop bc			;25ea
	pop bc			;25eb
	jr l25bfh		;25ec
l25eeh:
	ld a,(iy+006h)		;25ee
	and 00ch		;25f1
	or a			;25f3
	jr nz,l25ffh		;25f4
	call __bufallo		;25f6
	ld (iy+004h),l		;25f9
	ld (iy+005h),h		;25fc
l25ffh:
	ld de,0ffffh		;25ff
	ld l,(iy+004h)		;2602
	ld h,(iy+005h)		;2605
	or a			;2608
	sbc hl,de		;2609
	jr nz,l2627h		;260b
	ld (iy+004h),000h	;260d
	ld (iy+005h),000h	;2611
	ld a,(iy+007h)		;2615
	ld l,a			;2618
	rla			;2619
	sbc a,a			;261a
	ld h,a			;261b
	push hl			;261c
	call _close		;261d
	pop bc			;2620
	ld (iy+006h),000h	;2621
	jr l25a9h		;2625
l2627h:
	ld l,(iy+004h)		;2627
	ld h,(iy+005h)		;262a
	ld (iy+000h),l		;262d
	ld (iy+001h),h		;2630
	ld (iy+002h),000h	;2633
	ld (iy+003h),000h	;2637
	ld a,(ix-001h)		;263b
	or a			;263e
	jr z,l2647h		;263f
	set 1,(iy+006h)		;2641
	jr l264bh		;2645
l2647h:
	set 0,(iy+006h)		;2647
l264bh:
	ld a,(iy+004h)		;264b
	or (iy+005h)		;264e
	ld a,(ix-001h)		;2651
	jr z,l2664h		;2654
	or a			;2656
	jr z,l2661h		;2657
	ld (iy+002h),000h	;2659
	ld (iy+003h),002h	;265d
l2661h:
	ld a,(ix-001h)		;2661
l2664h:
	cp 001h			;2664
	jr nz,l267ch		;2666
	ld hl,00002h		;2668
	push hl			;266b
	ld de,00000h		;266c
	ld l,e			;266f
	ld h,d			;2670
	push hl			;2671
	push de			;2672
	push iy			;2673
	call _fseek		;2675
	pop bc			;2678
	pop bc			;2679
	pop bc			;267a
	pop bc			;267b
l267ch:
	push iy			;267c
	pop hl			;267e
	jp cret			;267f


; =============== F U N C T I O N =======================================
;
;	_ssize	from library
;
__ssize:
	call ncsv		;2682
	ld a,b			;2685
	rst 38h			;2686
	ld l,(ix+006h)		;2687
	ld h,(ix+007h)		;268a
	push hl			;268d
	pop iy			;268e
	bit 7,(iy+006h)		;2690
	jr z,l26a3h		;2694
	ld l,(iy+007h)		;2696
	ld h,000h		;2699
	push hl			;269b
	call __fsize		;269c
	pop bc			;269f
	jp cret			;26a0
l26a3h:
	ld de,0002ah		;26a3
	ld l,(iy+007h)		;26a6
	ld h,000h		;26a9
	call lmul		;26ab
	ld de,__fcb		;26ae
	add hl,de		;26b1
	ld (ix-008h),l		;26b2
	ld (ix-007h),h		;26b5
	ld a,(iy+006h)		;26b8
	ld (ix-002h),a		;26bb
	bit 1,a			;26be
	jr z,l26c8h		;26c0
	push iy			;26c2
	call _fflush		;26c4
	pop bc			;26c7
l26c8h:
	ld e,(ix-008h)		;26c8
	ld d,(ix-007h)		;26cb
	ld hl,00028h		;26ce
	add hl,de		;26d1
	ld l,(hl)		;26d2
	ld (ix-001h),l		;26d3
	ld hl,00028h		;26d6
	add hl,de		;26d9
	ld (hl),001h		;26da
	set 0,(iy+006h)		;26dc
	ld a,(iy+006h)		;26e0
	and 0fdh		;26e3
	ld (iy+006h),a		;26e5
	ld hl,00002h		;26e8
	push hl			;26eb
	ld de,0ff80h		;26ec
	ld hl,0ffffh		;26ef
	push hl			;26f2
	push de			;26f3
	ld l,(iy+007h)		;26f4
	ld h,000h		;26f7
	push hl			;26f9
	call _lseek		;26fa
	pop bc			;26fd
	pop bc			;26fe
	pop bc			;26ff
	pop bc			;2700
	ld (iy+002h),000h	;2701
	ld (iy+003h),000h	;2705
	push iy			;2709
	ld hl,00080h		;270b
	push hl			;270e
	ld hl,00001h		;270f
	push hl			;2712
	push ix			;2713
	pop de			;2715
	ld hl,0ff78h		;2716
	add hl,de		;2719
	push hl			;271a
	call read1		;271b
	pop bc			;271e
	pop bc			;271f
	pop bc			;2720
	pop bc			;2721
	push iy			;2722
	call _ftell		;2724
	pop bc			;2727
	ld (ix-006h),e		;2728
	ld (ix-005h),d		;272b
	ld (ix-004h),l		;272e
	ld (ix-003h),h		;2731
	ld a,(ix-001h)		;2734
	ld e,(ix-008h)		;2737
	ld d,(ix-007h)		;273a
	ld hl,00028h		;273d
	add hl,de		;2740
	ld (hl),a		;2741
	ld a,(ix-002h)		;2742
	ld (iy+006h),a		;2745
	bit 1,(iy+006h)		;2748
	jr z,l2762h		;274c
	ld (iy+002h),000h	;274e
	ld (iy+003h),002h	;2752
	ld l,(iy+004h)		;2756
	ld h,(iy+005h)		;2759
	ld (iy+000h),l		;275c
	ld (iy+001h),h		;275f
l2762h:
	ld e,(ix-006h)		;2762
	ld d,(ix-005h)		;2765
	ld l,(ix-004h)		;2768
	ld h,(ix-003h)		;276b
	jp cret			;276e


; =============== F U N C T I O N =======================================
;
;	fseek	from library
;
_fseek:
	call csv		;2771
	push hl			;2774
	push hl			;2775
	ld l,(ix+006h)		;2776
	ld h,(ix+007h)		;2779
	push hl			;277c
	pop iy			;277d
	ld a,(iy+006h)		;277f
	and 0efh		;2782
	ld (iy+006h),a		;2784
	ld a,(iy+004h)		;2787
	or (iy+005h)		;278a
	jr nz,l27c3h		;278d
	ld de,0ffffh		;278f
	ld l,e			;2792
	ld h,d			;2793
	push hl			;2794
	push de			;2795
	ld l,(ix+00ch)		;2796
	ld h,(ix+00dh)		;2799
	push hl			;279c
	ld e,(ix+008h)		;279d
	ld d,(ix+009h)		;27a0
	ld l,(ix+00ah)		;27a3
	ld h,(ix+00bh)		;27a6
	push hl			;27a9
	push de			;27aa
	ld l,(iy+007h)		;27ab
	ld h,000h		;27ae
	push hl			;27b0
	call _lseek		;27b1
	pop bc			;27b4
	pop bc			;27b5
	pop bc			;27b6
	pop bc			;27b7
	call lrelop		;27b8
	jr nz,l2822h		;27bb
l27bdh:
	ld hl,0ffffh		;27bd
	jp cret			;27c0
l27c3h:
	bit 1,(iy+006h)		;27c3
	jr z,l27cfh		;27c7
	push iy			;27c9
	call _fflush		;27cb
	pop bc			;27ce
l27cfh:
	ld l,(ix+00ch)		;27cf
	ld h,(ix+00dh)		;27d2
	ld a,h			;27d5
	or a			;27d6
	jr nz,l27bdh		;27d7
	ld a,l			;27d9
	or a			;27da
	jr z,l27f9h		;27db
	cp 001h			;27dd
	jr z,l27e7h		;27df
	cp 002h			;27e1
	jr z,l2828h		;27e3
	jr l27bdh		;27e5
l27e7h:
	push iy			;27e7
	call _ftell		;27e9
	pop bc			;27ec
	push hl			;27ed
	push de			;27ee
	push ix			;27ef
	pop de			;27f1
	ld hl,00008h		;27f2
	add hl,de		;27f5
	call asaladd		;27f6
l27f9h:
	push iy			;27f9
	call _ftell		;27fb
	pop bc			;27fe
	push hl			;27ff
	push de			;2800
	ld e,(ix+008h)		;2801
	ld d,(ix+009h)		;2804
	ld l,(ix+00ah)		;2807
	ld h,(ix+00bh)		;280a
	call alsub		;280d
	ld (ix-004h),e		;2810
	ld (ix-003h),d		;2813
	ld (ix-002h),l		;2816
	ld (ix-001h),h		;2819
	ld a,e			;281c
	or d			;281d
	or l			;281e
	or h			;281f
	jr nz,l283ch		;2820
l2822h:
	ld hl,00000h		;2822
	jp cret			;2825
l2828h:
	push iy			;2828
	call __ssize		;282a
	pop bc			;282d
	push hl			;282e
	push de			;282f
	push ix			;2830
	pop de			;2832
	ld hl,00008h		;2833
	add hl,de		;2836
	call asaladd		;2837
	jr l27f9h		;283a
l283ch:
	bit 0,(iy+006h)		;283c
	jr z,l2893h		;2840
	bit 7,(ix-001h)		;2842
	jr nz,l288bh		;2846
	ld e,(ix-004h)		;2848
	ld d,(ix-003h)		;284b
	ld l,(ix-002h)		;284e
	ld h,(ix-001h)		;2851
	push hl			;2854
	push de			;2855
	ld e,(iy+002h)		;2856
	ld d,(iy+003h)		;2859
	ld a,d			;285c
	rla			;285d
	sbc a,a			;285e
	ld l,a			;285f
	ld h,a			;2860
	call lrelop		;2861
	jp m,l288bh		;2864
	ld e,(ix-004h)		;2867
	ld d,(ix-003h)		;286a
	ld l,(iy+002h)		;286d
	ld h,(iy+003h)		;2870
	or a			;2873
	sbc hl,de		;2874
	ld (iy+002h),l		;2876
	ld (iy+003h),h		;2879
	ld l,(iy+000h)		;287c
	ld h,(iy+001h)		;287f
	add hl,de		;2882
	ld (iy+000h),l		;2883
	ld (iy+001h),h		;2886
	jr l2822h		;2889
l288bh:
	ld (iy+002h),000h	;288b
	ld (iy+003h),000h	;288f
l2893h:
	ld de,0ffffh		;2893
	ld l,e			;2896
	ld h,d			;2897
	push hl			;2898
	push de			;2899
	ld hl,00000h		;289a
	push hl			;289d
	ld e,(ix+008h)		;289e
	ld d,(ix+009h)		;28a1
	ld l,(ix+00ah)		;28a4
	ld h,(ix+00bh)		;28a7
	push hl			;28aa
	push de			;28ab
	ld a,(iy+007h)		;28ac
	ld l,a			;28af
	rla			;28b0
	sbc a,a			;28b1
	ld h,a			;28b2
	push hl			;28b3
	call _lseek		;28b4
	pop bc			;28b7
	pop bc			;28b8
	pop bc			;28b9
	pop bc			;28ba
	call lrelop		;28bb
	jp nz,l2822h		;28be
	jp l27bdh		;28c1


; =============== F U N C T I O N =======================================
;
;	ftell	from library
;
_ftell:
	call csv		;28c4
	push hl			;28c7
	push hl			;28c8
	ld l,(ix+006h)		;28c9
	ld h,(ix+007h)		;28cc
	push hl			;28cf
	pop iy			;28d0
	ld hl,00001h		;28d2
	push hl			;28d5
	ld de,00000h		;28d6
	ld l,e			;28d9
	ld h,d			;28da
	push hl			;28db
	push de			;28dc
	ld a,(iy+007h)		;28dd
	ld l,a			;28e0
	rla			;28e1
	sbc a,a			;28e2
	ld h,a			;28e3
	push hl			;28e4
	call _lseek		;28e5
	pop bc			;28e8
	pop bc			;28e9
	pop bc			;28ea
	pop bc			;28eb
	ld (ix-004h),e		;28ec
	ld (ix-003h),d		;28ef
	ld (ix-002h),l		;28f2
	ld (ix-001h),h		;28f5
	bit 7,(iy+003h)		;28f8
	jr z,l2906h		;28fc
	ld (iy+002h),000h	;28fe
	ld (iy+003h),000h	;2902
l2906h:
	ld a,(iy+004h)		;2906
	or (iy+005h)		;2909
	jr z,l2926h		;290c
	bit 1,(iy+006h)		;290e
	jr z,l2926h		;2912
	ld de,00200h		;2914
	ld hl,00000h		;2917
	push hl			;291a
	push de			;291b
	push ix			;291c
	pop hl			;291e
	dec hl			;291f
	dec hl			;2920
	dec hl			;2921
	dec hl			;2922
	call asaladd		;2923
l2926h:
	ld e,(iy+002h)		;2926
	ld d,(iy+003h)		;2929
	ld a,d			;292c
	rla			;292d
	sbc a,a			;292e
	ld l,a			;292f
	ld h,a			;2930
	push hl			;2931
	push de			;2932
	ld e,(ix-004h)		;2933
	ld d,(ix-003h)		;2936
	ld l,(ix-002h)		;2939
	ld h,(ix-001h)		;293c
	call alsub		;293f
	jp cret			;2942

; =============== F U N C T I O N =======================================
;	From library?
;		read1
;
read1:
	call ncsv		;2945
	defw  0fffah		;2948
	ld l,(ix+0ch)		;294a
	ld h,(ix+0dh)		;294d
	push hl			;2950
	pop iy			;2951
	ld e,(ix+00ah)		;2953
	ld d,(ix+00bh)		;2956
	ld l,(ix+008h)		;2959
	ld h,(ix+009h)		;295c
	call lmul		;295f
	ld (ix-004h),l		;2962
	ld (ix-003h),h		;2965
	ld l,(ix+006h)		;2968
	ld h,(ix+007h)		;296b
	ld (ix-002h),l		;296e
	ld (ix-001h),h		;2971
	jr l29a9h		;2974
l2976h:				;
	push iy			;2976
	call fgetc		;2978
	pop bc			;297b
	ld (ix-006h),l		;297c
	ld (ix-005h),h		;297f
	ld de,0ffffh		;2982
	or a			;2985
	sbc hl,de		;2986
	jr z,l29b1h		;2988
	ld l,(ix-004h)		;298a
	ld h,(ix-003h)		;298d
	add hl,de		;2990
	ld (ix-004h),l		;2991
	ld (ix-003h),h		;2994
	ld a,(ix-006h)		;2997
	ld l,(ix-002h)		;299a
	ld h,(ix-001h)		;299d
	inc hl			;29a0
	ld (ix-002h),l		;29a1
	ld (ix-001h),h		;29a4
	dec hl			;29a7
	ld (hl),a		;29a8
l29a9h:				;
	ld a,(ix-004h)		;29a9
	or (ix-003h)		;29ac
	jr nz,l2976h		;29af
l29b1h:				;
	ld e,(ix+008h)		;29b1
	ld d,(ix+009h)		;29b4
	ld l,(ix-004h)		;29b7
	ld h,(ix-003h)		;29ba
	add hl,de		;29bd
	ld de,0ffffh		;29be
	add hl,de		;29c1
	ld e,(ix+008h)		;29c2
	ld d,(ix+009h)		;29c5
	call ldiv		;29c8
	ex de,hl		;29cb
	ld l,(ix+00ah)		;29cc
	ld h,(ix+00bh)		;29cf
	or a			;29d2
	sbc hl,de		;29d3
	jp cret			;29d5


; =============== F U N C T I O N =======================================
;
;	fgetc(f) From library
;
fgetc:
	pop de			;29d8
	ex (sp),iy		;29d9
	ld a,(iy+006h)		;29db
	bit 0,a			;29de
	jr z,l2a3ch		;29e0
	bit 4,a			;29e2
	jr nz,l2a3ch		;29e4
l29e6h:
	ld l,(iy+002h)		;29e6
	ld h,(iy+003h)		;29e9
	ld a,l			;29ec
	or h			;29ed
	jr z,l2a47h		;29ee
	dec hl			;29f0
	ld (iy+002h),l		;29f1
	ld (iy+003h),h		;29f4
	ld l,(iy+000h)		;29f7
	ld h,(iy+001h)		;29fa
	ld a,(hl)		;29fd
	inc hl			;29fe
	ld (iy+000h),l		;29ff
	ld (iy+001h),h		;2a02
l2a05h:
	bit 7,(iy+006h)		;2a05
	jr z,l2a12h		;2a09
l2a0bh:
	ld l,a			;2a0b
	ld h,000h		;2a0c
	ex (sp),iy		;2a0e
	push de			;2a10
	ret			;2a11
l2a12h:
	cp 00dh			;2a12
	jr z,l29e6h		;2a14
	cp 01ah			;2a16
	jr nz,l2a0bh		;2a18
	ld a,(iy+004h)		;2a1a
	or (iy+005h)		;2a1d
	jr z,l2a3ch		;2a20
	ld l,(iy+002h)		;2a22
	ld h,(iy+003h)		;2a25
	inc hl			;2a28
	ld (iy+002h),l		;2a29
	ld (iy+003h),h		;2a2c
	ld l,(iy+000h)		;2a2f
	ld h,(iy+001h)		;2a32
	dec hl			;2a35
	ld (iy+000h),l		;2a36
	ld (iy+001h),h		;2a39
l2a3ch:
	set 4,(iy+006h)		;2a3c
	ld hl,0ffffh		;2a40
	ex (sp),iy		;2a43
	push de			;2a45
	ret			;2a46
l2a47h:
	bit 6,(iy+006h)		;2a47
	jr nz,l2a3ch		;2a4b
	push de			;2a4d
	push iy			;2a4e
	call _filbuf		;2a50
	ld a,l			;2a53
	pop bc			;2a54
	pop de			;2a55
	bit 7,h			;2a56
	jr nz,l2a3ch		;2a58
	jr l2a05h		;2a5a


; =============== F U N C T I O N =======================================
;
;	_filbuf 	from library
;
_filbuf:
	call csv		;2a5c
	push hl			;2a5f
	ld l,(ix+006h)		;2a60
	ld h,(ix+007h)		;2a63
	push hl			;2a66
	pop iy			;2a67
	ld (iy+002h),000h	;2a69
	ld (iy+003h),000h	;2a6d
	bit 0,(iy+006h)		;2a71
	jr nz,l2a7dh		;2a75
l2a77h:
	ld hl,0ffffh		;2a77
	jp cret			;2a7a
l2a7dh:
	ld a,(iy+004h)		;2a7d
	or (iy+005h)		;2a80
	jr nz,l2ab2h		;2a83
	ld (iy+002h),000h	;2a85
	ld (iy+003h),000h	;2a89
	ld hl,00001h		;2a8d
	push hl			;2a90
	push ix			;2a91
	pop hl			;2a93
	dec hl			;2a94
	push hl			;2a95
	ld l,(iy+007h)		;2a96
	ld h,000h		;2a99
	push hl			;2a9b
	call _read		;2a9c
	pop bc			;2a9f
	pop bc			;2aa0
	pop bc			;2aa1
	ld de,00001h		;2aa2
	or a			;2aa5
	sbc hl,de		;2aa6
	jr nz,l2ae1h		;2aa8
	ld l,(ix-001h)		;2aaa
l2aadh:
	ld h,000h		;2aad
	jp cret			;2aaf
l2ab2h:
	ld hl,00200h		;2ab2
	push hl			;2ab5
	ld l,(iy+004h)		;2ab6
	ld h,(iy+005h)		;2ab9
	push hl			;2abc
	ld l,(iy+007h)		;2abd
	ld h,000h		;2ac0
	push hl			;2ac2
	call _read		;2ac3
	pop bc			;2ac6
	pop bc			;2ac7
	pop bc			;2ac8
	ex de,hl		;2ac9
	ld (iy+002h),e		;2aca
	ld (iy+003h),d		;2acd
	ld hl,00000h		;2ad0
	call wrelop		;2ad3
	jp m,l2aedh		;2ad6
	ld a,(iy+002h)		;2ad9
	or (iy+003h)		;2adc
	jr nz,l2ae7h		;2adf
l2ae1h:
	set 4,(iy+006h)		;2ae1
	jr l2a77h		;2ae5
l2ae7h:
	set 5,(iy+006h)		;2ae7
	jr l2a77h		;2aeb
l2aedh:
	ld l,(iy+004h)		;2aed
	ld h,(iy+005h)		;2af0
	ld (iy+000h),l		;2af3
	ld (iy+001h),h		;2af6
	ld l,(iy+002h)		;2af9
	ld h,(iy+003h)		;2afc
	dec hl			;2aff
	ld (iy+002h),l		;2b00
	ld (iy+003h),h		;2b03
	ld l,(iy+000h)		;2b06
	ld h,(iy+001h)		;2b09
	inc hl			;2b0c
	ld (iy+000h),l		;2b0d
	ld (iy+001h),h		;2b10
	dec hl			;2b13
	ld l,(hl)		;2b14
	jr l2aadh		;2b15


; =============== F U N C T I O N =======================================
;	From library?
;							; void sub_4576h() {
cpm_clean:
	call csv		;2b17
	push hl			;2b1a
	ld (ix-001h),008h	;2b1b
	ld iy,__iob		;2b1f
l2b23h:
	push iy			;2b23
	call _fclose		;2b25
	pop bc			;2b28
	ld de,00008h		;2b29
	add iy,de		;2b2c
	ld a,(ix-001h)		;2b2e
	add a,0ffh		;2b31
	ld (ix-001h),a		;2b33
	or a			;2b36
	jr nz,l2b23h		;2b37
	jp cret			;2b39


; =============== F U N C T I O N =======================================
;
;	fclose		From library
_fclose:
	call csv		;2b3c
	ld l,(ix+006h)		;2b3f
	ld h,(ix+007h)		;2b42
	push hl			;2b45
	pop iy			;2b46
	ld a,(iy+006h)		;2b48
	and 003h		;2b4b
	or a			;2b4d
	jr nz,l2b56h		;2b4e
l2b50h:
	ld hl,0ffffh		;2b50
	jp cret			;2b53
l2b56h:
	push iy			;2b56
	call _fflush		;2b58
	pop bc			;2b5b
	ld a,(iy+006h)		;2b5c
	and 0f8h		;2b5f
	ld (iy+006h),a		;2b61
	ld a,(iy+004h)		;2b64
	or (iy+005h)		;2b67
	jr z,l2b85h		;2b6a
	bit 3,(iy+006h)		;2b6c
	jr nz,l2b85h		;2b70
	ld l,(iy+004h)		;2b72
	ld h,(iy+005h)		;2b75
	push hl			;2b78
	call __buffree		;2b79
	pop bc			;2b7c
	ld (iy+004h),000h	;2b7d
	ld (iy+005h),000h	;2b81
l2b85h:
	ld l,(iy+007h)		;2b85
	ld h,000h		;2b88
	push hl			;2b8a
	call _close		;2b8b
	pop bc			;2b8e
	ld de,0ffffh		;2b8f
	or a			;2b92
	sbc hl,de		;2b93
	jr z,l2b50h		;2b95
	bit 5,(iy+006h)		;2b97
	jr nz,l2b50h		;2b9b
	ld hl,00000h		;2b9d
	jp cret			;2ba0


; =============== F U N C T I O N =======================================
;
;	fflush		From library
_fflush:
	call csv		;2ba3
	push hl			;2ba6
	ld l,(ix+006h)		;2ba7
	ld h,(ix+007h)		;2baa
	push hl			;2bad
	pop iy			;2bae
	bit 1,(iy+006h)		;2bb0
	jr z,l2bd4h		;2bb4
	ld a,(iy+004h)		;2bb6
	or (iy+005h)		;2bb9
	jr z,l2bd4h		;2bbc
	ld e,(iy+002h)		;2bbe
	ld d,(iy+003h)		;2bc1
	ld hl,00200h		;2bc4
	or a			;2bc7
	sbc hl,de		;2bc8
	ld (ix-002h),l		;2bca
	ld (ix-001h),h		;2bcd
	ld a,l			;2bd0
	or h			;2bd1
	jr nz,l2bdah		;2bd2
l2bd4h:
	ld hl,00000h		;2bd4
	jp cret			;2bd7
l2bdah:
	ld l,(ix-002h)		;2bda
	ld h,(ix-001h)		;2bdd
	push hl			;2be0
	ld l,(iy+004h)		;2be1
	ld h,(iy+005h)		;2be4
	push hl			;2be7
	ld l,(iy+007h)		;2be8
	ld h,000h		;2beb
	push hl			;2bed
	call _write		;2bee
	pop bc			;2bf1
	pop bc			;2bf2
	pop bc			;2bf3
	ld e,(ix-002h)		;2bf4
	ld d,(ix-001h)		;2bf7
	or a			;2bfa
	sbc hl,de		;2bfb
	jr z,l2c03h		;2bfd
	set 5,(iy+006h)		;2bff
l2c03h:
	ld (iy+002h),000h	;2c03
	ld (iy+003h),002h	;2c07
	ld l,(iy+004h)		;2c0b
	ld h,(iy+005h)		;2c0e
	ld (iy+000h),l		;2c11
	ld (iy+001h),h		;2c14
	bit 5,(iy+006h)		;2c17
	jr z,l2bd4h		;2c1b
	ld hl,0ffffh		;2c1d
	jp cret			;2c20


; =============== F U N C T I O N =======================================
;	From library?
;
__bufallo:
	call csv		;2c23
	ld iy,(05582h)		;2c26
	push iy			;2c2a
	pop hl			;2c2c
	ld a,l			;2c2d
	or h			;2c2e
	jr z,l2c3ch		;2c2f
	ld l,(iy+000h)		;2c31
	ld h,(iy+001h)		;2c34
	ld (05582h),hl		;2c37
	jr l2c47h		;2c3a
l2c3ch:
	ld hl,00200h		;2c3c
	push hl			;2c3f
	call sbrk		;2c40
	pop bc			;2c43
	push hl			;2c44
	pop iy			;2c45
l2c47h:
	push iy			;2c47
	pop hl			;2c49
	jp cret			;2c4a


; =============== F U N C T I O N =======================================
;	From library?
;
__buffree:
	call csv		;2c4d
	ld l,(ix+006h)		;2c50
	ld h,(ix+007h)		;2c53
	push hl			;2c56
	pop iy			;2c57
	ld hl,(05582h)		;2c59
	ld (iy+000h),l		;2c5c
	ld (iy+001h),h		;2c5f
	ld (05582h),iy		;2c62
	jp cret			;2c66


; =============== F U N C T I O N =======================================
;	From library?
;
exit:
	call csv		;2c69
	call cpm_clean		;2c6c
	ld l,(ix+006h)		;2c6f
	ld h,(ix+007h)		;2c72
	push hl			;2c75
	call __exit		;2c76
	jp cret			;2c79

; =============== F U N C T I O N =======================================
;	From library
;
startup:
	jp __getargs		;2c7c

; =============== F U N C T I O N =======================================
;	From library
;
_open:
	call csv		;2c7f
	push hl			;2c82
	ld e,(ix+008h)		;2c83
	ld d,(ix+009h)		;2c86
	inc de			;2c89
	ld (ix+008h),e		;2c8a
	ld (ix+009h),d		;2c8d
	ld hl,00003h		;2c90
	call wrelop		;2c93
	jp p,l2ca1h		;2c96
	ld (ix+008h),003h	;2c99
	ld (ix+009h),000h	;2c9d
l2ca1h:
	call _getfcb		;2ca1
	push hl			;2ca4
	pop iy			;2ca5
	ld a,l			;2ca7
	or h			;2ca8
	jr nz,l2cb1h		;2ca9
l2cabh:
	ld hl,0ffffh		;2cab
	jp cret			;2cae
l2cb1h:
	ld l,(ix+006h)		;2cb1
	ld h,(ix+007h)		;2cb4
	push hl			;2cb7
	push iy			;2cb8
	call _setfcb		;2cba
	pop bc			;2cbd
	pop bc			;2cbe
	ld a,l			;2cbf
	or a			;2cc0
	jr nz,l2d2bh		;2cc1
	ld de,00001h		;2cc3
	ld l,(ix+008h)		;2cc6
	ld h,(ix+009h)		;2cc9
	or a			;2ccc
	sbc hl,de		;2ccd
	jr nz,l2ceah		;2ccf
	ld hl,0000ch		;2cd1
	push hl			;2cd4
	call bdos		;2cd5
	pop bc			;2cd8
	ld a,l			;2cd9
	ld b,030h		;2cda
	call brelop		;2cdc
	jp m,l2ceah		;2cdf
	ld a,(iy+006h)		;2ce2
	or 080h			;2ce5
	ld (iy+006h),a		;2ce7
l2ceah:
	call _getuid		;2cea
	ld (ix-001h),l		;2ced
	ld l,(iy+029h)		;2cf0
	ld h,000h		;2cf3
	push hl			;2cf5
	call _setuid		;2cf6
	pop bc			;2cf9
	push iy			;2cfa
	ld hl,0000fh		;2cfc
	push hl			;2cff
	call bdos		;2d00
	pop bc			;2d03
	pop bc			;2d04
	ld a,l			;2d05
	cp 0ffh			;2d06
	jr nz,l2d1bh		;2d08
	push iy			;2d0a
	call _putfcb		;2d0c
	ld l,(ix-001h)		;2d0f
	ld h,000h		;2d12
	ex (sp),hl		;2d14
	call _setuid		;2d15
	pop bc			;2d18
	jr l2cabh		;2d19
l2d1bh:
	ld l,(ix-001h)		;2d1b
	ld h,000h		;2d1e
	push hl			;2d20
	call _setuid		;2d21
	pop bc			;2d24
	ld a,(ix+008h)		;2d25
	ld (iy+028h),a		;2d28
l2d2bh:
	ld de,__fcb		;2d2b
	push iy			;2d2e
	pop hl			;2d30
	or a			;2d31
	sbc hl,de		;2d32
	ld de,0002ah		;2d34
	call adiv		;2d37
	jp cret			;2d3a


; =============== F U N C T I O N =======================================
;	From library
;
_read:
	call ncsv		;2d3d
	ld a,c			;2d40
	rst 38h			;2d41
	ld (ix-005h),000h	;2d42
	ld (ix-004h),000h	;2d46
	ld b,008h		;2d4a
	ld a,(ix+006h)		;2d4c
	call brelop		;2d4f
	jr c,l2d5ah		;2d52
l2d54h:
	ld hl,0ffffh		;2d54
	jp cret			;2d57
l2d5ah:
	ld de,0002ah		;2d5a
	ld l,(ix+006h)		;2d5d
	ld h,000h		;2d60
	call lmul		;2d62
	ld de,__fcb		;2d65
	add hl,de		;2d68
	push hl			;2d69
	pop iy			;2d6a
	ld a,(iy+028h)		;2d6c
	cp 001h			;2d6f
	jp z,l2e75h		;2d71
	cp 003h			;2d74
	jp z,l2e75h		;2d76
	cp 004h			;2d79
	jr z,l2dd4h		;2d7b
	cp 005h			;2d7d
	jr nz,l2d54h		;2d7f
	ld l,(ix+00ah)		;2d81
	ld h,(ix+00bh)		;2d84
	ld (ix-005h),l		;2d87
	ld (ix-004h),h		;2d8a
l2d8dh:
	ld a,(ix+00ah)		;2d8d
	or (ix+00bh)		;2d90
	jr nz,l2da7h		;2d93
l2d95h:
	ld e,(ix+00ah)		;2d95
	ld d,(ix+00bh)		;2d98
	ld l,(ix-005h)		;2d9b
	ld h,(ix-004h)		;2d9e
	or a			;2da1
	sbc hl,de		;2da2
	jp cret			;2da4
l2da7h:
	ld l,(ix+00ah)		;2da7
	ld h,(ix+00bh)		;2daa
	dec hl			;2dad
	ld (ix+00ah),l		;2dae
	ld (ix+00bh),h		;2db1
	ld hl,00003h		;2db4
	push hl			;2db7
	call bdos		;2db8
	pop bc			;2dbb
	ld a,l			;2dbc
	and 07fh		;2dbd
	ld l,(ix+008h)		;2dbf
	ld h,(ix+009h)		;2dc2
	inc hl			;2dc5
	ld (ix+008h),l		;2dc6
	ld (ix+009h),h		;2dc9
	dec hl			;2dcc
	ld (hl),a		;2dcd
	cp 00ah			;2dce
	jr nz,l2d8dh		;2dd0
	jr l2d95h		;2dd2
l2dd4h:
	ld e,(ix+00ah)		;2dd4
	ld d,(ix+00bh)		;2dd7
	ld hl,00080h		;2dda
	call wrelop		;2ddd
	jr nc,l2deah		;2de0
	ld (ix+00ah),080h	;2de2
	ld (ix+00bh),000h	;2de6
l2deah:
	ld a,(ix+00ah)		;2dea
	push ix			;2ded
	pop de			;2def
	ld hl,0ff79h		;2df0
	add hl,de		;2df3
	ld (hl),a		;2df4
	push ix			;2df5
	pop de			;2df7
	ld hl,0ff79h		;2df8
	add hl,de		;2dfb
	push hl			;2dfc
	ld hl,0000ah		;2dfd
	push hl			;2e00
	call bdos		;2e01
	pop bc			;2e04
	pop bc			;2e05
	push ix			;2e06
	pop de			;2e08
	ld hl,0ff7ah		;2e09
	add hl,de		;2e0c
	ld l,(hl)		;2e0d
	ld h,000h		;2e0e
	ld (ix-005h),l		;2e10
	ld (ix-004h),h		;2e13
	ld e,(ix+00ah)		;2e16
	ld d,(ix+00bh)		;2e19
	ld h,(ix-004h)		;2e1c
	call wrelop		;2e1f
	jr nc,l2e50h		;2e22
	ld hl,0000ah		;2e24
	push hl			;2e27
	ld hl,00002h		;2e28
	push hl			;2e2b
	call bdos		;2e2c
	pop bc			;2e2f
	pop bc			;2e30
	push ix			;2e31
	pop de			;2e33
	ld l,(ix-005h)		;2e34
	ld h,(ix-004h)		;2e37
	inc hl			;2e3a
	inc hl			;2e3b
	add hl,de		;2e3c
	ld de,0ff79h		;2e3d
	add hl,de		;2e40
	ld (hl),00ah		;2e41
	ld l,(ix-005h)		;2e43
	ld h,(ix-004h)		;2e46
	inc hl			;2e49
	ld (ix-005h),l		;2e4a
	ld (ix-004h),h		;2e4d
l2e50h:
	ld l,(ix-005h)		;2e50
	ld h,(ix-004h)		;2e53
	push hl			;2e56
	ld l,(ix+008h)		;2e57
	ld h,(ix+009h)		;2e5a
	push hl			;2e5d
	push ix			;2e5e
	pop de			;2e60
	ld hl,0ff7bh		;2e61
	add hl,de		;2e64
	push hl			;2e65
	call movmem		;2e66
	pop bc			;2e69
	pop bc			;2e6a
	pop bc			;2e6b
	ld l,(ix-005h)		;2e6c
	ld h,(ix-004h)		;2e6f
	jp cret			;2e72
l2e75h:
	call _getuid		;2e75
	ld e,l			;2e78
	ld (ix-003h),e		;2e79
	ld l,(ix+00ah)		;2e7c
	ld h,(ix+00bh)		;2e7f
	ld (ix-005h),l		;2e82
	ld (ix-004h),h		;2e85
	jp l2f8fh		;2e88
l2e8bh:
	call __sigchk		;2e8b
	ld l,(iy+029h)		;2e8e
	ld h,000h		;2e91
	push hl			;2e93
	call _setuid		;2e94
	pop bc			;2e97
	ld a,(iy+024h)		;2e98
	and 07fh		;2e9b
	ld (ix-002h),a		;2e9d
	ld e,a			;2ea0
	ld d,000h		;2ea1
	ld hl,00080h		;2ea3
	or a			;2ea6
	sbc hl,de		;2ea7
	ld (ix-001h),l		;2ea9
	ld e,l			;2eac
	ld l,(ix+00ah)		;2ead
	ld h,(ix+00bh)		;2eb0
	call wrelop		;2eb3
	jr nc,l2ebeh		;2eb6
	ld a,(ix+00ah)		;2eb8
	ld (ix-001h),a		;2ebb
l2ebeh:
	ld de,00080h		;2ebe
	ld hl,00000h		;2ec1
	push hl			;2ec4
	push de			;2ec5
	ld e,(iy+024h)		;2ec6
	ld d,(iy+025h)		;2ec9
	ld l,(iy+026h)		;2ecc
	ld h,(iy+027h)		;2ecf
	call lldiv		;2ed2
	push hl			;2ed5
	push de			;2ed6
	push iy			;2ed7
	pop de			;2ed9
	ld hl,00021h		;2eda
	add hl,de		;2edd
	push hl			;2ede
	call __putrno		;2edf
	pop bc			;2ee2
	pop bc			;2ee3
	pop bc			;2ee4
	ld a,(ix-001h)		;2ee5
	cp 080h			;2ee8
	jr nz,l2f0eh		;2eea
	ld l,(ix+008h)		;2eec
	ld h,(ix+009h)		;2eef
	push hl			;2ef2
	ld hl,0001ah		;2ef3
	push hl			;2ef6
	call bdos		;2ef7
	pop bc			;2efa
	pop bc			;2efb
	push iy			;2efc
	ld hl,00021h		;2efe
	push hl			;2f01
	call bdos		;2f02
	pop bc			;2f05
	pop bc			;2f06
	ld a,l			;2f07
	or a			;2f08
	jr z,l2f4fh		;2f09
	jp l2f98h		;2f0b
l2f0eh:
	push ix			;2f0e
	pop de			;2f10
	ld hl,0ff79h		;2f11
	add hl,de		;2f14
	push hl			;2f15
	ld hl,0001ah		;2f16
	push hl			;2f19
	call bdos		;2f1a
	pop bc			;2f1d
	pop bc			;2f1e
	push iy			;2f1f
	ld hl,00021h		;2f21
	push hl			;2f24
	call bdos		;2f25
	pop bc			;2f28
	pop bc			;2f29
	ld a,l			;2f2a
	or a			;2f2b
	jr nz,l2f98h		;2f2c
	ld l,(ix-001h)		;2f2e
	ld h,000h		;2f31
	push hl			;2f33
	ld l,(ix+008h)		;2f34
	ld h,(ix+009h)		;2f37
	push hl			;2f3a
	push ix			;2f3b
	pop de			;2f3d
	ld l,(ix-002h)		;2f3e
	ld h,000h		;2f41
	add hl,de		;2f43
	ld de,0ff79h		;2f44
	add hl,de		;2f47
	push hl			;2f48
	call movmem		;2f49
	pop bc			;2f4c
	pop bc			;2f4d
	pop bc			;2f4e
l2f4fh:
	ld e,(ix-001h)		;2f4f
	ld d,000h		;2f52
	ld l,(ix+008h)		;2f54
	ld h,(ix+009h)		;2f57
	add hl,de		;2f5a
	ld (ix+008h),l		;2f5b
	ld (ix+009h),h		;2f5e
	ld a,e			;2f61
	ld hl,00000h		;2f62
	ld d,l			;2f65
	push hl			;2f66
	push de			;2f67
	push iy			;2f68
	pop de			;2f6a
	ld hl,00024h		;2f6b
	add hl,de		;2f6e
	call asaladd		;2f6f
	ld e,(ix-001h)		;2f72
	ld d,000h		;2f75
	ld l,(ix+00ah)		;2f77
	ld h,(ix+00bh)		;2f7a
	or a			;2f7d
	sbc hl,de		;2f7e
	ld (ix+00ah),l		;2f80
	ld (ix+00bh),h		;2f83
	ld l,(ix-003h)		;2f86
	ld h,d			;2f89
	push hl			;2f8a
	call _setuid		;2f8b
	pop bc			;2f8e
l2f8fh:
	ld a,(ix+00ah)		;2f8f
	or (ix+00bh)		;2f92
	jp nz,l2e8bh		;2f95
l2f98h:
	ld l,(ix-003h)		;2f98
	ld h,000h		;2f9b
	push hl			;2f9d
	call _setuid		;2f9e
	pop bc			;2fa1
	jp l2d95h		;2fa2


; =============== F U N C T I O N =======================================
;	From library
;
_write:
	call ncsv		;2fa5
	ld a,c			;2fa8
	rst 38h			;2fa9
	ld b,008h		;2faa
	ld a,(ix+006h)		;2fac
	call brelop		;2faf
	jr c,l2fbah		;2fb2
l2fb4h:
	ld hl,0ffffh		;2fb4
	jp cret			;2fb7
l2fbah:
	ld de,0002ah		;2fba
	ld l,(ix+006h)		;2fbd
	ld h,000h		;2fc0
	call lmul		;2fc2
	ld de,__fcb		;2fc5
	add hl,de		;2fc8
	push hl			;2fc9
	pop iy			;2fca
	ld (ix-002h),002h	;2fcc
	ld l,(ix+00ah)		;2fd0
	ld h,(ix+00bh)		;2fd3
	ld (ix-007h),l		;2fd6
	ld (ix-006h),h		;2fd9
	ld a,(iy+028h)		;2fdc
	cp 002h			;2fdf
	jp z,l3072h		;2fe1
	cp 003h			;2fe4
	jp z,l3072h		;2fe6
	cp 004h			;2fe9
	jr z,l305eh		;2feb
	cp 006h			;2fed
	jr z,l3016h		;2fef
	cp 007h			;2ff1
	jr z,l3031h		;2ff3
	jr l2fb4h		;2ff5
l2ff7h:
	call __sigchk		;2ff7
	ld l,(ix+008h)		;2ffa
	ld h,(ix+009h)		;2ffd
	ld a,(hl)		;3000
	inc hl			;3001
	ld (ix+008h),l		;3002
	ld (ix+009h),h		;3005
	ld l,a			;3008
	rla			;3009
	sbc a,a			;300a
	ld h,a			;300b
	push hl			;300c
	ld hl,00004h		;300d
	push hl			;3010
	call bdos		;3011
	pop bc			;3014
	pop bc			;3015
l3016h:
	ld l,(ix+00ah)		;3016
	ld h,(ix+00bh)		;3019
	dec hl			;301c
	ld (ix+00ah),l		;301d
	ld (ix+00bh),h		;3020
	inc hl			;3023
	ld a,l			;3024
	or h			;3025
	jr nz,l2ff7h		;3026
l3028h:
	ld l,(ix-007h)		;3028
	ld h,(ix-006h)		;302b
	jp cret			;302e
l3031h:
	ld (ix-002h),005h	;3031
	jr l305eh		;3035
l3037h:
	call __sigchk		;3037
	ld l,(ix+008h)		;303a
	ld h,(ix+009h)		;303d
	ld a,(hl)		;3040
	inc hl			;3041
	ld (ix+008h),l		;3042
	ld (ix+009h),h		;3045
	ld l,a			;3048
	rla			;3049
	sbc a,a			;304a
	ld h,a			;304b
	ld (ix-005h),l		;304c
	ld (ix-004h),h		;304f
	push hl			;3052
	ld l,(ix-002h)		;3053
	ld h,000h		;3056
	push hl			;3058
	call bdos		;3059
	pop bc			;305c
	pop bc			;305d
l305eh:
	ld l,(ix+00ah)		;305e
	ld h,(ix+00bh)		;3061
	dec hl			;3064
	ld (ix+00ah),l		;3065
	ld (ix+00bh),h		;3068
	inc hl			;306b
	ld a,l			;306c
	or h			;306d
	jr nz,l3037h		;306e
	jr l3028h		;3070
l3072h:
	call _getuid		;3072
	ld e,l			;3075
	ld (ix-003h),e		;3076
	jp l319ch		;3079
l307ch:
	call __sigchk		;307c
	ld l,(iy+029h)		;307f
	ld h,000h		;3082
	push hl			;3084
	call _setuid		;3085
	pop bc			;3088
	ld a,(iy+024h)		;3089
	and 07fh		;308c
	ld (ix-002h),a		;308e
	ld e,a			;3091
	ld d,000h		;3092
	ld hl,00080h		;3094
	or a			;3097
	sbc hl,de		;3098
	ld (ix-001h),l		;309a
	ld e,l			;309d
	ld l,(ix+00ah)		;309e
	ld h,(ix+00bh)		;30a1
	call wrelop		;30a4
	jr nc,l30afh		;30a7
	ld a,(ix+00ah)		;30a9
	ld (ix-001h),a		;30ac
l30afh:
	ld de,00080h		;30af
	ld hl,00000h		;30b2
	push hl			;30b5
	push de			;30b6
	ld e,(iy+024h)		;30b7
	ld d,(iy+025h)		;30ba
	ld l,(iy+026h)		;30bd
	ld h,(iy+027h)		;30c0
	call lldiv		;30c3
	push hl			;30c6
	push de			;30c7
	push iy			;30c8
	pop de			;30ca
	ld hl,00021h		;30cb
	add hl,de		;30ce
	push hl			;30cf
	call __putrno		;30d0
	pop bc			;30d3
	pop bc			;30d4
	pop bc			;30d5
	ld a,(ix-001h)		;30d6
	cp 080h			;30d9
	jr nz,l30efh		;30db
	ld l,(ix+008h)		;30dd
	ld h,(ix+009h)		;30e0
	push hl			;30e3
	ld hl,0001ah		;30e4
	push hl			;30e7
	call bdos		;30e8
	pop bc			;30eb
	pop bc			;30ec
	jr l314dh		;30ed
l30efh:
	push ix			;30ef
	pop de			;30f1
	ld hl,0ff79h		;30f2
	add hl,de		;30f5
	push hl			;30f6
	ld hl,0001ah		;30f7
	push hl			;30fa
	call bdos		;30fb
	pop bc			;30fe
	push ix			;30ff
	pop de			;3101
	ld hl,0ff79h		;3102
	add hl,de		;3105
	ld (hl),01ah		;3106
	ld hl,0007fh		;3108
	ex (sp),hl		;310b
	push ix			;310c
	pop de			;310e
	ld hl,0ff7ah		;310f
	add hl,de		;3112
	push hl			;3113
	push ix			;3114
	pop de			;3116
	ld hl,0ff79h		;3117
	add hl,de		;311a
	push hl			;311b
	call movmem		;311c
	pop bc			;311f
	pop bc			;3120
	pop bc			;3121
	push iy			;3122
	ld hl,00021h		;3124
	push hl			;3127
	call bdos		;3128
	pop bc			;312b
	ld l,(ix-001h)		;312c
	ld h,000h		;312f
	ex (sp),hl		;3131
	push ix			;3132
	pop de			;3134
	ld l,(ix-002h)		;3135
	ld h,000h		;3138
	add hl,de		;313a
	ld de,0ff79h		;313b
	add hl,de		;313e
	push hl			;313f
	ld l,(ix+008h)		;3140
	ld h,(ix+009h)		;3143
	push hl			;3146
	call movmem		;3147
	pop bc			;314a
	pop bc			;314b
	pop bc			;314c
l314dh:
	push iy			;314d
	ld hl,00022h		;314f
	push hl			;3152
	call bdos		;3153
	pop bc			;3156
	pop bc			;3157
	ld a,l			;3158
	or a			;3159
	jr nz,l31a5h		;315a
	ld e,(ix-001h)		;315c
	ld d,000h		;315f
	ld l,(ix+008h)		;3161
	ld h,(ix+009h)		;3164
	add hl,de		;3167
	ld (ix+008h),l		;3168
	ld (ix+009h),h		;316b
	ld a,e			;316e
	ld hl,00000h		;316f
	ld d,l			;3172
	push hl			;3173
	push de			;3174
	push iy			;3175
	pop de			;3177
	ld hl,00024h		;3178
	add hl,de		;317b
	call asaladd		;317c
	ld e,(ix-001h)		;317f
	ld d,000h		;3182
	ld l,(ix+00ah)		;3184
	ld h,(ix+00bh)		;3187
	or a			;318a
	sbc hl,de		;318b
	ld (ix+00ah),l		;318d
	ld (ix+00bh),h		;3190
	ld l,(ix-003h)		;3193
	ld h,d			;3196
	push hl			;3197
	call _setuid		;3198
	pop bc			;319b
l319ch:
	ld a,(ix+00ah)		;319c
	or (ix+00bh)		;319f
	jp nz,l307ch		;31a2
l31a5h:
	ld l,(ix-003h)		;31a5
	ld h,000h		;31a8
	push hl			;31aa
	call _setuid		;31ab
	pop bc			;31ae
	ld e,(ix+00ah)		;31af
	ld d,(ix+00bh)		;31b2
	ld l,(ix-007h)		;31b5
	ld h,(ix-006h)		;31b8
	or a			;31bb
	sbc hl,de		;31bc
	jp cret			;31be


; =============== F U N C T I O N =======================================
;	From library
;
__fsize:
	call ncsv		;31c1
	ei			;31c4
	rst 38h			;31c5
	ld b,008h		;31c6
	ld a,(ix+006h)		;31c8
	call brelop		;31cb
	jr c,l31d8h		;31ce
	ld de,0ffffh		;31d0
	ld l,e			;31d3
	ld h,d			;31d4
	jp cret			;31d5
l31d8h:
	ld de,0002ah		;31d8
	ld l,(ix+006h)		;31db
	ld h,000h		;31de
	call lmul		;31e0
	ld de,__fcb		;31e3
	add hl,de		;31e6
	push hl			;31e7
	pop iy			;31e8
	call _getuid		;31ea
	ld (ix-005h),l		;31ed
	ld l,(iy+029h)		;31f0
	ld h,000h		;31f3
	push hl			;31f5
	call _setuid		;31f6
	pop bc			;31f9
	push iy			;31fa
	ld hl,00023h		;31fc
	push hl			;31ff
	call bdos		;3200
	pop bc			;3203
	ld l,(ix-005h)		;3204
	ld h,000h		;3207
	ex (sp),hl		;3209
	call _setuid		;320a
	pop bc			;320d
	ld b,010h		;320e
	ld a,(iy+023h)		;3210
	ld hl,00000h		;3213
	ld d,l			;3216
	ld e,a			;3217
	call allsh		;3218
	push hl			;321b
	push de			;321c
	ld b,008h		;321d
	ld a,(iy+022h)		;321f
	ld hl,00000h		;3222
	ld d,l			;3225
	ld e,a			;3226
	call allsh		;3227
	push hl			;322a
	push de			;322b
	ld a,(iy+021h)		;322c
	ld hl,00000h		;322f
	ld d,l			;3232
	ld e,a			;3233
	call aladd		;3234
	call aladd		;3237
	ld (ix-004h),e		;323a
	ld (ix-003h),d		;323d
	ld (ix-002h),l		;3240
	ld (ix-001h),h		;3243
	ld b,007h		;3246
	push ix			;3248
	pop hl			;324a
	dec hl			;324b
	dec hl			;324c
	dec hl			;324d
	dec hl			;324e
	call asallsh		;324f
	ld e,(ix-004h)		;3252
	ld d,(ix-003h)		;3255
	ld l,(ix-002h)		;3258
	ld h,(ix-001h)		;325b
	push hl			;325e
	push de			;325f
	ld e,(iy+024h)		;3260
	ld d,(iy+025h)		;3263
	ld l,(iy+026h)		;3266
	ld h,(iy+027h)		;3269
	call lrelop		;326c
	jp p,l3281h		;326f
	ld e,(ix-004h)		;3272
	ld d,(ix-003h)		;3275
	ld l,(ix-002h)		;3278
	ld h,(ix-001h)		;327b
	jp cret			;327e
l3281h:
	ld e,(iy+024h)		;3281
	ld d,(iy+025h)		;3284
	ld l,(iy+026h)		;3287
	ld h,(iy+027h)		;328a
	jp cret			;328d


; =============== F U N C T I O N =======================================
;	From library
;
_lseek:
	call csv		;3290
	push hl			;3293
	push hl			;3294
	ld b,008h		;3295
	ld a,(ix+006h)		;3297
	call brelop		;329a
	jr c,l32a7h		;329d
l329fh:
	ld de,0ffffh		;329f
	ld l,e			;32a2
	ld h,d			;32a3
	jp cret			;32a4
l32a7h:
	ld de,0002ah		;32a7
	ld l,(ix+006h)		;32aa
	ld h,000h		;32ad
	call lmul		;32af
	ld de,__fcb		;32b2
	add hl,de		;32b5
	push hl			;32b6
	pop iy			;32b7
	ld a,(ix+00ch)		;32b9
	cp 001h			;32bc
	jr z,l3309h		;32be
	cp 002h			;32c0
	ld e,(ix+008h)		;32c2
	ld d,(ix+009h)		;32c5
	ld l,(ix+00ah)		;32c8
	ld h,(ix+00bh)		;32cb
	jr z,l3334h		;32ce
	ld (ix-004h),e		;32d0
	ld (ix-003h),d		;32d3
	ld (ix-002h),l		;32d6
	ld (ix-001h),h		;32d9
l32dch:
	bit 7,(ix-001h)		;32dc
	jr nz,l329fh		;32e0
	ld e,(ix-004h)		;32e2
	ld d,(ix-003h)		;32e5
	ld l,(ix-002h)		;32e8
	ld h,(ix-001h)		;32eb
	ld (iy+024h),e		;32ee
	ld (iy+025h),d		;32f1
	ld (iy+026h),l		;32f4
	ld (iy+027h),h		;32f7
	ld e,(iy+024h)		;32fa
	ld d,(iy+025h)		;32fd
	ld l,(iy+026h)		;3300
	ld h,(iy+027h)		;3303
	jp cret			;3306
l3309h:
	ld e,(ix+008h)		;3309
	ld d,(ix+009h)		;330c
	ld l,(ix+00ah)		;330f
	ld h,(ix+00bh)		;3312
	push hl			;3315
	push de			;3316
	ld e,(iy+024h)		;3317
	ld d,(iy+025h)		;331a
	ld l,(iy+026h)		;331d
	ld h,(iy+027h)		;3320
l3323h:
	call aladd		;3323
	ld (ix-004h),e		;3326
	ld (ix-003h),d		;3329
	ld (ix-002h),l		;332c
	ld (ix-001h),h		;332f
	jr l32dch		;3332
l3334h:
	push hl			;3334
	push de			;3335
	ld l,(ix+006h)		;3336
	ld h,000h		;3339
	push hl			;333b
	call __fsize		;333c
	pop bc			;333f
	jr l3323h		;3340


; =============== F U N C T I O N =======================================
;	From library
;
_creat:
	call csv		;3342
	push hl			;3345
	call _getfcb		;3346
	push hl			;3349
	pop iy			;334a
	ld a,l			;334c
	or h			;334d
	jr nz,l3356h		;334e
l3350h:
	ld hl,0ffffh		;3350
	jp cret			;3353
l3356h:
	call _getuid		;3356
	ld (ix-001h),l		;3359
	ld l,(ix+006h)		;335c
	ld h,(ix+007h)		;335f
	push hl			;3362
	push iy			;3363
	call _setfcb		;3365
	pop bc			;3368
	pop bc			;3369
	ld a,l			;336a
	or a			;336b
	jr nz,l33aah		;336c
	ld l,(ix+006h)		;336e
	ld h,(ix+007h)		;3371
	push hl			;3374
	call _unlink		;3375
	ld l,(iy+029h)		;3378
	ld h,000h		;337b
	ex (sp),hl		;337d
	call _setuid		;337e
	pop bc			;3381
	push iy			;3382
	ld hl,00016h		;3384
	push hl			;3387
	call bdos		;3388
	pop bc			;338b
	pop bc			;338c
	ld a,l			;338d
	cp 0ffh			;338e
	ld l,(ix-001h)		;3390
	ld h,000h		;3393
	push hl			;3395
	jr nz,l33a2h		;3396
	call _setuid		;3398
	pop bc			;339b
	ld (iy+028h),000h	;339c
	jr l3350h		;33a0
l33a2h:
	call _setuid		;33a2
	pop bc			;33a5
	ld (iy+028h),002h	;33a6
l33aah:
	ld de,__fcb		;33aa
	push iy			;33ad
	pop hl			;33af
	or a			;33b0
	sbc hl,de		;33b1
	ld de,0002ah		;33b3
	call adiv		;33b6
	jp cret			;33b9


; =============== F U N C T I O N =======================================
;	From library?
;
_isatty:
	call csv		;33bc
	ld de,0002ah		;33bf
	ld l,(ix+006h)		;33c2
	ld h,000h		;33c5
	call lmul		;33c7
	ld de,l457bh		;33ca
	add hl,de		;33cd
	ld a,(hl)		;33ce
	cp 004h			;33cf
	jr z,l33dfh		;33d1
	cp 005h			;33d3
	jr z,l33dfh		;33d5
	cp 006h			;33d7
	jr z,l33dfh		;33d9
	cp 007h			;33db
	jr nz,l33e5h		;33dd
l33dfh:
	ld hl,00001h		;33df
	jp cret			;33e2
l33e5h:
	ld hl,00000h		;33e5
	jp cret			;33e8


; =============== F U N C T I O N =======================================
;	From library?
;
__cpm_clean:
	call csv		;33eb
	push hl			;33ee
	ld (ix-001h),000h	;33ef
l33f3h:
	ld l,(ix-001h)		;33f3
	ld h,000h		;33f6
	push hl			;33f8
	call _close		;33f9
	pop bc			;33fc
	ld b,008h		;33fd
	inc (ix-001h)		;33ff
	ld a,(ix-001h)		;3402
	call brelop		;3405
	jr c,l33f3h		;3408
	jp cret			;340a


; =============== F U N C T I O N =======================================
;	From library?
;
__putrno:
	call csv		;340d
	ld a,(ix+008h)		;3410
	ld l,(ix+006h)		;3413
	ld h,(ix+007h)		;3416
	ld (hl),a		;3419
	ld b,008h		;341a
	ld e,a			;341c
	ld d,(ix+009h)		;341d
	ld l,(ix+00ah)		;3420
	ld h,(ix+00bh)		;3423
	call alrsh		;3426
	ld l,(ix+006h)		;3429
	ld h,(ix+007h)		;342c
	inc hl			;342f
	ld (hl),e		;3430
	ld b,010h		;3431
	ld e,(ix+008h)		;3433
	ld d,(ix+009h)		;3436
	ld l,(ix+00ah)		;3439
	ld h,(ix+00bh)		;343c
	call alrsh		;343f
	ld l,(ix+006h)		;3442
	ld h,(ix+007h)		;3445
	inc hl			;3448
	inc hl			;3449
	ld (hl),e		;344a
	jp cret			;344b


; =============== F U N C T I O N =======================================
;	From library?
;
_close:
	call csv		;344e
	push hl			;3451
	ld b,008h		;3452
	ld a,(ix+006h)		;3454
	call brelop		;3457
	jr c,l3462h		;345a
	ld hl,0ffffh		;345c
	jp cret			;345f
l3462h:
	ld de,0002ah		;3462
	ld l,(ix+006h)		;3465
	ld h,000h		;3468
	call lmul		;346a
	ld de,__fcb		;346d
	add hl,de		;3470
	push hl			;3471
	pop iy			;3472
	call _getuid		;3474
	ld (ix-001h),l		;3477
	ld l,(iy+029h)		;347a
	ld h,000h		;347d
	push hl			;347f
	call _setuid		;3480
	pop bc			;3483
	ld a,(iy+028h)		;3484
	cp 002h			;3487
	jr z,l34a8h		;3489
	cp 003h			;348b
	jr z,l34a8h		;348d
	ld hl,0000ch		;348f
	push hl			;3492
	call bdoshl		;3493
	pop bc			;3496
	xor a			;3497
	ld l,a			;3498
	ld a,h			;3499
	and 005h		;349a
	ld h,a			;349c
	ld a,l			;349d
	or h			;349e
	jr z,l34b3h		;349f
	ld a,(iy+028h)		;34a1
	cp 001h			;34a4
	jr nz,l34b3h		;34a6
l34a8h:
	push iy			;34a8
	ld hl,00010h		;34aa
	push hl			;34ad
	call bdos		;34ae
	pop bc			;34b1
	pop bc			;34b2
l34b3h:
	ld (iy+028h),000h	;34b3
	ld l,(ix-001h)		;34b7
	ld h,000h		;34ba
	push hl			;34bc
	call _setuid		;34bd
	pop bc			;34c0
	ld hl,00000h		;34c1
	jp cret			;34c4


; =============== F U N C T I O N =======================================
;	From library?
;
_unlink:
	call ncsv		;34c7
	out (0ffh),a		;34ca
	ld l,(ix+006h)		;34cc
	ld h,(ix+007h)		;34cf
	push hl			;34d2
	push ix			;34d3
	pop de			;34d5
	ld hl,0ffd6h		;34d6
	add hl,de		;34d9
	push hl			;34da
	call _setfcb		;34db
	pop bc			;34de
	pop bc			;34df
	ld a,l			;34e0
	or a			;34e1
	jr z,l34eah		;34e2
	ld hl,00000h		;34e4
	jp cret			;34e7
l34eah:
	call _getuid		;34ea
	ld (ix-02bh),l		;34ed
	ld l,(ix-001h)		;34f0
	ld h,000h		;34f3
	push hl			;34f5
	call _setuid		;34f6
	push ix			;34f9
	pop de			;34fb
	ld hl,0ffd6h		;34fc
	add hl,de		;34ff
	ex (sp),hl		;3500
	ld hl,00013h		;3501
	push hl			;3504
	call bdos		;3505
	pop bc			;3508
	ld a,l			;3509
	rla			;350a
	sbc a,a			;350b
	ld h,a			;350c
	ld (ix-02dh),l		;350d
	ld (ix-02ch),h		;3510
	ld l,(ix-02bh)		;3513
	ld h,000h		;3516
	ex (sp),hl		;3518
	call _setuid		;3519
	pop bc			;351c
	ld l,(ix-02dh)		;351d
	ld h,(ix-02ch)		;3520
	jp cret			;3523


; =============== F U N C T I O N =======================================
;	From library?
;
_upcase:
	call csv		;3526
	ld a,(ix+006h)		;3529
	ld e,a			;352c
	rla			;352d
	sbc a,a			;352e
	ld d,a			;352f
	ld hl,l46b4h		;3530 __ctype_+1
	add hl,de		;3533
	bit 1,(hl)		;3534
	jr z,l353fh		;3536
	ld a,e			;3538
	add a,0e0h		;3539
	ld l,a			;353b
	jp cret			;353c
l353fh:
	ld l,(ix+006h)		;353f
	jp cret			;3542


; =============== F U N C T I O N =======================================
;	From library?
;
_getfcb:
	call csv		;3545
	ld iy,__fcb		;3548
	jr l3573h		;354c
l354eh:
	ld a,(iy+028h)		;354e
	or a			;3551
	jr nz,l356eh		;3552
	ld (iy+028h),001h	;3554
	ld (iy+024h),000h	;3558
	ld (iy+025h),000h	;355c
	ld (iy+026h),000h	;3560
	ld (iy+027h),000h	;3564
	push iy			;3568
	pop hl			;356a
	jp cret			;356b
l356eh:
	ld de,0002ah		;356e
	add iy,de		;3571
l3573h:
	ld de,_dnames		;3573
	push iy			;3576
	pop hl			;3578
	call wrelop		;3579
	jr c,l354eh		;357c
	ld hl,00000h		;357e
	jp cret			;3581


; =============== F U N C T I O N =======================================
;	From library?
;
_putfcb:
	call csv		;3584
	ld l,(ix+006h)		;3587
	ld h,(ix+007h)		;358a
	push hl			;358d
	pop iy			;358e
	ld (iy+028h),000h	;3590
	jp cret			;3594


; =============== F U N C T I O N =======================================
;	From library?
;
_setfcb:
	call csv		;3597
	push hl			;359a
	ld l,(ix+008h)		;359b
	ld h,(ix+009h)		;359e
	push hl			;35a1
	pop iy			;35a2
	jr l35a8h		;35a4
l35a6h:
	inc iy			;35a6
l35a8h:
	ld a,(iy+000h)		;35a8
	ld e,a			;35ab
	rla			;35ac
	sbc a,a			;35ad
	ld d,a			;35ae
	ld hl,l46b4h		;35af __ctype_+1
	add hl,de		;35b2
	bit 3,(hl)		;35b3 isspace()
	jr nz,l35a6h		;35b5
	ld (ix-001h),000h	;35b7
	jr l35ebh		;35bb
l35bdh:
	ld (ix-002h),000h	;35bd
l35c1h:
	push iy			;35c1
	pop de			;35c3
	ld l,(ix-002h)		;35c4
	ld h,000h		;35c7
	add hl,de		;35c9
	ld a,(hl)		;35ca
	ld l,a			;35cb
	rla			;35cc
	sbc a,a			;35cd
	ld h,a			;35ce
	push hl			;35cf
	call _upcase		;35d0
	pop bc			;35d3
	ld a,l			;35d4
	ld e,(ix-002h)		;35d5
	ld d,000h		;35d8
	ld l,(ix-001h)		;35da
	ld h,d			;35dd
	add hl,hl		;35de
	add hl,hl		;35df
	add hl,de		;35e0
	ld de,_dnames		;35e1
	add hl,de		;35e4
	cp (hl)			;35e5
	jr z,l3608h		;35e6
	inc (ix-001h)		;35e8
l35ebh:
	ld b,004h		;35eb
	ld a,(ix-001h)		;35ed
	call brelop		;35f0
	jr c,l35bdh		;35f3
	push iy			;35f5
	ld l,(ix+006h)		;35f7
	ld h,(ix+007h)		;35fa
	push hl			;35fd
	call _fc_parse		;35fe
	pop bc			;3601
	pop bc			;3602
	ld l,000h		;3603
	jp cret			;3605
l3608h:
	inc (ix-002h)		;3608
	ld a,(ix-002h)		;360b
	cp 004h			;360e
	jr nz,l35c1h		;3610
	ld a,(ix-001h)		;3612
	add a,004h		;3615
	ld e,(ix+006h)		;3617
	ld d,(ix+007h)		;361a
	ld hl,00028h		;361d
	add hl,de		;3620
	ld (hl),a		;3621
	ld l,001h		;3622
	jp cret			;3624


; =============== F U N C T I O N =======================================
;	From library?
;
_fc_parse:
	call csv		;3627
	push hl			;362a
	push hl			;362b
	ld l,(ix+006h)		;362c
	ld h,(ix+007h)		;362f
	push hl			;3632
	pop iy			;3633
	ld (iy+000h),000h	;3635
	call _getuid		;3639
	ld (iy+029h),l		;363c
	ld l,(ix+008h)		;363f
	ld h,(ix+009h)		;3642
	ld (ix-002h),l		;3645
	ld (ix-001h),h		;3648
	jr l365ah		;364b
l364dh:
	ld l,(ix-002h)		;364d
	ld h,(ix-001h)		;3650
	inc hl			;3653
	ld (ix-002h),l		;3654
	ld (ix-001h),h		;3657
l365ah:
	ld l,(ix-002h)		;365a
	ld h,(ix-001h)		;365d
	ld a,(hl)		;3660
	ld e,a			;3661
	rla			;3662
	sbc a,a			;3663
	ld d,a			;3664
	ld hl,l46b4h		;3665 __ctype_+1
	add hl,de		;3668
	bit 2,(hl)		;3669 isdigit()
	jr nz,l364dh		;366b
	ld e,(ix-002h)		;366d
	ld d,(ix-001h)		;3670
	ld l,(ix+008h)		;3673
	ld h,(ix+009h)		;3676
	or a			;3679
	sbc hl,de		;367a
	jr z,l36a0h		;367c
	ld l,e			;367e
	ld h,d			;367f
	ld a,(hl)		;3680
	cp 03ah			;3681
	ld l,(ix+008h)		;3683
	ld h,(ix+009h)		;3686
	jr nz,l36a6h		;3689
	push hl			;368b
	call atoi		;368c
	pop bc			;368f
	ld (iy+029h),l		;3690
	ld l,(ix-002h)		;3693
	ld h,(ix-001h)		;3696
	inc hl			;3699
	ld (ix+008h),l		;369a
	ld (ix+009h),h		;369d
l36a0h:
	ld l,(ix+008h)		;36a0
	ld h,(ix+009h)		;36a3
l36a6h:
	ld a,(hl)		;36a6
	or a			;36a7
	jr z,l36d7h		;36a8
	ld l,(ix+008h)		;36aa
	ld h,(ix+009h)		;36ad
	inc hl			;36b0
	ld a,(hl)		;36b1
	cp 03ah			;36b2
	jr nz,l36d7h		;36b4
	dec hl			;36b6
	ld a,(hl)		;36b7
	ld l,a			;36b8
	rla			;36b9
	sbc a,a			;36ba
	ld h,a			;36bb
	push hl			;36bc
	call _upcase		;36bd
	pop bc			;36c0
	ld a,l			;36c1
	rla			;36c2
	ld a,l			;36c3
	add a,0c0h		;36c4
	ld (iy+000h),a		;36c6
	ld l,(ix+008h)		;36c9
	ld h,(ix+009h)		;36cc
	inc hl			;36cf
	inc hl			;36d0
	ld (ix+008h),l		;36d1
	ld (ix+009h),h		;36d4
l36d7h:
	push iy			;36d7
	pop hl			;36d9
	inc hl			;36da
	ld (ix-002h),l		;36db
	ld (ix-001h),h		;36de
	jr l370ah		;36e1
l36e3h:
	ld l,(ix+008h)		;36e3
	ld h,(ix+009h)		;36e6
	ld a,(hl)		;36e9
	inc hl			;36ea
	ld (ix+008h),l		;36eb
	ld (ix+009h),h		;36ee
	ld l,a			;36f1
	rla			;36f2
	sbc a,a			;36f3
	ld h,a			;36f4
	push hl			;36f5
	call _upcase		;36f6
	pop bc			;36f9
	ld e,l			;36fa
	ld l,(ix-002h)		;36fb
	ld h,(ix-001h)		;36fe
	inc hl			;3701
	ld (ix-002h),l		;3702
	ld (ix-001h),h		;3705
	dec hl			;3708
	ld (hl),e		;3709
l370ah:
	ld l,(ix+008h)		;370a
	ld h,(ix+009h)		;370d
	ld a,(hl)		;3710
	cp 02eh			;3711
	ld a,(hl)		;3713
	jr z,l3742h		;3714
	cp 02ah			;3716
	ld a,(hl)		;3718
	jr z,l3742h		;3719
	ld e,a			;371b
	rla			;371c
	sbc a,a			;371d
	ld d,a			;371e
	ld hl,00020h		;371f
	call wrelop		;3722
	jp p,l373bh		;3725
	push iy			;3728
	pop de			;372a
	ld hl,00009h		;372b
	add hl,de		;372e
	ex de,hl		;372f
	ld l,(ix-002h)		;3730
	ld h,(ix-001h)		;3733
	call wrelop		;3736
	jr c,l36e3h		;3739
l373bh:
	ld l,(ix+008h)		;373b
	ld h,(ix+009h)		;373e
	ld a,(hl)		;3741
l3742h:
	cp 02ah			;3742
	jr nz,l374ch		;3744
	ld (ix-003h),03fh	;3746
	jr l3764h		;374a
l374ch:
	ld (ix-003h),020h	;374c
	jr l3764h		;3750
l3752h:
	ld a,(ix-003h)		;3752
	ld l,(ix-002h)		;3755
	ld h,(ix-001h)		;3758
	inc hl			;375b
	ld (ix-002h),l		;375c
	ld (ix-001h),h		;375f
	dec hl			;3762
	ld (hl),a		;3763
l3764h:
	push iy			;3764
	pop de			;3766
	ld hl,00009h		;3767
	add hl,de		;376a
	ex de,hl		;376b
	ld l,(ix-002h)		;376c
	ld h,(ix-001h)		;376f
	call wrelop		;3772
	jr c,l3752h		;3775
l3777h:
	ld l,(ix+008h)		;3777
	ld h,(ix+009h)		;377a
	ld a,(hl)		;377d
	or a			;377e
	ld a,(hl)		;377f
	jr z,l37bdh		;3780
	inc hl			;3782
	ld (ix+008h),l		;3783
	ld (ix+009h),h		;3786
	cp 02eh			;3789
	jr nz,l3777h		;378b
	jr l37b6h		;378d
l378fh:
	ld l,(ix+008h)		;378f
	ld h,(ix+009h)		;3792
	ld a,(hl)		;3795
	inc hl			;3796
	ld (ix+008h),l		;3797
	ld (ix+009h),h		;379a
	ld l,a			;379d
	rla			;379e
	sbc a,a			;379f
	ld h,a			;37a0
	push hl			;37a1
	call _upcase		;37a2
	pop bc			;37a5
	ld e,l			;37a6
	ld l,(ix-002h)		;37a7
	ld h,(ix-001h)		;37aa
	inc hl			;37ad
	ld (ix-002h),l		;37ae
	ld (ix-001h),h		;37b1
	dec hl			;37b4
	ld (hl),e		;37b5
l37b6h:
	ld l,(ix+008h)		;37b6
	ld h,(ix+009h)		;37b9
	ld a,(hl)		;37bc
l37bdh:
	ld e,a			;37bd
	rla			;37be
	sbc a,a			;37bf
	ld d,a			;37c0
	ld hl,00020h		;37c1
	call wrelop		;37c4
	ld l,(ix+008h)		;37c7
	ld h,(ix+009h)		;37ca
	ld a,(hl)		;37cd
	jp p,l37efh		;37ce
	cp 02ah			;37d1
	jr z,l37e8h		;37d3
	push iy			;37d5
	pop de			;37d7
	ld hl,0000ch		;37d8
	add hl,de		;37db
	ex de,hl		;37dc
	ld l,(ix-002h)		;37dd
	ld h,(ix-001h)		;37e0
	call wrelop		;37e3
	jr c,l378fh		;37e6
l37e8h:
	ld l,(ix+008h)		;37e8
	ld h,(ix+009h)		;37eb
	ld a,(hl)		;37ee
l37efh:
	cp 02ah			;37ef
	jr nz,l37f9h		;37f1
	ld (ix-003h),03fh	;37f3
	jr l3811h		;37f7
l37f9h:
	ld (ix-003h),020h	;37f9
	jr l3811h		;37fd
l37ffh:
	ld a,(ix-003h)		;37ff
	ld l,(ix-002h)		;3802
	ld h,(ix-001h)		;3805
	inc hl			;3808
	ld (ix-002h),l		;3809
	ld (ix-001h),h		;380c
	dec hl			;380f
	ld (hl),a		;3810
l3811h:
	push iy			;3811
	pop de			;3813
	ld hl,0000ch		;3814
	add hl,de		;3817
	ex de,hl		;3818
	ld l,(ix-002h)		;3819
	ld h,(ix-001h)		;381c
	call wrelop		;381f
	jr c,l37ffh		;3822
	xor a			;3824
	ld (iy+020h),a		;3825
	ld (iy+00ch),a		;3828
	jp cret			;382b


; =============== F U N C T I O N =======================================
;	From library?
;
_signal:
	call csv		;382e
	push hl			;3831
	ld de,00001h		;3832
	ld l,(ix+006h)		;3835
	ld h,(ix+007h)	;p1	;3838
	or a			;383b
	sbc hl,de		;383c
	jr z,l3846h		;383e		; if(p1 != 1)

	ld hl,0ffffh		;3840
	jp cret			;3843		;     return -1;
l3846h:
	ld hl,(05586h)		;3846
	ld (ix-002h),l		;3849
	ld (ix-001h),h	;l1	;384c		; l1 = 

	ld l,(ix+008h)		;384f
	ld h,(ix+009h)	;p2	;3852
	ld (05586h),hl		;3855

	ld l,(ix-002h)		;3858
	ld h,(ix-001h)	;l1	;385b
	jp cret			;385e


; =============== F U N C T I O N =======================================
;	From library?
;
__sigchk:
	call csv		;3861
	push hl			;3864
	ld de,00001h		;3865
	ld hl,(05586h)		;3868
	or a			;386b
	sbc hl,de		;386c
	jp z,cret		;386e
	ld hl,0000bh		;3871
	push hl			;3874
	call bdos		;3875
	pop bc			;3878
	ld a,l			;3879
	or a			;387a
	jp z,cret		;387b
	ld hl,00001h		;387e
	push hl			;3881
	call bdos		;3882
	pop bc			;3885
	ld e,l			;3886
	ld (ix-001h),e		;3887
	ld a,e			;388a
	cp 003h			;388b
	jp nz,cret		;388d
	ld hl,(05586h)		;3890
	ld a,l			;3893
	or h			;3894
	call z,exit		;3895
	ld hl,(05586h)		;3898
	call indir		;389b
	jp cret			;389e


; =============== F U N C T I O N =======================================
;	From library?
;
_getuid:
	call csv		;38a1
	ld c,020h		;38a4
	ld e,0ffh		;38a6
	push ix			;38a8
	call BDOS		;38aa
	pop ix			;38ad
	ld l,a			;38af
	ld h,000h		;38b0
	jp cret			;38b2



; =============== F U N C T I O N =======================================
;	From library?
;
_setuid:
	call csv		;38b5
	ld e,(ix+006h)		;38b8
	ld c,020h		;38bb
	push ix			;38bd
	call BDOS		;38bf
	pop ix			;38c2
	jp cret			;38c4


; =============== F U N C T I O N =======================================
;	From library?
;
bdos:
	call csv		;38c7
	ld e,(ix+008h)		;38ca
	ld d,(ix+009h)		;38cd
	ld c,(ix+006h)		;38d0
	push ix			;38d3
	push iy			;38d5
	call BDOS		;38d7
	pop iy			;38da
	pop ix			;38dc
	ld l,a			;38de
	rla			;38df
	sbc a,a			;38e0
	ld h,a			;38e1
	jp cret			;38e2


; =============== F U N C T I O N =======================================
;	From library?
;
bdoshl:
	call csv		;38e5
	ld e,(ix+008h)		;38e8
	ld d,(ix+009h)		;38eb
	ld c,(ix+006h)		;38ee
	push ix			;38f1
	call BDOS		;38f3
	pop ix			;38f6
	jp cret			;38f8


; =============== F U N C T I O N =======================================
;	From library?
;
__exit:
	call __cpm_clean	;38fb
	pop hl			;38fe
	pop hl			;38ff
	ld (00080h),hl		;3900
	jp 00000h		;3903


; =============== F U N C T I O N =======================================
;	From library?
;
asallsh:
	push bc			;3906
	ld e,(hl)		;3907
	inc hl			;3908
	ld d,(hl)		;3909
	inc hl			;390a
	ld c,(hl)		;390b
	inc hl			;390c
	ld b,(hl)		;390d
	ex (sp),hl		;390e
	push bc			;390f
	ex (sp),hl		;3910
	pop bc			;3911
	call allsh		;3912
	jp iregstore		;3915


; =============== F U N C T I O N =======================================
;	From library?
;
allsh:
	ld a,b			;3918
	or a			;3919
	ret z			;391a
	cp 021h			;391b
	jr c,l3921h		;391d
	ld b,020h		;391f
l3921h:
	ex de,hl		;3921
	add hl,hl		;3922
	ex de,hl		;3923
	adc hl,hl		;3924
	djnz l3921h		;3926
	ret			;3928


; =============== F U N C T I O N =======================================
;	From library?
;
asaladd:
	call iregset		;3929
	call aladd		;392c
	jp iregstore		;392f


; =============== F U N C T I O N =======================================
;	From library?
;
digit:
	sub 030h		;3932
	ret c			;3934
	cp 00ah			;3935
	ccf			;3937
	ret			;3938


; =============== F U N C T I O N =======================================
;	From library?
;
atoi:
	pop bc			;3939
	pop de			;393a
	push de			;393b
	push bc			;393c
	ld hl,00000h		;393d
l3940h:
	ld a,(de)		;3940
	inc de			;3941
	cp 020h			;3942
	jr z,l3940h		;3944
	cp 009h			;3946
	jr z,l3940h		;3948
	dec de			;394a
	cp 02dh			;394b
	jr z,l3954h		;394d
	cp 02bh			;394f
	jr nz,l3955h		;3951
	or a			;3953
l3954h:
	inc de			;3954
l3955h:
	ex af,af'		;3955
l3956h:
	ld a,(de)		;3956
	inc de			;3957
	call digit		;3958
	jr c,l3969h		;395b
	add hl,hl		;395d
	ld c,l			;395e
	ld b,h			;395f
	add hl,hl		;3960
	add hl,hl		;3961
	add hl,bc		;3962
	ld c,a			;3963
	ld b,000h		;3964
	add hl,bc		;3966
	jr l3956h		;3967
l3969h:
	ex af,af'		;3969
	ret nz			;396a
	ex de,hl		;396b
	ld hl,00000h		;396c
	sbc hl,de		;396f
	ret			;3971


; =============== F U N C T I O N =======================================
;	From library?
;
index:
	call rcsv		;3972
	jr l3978h		;3975
l3977h:
	inc hl			;3977
l3978h:
	ld a,(hl)		;3978
	or a			;3979
	jr z,l3982h		;397a
	cp e			;397c
	jr nz,l3977h		;397d
l397fh:
	jp cret			;397f
l3982h:
	ld hl,00000h		;3982
	jr l397fh		;3985


; =============== F U N C T I O N =======================================
;	From library?
;
iregset:
	ld e,(hl)		;3987
	inc hl			;3988
	ld d,(hl)		;3989
	inc hl			;398a
	ld c,(hl)		;398b
	inc hl			;398c
	ld b,(hl)		;398d
	ex (sp),hl		;398e
	push bc			;398f
	ex (sp),hl		;3990
	pop bc			;3991
	exx			;3992
	pop hl			;3993
	pop bc			;3994
	pop de			;3995
	ex (sp),hl		;3996
	push bc			;3997
	ex (sp),hl		;3998
	pop bc			;3999
	ex (sp),hl		;399a
	push hl			;399b
	push bc			;399c
	push de			;399d
	exx			;399e
	push bc			;399f
	ret			;39a0

; =============== F U N C T I O N =======================================
;	From library?
;
iregstore:
	ex (sp),hl		;39a1
	pop bc			;39a2
	ld (hl),b		;39a3
	dec hl			;39a4
	ld (hl),c		;39a5
	dec hl			;39a6
	ld (hl),d		;39a7
	dec hl			;39a8
	ld (hl),e		;39a9
	push bc			;39aa
	pop hl			;39ab
	ret			;39ac

; =============== F U N C T I O N =======================================
;	From library?
;
aladd:
	exx			;39ad
	pop hl			;39ae
	exx			;39af
	pop bc			;39b0
	ex de,hl		;39b1
	add hl,bc		;39b2
	ex de,hl		;39b3
	pop bc			;39b4
	adc hl,bc		;39b5
	exx			;39b7
	push hl			;39b8
	exx			;39b9
	ret			;39ba


; =============== F U N C T I O N =======================================
;	From library?
;
;	logical long right shift
;	value in HLDE, count in B
llrsh:
	ld a,b			;39bb
	or a			;39bc
	ret z			;39bd
	cp 021h			;39be
	jr c,l39c4h		;39c0
	ld b,020h		;39c2
l39c4h:
	srl h			;39c4
	rr l			;39c6
	rr d			;39c8
	rr e			;39ca
	djnz l39c4h		;39cc
	ret			;39ce


; =============== F U N C T I O N =======================================
;	From library?
;
lrelop:
	exx			;39cf
	pop hl			;39d0
	exx			;39d1
	pop bc			;39d2
	ex de,hl		;39d3
	ex (sp),hl		;39d4
	ex de,hl		;39d5
	ld a,h			;39d6
	xor d			;39d7
	jp p,l39e1h		;39d8
	ld a,h			;39db
	or 001h			;39dc
	pop hl			;39de
	jr l39f0h		;39df
l39e1h:
	or a			;39e1
	sbc hl,de		;39e2
	pop hl			;39e4
	jr nz,l39f0h		;39e5
	sbc hl,bc		;39e7
	jr z,l39f0h		;39e9
	ld a,002h		;39eb
	rra			;39ed
	or a			;39ee
	rlca			;39ef
l39f0h:
	exx			;39f0
	jp (hl)			;39f1


; =============== F U N C T I O N =======================================
;	From library?
;
brelop:
	push de			;39f2
	ld e,a			;39f3
	xor b			;39f4
	jp m,l39fch		;39f5
	ld a,e			;39f8
	sbc a,b			;39f9
	pop de			;39fa
	ret			;39fb
l39fch:
	ld a,e			;39fc
	and 080h		;39fd
	ld d,a			;39ff
	ld a,e			;3a00
	sbc a,b			;3a01
	ld a,d			;3a02
	inc a			;3a03
	pop de			;3a04
	ret			;3a05


; =============== F U N C T I O N =======================================
;	From library?
;
wrelop:
	ld a,h			;3a06
	xor d			;3a07
	jp m,l3a0eh		;3a08
	sbc hl,de		;3a0b
	ret			;3a0d
l3a0eh:
	ld a,h			;3a0e
	and 080h		;3a0f
	sbc hl,de		;3a11
	inc a			;3a13
	ret			;3a14


; =============== F U N C T I O N =======================================
;	From library?
;
alsub:
	exx			;3a15
	pop hl			;3a16
	exx			;3a17
	pop bc			;3a18
	ex de,hl		;3a19
	or a			;3a1a
	sbc hl,bc		;3a1b
	ex de,hl		;3a1d
	pop bc			;3a1e
	sbc hl,bc		;3a1f
	exx			;3a21
	push hl			;3a22
	exx			;3a23
	ret			;3a24


; =============== F U N C T I O N =======================================
;	malloc	From library
;
_malloc:
	call csv		;3a25
	push hl			;3a28
	ld hl,(0558ch)		;3a29
	ld a,l			;3a2c
	or h			;3a2d
	jr nz,l3a4ch		;3a2e

	ld hl,0558fh		;3a30
	ld (0558ch),hl		;3a33
	ld (05592h),hl		;3a36

	ld hl,0558ch		;3a39
	ld (0558fh),hl		;3a3c
	ld (0558ah),hl		;3a3f

	ld hl,0558eh		;3a42
	set 0,(hl)		;3a45

	ld hl,05591h		;3a47
	set 0,(hl)		;3a4a
l3a4ch:
	ld e,(ix+006h)		;3a4c
	ld d,(ix+007h)		;3a4f
	ld hl,0x0005		;3a52
	add hl,de		;3a55
	ld de,00003h		;3a56
	call ldiv		;3a59
	ld de,00003h		;3a5c
	call lmul		;3a5f
	ld (ix+006h),l		;3a62
	ld (ix+007h),h		;3a65
	ld iy,(0558ah)		;3a68
l3a6ch:
	ld hl,00000h		;3a6c
	ld (05588h),hl		;3a6f
l3a72h:
	bit 0,(iy+002h)		;3a72
	jp nz,l3b0dh		;3a76
	jr l3a8ah		;3a79
l3a7bh:
	ld l,(ix-002h)		;3a7b
	ld h,(ix-001h)		;3a7e
	ld c,(hl)		;3a81
	inc hl			;3a82
	ld b,(hl)		;3a83
	ld (iy+000h),c		;3a84
	ld (iy+001h),b		;3a87
l3a8ah:
	ld l,(iy+000h)		;3a8a
	ld h,(iy+001h)		;3a8d
	ld (ix-002h),l		;3a90
	ld (ix-001h),h		;3a93
	inc hl			;3a96
	inc hl			;3a97
	bit 0,(hl)		;3a98
	jr z,l3a7bh		;3a9a

	push iy			;3a9c
	pop de			;3a9e
	ld l,(ix+006h)		;3a9f
	ld h,(ix+007h)		;3aa2
	add hl,de		;3aa5
	ex de,hl		;3aa6
	ld l,(ix-002h)		;3aa7
	ld h,(ix-001h)		;3aaa
	call wrelop		;3aad
	push iy			;3ab0
	jr c,l3b0fh		;3ab2

	pop de			;3ab4
	ld l,(ix+006h)		;3ab5
	ld h,(ix+007h)		;3ab8
	add hl,de		;3abb
	push iy			;3abc
	pop de			;3abe
	call wrelop		;3abf
	push iy			;3ac2
	jr c,l3b0fh		;3ac4

	pop de			;3ac6
	ld l,(ix+006h)		;3ac7
	ld h,(ix+007h)		;3aca
	add hl,de		;3acd
	ld (0558ah),hl		;3ace
	ld e,(ix-002h)		;3ad1
	ld d,(ix-001h)		;3ad4
	call wrelop		;3ad7
	ld hl,(0558ah)		;3ada
	jr nc,l3afah		;3add

	ld de,05594h		;3adf
	push hl			;3ae2
	ld bc,00003h		;3ae3
	ldir			;3ae6
	pop hl			;3ae8
	ld e,(iy+000h)		;3ae9
	ld d,(iy+001h)		;3aec
	ld hl,(0558ah)		;3aef
	ld (hl),e		;3af2
	inc hl			;3af3
	ld (hl),d		;3af4
	inc hl			;3af5
	ld (hl),000h		;3af6
	dec hl			;3af8
	dec hl			;3af9
l3afah:
	ld (iy+000h),l		;3afa
	ld (iy+001h),h		;3afd
	set 0,(iy+002h)		;3b00
	push iy			;3b04
	pop hl			;3b06
	inc hl			;3b07
	inc hl			;3b08
	inc hl			;3b09
	jp cret			;3b0a
l3b0dh:
	push iy			;3b0d
l3b0fh:
	pop hl			;3b0f
	ld (ix-002h),l		;3b10
	ld (ix-001h),h		;3b13
	ld l,(iy+000h)		;3b16
	ld h,(iy+001h)		;3b19
	push hl			;3b1c
	pop iy			;3b1d
	push hl			;3b1f
	pop de			;3b20
	ld l,(ix-002h)		;3b21
	ld h,(ix-001h)		;3b24
	call wrelop		;3b27
	jp c,l3a72h		;3b2a

	ld de,(05592h)		;3b2d
	ld l,(ix-002h)		;3b31
	ld h,(ix-001h)		;3b34
	or a			;3b37
	sbc hl,de		;3b38
	jr nz,l3b47h		;3b3a

	ld de,0558ch		;3b3c
	push iy			;3b3f
	pop hl			;3b41
	or a			;3b42
	sbc hl,de		;3b43
	jr z,l3b4dh		;3b45
l3b47h:
	ld hl,00000h		;3b47
	jp cret			;3b4a
l3b4dh:
	ld hl,(05588h)		;3b4d
	inc hl			;3b50
	ld (05588h),hl		;3b51
	ex de,hl		;3b54
	ld hl,00001h		;3b55
	call wrelop		;3b58
	jp nc,l3a72h		;3b5b

	ld e,(ix+006h)		;3b5e
	ld d,(ix+007h)		;3b61
	ld hl,l0100h+1		;3b64
	add hl,de		;3b67
	ld de,000ffh		;3b68
	call ldiv		;3b6b
	ld de,000ffh		;3b6e
	call lmul		;3b71
	ld (05588h),hl		;3b74
	ld hl,00000h		;3b77
	push hl			;3b7a
	call sbrk		;3b7b
	pop bc			;3b7e
	ld (ix-002h),l		;3b7f
	ld (ix-001h),h		;3b82
	ld de,(05588h)		;3b85
	add hl,de		;3b89
	ld e,(ix-002h)		;3b8a
	ld d,(ix-001h)		;3b8d
	call wrelop		;3b90
	jr c,l3b47h		;3b93

	ld hl,(05588h)		;3b95
	push hl			;3b98
	call sbrk		;3b99
	pop bc			;3b9c
	ld (ix-002h),l		;3b9d
	ld (ix-001h),h		;3ba0
	ld de,0ffffh		;3ba3
	or a			;3ba6
	sbc hl,de		;3ba7
	jr z,l3b47h		;3ba9

	ld e,(ix-002h)		;3bab
	ld d,(ix-001h)		;3bae
	ld hl,(05592h)		;3bb1
	ld (hl),e		;3bb4
	inc hl			;3bb5
	ld (hl),d		;3bb6
	inc hl			;3bb7
	inc hl			;3bb8
	or a			;3bb9
	sbc hl,de		;3bba
	ld hl,(05592h)		;3bbc
	inc hl			;3bbf
	inc hl			;3bc0
	jr z,l3bc7h		;3bc1

	set 0,(hl)		;3bc3
	jr l3bc9h		;3bc5
l3bc7h:
	res 0,(hl)		;3bc7
l3bc9h:
	ld de,(05588h)		;3bc9
	ld l,(ix-002h)		;3bcd
	ld h,(ix-001h)		;3bd0
	add hl,de		;3bd3
	dec hl			;3bd4
	dec hl			;3bd5
	dec hl			;3bd6
	ex de,hl		;3bd7
	ld l,(ix-002h)		;3bd8
	ld h,(ix-001h)		;3bdb
	ld (hl),e		;3bde
	inc hl			;3bdf
	ld (hl),d		;3be0
	ld (05592h),de		;3be1
	ld de,0558ch		;3be5
	ld hl,(05592h)		;3be8
	ld (hl),e		;3beb
	inc hl			;3bec
	ld (hl),d		;3bed
	inc hl			;3bee
	set 0,(hl)		;3bef
	ld l,(ix-002h)		;3bf1
	ld h,(ix-001h)		;3bf4
	inc hl			;3bf7
	inc hl			;3bf8
	res 0,(hl)		;3bf9
	jp l3a6ch		;3bfb


; =============== F U N C T I O N =======================================
;	free	From library
;
_free:
	call csv		;3bfe
	ld l,(ix+006h)		;3c01
	ld h,(ix+007h)		;3c04
	dec hl			;3c07
	dec hl			;3c08
	dec hl			;3c09
	push hl			;3c0a
	pop iy			;3c0b
	ld (0558ah),iy		;3c0d
	res 0,(iy+002h)		;3c11
	jp cret			;3c15


; =============== F U N C T I O N =======================================
;	realloc	From library
;
_realloc:
	call ncsv		;3c18
	defw  -6
	ld   l,(ix+6)
	ld   h,(ix+7)

	push hl			;3c23
	pop iy			;3c24
	ld de,00003h		;3c26
	ld l,(ix+008h)		;3c29
	ld h,(ix+009h)		;3c2c
	inc hl			;3c2f
	inc hl			;3c30
	call ldiv		;3c31
	ld (ix-006h),l		;3c34
	ld (ix-005h),h		;3c37
	push iy			;3c3a
	pop de			;3c3c
	ld l,(iy-003h)		;3c3d
	ld h,(iy-002h)		;3c40
	or a			;3c43
	sbc hl,de		;3c44
	ld de,00003h		;3c46
	call adiv		;3c49
	ld (ix-004h),l		;3c4c
	ld (ix-003h),h		;3c4f
	bit 0,(iy-001h)		;3c52
	jr z,l3c5eh		;3c56

	push iy			;3c58
	call _free		;3c5a
	pop bc			;3c5d
l3c5eh:
	ld l,(ix+008h)		;3c5e
	ld h,(ix+009h)		;3c61
	push hl			;3c64
	call _malloc		;3c65
	pop bc			;3c68
	ld (ix-002h),l		;3c69
	ld (ix-001h),h		;3c6c
	ld a,l			;3c6f
	or h			;3c70
	jr z,l3c7bh		;3c71

	push iy			;3c73
	pop de			;3c75
	or a			;3c76
	sbc hl,de		;3c77
	jr nz,l3c84h		;3c79
l3c7bh:
	ld l,(ix-002h)		;3c7b
	ld h,(ix-001h)		;3c7e
	jp cret			;3c81
l3c84h:
	ld e,(ix-002h)		;3c84
	ld d,(ix-001h)		;3c87
	ld l,e			;3c8a
	ld h,d			;3c8b
	dec hl			;3c8c
	dec hl			;3c8d
	dec hl			;3c8e
	ld a,(hl)		;3c8f
	inc hl			;3c90
	ld h,(hl)		;3c91
	ld l,a			;3c92
	or a			;3c93
	sbc hl,de		;3c94
	ld de,00003h		;3c96
	call adiv		;3c99
	ld (ix-006h),l		;3c9c
	ld (ix-005h),h		;3c9f
	ld e,(ix-004h)		;3ca2
	ld d,(ix-003h)		;3ca5
	call wrelop		;3ca8
	jr nc,l3cb9h		;3cab

	ld l,(ix-006h)		;3cad
	ld h,(ix-005h)		;3cb0
	ld (ix-004h),l		;3cb3
	ld (ix-003h),h		;3cb6
l3cb9h:
	ld de,00003h		;3cb9
	ld l,(ix-004h)		;3cbc
	ld h,(ix-003h)		;3cbf
	call lmul		;3cc2
	push hl			;3cc5
	ld l,(ix-002h)		;3cc6
	ld h,(ix-001h)		;3cc9
	push hl			;3ccc
	push iy			;3ccd
	call movmem		;3ccf
	pop bc			;3cd2
	pop bc			;3cd3
	pop bc			;3cd4
	push iy			;3cd5
	pop de			;3cd7
	ld l,(ix-002h)		;3cd8
	ld h,(ix-001h)		;3cdb
	call wrelop		;3cde
	jr nc,l3c7bh		;3ce1

	ld de,00003h		;3ce3
	ld l,(ix-006h)		;3ce6
	ld h,(ix-005h)		;3ce9
	call lmul		;3cec
	ld e,(ix-002h)		;3cef
	ld d,(ix-001h)		;3cf2
	add hl,de		;3cf5
	ex de,hl		;3cf6
	push iy			;3cf7
	pop hl			;3cf9
	call wrelop		;3cfa
	jp nc,l3c7bh		;3cfd

	ld de,00003h		;3d00
	ld l,(ix-006h)		;3d03
	ld h,(ix-005h)		;3d06
	call lmul		;3d09
	ld e,(ix-002h)		;3d0c
	ld d,(ix-001h)		;3d0f
	add hl,de		;3d12
	push iy			;3d13
	pop de			;3d15
	or a			;3d16
	sbc hl,de		;3d17
	ld de,00003h		;3d19
	call adiv		;3d1c
	ld de,00003h		;3d1f
	call lmul		;3d22
	ld e,(ix-002h)		;3d25
	ld d,(ix-001h)		;3d28
	add hl,de		;3d2b
	ex de,hl		;3d2c
	ld hl,05594h		;3d2d
	push hl			;3d30
	ld bc,00003h		;3d31
	ldir			;3d34
	pop hl			;3d36
	jp l3c7bh		;3d37

; =============== F U N C T I O N =======================================
;   16 bit divide and modulus routines
; called with dividend in hl and divisor in de
; returns with result in hl.
;
; adiv (amod) is signed divide (modulus), ldiv (lmod) is unsigned
;
amod:
	call adiv		;3d3a
	ex de,hl		;3d3d
	ret			;3d3e

;
;
lmod:
	call ldiv		;3d3f
	ex de,hl		;3d42
	ret			;3d43

; =============== F U N C T I O N =======================================
;	From library?
;
ldiv:
	xor a			;3d44
	ex af,af'		;3d45
	ex de,hl		;3d46
	jr l3d54h		;3d47


; =============== F U N C T I O N =======================================
;	adiv	From library
;
adiv:
	ld a,h			;3d49
	xor d			;3d4a
	ld a,h			;3d4b
	ex af,af'		;3d4c
	call l_negif		;3d4d
	ex de,hl		;3d50
	call l_negif		;3d51
l3d54h:
	ld b,001h		;3d54
	ld a,h			;3d56
	or l			;3d57
	ret z			;3d58
l3d59h:
	push hl			;3d59
	add hl,hl		;3d5a
	jr c,l3d6bh		;3d5b
	ld a,d			;3d5d
	cp h			;3d5e
	jr c,l3d6bh		;3d5f
	jr nz,l3d67h		;3d61
	ld a,e			;3d63
	cp l			;3d64
	jr c,l3d6bh		;3d65
l3d67h:
	pop af			;3d67
	inc b			;3d68
	jr l3d59h		;3d69
l3d6bh:
	pop hl			;3d6b
	ex de,hl		;3d6c
	push hl			;3d6d
	ld hl,00000h		;3d6e
	ex (sp),hl		;3d71
l3d72h:
	ld a,h			;3d72
	cp d			;3d73
	jr c,l3d7eh		;3d74
	jr nz,l3d7ch		;3d76
	ld a,l			;3d78
	cp e			;3d79
	jr c,l3d7eh		;3d7a
l3d7ch:
	sbc hl,de		;3d7c
l3d7eh:
	ex (sp),hl		;3d7e
	ccf			;3d7f
	adc hl,hl		;3d80
	srl d			;3d82
	rr e			;3d84
	ex (sp),hl		;3d86
	djnz l3d72h		;3d87
	pop de			;3d89
	ex de,hl		;3d8a
	ex af,af'		;3d8b
	call m,l_negat	;3d8c
	ex de,hl		;3d8f
	or a			;3d90
	call m,l_negat	;3d91
	ex de,hl		;3d94
	ret			;3d95


; =============== F U N C T I O N =======================================
;	l_negif	From library
;
l_negif:
	bit 7,h			;3d96
	ret z			;3d98


; =============== F U N C T I O N =======================================
;	l_negat	From library
;
l_negat:
	ld b,h			;3d99
	ld c,l			;3d9a
	ld hl,00000h		;3d9b
	or a			;3d9e
	sbc hl,bc		;3d9f
	ret			;3da1


; =============== F U N C T I O N =======================================
;	_pnum	From library
;
__pnum:
	call ncsv		;3da2
	dw	0FFE1H	;-31	;3da5
	ld a,(ix+00ah)		;3da7
	ld e,a			;3daa
	rla			;3dab
	sbc a,a			;3dac
	ld d,a			;3dad
	ld hl,0001eh		;3dae
	call wrelop		;3db1
	jp p,l3dbbh		;3db4

	ld (ix+00ah),01eh	;3db7
l3dbbh:
	ld a,(ix+00eh)		;3dbb
	or a			;3dbe
	jr z,l3df1h		;3dbf
	bit 7,(ix+009h)		;3dc1
	jr z,l3df1h		;3dc5
	ld e,(ix+006h)		;3dc7
	ld d,(ix+007h)		;3dca
	ld l,(ix+008h)		;3dcd
	ld h,(ix+009h)		;3dd0
	push hl			;3dd3
	push de			;3dd4
	ld hl,00000h		;3dd5
	pop bc			;3dd8
	or a			;3dd9
	sbc hl,bc		;3dda
	pop bc			;3ddc
	ex de,hl		;3ddd
	ld hl,00000h		;3dde
	sbc hl,bc		;3de1
	ld (ix+006h),e		;3de3
	ld (ix+007h),d		;3de6
	ld (ix+008h),l		;3de9
	ld (ix+009h),h		;3dec
	jr l3df5h		;3def
l3df1h:
	ld (ix+00eh),000h	;3df1
l3df5h:
	ld a,(ix+00ah)		;3df5
	or a			;3df8
	jr nz,l3e0ch		;3df9

	ld a,(ix+006h)		;3dfb
	or (ix+007h)		;3dfe
	or (ix+008h)		;3e01
	or (ix+009h)		;3e04
	jr nz,l3e0ch		;3e07
	inc (ix+00ah)		;3e09
l3e0ch:
	push ix			;3e0c
	pop de			;3e0e
	ld hl,0ffffh		;3e0f
	add hl,de		;3e12
	push hl			;3e13
	pop iy			;3e14
	jr l3e56h		;3e16
l3e18h:
	ld a,(ix+010h)		;3e18
	ld hl,00000h		;3e1b
	ld d,l			;3e1e
	ld e,a			;3e1f
	push hl			;3e20
	push de			;3e21
	ld e,(ix+006h)		;3e22
	ld d,(ix+007h)		;3e25
	ld l,(ix+008h)		;3e28
	ld h,(ix+009h)		;3e2b
	call llmod:		;3e2e
	ex de,hl		;3e31
	ld de,l4734h		;3e32
	add hl,de		;3e35
	ld l,(hl)		;3e36
	ld de,0ffffh		;3e37
	add iy,de		;3e3a
	ld (iy+000h),l		;3e3c
	ld a,(ix+010h)		;3e3f
	ld hl,00000h		;3e42
	ld d,l			;3e45
	ld e,a			;3e46
	push hl			;3e47
	push de			;3e48
	push ix			;3e49
	pop de			;3e4b
	ld hl,00006h		;3e4c
	add hl,de		;3e4f
	call aslldiv		;3e50
	dec (ix+00ah)		;3e53
l3e56h:
	ld a,(ix+006h)		;3e56
	or (ix+007h)		;3e59
	or (ix+008h)		;3e5c
	or (ix+009h)		;3e5f
	jr nz,l3e18h		;3e62
	ld a,(ix+00ah)		;3e64
	ld e,a			;3e67
	rla			;3e68
	sbc a,a			;3e69
	ld d,a			;3e6a
	ld hl,00000h		;3e6b
	call wrelop		;3e6e
	jp m,l3e18h		;3e71

	push ix			;3e74
	pop de			;3e76
	ld hl,0ffffh		;3e77
	add hl,de		;3e7a
	push iy			;3e7b
	pop de			;3e7d
	or a			;3e7e
	sbc hl,de		;3e7f
	ld e,(ix+00eh)		;3e81
	ld d,000h		;3e84
	add hl,de		;3e86
	ld (ix+00ah),l		;3e87
	ld (ix-001h),l		;3e8a
	ld e,(ix+00ch)		;3e8d
	ld l,(ix-001h)		;3e90
	ld h,d			;3e93
	call wrelop		;3e94
	jr nc,l3eafh		;3e97

	ld a,(ix+00ch)		;3e99
	ld (ix-001h),a		;3e9c
	jr l3eafh		;3e9f
l3ea1h:
	ld hl,00020h		;3ea1
	push hl			;3ea4
	ld l,(ix+012h)		;3ea5
	ld h,(ix+013h)		;3ea8
	call indir		;3eab
	pop bc			;3eae
l3eafh:
	ld b,(ix+00ch)		;3eaf
	dec (ix+00ch)		;3eb2
	ld a,(ix+00ah)		;3eb5
	call brelop		;3eb8
	jp m,l3ea1h		;3ebb

	ld a,(ix+00eh)		;3ebe
	or a			;3ec1
	jr z,l3eebh		;3ec2

	ld hl,0002dh		;3ec4
	push hl			;3ec7
	ld l,(ix+012h)		;3ec8
	ld h,(ix+013h)		;3ecb
	call indir		;3ece
	pop bc			;3ed1
	dec (ix+00ah)		;3ed2
	jr l3eebh		;3ed5
l3ed7h:
	ld a,(iy+000h)		;3ed7
	inc iy			;3eda
	ld l,a			;3edc
	rla			;3edd
	sbc a,a			;3ede
	ld h,a			;3edf
	push hl			;3ee0
	ld l,(ix+012h)		;3ee1
	ld h,(ix+013h)		;3ee4
	call indir		;3ee7
	pop bc			;3eea
l3eebh:
	ld a,(ix+00ah)		;3eeb
	dec (ix+00ah)		;3eee
	or a			;3ef1
	jr nz,l3ed7h		;3ef2

	ld l,(ix-001h)		;3ef4
	ld h,000h		;3ef7
	jp cret			;3ef9


; =============== F U N C T I O N =======================================
;	From library?
;
lregset:
	pop bc			;3efc
	exx			;3efd
	pop bc			;3efe
	pop de			;3eff
	exx			;3f00
	ex de,hl		;3f01
	ex (sp),hl		;3f02
	ex de,hl		;3f03
	exx			;3f04
	push bc			;3f05
	pop hl			;3f06
	ex (sp),hl		;3f07
	exx			;3f08
	push bc			;3f09
	ret			;3f0a


; =============== F U N C T I O N =======================================
;	From library?
;
iregset:
	pop de			;3f0b
	call lregset		;3f0c
	push hl			;3f0f
	ex (sp),iy		;3f10
	ld h,(iy+003h)		;3f12
	ld l,(iy+002h)		;3f15
	exx			;3f18
	push hl			;3f19
	ld h,(iy+001h)		;3f1a
	ld l,(iy+000h)		;3f1d
	exx			;3f20
	ret			;3f21


; =============== F U N C T I O N =======================================
;	From library?
;
sgndiv:
	call negif		;3f22
	exx			;3f25
	ex de,hl		;3f26
	exx			;3f27
	ex de,hl		;3f28
	call negif		;3f29
	ex de,hl		;3f2c
	exx			;3f2d
	ex de,hl		;3f2e
	exx			;3f2f
	jp divide		;3f30
	call iregset		;3f33
	call dosdiv		;3f36
store:
	ld (iy+000h),e		;3f39
	ld (iy+001h),d		;3f3c
	ld (iy+002h),l		;3f3f
	ld (iy+003h),h		;3f42
	pop iy			;3f45
	ret			;3f47


; =============== F U N C T I O N =======================================
;
;	lldiv	From library
;
lldiv:
	call lregset		;3f48


; =============== F U N C T I O N =======================================
;
;	dosdiv	From library
;
dosdiv:
	ld a,h			;3f4b
	xor d			;3f4c
	ex af,af'		;3f4d
	call sgndiv		;3f4e
	ex af,af'		;3f51
	push bc			;3f52
	exx			;3f53
	pop hl			;3f54
	ld e,c			;3f55
	ld d,b			;3f56
	jp m,negat		;3f57
	ret			;3f5a
; =============== F U N C T I O N =======================================
;
;	lldiv	From library
;
lldiv:
	call lregset		;3f5b


; =============== F U N C T I O N =======================================
;
;	doudiv	From library
;
doudiv:
	call divide		;3f5e
	push bc			;3f61
	exx			;3f62
	pop hl			;3f63
	ld e,c			;3f64
	ld d,b			;3f65
	ret			;3f66


; =============== F U N C T I O N =======================================
;
;	aslldiv	From library
;
aslldiv:
	call iregset		;3f67
	call doudiv		;3f6a
	jr store		;3f6d

	call lregset		;3f6f


; =============== F U N C T I O N =======================================
;
;	dosrem	From library
;
dosrem:
	ld a,h			;3f72
	ex af,af'		;3f73
	call sgndiv		;3f74
	push hl			;3f77
	exx			;3f78
	pop de			;3f79
	ex de,hl		;3f7a
	ex af,af'		;3f7b
	or a			;3f7c
	jp m,negat		;3f7d
	ret			;3f80

; =============== F U N C T I O N =======================================
;
;	asalmod	From library
;
asalmod: 
	call iregset		;3f81
	call dosrem		;3f84
	jr store		;3f87


; =============== F U N C T I O N =======================================
;
;	llmod	From library
;
llmod:
	call lregset		;3f89


; =============== F U N C T I O N =======================================
;
;	dourem	From library
;
dourem:
	call divide		;3f8c
	push hl			;3f8f
	exx			;3f90
	pop de			;3f91
	ex de,hl		;3f92
	ret			;3f93


; =============== F U N C T I O N =======================================
;
;	asllmod	From library
;
asllmod:
	call iregset		;3f94
	call dourem		;3f97
	jr store		;3f9a


; =============== F U N C T I O N =======================================
;
; Negate the long in HL/DE
;
negat:
	push hl			;3f9c
	ld hl,00000h		;3f9d
	or a			;3fa0
	sbc hl,de		;3fa1
	ex de,hl		;3fa3
	pop bc			;3fa4
	ld hl,00000h		;3fa5
	sbc hl,bc		;3fa8
	ret			;3faa


; =============== F U N C T I O N =======================================
;
; called with high word in HL, low word in HL'
; returns with positive value
;
negif:
	bit 7,h			;3fab
	ret z			;3fad
	exx			;3fae
	ld c,l			;3faf
	ld b,h			;3fb0
	ld hl,00000h		;3fb1
	or a			;3fb4
	sbc hl,bc		;3fb5
	exx			;3fb7
	ld c,l			;3fb8
	ld b,h			;3fb9
	ld hl,00000h		;3fba
	sbc hl,bc		;3fbd
	ret			;3fbf

; =============== F U N C T I O N =======================================
; Called with dividend in HL/HL', divisor in DE/DE', high words in
; selected register set
; returns with quotient in BC/BC', remainder in HL/HL', high words
; selected
;
divide:
	ld bc,00000h		;3fc0
	ld a,e			;3fc3
	or d			;3fc4
	exx			;3fc5
	ld bc,00000h		;3fc6
	or e			;3fc9
	or d			;3fca
	exx			;3fcb
	ret z			;3fcc
	ld a,001h		;3fcd
	jr l3feah		;3fcf
l3fd1h:
	push hl			;3fd1
	exx			;3fd2
	push hl			;3fd3
	or a			;3fd4
	sbc hl,de		;3fd5
	exx			;3fd7
	sbc hl,de		;3fd8
	exx			;3fda
	pop hl			;3fdb
	exx			;3fdc
	pop hl			;3fdd
	jr c,l3feeh		;3fde
	exx			;3fe0
	inc a			;3fe1
	ex de,hl		;3fe2
	add hl,hl		;3fe3
	ex de,hl		;3fe4
	exx			;3fe5
	ex de,hl		;3fe6
	adc hl,hl		;3fe7
	ex de,hl		;3fe9
l3feah:
	bit 7,d			;3fea
	jr z,l3fd1h		;3fec
l3feeh:
	push hl			;3fee
	exx			;3fef
	push hl			;3ff0
	or a			;3ff1
	sbc hl,de		;3ff2
	exx			;3ff4
	sbc hl,de		;3ff5
	exx			;3ff7
	jr nc,l4000h		;3ff8
	pop hl			;3ffa
	exx			;3ffb
	pop hl			;3ffc
	exx			;3ffd
	jr l4004h		;3ffe
l4000h:
	inc sp			;4000
	inc sp			;4001
	inc sp			;4002
	inc sp			;4003
l4004h:
	ccf			;4004
	rl c			;4005
	rl b			;4007
	exx			;4009
	rl c			;400a
	rl b			;400c
	srl d			;400e
	rr e			;4010
	exx			;4012
	rr d			;4013
	rr e			;4015
	exx			;4017
	dec a			;4018
	jr nz,l3feeh		;4019
	ret			;401b


; =============== F U N C T I O N =======================================
;
;	movmem	From library
;
movmem:
bmove:
	pop hl			;401c
	exx			;401d
	pop hl			;401e
	pop de			;401f
	pop bc			;4020
	ld a,b			;4021
	or c			;4022
	jr z,l4027h		;4023
	ldir			;4025
l4027h:
	push bc			;4027
	push de			;4028
	push hl			;4029
	exx			;402a
	jp (hl)			;402b


; =============== F U N C T I O N =======================================
; 16 bit integer multiply	hl*de
; on entry, left operand is in hl, right operand in de
;
amul:
lmul:
	ld a,e			;402c
	ld c,d			;402d
	ex de,hl		;402e
	ld hl,00000h		;402f
	ld b,008h		;4032
	call mult8b		;4034
	ex de,hl		;4037
	jr l403bh		;4038
l403ah:
	add hl,hl		;403a
l403bh:
	djnz l403ah		;403b
	ex de,hl		;403d
	ld a,c			;403e


; =============== F U N C T I O N =======================================
;	mult8b	From library
;
mult8b:
	srl a			;403f
	jr nc,l4044h		;4041
	add hl,de		;4043
l4044h:
	ex de,hl		;4044
	add hl,hl		;4045
	ex de,hl		;4046
	ret z			;4047
	djnz mult8b		;4048
	ret			;404a


; =============== F U N C T I O N =======================================
; arithmetic long right shift
; value in HLDE, count in B
;
alrsh:
	ld a,b			;404b
	or a			;404c
	ret z			;404d
	cp 021h			;404e
	jr c,l4054h		;4050
	ld b,020h		;4052
l4054h:
	sra h			;4054
	rr l			;4056
	rr d			;4058
	rr e			;405a
	djnz l4054h		;405c
	ret			;405e


; =============== F U N C T I O N =======================================
;	_strrchr	From library
;
_strrchr:
	call rcsv		;405f
	ld bc,00000h		;4062
	jr l4069h		;4065
l4067h:
	inc hl			;4067
	inc bc			;4068
l4069h:
	ld a,(hl)		;4069
	or a			;406a
	jr nz,l4067h		;406b
l406dh:
	dec hl			;406d
	ld a,c			;406e
	or b			;406f
	jr z,l407ah		;4070
	dec bc			;4072
	ld a,(hl)		;4073
	cp e			;4074
	jr nz,l406dh		;4075
l4077h:
	jp cret			;4077

l407ah:
	ld hl,00000h		;407a
	jr l4077h		;407d

; =============== F U N C T I O N =======================================
;
; NB This brk() does not check that the argument is reasonable.
;
brk:
	pop hl			;407f
	pop de			;4080
	ld (05597h),de		;4081
	push de			;4085
	jp (hl)			;4086


; =============== F U N C T I O N =======================================
;
;	sbrk	From library
;
sbrk:
	pop bc			;4087
	pop de			;4088
	push de			;4089
	push bc			;408a
	ld hl,(05597h)		;408b
	ld a,l			;408e
	or h			;408f
	jr nz,l4098h		;4090
	ld hl,__Hbss		;4092
	ld (05597h),hl		;4095
l4098h:
	add hl,de		;4098
	jr c,l40a5h		;4099
	ld bc,00400h		;409b
	add hl,bc		;409e
	jr c,l40a5h		;409f
	sbc hl,sp		;40a1
	jr c,l40a9h		;40a3
l40a5h:
	ld hl,0ffffh		;40a5
	ret			;40a8
l40a9h:
	ld hl,(05597h)		;40a9
	push hl			;40ac
	add hl,de		;40ad
	ld (05597h),hl		;40ae
	pop hl			;40b1
	ret			;40b2

; =============== F U N C T I O N =======================================
;
; checksp
;
checksp:
	ld hl,(05597h)		;40b3
	ld bc,00080h		;40b6
	add hl,bc		;40b9
	sbc hl,sp		;40ba
	ld hl,00001h		;40bc
	ret c			;40bf
	dec hl			;40c0
	ret			;40c1


; =============== F U N C T I O N =======================================
; shift left, arithmetic or logical <<
;
; Shift operations - the count is always in B,
; the quantity to be shifted is in HL, except for the assignment
; type operations, when it is in the memory location pointed to by HL
shal:
shll:
sub_40c2h:
	ld a,b			;40c2
	or a			;40c3
	ret z			;40c4
	cp 010h			;40c5
	jr c,l40cbh		;40c7
	ld b,010h		;40c9
l40cbh:
	add hl,hl		;40cb
	djnz l40cbh		;40cc
	ret			;40ce



; =============== F U N C T I O N =======================================
;	From library?
;
;	Shift operations - the count is always in B,
;	the quantity to be shifted is in HL, except for the assignment
;	type operations, when it is in the memory location pointed to by
;	HL
shlr:
	ld a,b			;40cf
	or a			;40d0
	ret z			;40d1
	cp 010h			;40d2
	jr c,l40d8h		;40d4
	ld b,010h		;40d6
l40d8h:
	srl h			;40d8
	rr l			;40da
	djnz l40d8h		;40dc
	ret			;40de


; =============== F U N C T I O N =======================================
;
;	strcmp	From library
;
strcmp:
	pop bc			;40df
	pop de			;40e0
	pop hl			;40e1
	push hl			;40e2
	push de			;40e3
	push bc			;40e4
l40e5h:
	ld a,(de)		;40e5
	cp (hl)			;40e6
	jr nz,l40f2h		;40e7
	inc de			;40e9
	inc hl			;40ea
	or a			;40eb
	jr nz,l40e5h		;40ec
	ld hl,00000h		;40ee
	ret			;40f1
l40f2h:
	ld hl,00001h		;40f2
	ret nc			;40f5
	dec hl			;40f6
	dec hl			;40f7
	ret			;40f8


; =============== F U N C T I O N =======================================
;
;	strcpy	From library
;
strcpy:
	pop bc			;40f9
	pop de			;40fa
	pop hl			;40fb
	push hl			;40fc
	push de			;40fd
	push bc			;40fe
	ld c,e			;40ff
	ld b,d			;4100
l4101h:
	ld a,(hl)		;4101
	ld (de),a		;4102
	inc de			;4103
	inc hl			;4104
	or a			;4105
	jr nz,l4101h		;4106
	ld l,c			;4108
	ld h,b			;4109
	ret			;410a


; =============== F U N C T I O N =======================================
;
;	strlen	From library
;
strlen:
	pop hl			;410b
	pop de			;410c
	push de			;410d
	push hl			;410e
	ld hl,00000h		;410f
l4112h:
	ld a,(de)		;4112
	or a			;4113
	ret z			;4114
	inc hl			;4115
	inc de			;4116
	jr l4112h		;4117


; =============== F U N C T I O N =======================================
;
;	csv	From library
;
csv:
	pop hl			;4119
	push iy			;411a
	push ix			;411c
	ld ix,00000h		;411e
	add ix,sp		;4122
	jp (hl)			;4124


; =============== F U N C T I O N =======================================
;
;	cret	From library
;
cret:
	ld sp,ix		;4125
	pop ix			;4127
	pop iy			;4129
	ret			;412b


; =============== F U N C T I O N =======================================
;
;	indir	From library
;
indir:
	jp (hl)			;412c


; =============== F U N C T I O N =======================================
;
;	ncsv	From library
;
ncsv:
	pop hl			;412d
	push iy			;412e
	push ix			;4130
	ld ix,00000h		;4132
	add ix,sp		;4136
	ld e,(hl)		;4138
	inc hl			;4139
	ld d,(hl)		;413a
	inc hl			;413b
	ex de,hl		;413c
	add hl,sp		;413d
	ld sp,hl		;413e
	ex de,hl		;413f
	jp (hl)			;4140


; =============== F U N C T I O N =======================================
;
;	rcsv	From library
;
rcsv:
	ex (sp),iy		;4141
	push ix			;4143
	ld ix,00000h		;4145
	add ix,sp		;4149
	ld l,(ix+006h)		;414b
	ld h,(ix+007h)		;414e
	ld e,(ix+008h)		;4151
	ld d,(ix+009h)		;4154
	ld c,(ix+00ah)		;4157
	ld b,(ix+00bh)		;415a
	jp (iy)			;415d


data:

; BLOCK 'data_415f' (start 0x415f end 0x4780)
data_415f_start:
	defb 000h		;415f	00 	. 
l4160h:
	defb 064h		;4160	64 	d	"delete what ?"
	defb 065h		;4161	65 	e 
	defb 06ch		;4162	6c 	l 
	defb 065h		;4163	65 	e 
	defb 074h		;4164	74 	t 
	defb 065h		;4165	65 	e 
	defb 020h		;4166	20 	  
	defb 077h		;4167	77 	w 
	defb 068h		;4168	68 	h 
	defb 061h		;4169	61 	a 
	defb 074h		;416a	74 	t 
	defb 020h		;416b	20 	  
	defb 03fh		;416c	3f 	? 
	defb 000h		;416d	00 	. 
l416eh:
	defb 06ch		;416e	6c 	l	"libtmp.$$$"
	defb 069h		;416f	69 	i 
	defb 062h		;4170	62 	b 
	defb 074h		;4171	74 	t 
	defb 06dh		;4172	6d 	m 
	defb 070h		;4173	70 	p 
	defb 02eh		;4174	2e 	. 
	defb 024h		;4175	24 	$ 
	defb 024h		;4176	24 	$ 
	defb 024h		;4177	24 	$ 
	defb 000h		;4178	00 	. 
l4179h:
	defb 077h		;4179	77 	w	"wb"
	defb 062h		;417a	62 	b 
	defb 000h		;417b	00 	. 
l417ch:
	defb 057h		;417c	57 	W	"Write error on %s file"
	defb 072h		;417d	72 	r 
	defb 069h		;417e	69 	i 
	defb 074h		;417f	74 	t 
	defb 065h		;4180	65 	e 
	defb 020h		;4181	20 	  
	defb 065h		;4182	65 	e 
	defb 072h		;4183	72 	r 
	defb 072h		;4184	72 	r 
	defb 06fh		;4185	6f 	o 
	defb 072h		;4186	72 	r 
	defb 020h		;4187	20 	  
	defb 06fh		;4188	6f 	o 
	defb 06eh		;4189	6e 	n 
	defb 020h		;418a	20 	  
	defb 025h		;418b	25 	% 
	defb 073h		;418c	73 	s 
	defb 020h		;418d	20 	  
	defb 066h		;418e	66 	f 
	defb 069h		;418f	69 	i 
	defb 06ch		;4190	6c 	l 
	defb 065h		;4191	65 	e 
	defb 000h		;4192	00 	. 
l4193h:
	defb 074h		;4193	74 	t	"temp"
	defb 065h		;4194	65 	e 
	defb 06dh		;4195	6d 	m 
	defb 070h		;4196	70 	p 
	defb 000h		;4197	00 	. 
l4198h:
	defb 06fh		;4198	6f 	o	"output"
	defb 075h		;4199	75 	u 
	defb 074h		;419a	74 	t 
	defb 070h		;419b	70 	p 
	defb 075h		;419c	75 	u 
	defb 074h		;419d	74 	t 
	defb 000h		;419e	00 	. 
l419fh:
	defb 072h		;419f	72 	r	"rb"
	defb 062h		;41a0	62 	b 
	defb 000h		;41a1	00 	. 
l41a2h:
	defb 02eh		;41a2	2e 	.	".lib"
	defb 06ch		;41a3	6c 	l 
	defb 069h		;41a4	69 	i 
	defb 062h		;41a5	62 	b 
	defb 000h		;41a6	00 	. 
l41a7h:
	defb 02eh		;41a7	2e 	.	".LIB"
	defb 04ch		;41a8	4c 	L 
	defb 049h		;41a9	49 	I 
	defb 042h		;41aa	42 	B 
	defb 000h		;41ab	00 	. 
l41ach:
	defb 06ch		;41ac	6c 	l	"library file names should have .lib extension: %s"
	defb 069h		;41ad	69 	i 
	defb 062h		;41ae	62 	b 
	defb 072h		;41af	72 	r 
	defb 061h		;41b0	61 	a 
	defb 072h		;41b1	72 	r 
	defb 079h		;41b2	79 	y 
	defb 020h		;41b3	20 	  
	defb 066h		;41b4	66 	f 
	defb 069h		;41b5	69 	i 
	defb 06ch		;41b6	6c 	l 
	defb 065h		;41b7	65 	e 
	defb 020h		;41b8	20 	  
	defb 06eh		;41b9	6e 	n 
	defb 061h		;41ba	61 	a 
	defb 06dh		;41bb	6d 	m 
	defb 065h		;41bc	65 	e 
	defb 073h		;41bd	73 	s 
	defb 020h		;41be	20 	  
	defb 073h		;41bf	73 	s 
	defb 068h		;41c0	68 	h 
	defb 06fh		;41c1	6f 	o 
	defb 075h		;41c2	75 	u 
	defb 06ch		;41c3	6c 	l 
	defb 064h		;41c4	64 	d 
	defb 020h		;41c5	20 	  
	defb 068h		;41c6	68 	h 
	defb 061h		;41c7	61 	a 
	defb 076h		;41c8	76 	v 
	defb 065h		;41c9	65 	e 
	defb 020h		;41ca	20 	  
	defb 02eh		;41cb	2e 	. 
	defb 06ch		;41cc	6c 	l 
	defb 069h		;41cd	69 	i 
	defb 062h		;41ce	62 	b 
	defb 020h		;41cf	20 	  
	defb 065h		;41d0	65 	e 
	defb 078h		;41d1	78 	x 
	defb 074h		;41d2	74 	t 
	defb 065h		;41d3	65 	e 
	defb 06eh		;41d4	6e 	n 
	defb 073h		;41d5	73 	s 
	defb 069h		;41d6	69 	i 
	defb 06fh		;41d7	6f 	o 
	defb 06eh		;41d8	6e 	n 
	defb 03ah		;41d9	3a 	: 
	defb 020h		;41da	20 	  
	defb 025h		;41db	25 	% 
	defb 073h		;41dc	73 	s 
	defb 000h		;41dd	00 	. 
l41deh:
	defb 072h		;41de	72 	r	"rb"
	defb 062h		;41df	62 	b 
	defb 000h		;41e0	00 	. 
l41e1h:
	defb 072h		;41e1	72 	r	"rb"
	defb 062h		;41e2	62 	b 
	defb 000h		;41e3	00 	. 
l41e4h:
	defb 077h		;41e4	77 	w	"wb"
	defb 062h		;41e5	62 	b 
	defb 000h		;41e6	00 	. 
l41e7h:
	defb 077h		;41e7	77 	w	"wb"
	defb 062h		;41e8	62 	b 
	defb 000h		;41e9	00 	. 
l41eah:
	defb 072h		;41ea	72 	r	"rb"
	defb 062h		;41eb	62 	b 
	defb 000h		;41ec	00 	. 
l41edh:
	defb 075h		;41ed	75 	u	"unexpected end of file"
	defb 06eh		;41ee	6e 	n 
	defb 065h		;41ef	65 	e 
	defb 078h		;41f0	78 	x 
	defb 070h		;41f1	70 	p 
	defb 065h		;41f2	65 	e 
	defb 063h		;41f3	63 	c 
	defb 074h		;41f4	74 	t 
	defb 065h		;41f5	65 	e 
	defb 064h		;41f6	64 	d 
	defb 020h		;41f7	20 	  
	defb 065h		;41f8	65 	e 
	defb 06eh		;41f9	6e 	n 
	defb 064h		;41fa	64 	d 
	defb 020h		;41fb	20 	  
	defb 06fh		;41fc	6f 	o 
	defb 066h		;41fd	66 	f 
	defb 020h		;41fe	20 	  
	defb 066h		;41ff	66 	f 
	defb 069h		;4200	69 	i 
	defb 06ch		;4201	6c 	l 
	defb 065h		;4202	65 	e 
	defb 000h		;4203	00 	. 

arry_4204:
	defb 044h		;4204	44 	D	"D?C???U"
	defb 03fh		;4205	3f 	? 

	defb 043h		;4206	43 	C 
	defb 03fh		;4207	3f 	? 

	defb 03fh		;4208	3f 	? 
	defb 03fh		;4209	3f 	? 

	defb 055h		;420a	55 	U 
	defb 000h		;420b	00 	. 

l420ch:
	defb 053h		;420c	53 	S	"Subkeys: d(defined) u(ndefined)"
	defb 075h		;420d	75 	u 
	defb 062h		;420e	62 	b 
	defb 06bh		;420f	6b 	k 
	defb 065h		;4210	65 	e 
	defb 079h		;4211	79 	y 
	defb 073h		;4212	73 	s 
	defb 03ah		;4213	3a 	: 
	defb 020h		;4214	20 	  
	defb 064h		;4215	64 	d 
	defb 028h		;4216	28 	( 
	defb 064h		;4217	64 	d 
	defb 065h		;4218	65 	e 
	defb 066h		;4219	66 	f 
	defb 069h		;421a	69 	i 
	defb 06eh		;421b	6e 	n 
	defb 065h		;421c	65 	e 
	defb 064h		;421d	64 	d 
	defb 029h		;421e	29 	) 
	defb 020h		;421f	20 	  
	defb 075h		;4220	75 	u 
	defb 028h		;4221	28 	( 
	defb 06eh		;4222	6e 	n 
	defb 064h		;4223	64 	d 
	defb 065h		;4224	65 	e 
	defb 066h		;4225	66 	f 
	defb 069h		;4226	69 	i 
	defb 06eh		;4227	6e 	n 
	defb 065h		;4228	65 	e 
	defb 064h		;4229	64 	d 
	defb 029h		;422a	29 	) 
	defb 000h		;422b	00 	. 
l422ch:
	defb 025h		;422c	25 	%	"%-15.15s"
	defb 02dh		;422d	2d 	- 
	defb 031h		;422e	31 	1 
	defb 035h		;422f	35 	5 
	defb 02eh		;4230	2e 	. 
	defb 031h		;4231	31 	1 
	defb 035h		;4232	35 	5 
	defb 073h		;4233	73 	s 
	defb 000h		;4234	00 	. 
l4235h:
	defb 020h		;4235	20 	 	" %c"
	defb 025h		;4236	25 	% 
	defb 063h		;4237	63 	c 
	defb 000h		;4238	00 	. 
l4239h:
	defb 009h		;4239	09 	.	"\t\t"
	defb 009h		;423a	09 	. 
	defb 000h		;423b	00 	. 
l423ch:
	defb 025h		;423c	25 	%	"%c %-12.12s"
	defb 063h		;423d	63 	c 
	defb 020h		;423e	20 	  
	defb 025h		;423f	25 	% 
	defb 02dh		;4240	2d 	- 
	defb 031h		;4241	31 	1 
	defb 032h		;4242	32 	2 
	defb 02eh		;4243	2e 	. 
	defb 031h		;4244	31 	1 
	defb 032h		;4245	32 	2 
	defb 073h		;4246	73 	s 
	defb 000h		;4247	00 	. 
l4248h:
	defb 00ah		;4248	0a 	.	"\n"
	defb 000h		;4249	00 	. 
l424ah:
	defb 020h		;424a	20 	 	"  "
	defb 020h		;424b	20 	  
	defb 000h		;424c	00 	. 
l424dh:
	defb 025h		;424d	25 	%	"%-16.15s"
	defb 02dh		;424e	2d 	- 
	defb 031h		;424f	31 	1 
	defb 036h		;4250	36 	6 
	defb 02eh		;4251	2e 	. 
	defb 031h		;4252	31 	1 
	defb 035h		;4253	35 	5 
	defb 073h		;4254	73 	s 
	defb 000h		;4255	00 	. 

word_4256:
	defb 050h		;4256	50 	P	"P"
	defb 000h		;4257	00 	. 

arry_4258:
	defb 072h		;4258	72 	r 	"rdxms"
	defb 064h		;4259	64 	d 
	defb 078h		;425a	78 	x 
	defb 06dh		;425b	6d 	m 
	defb 073h		;425c	73 	s 
	defb 000h		;425d	00 	. 

msg_425e:
	defb 055h		;425e	55 	U	"Usage: libr [-w][-pwidth] key [subkeys symbol] file.lib [modules ...]"
	defb 073h		;425f	73 	s 
	defb 061h		;4260	61 	a 
	defb 067h		;4261	67 	g 
	defb 065h		;4262	65 	e 
	defb 03ah		;4263	3a 	: 
	defb 020h		;4264	20 	  
	defb 06ch		;4265	6c 	l 
	defb 069h		;4266	69 	i 
	defb 062h		;4267	62 	b 
	defb 072h		;4268	72 	r 
	defb 020h		;4269	20 	  
	defb 05bh		;426a	5b 	[ 
	defb 02dh		;426b	2d 	- 
	defb 077h		;426c	77 	w 
	defb 05dh		;426d	5d 	] 
	defb 05bh		;426e	5b 	[ 
	defb 02dh		;426f	2d 	- 
	defb 070h		;4270	70 	p 
	defb 077h		;4271	77 	w 
	defb 069h		;4272	69 	i 
	defb 064h		;4273	64 	d 
	defb 074h		;4274	74 	t 
	defb 068h		;4275	68 	h 
	defb 05dh		;4276	5d 	] 
	defb 020h		;4277	20 	  
	defb 06bh		;4278	6b 	k 
	defb 065h		;4279	65 	e 
	defb 079h		;427a	79 	y 
	defb 020h		;427b	20 	  
	defb 05bh		;427c	5b 	[ 
	defb 073h		;427d	73 	s 
	defb 075h		;427e	75 	u 
	defb 062h		;427f	62 	b 
	defb 06bh		;4280	6b 	k 
	defb 065h		;4281	65 	e 
	defb 079h		;4282	79 	y 
	defb 073h		;4283	73 	s 
	defb 020h		;4284	20 	  
	defb 073h		;4285	73 	s 
	defb 079h		;4286	79 	y 
	defb 06dh		;4287	6d 	m 
	defb 062h		;4288	62 	b 
	defb 06fh		;4289	6f 	o 
	defb 06ch		;428a	6c 	l 
	defb 05dh		;428b	5d 	] 
	defb 020h		;428c	20 	  
	defb 066h		;428d	66 	f 
	defb 069h		;428e	69 	i 
	defb 06ch		;428f	6c 	l 
	defb 065h		;4290	65 	e 
	defb 02eh		;4291	2e 	. 
	defb 06ch		;4292	6c 	l 
	defb 069h		;4293	69 	i 
	defb 062h		;4294	62 	b 
	defb 020h		;4295	20 	  
	defb 05bh		;4296	5b 	[ 
	defb 06dh		;4297	6d 	m 
	defb 06fh		;4298	6f 	o 
	defb 064h		;4299	64 	d 
	defb 075h		;429a	75 	u 
	defb 06ch		;429b	6c 	l 
	defb 065h		;429c	65 	e 
	defb 073h		;429d	73 	s 
	defb 020h		;429e	20 	  
	defb 02eh		;429f	2e 	. 
	defb 02eh		;42a0	2e 	. 
	defb 02eh		;42a1	2e 	. 
	defb 05dh		;42a2	5d 	] 
	defb 000h		;42a3	00 	. 
l42a4h:
	defb 04bh		;42a4	4b 	K	"Keys: r(eplace), d(elete), (e)x(tract), m(odules), s(ymbols)"
	defb 065h		;42a5	65 	e 
	defb 079h		;42a6	79 	y 
	defb 073h		;42a7	73 	s 
	defb 03ah		;42a8	3a 	: 
	defb 020h		;42a9	20 	  
	defb 072h		;42aa	72 	r 
	defb 028h		;42ab	28 	( 
	defb 065h		;42ac	65 	e 
	defb 070h		;42ad	70 	p 
	defb 06ch		;42ae	6c 	l 
	defb 061h		;42af	61 	a 
	defb 063h		;42b0	63 	c 
	defb 065h		;42b1	65 	e 
	defb 029h		;42b2	29 	) 
	defb 02ch		;42b3	2c 	, 
	defb 020h		;42b4	20 	  
	defb 064h		;42b5	64 	d 
	defb 028h		;42b6	28 	( 
	defb 065h		;42b7	65 	e 
	defb 06ch		;42b8	6c 	l 
	defb 065h		;42b9	65 	e 
	defb 074h		;42ba	74 	t 
	defb 065h		;42bb	65 	e 
	defb 029h		;42bc	29 	) 
	defb 02ch		;42bd	2c 	, 
	defb 020h		;42be	20 	  
	defb 028h		;42bf	28 	( 
	defb 065h		;42c0	65 	e 
	defb 029h		;42c1	29 	) 
	defb 078h		;42c2	78 	x 
	defb 028h		;42c3	28 	( 
	defb 074h		;42c4	74 	t 
	defb 072h		;42c5	72 	r 
	defb 061h		;42c6	61 	a 
	defb 063h		;42c7	63 	c 
	defb 074h		;42c8	74 	t 
	defb 029h		;42c9	29 	) 
	defb 02ch		;42ca	2c 	, 
	defb 020h		;42cb	20 	  
	defb 06dh		;42cc	6d 	m 
	defb 028h		;42cd	28 	( 
	defb 06fh		;42ce	6f 	o 
	defb 064h		;42cf	64 	d 
	defb 075h		;42d0	75 	u 
	defb 06ch		;42d1	6c 	l 
	defb 065h		;42d2	65 	e 
	defb 073h		;42d3	73 	s 
	defb 029h		;42d4	29 	) 
	defb 02ch		;42d5	2c 	, 
	defb 020h		;42d6	20 	  
	defb 073h		;42d7	73 	s 
	defb 028h		;42d8	28 	( 
	defb 079h		;42d9	79 	y 
	defb 06dh		;42da	6d 	m 
	defb 062h		;42db	62 	b 
	defb 06fh		;42dc	6f 	o 
	defb 06ch		;42dd	6c 	l 
	defb 073h		;42de	73 	s 
	defb 029h		;42df	29 	) 
	defb 000h		;42e0	00 	. 


l42e1h:
  sub_175ah
	defb 05ah		;42e1	5a 	Z 
	defb 017h		;42e2	17 	. 
  sub_02e5h
	defb 0e5h		;42e3	e5 	. 
	defb 002h		;42e4	02 	. 
  sub_0337h
	defb 037h		;42e5	37 	7 
	defb 003h		;42e6	03 	. 
  sub_0df2h
	defb 0f2h		;42e7	f2 	. 
	defb 00dh		;42e8	0d 	. 
  sub_0f0dh
	defb 00dh		;42e9	0d 	. 
	defb 00fh		;42ea	0f 	. 



l42ebh:
	defb 06ch		;42eb	6c 	l	"libr"
	defb 069h		;42ec	69 	i 
	defb 062h		;42ed	62 	b 
	defb 072h		;42ee	72 	r 
	defb 000h		;42ef	00 	. 

arry_42f0:
	defb 000h		;42f0	00 	. 

l42f1h:
	defb 043h		;42f1	43 	C	"Can't open %s\n"
	defb 061h		;42f2	61 	a 
	defb 06eh		;42f3	6e 	n 
	defb 027h		;42f4	27 	' 
	defb 074h		;42f5	74 	t 
	defb 020h		;42f6	20 	  
	defb 06fh		;42f7	6f 	o 
	defb 070h		;42f8	70 	p 
	defb 065h		;42f9	65 	e 
	defb 06eh		;42fa	6e 	n 
	defb 020h		;42fb	20 	  
	defb 025h		;42fc	25 	% 
	defb 073h		;42fd	73 	s 
	defb 00ah		;42fe	0a 	. 
	defb 000h		;42ff	00 	. 
l4300h:
	defb 053h		;4300	53 	S	"Seek error on %s\n"
	defb 065h		;4301	65 	e 
	defb 065h		;4302	65 	e 
	defb 06bh		;4303	6b 	k 
	defb 020h		;4304	20 	  
	defb 065h		;4305	65 	e 
	defb 072h		;4306	72 	r 
	defb 072h		;4307	72 	r 
	defb 06fh		;4308	6f 	o 
	defb 072h		;4309	72 	r 
	defb 020h		;430a	20 	  
	defb 06fh		;430b	6f 	o 
	defb 06eh		;430c	6e 	n 
	defb 020h		;430d	20 	  
	defb 025h		;430e	25 	% 
	defb 073h		;430f	73 	s 
	defb 00ah		;4310	0a 	. 
	defb 000h		;4311	00 	. 
l4312h:
	defb 020h		;4312	20 	 	" (warning)\n"
	defb 028h		;4313	28 	( 
	defb 077h		;4314	77 	w 
	defb 061h		;4315	61 	a 
	defb 072h		;4316	72 	r 
	defb 06eh		;4317	6e 	n 
	defb 069h		;4318	69 	i 
	defb 06eh		;4319	6e 	n 
	defb 067h		;431a	67 	g 
	defb 029h		;431b	29 	) 
	defb 00ah		;431c	0a 	. 
	defb 000h		;431d	00 	. 
l431eh:
	defb 062h		;431e	62 	b	"bad file format: %s\n"
	defb 061h		;431f	61 	a 
	defb 064h		;4320	64 	d 
	defb 020h		;4321	20 	  
	defb 066h		;4322	66 	f 
	defb 069h		;4323	69 	i 
	defb 06ch		;4324	6c 	l 
	defb 065h		;4325	65 	e 
	defb 020h		;4326	20 	  
	defb 066h		;4327	66 	f 
	defb 06fh		;4328	6f 	o 
	defb 072h		;4329	72 	r 
	defb 06dh		;432a	6d 	m 
	defb 061h		;432b	61 	a 
	defb 074h		;432c	74 	t 
	defb 03ah		;432d	3a 	: 
	defb 020h		;432e	20 	  
	defb 025h		;432f	25 	% 
	defb 073h		;4330	73 	s 
	defb 00ah		;4331	0a 	. 
	defb 000h		;4332	00 	. 
l4333h:
	defb 06eh		;4333	6e 	n	"no such module: %s"
	defb 06fh		;4334	6f 	o 
	defb 020h		;4335	20 	  
	defb 073h		;4336	73 	s 
	defb 075h		;4337	75 	u 
	defb 063h		;4338	63 	c 
	defb 068h		;4339	68 	h 
	defb 020h		;433a	20 	  
	defb 06dh		;433b	6d 	m 
	defb 06fh		;433c	6f 	o 
	defb 064h		;433d	64 	d 
	defb 075h		;433e	75 	u 
	defb 06ch		;433f	6c 	l 
	defb 065h		;4340	65 	e 
	defb 03ah		;4341	3a 	: 
	defb 020h		;4342	20 	  
	defb 025h		;4343	25 	% 
	defb 073h		;4344	73 	s 
	defb 000h		;4345	00 	. 
l4346h:
	defb 043h		;4346	43 	C	"Cannot get memory"
	defb 061h		;4347	61 	a 
	defb 06eh		;4348	6e 	n 
	defb 06eh		;4349	6e 	n 
	defb 06fh		;434a	6f 	o 
	defb 074h		;434b	74 	t 
	defb 020h		;434c	20 	  
	defb 067h		;434d	67 	g 
	defb 065h		;434e	65 	e 
	defb 074h		;434f	74 	t 
	defb 020h		;4350	20 	  
	defb 06dh		;4351	6d 	m 
	defb 065h		;4352	65 	e 
	defb 06dh		;4353	6d 	m 
	defb 06fh		;4354	6f 	o 
	defb 072h		;4355	72 	r 
	defb 079h		;4356	79 	y 
	defb 000h		;4357	00 	. 


arry_4358:
	defb 000h		;4358	00 	. 
	defb 001h		;4359	01 	. 
	defb 002h		;435a	02 	. 
	defb 003h		;435b	03 	. 

arry_435c:
	defb 000h		;435c	00 	. 

l435dh:
	defb 001h		;435d	01 	. 

l435eh:
	defb 069h		;435e	69 	i	"incomplete ident record"
	defb 06eh		;435f	6e 	n 
	defb 063h		;4360	63 	c 
	defb 06fh		;4361	6f 	o 
	defb 06dh		;4362	6d 	m 
	defb 070h		;4363	70 	p 
	defb 06ch		;4364	6c 	l 
	defb 065h		;4365	65 	e 
	defb 074h		;4366	74 	t 
	defb 065h		;4367	65 	e 
	defb 020h		;4368	20 	  
	defb 069h		;4369	69 	i 
	defb 064h		;436a	64 	d 
	defb 065h		;436b	65 	e 
	defb 06eh		;436c	6e 	n 
	defb 074h		;436d	74 	t 
	defb 020h		;436e	20 	  
	defb 072h		;436f	72 	r 
	defb 065h		;4370	65 	e 
	defb 063h		;4371	63 	c 
	defb 06fh		;4372	6f 	o 
	defb 072h		;4373	72 	r 
	defb 064h		;4374	64 	d 
	defb 000h		;4375	00 	. 
l4376h:
	defb 069h		;4376	69 	i	"ident records do not match"
	defb 064h		;4377	64 	d 
	defb 065h		;4378	65 	e 
	defb 06eh		;4379	6e 	n 
	defb 074h		;437a	74 	t 
	defb 020h		;437b	20 	  
	defb 072h		;437c	72 	r 
	defb 065h		;437d	65 	e 
	defb 063h		;437e	63 	c 
	defb 06fh		;437f	6f 	o 
	defb 072h		;4380	72 	r 
	defb 064h		;4381	64 	d 
	defb 073h		;4382	73 	s 
	defb 020h		;4383	20 	  
	defb 064h		;4384	64 	d 
	defb 06fh		;4385	6f 	o 
	defb 020h		;4386	20 	  
	defb 06eh		;4387	6e 	n 
	defb 06fh		;4388	6f 	o 
	defb 074h		;4389	74 	t 
	defb 020h		;438a	20 	  
	defb 06dh		;438b	6d 	m 
	defb 061h		;438c	61 	a 
	defb 074h		;438d	74 	t 
	defb 063h		;438e	63 	c 
	defb 068h		;438f	68 	h 
	defb 000h		;4390	00 	. 
l4391h:
	defb 069h		;4391	69 	i	"ident records do not match"
	defb 064h		;4392	64 	d 
	defb 065h		;4393	65 	e 
	defb 06eh		;4394	6e 	n 
	defb 074h		;4395	74 	t 
	defb 020h		;4396	20 	  
	defb 072h		;4397	72 	r 
	defb 065h		;4398	65 	e 
	defb 063h		;4399	63 	c 
	defb 06fh		;439a	6f 	o 
	defb 072h		;439b	72 	r 
	defb 064h		;439c	64 	d 
	defb 073h		;439d	73 	s 
	defb 020h		;439e	20 	  
	defb 064h		;439f	64 	d 
	defb 06fh		;43a0	6f 	o 
	defb 020h		;43a1	20 	  
	defb 06eh		;43a2	6e 	n 
	defb 06fh		;43a3	6f 	o 
	defb 074h		;43a4	74 	t 
	defb 020h		;43a5	20 	  
	defb 06dh		;43a6	6d 	m 
	defb 061h		;43a7	61 	a 
	defb 074h		;43a8	74 	t 
	defb 063h		;43a9	63 	c 
	defb 068h		;43aa	68 	h 
	defb 000h		;43ab	00 	. 
l43ach:
	defb 054h		;43ac	54 	T	"Too many symbols in %s"
	defb 06fh		;43ad	6f 	o 
	defb 06fh		;43ae	6f 	o 
	defb 020h		;43af	20 	  
	defb 06dh		;43b0	6d 	m 
	defb 061h		;43b1	61 	a 
	defb 06eh		;43b2	6e 	n 
	defb 079h		;43b3	79 	y 
	defb 020h		;43b4	20 	  
	defb 073h		;43b5	73 	s 
	defb 079h		;43b6	79 	y 
	defb 06dh		;43b7	6d 	m 
	defb 062h		;43b8	62 	b 
	defb 06fh		;43b9	6f 	o 
	defb 06ch		;43ba	6c 	l 
	defb 073h		;43bb	73 	s 
	defb 020h		;43bc	20 	  
	defb 069h		;43bd	69 	i 
	defb 06eh		;43be	6e 	n 
	defb 020h		;43bf	20 	  
	defb 025h		;43c0	25 	% 
	defb 073h		;43c1	73 	s 
	defb 000h		;43c2	00 	. 
l43c3h:
	defb 072h		;43c3	72 	r	"rb"
	defb 062h		;43c4	62 	b 
	defb 000h		;43c5	00 	. 
l43c6h:
	defb 066h		;43c6	66 	f	"file too big"
	defb 069h		;43c7	69 	i 
	defb 06ch		;43c8	6c 	l 
	defb 065h		;43c9	65 	e 
	defb 020h		;43ca	20 	  
	defb 074h		;43cb	74 	t 
	defb 06fh		;43cc	6f 	o 
	defb 06fh		;43cd	6f 	o 
	defb 020h		;43ce	20 	  
	defb 062h		;43cf	62 	b 
	defb 069h		;43d0	69 	i 
	defb 067h		;43d1	67 	g 
	defb 000h		;43d2	00 	. 
l43d3h:
	defb 06dh		;43d3	6d 	m	"module %s defines no symbols"
	defb 06fh		;43d4	6f 	o 
	defb 064h		;43d5	64 	d 
	defb 075h		;43d6	75 	u 
	defb 06ch		;43d7	6c 	l 
	defb 065h		;43d8	65 	e 
	defb 020h		;43d9	20 	  
	defb 025h		;43da	25 	% 
	defb 073h		;43db	73 	s 
	defb 020h		;43dc	20 	  
	defb 064h		;43dd	64 	d 
	defb 065h		;43de	65 	e 
	defb 066h		;43df	66 	f 
	defb 069h		;43e0	69 	i 
	defb 06eh		;43e1	6e 	n 
	defb 065h		;43e2	65 	e 
	defb 073h		;43e3	73 	s 
	defb 020h		;43e4	20 	  
	defb 06eh		;43e5	6e 	n 
	defb 06fh		;43e6	6f 	o 
	defb 020h		;43e7	20 	  
	defb 073h		;43e8	73 	s 
	defb 079h		;43e9	79 	y 
	defb 06dh		;43ea	6d 	m 
	defb 062h		;43eb	62 	b 
	defb 06fh		;43ec	6f 	o 
	defb 06ch		;43ed	6c 	l 
	defb 073h		;43ee	73 	s 
	defb 000h		;43ef	00 	. 
l43f0h:
	defb 06eh		;43f0	6e 	n	"no end record found"
	defb 06fh		;43f1	6f 	o 
	defb 020h		;43f2	20 	  
	defb 065h		;43f3	65 	e 
	defb 06eh		;43f4	6e 	n 
	defb 064h		;43f5	64 	d 
	defb 020h		;43f6	20 	  
	defb 072h		;43f7	72 	r 
	defb 065h		;43f8	65 	e 
	defb 063h		;43f9	63 	c 
	defb 06fh		;43fa	6f 	o 
	defb 072h		;43fb	72 	r 
	defb 064h		;43fc	64 	d 
	defb 020h		;43fd	20 	  
	defb 066h		;43fe	66 	f 
	defb 06fh		;43ff	6f 	o 
	defb 075h		;4400	75 	u 
	defb 06eh		;4401	6e 	n 
	defb 064h		;4402	64 	d 
	defb 000h		;4403	00 	. 
l4404h:
	defb 075h		;4404	75 	u	"unknown record type: %d"
	defb 06eh		;4405	6e 	n 
	defb 06bh		;4406	6b 	k 
	defb 06eh		;4407	6e 	n 
	defb 06fh		;4408	6f 	o 
	defb 077h		;4409	77 	w 
	defb 06eh		;440a	6e 	n 
	defb 020h		;440b	20 	  
	defb 072h		;440c	72 	r 
	defb 065h		;440d	65 	e 
	defb 063h		;440e	63 	c 
	defb 06fh		;440f	6f 	o 
	defb 072h		;4410	72 	r 
	defb 064h		;4411	64 	d 
	defb 020h		;4412	20 	  
	defb 074h		;4413	74 	t 
	defb 079h		;4414	79 	y 
	defb 070h		;4415	70 	p 
	defb 065h		;4416	65 	e 
	defb 03ah		;4417	3a 	: 
	defb 020h		;4418	20 	  
	defb 025h		;4419	25 	% 
	defb 064h		;441a	64 	d 
	defb 000h		;441b	00 	. 
l441ch:
	defb 072h		;441c	72 	r	"record too long: %d+%d"
	defb 065h		;441d	65 	e 
	defb 063h		;441e	63 	c 
	defb 06fh		;441f	6f 	o 
	defb 072h		;4420	72 	r 
	defb 064h		;4421	64 	d 
	defb 020h		;4422	20 	  
	defb 074h		;4423	74 	t 
	defb 06fh		;4424	6f 	o 
	defb 06fh		;4425	6f 	o 
	defb 020h		;4426	20 	  
	defb 06ch		;4427	6c 	l 
	defb 06fh		;4428	6f 	o 
	defb 06eh		;4429	6e 	n 
	defb 067h		;442a	67 	g 
	defb 03ah		;442b	3a 	: 
	defb 020h		;442c	20 	  
	defb 025h		;442d	25 	% 
	defb 064h		;442e	64 	d 
	defb 02bh		;442f	2b 	+ 
	defb 025h		;4430	25 	% 
	defb 064h		;4431	64 	d 
	defb 000h		;4432	00 	. 
l4433h:
	defb 069h		;4433	69 	i	"incomplete record"
	defb 06eh		;4434	6e 	n 
	defb 063h		;4435	63 	c 
	defb 06fh		;4436	6f 	o 
	defb 06dh		;4437	6d 	m 
	defb 070h		;4438	70 	p 
	defb 06ch		;4439	6c 	l 
	defb 065h		;443a	65 	e 
	defb 074h		;443b	74 	t 
	defb 065h		;443c	65 	e 
	defb 020h		;443d	20 	  
	defb 072h		;443e	72 	r 
	defb 065h		;443f	65 	e 
	defb 063h		;4440	63 	c 
	defb 06fh		;4441	6f 	o 
	defb 072h		;4442	72 	r 
	defb 064h		;4443	64 	d 
	defb 000h		;4444	00 	. 
l4445h:
	defb 069h		;4445	69 	i	"incomplete symbol record"
	defb 06eh		;4446	6e 	n 
	defb 063h		;4447	63 	c 
	defb 06fh		;4448	6f 	o 
	defb 06dh		;4449	6d 	m 
	defb 070h		;444a	70 	p 
	defb 06ch		;444b	6c 	l 
	defb 065h		;444c	65 	e 
	defb 074h		;444d	74 	t 
	defb 065h		;444e	65 	e 
	defb 020h		;444f	20 	  
	defb 073h		;4450	73 	s 
	defb 079h		;4451	79 	y 
	defb 06dh		;4452	6d 	m 
	defb 062h		;4453	62 	b 
	defb 06fh		;4454	6f 	o 
	defb 06ch		;4455	6c 	l 
	defb 020h		;4456	20 	  
	defb 072h		;4457	72 	r 
	defb 065h		;4458	65 	e 
	defb 063h		;4459	63 	c 
	defb 06fh		;445a	6f 	o 
	defb 072h		;445b	72 	r 
	defb 064h		;445c	64 	d 
	defb 000h		;445d	00 	. 
l445eh:
	defb 072h		;445e	72 	r	"replace what ?"
	defb 065h		;445f	65 	e 
	defb 070h		;4460	70 	p 
	defb 06ch		;4461	6c 	l 
	defb 061h		;4462	61 	a 
	defb 063h		;4463	63 	c 
	defb 065h		;4464	65 	e 
	defb 020h		;4465	20 	  
	defb 077h		;4466	77 	w 
	defb 068h		;4467	68 	h 
	defb 061h		;4468	61 	a 
	defb 074h		;4469	74 	t 
	defb 020h		;446a	20 	  
	defb 03fh		;446b	3f 	? 
	defb 000h		;446c	00 	. 

l446dh:
	defb 05ch		;446d	5c 	\	"\"
	defb 000h		;446e	00 	. 
l446fh:
	defb 074h		;446f	74 	t	"too many arguments"
	defb 06fh		;4470	6f 	o 
	defb 06fh		;4471	6f 	o 
	defb 020h		;4472	20 	  
	defb 06dh		;4473	6d 	m 
	defb 061h		;4474	61 	a 
	defb 06eh		;4475	6e 	n 
	defb 079h		;4476	79 	y 
	defb 020h		;4477	20 	  
	defb 061h		;4478	61 	a 
	defb 072h		;4479	72 	r 
	defb 067h		;447a	67 	g 
	defb 075h		;447b	75 	u 
	defb 06dh		;447c	6d 	m 
	defb 065h		;447d	65 	e 
	defb 06eh		;447e	6e 	n 
	defb 074h		;447f	74 	t 
	defb 073h		;4480	73 	s 
	defb 000h		;4481	00 	. 
l4482h:
	defb 061h		;4482	61 	a	"argument too long"
	defb 072h		;4483	72 	r 
	defb 067h		;4484	67 	g 
	defb 075h		;4485	75 	u 
	defb 06dh		;4486	6d 	m 
	defb 065h		;4487	65 	e 
	defb 06eh		;4488	6e 	n 
	defb 074h		;4489	74 	t 
	defb 020h		;448a	20 	  
	defb 074h		;448b	74 	t 
	defb 06fh		;448c	6f 	o 
	defb 06fh		;448d	6f 	o 
	defb 020h		;448e	20 	  
	defb 06ch		;448f	6c 	l 
	defb 06fh		;4490	6f 	o 
	defb 06eh		;4491	6e 	n 
	defb 067h		;4492	67 	g 
	defb 000h		;4493	00 	. 
l4494h:
	defb 025h		;4494	25 	%	"%u:"
	defb 075h		;4495	75 	u 
	defb 03ah		;4496	3a 	: 
	defb 000h		;4497	00 	. 
l4498h:
	defb 03ah		;4498	3a 	:	": no match"
	defb 020h		;4499	20 	  
	defb 06eh		;449a	6e 	n 
	defb 06fh		;449b	6f 	o 
	defb 020h		;449c	20 	  
	defb 06dh		;449d	6d 	m 
	defb 061h		;449e	61 	a 
	defb 074h		;449f	74 	t 
	defb 063h		;44a0	63 	c 
	defb 068h		;44a1	68 	h 
	defb 000h		;44a2	00 	. 
l44a3h:
	defb 06eh		;44a3	6e 	n	"no name after "
	defb 06fh		;44a4	6f 	o 
	defb 020h		;44a5	20 	  
	defb 06eh		;44a6	6e 	n 
	defb 061h		;44a7	61 	a 
	defb 06dh		;44a8	6d 	m 
	defb 065h		;44a9	65 	e 
	defb 020h		;44aa	20 	  
	defb 061h		;44ab	61 	a 
	defb 066h		;44ac	66 	f 
	defb 074h		;44ad	74 	t 
	defb 065h		;44ae	65 	e 
	defb 072h		;44af	72 	r 
	defb 020h		;44b0	20 	  
	defb 000h		;44b1	00 	. 
l44b2h:
	defb 069h		;44b2	69 	i	"input"
	defb 06eh		;44b3	6e 	n 
	defb 070h		;44b4	70 	p 
	defb 075h		;44b5	75 	u 
	defb 074h		;44b6	74 	t 
	defb 000h		;44b7	00 	. 
l44b8h:
	defb 072h		;44b8	72 	r	"r"
	defb 000h		;44b9	00 	. 
l44bah:
	defb 061h		;44ba	61 	a	"a"
	defb 000h		;44bb	00 	. 
l44bch:
	defb 077h		;44bc	77 	w	"w"
	defb 000h		;44bd	00 	. 
l44beh:
	defb 06fh		;44be	6f 	o	"output"
	defb 075h		;44bf	75 	u 
	defb 074h		;44c0	74 	t 
	defb 070h		;44c1	70 	p 
	defb 075h		;44c2	75 	u 
	defb 074h		;44c3	74 	t 
	defb 000h		;44c4	00 	. 
l44c5h:
	defb 025h		;44c5	25 	%	"%s> "
	defb 073h		;44c6	73 	s 
	defb 03eh		;44c7	3e 	> 
	defb 020h		;44c8	20 	  
	defb 000h		;44c9	00 	. 
l44cah:
	defb 00ah		;44ca	0a 	.	"\n"
	defb 000h		;44cb	00 	. 
l44cch:
	defb 06eh		;44cc	6e 	n	"no room for arguments"
	defb 06fh		;44cd	6f 	o 
	defb 020h		;44ce	20 	  
	defb 072h		;44cf	72 	r 
	defb 06fh		;44d0	6f 	o 
	defb 06fh		;44d1	6f 	o 
	defb 06dh		;44d2	6d 	m 
	defb 020h		;44d3	20 	  
	defb 066h		;44d4	66 	f 
	defb 06fh		;44d5	6f 	o 
	defb 072h		;44d6	72 	r 
	defb 020h		;44d7	20 	  
	defb 061h		;44d8	61 	a 
	defb 072h		;44d9	72 	r 
	defb 067h		;44da	67 	g 
	defb 075h		;44db	75 	u 
	defb 06dh		;44dc	6d 	m 
	defb 065h		;44dd	65 	e 
	defb 06eh		;44de	6e 	n 
	defb 074h		;44df	74 	t 
	defb 073h		;44e0	73 	s 
	defb 000h		;44e1	00 	. 
l44e2h:
	defb 041h		;44e2	41 	A	"Ambiguous "
	defb 06dh		;44e3	6d 	m 
	defb 062h		;44e4	62 	b 
	defb 069h		;44e5	69 	i 
	defb 067h		;44e6	67 	g 
	defb 075h		;44e7	75 	u 
	defb 06fh		;44e8	6f 	o 
	defb 075h		;44e9	75 	u 
	defb 073h		;44ea	73 	s 
	defb 020h		;44eb	20 	  
	defb 000h		;44ec	00 	. 
l44edh:
	defb 020h		;44ed	20 	 	" redirection"
	defb 072h		;44ee	72 	r 
	defb 065h		;44ef	65 	e 
	defb 064h		;44f0	64 	d 
	defb 069h		;44f1	69 	i 
	defb 072h		;44f2	72 	r 
	defb 065h		;44f3	65 	e 
	defb 063h		;44f4	63 	c 
	defb 074h		;44f5	74 	t 
	defb 069h		;44f6	69 	i 
	defb 06fh		;44f7	6f 	o 
	defb 06eh		;44f8	6e 	n 
	defb 000h		;44f9	00 	. 
l44fah:
	defb 043h		;44fa	43 	C	"Can't open "
	defb 061h		;44fb	61 	a 
	defb 06eh		;44fc	6e 	n 
	defb 027h		;44fd	27 	' 
	defb 074h		;44fe	74 	t 
	defb 020h		;44ff	20 	  
	defb 06fh		;4500	6f 	o 
	defb 070h		;4501	70 	p 
	defb 065h		;4502	65 	e 
	defb 06eh		;4503	6e 	n 
	defb 020h		;4504	20 	  
	defb 000h		;4505	00 	. 
l4506h:
	defb 020h		;4506	20 	 	" for "
	defb 066h		;4507	66 	f 
	defb 06fh		;4508	6f 	o 
	defb 072h		;4509	72 	r 
	defb 020h		;450a	20 	  
	defb 000h		;450b	00 	. 
l450ch:
	defb 028h		;450c	28 	(	"(null)"
	defb 06eh		;450d	6e 	n 
	defb 075h		;450e	75 	u 
	defb 06ch		;450f	6c 	l 
	defb 06ch		;4510	6c 	l 
	defb 029h		;4511	29 	) 
	defb 000h		;4512	00 	. 


__iob:
	defb 082h		;4513	82 	. 
	defb 053h		;4514	53 	S 
	defb 000h		;4515	00 	. 
	defb 000h		;4516	00 	. 
	defb 082h		;4517	82 	. 
	defb 053h		;4518	53 	S 
	defb 009h		;4519	09 	. 
l451ah:
	defb 000h		;451a	00 	. 
__iob8:
	defb 000h		;451b	00 	. 
	defb 000h		;451c	00 	. 
	defb 000h		;451d	00 	. 
	defb 000h		;451e	00 	. 
	defb 000h		;451f	00 	. 
	defb 000h		;4520	00 	. 
	defb 006h		;4521	06 	. 
	defb 001h		;4522	01 	. 
__iob16:
	defb 000h		;4523	00 	. 
	defb 000h		;4524	00 	. 
	defb 000h		;4525	00 	. 
	defb 000h		;4526	00 	. 
	defb 000h		;4527	00 	. 
	defb 000h		;4528	00 	. 
	defb 006h		;4529	06 	. 
	defb 002h		;452a	02 	. 
	defb 000h		;452b	00 	. 
	defb 000h		;452c	00 	. 
	defb 000h		;452d	00 	. 
	defb 000h		;452e	00 	. 
	defb 000h		;452f	00 	. 
	defb 000h		;4530	00 	. 
	defb 000h		;4531	00 	. 
	defb 000h		;4532	00 	. 
	defb 000h		;4533	00 	. 
	defb 000h		;4534	00 	. 
	defb 000h		;4535	00 	. 
	defb 000h		;4536	00 	. 
	defb 000h		;4537	00 	. 
	defb 000h		;4538	00 	. 
	defb 000h		;4539	00 	. 
	defb 000h		;453a	00 	. 
	defb 000h		;453b	00 	. 
	defb 000h		;453c	00 	. 
	defb 000h		;453d	00 	. 
	defb 000h		;453e	00 	. 
	defb 000h		;453f	00 	. 
	defb 000h		;4540	00 	. 
	defb 000h		;4541	00 	. 
	defb 000h		;4542	00 	. 
	defb 000h		;4543	00 	. 
	defb 000h		;4544	00 	. 
	defb 000h		;4545	00 	. 
	defb 000h		;4546	00 	. 
	defb 000h		;4547	00 	. 
	defb 000h		;4548	00 	. 
	defb 000h		;4549	00 	. 
	defb 000h		;454a	00 	. 
	defb 000h		;454b	00 	. 
	defb 000h		;454c	00 	. 
	defb 000h		;454d	00 	. 
	defb 000h		;454e	00 	. 
	defb 000h		;454f	00 	. 
	defb 000h		;4550	00 	. 
	defb 000h		;4551	00 	. 
	defb 000h		;4552	00 	. 
__fcb:
	defb 000h		;4553	00 	. 
	defb 020h		;4554	20 	  
	defb 020h		;4555	20 	  
	defb 020h		;4556	20 	  
	defb 020h		;4557	20 	  
	defb 020h		;4558	20 	  
	defb 020h		;4559	20 	  
	defb 020h		;455a	20 	  
	defb 020h		;455b	20 	  
	defb 020h		;455c	20 	  
	defb 020h		;455d	20 	  
	defb 020h		;455e	20 	  
	defb 000h		;455f	00 	. 
	defb 000h		;4560	00 	. 
	defb 000h		;4561	00 	. 
	defb 000h		;4562	00 	. 
	defb 000h		;4563	00 	. 
	defb 000h		;4564	00 	. 
	defb 000h		;4565	00 	. 
	defb 000h		;4566	00 	. 
	defb 000h		;4567	00 	. 
	defb 000h		;4568	00 	. 
	defb 000h		;4569	00 	. 
	defb 000h		;456a	00 	. 
	defb 000h		;456b	00 	. 
	defb 000h		;456c	00 	. 
	defb 000h		;456d	00 	. 
	defb 000h		;456e	00 	. 
	defb 000h		;456f	00 	. 
	defb 000h		;4570	00 	. 
	defb 000h		;4571	00 	. 
	defb 000h		;4572	00 	. 
	defb 000h		;4573	00 	. 
	defb 000h		;4574	00 	. 
	defb 000h		;4575	00 	. 
	defb 000h		;4576	00 	. 
	defb 000h		;4577	00 	. 
	defb 000h		;4578	00 	. 
	defb 000h		;4579	00 	. 
	defb 000h		;457a	00 	. 
l457bh:
	defb 004h		;457b	04 	. 
	defb 000h		;457c	00 	. 
	defb 000h		;457d	00 	. 
	defb 020h		;457e	20 	  
	defb 020h		;457f	20 	  
	defb 020h		;4580	20 	  
	defb 020h		;4581	20 	  
	defb 020h		;4582	20 	  
	defb 020h		;4583	20 	  
	defb 020h		;4584	20 	  
	defb 020h		;4585	20 	  
	defb 020h		;4586	20 	  
	defb 020h		;4587	20 	  
	defb 020h		;4588	20 	  
	defb 000h		;4589	00 	. 
	defb 000h		;458a	00 	. 
	defb 000h		;458b	00 	. 
	defb 000h		;458c	00 	. 
	defb 000h		;458d	00 	. 
	defb 000h		;458e	00 	. 
	defb 000h		;458f	00 	. 
	defb 000h		;4590	00 	. 
	defb 000h		;4591	00 	. 
	defb 000h		;4592	00 	. 
	defb 000h		;4593	00 	. 
	defb 000h		;4594	00 	. 
	defb 000h		;4595	00 	. 
	defb 000h		;4596	00 	. 
	defb 000h		;4597	00 	. 
	defb 000h		;4598	00 	. 
	defb 000h		;4599	00 	. 
	defb 000h		;459a	00 	. 
	defb 000h		;459b	00 	. 
	defb 000h		;459c	00 	. 
	defb 000h		;459d	00 	. 
	defb 000h		;459e	00 	. 
	defb 000h		;459f	00 	. 
	defb 000h		;45a0	00 	. 
	defb 000h		;45a1	00 	. 
	defb 000h		;45a2	00 	. 
	defb 000h		;45a3	00 	. 
	defb 000h		;45a4	00 	. 
	defb 004h		;45a5	04 	. 
	defb 000h		;45a6	00 	. 
	defb 000h		;45a7	00 	. 
	defb 020h		;45a8	20 	  
	defb 020h		;45a9	20 	  
	defb 020h		;45aa	20 	  
	defb 020h		;45ab	20 	  
	defb 020h		;45ac	20 	  
	defb 020h		;45ad	20 	  
	defb 020h		;45ae	20 	  
	defb 020h		;45af	20 	  
	defb 020h		;45b0	20 	  
	defb 020h		;45b1	20 	  
	defb 020h		;45b2	20 	  
	defb 000h		;45b3	00 	. 
	defb 000h		;45b4	00 	. 
	defb 000h		;45b5	00 	. 
	defb 000h		;45b6	00 	. 
	defb 000h		;45b7	00 	. 
	defb 000h		;45b8	00 	. 
	defb 000h		;45b9	00 	. 
	defb 000h		;45ba	00 	. 
	defb 000h		;45bb	00 	. 
	defb 000h		;45bc	00 	. 
	defb 000h		;45bd	00 	. 
	defb 000h		;45be	00 	. 
	defb 000h		;45bf	00 	. 
	defb 000h		;45c0	00 	. 
	defb 000h		;45c1	00 	. 
	defb 000h		;45c2	00 	. 
	defb 000h		;45c3	00 	. 
	defb 000h		;45c4	00 	. 
	defb 000h		;45c5	00 	. 
	defb 000h		;45c6	00 	. 
	defb 000h		;45c7	00 	. 
	defb 000h		;45c8	00 	. 
	defb 000h		;45c9	00 	. 
	defb 000h		;45ca	00 	. 
	defb 000h		;45cb	00 	. 
	defb 000h		;45cc	00 	. 
	defb 000h		;45cd	00 	. 
	defb 000h		;45ce	00 	. 
	defb 004h		;45cf	04 	. 
	defb 000h		;45d0	00 	. 
	defb 000h		;45d1	00 	. 
	defb 000h		;45d2	00 	. 
	defb 000h		;45d3	00 	. 
	defb 000h		;45d4	00 	. 
	defb 000h		;45d5	00 	. 
	defb 000h		;45d6	00 	. 
	defb 000h		;45d7	00 	. 
	defb 000h		;45d8	00 	. 
	defb 000h		;45d9	00 	. 
	defb 000h		;45da	00 	. 
	defb 000h		;45db	00 	. 
	defb 000h		;45dc	00 	. 
	defb 000h		;45dd	00 	. 
	defb 000h		;45de	00 	. 
	defb 000h		;45df	00 	. 
	defb 000h		;45e0	00 	. 
	defb 000h		;45e1	00 	. 
	defb 000h		;45e2	00 	. 
	defb 000h		;45e3	00 	. 
	defb 000h		;45e4	00 	. 
	defb 000h		;45e5	00 	. 
	defb 000h		;45e6	00 	. 
	defb 000h		;45e7	00 	. 
	defb 000h		;45e8	00 	. 
	defb 000h		;45e9	00 	. 
	defb 000h		;45ea	00 	. 
	defb 000h		;45eb	00 	. 
	defb 000h		;45ec	00 	. 
	defb 000h		;45ed	00 	. 
	defb 000h		;45ee	00 	. 
	defb 000h		;45ef	00 	. 
	defb 000h		;45f0	00 	. 
	defb 000h		;45f1	00 	. 
	defb 000h		;45f2	00 	. 
	defb 000h		;45f3	00 	. 
	defb 000h		;45f4	00 	. 
	defb 000h		;45f5	00 	. 
	defb 000h		;45f6	00 	. 
	defb 000h		;45f7	00 	. 
	defb 000h		;45f8	00 	. 
	defb 000h		;45f9	00 	. 
	defb 000h		;45fa	00 	. 
	defb 000h		;45fb	00 	. 
	defb 000h		;45fc	00 	. 
	defb 000h		;45fd	00 	. 
	defb 000h		;45fe	00 	. 
	defb 000h		;45ff	00 	. 
	defb 000h		;4600	00 	. 
	defb 000h		;4601	00 	. 
	defb 000h		;4602	00 	. 
	defb 000h		;4603	00 	. 
	defb 000h		;4604	00 	. 
	defb 000h		;4605	00 	. 
	defb 000h		;4606	00 	. 
	defb 000h		;4607	00 	. 
	defb 000h		;4608	00 	. 
	defb 000h		;4609	00 	. 
	defb 000h		;460a	00 	. 
	defb 000h		;460b	00 	. 
	defb 000h		;460c	00 	. 
	defb 000h		;460d	00 	. 
	defb 000h		;460e	00 	. 
	defb 000h		;460f	00 	. 
	defb 000h		;4610	00 	. 
	defb 000h		;4611	00 	. 
	defb 000h		;4612	00 	. 
	defb 000h		;4613	00 	. 
	defb 000h		;4614	00 	. 
	defb 000h		;4615	00 	. 
	defb 000h		;4616	00 	. 
	defb 000h		;4617	00 	. 
	defb 000h		;4618	00 	. 
	defb 000h		;4619	00 	. 
	defb 000h		;461a	00 	. 
	defb 000h		;461b	00 	. 
	defb 000h		;461c	00 	. 
	defb 000h		;461d	00 	. 
	defb 000h		;461e	00 	. 
	defb 000h		;461f	00 	. 
	defb 000h		;4620	00 	. 
	defb 000h		;4621	00 	. 
	defb 000h		;4622	00 	. 
	defb 000h		;4623	00 	. 
	defb 000h		;4624	00 	. 
	defb 000h		;4625	00 	. 
	defb 000h		;4626	00 	. 
	defb 000h		;4627	00 	. 
	defb 000h		;4628	00 	. 
	defb 000h		;4629	00 	. 
	defb 000h		;462a	00 	. 
	defb 000h		;462b	00 	. 
	defb 000h		;462c	00 	. 
	defb 000h		;462d	00 	. 
	defb 000h		;462e	00 	. 
	defb 000h		;462f	00 	. 
	defb 000h		;4630	00 	. 
	defb 000h		;4631	00 	. 
	defb 000h		;4632	00 	. 
	defb 000h		;4633	00 	. 
	defb 000h		;4634	00 	. 
	defb 000h		;4635	00 	. 
	defb 000h		;4636	00 	. 
	defb 000h		;4637	00 	. 
	defb 000h		;4638	00 	. 
	defb 000h		;4639	00 	. 
	defb 000h		;463a	00 	. 
	defb 000h		;463b	00 	. 
	defb 000h		;463c	00 	. 
	defb 000h		;463d	00 	. 
	defb 000h		;463e	00 	. 
	defb 000h		;463f	00 	. 
	defb 000h		;4640	00 	. 
	defb 000h		;4641	00 	. 
	defb 000h		;4642	00 	. 
	defb 000h		;4643	00 	. 
	defb 000h		;4644	00 	. 
	defb 000h		;4645	00 	. 
	defb 000h		;4646	00 	. 
	defb 000h		;4647	00 	. 
	defb 000h		;4648	00 	. 
	defb 000h		;4649	00 	. 
	defb 000h		;464a	00 	. 
	defb 000h		;464b	00 	. 
	defb 000h		;464c	00 	. 
	defb 000h		;464d	00 	. 
	defb 000h		;464e	00 	. 
	defb 000h		;464f	00 	. 
	defb 000h		;4650	00 	. 
	defb 000h		;4651	00 	. 
	defb 000h		;4652	00 	. 
	defb 000h		;4653	00 	. 
	defb 000h		;4654	00 	. 
	defb 000h		;4655	00 	. 
	defb 000h		;4656	00 	. 
	defb 000h		;4657	00 	. 
	defb 000h		;4658	00 	. 
	defb 000h		;4659	00 	. 
	defb 000h		;465a	00 	. 
	defb 000h		;465b	00 	. 
	defb 000h		;465c	00 	. 
	defb 000h		;465d	00 	. 
	defb 000h		;465e	00 	. 
	defb 000h		;465f	00 	. 
	defb 000h		;4660	00 	. 
	defb 000h		;4661	00 	. 
	defb 000h		;4662	00 	. 
	defb 000h		;4663	00 	. 
	defb 000h		;4664	00 	. 
	defb 000h		;4665	00 	. 
	defb 000h		;4666	00 	. 
	defb 000h		;4667	00 	. 
	defb 000h		;4668	00 	. 
	defb 000h		;4669	00 	. 
	defb 000h		;466a	00 	. 
	defb 000h		;466b	00 	. 
	defb 000h		;466c	00 	. 
	defb 000h		;466d	00 	. 
	defb 000h		;466e	00 	. 
	defb 000h		;466f	00 	. 
	defb 000h		;4670	00 	. 
	defb 000h		;4671	00 	. 
	defb 000h		;4672	00 	. 
	defb 000h		;4673	00 	. 
	defb 000h		;4674	00 	. 
	defb 000h		;4675	00 	. 
	defb 000h		;4676	00 	. 
	defb 000h		;4677	00 	. 
	defb 000h		;4678	00 	. 
	defb 000h		;4679	00 	. 
	defb 000h		;467a	00 	. 
	defb 000h		;467b	00 	. 
	defb 000h		;467c	00 	. 
	defb 000h		;467d	00 	. 
	defb 000h		;467e	00 	. 
	defb 000h		;467f	00 	. 
	defb 000h		;4680	00 	. 
	defb 000h		;4681	00 	. 
	defb 000h		;4682	00 	. 
	defb 000h		;4683	00 	. 
	defb 000h		;4684	00 	. 
	defb 000h		;4685	00 	. 
	defb 000h		;4686	00 	. 
	defb 000h		;4687	00 	. 
	defb 000h		;4688	00 	. 
	defb 000h		;4689	00 	. 
	defb 000h		;468a	00 	. 
	defb 000h		;468b	00 	. 
	defb 000h		;468c	00 	. 
	defb 000h		;468d	00 	. 
	defb 000h		;468e	00 	. 
	defb 000h		;468f	00 	. 
	defb 000h		;4690	00 	. 
	defb 000h		;4691	00 	. 
	defb 000h		;4692	00 	. 
	defb 000h		;4693	00 	. 
	defb 000h		;4694	00 	. 
	defb 000h		;4695	00 	. 
	defb 000h		;4696	00 	. 
	defb 000h		;4697	00 	. 
	defb 000h		;4698	00 	. 
	defb 000h		;4699	00 	. 
	defb 000h		;469a	00 	. 
	defb 000h		;469b	00 	. 
	defb 000h		;469c	00 	. 
	defb 000h		;469d	00 	. 
	defb 000h		;469e	00 	. 
	defb 000h		;469f	00 	. 
	defb 000h		;46a0	00 	. 
	defb 000h		;46a1	00 	. 
	defb 000h		;46a2	00 	. 
_dnames:
	defb 043h		;46a3	43 	C 
	defb 04fh		;46a4	4f 	O 
	defb 04eh		;46a5	4e 	N 
	defb 03ah		;46a6	3a 	: 
	defb 052h		;46a7	52 	R 
	defb 044h		;46a8	44 	D 
	defb 052h		;46a9	52 	R 
	defb 03ah		;46aa	3a 	: 
	defb 050h		;46ab	50 	P 
	defb 055h		;46ac	55 	U 
	defb 04eh		;46ad	4e 	N 
	defb 03ah		;46ae	3a 	: 
	defb 04ch		;46af	4c 	L 
	defb 053h		;46b0	53 	S 
	defb 054h		;46b1	54 	T 
	defb 03ah		;46b2	3a 	: 
__ctype_:
	defb 000h		;46b3	00 	. 
l46b4h:
	defb 020h		;46b4	20 	  
	defb 020h		;46b5	20 	  
	defb 020h		;46b6	20 	  
	defb 020h		;46b7	20 	  
	defb 020h		;46b8	20 	  
	defb 020h		;46b9	20 	  
	defb 020h		;46ba	20 	  
	defb 020h		;46bb	20 	  
	defb 020h		;46bc	20 	  
	defb 008h		;46bd	08 	. 
	defb 008h		;46be	08 	. 
	defb 008h		;46bf	08 	. 
	defb 008h		;46c0	08 	. 
	defb 008h		;46c1	08 	. 
	defb 020h		;46c2	20 	  
	defb 020h		;46c3	20 	  
	defb 020h		;46c4	20 	  
	defb 020h		;46c5	20 	  
	defb 020h		;46c6	20 	  
	defb 020h		;46c7	20 	  
	defb 020h		;46c8	20 	  
	defb 020h		;46c9	20 	  
	defb 020h		;46ca	20 	  
	defb 020h		;46cb	20 	  
	defb 020h		;46cc	20 	  
	defb 020h		;46cd	20 	  
	defb 020h		;46ce	20 	  
	defb 020h		;46cf	20 	  
	defb 020h		;46d0	20 	  
	defb 020h		;46d1	20 	  
	defb 020h		;46d2	20 	  
	defb 020h		;46d3	20 	  
	defb 008h		;46d4	08 	. 
	defb 010h		;46d5	10 	. 
	defb 010h		;46d6	10 	. 
	defb 010h		;46d7	10 	. 
	defb 010h		;46d8	10 	. 
	defb 010h		;46d9	10 	. 
	defb 010h		;46da	10 	. 
	defb 010h		;46db	10 	. 
	defb 010h		;46dc	10 	. 
	defb 010h		;46dd	10 	. 
	defb 010h		;46de	10 	. 
	defb 010h		;46df	10 	. 
	defb 010h		;46e0	10 	. 
	defb 010h		;46e1	10 	. 
	defb 010h		;46e2	10 	. 
	defb 010h		;46e3	10 	. 
	defb 004h		;46e4	04 	. 
	defb 004h		;46e5	04 	. 
	defb 004h		;46e6	04 	. 
	defb 004h		;46e7	04 	. 
	defb 004h		;46e8	04 	. 
	defb 004h		;46e9	04 	. 
	defb 004h		;46ea	04 	. 
	defb 004h		;46eb	04 	. 
	defb 004h		;46ec	04 	. 
	defb 004h		;46ed	04 	. 
	defb 010h		;46ee	10 	. 
	defb 010h		;46ef	10 	. 
	defb 010h		;46f0	10 	. 
	defb 010h		;46f1	10 	. 
	defb 010h		;46f2	10 	. 
	defb 010h		;46f3	10 	. 
	defb 010h		;46f4	10 	. 
	defb 041h		;46f5	41 	A 
	defb 041h		;46f6	41 	A 
	defb 041h		;46f7	41 	A 
	defb 041h		;46f8	41 	A 
	defb 041h		;46f9	41 	A 
	defb 041h		;46fa	41 	A 
	defb 001h		;46fb	01 	. 
	defb 001h		;46fc	01 	. 
	defb 001h		;46fd	01 	. 
	defb 001h		;46fe	01 	. 
	defb 001h		;46ff	01 	. 
	defb 001h		;4700	01 	. 
	defb 001h		;4701	01 	. 
	defb 001h		;4702	01 	. 
	defb 001h		;4703	01 	. 
	defb 001h		;4704	01 	. 
	defb 001h		;4705	01 	. 
	defb 001h		;4706	01 	. 
	defb 001h		;4707	01 	. 
	defb 001h		;4708	01 	. 
	defb 001h		;4709	01 	. 
	defb 001h		;470a	01 	. 
	defb 001h		;470b	01 	. 
	defb 001h		;470c	01 	. 
	defb 001h		;470d	01 	. 
	defb 001h		;470e	01 	. 
	defb 010h		;470f	10 	. 
	defb 010h		;4710	10 	. 
	defb 010h		;4711	10 	. 
	defb 010h		;4712	10 	. 
	defb 010h		;4713	10 	. 
	defb 010h		;4714	10 	. 
	defb 042h		;4715	42 	B 
	defb 042h		;4716	42 	B 
	defb 042h		;4717	42 	B 
	defb 042h		;4718	42 	B 
	defb 042h		;4719	42 	B 
	defb 042h		;471a	42 	B 
	defb 002h		;471b	02 	. 
	defb 002h		;471c	02 	. 
	defb 002h		;471d	02 	. 
	defb 002h		;471e	02 	. 
	defb 002h		;471f	02 	. 
	defb 002h		;4720	02 	. 
	defb 002h		;4721	02 	. 
	defb 002h		;4722	02 	. 
	defb 002h		;4723	02 	. 
	defb 002h		;4724	02 	. 
	defb 002h		;4725	02 	. 
	defb 002h		;4726	02 	. 
	defb 002h		;4727	02 	. 
	defb 002h		;4728	02 	. 
	defb 002h		;4729	02 	. 
	defb 002h		;472a	02 	. 
	defb 002h		;472b	02 	. 
	defb 002h		;472c	02 	. 
	defb 002h		;472d	02 	. 
	defb 002h		;472e	02 	. 
	defb 010h		;472f	10 	. 
	defb 010h		;4730	10 	. 
	defb 010h		;4731	10 	. 
	defb 010h		;4732	10 	. 
	defb 020h		;4733	20 	  
l4734h:
	defb 030h		;4734	30 	0 
	defb 031h		;4735	31 	1 
	defb 032h		;4736	32 	2 
	defb 033h		;4737	33 	3 
	defb 034h		;4738	34 	4 
	defb 035h		;4739	35 	5 
	defb 036h		;473a	36 	6 
	defb 037h		;473b	37 	7 
	defb 038h		;473c	38 	8 
	defb 039h		;473d	39 	9 
	defb 041h		;473e	41 	A 
	defb 042h		;473f	42 	B 
	defb 043h		;4740	43 	C 
	defb 044h		;4741	44 	D 
	defb 045h		;4742	45 	E 
	defb 046h		;4743	46 	F 
	defb 000h		;4744	00 	. 
__Lbss:
word_4745:
	defb 000h		;4745	00 	. 
	defb 000h		;4746	00 	. 
word_4747:
	defb 000h		;4747	00 	. 
	defb 000h		;4748	00 	. 
word_4749:
	defb 000h		;4749	00 	. 
	defb 000h		;474a	00 	. 
word_474b:
	defb 000h		;474b	00 	. 
	defb 000h		;474c	00 	. 
word_474d:
	defb 000h		;474d	00 	. 
	defb 000h		;474e	00 	. 
word_474f:
	defb 000h		;474f	00 	. 
	defb 000h		;4750	00 	. 
byte_4751:
	defb 000h		;4751	00 	. 
word_4752:
	defb 000h		;4752	00 	. 
	defb 000h		;4753	00 	. 
word_4754:
	defb 000h		;4754	00 	. 
	defb 000h		;4755	00 	. 
word_4756:
	defb 000h		;4756	00 	. 
	defb 000h		;4757	00 	. 
word_4758:
	defb 000h		;4758	00 	. 
	defb 000h		;4759	00 	. 
word_475a:
	defb 000h		;475a	00 	. 
	defb 000h		;475b	00 	. 
word_475c:
	defb 000h		;475c	00 	. 
	defb 000h		;475d	00 	. 
byte_475e:
	defb 000h		;475e	00 	. 
word_475f:
	defb 000h		;475f	00 	. 
	defb 000h		;4760	00 	. 
word_4761:
	defb 000h		;4761	00 	. 
	defb 000h		;4762	00 	. 
word_4763:
	defb 000h		;4763	00 	. 
	defb 000h		;4764	00 	. 
word_4765:
	defb 000h		;4765	00 	. 
	defb 000h		;4766	00 	. 
l4767h:
	defb 000h		;4767	00 	. 
	defb 000h		;4768	00 	. 
	defb 000h		;4769	00 	. 
	defb 000h		;476a	00 	. 
	defb 000h		;476b	00 	. 
	defb 000h		;476c	00 	. 
	defb 000h		;476d	00 	. 
	defb 000h		;476e	00 	. 
	defb 000h		;476f	00 	. 
	defb 000h		;4770	00 	. 
	defb 000h		;4771	00 	. 
	defb 000h		;4772	00 	. 
	defb 000h		;4773	00 	. 
	defb 000h		;4774	00 	. 
	defb 000h		;4775	00 	. 
	defb 000h		;4776	00 	. 
	defb 000h		;4777	00 	. 
	defb 000h		;4778	00 	. 
	defb 000h		;4779	00 	. 
	defb 000h		;477a	00 	. 
	defb 000h		;477b	00 	. 
	defb 000h		;477c	00 	. 
	defb 000h		;477d	00 	. 
	defb 000h		;477e	00 	. 
	defb 000h		;477f	00 	. 
data_415f_end:



word_4967: defw	0
arry_4969: defb 0, 0
arry_496b: defw	0

arry_496d:
    04971h
arry_4975:



word_4b6d: defw	0
word_4b6f: defw	0
byte_4b71: defb 0
byte_4b72: defb 0
byte_4b73: defb 0
word_4b74: defw	0
byte_4b76: defb 0
word_4b77: defw	0
word_4b79: defw	0

word_4b7e: defw	0
