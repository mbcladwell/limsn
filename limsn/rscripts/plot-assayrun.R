rm(list=ls(all=TRUE))

## https://benfradet.github.io/blog/2014/04/30/Display-legend-outside-plot-R
## Rscript --vanilla plot-layout.R in.txt out.png 96

args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args) %in% c(0,1,2,3,4)) {
  stop("Error: args required: six inputs, in1, in2, output file, hits file, response and threshold", call.=FALSE)
}

## getwd()
## infile <- "../pub/tmp/ar-8222479441190188284525.txt"
## infile2 <- "../pub/tmp/ar2-7764507602467792171973.txt"
## response <- 1
## threshold <- 3
## outfile <- "../pub/tmp/out.png"
## hitfile <- "../pub/tmp/hl-4956482.txt"
## d <- read.table( file = infile,   sep = "\t", header=TRUE)
## d2 <- read.table( file = infile2,   sep = "\t", header=TRUE, row.names=NULL)


infile <- args[1]
infile2 <- args[2]
outfile <- args[3]
hitfile <- args[4]
response <- args[5]
threshold <- args[6]
d <- read.table(file=args[1], sep="\t", header=TRUE)
d2 <- read.table(file=args[2], sep="\t", header=TRUE, row.names=NULL)

## response
## 0 raw
## 1 norm
## 2 norm_pos
## 3 p_enhanced
if(response ==0)d3 <- d[,c(2,3,5,9,12)]
if(response ==1)d3 <- d[,c(2,3,6,9,12)]
if(response ==2)d3 <- d[,c(2,3,7,9,12)]
if(response ==3)d3 <- d[,c(2,3,8,9,12)]

if(response ==0) ylabel <- "Background Subtracted"
if(response ==1) ylabel <- "Normalized"
if(response ==2) ylabel <- "Normalized to postive controls"
if(response ==3) ylabel <- "% Enhanced"




## Threshold
## 1  mean-pos
## 2  mean-neg-2-sd
## 3  mean-neg-3-sd

if(threshold %in% c("1","2","3")){
	if(threshold =="1"){
    		threshold.text <- "> mean(pos)"
   		threshold.val <- d2[d2$response.type==response, "mean.pos" ]
    	}
	if(threshold =="2"){
    		threshold.text <- "mean(neg) + 2SD"
    		threshold.val <- d2[d2$response.type==response, "mean.neg.2.sd" ]
    	}
	if(threshold =="3"){
    		threshold.text <- "mean(neg) + 3SD"
    		threshold.val <- d2[d2$response.type==response, "mean.neg.3.sd" ]
	}
	}else{
            threshold.text <- "manual"
            threshold.val <- threshold
}


names(d3) <- c("plate","well","response","type","spl")
unks <- d3[d3$type==1,]
hitspre <- unks[unks$response > threshold.val,]
hits <- hitspre[hitspre$spl > 0,]
write.table(hits, file = hitfile, append =FALSE, quote = FALSE, sep = "\t",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE)
num.hits <- length(unique(hits$spl)) 
##only want unique hits
d3 <- d3[order(d3$response),]
d3$index <- (nrow(d3)):1

palette(c("black", "green",  "red","grey" ))
png(outfile,width=900, height=550)
## par(xpd = T, mar = par()$mar + c(0,0,0,6))
plot(d3$index, d3$response,  cex=1, pch=1, col=as.factor(d3$type), ylab= ylabel, xlab="Index")

text( nrow(d3)*0.1, threshold.val + 0.05*threshold.val, paste0("hits: ", num.hits))
text( nrow(d3)*0.1, threshold.val - 0.05*threshold.val, threshold.text)
## par(xpd = T, mar = par()$mar + c(0,0,0,6))
legend("topright",  c("unknown","positive","negative","blank"), fill=c("white", "green", "red", "grey"))
abline(h=threshold.val, lty="dashed")


## dev.off()  
## par(mar=c(5, 4, 4, 2) + 0.1)
 

