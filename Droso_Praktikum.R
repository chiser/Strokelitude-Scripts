
################## An R-script to import strokelitude data and to plot it in several ways

## if you did not do so yet, set the right working directory
setwd("C:/Users/LocalAdmin/Desktop/scripts/repositories/StrokelitudeScripts")

## source the script with the functions needed for analysis
source("StrokePrepFunctions.R")


setwd("C:/Users/LocalAdmin/Desktop/")
##### read the data with the corresponding function
flyTraces <- flyDataImport()
flyTracesFiltered <- flyDataFilter(flyTraces, frequency = .12, order = 3)

## plot the traces and save them as .png files
png(file = "RightTrace.png", width = 1920) # direct the following output to the image RightTrace.png
plot(x = flyTracesFiltered$Time, y = flyTracesFiltered$Right, type = "l", main = "Trace of the Right Wing", xlab = "Time (sec)", ylab = "Right Anterior Wingstroke Angle")
png(file = "LeftTrace.png", width = 1920)
plot(x = flyTracesFiltered$Time, y = flyTracesFiltered$Left, type = "l", main = "Trace of the Left Wing", xlab = "Time (sec)", ylab = "Left Anterior Wingstroke Angle")
png(file = "Trace.png", width = 1920)
plot(x = flyTracesFiltered$Time, y = flyTracesFiltered$Right-flyTracesFiltered$Left, type = "l", main = "Difference in Wingstroke Amplitude", xlab = "Time (sec)", ylab = "Wingstroke Angle Difference")
graphics.off()




##### do the downsampling with the corresponding function
print("Please enter the binsize for averaging:")
binsize <- 5   # set the size of bins to be averaged

flyTracesDown <- flyDataDownsample(flyTracesFiltered, binsize)


## plotting downsampled data
png(file = "TraceDownsampled.png", width = 1920)
plot(x = flyTracesDown$Time, y = (flyTracesDown$Right-flyTracesDown$Left), type = "l", main = "Difference in Wingstroke Amplitude, Downsampled", xlab = "Time (sec)", ylab = "Wingstroke Angle Difference")




direction <- flyTracesDown$Right-flyTracesDown$Left
thrust <- flyTracesDown$Right+flyTracesDown$Left

x = thrust* cos(direction)
y = thrust* sin(direction)

plot(direction, type="l")

plot(thrust, type="l")


png(file = "Simulated_path.png", width = 1200,height = 1200)
plot(cumsum(x),cumsum(y),type="l")


graphics.off()









