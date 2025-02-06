# PGS Standardization Overview 

Example pipeline for PGS standardization.

__For details,__
* Sutoh Y, Hachiya T, Otsuka-Yamasaki Y, Tokutomi T, Yoshida A, Kotozaki Y, Komaki S, Minabe S, Ohmomo H, Tanno K, Fukushima A, Sasaki M, Shimizu A. Reference-Based Standardization Approach Stabilizing Small Batch Risk Prediction via Polygenic Score. Genet Epidemiol. 2025 Mar;49(2):e70002. doi: 10.1002/gepi.70002. PMID: 39888077.

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
