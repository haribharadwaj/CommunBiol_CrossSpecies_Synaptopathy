
[![DOI](https://zenodo.org/badge/505630380.svg)](https://zenodo.org/badge/latestdoi/505630380)


# Cross-species Study on Cochlear Synaptopathy with "Normal" Audiograms

This repository contains data files associated with the manuscript titled **Cross-Species Experiments Reveal Widespread Cochlear Neural Damage in Normal Hearing** submitted to  [Communications Biology](https://www.nature.com/commsbio/). An early pre-print of the manuscript can be found on [BioRxiv: 2021.03.17.435900 (doi: 10.1101/2021.03.17.435900)](https://www.biorxiv.org/content/10.1101/2021.03.17.435900v1).

## Data
The data is organized into three directories: ```Human```, ```Chinchilla```, and ```Common```. 

The ```Human``` directory contains two ```.csv``` files, one with wideband middle-ear muscle reflex (WB-MEMR) data, and one with auditory brainstem response (ABR) data. Data are provided for each of the 166 participants (55 young controls/YCtrl, 53 young individuals with regular and substantial acoustic overexposure/YExp, and 58 middle-aged subjects/MA) individually. The two files contain a commons set of subject IDs, and columns providing information about individual age, gender, group, audiometric thresholds, and DPOAE amplitudes. Audiometric thresholds are provided averaged over three frequency ranges: 0.25 -- 2 kHz (```LFA```), 3 -- 8 kHz (```HFA```), and 9 -- 16 kHz (```EHFA```), and provided in dB HL units. DPOAE amplitudes are provided averaged over two frequency ranges: 3 -- 8 kHz (```DPhfa```) and (```DPehfa```), and provided in dB EPL (emitted-pressure level) units.

The ```Chinchilla``` directory contains two files, one with wideband middle-ear muscle reflex (WB-MEMR) data, and one with auditory brainstem response (ABR) data. Data are provided for each of the 7 chinchillas and for each time point measured. MEMR data are provided pre-, 1-day post-, and 2-weeks post-noise exposure. ABR data are provided pre- and 2-weeks post-noise exposure. In addition to the two files, the ```Chinchilla``` directory contains a subdirectory called ```MAT``` with MATLAB format files (i.e., ```.mat```) with a copy of the WB-MEMR and ABR data and additional DPOAE and histology data. Plotting scripts (```.m``` files) that regenerate the chinchilla plots in the manuscript are included with the ```.mat``` files as references to help understand the structure of the data in the ```.mat``` files. The ```.m``` files were tested using MATLAB Version: 9.4.0.813654 (R2018a) on macOS.

The ```Common``` directory contains two files. The ```Human_and_Chin_Stats.txt``` file contains a copy of the R code that performs all the statistical analyses on ABR and WB-MEMR data reported in the manuscript and their corresponding tabular outputs. The ```.csv``` files in the ```Human``` and ```Chinchilla``` directories serve as inputs to the R code. The ```EffectSizes.txt``` file contains estimates of effect size for the different measures and the multi-measure classifier plotted in Figure 3 of the manuscript.

Please reach out to the manuscript authors with any questions about the data or the plotting scripts.

