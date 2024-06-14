@echo off

md obj\x86
md bin\

cmd /c pink pu

clang -c -o obj/x86/pu.o --target=x86_64-pc-win32-coff -fno-strict-aliasing -w -ffreestanding -fno-stack-protector -nostdlib -static out_pu.c
lld -flavor link -fixed -dynamicbase:no -subsystem:console -align:1024 -nodefaultlib -base:0xffffffffffe00000 -entry:main obj\x86\pu.o -out:bin/pux86.sys

md iso_root\x86\System\

xcopy /Y /S bin\pux86.sys iso_root\x86\System\pux86.sys
xcopy /Y /S bo\ot\simpleboot.cfg iso_root\x86\simpleboot.cfg

simpleboot -k System/pux86.sys -e -c iso_root/x86 PurpleOS-x86_64s.img