#! /bin/R
library(tidyverse)

args <- commandArgs(trailingOnly=T)
# args <- c("path/to/calculated/test.score.txt", "path/to/calculated/reference.score.txt")
Tdf1 <- read.table(args[1], header=T)
Rdf1 <- read.table(args[2], header=T)

# Rormalization in reference
m <- mean(Rdf1$RAW_PGS)
s <- sd(Rdf1$RAW_PGS)
Tdf2 <- Tdf1 %>% transmute(ID, N_PGS = ((RAW_PGS - m)/s))
Rdf2 <- Rdf1 %>% transmute(ID, N_PGS = ((RAW_PGS - m)/s))

# Percentiles
ncat <- 100
qcut <- quantile( Rdf2$N_PGS, seq(0,1,by=1/ncat) )
Tdf2$Percentile <- rep(1, nrow(Tdf2))
for(i in 1:ncat){
  eval(parse(text = paste0("Tdf2[Tdf2$N_PGS>qcut[",i,"], ]$Percentile <-",i)))
}

write.table(Tdf2, "Standerdized_PGS_ref_based.txt", row.names=F, quote=F)