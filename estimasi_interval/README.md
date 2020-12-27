# Estimasi Interval <img src="https://img.shields.io/badge/r-%23276DC3.svg?&style=for-the-badge&logo=r&logoColor=white"/> 


Materi
======

**Sumber Materi** 

1. [Statistika : Confidence Interval Estimation, CI
Proporsi, dan Contoh
Soal](https://wikiwoh.blogspot.com/2019/11/statistika-confidence-interval.html)

Estimasi interval menunjukkan pada interval berapa suatu parameter
populasi akan berada. Estimasi ini dibatasi oleh dua nilai, disebut
sebagai batas atas dan batas bawah, yang masing-masing mempunyai
simpangan 𝑑 dari estimatornya. Besarnya 𝑑 akan tergantung kepada ukuran
sampel acak yang digunakan tingkat keyakinan (level of confidence), dan
distribusi probabilitas untuk estimated value yang digunakan.

Estimasi Interval Rata-Rata
===========================

Varians Diketahui Populasi Terbatas
-----------------------------------

### Membuat Fungsi Sendiri

``` r
ci_mean_diketahui_terbatas <- function(x, var, N, alpa = 0.05, n = NULL){
      if(!is.numeric(x) | any(is.na(x))) 
         stop("Data harus numeric vector dan tidak mengandung NA")
      
      rata2 <- NULL
      if (!is.null(n)){
         rata2 <- x[1]   
      } else {
            n <- length(x)
            rata2 <- mean(x)
      }
      
      zhitung <- qnorm(alpa/2, lower.tail = FALSE)
      se <- sqrt(var/n)
      correction <- sqrt((N-n)/(N-1))
      
      ci <- rata2 + (c(-1, 1) * zhitung * se * correction)
      list(ci = paste(round(ci, 3) ,collapse=" - "),
           batas_atas = ci[2],
           batas_bawah = ci[1],
           mean = rata2,
           alpa = alpa,
           N = N,
           n = n,
           var = var)
}
```

### Membuat Data Dummy

``` r
N <- 30
n <- 20
var <- 9
miu <- 20
set.seed(2701)
data_coba <- rnorm(n, mean = miu, sd = sqrt(var))
data_coba
```

    ##  [1] 23.88155 18.14535 20.07918 20.47023 23.85762 17.38990 16.98155 16.38703
    ##  [9] 23.18458 19.88907 25.95686 15.43967 20.92321 23.83168 21.02230 23.66274
    ## [17] 21.14878 22.34624 24.48349 14.47755

### Membuat Selang Kepercayaan 10%

``` r
ci <- ci_mean_diketahui_terbatas(data_coba, var, N, alpa = 0.10)
kable(data.frame(ci))
```

| ci             |  batas\_atas|  batas\_bawah|      mean|  alpa|    N|    n|  var|
|:---------------|------------:|-------------:|---------:|-----:|----:|----:|----:|
| 20.03 - 21.326 |     21.32587|      20.02999|  20.67793|   0.1|   30|   20|    9|

``` r
ci <- ci_mean_diketahui_terbatas(mean(data_coba), var, N, alpa = 0.10, n = length(data_coba))
kable(data.frame(ci))
```

| ci             |  batas\_atas|  batas\_bawah|      mean|  alpa|    N|    n|  var|
|:---------------|------------:|-------------:|---------:|-----:|----:|----:|----:|
| 20.03 - 21.326 |     21.32587|      20.02999|  20.67793|   0.1|   30|   20|    9|

Varians Diketahui Populasi Tidak Terbatas
-----------------------------------------

### Membuat Fungsi Sendiri

``` r
ci_mean_diketahui_tidak_terbatas <- function(x, var, alpa = 0.05, n = NULL){
      if(!is.numeric(x) | any(is.na(x))) 
         stop("Data harus numeric vector dan tidak mengandung NA")
      
      rata2 <- NULL
      if (!is.null(n)){
         rata2 <- x[1]   
      } else {
            n <- length(x)
            rata2 <- mean(x)
      }
      
      zhitung <- qnorm(alpa/2,  lower.tail = FALSE)
      se <- sqrt(var/n)
      
      ci <- rata2 + (c(-1, 1) * zhitung * se)
      list(ci = paste(round(ci, 3) ,collapse=" - "),
           batas_atas = ci[2],
           batas_bawah = ci[1],
           mean = rata2,
           alpa = alpa,
           n = n,
           var = var)
}
```

### Membuat Data Dummy

``` r
n <- 25
var <- 13
miu <- 40
set.seed(127)
data_coba <- rnorm(n, mean = miu, sd = sqrt(var))
data_coba
```

    ##  [1] 37.95301 37.06234 38.21908 40.00656 42.95578 43.59386 42.71059 39.54733
    ##  [9] 42.03577 40.48137 39.61794 42.18471 40.04778 38.99481 39.51082 43.11211
    ## [17] 39.89252 37.32305 36.85021 39.00016 37.79945 44.80146 44.21733 41.58950
    ## [25] 33.72826

### Membuat Selang Kepercayaan 8%

``` r
ci <- ci_mean_diketahui_tidak_terbatas(data_coba, var, alpa = 0.08)
kable(data.frame(ci))
```

| ci              |  batas\_atas|  batas\_bawah|      mean|  alpa|    n|  var|
|:----------------|------------:|-------------:|---------:|-----:|----:|----:|
| 38.867 - 41.392 |     41.39187|      38.86699|  40.12943|  0.08|   25|   13|

``` r
ci <- ci_mean_diketahui_tidak_terbatas(mean(data_coba), 
                                       var, 
                                       alpa = 0.08, 
                                       n = length(data_coba))
kable(data.frame(ci))
```

| ci              |  batas\_atas|  batas\_bawah|      mean|  alpa|    n|  var|
|:----------------|------------:|-------------:|---------:|-----:|----:|----:|
| 38.867 - 41.392 |     41.39187|      38.86699|  40.12943|  0.08|   25|   13|

Varians Tidak Diketahui Populasi Terbatas
-----------------------------------------

### Membuat Fungsi Sendiri

``` r
ci_mean_tidak_diketahui_terbatas <- function(x, N, alpa = 0.05, n = NULL, sd = NULL){
      if(!is.numeric(x) | any(is.na(x))) 
         stop("Data harus numeric vector dan tidak mengandung NA")
      
      rata2 <- NULL
      if (!is.null(n)){
         if(is.null(sd)) stop("sd tidak boleh NULL")
         rata2 <- x[1]   
      } else {
         n <- length(x)
         rata2 <- mean(x)
         sd <- sd(x)
      }
      
      thitung <- qt(alpa/2, n - 1, lower.tail = FALSE)
      se <- sd/sqrt(n)
      correction <- sqrt((N-n)/(N-1))
      
      ci <- rata2 + (c(-1, 1) * thitung * se * correction)
      list(ci = paste(round(ci, 3) ,collapse=" - "),
           batas_atas = ci[2],
           batas_bawah = ci[1],
           mean = rata2,
           alpa = alpa,
           n = n,
           N = N,
           sd = var)
}
```

### Membuat Data Dummy

``` r
N <- 30
n <- 27
miu <- 45
set.seed(2701)
data_coba <- rnorm(n, mean = miu, sd = sqrt(23))
data_coba
```

    ##  [1] 51.20509 42.03514 45.12658 45.75171 51.16683 40.82747 40.17468 39.22427
    ##  [9] 50.09090 44.82266 54.52271 37.70980 46.47586 51.12536 46.63426 50.85529
    ## [17] 46.83646 48.75073 52.16736 36.17176 46.61055 52.81124 40.16588 47.52888
    ## [25] 47.75511 42.13505 48.53729

### Membuat Selang Kepercayaan 5%

``` r
ci <- ci_mean_tidak_diketahui_terbatas(data_coba, N)
kable(data.frame(ci))
```

| ci              |  batas\_atas|  batas\_bawah|      mean|  alpa|    n|    N|   sd|
|:----------------|------------:|-------------:|---------:|-----:|----:|----:|----:|
| 45.564 - 46.823 |     46.82276|      45.56383|  46.19329|  0.05|   27|   30|   13|

``` r
ci <- ci_mean_tidak_diketahui_terbatas(mean(data_coba), 
                                 N, 
                                 n = length(data_coba), 
                                 sd = sd(data_coba))
kable(data.frame(ci))
```

| ci              |  batas\_atas|  batas\_bawah|      mean|  alpa|    n|    N|   sd|
|:----------------|------------:|-------------:|---------:|-----:|----:|----:|----:|
| 45.564 - 46.823 |     46.82276|      45.56383|  46.19329|  0.05|   27|   30|   13|

Varians Tidak Diketahui Populasi Tidak Terbatas
-----------------------------------------------

### Membuat Fungsi Sendiri

``` r
ci_mean_tidak_diketahui_tidak_terbatas <- function(x, alpa = 0.05, n = NULL, sd = NULL){
      if(!is.numeric(x) | any(is.na(x))) 
         stop("Data harus numeric vector dan tidak mengandung NA")
      
      rata2 <- NULL
      if (!is.null(n)){
         if(is.null(sd)) stop("sd tidak boleh NULL")
         rata2 <- x[1]   
      } else {
         n <- length(x)
         rata2 <- mean(x)
         sd <- sd(x)
      }
      
      thitung <- qt(alpa/2, n-1,  lower.tail = FALSE)
      se <- sd/sqrt(n)
      
      ci <- rata2 + (c(-1, 1) * thitung * se)
      list(ci = paste(round(ci, 3) ,collapse=" - "),
           batas_atas = ci[2],
           batas_bawah = ci[1],
           mean = rata2,
           alpa = alpa,
           n = n,
           sd = sd)
}
```

### Membuat Data Dummy

``` r
n <- 27
var <- 13
miu <- 40
set.seed(2701)
data_coba <- rnorm(n, mean = miu, sd = sqrt(27))
data_coba
```

    ##  [1] 46.72305 36.78765 40.13714 40.81446 46.68159 35.47918 34.77189 33.74216
    ##  [9] 45.51585 39.80786 50.31759 32.10127 41.59905 46.63667 41.77068 46.34405
    ## [17] 41.98975 44.06381 47.76563 30.43484 41.74499 48.46327 34.76237 42.73997
    ## [25] 42.98509 36.89591 43.83256

### Membuat Selang Kepercayaan 3%

``` r
ci <- ci_mean_tidak_diketahui_tidak_terbatas(data_coba, alpa = 0.03)
kable(data.frame(ci))
```

| ci              |  batas\_atas|  batas\_bawah|     mean|  alpa|    n|        sd|
|:----------------|------------:|-------------:|--------:|-----:|----:|---------:|
| 38.925 - 43.661 |     43.66123|      38.92457|  41.2929|  0.03|   27|  5.360286|

``` r
ci <- ci_mean_tidak_diketahui_tidak_terbatas(mean(data_coba), 
                                       alpa = 0.03, 
                                       n = length(data_coba),
                                       sd = sd(data_coba))
kable(data.frame(ci))
```

| ci              |  batas\_atas|  batas\_bawah|     mean|  alpa|    n|        sd|
|:----------------|------------:|-------------:|--------:|-----:|----:|---------:|
| 38.925 - 43.661 |     43.66123|      38.92457|  41.2929|  0.03|   27|  5.360286|

Estimasi Interval Proporsi
==========================

Populasi Terbatas
-----------------

### Membuat Fungsi Sendiri

``` r
ci_proporsi_terbatas <- function(p, N, n, alpa = 0.05){
   if(length(p) > 2 | p > 1 | p < 0)
      stop("proporsi salah harus angka 0-1")
   
   zhitung <- qnorm(alpa/2, lower.tail = FALSE)
   se <- sqrt(p * (1 - p) / n)
   correction <- sqrt((N-n)/(N-1))
   
   ci <- p + (c(-1, 1) * zhitung * se * correction)
   list(ci = paste(round(ci, 3) ,collapse=" - "),
        batas_atas = ci[2],
        batas_bawah = ci[1],
        p = p,
        alpa = alpa,
        n = n,
        N = N)
}
```

### Test Fungsi

``` r
ci <- ci_proporsi_terbatas(0.6, 40, 20)
kable(data.frame(ci))
```

| ci            |  batas\_atas|  batas\_bawah|    p|  alpa|    n|    N|
|:--------------|------------:|-------------:|----:|-----:|----:|----:|
| 0.446 - 0.754 |    0.7537522|     0.4462478|  0.6|  0.05|   20|   40|

Populasi Tidak Terbatas
-----------------------

### Membuat Fungsi Sendiri

``` r
ci_proporsi_tidak_terbatas <- function(p, n, alpa = 0.05){
   if(length(p) > 2 | p > 1 | p < 0)
      stop("proporsi salah harus angka 0-1")
   
   zhitung <- qnorm(alpa/2, lower.tail = FALSE)
   se <- sqrt(p * (1 - p) / n)
   
   ci <- p + (c(-1, 1) * zhitung * se)
   list(ci = paste(round(ci, 3) ,collapse=" - "),
        batas_atas = ci[2],
        batas_bawah = ci[1],
        p = p,
        alpa = alpa,
        n = n)
}
```

### Test Fungsi

``` r
ci <- ci_proporsi_tidak_terbatas(0.6, 20)
kable(data.frame(ci))
```

| ci            |  batas\_atas|  batas\_bawah|    p|  alpa|    n|
|:--------------|------------:|-------------:|----:|-----:|----:|
| 0.385 - 0.815 |    0.8147033|     0.3852967|  0.6|  0.05|   20|

Sample Size
===========

Sample Size Mean
----------------

### Membuat Fungsi Sendiri

``` r
sample_size_mean <- function(sd, moe, alpa = 0.05){
   zhitung <- qnorm(alpa/2, lower.tail = FALSE)
   n <- ((zhitung * sd) / moe)^2
   list(n = n,
        sd = sd,
        moe = moe,
        alpa = alpa)
}
```

### Tes Fungsi

``` r
sample_size_mean(5, 2, alpa = 0.1)
```

    ## $n
    ## [1] 16.90965
    ## 
    ## $sd
    ## [1] 5
    ## 
    ## $moe
    ## [1] 2
    ## 
    ## $alpa
    ## [1] 0.1

Sample Size Proporsi
--------------------

### Membuat Fungsi Sendiri

``` r
sample_size_proporsi <- function(p, moe, alpa = 0.05){
   zhitung <- qnorm(alpa/2, lower.tail = FALSE)
   n <- p * (1 - p) * (zhitung / moe)^2
   list(n = n,
        p = p,
        moe = moe,
        alpa = alpa)
}
```

### Tes Fungsi

``` r
sample_size_proporsi(0.6, 0.05, alpa = 0.01)
```

    ## $n
    ## [1] 636.9501
    ## 
    ## $p
    ## [1] 0.6
    ## 
    ## $moe
    ## [1] 0.05
    ## 
    ## $alpa
    ## [1] 0.01

Pembahasan Latihan Soal
=======================

Nomor 1
-------

An electrical firm manufactures light bulbs that have a length of life
that is approximately normally distributed with a standard deviation of
40 hours. If a sample of 30 bulbs has an average life of 780 hours, find
a 96% confidence interval for the population mean of all bulbs produced
by this firm.

### Pembahasan Nomor 1

Dari soal diperoleh bahwa standard deviasi dari populasi diketahui
sehingga akan menggunkana rumus yang varians diketahui tetapi populasi
tidak terbatas

``` r
sd <- 40
n <- 30
x <- 780
alpa <- 0.04

ci <- ci_mean_diketahui_tidak_terbatas(x, 
                                       var = sd^2,
                                       alpa = alpa,
                                       n = 30)
ci$ci
```

    ## [1] "765.002 - 794.998"

Nomor 2
-------

Hitunglah 92% confident interval untuk rata-rata 2 variabel continues
pada data\_dummy\_komstat.csv

``` r
data <- read.csv("https://raw.githubusercontent.com/modul60stis/data/main/data_dummy_komstat.csv")
alpa <-  0.05

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

### Pembahasan Nomor 2

Pada data\_dummy\_komstat.csv terdapat 2 variabel continues, yaitu
`sebelum` dan `sesudah`. Varians populasi dari kedua varuabel tersebut
tidak diketahui

#### CI Variabel `sebelum`

``` r
ci <- ci_mean_tidak_diketahui_tidak_terbatas(data$sebelum, alpa = alpa)
kable(data.frame(ci))
```

| ci              |  batas\_atas|  batas\_bawah|      mean|  alpa|     n|        sd|
|:----------------|------------:|-------------:|---------:|-----:|-----:|---------:|
| 60.407 - 61.602 |     61.60198|       60.4069|  61.00444|  0.05|  1127|  10.22383|

#### CI Variabel `sesudah`

``` r
ci <- ci_mean_tidak_diketahui_tidak_terbatas(data$sesudah, alpa = alpa)
kable(data.frame(ci))
```

| ci              |  batas\_atas|  batas\_bawah|      mean|  alpa|     n|        sd|
|:----------------|------------:|-------------:|---------:|-----:|-----:|---------:|
| 60.427 - 61.814 |     61.81403|      60.42732|  61.12067|  0.05|  1127|  11.86325|

Nomor 3
-------

Sebuah percobaan dilakukan untuk mengetahui proporsi orang dewasa yang
mengalami sindrom kelelahan kronis. Dalam percobaan ini, 4000 orang
dipilih secara acak untuk melakukan survey. Suvey dilakukan dengan
bertanya: apakah mereka mengalami kelelahan yang tidak normal (kronis)
sehingga mengganggu aktivitas pekerjaan kantor atau pekerjaan rumah
tangga mereka selama 6 bulan terakhir ? Dari 3066 yang menjawab survey,
ada 590 orang yang mengalami kelelahn kronis Tentukan

1.  Berapakah point estimate untuk proporsi populasi orang dewasa yang
    mengalami kelelahan kronis?
2.  Buatlah confidence interval sebasar 95% untuk mengestimasi proporsi
    orang dewasa yang megalami kelelahan

### Pembahasan Nomor 3

``` r
n <- 3066
x <- 590
```

#### Point Estimate

``` r
p <- x / n
p
```

    ## [1] 0.1924331

#### CI 95%

``` r
ci <- ci_proporsi_tidak_terbatas(p, n)
kable(data.frame(ci))
```

| ci            |  batas\_atas|  batas\_bawah|          p|  alpa|     n|
|:--------------|------------:|-------------:|----------:|-----:|-----:|
| 0.178 - 0.206 |    0.2063869|     0.1784794|  0.1924331|  0.05|  3066|

Nomor 4
-------

Hitunglah 92% confident interval untuk proporsi mahasiwa yang merasa
puas dengan metode pengajaran yang digunakana pada
data\_dummy\_komstat.csv.

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

### Pembahasan Nomor 4

``` r
table(data$puas)
```

    ## 
    ## Tidak    Ya 
    ##   434   693

Dari hasil diatas diketahui bahwa banyaknya mahasiswa yang puas sebanyak
693 mahasiswa. Sehingg

``` r
x <- 693
n <- nrow(data)
p <- x/n
alpa <-  0.08

ci <- ci_proporsi_tidak_terbatas(p, n, alpa = alpa)
kable(data.frame(ci))
```

| ci          |  batas\_atas|  batas\_bawah|          p|  alpa|     n|
|:------------|------------:|-------------:|----------:|-----:|-----:|
| 0.59 - 0.64 |    0.6402835|     0.5895302|  0.6149068|  0.08|  1127|

Nomor 5
-------

A marketing agency wishes to determine the average time, in days, that
it takes to sell a product in various stores in a city. How large a
sample will they need in order to be 98% confident that their sample
mean will be within 2 days of the true mean? Assume that σ = 5 days.

### Pembahasan Nomor 5

``` r
sd <- 5
moe <- 2
alpa <- 0.02

sampleSize <- sample_size_mean(sd, moe, alpa = alpa)
sampleSize$n
```

    ## [1] 33.82434

