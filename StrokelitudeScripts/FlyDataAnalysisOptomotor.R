################## An R-script to analyse strokelitude data containing different conditions

## if you did not do so yet, set the right working directory
#setwd("F:/Master/FlyData")

## source the scripts with functions needed for analysis
source("StrokePrepFunctions.R")
source("StrokeFunctions.R")

##### read the data with the corresponding function
flyTraces <- flyDataImport()
flyTracesFiltered <- flyDataFilter(flyTraces, frequency = .12, order = 3)

##### do the downsampling with the corresponding function
print("Please enter the binsize for averaging:")
binsize <- scan(n=1)   # set the size of bins to be averaged

flyTracesDown <- flyDataDownsample(flyTracesFiltered, binsize)

## do the sliding average with the corresponding function
flyTracesSlide <- flyDataSlidingAverage(flyTracesFiltered, binsize)


##### sort the data into the different conditions and compare two conditions with a t-test

## query the parameters needed for sorting
# parameters <- parameterQuery()
## or use hardcoded parameters
parameters <- parametersHardcoded()
## or determine the parameters from the gaps in the data
#borders <- getBorders(flyTracesFiltered, 10)
#lastSecond <- getLastSecond(flyTracesFiltered)
#condOrder <- c(1,2,3,1,2,3,1,2,3,1,2,3)				# HARDCODED order of conditions; TODO: change this to data query
#parameters <- bordersToStarts(borders, condOrder, lastSecond)

startTimes <- parameters[[1]]
endTimes <- parameters[[2]]

## do the actual sorting
flyTracesSorted <- flyDataSections(flyTracesFiltered, startTimes, endTimes)

## perform a t-test between condition 2 (assumed to be right movement) and condition 3 (assumed to be left movement)
tTestResult <- pairwise.t.test(flyTracesSorted[[2]], flyTracesSorted[[3]])


##### TODO do a more sophisticated analysis, comparing several models
## first model: simple regression
linMod <- lm(Right-Left ~ Time, flyTracesFiltered)	# fitting the linear model
# print(summary(linMod))						# printing a summary
linModDown <- lm(Right-Left ~ Time, flyTracesDown)	# fit the same model with the downsampled data
# print(summary(linModDown))
linModSl <- lm(Right-Left ~ Time, flyTracesSlide)	# fit the same model to the sliding averaged data
# print(summary(linModSl))

## second model: a horizontal line for each condition (basically like a t-test)

## third model: an exponential decay toward the preferred direction for each optomotor trial (curve has same shape for each trial)

## fourth model: an exponential decay toward the preferred direction for each optomotor trial



