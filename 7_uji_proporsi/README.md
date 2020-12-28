# Uji Proporsi <img src="https://img.shields.io/badge/r-%23276DC3.svg?&style=for-the-badge&logo=r&logoColor=white"/> 


Materi
======

**Acuan Materi**

1.  [One-Proportion Z-Test in
    R](http://www.sthda.com/english/wiki/one-proportion-z-test-in-r)
2.  [Two-Proportions Z-Test in
    R](http://www.sthda.com/english/wiki/two-proportions-z-test-in-r)

Uji Satu Populasi
=================

𝐻0: 𝑝= 𝑝0; 𝐻1:𝑝 ≠𝑝0 𝐻0: 𝑝≤ 𝑝0; 𝐻1:𝑝\>𝑝0 𝐻0: 𝑝≥ 𝑝0; 𝐻1:𝑝\<𝑝0

Membuat Fungsi Sendiri
----------------------

``` r
prop.test_satu_pop <-  function(x, n, p, alpa = 0.05, alternative = "two.sided"){
      p_cap <- x / n
      se <- sqrt(p * (1 - p) / n)
      zhitung <- (p_cap - p) / se
      
      if(alternative == "less"){
            alternative <- paste("proportion less than", p)
            p_value <- pnorm(zhitung)
      } else if(alternative == "greater"){
            alternative <- paste("proportion greater than", p)
            p_value <- pnorm(zhitung, lower.tail = FALSE)
      } else {
            alternative <- paste("proportion not equal", p)
            p_value <- 2 * pnorm(abs(zhitung), lower.tail = FALSE)
      }
      
      keputusan <- if(p_value < alpa){
            "Tolak H0"
      } else {
            "Gagal Tolak H0"
      }
      
      list(statistic = zhitung,
           p_value = p_value,
           alpa = alpa,
           keputusan = keputusan,
           alternative = alternative,
           p_cap = p_cap,
           p0 = p,
           x = x,
           n = n)
}
```

Mencoba Fungsi Sendiri
----------------------

``` r
result <- prop.test_satu_pop(x = 95, n = 160, p = 0.5)
kable(data.frame(result))
```

|  statistic|   p\_value|  alpa| keputusan | alternative              |   p\_cap|   p0|    x|    n|
|----------:|----------:|-----:|:----------|:-------------------------|--------:|----:|----:|----:|
|   2.371708|  0.0177061|  0.05| Tolak H0  | proportion not equal 0.5 |  0.59375|  0.5|   95|  160|

Menggunakan Fungsi `prop.test`
------------------------------

``` r
prop.test(x = 95, n = 160, p = 0.5, correct = FALSE)
```

    ## 
    ##  1-sample proportions test without continuity correction
    ## 
    ## data:  95 out of 160, null probability 0.5
    ## X-squared = 5.625, df = 1, p-value = 0.01771
    ## alternative hypothesis: true p is not equal to 0.5
    ## 95 percent confidence interval:
    ##  0.5163169 0.6667870
    ## sample estimates:
    ##       p 
    ## 0.59375

Perbedaan dari fungsi yang dibuat sendiri dengan fungsi `prop.test`
adalah fungsi `prop.test` menggunakan pendekatan Chi-Square. Hasil
p-value akan sama, karena distribus `Z^2` sama dengan distributsi
`Chi-Square`

Uji Dua Populasi
================

Membuat Fungsi Sendiri
----------------------

``` r
prop.test_dua_pop <-  function(x1, n1, x2, n2, alpa = 0.05, alternative = "two.sided"){
      p_cap1 <- x1 / n1
      p_cap2 <- x2 / n2
      p_gab <- ((n1 * p_cap1) + (n2 * p_cap2)) / (n1 + n2)
      se <- sqrt(p_gab * (1 - p_gab) * ((1/n1) + (1/n2)))
      zhitung <- (p_cap1 - p_cap2) / se
      
      p_value <- NULL
      if(alternative == "less"){
            p_value <- pnorm(zhitung)
      } else if(alternative == "greater"){
            p_value <- pnorm(zhitung, lower.tail = FALSE)
      } else {
            p_value <- 2 * pnorm(abs(zhitung), lower.tail = FALSE)
      }
      
      keputusan <- if(p_value < alpa){
            "Tolak H0"
      } else {
            "Gagal Tolak H0"
      }
      
      list(statistic = zhitung,
           p_value = p_value,
           alpa = alpa,
           keputusan = keputusan,
           alternative = alternative,
           p_cap1 = p_cap1,
           p_cap2 = p_cap2,
           x1 = x1,
           x2 = x2,
           n1 = n1,
           n2 = n2)
}
```

Mencoba Fungsi Buatan
---------------------

``` r
result <- prop.test_dua_pop(490, 500, 480, 500)
kable(data.frame(result))
```

|  statistic|   p\_value|  alpa| keputusan      | alternative |  p\_cap1|  p\_cap2|   x1|   x2|   n1|   n2|
|----------:|----------:|-----:|:---------------|:------------|--------:|--------:|----:|----:|----:|----:|
|    1.85376|  0.0637735|  0.05| Gagal Tolak H0 | two.sided   |     0.98|     0.96|  490|  480|  500|  500|

Menggunakan Fungsi `prop.test`
------------------------------

``` r
prop.test(x = c(490, 480), n = c(500, 500), correct = FALSE)
```

    ## 
    ##  2-sample test for equality of proportions without continuity
    ##  correction
    ## 
    ## data:  c(490, 480) out of c(500, 500)
    ## X-squared = 3.4364, df = 1, p-value = 0.06377
    ## alternative hypothesis: two.sided
    ## 95 percent confidence interval:
    ##  -0.001109458  0.041109458
    ## sample estimates:
    ## prop 1 prop 2 
    ##   0.98   0.96

Perbedaan dari fungsi yang dibuat sendiri dengan fungsi `prop.test`
adalah fungsi `prop.test` menggunakan pendekatan Chi-Square. Hasil
p-value akan sama, karena distribusi `Z^2` sama dengan distributsi
`Chi-Square`

Pembahasan Latihan Soal
=======================

Dengan menggunakan data\_dummy\_komstat.csv dan tingkat signifikansi 5%.

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

Jika dilihat berdasarkan nilai sesudah apakah proporsi mahasiswa yang
puas lebih dari 0.6?

### Pembahasan Nomor 1

``` r
table(data$puas)
```

    ## 
    ## Tidak    Ya 
    ##   434   693

Terlihat bahwa ada 639 mahasiswa yang puas dari 1127 mahasiswa

``` r
x <- 639
n <- 1127
p <- 0.6
result <- prop.test_satu_pop(x, n, p, alpa = alpa, alternative = "greater")
kable(data.frame(result))
```

<table style="width:100%;">
<colgroup>
<col style="width: 11%" />
<col style="width: 11%" />
<col style="width: 5%" />
<col style="width: 16%" />
<col style="width: 31%" />
<col style="width: 10%" />
<col style="width: 4%" />
<col style="width: 4%" />
<col style="width: 5%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">statistic</th>
<th style="text-align: right;">p_value</th>
<th style="text-align: right;">alpa</th>
<th style="text-align: left;">keputusan</th>
<th style="text-align: left;">alternative</th>
<th style="text-align: right;">p_cap</th>
<th style="text-align: right;">p0</th>
<th style="text-align: right;">x</th>
<th style="text-align: right;">n</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">-2.26191</td>
<td style="text-align: right;">0.9881485</td>
<td style="text-align: right;">0.05</td>
<td style="text-align: left;">Gagal Tolak H0</td>
<td style="text-align: left;">proportion greater than 0.6</td>
<td style="text-align: right;">0.566992</td>
<td style="text-align: right;">0.6</td>
<td style="text-align: right;">639</td>
<td style="text-align: right;">1127</td>
</tr>
</tbody>
</table>

``` r
prop.test(x, n, p, alternative = "greater", correct = FALSE)
```

    ## 
    ##  1-sample proportions test without continuity correction
    ## 
    ## data:  x out of n, null probability p
    ## X-squared = 5.1162, df = 1, p-value = 0.9881
    ## alternative hypothesis: true p is greater than 0.6
    ## 95 percent confidence interval:
    ##  0.5425828 1.0000000
    ## sample estimates:
    ##        p 
    ## 0.566992

Diperoleh p-value sebesar 0.9881, dengan tingkat signifikansi 5% maka
gagal tolak H0, yang berarti tidak terdapat bukti yang cukup untuk
mengatakan bahwa proporsi mahasiswa yang puas lebih dari 0.6

Nomor 2
-------

Jika dilihat berdasarkan nilai sesudah apakah ada perbedaan proporsi
antara laki-laki dan perempuan yang puas terhadap metode pengajaran?

### Pembahasan Nomor 2

``` r
table(data$puas, data$jenis_kelamin)
```

    ##        
    ##         Laki-Laki Perempuan
    ##   Tidak       197       237
    ##   Ya          335       358

Terlihat bahwa laki-laki yang puas ada sebanyak 335 dari 532 mahasiswa
dan perempuan ada sebanyak 358 dari 595 mahasiswa

``` r
result <- prop.test_dua_pop(335, 532, 358, 595)
kable(data.frame(result))
```

<table style="width:100%;">
<colgroup>
<col style="width: 11%" />
<col style="width: 11%" />
<col style="width: 5%" />
<col style="width: 17%" />
<col style="width: 13%" />
<col style="width: 11%" />
<col style="width: 11%" />
<col style="width: 4%" />
<col style="width: 4%" />
<col style="width: 4%" />
<col style="width: 4%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">statistic</th>
<th style="text-align: right;">p_value</th>
<th style="text-align: right;">alpa</th>
<th style="text-align: left;">keputusan</th>
<th style="text-align: left;">alternative</th>
<th style="text-align: right;">p_cap1</th>
<th style="text-align: right;">p_cap2</th>
<th style="text-align: right;">x1</th>
<th style="text-align: right;">x2</th>
<th style="text-align: right;">n1</th>
<th style="text-align: right;">n2</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">0.9649634</td>
<td style="text-align: right;">0.3345632</td>
<td style="text-align: right;">0.05</td>
<td style="text-align: left;">Gagal Tolak H0</td>
<td style="text-align: left;">two.sided</td>
<td style="text-align: right;">0.6296992</td>
<td style="text-align: right;">0.6016807</td>
<td style="text-align: right;">335</td>
<td style="text-align: right;">358</td>
<td style="text-align: right;">532</td>
<td style="text-align: right;">595</td>
</tr>
</tbody>
</table>

``` r
prop.test(x = c(335, 358), n = c(532, 595), correct = FALSE)
```

    ## 
    ##  2-sample test for equality of proportions without continuity
    ##  correction
    ## 
    ## data:  c(335, 358) out of c(532, 595)
    ## X-squared = 0.93115, df = 1, p-value = 0.3346
    ## alternative hypothesis: two.sided
    ## 95 percent confidence interval:
    ##  -0.02882364  0.08486079
    ## sample estimates:
    ##    prop 1    prop 2 
    ## 0.6296992 0.6016807

Terlihat bahwa p-value lebih besar dari 0.05 sehingga gagal tolak H0,
yang berarti dapat ditarik kesimpulan bahwa proporsi antara laki-laki
dan perempuan yang puas terhadap metode pengajaran tidak berbeda.


