rm(list=ls(all=TRUE))

## https://benfradet.github.io/blog/2014/04/30/Display-legend-outside-plot-R
## Rscript --vanilla plot-layout.R in.txt out.png 96

args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args) %in% c(0,1,2,4,5)) {
  stop("Error: args required: input, output file and format", call=FALSE)
}

 ## getwd()
 ## infile <- "../tmp/lyt-1562457325090311990834.txt"
 ## spl.outfile <- "../tmp/out.png"
 ## d <- read.table( file = infile, skip=3, nrows=384, sep = "\t", header=TRUE)

infile <- args[1]
## spl.outfile <- paste0("../pub/", args[2])
spl.outfile <- args[2]
format <- as.numeric(args[3])
d <- read.table(file=args[1],  nrows=format, sep="\t", header=TRUE)

well.nums <-read.table( file = "rscripts/well_numbers_for_import.txt",   sep = "\t", header=TRUE)
well.nums <- well.nums[well.nums$format==format,]

d <- merge(d, well.nums, by.x="well", by.y="bycol")

palette(c("white", "green", "red", "grey", "lightblue"))
par(xpd = T, mar = par()$mar + c(0,0,0,6))

if(format==96){

    png(spl.outfile,width=450, height=275)
    par(xpd = T, mar = par()$mar + c(0,0,0,6))

    plot(d$col, d$rownum, ylim = rev(range(d$rownum)), cex=3, pch=22, col="black", bg=d$type, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(13, 3,  c("unknown","positive","negative","blank"), fill=c("white", "green", "red", "grey", "lightblue"))
    axis(2, at=1:8, labels=LETTERS[1:8], las=2)
    axis(3, at=1:12, labels=1:12, xlab="Column")
    mtext("Column", side=3, line=3)
    dev.off()
}

if(format==384){

    png(spl.outfile, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$rownum, ylim = rev(range(d$rownum)), cex=2, pch=22, col="black", bg=d$type, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(26, 5,  c("unknown","positive","negative","blank","edge"), fill=c("white", "green", "red", "grey", "lightblue"))
    axis(2, at=1:16, labels=LETTERS[1:16], las=2)
    axis(3, at=1:24, labels=1:24, xlab="Column")
    mtext("Column", side=3, line=3)
       dev.off()
}

if(format==1536){
    png(spl.outfile, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$rownum, ylim = rev(range(d$rownum)), cex=1, pch=22, col="black", bg=d$type, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(52, 8,  c("unknown","positive","negative","blank","edge"), fill=c("white", "green", "red", "grey", "lightblue"))
    axis(2, at=1:32, labels=LETTERS[1:32], las=2)
    axis(3, at=1:48, labels=1:48, xlab="Column")
    mtext("Column", side=3, line=3)
   dev.off()
}

par(mar=c(5, 4, 4, 2) + 0.1)
 

