# Statistik Sederhana <img src="https://img.shields.io/badge/r-%23276DC3.svg?&style=for-the-badge&logo=r&logoColor=white"/> 

Load Library
------------

``` r
library(moments)
library(knitr)
```

Membuat Data Dummy
------------------

``` r
kelas <- c("3SD1", "3SD2", "3SI1", "3SI2")
data <- data.frame(ipk = sample(seq(2.5, 4, 0.01), 150, replace = TRUE),
                   kelas = sample(kelas, 150, replace = TRUE, prob = rep(0.25, 4)))
kable(head(data, 10))
```

|   ipk| kelas |
|-----:|:------|
|  3.75| 3SI2  |
|  3.65| 3SD2  |
|  3.30| 3SI1  |
|  2.98| 3SI2  |
|  2.57| 3SD2  |
|  3.23| 3SD2  |
|  3.01| 3SI1  |
|  3.73| 3SD1  |
|  3.10| 3SI2  |
|  3.10| 3SD1  |

Minimal
-------

### `min(x)`

Mencari nilai terkecil

``` r
min(data$ipk)
```

    ## [1] 2.5

### `which.min(x)`

Mencari index nilai terkecil

``` r
which.min(data$ipk)
```

    ## [1] 110

Yang berarti nilai terkecil pada variabel `ipk` ada pada index ke-29.
Kita dapat menggunakannya untuk mengambil data lengkapnya

``` r
data[which.min(data$ipk), ]
```

    ##     ipk kelas
    ## 110 2.5  3SD1

Median
------

### `median(x)`

``` r
median(data$ipk)
```

    ## [1] 3.24

### Membuat fungsi median sendiri

``` r
median_manual <- function(x){
      if(!is.numeric(x)) stop("Data harus numeric")
      
      n <- length(x)
      x <- sort(x)
      if(n %% 2 == 0){
            return((x[n/2] + x[(n/2) + 1]) / 2)
      }
      x[ceiling(n/2)]
}
```

``` r
median_manual(data$ipk)
```

    ## [1] 3.24

``` r
median_manual(data$kelas)
```

    ## Error in median_manual(data$kelas): Data harus numeric

Maksimal
--------

### `max(x)`

Mencari nilai terbesar

``` r
max(data$ipk)
```

    ## [1] 4

### `which.max(x)`

Mencari index nilai terbesar

``` r
which.max(data$ipk)
```

    ## [1] 87

Yang berarti nilai terkecil pada variabel `ipk` ada pada index ke-20.
Kita dapat menggunakannya untuk mengambil data lengkapnya

``` r
data[which.max(data$ipk), ]
```

    ##    ipk kelas
    ## 87   4  3SD2

Mean
----

### `mean(x)`

``` r
mean(data$ipk)
```

    ## [1] 3.263133

Modus
-----

Membuat fungsi sendiri

``` r
modus_manual <- function(x){
      if(!is.vector(x)) stop("Data harus vector")
      tabel_frekuesi <- table(x)
      tabel_frekuesi <- sort(tabel_frekuesi, decreasing = TRUE)
      modus_frekuensi <- as.numeric(tabel_frekuesi[1])
      modus <- NULL
      j <- 1
      for (i in 1:length(tabel_frekuesi)){
            if(tabel_frekuesi[i] == modus_frekuensi){
                  modus[j] <- names(tabel_frekuesi[i])
                  j <- j + 1
            }
            else
                  break
      }
      list(frekuensi = modus_frekuensi, modus = modus)
}
```

``` r
modus_manual(data$kelas)
```

    ## $frekuensi
    ## [1] 47
    ## 
    ## $modus
    ## [1] "3SD2"

``` r
modus_manual(data$ipk)
```

    ## $frekuensi
    ## [1] 4
    ## 
    ## $modus
    ## [1] "3.08"

``` r
modus_manual(data)
```

    ## Error in modus_manual(data): Data harus vector

Quartil
-------

### `quantile(x)`

``` r
quantile(data$ipk)
```

    ##     0%    25%    50%    75%   100% 
    ## 2.5000 2.9425 3.2400 3.6275 4.0000

``` r
quantile(data$ipk, probs = c(0.23, 0.27, 0.59, 0.91))
```

    ##    23%    27%    59%    91% 
    ## 2.8954 2.9723 3.3891 3.8859

Range
-----

Membuat fungsi sendiri

``` r
range_manual <- function(x){
      if(!is.numeric(x)) stop("Data harus numeric")
      max(x) - min(x)
}
```

``` r
range_manual(data$ipk)
```

    ## [1] 1.5

``` r
range_manual(data$kelas)
```

    ## Error in range_manual(data$kelas): Data harus numeric

Interquartil Range (IQR)
------------------------

Membuat fungsi sendiri

``` r
iqr_manual <- function(x){
      if(!is.numeric(x)) stop("Data harus numeric")
      q3 <- quantile(x, probs = c(0.75))
      q1 <- quantile(x, probs = c(0.25))
      as.numeric(q3 - q1)
}
```

``` r
iqr_manual(data$ipk)
```

    ## [1] 0.685

``` r
iqr_manual(data$kelas)
```

    ## Error in iqr_manual(data$kelas): Data harus numeric

Jumlah
------

``` r
sum(data$ipk)
```

    ## [1] 489.47

Sample Variance
---------------

### `var(x)`

``` r
var(data$ipk)
```

    ## [1] 0.1866901

### Membuat Fungsi Sendiri

``` r
var_manual <- function(x){
      if(!is.numeric(x)) stop("Data harus numeric")
      (sum((x - mean(x))^2)) / (length(x) - 1)
}
```

``` r
var_manual(data$ipk)
```

    ## [1] 0.1866901

``` r
var_manual(data$kelas)
```

    ## Error in var_manual(data$kelas): Data harus numeric

Standard Deviasi
----------------

### `sd(x)`

``` r
sd(data$ipk)
```

    ## [1] 0.4320765

### Membuat Fungsi Sendiri

``` r
sd_manual <- function(x){
      if(!is.numeric(x)) stop("Data harus numeric")
      varians <- (sum((x - mean(x))^2)) / (length(x) - 1)
      sqrt(varians)
}
```

``` r
sd_manual(data$ipk)
```

    ## [1] 0.4320765

``` r
sd_manual(data$kelas)
```

    ## Error in sd_manual(data$kelas): Data harus numeric

Skewness
--------

Untuk menghitung skewness dibutuhkan fungsi dari library `moments`.
Silahkan install terlebih dahulu `install.packages("moments")`

### `skewness(x)`

``` r
skewness(data$ipk)
```

    ## [1] -0.01528674

### Membuat Fungsi Sendiri

``` r
skewness_manual <- function(x){
      if(!is.numeric(x)) stop("Data harus numeric")
      n <- length(x)
      pembilang <- sum((x - mean(x))^3) / n
      penyebut <- (sum((x - mean(x))^2 / n))^(3/2)
      pembilang /penyebut
}
```

``` r
skewness_manual(data$ipk)
```

    ## [1] -0.01528674

``` r
skewness_manual(data$kelas)
```

    ## Error in skewness_manual(data$kelas): Data harus numeric

Kurtosis
--------

Untuk menghitung kurtosis dibutuhkan fungsi dari library `moments`.
Silahkan install terlebih dahulu `install.packages("moments")`

### `kurtosis(x)`

``` r
kurtosis(data$ipk)
```

    ## [1] 1.930914

### Membuat Fungsi Sendiri

``` r
kurtosis_manual <- function(x){
      if(!is.numeric(x)) stop("Data harus numeric")
      n <- length(x)
      pembilang <- sum((x - mean(x))^4) / n
      penyebut <- (sum((x - mean(x))^2 / n))^(2)
      pembilang /penyebut
}
```

``` r
kurtosis_manual(data$ipk)
```

    ## [1] 1.930914

``` r
kurtosis_manual(data$kelas)
```

    ## Error in kurtosis_manual(data$kelas): Data harus numeric

Tambahan
--------

### `summary(x)`

``` r
summary(data)
```

    ##       ipk           kelas          
    ##  Min.   :2.500   Length:150        
    ##  1st Qu.:2.942   Class :character  
    ##  Median :3.240   Mode  :character  
    ##  Mean   :3.263                     
    ##  3rd Qu.:3.627                     
    ##  Max.   :4.000

### `str(x)`

``` r
str(data)
```

    ## 'data.frame':    150 obs. of  2 variables:
    ##  $ ipk  : num  3.75 3.65 3.3 2.98 2.57 3.23 3.01 3.73 3.1 3.1 ...
    ##  $ kelas: chr  "3SI2" "3SD2" "3SI1" "3SI2" ...

### `dplyr::glimpse(x)`

``` r
dplyr::glimpse(data)
```

    ## Rows: 150
    ## Columns: 2
    ## $ ipk   <dbl> 3.75, 3.65, 3.30, 2.98, 2.57, 3.23, 3.01, 3.73, 3.10, 3.10, 3...
    ## $ kelas <chr> "3SI2", "3SD2", "3SI1", "3SI2", "3SD2", "3SD2", "3SI1", "3SD1...
