# PGS Standardization Overview 

Example pipeline for PGS standardization.


## QC 1: Use reference and native variants

```bash
sbatch -c 8 --mem-per-cpu=4G ./Shell-script/QC_native.sh
```

## QC 2: Use reference and shared variants

```bash
sbatch -c 8 --mem-per-cpu=4G ./Shell-script/QC_shared.sh
```

## PGS calculation
Calculate scores for test and reference data based on any model using a conventional tool such as Plink2. 


## Standardization 1: Standardizing in a test batch (conventional standardizing)
Expected data format: 
ID RAW_PGS

```bash
data="path/to/calculated/test.score.txt"
Rscript ./R-script/PGS_standardization_no_ref.R $data
```

## Standardization 2: Standardization of a test batch in a reference ("reference-based" approach)

```bash
data="path/to/calculated/test.score.txt"
ref="path/to/calculated/reference.score.txt"
Rscript ./R-script/PGS_standardization_ref_based.R $data $ref
```
