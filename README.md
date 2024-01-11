## Introduction
In this paper,  we present a Multilinear Sparse Logistic Regression model with $\ell_0$-constraints ($\ell_0$-MLSR), which allows us to take tensor data directly as input, In contrast to the $\ell_1$-norm and $\ell_2$-norm, the $\ell_0$-norm constraint is better suited for feature selection. However, due to its nonconvex and nonsmooth properties, solving it is challenging and convergence guarantees are lacking. To tackle these challanges, we propose an Accelerated Proximal Alternating Linearized Minimization with Adaptive Momentum ($APALM^+$) to solve the $\ell_0$-MLSR model. 

This package contains code for the Multilinear Sparse Logistic Regression model with $\ell_0$-constraints ($\ell_0$-MLSR) problem in the paper[<sup>1</sup>](#refer-id). 

## Matlab code
A toy example explains how to use the MSLR function. For "MSLR", before running the script, please first add the toolbox 'tensortoolbox'[<sup>2</sup>](#refer-id) to the running path of matlab, and then run the function 'main_Run_me'. More descriptions about these functions can be found in their annotation part.

## Data
This code has built-in the synthesize data mentioned in paper[<sup>1</sup>](#refer-id). For the real dataset: (1) Concrete Crack Images[<sup>3</sup>](#refer-id) (2) Br35H :: Brain Tumor Detection[<sup>5</sup>](#refer-id), please go to the corresponding website to download.


## Reference
<div id="refer-id"></div>
[1]  Yang W, Min W. Globally Convergent Accelerated Algorithms for Multilinear Sparse Logistic Regression with ℓ0-constraints[J]. arXiv preprint arXiv:2309.09239, 2023

[2] Brett W. Bader and Tamara G. Kolda. 2006. Algorithm 862: MATLAB tensor classes for fast algorithm prototyping. ACM Trans. Math. Softw. 32, 4 (December 2006), 635–653. https://doi.org/10.1145/1186785.1186794

[3] L. Zhang, F. Yang, Y. D. Zhang, and Y. J. Zhu, “Road crack detection using deep convolutional neural network,” in EEE Int. Conf. Inf. Process., 2016, pp. 3708–3712

[4] H. AHMED, “Br35h :: Brain tumor detection 2020,” oct2022. [Online]. Available: https://www.kaggle.com/datasets/ahmedhamada0/brain-tumor-detection/code
