# Fungsi Penting <img src="https://img.shields.io/badge/r-%23276DC3.svg?&style=for-the-badge&logo=r&logoColor=white"/> 

Berikut beberapa fungsi yang cukup penting dan sering digunakan.

``` r
set.seed(270100)
df <- data.frame(x = rbinom(15, 50, 0.5),
                 y = rnorm(15, 27, 1),
                 z = rt(15, 23),
                 k = sample(c("Ya", "Tidak"), 15, replace = TRUE))
kable(df)
```

|    x|         y|           z| k     |
|----:|---------:|-----------:|:------|
|   21|  28.64692|   1.5320709| Ya    |
|   22|  27.17640|   0.8483414| Tidak |
|   32|  26.80549|   1.0705653| Tidak |
|   24|  26.63609|  -0.0908359| Ya    |
|   18|  26.84322|   0.5915476| Ya    |
|   25|  25.74436|  -0.2819205| Tidak |
|   21|  26.85257|  -1.5265474| Ya    |
|   23|  26.31573|  -0.7879903| Tidak |
|   29|  27.59268|  -1.9291701| Ya    |
|   23|  27.86027|  -1.0460351| Ya    |
|   25|  26.38646|  -0.1451511| Tidak |
|   31|  27.36337|  -0.9743630| Ya    |
|   27|  26.66182|   0.9548112| Tidak |
|   26|  28.70427|   0.6079854| Ya    |
|   23|  25.16610|   0.3247809| Ya    |

Fungsi `rowSums`
================

Fungsi ini digunakan untuk menjumlah perbaris, argument `na.rm = TRUE`
harus dicantumkan jika terdapat data yang NA.

``` r
rowSums(df[1:3], na.rm = TRUE)
```

    ##  [1] 51.17899 50.02474 59.87605 50.54526 45.43477 50.46244 46.32602 48.52774
    ##  [9] 54.66351 49.81423 51.24131 57.38901 54.61663 55.31226 48.49088

Fungsi `colSums`
================

Fungsi ini digunakan untuk menjumlah perkolom, argument `na.rm = TRUE`
harus dicantumkan jika terdapat data yang NA.

``` r
colSums(df[1:3], na.rm = TRUE)
```

    ##           x           y           z 
    ## 370.0000000 404.7557507  -0.8519109

Fungsi `rowMeans`
=================

Fungsi ini digunakan untuk untuk mencari rata-rata perbaris, argument
`na.rm = TRUE` harus dicantumkan jika terdapat data yang NA.

``` r
rowMeans(df[1:3], na.rm = TRUE)
```

    ##  [1] 17.05966 16.67491 19.95868 16.84842 15.14492 16.82081 15.44201 16.17591
    ##  [9] 18.22117 16.60474 17.08044 19.12967 18.20554 18.43742 16.16363

Fungsi `colMeans`
=================

Fungsi ini digunakan untuk untuk mencari rata-rata perkolom, argument
`na.rm = TRUE` harus dicantumkan jika terdapat data yang NA.

``` r
colMeans(df[1:3], na.rm = TRUE)
```

    ##           x           y           z 
    ## 24.66666667 26.98371671 -0.05679406

Fungsi `sample`
===============

Digunakan untuk mengambil sampel, argument `replace` digunakan untuk
mengatur apakah sampel diambil secara replacement atau tidak.

``` r
sample(df$x, 5, replace = TRUE)
```

    ## [1] 27 21 25 23 26

Fungsi `apply`
==============

`apply(X, MARGIN, FUN)`, argumen `MARGIN` untuk mengatur arah iterasi, 1
untuk perbaris dan 2 untuk perkolom. Argumen `FUN` diisi oleh fungsi
yang akan diterapkan periterasi.

Misalnya kita ingin mencari varians perkolom, maka `MARGIN = 2` dan
`FUN = var`

``` r
apply(df[1:3], 2, var)
```

    ##         x         y         z 
    ## 14.809524  0.927343  1.051908

Fungsi `lapply`
===============

Sama seperti `apply` tetapi hanya iterasi untuk perkolom. Kembalian dari
fungsi ini berupa `list`

``` r
lapply(df[1:3], sd)
```

    ## $x
    ## [1] 3.848314
    ## 
    ## $y
    ## [1] 0.9629865
    ## 
    ## $z
    ## [1] 1.025626

Fungsi `sapply`
===============

Sama seperti `lapply` tetapi yang dikembalikan berupa vector jika
dimensi setiap iterasinya 1 dan matrix jika lebih dari satu. Jika
berbeda maka akan dikembalikan sebagai list seperti fungsi `lapply`

``` r
sapply(df, is.numeric)
```

    ##     x     y     z     k 
    ##  TRUE  TRUE  TRUE FALSE

``` r
sapply(df[1:3], quantile)
```

    ##         x        y           z
    ## 0%   18.0 25.16610 -1.92917011
    ## 25%  22.5 26.51128 -0.88117663
    ## 50%  24.0 26.84322 -0.09083592
    ## 75%  26.5 27.47803  0.72816342
    ## 100% 32.0 28.70427  1.53207090

Fungsi `split`
==============

Digunakan untuk membagi data berdasarkan keriteria tertentu

``` r
split(df$x, df$k)
```

    ## $Tidak
    ## [1] 22 32 25 23 25 27
    ## 
    ## $Ya
    ## [1] 21 24 18 21 29 23 31 26 23

Fungsi `tapply`
===============

Digunakan untuk membagi data berdasarkan kriteria tertentu kemudian
menerapkan suatu fungsi pada setiap katagori

``` r
tapply(df$x, df$k, shapiro.test)
```

    ## $Tidak
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.90065, p-value = 0.3778
    ## 
    ## 
    ## $Ya
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.95845, p-value = 0.782

Tambahan
========

Setiap argumen `FUN` kita dapat mengirimkan fungsi buatan sendiri atau
fungsi anonymous.

``` r
lapply(df[1:3], function(x){
      c(max = max(x), 
        min = min(x),
        median = median(x))
})
```

    ## $x
    ##    max    min median 
    ##     32     18     24 
    ## 
    ## $y
    ##      max      min   median 
    ## 28.70427 25.16610 26.84322 
    ## 
    ## $z
    ##         max         min      median 
    ##  1.53207090 -1.92917011 -0.09083592

``` r
sapply(df[1:3], function(x){
      c(mean = mean(x), 
        sd = sd(x),
        var = var(x))
})
```

    ##              x          y           z
    ## mean 24.666667 26.9837167 -0.05679406
    ## sd    3.848314  0.9629865  1.02562586
    ## var  14.809524  0.9273430  1.05190840

``` r
tapply(df$x, df$k, function(x){
      c(mean = mean(x), 
        sd = sd(x),
        var = var(x))
})
```

    ## $Tidak
    ##      mean        sd       var 
    ## 25.666667  3.559026 12.666667 
    ## 
    ## $Ya
    ##      mean        sd       var 
    ## 24.000000  4.092676 16.750000
