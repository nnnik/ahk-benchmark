#include ../benchmark.ahk

#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
#SingleInstance force
ListLines Off
Process, Priority, , H
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
SetWorkingDir %A_ScriptDir%


case1(){
	DllCall( "LoadLibrary", "Str", "gdiplus")
	DllCall( "gdiplus\GdiplusStartup", "Ptr", pToken, "Ptr", &si, "Ptr", 0)
	DllCall( "gdiplus\GdipGetImageEncodersSize", "UInt*", nCount, "UInt*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall( "gdiplus\GdipGetImageEncoders", "UInt", nCount, "UInt", nSize, "Ptr", &ci)
	DllCall( "gdiplus\GdiplusShutdown", Ptr, pToken)
}

benchmark(func("case1"), 1000)