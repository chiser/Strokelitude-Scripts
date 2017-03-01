######################## A script for plotting data from torque measurements

## source the functions needed
source("StrokePrepFunctions.R")

tTraces <- flyTorqueImport()

## query the user for start and end seconds for the excerpts
print("Please enter the starting time for the excerpts.")
startTime <- scan(n=1)
print("Please enter the end time for the excerpts.")
endTime <-  scan(n=1)

for(ind in 1:length(tTraces)){
	png(filename = paste("torqueTrace",ind,".png", sep = ""), width = 1920)
	plot(x = tTraces[[ind]]$Time, y = tTraces[[ind]]$Trace, type = "l", main = paste("Torque Trace",ind), xlab = "Time (sec)", ylab = "Yaw Torque")
	# graphics.off()
  #uncommenting the above solved the error I had running the script without it: Error in plot.window(): endliche xlim werte nötig.
  #another possibility would be to try to hardcore the xlim between reasonable values: not easy because they vary quite a bit. In addition in the plots I see the last fly is plotted wrong: probably because of the conversion of numbers to string(factors) and then to numbers again
	flyTraceExcerptPlot(tTraces[[ind]]$Trace, tTraces[[ind]]$Time, startTime, endTime, filename = paste("torqueTraceExcerpt", ind, ".png"))
	 #dev.off()
}

graphics.off()