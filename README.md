# Hyperspectral from RGB/Multispectral

This is a MATLAB implementation of the hyperspectral estimation procedure described in the paper "[Sparse Recovery of Hyperspectral Signal from Natural RGB Images](https://www.cs.bgu.ac.il/~obs/Publications/2016-Arad_and_Ben_Shahar-Sparse_Recovery_of_Hyperspectral_Signal_from_Natural_RGB_Images.pdf)" by B. Arad and O. Ben-Shahar. Additional details can be found on the [Project Page](http://icvl.cs.bgu.ac.il/hyperspectral-imaging/) under the Ben-Gurion University [Interdisiplnary Computational Vision Laboratory website](http://icvl.cs.bgu.ac.il/).

If you use this code in your work, please cite “Arad and Ben-Shahar, Sparse Recovery of Hyperspectral Signal from Natural RGB Images, in the European Conference on Computer Vision, Amsterdam, The Netherlands, October 11–14, 2016”
```
@inproceedings{arad_and_ben_shahar_2016_ECCV,
  title={Sparse Recovery of Hyperspectral Signal from Natural RGB Images},
  author={Arad, Boaz and Ben-Shahar, Ohad},
  booktitle={European Conference on Computer Vision},
  pages={19--34},
  year={2016},
  organization={Springer}
}
```
## Prerequisites
* MATLAB (Obviously) 
* OMP-Box v10
* KSVD-Box v13

The last two can be found here: http://www.cs.technion.ac.il/~ronrubin/software.html

## Getting Started

First, download and install all the above prerequisites. Once OMP-Box and KSVD-Box are installed checkout the repository and review **shredExample.m** for usage examples.

Please note that accurate reconstruction of hyperspectral images depends heavily on the quality of the hyperspectral dictionary used for reconstruction. 

**sample_dict.mat** includes a dictionary precomputed from images in the [BGU ICVL Natural Hyperspectral Image Database](http://icvl.cs.bgu.ac.il/hyperspectral/), and should demonstrate good performance over this data set. 

When comparing performance of HS reconstruction algorithms over the ICVL data set, or any other data set, we recommend that you:
* Optimize the dictionary for your target domain.
* Avoid using test/target images for dictionary construction.

If you are uncertain as to how to do any of the above, feel free to consult the authors.

## Code Authors

* **Boaz Arad** - https://github.com/boazarad


## License and Contributions

Please contact the authors regarding usage rights and contributions. 

While we are likely to allow free use for academic reseach and educational uses, commercial and private applications will require licensing.

