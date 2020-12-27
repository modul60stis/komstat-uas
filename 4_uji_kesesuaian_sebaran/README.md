# Uji Kesesuaian Sebaran <img src="https://img.shields.io/badge/r-%23276DC3.svg?&style=for-the-badge&logo=r&logoColor=white"/> 


Materi
======

Uji kesesuaian sebaran pada materi ini adalah uji untuk melakukan
pengecekan apakah suatu data berdistribusi normal. Hipotesis dari semua
uji yang akan dibahas sama, yaitu

-   𝐻0: Data berdistribusi normal
-   𝐻1: Data tidak berdistribusi normal

Membuat data dummy
==================

### Data berdistribusi normal

``` r
set.seed(2723)
dummy_norm <- rnorm(50, 27, sqrt(23))
dummy_norm
```

    ##  [1] 31.17126 31.05598 26.93315 29.66166 22.24312 20.83230 20.92326 26.10414
    ##  [9] 28.75785 23.86136 27.59223 27.46114 30.82559 25.93974 28.97678 25.24196
    ## [17] 22.59223 23.05779 20.24926 29.45516 27.15233 28.01285 19.59500 22.12638
    ## [25] 25.80775 23.56267 15.51518 22.99072 32.16207 24.40146 29.57614 27.70869
    ## [33] 35.04665 34.82811 34.05753 34.08465 29.14900 27.86116 25.44591 20.91063
    ## [41] 25.61489 19.07522 27.30061 22.90432 31.58831 22.33621 22.70829 27.88953
    ## [49] 26.42955 20.53732

### Data berdistribusi Gamma

``` r
set.seed(2237)
dummy_gamma <- rgamma(50, shape = 10)
dummy_gamma
```

    ##  [1]  7.704054  9.444606  9.841791 11.892850  8.990946  9.894848 12.023878
    ##  [8]  8.741898  9.111445  6.753723 15.919930  6.976781  3.263417  8.263437
    ## [15]  7.442802 16.023644  9.705553 17.536949  8.564302  7.985756  6.817293
    ## [22]  8.910658 19.690223 16.759936 11.871948  7.748258 10.298802 14.508502
    ## [29] 11.068361  6.656177 18.469707  9.070994 12.513637  9.917839  7.372027
    ## [36] 10.808952 10.193247 10.846344  6.405234  7.022348 14.856935 13.483191
    ## [43] 11.484229 10.447651 12.666103 16.503415 10.860345  8.622881  4.839212
    ## [50]  7.541841

Uji Shapiro Wilk
================

Uji Shapiro-Wilk digunakan sebagai uji kenormalan data. Untuk
menggunakan uji ini dapat menggunakan function `shapiro.test(x)`

### Cek kenormalan pada data `dummy_norm`

``` r
shapiro.test(dummy_norm)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  dummy_norm
    ## W = 0.98521, p-value = 0.7806

Terlihat bahwa p-value lebih besar dari 0.05, sehingga dengan tingkat
signifikansi 5% kita gagal menolak H0 dan menyimpulkan bahwa data
berdistribusi normal

### Cek kenormalan pada data `dummy_gamma`

``` r
shapiro.test(dummy_gamma)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  dummy_gamma
    ## W = 0.94882, p-value = 0.03052

Terlihat bahwa p-value lebih kecil dari 0.05, sehingga dengan tingkat
signifikansi 5% kita menolak H0 dan menyimpulkan bahwa data tidak
berdistribusi normal

Uji Liliefors
=============

Untuk menggunakan uji ini dapat menggunakan function `lillie.test(x)`
dari package `nortest`

``` r
# install.packages("nortest")
library(nortest)
```

### Cek kenormalan pada data `dummy_norm`

``` r
lillie.test(dummy_norm)
```

    ## 
    ##  Lilliefors (Kolmogorov-Smirnov) normality test
    ## 
    ## data:  dummy_norm
    ## D = 0.079357, p-value = 0.6005

Terlihat bahwa p-value lebih besar dari 0.05, sehingga dengan tingkat
signifikansi 5% kita gagal menolak H0 dan menyimpulkan bahwa data
berdistribusi normal

### Cek kenormalan pada data `dummy_gamma`

``` r
lillie.test(dummy_gamma)
```

    ## 
    ##  Lilliefors (Kolmogorov-Smirnov) normality test
    ## 
    ## data:  dummy_gamma
    ## D = 0.11877, p-value = 0.07527

Terlihat bahwa p-value lebih besar dari 0.05, sehingga dengan tingkat
signifikansi 5% kita gagal menolak H0 dan menyimpulkan bahwa data
berdistribusi normal. Ini berarti data berdistribusi gamma juga
disimpulkan berdistribusi normal oleh Liliefors Test.

Uji Kolmogorov Smirnov
======================

Untuk menggunakan uji ini dapat menggunakan function `ks.test(x)`. Uji
Kolmogorov Smirnov ini sebenarnya tidak hanya untuk menguji kenormalan
tetapi dapat untuk menguji sebaran distribusi lainnya

### Cek kenormalan pada data `dummy_norm`

Untuk mengujinya kita harus menspesifikasikan nilai `mean` dan `sd`

``` r
ks.test(dummy_norm, "pnorm", mean = 27, sd = sqrt(23))
```

    ## 
    ##  One-sample Kolmogorov-Smirnov test
    ## 
    ## data:  dummy_norm
    ## D = 0.11637, p-value = 0.4724
    ## alternative hypothesis: two-sided

Terlihat bahwa p-value lebih besar dari 0.05, sehingga dengan tingkat
signifikansi 5% kita gagal menolak H0 dan menyimpulkan bahwa data
berdistribusi normal dengan `mean = 27` dan `sd = sqrt(23)`

### Cek kenormalan pada data `dummy_gamma`

``` r
ks.test(dummy_gamma, "pnorm", mean = 27, sd = sqrt(23))
```

    ## 
    ##  One-sample Kolmogorov-Smirnov test
    ## 
    ## data:  dummy_gamma
    ## D = 0.94235, p-value = 8.882e-16
    ## alternative hypothesis: two-sided

Terlihat bahwa p-value lebih kecil dari 0.05, sehingga dengan tingkat
signifikansi 5% kita menolak H0 dan menyimpulkan bahwa data tidak
berdistribusi normal

### Menggunakan Shapiro Wilk untuk melihat apakah data berdistribusi gamma

-   𝐻0: Data berdistribusi gamma
-   𝐻1: Data tidak berdistribusi gamma

``` r
ks.test(dummy_gamma, "pgamma", shape = 10)
```

    ## 
    ##  One-sample Kolmogorov-Smirnov test
    ## 
    ## data:  dummy_gamma
    ## D = 0.094965, p-value = 0.7222
    ## alternative hypothesis: two-sided

Terlihat p-value yang sangat besar yang berarti kita gagal menolak H0,
sehingga data dapat disimpulkan berdistribusi gamma dengan `shape = 10`

Pembahasan Latihan Soal
=======================

``` r
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

Ujilah apakah dua variabel continue pada data\_dummy\_komstat.csv
berdistribusi normal?

### Pembahasan Nomor 1

#### Cek normalitas pada variabel `sebelum`

``` r
shapiro.test(data$sebelum)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  data$sebelum
    ## W = 0.99836, p-value = 0.3633

Terlihat bahwa p-value lebih besar dari 0.05, sehingga dengan tingkat
signifikansi 5% kita gagal menolak H0 dan menyimpulkan bahwa variabel
`sebelum` berdistribusi normal

#### Cek normalitas pada variabel `sesudah`

``` r
shapiro.test(data$sesudah)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  data$sesudah
    ## W = 0.9987, p-value = 0.588

Terlihat bahwa p-value lebih besar dari 0.05, sehingga dengan tingkat
signifikansi 5% kita gagal menolak H0 dan menyimpulkan bahwa variabel
`sesudah` berdistribusi normal

Nomor 2
-------

Jika variabel sebelum dan sesudah pada data\_dummy\_komstat.csv dibagi
berdasarkan metode apakah berdistribusi normal?

### Pembahasan Nomor 2

#### Cek normalitas pada variabel `sebelum`

``` r
tapply(data$sebelum, data$metode, shapiro.test)
```

    ## $A
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.99353, p-value = 0.2863
    ## 
    ## 
    ## $B
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.99303, p-value = 0.1827
    ## 
    ## 
    ## $C
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.99568, p-value = 0.6294
    ## 
    ## 
    ## $D
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.99425, p-value = 0.3841

Terlihat untuk semua metode p-value lebih besar dari 0.05, sehingga
dapat disimpulkan untuk variabel `sebelum` jika dikatagori berdasarkan
metode semuanya berdistribusi normal

#### Cek normalitas pada variabel `sesudah`

``` r
tapply(data$sesudah, data$metode, shapiro.test)
```

    ## $A
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.99515, p-value = 0.5443
    ## 
    ## 
    ## $B
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.99455, p-value = 0.3715
    ## 
    ## 
    ## $C
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.99518, p-value = 0.5284
    ## 
    ## 
    ## $D
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.99607, p-value = 0.7235

Terlihat untuk semua metode p-value lebih besar dari 0.05, sehingga
dapat disimpulkan untuk variabel `sesudah` jika dikatagori berdasarkan
metode semuanya berdistribusi normal

