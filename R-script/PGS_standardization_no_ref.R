#! /bin/R
library(tidyverse)

args <- commandArgs(trailingOnly=T)
# args <- c("path/to/calculated/test.score.txt")
Tdf1 <- read.table(args[1], header=T)

# Normalization in test sample
Tdf2 <- Tdf1 %>% transmute(ID, N_PGS = scale(RAW_PGS))

# Percentiles
ncat <- 100
qcut <- quantile( Tdf2$N_PGS, seq(0,1,by=1/ncat) )
Tdf2$Percentile <- rep(1, nrow(Tdf2))
for(i in 1:ncat){
  eval(parse(text = paste0("Tdf2[Tdf2$N_PGS>qcut[",i,"], ]$Percentile <-",i)))
}

write.table(Tdf2, "Standerdized_PGS_no_ref.txt", row.names=F, quote=F)
