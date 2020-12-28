# Uji Rata-Rata <img src="https://img.shields.io/badge/r-%23276DC3.svg?&style=for-the-badge&logo=r&logoColor=white"/> 


Materi
======

**Acuan Materi**

1.  [Student’s t-test in R and by
    hand](https://statsandr.com/blog/student-s-t-test-in-r-and-by-hand-how-to-compare-two-groups-under-different-scenarios/#scenario-1-independent-samples-with-2-known-variances-1)
2.  [t
    test](http://www.sthda.com/english/wiki/t-test#:~:text=t%20test%20is%20used%20to,to%20a%20theoretical%20value%20mu.&text=The%20one%2Dsample%20t%20test,two%20unrelated%20groups%20of%20samples.)

Uji beda T (Uji T) adalah salah satu teknik analisis dalam ilmu
statistika yang digunakan untuk mengetahui signifikansi perbedaan dan
membuat kesimpulan tentang suatu populasi berdasarkan data dari sampel
yang diambil dari populasi itu. Teknik uji beda t dilakukan atas data
rasio atau interval. Teknik yang dilakukan dengan membandingkan nilai
mean. Statistik uji ini digunakan dalam pengujian hipotesis.
Asumsi/syarat uji –t :

-   Data berdistribusi normal
-   Skala rasio/Interval
-   Sampel independen

Membuat Data Dummy
==================

``` r
set.seed(220037)
x <- rnorm(100, mean = 1, sd = 2)
set.seed(220037)
y <- rnorm(100, mean = 0, sd = 1)
```

Uji Satu Populasi
=================

𝐻0: 𝜇= 𝜇0 𝐻1: 𝜇≠ 𝜇0 atau 𝜇\< 𝜇0 atau 𝜇\> 𝜇0

Varians Diketahui
-----------------

### Membuat Fungsi Sendiri

``` r
t.test_satu_pop_diketahui <- function(x, sigma.squared, miu0 = 0, alpa = 0.05, alternative = "two.sided"){
      n <-length(x)
      rata2 <- mean(x)
      zhitung <- (rata2 - miu0) / (sqrt(sigma.squared / n))
      if(alternative == "less"){
            alternative <- paste("less than", miu0)
            p_value <- pnorm(zhitung)
      } else if(alternative == "greater"){
            alternative <- paste("greater than", miu0)
            p_value <- pnorm(zhitung, lower.tail = FALSE)
      } else {
            alternative <- paste("not equal", miu0)
            p_value <- 2 * pnorm(abs(zhitung), lower.tail = FALSE)
      }
      
      keputusan <- if(p_value < alpa){
            "Tolak H0"
      } else {
            "Gagal Tolak H0"
      }
      
      list(statistic = zhitung,
           p_value = p_value,
           n = n,
           mean_sample = rata2,
           keputusan = keputusan,
           alpa = alpa,
           alternative = alternative,
           var_pop = sigma.squared)
}
```

### Mencoba Fungsi Buatan

``` r
result <- t.test_satu_pop_diketahui(x, sigma.squared = 5, miu0 = 1)
kable(data.frame(result))
```

|   statistic|   p\_value|    n|  mean\_sample| keputusan      |  alpa| alternative |  var\_pop|
|-----------:|----------:|----:|-------------:|:---------------|-----:|:------------|---------:|
|  -0.7121295|  0.4763846|  100|      0.840763| Gagal Tolak H0 |  0.05| not equal 1 |         5|

Varians Tidak Diketahui
-----------------------

### Membuat Fungsi Sendiri

``` r
t.test_satu_pop_tidak_diketahui <- function(x, miu0 = 0, alpa = 0.05, alternative = "two.sided"){
      n <-length(x)
      df <- n - 1
      rata2 <- mean(x)
      var_sample <- var(x)
      thitung <- (rata2 - miu0) / (sqrt(var_sample / n))
      if(alternative == "less"){
            alternative <- paste("less than", miu0)
            p_value <- pt(thitung, df)
      } else if(alternative == "greater"){
            alternative <- paste("greater than", miu0)
            p_value <- pt(thitung, df, lower.tail = FALSE)
      } else {
            alternative <- paste("not equal", miu0)
            p_value <- 2 * pt(abs(thitung), df, lower.tail = FALSE)
      }
      
      keputusan <- if(p_value < alpa){
            "Tolak H0"
      } else {
            "Gagal Tolak H0"
      }
      
      list(statistic = thitung,
           p_value = p_value,
           n = n,
           df = df,
           mean_sample = rata2,
           keputusan = keputusan,
           alpa = alpa,
           alternative = alternative,
           var_sample = var_sample)
}
```

### Mencoba Fungsi Buatan

``` r
result <- t.test_satu_pop_tidak_diketahui(x, miu0 = 0.9, alternative = "less")
kable(data.frame(result))
```

|   statistic|   p\_value|    n|   df|  mean\_sample| keputusan      |  alpa| alternative   |  var\_sample|
|-----------:|----------:|----:|----:|-------------:|:---------------|-----:|:--------------|------------:|
|  -0.2589808|  0.3980939|  100|   99|      0.840763| Gagal Tolak H0 |  0.05| less than 0.9 |     5.231798|

### Menggunakan Fungsi `t.test()`

``` r
t.test(x, mu = 0.9 , alternative = "less")
```

    ## 
    ##  One Sample t-test
    ## 
    ## data:  x
    ## t = -0.25898, df = 99, p-value = 0.3981
    ## alternative hypothesis: true mean is less than 0.9
    ## 95 percent confidence interval:
    ##      -Inf 1.220546
    ## sample estimates:
    ## mean of x 
    ##  0.840763

Uji Dua Populasi Independent
============================

𝐻0: 𝜇1−𝜇2 = 𝑑0 𝐻1: 𝜇1−𝜇2 ≠ 𝑑0 atau 𝜇1−𝜇2\< 𝑑0 atau 𝜇1−𝜇2\> 𝑑0

Varians Diketahui
-----------------

``` r
t.test_dua_pop_diketahui <- function(x, y, V1, V2, miu0 = 0, alpa = 0.05, alternative = "two.sided") {
      M1 <- mean(x)
      M2 <- mean(y)
      n1 <- length(x)
      n2 <- length(y)
      sigma1 <- sqrt(V1)
      sigma2 <- sqrt(V2)
      
      se <- sqrt((V1 / n1) + (V2 / n2))
      statistic <- (M1 - M2 - miu0) / se
      
      p_value <- if (alternative == "greater") {
            alternative <- paste("difference mean greater than", miu0)
            pnorm(statistic, lower.tail = FALSE)
      } else if (alternative == "less") {
            alternative <- paste("difference mean less than", miu0)
            pnorm(statistic, lower.tail = TRUE)
      } else {
            alternative <- paste("difference mean not equal", miu0)
            2 * pnorm(abs(statistic), lower.tail = FALSE)
      }
      
      keputusan <- if(p_value < alpa){
            "Tolak H0"
      } else {
            "Gagal Tolak H0"
      }
      
      list(statistic = statistic, 
           p.value = p_value,
           alpa = alpa,
           keputusan = keputusan,
           alternative = alternative,
           mean1 = M1, 
           mean2 = M2, 
           sigma1 = sigma1, 
           sigma2 = sigma2,
           n1 = n1,
           n2 = n2,
           se = se)
}
```

### Mencoba Fungsi Buatan

``` r
result <- t.test_dua_pop_diketahui(x, y, 2, 1, miu0 = 1)
kable(data.frame(result))
```

<table style="width:100%;">
<colgroup>
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 4%" />
<col style="width: 12%" />
<col style="width: 22%" />
<col style="width: 7%" />
<col style="width: 8%" />
<col style="width: 7%" />
<col style="width: 5%" />
<col style="width: 3%" />
<col style="width: 3%" />
<col style="width: 8%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">statistic</th>
<th style="text-align: right;">p.value</th>
<th style="text-align: right;">alpa</th>
<th style="text-align: left;">keputusan</th>
<th style="text-align: left;">alternative</th>
<th style="text-align: right;">mean1</th>
<th style="text-align: right;">mean2</th>
<th style="text-align: right;">sigma1</th>
<th style="text-align: right;">sigma2</th>
<th style="text-align: right;">n1</th>
<th style="text-align: right;">n2</th>
<th style="text-align: right;">se</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">-0.4596776</td>
<td style="text-align: right;">0.6457476</td>
<td style="text-align: right;">0.05</td>
<td style="text-align: left;">Gagal Tolak H0</td>
<td style="text-align: left;">difference mean not equal 1</td>
<td style="text-align: right;">0.840763</td>
<td style="text-align: right;">-0.0796185</td>
<td style="text-align: right;">1.414214</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">100</td>
<td style="text-align: right;">100</td>
<td style="text-align: right;">0.1732051</td>
</tr>
</tbody>
</table>

Varians Tidak Diketahui dan Diasumsikan Sama
--------------------------------------------

### Membuat Fungsi Sendiri

``` r
t.test_var_equal <- function(x, y, miu0 = 0, alpa = 0.05, alternative = "two.sided"){
      M1 <- mean(x)
      M2 <- mean(y)
      var1 <- var(x)
      var2 <- var(y)
      n1 <- length(x)
      n2 <- length(y)
      df <- n1 + n2 - 2
      
      tmp1 <- (n1 -1) * var1
      tmp2 <- (n2 - 1) * var2
      sp <- sqrt((tmp1 + tmp2) / df)
      
      se <- sp * sqrt((1/n1) + (1/n2))
      
      thitung <- (M1 - M2 - miu0) / se
      
      p_value <- if (alternative == "greater") {
            alternative <- paste("difference mean greater than", miu0)
            pt(thitung, df, lower.tail = FALSE)
      } else if (alternative == "less") {
            alternative <- paste("difference mean less than", miu0)
            pt(thitung, df, lower.tail = TRUE)
      } else {
            alternative <- paste("difference mean not equal", miu0)
            2 * pt(abs(thitung), df, lower.tail = FALSE)
      }
      
      keputusan <- if(p_value < alpa){
            "Tolak H0"
      } else {
            "Gagal Tolak H0"
      }
      
      list(statistic = thitung, 
           p.value = p_value,
           alpa = alpa,
           keputusan = keputusan,
           alternative = alternative,
           df = df,
           mean1 = M1, 
           mean2 = M2, 
           var1 = var1, 
           var2 = var2,
           n1 = n1,
           n2 = n2,
           se = se)
}
```

### Mencoba Fungsi Buatan

``` r
result <- t.test_var_equal(x, y, alternative = "greater", miu0 = 0.5)
kable(data.frame(result))
```

<table style="width:100%;">
<colgroup>
<col style="width: 7%" />
<col style="width: 7%" />
<col style="width: 3%" />
<col style="width: 11%" />
<col style="width: 25%" />
<col style="width: 3%" />
<col style="width: 6%" />
<col style="width: 8%" />
<col style="width: 6%" />
<col style="width: 6%" />
<col style="width: 3%" />
<col style="width: 3%" />
<col style="width: 7%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">statistic</th>
<th style="text-align: right;">p.value</th>
<th style="text-align: right;">alpa</th>
<th style="text-align: left;">keputusan</th>
<th style="text-align: left;">alternative</th>
<th style="text-align: right;">df</th>
<th style="text-align: right;">mean1</th>
<th style="text-align: right;">mean2</th>
<th style="text-align: right;">var1</th>
<th style="text-align: right;">var2</th>
<th style="text-align: right;">n1</th>
<th style="text-align: right;">n2</th>
<th style="text-align: right;">se</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">1.643853</td>
<td style="text-align: right;">0.0508967</td>
<td style="text-align: right;">0.05</td>
<td style="text-align: left;">Gagal Tolak H0</td>
<td style="text-align: left;">difference mean greater than 0.5</td>
<td style="text-align: right;">198</td>
<td style="text-align: right;">0.840763</td>
<td style="text-align: right;">-0.0796185</td>
<td style="text-align: right;">5.231798</td>
<td style="text-align: right;">1.30795</td>
<td style="text-align: right;">100</td>
<td style="text-align: right;">100</td>
<td style="text-align: right;">0.2557293</td>
</tr>
</tbody>
</table>

### Menggunakan Fungsi `t.test`

``` r
t.test(x, y, var.equal = TRUE, alternative = "greater", mu = 0.5)
```

    ## 
    ##  Two Sample t-test
    ## 
    ## data:  x and y
    ## t = 1.6439, df = 198, p-value = 0.0509
    ## alternative hypothesis: true difference in means is greater than 0.5
    ## 95 percent confidence interval:
    ##  0.4977669       Inf
    ## sample estimates:
    ##  mean of x  mean of y 
    ##  0.8407630 -0.0796185

Varians Tidak Diketahui dan Diasumsikan Tidak Sama
--------------------------------------------------

### Membuat Fungsi Sendiri

``` r
t.test_var_not_equal <- function(x, y, miu0 = 0, alpa = 0.05, alternative = "two.sided"){
      M1 <- mean(x)
      M2 <- mean(y)
      var1 <- var(x)
      var2 <- var(y)
      n1 <- length(x)
      n2 <- length(y)
      
      tmp1 <- var1 / n1
      tmp2 <- var2 / n2
      se <- sqrt(tmp1 + tmp2)
      
      df <- (tmp1 + tmp2)^2
      tmp1 <- tmp1^2 / (n1-1)
      tmp2 <- tmp2^2 / (n2-1)
      df <- df / (tmp1 + tmp2)
      
      thitung <- (M1 - M2 - miu0) / se
      
      p_value <- if (alternative == "greater") {
            alternative <- paste("difference mean greater than", miu0)
            pt(thitung, df, lower.tail = FALSE)
      } else if (alternative == "less") {
            alternative <- paste("difference mean less than", miu0)
            pt(thitung, df, lower.tail = TRUE)
      } else {
            alternative <- paste("difference mean not equal", miu0)
            2 * pt(abs(thitung), df, lower.tail = FALSE)
      }
      
      keputusan <- if(p_value < alpa){
            "Tolak H0"
      } else {
            "Gagal Tolak H0"
      }
      
      list(statistic = thitung, 
           p.value = p_value,
           alpa = alpa,
           keputusan = keputusan,
           alternative = alternative,
           df = df,
           mean1 = M1, 
           mean2 = M2, 
           var1 = var1, 
           var2 = var2,
           n1 = n1,
           n2 = n2,
           se = se)
}
```

### Mencoba Fungsi Buatan

``` r
result <- t.test_var_not_equal(x, y, miu0 = 1.5)
kable(data.frame(result))
```

<table>
<colgroup>
<col style="width: 7%" />
<col style="width: 7%" />
<col style="width: 3%" />
<col style="width: 7%" />
<col style="width: 23%" />
<col style="width: 6%" />
<col style="width: 6%" />
<col style="width: 8%" />
<col style="width: 6%" />
<col style="width: 6%" />
<col style="width: 3%" />
<col style="width: 3%" />
<col style="width: 7%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">statistic</th>
<th style="text-align: right;">p.value</th>
<th style="text-align: right;">alpa</th>
<th style="text-align: left;">keputusan</th>
<th style="text-align: left;">alternative</th>
<th style="text-align: right;">df</th>
<th style="text-align: right;">mean1</th>
<th style="text-align: right;">mean2</th>
<th style="text-align: right;">var1</th>
<th style="text-align: right;">var2</th>
<th style="text-align: right;">n1</th>
<th style="text-align: right;">n2</th>
<th style="text-align: right;">se</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">-2.266531</td>
<td style="text-align: right;">0.0248925</td>
<td style="text-align: right;">0.05</td>
<td style="text-align: left;">Tolak H0</td>
<td style="text-align: left;">difference mean not equal 1.5</td>
<td style="text-align: right;">145.5882</td>
<td style="text-align: right;">0.840763</td>
<td style="text-align: right;">-0.0796185</td>
<td style="text-align: right;">5.231798</td>
<td style="text-align: right;">1.30795</td>
<td style="text-align: right;">100</td>
<td style="text-align: right;">100</td>
<td style="text-align: right;">0.2557293</td>
</tr>
</tbody>
</table>

### Menggunkan Fungsi `t.test`

``` r
t.test(x, y, var.equal = FALSE, mu = 1.5)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  x and y
    ## t = -2.2665, df = 145.59, p-value = 0.02489
    ## alternative hypothesis: true difference in means is not equal to 1.5
    ## 95 percent confidence interval:
    ##  0.414960 1.425803
    ## sample estimates:
    ##  mean of x  mean of y 
    ##  0.8407630 -0.0796185

Uji Dua Populasi Dependent
==========================

Membuat Fungsi Sendiri
----------------------

``` r
t.test_paired <- function(x, y, miu0 = 0, alpa = 0.05, alternative = "two.sided"){
      d <- x - y
      n <-length(d)
      df <- n - 1
      rata2_d <- mean(d)
      var_d <- var(d)
      thitung <- (rata2_d - miu0) / (sqrt(var_d / n))
      if(alternative == "less"){
            alternative <- paste("less than", miu0)
            p_value <- pt(thitung, df)
      } else if(alternative == "greater"){
            alternative <- paste("greater than", miu0)
            p_value <- pt(thitung, df, lower.tail = FALSE)
      } else {
            alternative <- paste("not equal", miu0)
            p_value <- 2 * pt(abs(thitung), df, lower.tail = FALSE)
      }
      
      keputusan <- if(p_value < alpa){
            "Tolak H0"
      } else {
            "Gagal Tolak H0"
      }
      
      list(statistic = thitung,
           p_value = p_value,
           n = n,
           df = df,
           mean_sample_d = rata2_d,
           keputusan = keputusan,
           alpa = alpa,
           alternative = alternative,
           var_sample_d = var_d)
}
```

Mencoba Fungsi Buatan
---------------------

``` r
result <- t.test_paired(x, y, alternative = "less", miu0 = 1)
kable(data.frame(result))
```

|   statistic|   p\_value|    n|   df|  mean\_sample\_d| keputusan      |  alpa| alternative |  var\_sample\_d|
|-----------:|----------:|----:|----:|----------------:|:---------------|-----:|:------------|---------------:|
|  -0.6961751|  0.2439752|  100|   99|        0.9203815| Gagal Tolak H0 |  0.05| less than 1 |         1.30795|

Menggunakan Fungsi `t.test`
---------------------------

``` r
t.test(x, y, paired = TRUE, alternative = "less", mu = 1)
```

    ## 
    ##  Paired t-test
    ## 
    ## data:  x and y
    ## t = -0.69618, df = 99, p-value = 0.244
    ## alternative hypothesis: true difference in means is less than 1
    ## 95 percent confidence interval:
    ##      -Inf 1.110273
    ## sample estimates:
    ## mean of the differences 
    ##               0.9203815

Pembahasan Latihan Soal
=======================

Dengan menggunakan data\_dummy\_komstat.csv

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

Dengan 𝛼=0.05, ujilah apakah variabel sebelum memiliki 𝜇\>65, jika
diketahui 𝜎=10?

### Pembahasan Nomor 1

#### Uji Kenormalan

``` r
shapiro.test(data$sebelum)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  data$sebelum
    ## W = 0.99836, p-value = 0.3633

Data berdistribusi normal

``` r
result <- t.test_satu_pop_diketahui(data$sebelum, 
                                    sigma.squared =  100, 
                                    miu0 = 65, 
                                    alternative = "greater")
kable(data.frame(result))
```

|  statistic|  p\_value|     n|  mean\_sample| keputusan      |  alpa| alternative     |  var\_pop|
|----------:|---------:|-----:|-------------:|:---------------|-----:|:----------------|---------:|
|  -13.41343|         1|  1127|      61.00444| Gagal Tolak H0 |  0.05| greater than 65 |       100|

Dengan tingkat signifikansi 5% variabel `sebelum` tidak memiliki `𝜇>65`

Nomor 2
-------

Dengan 𝛼=0.08, Ujilah apakah variabel sesudah memiliki 𝜇\<65, jika 𝜎
tidak diketahui?

### Pembahasan Nomor 2

#### Uji kenormalan

``` r
shapiro.test(data$sesudah)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  data$sesudah
    ## W = 0.9987, p-value = 0.588

Data berdistribusi normal

``` r
result <- t.test_satu_pop_tidak_diketahui(data$sesudah, 
                                          miu0 = 65, 
                                          alternative = "less",
                                          alpa = 0.08)
kable(data.frame(result))
```

|  statistic|  p\_value|     n|    df|  mean\_sample| keputusan |  alpa| alternative  |  var\_sample|
|----------:|---------:|-----:|-----:|-------------:|:----------|-----:|:-------------|------------:|
|  -10.97778|         0|  1127|  1126|      61.12067| Tolak H0  |  0.08| less than 65 |     140.7368|

Dengan tingkat signifikansi 8% variabel `sesudah` tidak memiliki `𝜇<65`

Nomor 3
-------

Dengan 𝛼=0.10, ujilah apakah variabel sesudah dengan metode A memiliki
rata-rata yang sama dengan variabel sesudah dengan metode C?

### Pembahasan Nomor 2

#### Split data

``` r
splitData <- split(data$sesudah, data$metode)
a <- splitData$A
c <- splitData$C
```

#### Uji kenormalan

``` r
shapiro.test(a)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  a
    ## W = 0.99515, p-value = 0.5443

``` r
shapiro.test(c)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  c
    ## W = 0.99518, p-value = 0.5284

Keduanya berdistribusi Normal

#### Uji kesamaan varians

``` r
var.test(a, c)
```

    ## 
    ##  F test to compare two variances
    ## 
    ## data:  a and c
    ## F = 0.82858, num df = 273, denom df = 280, p-value = 0.1188
    ## alternative hypothesis: true ratio of variances is not equal to 1
    ## 95 percent confidence interval:
    ##  0.6543499 1.0495648
    ## sample estimates:
    ## ratio of variances 
    ##          0.8285753

Terlihat bahwa p-value lebih besar dari 0.10 sehingga gagal tolak H0
yang berarti varians sama

``` r
t.test(a, c, var.equal = TRUE)
```

    ## 
    ##  Two Sample t-test
    ## 
    ## data:  a and c
    ## t = 1.9396, df = 553, p-value = 0.05294
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.02508592  3.96653590
    ## sample estimates:
    ## mean of x mean of y 
    ##  62.82482  60.85409

``` r
result <- t.test_var_equal(a, c, alpa = 0.10)
kable(data.frame(result))
```

<table style="width:100%;">
<colgroup>
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 4%" />
<col style="width: 8%" />
<col style="width: 23%" />
<col style="width: 3%" />
<col style="width: 7%" />
<col style="width: 7%" />
<col style="width: 7%" />
<col style="width: 7%" />
<col style="width: 3%" />
<col style="width: 3%" />
<col style="width: 7%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">statistic</th>
<th style="text-align: right;">p.value</th>
<th style="text-align: right;">alpa</th>
<th style="text-align: left;">keputusan</th>
<th style="text-align: left;">alternative</th>
<th style="text-align: right;">df</th>
<th style="text-align: right;">mean1</th>
<th style="text-align: right;">mean2</th>
<th style="text-align: right;">var1</th>
<th style="text-align: right;">var2</th>
<th style="text-align: right;">n1</th>
<th style="text-align: right;">n2</th>
<th style="text-align: right;">se</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">1.939574</td>
<td style="text-align: right;">0.0529397</td>
<td style="text-align: right;">0.1</td>
<td style="text-align: left;">Tolak H0</td>
<td style="text-align: left;">difference mean not equal 0</td>
<td style="text-align: right;">553</td>
<td style="text-align: right;">62.82482</td>
<td style="text-align: right;">60.85409</td>
<td style="text-align: right;">129.6395</td>
<td style="text-align: right;">156.4608</td>
<td style="text-align: right;">274</td>
<td style="text-align: right;">281</td>
<td style="text-align: right;">1.016061</td>
</tr>
</tbody>
</table>

Diperoleh p-value yang lebih kecil dari 0.10, sehingga tolak H0, yang
berarti variabel sesudah untuk metode A dan C memiliki rata-rata yang
berbeda

Nomor 4
-------

Dengan 𝛼=0.05, ujilah apakah variabel sesudah memiliki rata-rata yang
lebih besar daripada variabel sebelum?

### Pembahasan Nomor 4

Variabel sebelum dan sesudah adalah variabel yang saling berkaitan

#### Uji Kenormalan

``` r
shapiro.test(data$sebelum)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  data$sebelum
    ## W = 0.99836, p-value = 0.3633

``` r
shapiro.test(data$sesudah)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  data$sesudah
    ## W = 0.9987, p-value = 0.588

Keduanya berdistribus normal

``` r
t.test(data$sesudah, data$sebelum, paired = TRUE, alternative = "greater")
```

    ## 
    ##  Paired t-test
    ## 
    ## data:  data$sesudah and data$sebelum
    ## t = 0.6357, df = 1126, p-value = 0.2626
    ## alternative hypothesis: true difference in means is greater than 0
    ## 95 percent confidence interval:
    ##  -0.1847706        Inf
    ## sample estimates:
    ## mean of the differences 
    ##               0.1162378

``` r
result <- t.test_paired(data$sesudah, data$sebelum, alternative = "greater")
kable(data.frame(result))
```

<table>
<colgroup>
<col style="width: 11%" />
<col style="width: 8%" />
<col style="width: 5%" />
<col style="width: 5%" />
<col style="width: 15%" />
<col style="width: 16%" />
<col style="width: 5%" />
<col style="width: 16%" />
<col style="width: 14%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">statistic</th>
<th style="text-align: right;">p_value</th>
<th style="text-align: right;">n</th>
<th style="text-align: right;">df</th>
<th style="text-align: right;">mean_sample_d</th>
<th style="text-align: left;">keputusan</th>
<th style="text-align: right;">alpa</th>
<th style="text-align: left;">alternative</th>
<th style="text-align: right;">var_sample_d</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">0.6357018</td>
<td style="text-align: right;">0.26255</td>
<td style="text-align: right;">1127</td>
<td style="text-align: right;">1126</td>
<td style="text-align: right;">0.1162378</td>
<td style="text-align: left;">Gagal Tolak H0</td>
<td style="text-align: right;">0.05</td>
<td style="text-align: left;">greater than 0</td>
<td style="text-align: right;">37.68008</td>
</tr>
</tbody>
</table>

Tidak terbukti dengan alpa 5% bahwa rata-rata variabel `sesudah` lebih
besar dari `sebelum`

Nomor 5
-------

Dengan 𝛼=0.01, ujilah apakah selisih niliai sesudah dan sebelum jika
dikelompokkan berdasarkan jenis kelamin memiliki nilai rata-rata yang
sama?

### Pembahasan Nomor 5

#### Split Data

``` r
d <- data$sesudah - data$sebelum
splitData <- split(d, data$jenis_kelamin)
cowo <- splitData$`Laki-Laki`
cewe <-  splitData$Perempuan
```

#### Uji Kenormalan

``` r
shapiro.test(cowo)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  cowo
    ## W = 0.94056, p-value = 9.495e-14

``` r
shapiro.test(cewe)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  cewe
    ## W = 0.95412, p-value = 1.195e-12

Terlihat bahwa data tidak normal. Apa yang harus dilakukan? Apakah boleh
dilanjutkan? **Saya juga tidak tau** :v

Apakah Central Limit Theorem bisa digunakan? Silahkan baca disini [You
can’t assume a normal distribution for your data with
N\>30](http://psychbrief.com/cant-assume-normal-distribution-n30/)


