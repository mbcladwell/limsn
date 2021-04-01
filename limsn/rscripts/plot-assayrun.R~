rm(list=ls(all=TRUE))

## https://benfradet.github.io/blog/2014/04/30/Display-legend-outside-plot-R
## Rscript --vanilla plot-layout.R in.txt out.png 96

args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args) %in% c(0,1,2,3)) {
  stop("Error: args required: two inputs, output file, response and threshold", call.=FALSE)
}

## getwd()
## infile <- "../tmp/ar-8222479441190188284525.txt"
## infile2 <- "../tmp/ar2-7764507602467792171973.txt"
## response <- 1
## threshold <- 3
## outfile <- "../tmp/out.png"
##  d <- read.table( file = infile,   sep = "\t", header=TRUE)
##  d2 <- read.table( file = infile2,   sep = "\t", header=TRUE, row.names=NULL)

infile <- args[1]
infile2 <- args[2]
 outfile <- args[3]
response <- args[4]
threshold <- args[5]

 d <- read.table(file=args[1], sep="\t", header=TRUE)
 d2 <- read.table(file=args[2], sep="\t", header=TRUE, row.names=NULL)


## 0 raw
## 1 norm
## 2 norm_pos
## 3 p_enhanced
if(response ==0)data <- d[,c(2,3,5,9)]
if(response ==1)data <- d[,c(2,3,6,9)]
if(response ==2)data <- d[,c(2,3,7,9)]
if(response ==3)data <- d[,c(2,3,8,9)]


## Threshold
## 1  mean-pos
## 2  mean-neg-2-sd
## 3  mean-neg-3-sd

if(threshold ==1){
    threshold.text <- "> mean(pos)"
    threshold <- d2[d2$response.type==response, "mean.pos" ]
    }
if(threshold ==2){
    threshold.text <- "mean(neg) + 2SD"
    threshold <- d2[d2$response.type==response, "mean.neg.2.sd" ]
    }
if(threshold ==3){
    threshold.text <- "mean(neg) + 3SD"
    threshold <- d2[d2$response.type==response, "mean.neg.3.sd" ]
}

names(data) <- c("plate","well","response","type")
data <- data[order(data$response),]
data$index <- (nrow(data)):1
num.hits <- nrow(data[data$response > threshold,])

palette(c("grey", "red", "green", "black"))
png(outfile,width=900, height=550)
## par(xpd = T, mar = par()$mar + c(0,0,0,6))
plot(data$index, data$response,  cex=1, pch=1, col=data$type, ylab="Background Subtracted", xlab="Index")
text( nrow(data)*0.1, threshold + 0.05*threshold, paste0("hits: ", num.hits))
text( nrow(data)*0.1, threshold - 0.05*threshold, threshold.text)
## par(xpd = T, mar = par()$mar + c(0,0,0,6))
legend("topright",  c("unknown","positive","negative","blank"), fill=c("white", "green", "red", "grey"))
abline(h=threshold, lty="dashed")


dev.off()  
par(mar=c(5, 4, 4, 2) + 0.1)
 

