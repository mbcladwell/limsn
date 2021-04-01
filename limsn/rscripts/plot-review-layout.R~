rm(list=ls(all=TRUE))

## https://benfradet.github.io/blog/2014/04/30/Display-legend-outside-plot-R
## Rscript --vanilla plot-layout.R in.txt out.png 96

args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args) %in% c(0,1,2,3,4)) {
  stop("Error: args required: input, three output files and format", call.=FALSE)
}

## getwd()
## infile <- "../tmp/lyt-8221059232934462442676.txt"
## spl.outfile <- "./out.png"
##  spl.rep.out <- "./out2.png"
##  trg.rep.out <- "./out3.png"
## format <- 96
##
infile <- args[1]
spl.outfile <- args[2]
spl.rep.out <- args[3]
trg.rep.out <- args[4]
format <- args[5]


 d <- read.table(file=args[1], sep="\t", header=TRUE)
## d <- read.table( file = infile,   sep = "\t", header=TRUE)

palette(c("white", "green", "red", "grey", "lightblue"))
par(xpd = T, mar = par()$mar + c(0,0,0,6))

if(format==96){

    png(spl.outfile,width=450, height=275)
    par(xpd = T, mar = par()$mar + c(0,0,0,6))

    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=3, pch=22, col="black", bg=d$type, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(13, 3,  c("unknown","positive","negative","blank"), fill=c("white", "green", "red", "grey", "lightblue"))
    axis(2, at=1:8, labels=LETTERS[1:8], las=2)
    axis(3, at=1:12, labels=1:12, xlab="Column")
    mtext("Column", side=3, line=3)
    dev.off()

    palette(c("black","white","blue","lightblue"))
    png(spl.rep.out, width=450, height=275)
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=3, pch=22, col="black", bg=d$replicates, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(13, 3,  c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:8, labels=LETTERS[1:8], las=2)
    axis(3, at=1:12, labels=1:12, xlab="Column")
    mtext("Column", side=3, line=3)
    dev.off()

    png(trg.rep.out, width=450, height=275)
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=3, pch=22, col="black", bg=d$targets, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(13, 3,  c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:8, labels=LETTERS[1:8], las=2)
    axis(3, at=1:12, labels=1:12, xlab="Column")
    mtext("Column", side=3, line=3)
    dev.off()

}



if(format==384){

    png(spl.outfile, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=2, pch=22, col="black", bg=d$type, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(26, 5,  c("unknown","positive","negative","blank","edge"), fill=c("white", "green", "red", "grey", "lightblue"))
    axis(2, at=1:16, labels=LETTERS[1:16], las=2)
    axis(3, at=1:24, labels=1:24, xlab="Column")
    mtext("Column", side=3, line=3)
       dev.off()

    palette(c("black","white","blue","lightblue"))
    png(spl.rep.out, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=2, pch=22, col="white", bg=d$replicates, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(26, 5,  c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:16, labels=LETTERS[1:16], las=2)
    axis(3, at=1:24, labels=1:24, xlab="Column")
    mtext("Column", side=3, line=3)
    dev.off()

    png(trg.rep.out, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=2, pch=22, col="white", bg=d$targets, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(26, 5,  c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:16, labels=LETTERS[1:16], las=2)
    axis(3, at=1:24, labels=1:24, xlab="Column")
    mtext("Column", side=3, line=3)
       dev.off()

}




if(format==1536){

    
    png(spl.outfile, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=1, pch=22, col="black", bg=d$type, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(52, 8,  c("unknown","positive","negative","blank","edge"), fill=c("white", "green", "red", "grey", "lightblue"))
    axis(2, at=1:32, labels=LETTERS[1:32], las=2)
    axis(3, at=1:48, labels=1:48, xlab="Column")
    mtext("Column", side=3, line=3)
   dev.off()

    png(spl.rep.out, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    palette(c("black","white","blue","lightblue"))
        plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=1, pch=22, col="white", bg=d$replicates, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(52, 8, c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:32, labels=LETTERS[1:32], las=2)
    axis(3, at=1:48, labels=1:48, xlab="Column")
    mtext("Column", side=3, line=3)
   dev.off()

    png(trg.rep.out, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
        plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=1, pch=22, col="white", bg=d$targets, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(52, 8,  c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:32, labels=LETTERS[1:32], las=2)
    axis(3, at=1:48, labels=1:48, xlab="Column")
    mtext("Column", side=3, line=3)
   dev.off()


}


par(mar=c(5, 4, 4, 2) + 0.1)
 

