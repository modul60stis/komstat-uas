# Distibusi Peluang <img src="https://img.shields.io/badge/r-%23276DC3.svg?&style=for-the-badge&logo=r&logoColor=white"/> 

Materi
------
**Acuan Materi**
1. [Variabel Random dan Distribusi Peluang](https://www.slideshare.net/audityasutarto/variabel-random-distribusi-peluang)

Secara garis besar setiap function distibusi peluang akan diawali oleh
`d`, `p`, `q`, dan `r`, kemudian diteruskan dengan nama dari
distribusinya, misalnya untuk distribusi normal menjadi `dnorm` untuk
mencari PDF, `pnorm` untuk mencari nilai CDF, `qnorm` untuk mencari
inverse CDF, dan `rnorm` untuk mengenerate data random yang berdistibusi
normal.

Fungsi CDF (`p` dan `q`) di R **selalu** fungsi kumulatif dari kiri
`X <= x`, untuk merubah arahanya jadi fungsi kumulatif dari kanan
`X > x` gunakan argument `lower.tail = FALSE`. Contohnya `qnorm(0.95)`
akan sama dengan `qnorm(0.05, lower.tail = FALSE)`

| Sintaks |                Output               |
|:-------:|:-----------------------------------:|
|   “d”   |  Probability Density Function (PDF) |
|   “p”   |  Cumulative Density Function (CDF)  |
|   “q”   | Inverse Cumulative Density Function |
|   “r”   |        Random Generated Data        |

Berikut distribusi yang ada di R. Untuk melihat argumen apa saja yang
dibutuhkan pada sebuah fungsi silahkan gunakan fungsi
`help(nama_fungsi)` misalnya `help(dbinom)` atau dapat menggunakan
`?nama_fungsi`, misalnya `?rexp`

| No  | Distribution   | Function                                   |
|-----|----------------|--------------------------------------------|
| 1   | Normal         | dnorm, pnorm, qnorm, rnorm                 |
| 2   | Chi-Squared    | dchisq, pchisq, qchisq, rchisq             |
| 3   | Student’s t    | dt, pt, qt, rt                             |
| 4   | Binomial       | dbinom, pbinom, qbinom, rbinom,            |
| 5   | Poisson        | dpois, ppois, dpois, rpois                 |
| 6   | F              | df, pf, qf, rf                             |
| 7   | Gamma          | dgamma, pgamma, qgamma, rgamma             |
| 8   | Exponential    | dexp, pexp, qexp, rexp                     |
| 9   | Multinomial    | dmultinom, pmultinom, qmultinom, rmultinom |
| 9   | Hypergeometric | dhyper, phyper, qhyper, rhyper             |
| 10  | Uniform        | dunif, punif, qunif, runif                 |
| 11  | Beta           | dbeta, pbeta, qbeta, rbeta                 |
| 12  | Cauchy         | dcauchy, pcauchy, qcauchy, rcauchy         |
| 13  | Geometric      | dgeom, pgeom, qgeom, rgeom                 |
| 14  | Logistic       | dlogis, plogis, qlogis, rlogis             |
| 15  | Weibeull       | dweibull, pweibull, qweibull, rweibull     |
| 16  | Wicoxon        | dwilcox, pwilcox, qwilcox, rwilcox         |

Contoh
------

Untuk mencari peluang kumulatif `x > 32`, ketika `mean = 30` dan
`varians = 10`

``` r
pnorm(32, mean = 30, sd = sqrt(10), lower.tail = FALSE)
```

    ## [1] 0.2635446

Atau misalnya ingin mencari z tabel ketika tingkat signifikasi 5%

``` r
qnorm(0.05, mean = 0, sd = 1, lower.tail = FALSE)
```

    ## [1] 1.644854

Atau misalnya kita ingin men-generate 20 angka random yang berdistibusi
`Poisson(27)`

``` r
rpois(20, 27)
```

    ##  [1] 25 26 29 24 32 27 23 23 26 30 25 32 29 30 23 34 33 32 23 29

Pembahasan Latihan Soal
-----------------------

## Nomor 1

Diasumsikan seorang telemarketer pada suatu hari berhasil menjual 20
dari 100 panggilan (𝑝=0.2). Jika ia menelpon 12 orang hari ini,
berapakah peluang

1.  Tidak ada penjualan?
2.  Tepat 2 penjualan
3.  Paling banyak 2 penjualan
4.  Minimum 4 penjualan?

### Pembahasan Nomor 1

Distribusi yang digunakan adalah binomial

``` r
n <- 12
p <- 0.2
```

#### Peluang tidak ada penjualan

``` r
x <- 0
peluang <- dbinom(x, n, p)
peluang
```

    ## [1] 0.06871948

#### Peluang tepat 2 penjualan

``` r
x <- 2
peluang <- dbinom(x, n, p)
peluang
```

    ## [1] 0.2834678

#### Peluang paling banyak 2 pejualan

``` r
x <- 2
peluang <- pbinom(x, n, p)
peluang
```

    ## [1] 0.5583457

#### Peluang minimum 4 penjualan

``` r
x <- 4 - 1 
peluang <- pbinom(x, n, p, lower.tail = FALSE)
peluang
```

    ## [1] 0.2054311

## Nomor 2

Setiap lot sebanyak 40 komponen dikatakan tidak lolos jika ditemukan
produk cacat sebanyak 3 atau lebih. Suatu rencana sampling dilakukan
dengan memilih 5 komponen secara acak dan menolak lot tersebut jika 1
produk cacat ditemukan. Berapakah peluang tepat 1 cacat ditemukan dalam
sampel jika terdapat 3 produk cacat dikeseluruhan lot?

### Pembahasan Nomor 2

Distribusi yang digunakan adalah distibusi Hypergeometri

``` r
x <- 1
m <- 3
n <- 40 - m
k <- 5

peluang <- dhyper(x, m, n, k)
peluang
```

    ## [1] 0.3011134

## Nomor 3

Seorang karyawan administrasi bertugas memasukkan 75 kata per menit
dengan 6 error/kesalahan per jam. Berapakah peluang ia membuat 0-1
kesalahan dalam 255 kata yang dibuat?

### Pembahasan Nomror 3

Distribusi yang dugunakan adalah distribusi Poisson

Mencari error perkata

``` r
kata_per_menit <- 75
kata_per_jam <-  75*60
kesalahan_per_jam <- 6
kesalahan_per_kata <- kesalahan_per_jam / kata_per_jam
kesalahan_per_kata
```

    ## [1] 0.001333333

Karena yang dicari adalah keslahan per 255 kata maka lambda adalaha
kesalahan per kata dikali 255

``` r
lambda <- kesalahan_per_kata * 255
peluang <- ppois(1, lambda)
peluang
```

    ## [1] 0.9537722

## Nomor 4

Dibagian pengendalian kualitas usai bola lampu diasumsikan berdistribusi
normal dengan 𝜇=2000 jam dan 𝜎 = 200 jam. Berapakah peluang suatu bola
lampu menyala selama

1.  Antara 2000 dan 2400 jam?
2.  Kurang dari 1470 jam?

### Pembahasan Nomor 4

Distribusi yang akan digunakan adalah distibusi normal

``` r
miu <- 2000
sd <- 200
```

#### Peluang antara 2000 dan 2400 jam

``` r
x_atas <- 2400
x_bawah <- 2000
peluang <- pnorm(x_atas, mean = miu, sd = sd) - pnorm(x_bawah, mean = miu, sd = sd)
peluang
```

    ## [1] 0.4772499

#### Peluang kurang dari 1470 jam

``` r
x <- 1470
peluang <- pnorm(x, mean = miu, sd = sd)
peluang
```

    ## [1] 0.004024589
