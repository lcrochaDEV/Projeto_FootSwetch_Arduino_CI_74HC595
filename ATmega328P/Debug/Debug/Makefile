###############################################################################
# Makefile for project 
###############################################################################

## General options
PROJECT = 
MCU = ATmega328P
COMPILER = "AVRASM (Proteus)"
TARGET = Debug
SHELL = C:\Windows\system32\cmd.exe

## Tools general options
ASMFLAGS=-fO -i"C:\Program Files (x86)\Labcenter Electronics\Proteus 8 Professional\VSM Studio\Tools\AVRASM\appnotes\m328Pdef.inc"

## Processing Tools
ASM=avrasm2.exe
#  C:/Users/LuKInhas/Documents/Projeto FootSwetch Arduino CI 74HC595/ATmega328P/Debug/Debug/Debug.obj: TOOL=ASM

# Build tree:
all:	Debug

Debug:	Debug.obj

Debug.obj:	
	$(ASM) $(ASMFLAGS)  -o "Debug.obj" -l Debug.lst %INFILE_DOS_QUOTED%

# tidy - delete all temporary files which are not involved in the target generation
tidy:
	rm -rf Debug.lst

# cleanup - delete all generated files
clean:	tidy

