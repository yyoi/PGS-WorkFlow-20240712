#! /bin/bash

# Genotype QC for test samples
for chr in $(seq 1 22); do
if [ ! -e $Ref/temp/test_QC1_chr$chr.pgen ]; then

plink2 --memory 32000 --threads 8 \
       --pfile $test_genotype/chr$chr \
       --set-all-var-ids @:#:\$r:\$a \
       --new-id-max-allele-len 10000 \
       --minimac3-r2-filter 0.3 \
       --make-pgen --out $Ref/temp/test_QC1_chr$chr
fi
done

# Genotype QC for reference samples
for chr in $(seq 1 22); do
if [ ! -e $Ref/temp/ref_QC1_chr$chr.pgen ]; then

plink2 --memory 32000 --threads 8 \
       --pfile $ref_genotype/chr$chr \
       --set-all-var-ids @:#:\$r:\$a \
       --new-id-max-allele-len 10000 \
       --minimac3-r2-filter 0.3 \
       --make-pgen --out $Ref/temp/ref_QC1_chr$chr
fi
done