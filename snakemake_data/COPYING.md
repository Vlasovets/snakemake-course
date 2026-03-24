# Sample dataset for Snakemake Novice Bioinformatics course

This sample dataset is intended for use with the course found at:

https://github.com/carpentries-incubator/snakemake-novice-bioinformatics

# Short read data

These originate from a dataset lodged in [ArrayExpress at EBI][1]:

https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-4044

As per the [BioStudies terms of use][2] "New datasets in BioStudies are released into the public
domain under the terms of a Creative Commons Zero (CC0) waiver". This means you may legally use
the files for any purpose without attribution. However, if you do re-use the dataset it is basic
academic courtesy to state the accession *E-MTAB-4044*, and cite the paper:

> Lahtvee PJ, Kumar R, Hallström BM, Nielsen J.
> Adaptation to different types of stress converge on mitochondrial metabolism.
> Mol Biol Cell. 2016;27(15):2505-2514. doi:10.1091/mbc.E16-03-0187

The subset of the dataset included here was selected by the authors of the Snakemake lesson.

# Yeast transcriptome

This was downloaded from the [Ensembl yeast database][3], specifically this location:

https://ftp.ensembl.org/pub/release-100/fasta/saccharomyces_cerevisiae/cdna/

The description provided by Ensemble states that:

> The data on this site is a direct import of the Saccharomyces Genome Database (SGD) dataset for
> the Saccharomyces cerevisiae S288C genome. The assembly provided is R64-1-1, supplemented with
> additional cross-references and annotations. The protein-coding and non-coding gene model
> annotation was imported from SGD in April 2018. This gene set is based on Liachko et al. 2013

The [SGD website][4] provides full information on appropriate citation of their genome builds,
but the appropriate papers to cite regarding this reference sequence are:

> Engel SR, Dietrich FS, Fisk DG, Binkley G, Balakrishnan R, Costanzo MC, Dwight SS, Hitz BC,
> Karra K, Nash RS, Weng S, Wong ED, Lloyd P, Skrzypek MS, Miyasato SR, Simison M, Cherry JM. (2013)
> The Reference Genome Sequence of Saccharomyces cerevisiae: Then and Now. G3 (Bethesda).
> 2013 Dec 27. pii: g3.113.008995v1. doi: 10.1534/g3.113.008995. [PMID: 24374639]

> Liachko I, Youngblood RA, Keich U, Dunham MJ.
> High-resolution mapping, characterization, and optimization of autonomously replicating sequences
> in yeast. Genome Res. 2013;23(4):698-704. doi:10.1101/gr.144659.112

[1]: https://www.ebi.ac.uk/biostudies/arrayexpress
[2]: https://www.ebi.ac.uk/biostudies/help
[3]: https://www.ensembl.org/Saccharomyces_cerevisiae/Info/Index
[4]: https://sites.google.com/view/yeastgenome-help/about/how-to-cite-sgd
