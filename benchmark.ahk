Benchmark(callback, reps = 1000) {
	DllCall( "QueryPerformanceFrequency", "Int64*", ticksPerSec)
	DllCall("QueryPerformanceCounter", "Int64*", startTick)
	Loop %reps% {
		%callback%()
	}
	DllCall("QueryPerformanceCounter", "Int64*", endTick)
	
	FormatResult(reps, startTick, endTick, ticksPerSec)
}

FormatResult(reps, startTick, endTick, ticksPerSec, name = "Benchmark") {
	elpSfx = s 
	elpTime := (endTick - startTick) / ticksPerSec
	
	repSfx = s
	repTime := elpTime / reps
	
	if (repTime < 0.001) {
		repSfx = ns
		repTime := elpTime * 1000000 / reps
	} else if (repTime < 1) {
		repSfx = ms
		repTime := elpTime * 1000 / reps
	} 
	
	if (elpTime < 0.001) {
		elpSfx = ns
		elpTime := (endTick - startTick) * 1000000 / ticksPerSec
	} else if (elpTime < 1) {
		elpSfx = ms
		elpTime := (endTick - startTick) * 1000 / ticksPerSec
	}
	
	MsgBox,,%name%,Reps: %reps%`nStart Tick: %startTick%`nEnd Tick: %endTick%`nTick Frequency: %ticksPerSec%tps`nElapsed Time: %elpTime%%elpSfx%`nTime Per Rep: %repTime%%repSfx%`nAHK Version: %A_AhkVersion%`nError Level: %ErrorLevel%`nLast Error: %A_LastError%
}