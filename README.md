## Introduction
Multilinear logistic regression  is a powerful tool for analyzing multidimensional data. To improve its efficiency and interpretability, we present a Multilinear Sparse Logistic Regression model with $\ell_0$ norm constraints ($\ell_0$-MSLR). In contrast to the $\ell_1$ norm and $\ell_2$ norm, the $\ell_0$ norm is more suitable for feature selection. However, due to its nonconvex and nonsmooth properties, solving $\ell_0$-MSLR is challenging and convergence guarantees are lacking. Additionally, the multilinear operation in $\ell_0$-MSLR also brings nonconvexity. To tackle these issues, we propose the Accelerated Proximal Alternating Linearization Method with Adaptive Momentum (APALM$^+$)  to solve the $\ell_0$-MSLR. We prove that APALM$^+$ ensures the convergence  of the $\ell_0$-MSLR and provides a practical convergent scheme based on APALM$^+$. Furthermore, we  prove the global convergence of APALM$^+$ and establish its convergence rate. To accelerate convergence, we also introduce an adaptive extrapolation strategy in APALM$^+$.  The numerical experiments demonstrate the effectiveness of our method. 

This package contains code for the Multilinear Sparse Logistic Regression model with $\ell_0$-constraints ($\ell_0$-MLSR) problem.

## Matlab code
A toy example explains how to use the L0MSLR function. 

Before running it, first add the toolbox 'tensortoolbox'[<sup>1</sup>](#refer-id) (www.tensortoolbox.org) to the running path of matlab, and then run the function 'main_Run_me'.  

## Data
This code has built-in the synthesize data mentioned in paper[<sup>1</sup>](#refer-id). For the real dataset: (1) Concrete Crack Images[<sup>3</sup>](#refer-id) (2) Br35H :: Brain Tumor Detection[<sup>4</sup>](#refer-id), please go to the corresponding website to download.


## Reference
<div id="refer-id"></div>

[1] Brett W. Bader and Tamara G. Kolda. 2006. Algorithm 862: MATLAB tensor classes for fast algorithm prototyping. ACM Trans. Math. Softw. 32, 4 (December 2006), 635–653. https://doi.org/10.1145/1186785.1186794

[2] L. Zhang, F. Yang, Y. D. Zhang, and Y. J. Zhu, “Road crack detection using deep convolutional neural network,” in EEE Int. Conf. Inf. Process., 2016, pp. 3708–3712

[3] H. AHMED, “Br35h :: Brain tumor detection 2020,” oct2022. [Online]. Available: https://www.kaggle.com/datasets/ahmedhamada0/brain-tumor-detection/code
