# Dplyr <img src="https://img.shields.io/badge/r-%23276DC3.svg?&style=for-the-badge&logo=r&logoColor=white"/> 

``` r
library(knitr)
library(dplyr)
```

Materi
======

**Acuan Materi**

1.  [Useful dplyr
    Functions](https://www.r-bloggers.com/2017/07/useful-dplyr-functions-wexamples/)
2.  [Data Manipulation with
    dplyr](https://www.r-bloggers.com/2015/08/data-manipulation-with-dplyr/)
3.  [MANIPULASI DATA DENGAN LIBRARY(DPLYR)
    R](https://muhammadilhammubarok.wordpress.com/2018/05/01/manipulasi-data-dengan-librarydplyr-di-r/)
4.  [Dplyr Cheat
    Sheet](https://rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)

Dplyr adalah package di R yang dapat digunakan untuk memanipulasi data.
Package ini dikembangkan oleh Hadley Wickham dan Roman Francois yang
memberikan beberapa fungsi yang mudah digunakan. Package ini sangat
berguna ketika digunakan untuk melakukan analisis dan eksplorasi data.

``` r
iris <- iris
kable(head(iris, 5))
```

|  Sepal.Length|  Sepal.Width|  Petal.Length|  Petal.Width| Species |
|-------------:|------------:|-------------:|------------:|:--------|
|           5.1|          3.5|           1.4|          0.2| setosa  |
|           4.9|          3.0|           1.4|          0.2| setosa  |
|           4.7|          3.2|           1.3|          0.2| setosa  |
|           4.6|          3.1|           1.5|          0.2| setosa  |
|           5.0|          3.6|           1.4|          0.2| setosa  |

``` r
air <- airquality
kable(head(air, 5))
```

|  Ozone|  Solar.R|  Wind|  Temp|  Month|  Day|
|------:|--------:|-----:|-----:|------:|----:|
|     41|      190|   7.4|    67|      5|    1|
|     36|      118|   8.0|    72|      5|    2|
|     12|      149|  12.6|    74|      5|    3|
|     18|      313|  11.5|    62|      5|    4|
|     NA|       NA|  14.3|    56|      5|    5|

Dplyr
=====

Pipe Operator
-------------

Operator ini menggunakan `%>%` yang berguna untuk fungsi berantai.
Sehingga dapat menuliskan lebih dari satu fungsi sekaligus tanpa harus
menyimpannya terlebih dahulu. Cara kerjanya yaitu meletakkan apa yang
ada disebelah kiri pipe ke dalam argument pertama fungsi disebelah kanan
pipe

Perintah `kable(head(air, 3))` akan sama dengan sintax berikut ini

``` r
air %>% 
      head(3) %>%
      kable()
```

|  Ozone|  Solar.R|  Wind|  Temp|  Month|  Day|
|------:|--------:|-----:|-----:|------:|----:|
|     41|      190|   7.4|    67|      5|    1|
|     36|      118|   8.0|    72|      5|    2|
|     12|      149|  12.6|    74|      5|    3|

Fungsi `glimpse`
----------------

Fungsi glimpse() memiliki fungsi yang sama seperti str() yaitu
memberikan rangkuman tentang keadaan data. Meliputi jumlah observasi
atau baris dan jumlah variabel atau kolom. Kemudian memberikan informasi
mengenai tipe dari variabel serta menampilkan sedikit tentang datanya.

``` r
glimpse(air)
```

    ## Rows: 153
    ## Columns: 6
    ## $ Ozone   <int> 41, 36, 12, 18, NA, 28, 23, 19, 8, NA, 7, 16, 11, 14, 18, 1...
    ## $ Solar.R <int> 190, 118, 149, 313, NA, NA, 299, 99, 19, 194, NA, 256, 290,...
    ## $ Wind    <dbl> 7.4, 8.0, 12.6, 11.5, 14.3, 14.9, 8.6, 13.8, 20.1, 8.6, 6.9...
    ## $ Temp    <int> 67, 72, 74, 62, 56, 66, 65, 59, 61, 69, 74, 69, 66, 68, 58,...
    ## $ Month   <int> 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,...
    ## $ Day     <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, ...

Fungsi `sample_n` dan `sample_frac`
-----------------------------------

Fungsi ini digunakan untuk mengambil secara acak pada data. Fungsi
sample\_n berarti mengambil sampel berdasarkan nilai n yang ditentukan.
Fungsi sample\_frac berarti mengambil sampel berdasarkan besaran
persentase dari keluruhan data.

``` r
air %>% 
      sample_n(5, replace = FALSE) %>%
      kable()
```

|  Ozone|  Solar.R|  Wind|  Temp|  Month|  Day|
|------:|--------:|-----:|-----:|------:|----:|
|     47|       95|   7.4|    87|      9|    5|
|     80|      294|   8.6|    86|      7|   24|
|     71|      291|  13.8|    90|      6|    9|
|     NA|      186|   9.2|    84|      6|    4|
|     16|       77|   7.4|    82|      8|    3|

``` r
iris %>%
      sample_frac(0.1, replace = TRUE) %>%
      kable()
```

|  Sepal.Length|  Sepal.Width|  Petal.Length|  Petal.Width| Species    |
|-------------:|------------:|-------------:|------------:|:-----------|
|           6.3|          3.4|           5.6|          2.4| virginica  |
|           6.0|          2.2|           4.0|          1.0| versicolor |
|           5.8|          2.7|           4.1|          1.0| versicolor |
|           4.8|          3.1|           1.6|          0.2| setosa     |
|           5.8|          2.7|           3.9|          1.2| versicolor |
|           5.0|          2.3|           3.3|          1.0| versicolor |
|           5.0|          3.0|           1.6|          0.2| setosa     |
|           6.7|          3.0|           5.2|          2.3| virginica  |
|           6.1|          3.0|           4.9|          1.8| virginica  |
|           4.3|          3.0|           1.1|          0.1| setosa     |
|           5.7|          2.5|           5.0|          2.0| virginica  |
|           5.5|          2.4|           3.8|          1.1| versicolor |
|           5.7|          2.6|           3.5|          1.0| versicolor |
|           5.7|          2.6|           3.5|          1.0| versicolor |
|           5.4|          3.9|           1.7|          0.4| setosa     |

Fungsi `select`
---------------

Fungsi ini digunakan untuk mengambil satu atau beberapa variabel
tertentu dari data.

#### Bisa menggunakan nama kolom

``` r
air %>%
      select(Month, Day) %>%
      head() %>%
      kable()
```

|  Month|  Day|
|------:|----:|
|      5|    1|
|      5|    2|
|      5|    3|
|      5|    4|
|      5|    5|
|      5|    6|

#### Bisa mengunakan index kolom

``` r
iris %>%
      select(c(1, 3)) %>%
      head() %>%
      kable()
```

|  Sepal.Length|  Petal.Length|
|-------------:|-------------:|
|           5.1|           1.4|
|           4.9|           1.4|
|           4.7|           1.3|
|           4.6|           1.5|
|           5.0|           1.4|
|           5.4|           1.7|

#### Bisa sambil langsung merubah nama kolom

``` r
air %>%
      select(bulan = Month, hari = Day) %>%
      head() %>%
      kable()
```

|  bulan|  hari|
|------:|-----:|
|      5|     1|
|      5|     2|
|      5|     3|
|      5|     4|
|      5|     5|
|      5|     6|

#### Bisa menggunakan beberapa fungsi tambahan

``` r
iris %>%
      select(starts_with("s")) %>%
      head() %>%
      kable()
```

|  Sepal.Length|  Sepal.Width| Species |
|-------------:|------------:|:--------|
|           5.1|          3.5| setosa  |
|           4.9|          3.0| setosa  |
|           4.7|          3.2| setosa  |
|           4.6|          3.1| setosa  |
|           5.0|          3.6| setosa  |
|           5.4|          3.9| setosa  |

``` r
iris %>%
      select(contains("W")) %>%
      head() %>%
      kable()
```

|  Sepal.Width|  Petal.Width|
|------------:|------------:|
|          3.5|          0.2|
|          3.0|          0.2|
|          3.2|          0.2|
|          3.1|          0.2|
|          3.6|          0.2|
|          3.9|          0.4|

``` r
iris %>%
      select(-ends_with("h")) %>%
      head() %>%
      kable()
```

| Species |
|:--------|
| setosa  |
| setosa  |
| setosa  |
| setosa  |
| setosa  |
| setosa  |

#### Bisa sambil mengurutkan kolom

``` r
air %>%
      select(Day, Month, everything()) %>%
      head() %>%
      kable()
```

|  Day|  Month|  Ozone|  Solar.R|  Wind|  Temp|
|----:|------:|------:|--------:|-----:|-----:|
|    1|      5|     41|      190|   7.4|    67|
|    2|      5|     36|      118|   8.0|    72|
|    3|      5|     12|      149|  12.6|    74|
|    4|      5|     18|      313|  11.5|    62|
|    5|      5|     NA|       NA|  14.3|    56|
|    6|      5|     28|       NA|  14.9|    66|

Fungsi `rename`
---------------

``` r
air %>%
      rename(bulan = Month,
             tanggal = Day) %>%
      head() %>%
      kable()
```

|  Ozone|  Solar.R|  Wind|  Temp|  bulan|  tanggal|
|------:|--------:|-----:|-----:|------:|--------:|
|     41|      190|   7.4|    67|      5|        1|
|     36|      118|   8.0|    72|      5|        2|
|     12|      149|  12.6|    74|      5|        3|
|     18|      313|  11.5|    62|      5|        4|
|     NA|       NA|  14.3|    56|      5|        5|
|     28|       NA|  14.9|    66|      5|        6|

Fungsi `pull`
-------------

Mengambil kolom sebagai vector

``` r
iris %>%
      pull(Sepal.Length)
```

    ##   [1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0 4.4 4.9 5.4 4.8 4.8 4.3 5.8 5.7 5.4 5.1
    ##  [19] 5.7 5.1 5.4 5.1 4.6 5.1 4.8 5.0 5.0 5.2 5.2 4.7 4.8 5.4 5.2 5.5 4.9 5.0
    ##  [37] 5.5 4.9 4.4 5.1 5.0 4.5 4.4 5.0 5.1 4.8 5.1 4.6 5.3 5.0 7.0 6.4 6.9 5.5
    ##  [55] 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9 6.0 6.1 5.6 6.7 5.6 5.8 6.2 5.6 5.9 6.1
    ##  [73] 6.3 6.1 6.4 6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4 6.0 6.7 6.3 5.6 5.5
    ##  [91] 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 6.3 5.8 7.1 6.3 6.5 7.6 4.9 7.3
    ## [109] 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7 6.0 6.9 5.6 7.7 6.3 6.7 7.2
    ## [127] 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8
    ## [145] 6.7 6.7 6.3 6.5 6.2 5.9

Fungsi `filter`
---------------

Fungsi ini digunakan untuk menyeleksi dan menampilkan data sesuai dengan
ketentuan.

``` r
air %>%
      filter(Month %in% c(5, 9) & Day == 2) %>%
      kable()
```

|  Ozone|  Solar.R|  Wind|  Temp|  Month|  Day|
|------:|--------:|-----:|-----:|------:|----:|
|     36|      118|   8.0|    72|      5|    2|
|     78|      197|   5.1|    92|      9|    2|

Fungsi `count`
--------------

Fungsi ini digunakan untuk menyeleksi dan menampilkan data sesuai dengan
ketentuan.

``` r
iris %>%
      count(Species) %>%
      kable()
```

| Species    |    n|
|:-----------|----:|
| setosa     |   50|
| versicolor |   50|
| virginica  |   50|

Fungsi `distinct`
-----------------

Digunakan menghapus nilai yang duplikat

``` r
air %>%
      distinct(Month) %>%
      kable()
```

|  Month|
|------:|
|      5|
|      6|
|      7|
|      8|
|      9|

Tetap mempertahankan kolom lainnya dapat menggunakan `.keep_all = TRUE`

``` r
air %>%
      distinct(Month, .keep_all = T) %>%
      kable()
```

|  Ozone|  Solar.R|  Wind|  Temp|  Month|  Day|
|------:|--------:|-----:|-----:|------:|----:|
|     41|      190|   7.4|    67|      5|    1|
|     NA|      286|   8.6|    78|      6|    1|
|    135|      269|   4.1|    84|      7|    1|
|     39|       83|   6.9|    81|      8|    1|
|     96|      167|   6.9|    91|      9|    1|

Fungsi `arrange`
----------------

Fungsi ini berguna untuk mengurutkan data berdasarkan variabel. Variabel
yang menjadi acuan untuk diurutkan dapat lebih dari satu dan dapat
ditentukan apakah dari besar ke kecil atau dari kecil ke besar.

#### Dari yang terkecil

``` r
air %>%
      arrange(Solar.R) %>%
      head() %>%
      kable()
```

|  Ozone|  Solar.R|  Wind|  Temp|  Month|  Day|
|------:|--------:|-----:|-----:|------:|----:|
|     16|        7|   6.9|    74|      7|   21|
|      1|        8|   9.7|    59|      5|   21|
|     23|       13|  12.0|    67|      5|   28|
|     23|       14|   9.2|    71|      9|   22|
|      8|       19|  20.1|    61|      5|    9|
|     14|       20|  16.6|    63|      9|   25|

#### Dari yang terbesar

``` r
air %>%
      arrange(desc(Solar.R)) %>%
      head() %>%
      kable()
```

|  Ozone|  Solar.R|  Wind|  Temp|  Month|  Day|
|------:|--------:|-----:|-----:|------:|----:|
|     14|      334|  11.5|    64|      5|   16|
|     NA|      332|  13.8|    80|      6|   14|
|     39|      323|  11.5|    87|      6|   10|
|     30|      322|  11.5|    68|      5|   19|
|     NA|      322|  11.5|    79|      6|   15|
|     11|      320|  16.6|    73|      5|   22|

Fungsi `mutate`
---------------

Fungsi ini dapat digunakan untuk menambahkan variabel baru. Variabel
baru tersebut dapat berupa variabel kategorik maupun numerik.

``` r
air %>%
      select(hari = Day) %>%
      mutate(katagori = if_else(hari < 15, "Awal Bulan", "Akhir Bulan")) %>%
      sample_n(7) %>%
      kable()
```

|  hari| katagori    |
|-----:|:------------|
|     9| Awal Bulan  |
|    14| Awal Bulan  |
|    20| Akhir Bulan |
|    10| Awal Bulan  |
|    23| Akhir Bulan |
|    30| Akhir Bulan |
|    24| Akhir Bulan |

#### Dapat menambahkan kondisi

``` r
iris %>%
      mutate_if(is.numeric, funs(new = (. * 1000))) %>%
      head() %>%
      kable()
```

    ## Warning: `funs()` is deprecated as of dplyr 0.8.0.
    ## Please use a list of either functions or lambdas: 
    ## 
    ##   # Simple named list: 
    ##   list(mean = mean, median = median)
    ## 
    ##   # Auto named with `tibble::lst()`: 
    ##   tibble::lst(mean, median)
    ## 
    ##   # Using lambdas
    ##   list(~ mean(., trim = .2), ~ median(., na.rm = TRUE))
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_warnings()` to see where this warning was generated.

<table style="width:100%;">
<colgroup>
<col style="width: 10%" />
<col style="width: 9%" />
<col style="width: 10%" />
<col style="width: 9%" />
<col style="width: 6%" />
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 13%" />
<col style="width: 12%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">Sepal.Length</th>
<th style="text-align: right;">Sepal.Width</th>
<th style="text-align: right;">Petal.Length</th>
<th style="text-align: right;">Petal.Width</th>
<th style="text-align: left;">Species</th>
<th style="text-align: right;">Sepal.Length_new</th>
<th style="text-align: right;">Sepal.Width_new</th>
<th style="text-align: right;">Petal.Length_new</th>
<th style="text-align: right;">Petal.Width_new</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">5.1</td>
<td style="text-align: right;">3.5</td>
<td style="text-align: right;">1.4</td>
<td style="text-align: right;">0.2</td>
<td style="text-align: left;">setosa</td>
<td style="text-align: right;">5100</td>
<td style="text-align: right;">3500</td>
<td style="text-align: right;">1400</td>
<td style="text-align: right;">200</td>
</tr>
<tr class="even">
<td style="text-align: right;">4.9</td>
<td style="text-align: right;">3.0</td>
<td style="text-align: right;">1.4</td>
<td style="text-align: right;">0.2</td>
<td style="text-align: left;">setosa</td>
<td style="text-align: right;">4900</td>
<td style="text-align: right;">3000</td>
<td style="text-align: right;">1400</td>
<td style="text-align: right;">200</td>
</tr>
<tr class="odd">
<td style="text-align: right;">4.7</td>
<td style="text-align: right;">3.2</td>
<td style="text-align: right;">1.3</td>
<td style="text-align: right;">0.2</td>
<td style="text-align: left;">setosa</td>
<td style="text-align: right;">4700</td>
<td style="text-align: right;">3200</td>
<td style="text-align: right;">1300</td>
<td style="text-align: right;">200</td>
</tr>
<tr class="even">
<td style="text-align: right;">4.6</td>
<td style="text-align: right;">3.1</td>
<td style="text-align: right;">1.5</td>
<td style="text-align: right;">0.2</td>
<td style="text-align: left;">setosa</td>
<td style="text-align: right;">4600</td>
<td style="text-align: right;">3100</td>
<td style="text-align: right;">1500</td>
<td style="text-align: right;">200</td>
</tr>
<tr class="odd">
<td style="text-align: right;">5.0</td>
<td style="text-align: right;">3.6</td>
<td style="text-align: right;">1.4</td>
<td style="text-align: right;">0.2</td>
<td style="text-align: left;">setosa</td>
<td style="text-align: right;">5000</td>
<td style="text-align: right;">3600</td>
<td style="text-align: right;">1400</td>
<td style="text-align: right;">200</td>
</tr>
<tr class="even">
<td style="text-align: right;">5.4</td>
<td style="text-align: right;">3.9</td>
<td style="text-align: right;">1.7</td>
<td style="text-align: right;">0.4</td>
<td style="text-align: left;">setosa</td>
<td style="text-align: right;">5400</td>
<td style="text-align: right;">3900</td>
<td style="text-align: right;">1700</td>
<td style="text-align: right;">400</td>
</tr>
</tbody>
</table>

Fungsi `group_by`
-----------------

Fungsi yang digunakan untuk mengelompokkan data berdasarkan satu atau
lebih variabel. Efek dari fungsi ini akan terlihat jika dikombinasikan
dengan fungsi `summarise`

Fungsi `summarise`
------------------

Fungsi summarise digunakan untuk meringkas beberapa nilai data menjadi
satu nilai.

### Kombinasi dengan `group_by`

``` r
air %>%
      group_by(Month) %>%
      summarise(rata2_Temp = mean(Temp)) %>%
      kable()
```

|  Month|  rata2\_Temp|
|------:|------------:|
|      5|     65.54839|
|      6|     79.10000|
|      7|     83.90323|
|      8|     83.96774|
|      9|     76.90000|

### Summarise semua kolom

``` r
iris %>%
      select(-Species) %>%
      summarise_all(funs(rata2 = mean, median)) %>%
      kable()
```

<table style="width:100%;">
<colgroup>
<col style="width: 12%" />
<col style="width: 11%" />
<col style="width: 12%" />
<col style="width: 11%" />
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 13%" />
<col style="width: 12%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">Sepal.Length_rata2</th>
<th style="text-align: right;">Sepal.Width_rata2</th>
<th style="text-align: right;">Petal.Length_rata2</th>
<th style="text-align: right;">Petal.Width_rata2</th>
<th style="text-align: right;">Sepal.Length_median</th>
<th style="text-align: right;">Sepal.Width_median</th>
<th style="text-align: right;">Petal.Length_median</th>
<th style="text-align: right;">Petal.Width_median</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">5.843333</td>
<td style="text-align: right;">3.057333</td>
<td style="text-align: right;">3.758</td>
<td style="text-align: right;">1.199333</td>
<td style="text-align: right;">5.8</td>
<td style="text-align: right;">3</td>
<td style="text-align: right;">4.35</td>
<td style="text-align: right;">1.3</td>
</tr>
</tbody>
</table>

### Summarise kolom tertentu

``` r
iris %>%
      group_by(Species) %>%
      summarise_at(vars(Sepal.Length, Sepal.Width),
                   funs(n(), mean)) %>%
      kable()
```

| Species    |  Sepal.Length\_n|  Sepal.Width\_n|  Sepal.Length\_mean|  Sepal.Width\_mean|
|:-----------|----------------:|---------------:|-------------------:|------------------:|
| setosa     |               50|              50|               5.006|              3.428|
| versicolor |               50|              50|               5.936|              2.770|
| virginica  |               50|              50|               6.588|              2.974|

### Summarise kolom pad kondisi tertentu

``` r
iris %>%
      summarise_if(is.numeric, mean) %>%
      kable()
```

|  Sepal.Length|  Sepal.Width|  Petal.Length|  Petal.Width|
|-------------:|------------:|-------------:|------------:|
|      5.843333|     3.057333|         3.758|     1.199333|

Join
----

Data Dummy 1

``` r
df1 <- data.frame(ID = c(1, 2, 3, 4, 5),
                  y = c(12, 23, 27, 1, 7))
kable(df1)
```

|   ID|    y|
|----:|----:|
|    1|   12|
|    2|   23|
|    3|   27|
|    4|    1|
|    5|    7|

Data Dummy 2

``` r
df2 <- data.frame(ID = c(3, 4, 5, 6, 7),
                  k = c(112, 123, 127, 11, 17))
kable(df2)
```

|   ID|    k|
|----:|----:|
|    3|  112|
|    4|  123|
|    5|  127|
|    6|   11|
|    7|   17|

### Inner Join

Foreign key yang digunakan harus ada dikedua data frame

``` r
inner_join(df1, df2, by ="ID") %>%
      kable()
```

|   ID|    y|    k|
|----:|----:|----:|
|    3|   27|  112|
|    4|    1|  123|
|    5|    7|  127|

### Left Join

Semua data frame pertama akan dimasukkan meskipun pasangannya di data
frame kedua tidak ada

``` r
left_join(df1, df2, by ="ID") %>% 
      kable()
```

|   ID|    y|    k|
|----:|----:|----:|
|    1|   12|   NA|
|    2|   23|   NA|
|    3|   27|  112|
|    4|    1|  123|
|    5|    7|  127|

### Right Join

Kebalikan dari left join

``` r
right_join(df1, df2, by ="ID") %>%
      kable()
```

|   ID|    y|    k|
|----:|----:|----:|
|    3|   27|  112|
|    4|    1|  123|
|    5|    7|  127|
|    6|   NA|   11|
|    7|   NA|   17|

### Full Join

Kebalikan dari left join

``` r
full_join(df1, df2, by ="ID") %>%
      kable()
```

|   ID|    y|    k|
|----:|----:|----:|
|    1|   12|   NA|
|    2|   23|   NA|
|    3|   27|  112|
|    4|    1|  123|
|    5|    7|  127|
|    6|   NA|   11|
|    7|   NA|   17|
