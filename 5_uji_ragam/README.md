# Uji Ragam <img src="https://img.shields.io/badge/r-%23276DC3.svg?&style=for-the-badge&logo=r&logoColor=white"/> 


Materi
======

**Acuan Materi**

1.  [One Variance Chi-Square Test](https://rpubs.com/mpfoley73/460916)
2.  [Compare Multiple Sample Variances in
    R](http://www.sthda.com/english/wiki/compare-multiple-sample-variances-in-r#compute-bartletts-test-in-r)

Pengujian hipotesis mengenai variansi populasi atau simpangan baku
berarti kita ingin menguji hipotesis mengenai keseragaman suatu populasi
ataupun membandingkan keseragaman suatu populasi dengan populasi
lainnya.

Uji Varians Satu Populasi
=========================

-   𝐻0: 𝜎= 𝜎0
-   𝐻1: 𝜎≠ 𝜎0 atau 𝜎 \< 𝜎0 atau 𝜎 \> 𝜎0

Membuat Fungsi Sendiri
----------------------

``` r
var_satu_pop <- function(x, sigma.squared, alpa = 0.05, alternative = "two.sided"){
      n <- length(x)
      df <- n - 1
      sample_variance <- var(x)
      chi_hitung <- (n - 1) * sample_variance / sigma.squared
      
      p_value <- if(alternative == "less"){
            pchisq(chi_hitung, df, lower.tail = TRUE)
      } else if(alternative == "greater") {
            pchisq(chi_hitung, df, lower.tail = FALSE)
      } else {
            2 * pchisq(chi_hitung, df, lower.tail = FALSE)
      }
      
      keputusan <- NULL
      if(alternative == "less"){
            batas <- qchisq(alpa, df)
            if (chi_hitung < batas)
                  keputusan <- "Tolak H0"
            else
                  keputusan <- "Gagal Tolak H0"
            alternative <- paste("less than", round(sigma.squared, 3))
      } else if(alternative == "greater"){
            batas <- qchisq(alpa, df, lower.tail = FALSE)
            if (chi_hitung > batas)
                  keputusan <- "Tolak H0"
            else
                  keputusan <- "Gagal Tolak H0"
            alternative <- paste("grater than", round(sigma.squared, 3))
      } else{
            alternative <- "two.sided"
            batas_atas <- qchisq(alpa / 2, df, lower.tail = FALSE)
            batas_bawah <- qchisq(alpa / 2, df)
            if (chi_hitung < batas_bawah | chi_hitung > batas_atas)
                  keputusan <- "Tolak H0"
            else
                  keputusan <- "Gagal Tolak H0"
            alternative <- paste("not equal", round(sigma.squared, 3))
      }
      
      list(statistic = chi_hitung,
           p_value = p_value,
           df = df,
           keputusan = keputusan,
           alpa = alpa,
           alternative = alternative,
           sample_var = sample_variance)
}
```

``` r
set.seed(27)
dummy <- rnorm(50, mean = 0, sd = 2)
result <- var_satu_pop(dummy, 2.5)
result
```

    ## $statistic
    ## [1] 107.0419
    ## 
    ## $p_value
    ## [1] 6.578941e-06
    ## 
    ## $df
    ## [1] 49
    ## 
    ## $keputusan
    ## [1] "Tolak H0"
    ## 
    ## $alpa
    ## [1] 0.05
    ## 
    ## $alternative
    ## [1] "not equal 2.5"
    ## 
    ## $sample_var
    ## [1] 5.461319

Menggunakan Function `varTest(x)` dari Package `EnvStats`
---------------------------------------------------------

``` r
# install.packages("EnvStats")
library(EnvStats)
varTest(dummy, sigma.squared = 2.5, alternative = "two.sided")
```

    ## 
    ##  Chi-Squared Test on Variance
    ## 
    ## data:  dummy
    ## Chi-Squared = 107.04, df = 49, p-value = 6.579e-06
    ## alternative hypothesis: true variance is not equal to 2.5
    ## 95 percent confidence interval:
    ##  3.810815 8.480601
    ## sample estimates:
    ## variance 
    ## 5.461319

Uji Varians Dua Populasi
========================

Uji yang digunakan adalah uji F. Uji F sangat sensitif terhadap asumsi
kenormalan, oleh karena sebaiknya data perlu memenuhi asumsi kenormalan.

-   𝐻0: 𝜎1= 𝜎2
-   𝐻1: 𝜎1 ≠ 𝜎2 atau 𝜎1 \< 𝜎2 atau 𝜎1 \> 𝜎2

Menggunakan Function `var.test(x, y)`
-------------------------------------

Nilai dari parameter alternative
`alternative = c("two.sided"", "less", "greater")`

``` r
x <- rnorm(40, mean = 27, sd = sqrt(10))
y <- rnorm(40, mean = 23, sd = sqrt(11))
var.test(x, y, alternative = "greater")
```

    ## 
    ##  F test to compare two variances
    ## 
    ## data:  x and y
    ## F = 1.6762, num df = 39, denom df = 39, p-value = 0.05549
    ## alternative hypothesis: true ratio of variances is greater than 1
    ## 95 percent confidence interval:
    ##  0.9833944       Inf
    ## sample estimates:
    ## ratio of variances 
    ##           1.676161

Uji Varians Tiga Populasi atau Lebih
====================================

Uji Bartlett
------------

Uji ini digunakan untuk melihat kesamaan varians dari beberapa populasi
yang berdistribusi normal. Hipotesa yang digunakan pada uji Bartlett
adalah sebagai berikut:

-   𝐻0: 𝜎1 = 𝜎2 = … = 𝜎𝑘
-   𝐻1: Setidaknya ada satu 𝜎𝑖 yang tidak sama

Di R kita dapat menggunakan function `bartlett.test(formula, data)`

``` r
data(PlantGrowth)
kable(dplyr::sample_n(PlantGrowth, 10))
```

|  weight| group |
|-------:|:------|
|    5.33| ctrl  |
|    4.17| ctrl  |
|    4.81| trt1  |
|    4.61| ctrl  |
|    5.58| ctrl  |
|    4.32| trt1  |
|    5.17| ctrl  |
|    5.37| trt2  |
|    4.69| trt1  |
|    4.89| trt1  |

``` r
bartlett.test(weight ~ group, data = PlantGrowth)
```

    ## 
    ##  Bartlett test of homogeneity of variances
    ## 
    ## data:  weight by group
    ## Bartlett's K-squared = 2.8786, df = 2, p-value = 0.2371

Uji Levene
----------

Uji Levene merupakan metode pengujian homogenitas varians yang hampir
sama dengan uji Bartlett. Perbedaan uji Levene dengan uji Bartlett yaitu
bahwa data yang diuji dengan uji Levene tidak harus berdistribusi
normal, namun harus kontinu. Hipotesis

-   𝐻0: 𝜎1 = 𝜎2 = … = 𝜎𝑘
-   𝐻1: Setidaknya ada satu 𝜎𝑖 yang tidak sama

Di R kita dapat menggunakan function `leveneTest.test(formula, data)`
dari package `car`

``` r
# install.packages("car")
library(car)
leveneTest(weight ~ group, data = PlantGrowth)
```

    ## Levene's Test for Homogeneity of Variance (center = median)
    ##       Df F value Pr(>F)
    ## group  2  1.1192 0.3412
    ##       27

Pembahasan Latihan Soal
=======================

Dengan menggunakan data\_dummy\_komstat.csv dan 𝛼 = 0.05

``` r
alpa <- 0.05
data <- read.csv("https://raw.githubusercontent.com/modul60stis/data/main/data_dummy_komstat.csv")
kable(head(data, 10))
```

|  sebelum|  sesudah| jenis\_kelamin | metode | puas  |
|--------:|--------:|:---------------|:-------|:------|
|       72|       64| Laki-Laki      | B      | Tidak |
|       51|       43| Laki-Laki      | C      | Tidak |
|       51|       59| Laki-Laki      | D      | Tidak |
|       66|       65| Perempuan      | B      | Ya    |
|       51|       56| Laki-Laki      | A      | Ya    |
|       63|       61| Laki-Laki      | A      | Ya    |
|       57|       50| Perempuan      | A      | Ya    |
|       65|       61| Perempuan      | C      | Ya    |
|       64|       58| Laki-Laki      | A      | Ya    |
|       73|       82| Perempuan      | B      | Ya    |

Nomor 1
-------

Ujilah apakah variabel sebelum memiliki 𝜎=10?

### Pembahasan Nomor 1

Dengan menggunakan fungsi buatan sendiri

``` r
var_satu_pop(data$sebelum, 10^2)
```

    ## $statistic
    ## [1] 1176.97
    ## 
    ## $p_value
    ## [1] 0.2836008
    ## 
    ## $df
    ## [1] 1126
    ## 
    ## $keputusan
    ## [1] "Gagal Tolak H0"
    ## 
    ## $alpa
    ## [1] 0.05
    ## 
    ## $alternative
    ## [1] "not equal 100"
    ## 
    ## $sample_var
    ## [1] 104.5266

Dengan menggunakan `varTest`

``` r
varTest(data$sebelum, sigma.squared = 100)
```

    ## 
    ##  Chi-Squared Test on Variance
    ## 
    ## data:  data$sebelum
    ## Chi-Squared = 1177, df = 1126, p-value = 0.2836
    ## alternative hypothesis: true variance is not equal to 100
    ## 95 percent confidence interval:
    ##   96.4026 113.7281
    ## sample estimates:
    ## variance 
    ## 104.5266

Terlihat bahwa hasilnya sama, p-value sebesar 0.2836 yang berarti gagal
tolak H0, maka dengan tingkat signifikansi 5% diperoleh cukup bukti
bahwa variabel `sebelum` memiliki `𝜎=10`

Nomor 2
-------

Ujilah apakah variabel sebelum dan sesudah memiliki varians yang sama?

### Pembahasan Nomor 2

Uji normalitas terlebih dahulu, yang akan digunakan adalah uji Shapiro
Wilk

``` r
shapiro.test(data$sebelum)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  data$sebelum
    ## W = 0.99836, p-value = 0.3633

Diperoleh bahwa variabel `sebelum` berdistribusi normal

``` r
shapiro.test(data$sesudah)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  data$sesudah
    ## W = 0.9987, p-value = 0.588

Diperoleh bahwa variabel `sesudah` berdistribusi normal

``` r
var.test(data$sebelum, data$sesudah)
```

    ## 
    ##  F test to compare two variances
    ## 
    ## data:  data$sebelum and data$sesudah
    ## F = 0.74271, num df = 1126, denom df = 1126, p-value = 6.347e-07
    ## alternative hypothesis: true ratio of variances is not equal to 1
    ## 95 percent confidence interval:
    ##  0.6607853 0.8347922
    ## sample estimates:
    ## ratio of variances 
    ##          0.7427102

Terlihat bahwa nilai p-value sangat kecil, jauh lebih kecil dari 0.05,
maka tolak H0. Sehingga dengan tingkat signifikansi 5% diperoleh cukup
bukti bahwa keduanya memiliki varians yang berbeda

Nomor 3
-------

Jika variabel sebelum dan sesudah masing-masing dikelompokkan
berdasarkan metode apakah memiliki varians yang sama?

### Pembahasan Nomor 3

Akan digunakan Uji Levene. Jika ingin menggunakan Uji Bartlett maka
silahkan lakukan uji kenormalan terlebih dahulu

#### Variabel `sebelum`

``` r
leveneTest(sebelum ~ factor(metode), data = data)
```

    ## Levene's Test for Homogeneity of Variance (center = median)
    ##         Df F value Pr(>F)
    ## group    3  1.3418 0.2593
    ##       1123

Terlihat bahwa p-value lebih besar dari 0.05, jadi gagal tolak H0, yang
berarti dengan tingkat signifikansi 5% variabel `sebelum` jika
dikelompokkan berdasarkan metode memiliki varians yang sama

#### Variabel `sesudah`

``` r
leveneTest(sesudah ~ factor(metode), data = data)
```

    ## Levene's Test for Homogeneity of Variance (center = median)
    ##         Df F value Pr(>F)
    ## group    3  1.3612 0.2532
    ##       1123

Terlihat bahwa p-value lebih besar dari 0.05, jadi gagal tolak H0, yang
berarti dengan tingkat signifikansi 5% variabel `sesudah` jika
dikelompokkan berdasarkan metode memiliki varians yang sama

