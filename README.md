# README

This is a toolbox for hyperspectral images, which is written by MATLAB(.m).

## Algorithms

### Band Selection

- [ECA](Papers/ECA.pdf) - Exemplar Component Analysis: A Fast Band Selection Method for Hyperspectral Imagery
- [EFDPC](Papers/EFDPC.pdf) - A Novel Ranking-Based Clustering Approach for Hyperspectral Band Selection
- [FVGBS](Papers/FVGBS.pdf) - Fast Volume Gradient Based Band Selection: A Fast Volume Gradient Based Band Selection Method for Hyperspectral_Image.
- [MNBS](Papers/MNBS.pdf) - A New Band Selection Method for Hyperspectral Image Based on Data Quality
- [OPBS](Papers/OPBS.pdf) - A Geometry-Based Band Selection Approach for Hyperspectral Image Analysis

### Clustering

- [CCA](Papers/CCA.pdf) - Clustering of Continuous Attributes
- [FSFDP](Papers/FSFDP.pdf) - Clustering by Fast Search and Find of Density Peaks
- [MeanShift](Papers/Meanshift.pdf) - Mean Shift Clustering
- [SC](Papers/SC.pdf) - Spectral Clustering
- [SNMF](Papers/SNMF.pdf) - Symmetric Non-negative Matrix Factorization for Graph Clustering

### Data Analysis

- [FastICA](Papers/FastICA.pdf) - Fast Independent Component Analysis
- [LLE](Papers/LLE.pdf) - Locally Linear Embedding
- [LS](Papers/LS.pdf) - Linear Least Squares Regression
- [MNF](Papers/MNF.pdf) - Minimum Noise Fraction
- [NNLS](Papers/NNLS.pdf) - Nonnegative Least Squares
- [PCA](Papers/PCA.pdf) - Principal Component Analysis
- [PSA](Papers/PSA.pdf) - Principal Skewness Analysis
- [TLS](Papers/TLS.pdf) - Total Least Squares

### Endmember Extraction

- [MVCNMF](Papers/MVCNMF.pdf) - Minimum Volume Constrained Nonnegative Matrix Factorization
- [NFINDR](Papers/NFINDER.pdf) - N-FINDR: an algorithm for fast autonomous spectral end-member determination in hyperspectral data

### Image Registration

- [ANCPS](Papers/ANCPS.pdf) - A New Translation Matching Method Based on Autocorrelated Normalized Cross-Power Spectrum
- [CSM](Papers/CSM.pdf) - Cyclic Shift Matrix - A New Tool for the Translation Matching Problem
- [HOGE](Papers/HOGE.pdf) - A Subspace Identification Extension to the Phase Correlation Method
- [IDFT_US](Papers/IDFT_US.pdf) - Efficient subpixel image registration algorithms
- [SVD_RANSAC](Papers/SVD_RANSAC.pdf) - A Novel Subpixel Phase Correlation Method Using Singular Value Decomposition and Unified Random Sample Consensus

### Target Detection

- [CEM](Papers/CEM.pdf) - Constrianed Energy Minimization
- MF - Matched Filter
- [MTCEM](Papers/MTCEM.pdf) - Multiple Targets Constrained Energy Minimization
- [MTICEM](Papers/MTICEM.pdf) - Multiple Targets Inequality Constrained Energy Minimization
- [SACE](Papers/SimplexACE.pdf) - Simplex ACE: a constrained subspace detector
- SAM - Spectral Angle Mapper

## Examples

### Band Selection Example

Select 3 bands to composite the false color image.

![Alt text](Examples/results/band_sel_false_rgb.png)

The SVM classification results on the selected bands.

![Alt text](Examples/results/band_sel_svm_acc.png)

### Component Analysis Example

Three mixed images.

![Mixed Images](Examples/results/mixed_imgs.png)

PCA

![Alt text](Examples/results/mixed_imgs_pca.png)

FastICA

![Alt text](Examples/results/mixed_imgs_fastica.png)

PSA

![Alt text](Examples/results/mixed_imgs_psa.png)

NPSA

![Alt text](Examples/results/mixed_imgs_npsa.png)

### Dimension Reduction Example

![Alt text](Examples/results/DR_data1.png)

![Alt text](Examples/results/DR_data1_result.png)

![Alt text](Examples/results/DR_data2.png)

![Alt text](Examples/results/DR_data2_result.png)

![Alt text](Examples/results/DR_data3.png)

![Alt text](Examples/results/DR_data3_result.png)

### Image Registration Example

Anti-noise performance of image registration algorithms

![Alt text](Examples/results/image_registration.png)

### Target Detection Example

Single target detection results of CEM, MF and SAM

![Alt text](Examples/results/target_detection.png)

## Contributors

[![contributors](https://contrib.rocks/image?repo=shinyypig/hyperspectral_image_toolbox)](https://github.com/shinyypig/hyperspectral_image_toolbox/graphs/contributors)

Made with [contrib.rocks](https://contrib.rocks).
