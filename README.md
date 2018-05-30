# Interactive visualization with iSEE

This repository contains the code required to construct the tours described in the _iSEE_ paper by Rue-Albrecht _et al._

**Note:** these tours can be resumed from within their respective iSEE application instance, using the question mark icon in the top-right corner of the _Shiny_ application ( <img src=img/help.png height="20" width="20"> ).

# Setting up the tours

## Overview

Each tour is composed of three files:

- `data.R`: a script that contains the instructions to pre-process the data into a `SummarizedExperiment` or `SingleCellExperiment` object ready for _iSEE_.
- `tour.txt`: a set of step-wise instructions attached to various UI elements in the _iSEE_ user interface.
- `app.R`: a script that uses the object generated by `data.R` to configure the _iSEE_ application and launch the tour.

To launch a tour, successively execute `data.R` and `app.R`.

## Allen

The `data.R` script uses the Allen data subset in the the [_scRNAseq_](http://bioconductor.org/packages/release/data/experiment/html/scRNAseq.html) Bioconductor package.
It performs a small number of pre-processing steps (e.g., normalization, dimensionality reduction) before saving a serialized `SingleCellExperiment` object to file.

**Live demo:** https://marionilab.cruk.cam.ac.uk/iSEE_allen

## TCGA

The `data.R` script fetches the TCGA data set from the Bioconductor [ExperimentHub](http://bioconductor.org/packages/release/bioc/html/ExperimentHub.html) in the form of an `ExpressionSet`.
It converts this to a `SingleCellExperiment` object and performs a small number of preprocessing steps (e.g., PCA, _t_-SNE) before saving the object to file.

**Note:** the first time that the script is run, it may take a few extra minutes, as it downloads and caches a copy of the data set if you haven't one already. 
Subsequent runs of the script will launch the tour significantly faster, as they will use the locally cached data set. 
Refer to the documentation of the [ExperimentHub](http://bioconductor.org/packages/release/bioc/html/ExperimentHub.html) for further details.

**Live demo:** https://marionilab.cruk.cam.ac.uk/iSEE_tcga

## PBMC 4K

This is somewhat more involved as the relevant data, while publicly available, need to be processed and analyzed.
This can be achieved by following these steps:

1. Download and unpack the PBMC 4K dataset from the [10X Genomics website](http://cf.10xgenomics.com/samples/cell-exp/2.1.0/pbmc4k/pbmc4k_raw_gene_bc_matrices.tar.gz).
2. Run the [analysis script](https://github.com/MarioniLab/EmptyDrops2017/tree/master/analysis/pbmc4k/analysis.Rmd).
Modify the `fname` variable according to the path to the unpacked PBMC data files.
3. Move the generated `sce.rds` object into `tours/` and run `pbmc4k_app.R`.

**Live demo:** https://marionilab.cruk.cam.ac.uk/iSEE_pbmc4k

## CyTOF

The `data.R` script downloads a preprocesed version of the data set from [Bodenmiller et al (2012)](https://www.nature.com/articles/nbt.2317). 
See the [`HDCytoData`](http://bioconductor.org/packages/HDCytoData/) package for more information about how the data was processed. 

**Live demo:** https://marionilab.cruk.cam.ac.uk/iSEE_cytof
