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

<div align=center>
    <img width=80% style=margin:2% src="Examples/results/band_sel_false_rgb.png">
</div>

The SVM classification results on the selected bands.

<div align=center>
    <img width=40% style=margin:2% src="Examples/results/band_sel_svm_acc.png">
</div>

### Component Analysis Example

<div align=center>
    <img width=50% style=margin:2% src="Examples/results/mixed_imgs.png">
    <div> Three mixed images </div>
</div>

<div align=center>
    <img width=50% style=margin:2% src="Examples/results/mixed_imgs_pca.png">
    <div> PCA </div>
</div>

<div align=center>
    <img width=50% style=margin:2% src="Examples/results/mixed_imgs_fastica.png">
    <div> FastICA </div>
</div>

<div align=center>
    <img width=50% style=margin:2% src="Examples/results/mixed_imgs_psa.png">
    <div> PSA </div>
</div>

<div align=center>
    <img width=50% style=margin:2% src="Examples/results/mixed_imgs_npsa.png">
    <div> NPSA </div>
</div>

### Dimension Reduction Example

<div align=center>
    <img width=40% style=margin:2% src="Examples/results/DR_data1.png">
</div>

<div align=center>
    <img width=80% style=margin:2% src="Examples/results/DR_data1_result.png">
</div>

<div align=center>
    <img width=40% style=margin:2% src="Examples/results/DR_data2.png">
</div>

<div align=center>
    <img width=80% style=margin:2% src="Examples/results/DR_data2_result.png">
</div>

<div align=center>
    <img width=40% style=margin:2% src="Examples/results/DR_data3.png">
</div>

<div align=center>
    <img width=80% style=margin:2% src="Examples/results/DR_data3_result.png">
</div>

### Image Registration Example

Anti-noise performance of image registration algorithms

<div align=center>
    <img width=80% style=margin:2% src="Examples/results/image_registration.png">
</div>

### Target Detection Example

Single target detection results of CEM, MF and SAM

<div align=center>
    <img width=60% style=margin:2% src="Examples/results/target_detection.png">
</div>

## Contributors

[![contributors](https://contrib.rocks/image?repo=shinyypig/hyperspectral_image_toolbox)](https://github.com/shinyypig/hyperspectral_image_toolbox/graphs/contributors)

Made with [contrib.rocks](https://contrib.rocks).
