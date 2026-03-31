# snakemake-course

Short setup for the Carpentries Snakemake novice bioinformatics course.

## Quick start

1. Create the course environment:

```bash
bash create-snakemake-env.sh
```

2. Activate it:

```bash
conda activate snakemake_carpentry
```

3. Check Snakemake:

```bash
snakemake --version
```

## Course data

The dataset is already included in this repository at:

- `snakemake_data/yeast/reads`
- `snakemake_data/yeast/transcriptome`

## Course revision notes
Install setq instead of FastX since the latter is no longer maintained

```bash
conda install -c bioconda seqtk
```

Use these paths as inputs while following the lesson:
https://carpentries-incubator.github.io/snakemake-novice-bioinformatics/index.html