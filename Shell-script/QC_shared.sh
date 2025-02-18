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

# Extract reference loci from test data
for chr in $(seq 1 22); do
if [ ! -e $Ref/temp/test_QC2_chr$chr.pgen ]; then
plink2 --memory 32000 --threads 8 \
       --pfile $Ref/temp/test_QC1_chr$chr \
       --extract $Ref/temp/ref_QC1_chr$chr.pvar \
       --make-pgen --out $Ref/temp/test_QC2_chr$chr
fi
done

# Extract test loci from reference data
for chr in $(seq 1 22); do
if [ ! -e $Ref/temp/ref_QC2_chr$chr.pgen ]; then
plink2 --memory 32000 --threads 8 \
       --pfile $Ref/temp/ref_QC1_chr$chr \
       --extract $Ref/temp/test_QC2_chr$chr.pvar \
       --make-pgen --out $Ref/temp/ref_QC2_chr$chr
fi
done
