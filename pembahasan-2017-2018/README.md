# Pembahasan UAS Tahun 2017/2018 <img src="https://img.shields.io/badge/r-%23276DC3.svg?&style=for-the-badge&logo=r&logoColor=white"/> 

Load Data dan Library
=====================

``` r
library(knitr)
library(dplyr)
library(car)
```

Untuk soal no 1, 2, dan 3 gunakan data SusenasUAS.csv yang telah
dikirimkan sebelumnya.

Data dapat diperoleh [disini](https://raw.githubusercontent.com/modul60stis/data/main/susenasUAS.csv)

``` r
df <- read.csv("https://raw.githubusercontent.com/modul60stis/data/main/susenasUAS.csv")
kable(sample_n(df, 7))
```

<table>
<colgroup>
<col style="width: 15%" />
<col style="width: 20%" />
<col style="width: 13%" />
<col style="width: 18%" />
<col style="width: 18%" />
<col style="width: 14%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">status_daerah</th>
<th style="text-align: left;">status_kepemilikan</th>
<th style="text-align: right;">pengeluaran</th>
<th style="text-align: left;">sektor_pekerjaan</th>
<th style="text-align: left;">status_pekerjaan</th>
<th style="text-align: right;">jenis_lantai</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">perkotaan</td>
<td style="text-align: left;">kontrak</td>
<td style="text-align: right;">958267.9</td>
<td style="text-align: left;">pertanian</td>
<td style="text-align: left;">pengusaha</td>
<td style="text-align: right;">3</td>
</tr>
<tr class="even">
<td style="text-align: left;">perkotaan</td>
<td style="text-align: left;">milik sendiri</td>
<td style="text-align: right;">888404.8</td>
<td style="text-align: left;">industri</td>
<td style="text-align: left;">buruh/karyawan</td>
<td style="text-align: right;">3</td>
</tr>
<tr class="odd">
<td style="text-align: left;">pedesaan</td>
<td style="text-align: left;">milik sendiri</td>
<td style="text-align: right;">1013892.9</td>
<td style="text-align: left;">industri</td>
<td style="text-align: left;">pengusaha</td>
<td style="text-align: right;">3</td>
</tr>
<tr class="even">
<td style="text-align: left;">perkotaan</td>
<td style="text-align: left;">sewa</td>
<td style="text-align: right;">1247904.8</td>
<td style="text-align: left;">pertanian</td>
<td style="text-align: left;">pengusaha</td>
<td style="text-align: right;">1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">pedesaan</td>
<td style="text-align: left;">milik sendiri</td>
<td style="text-align: right;">564738.1</td>
<td style="text-align: left;">industri</td>
<td style="text-align: left;">lainnya</td>
<td style="text-align: right;">3</td>
</tr>
<tr class="even">
<td style="text-align: left;">perkotaan</td>
<td style="text-align: left;">milik orangtua</td>
<td style="text-align: right;">1580952.4</td>
<td style="text-align: left;">pertanian</td>
<td style="text-align: left;">buruh/karyawan</td>
<td style="text-align: right;">2</td>
</tr>
<tr class="odd">
<td style="text-align: left;">pedesaan</td>
<td style="text-align: left;">milik sendiri</td>
<td style="text-align: right;">1387619.0</td>
<td style="text-align: left;">industri</td>
<td style="text-align: left;">pengusaha</td>
<td style="text-align: right;">1</td>
</tr>
</tbody>
</table>

**Ket : Data diatas bukan data asli yang dari dosen, tapi dibuat sesuai
dengan kebutuhan soal, karena data dari dosen sudah tidak ditemukan**

Nomor 1
=======

Terdapat opini bahwa rumah tangga dengan ART bekerja pada lapangan usaha
industry memiliki rata-rata pengeluaran sebulan lebih besar dibandingkan
RT dengan lapangan usaha pertanian. Tetapkan 𝐻0 dan 𝐻1 nya, serta
lakukan uji yang sesuai, kemudian interpretasikan hasil yang diperoleh.
(15)

Split Data
----------

``` r
splitData <- split(df$pengeluaran, df$sektor_pekerjaan)
industri <- splitData$industri
pertanian <- splitData$pertanian
kable(table(df$sektor_pekerjaan))
```

| Var1      |  Freq|
|:----------|-----:|
| industri  |    94|
| pertanian |    84|

Uji Kenormalan
--------------

-   H0 : Data berdistribusi normal
-   H1 : Data tidak berdistribusi normal

``` r
shapiro.test(industri)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  industri
    ## W = 0.95404, p-value = 0.002297

``` r
shapiro.test(pertanian)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  pertanian
    ## W = 0.97587, p-value = 0.1158

Terlihat bahwa dengan tingkat signifikansi 5% data pertanian normal akan
tetapi data industri tidak normal.

Saya tidak tau apakah tetap bisa dilanjutkan dengan menggunakan Central
Limit Theorem, yaitu jika jumlah datanya melebihi 30 maka akan dianggap
normal.

Saya tetap akan melanjutkan ke Uji T, **karena di soal** mengharuskan
menggunakan itu.

Uji Kesamaan Varians
--------------------

-   H0 : Keduanya memiliki varians yang sama
-   H1 : Keduanya memiliki varians yang berbeda

``` r
var.test(industri, pertanian)
```

    ## 
    ##  F test to compare two variances
    ## 
    ## data:  industri and pertanian
    ## F = 0.73731, num df = 93, denom df = 83, p-value = 0.1532
    ## alternative hypothesis: true ratio of variances is not equal to 1
    ## 95 percent confidence interval:
    ##  0.4825921 1.1207274
    ## sample estimates:
    ## ratio of variances 
    ##          0.7373062

Terlihat bahwa p-value lebih besar dari 0.05 yang berarti gagal tolak
H0. Dengan tingkat signifikansi 5% diperoleh cukup bukti bahwa keduanya
memiliki varians yang sama.

Uji T Test
----------

-   H0 : Rata-rata pengeluaran antara ART yang bekerja di sektor
    industri sama dengan yang bekerja di sektor pertanian
-   H1 : Rata-rata pengeluaran ART yang bekerja di sektor industri lebih
    besar daripada yang bekerja di sektor pertanian

``` r
t.test(industri, pertanian, var.equal = TRUE, alternative = "greater")
```

    ## 
    ##  Two Sample t-test
    ## 
    ## data:  industri and pertanian
    ## t = -5.5429, df = 176, p-value = 1
    ## alternative hypothesis: true difference in means is greater than 0
    ## 95 percent confidence interval:
    ##  -397125     Inf
    ## sample estimates:
    ## mean of x mean of y 
    ##  860974.8 1166851.1

Terlihat bahwa p-value sangat besar mendekati 1 yang artinya gagal tolak
H0.

Maka dengan tingkat signifikansi 5% dan data yang ada, tidak dapat
dibuktikan bahwa pengeluaran ART yang bekerja di sektor industri lebih
besar dari pengeluaran ART yang bekerja di sektor pertanian.

Nomor 2
=======

Lakukan uji apakah terdapat perbedaan rata-rata Rata-Rata Pengeluaran
sebulan antara status pekerjaan yang berbeda. Interpretasikan hasil yang
didapat kemudian lakukan uji lanjutan (posthoc test) sesuai dengan hasil
uji tersebut. (20)

Menentukan Uji yang sesuai
--------------------------

``` r
kable(table(df$status_pekerjaan))
```

| Var1                |  Freq|
|:--------------------|-----:|
| buruh/karyawan      |    74|
| lainnya             |    10|
| penerima pendapatan |    17|
| pengusaha           |    77|

Terlihat bahwa status pekerjaan ada 4, maka untuk menguji rata-ratanya
dapat menggunakan uji Anova. Akan dilakukan pengecekan asumsi terlebih
dahulu

Asumsi Kesamaan Varians
-----------------------

-   H0 : Semua varians sama
-   H1 : Minimal ada satu varians yang berbeda

``` r
leveneTest(pengeluaran ~ factor(status_pekerjaan), data = df)
```

    ## Levene's Test for Homogeneity of Variance (center = median)
    ##        Df F value Pr(>F)
    ## group   3  0.4261 0.7345
    ##       174

Terlihat bahwa p-value lebih besar dari 0.05, oleh karena itu gagal
tolak H0 yang berarti keempat status pekerjaan memiliki varians yang
sama

Cek Normalitas
--------------

``` r
tapply(df$pengeluaran, df$status_pekerjaan, shapiro.test)
```

    ## $`buruh/karyawan`
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.95664, p-value = 0.01255
    ## 
    ## 
    ## $lainnya
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.86038, p-value = 0.0771
    ## 
    ## 
    ## $`penerima pendapatan`
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.97248, p-value = 0.8602
    ## 
    ## 
    ## $pengusaha
    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  X[[i]]
    ## W = 0.95841, p-value = 0.01304

Terlihat bahwa semua kelompok pekerjaan akan normal pada tingkat
signifikansi 1%. Analisis tetap akan dilanjutkan ke anova

Uji Anova
---------

-   H0 : Semuanya memiliki rata-rata yang sama
-   H1 : Minimal ada satu rata-rata yang berbeda

``` r
res.aov <- aov(pengeluaran ~ status_pekerjaan, data = df)
summary(res.aov)
```

    ##                   Df    Sum Sq   Mean Sq F value Pr(>F)  
    ## status_pekerjaan   3 1.025e+12 3.417e+11    2.21 0.0886 .
    ## Residuals        174 2.690e+13 1.546e+11                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

karena p-value lebih besar dari 0.05 maka gagal tolak H0 yang berarti
ada minimal satu rata-rata yang berbeda

Posthoc Test
------------

``` r
TukeyHSD(res.aov)
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = pengeluaran ~ status_pekerjaan, data = df)
    ## 
    ## $status_pekerjaan
    ##                                          diff        lwr        upr     p adj
    ## lainnya-buruh/karyawan              -52812.70 -396449.21 290823.815 0.9784789
    ## penerima pendapatan-buruh/karyawan -270282.08 -544601.09   4036.923 0.0551230
    ## pengusaha-buruh/karyawan            -69320.12 -235356.31  96716.078 0.7003703
    ## penerima pendapatan-lainnya        -217469.38 -623943.55 189004.778 0.5086546
    ## pengusaha-lainnya                   -16507.42 -359346.08 326331.240 0.9993013
    ## pengusaha-penerima pendapatan       200961.97  -72356.91 474280.842 0.2287469

Dari p-value adjusted terlihat bahwa yang memiliki p-value yang kecil
adalah rata-rata penerima pendapatan dengan buruh/karyawan.

``` r
tapply(df$pengeluaran, df$status_pekerjaan, mean)
```

    ##      buruh/karyawan             lainnya penerima pendapatan           pengusaha 
    ##           1064088.2           1011275.5            793806.1            994768.1

Dari rata-rata diatas terlihat jelas bahwa perbedaan rata-rata antara
buruh/karyawan dengan penerima pendapatan sangat berbeda jauh dan secara
statistik itu yang membuat hipotesisi pada anova ditolak

Nomor 3
=======

Seorang peneliti berhipotesis bahwa proporsi jenis lantai terluas
berbeda antara daerah perkotaan dan pedesaan. Tetapkan 𝐻0 dan 𝐻1 serta
lakukan uji yang sesuai untuk menjawab pertanyaan tersebut. (15)

Membuat Tabel Frekuesni
-----------------------

``` r
tabel <- table(df$status_daerah, df$jenis_lantai)
kable(tabel)
```

|           |    1|    2|    3|
|:----------|----:|----:|----:|
| pedesaan  |   42|   37|   44|
| perkotaan |   19|   20|   16|

Uji Proporsi
------------

-   H0 : proporsi jenis lantai tidak berbeda antara daerah perkotaan dan
    pedesaan
-   H1 : proporsi jenis lantai berbeda antara daerah perkotaan dan
    pedesaan

``` r
chisq.test(tabel)
```

    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  tabel
    ## X-squared = 0.97352, df = 2, p-value = 0.6146

Karena p-value lebih besar dari 0.05, maka tolak H0, dengan tingkat
signifikansi 5% dan data yang ada proporsi jenis lantai tidak berbeda
antara daerah perkotaan dan pedesaan

Nomor 4
=======

Bagian A
--------

Buatlah sebuah fungsi untuk uji beda proporsi dengan input: Proporsi
grup 1 (𝑃1), besar sampel grup 1 (𝑛1), Proporsi grup 2 (𝑃2), besar
sampel grup 2 (𝑛2), dan taraf signifikansi (𝛼). Fungsi tersebut akan
menghasilkan nilai statistik uji, p-value, serta selang kepercayaan.
(25)

``` r
uji_beda_proporsi <-  function(p1, n1, p2, n2, alpa = "0.05"){
      p_gabungan <- (n1*p1 + n2*p2) / (n1 + n2)
      se <- sqrt(p_gabungan * (1 - p_gabungan) * (1/n1 + 1/n2))
      zhitung <- (p1 - p2) / se
      p_value <- 2 * pnorm(abs(zhitung), lower.tail = FALSE)
      
      keputusan <- if(p_value < alpa){
            "Tolak H0"
      } else {
            "Gagal Tolak H0"
      }
      
      seA <- pA * (1 - pA) / nA
      seB <- pB * (1 - pB) / nB
      
      lower <- (p1 - p2) - qnorm(alpa/2, lower.tail = FALSE) * sqrt(seA + seB)
      upper <- (p1 - p2) + qnorm(alpa/2, lower.tail = FALSE) * sqrt(seA + seB)
      
      list(statistic = zhitung,
           p_value = p_value,
           alpa = alpa,
           keputusan = keputusan,
           lower_ci = lower,
           upper_ci = upper,
           alternative = "difference proportion not equal 0")
}
```

Bagian B
--------

Implementasikan fungsi pada soal 4a pada kasus berikut, serta
implementasikan hasilnya. Dua orang pegawai A dan B masing-masing telah
bekerja sebagai petugas entry selama 10 tahun dan 5 tahun. Pimpinan
perusahaan beranggapan bahwa persentase kesalahan entry kedua pegawai
tersebut tidak sama yang kemungkinan dikarenakan lama masa kerja yang
berbeda. Untuk menguji hipotesis tersebut diambil sampel hasil entry
dari 50 kuisioner yang dilakukan oleh masing-masing petugas A dan Dari
sampel tersebut petugas A membuat 10% kesalahan sedangkan petugas B 12%.
Ujilah hipotesis di atas dengan tingkat signifikansi 1%. (15)

-   H0 : Persentase kesalahan entry pegawai A dan B sama
-   H1 : Persentase kesalahan entry pegawai A dan B tidak sama

### Menggunakan Fungsi Buatan

``` r
pA <- 0.1
nA <- 50
pB <- 0.12
nB <- 50
alpa <- 0.01
result <- uji_beda_proporsi(pA, nA, pB, nB, alpa)
kable(data.frame(result))
```

<table>
<colgroup>
<col style="width: 11%" />
<col style="width: 10%" />
<col style="width: 5%" />
<col style="width: 15%" />
<col style="width: 11%" />
<col style="width: 10%" />
<col style="width: 35%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">statistic</th>
<th style="text-align: right;">p_value</th>
<th style="text-align: right;">alpa</th>
<th style="text-align: left;">keputusan</th>
<th style="text-align: right;">lower_ci</th>
<th style="text-align: right;">upper_ci</th>
<th style="text-align: left;">alternative</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">-0.3196014</td>
<td style="text-align: right;">0.7492705</td>
<td style="text-align: right;">0.01</td>
<td style="text-align: left;">Gagal Tolak H0</td>
<td style="text-align: right;">-0.1811078</td>
<td style="text-align: right;">0.1411078</td>
<td style="text-align: left;">difference proportion not equal 0</td>
</tr>
</tbody>
</table>

Diperoleh z-statistic sebesar -0.3196014 dan p-value 0.7492705 yang jauh
lebih besr dari 0.01, artinya gagal tolak H0.

Dengan tingkat signifikansi 1%, anggapan pemimpin perusahaan bahwa
persentase kesalahan entry kedua pegawai tersebut tidak sama tidak dapat
dibuktikan.

### Menggunakan Fungsi Bawaan R

``` r
prop.test(x = c(pA * nA, pB *nB), n = c(nA, nB), correct = FALSE, conf.level = 0.99)
```

    ## 
    ##  2-sample test for equality of proportions without continuity
    ##  correction
    ## 
    ## data:  c(pA * nA, pB * nB) out of c(nA, nB)
    ## X-squared = 0.10215, df = 1, p-value = 0.7493
    ## alternative hypothesis: two.sided
    ## 99 percent confidence interval:
    ##  -0.1811078  0.1411078
    ## sample estimates:
    ## prop 1 prop 2 
    ##   0.10   0.12

Terlihat bahwa hasil p-value dan selang kepercayaan yang diperoleh sama.
Akan tetap fungsi `prop.test` menghasilkan statistik chi-square, yang
mana sama saja dengan kuadrat dari statistic z. Jika sebelumnya kita
memperoleh z-statistic -0.3196014, jika kita kuadrat kan menjadi
0.1021451, yang mana hasilnya sama dengan X-squared hasil fungsi
`prop.test`


