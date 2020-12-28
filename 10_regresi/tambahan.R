library(olsrr)
library(lmtest)
library(orcutt)
library(car)
library(nortest)

d <- read.csv("Forbes2000.csv")
View(d)
d <- d[, 5:8]

modelawal = lm(sales ~ profits +assets + marketvalue, data = d)
modelawal

ols_regress(sales ~ profits +assets + marketvalue, data = d)

ols_plot_resid_fit(modelawal)


### Detection Outlier ###

# Studentized Residual
ols_plot_resid_stud(modelawal)

# Standardized Residual
rstudent(modelawal)
ols_plot_resid_stand(modelawal)

# Deleted Studentized Residual vs Fitted Values Plot
ols_plot_resid_stud_fit(modelawal)


### Measures of Influence ###

# Cook's Distance
cooks.distance(modelawal)
ols_plot_cooksd_bar(modelawal)
ols_plot_cooksd_chart(modelawal)

# DFBETAs
dfbetas(modelawal)
ols_plot_dfbetas(modelawal)

# DFFITS
dffits(modelawal)
ols_plot_dffits(modelawal)


### Selection Model ###

# All Possible Sample
k <- ols_step_all_possible(modelawal)
k
View(k)
plot(k)

# Best Subset Regression (Largest R2 value or the smallest MSE, Mallow's Cp or AIC )
k <- ols_step_best_subset(modelawal)
k
View(k)
plot(k)

# Stepwise Forward Regression
ols_step_forward_p(modelawal)
ols_step_forward_p(modelawal, details = TRUE)

# Stepwise Backward Regression
ols_step_backward_p(modelawal)
ols_step_backward_p(modelawal, details = TRUE)

# Stepwise Regression
ols_step_both_p(modelawal)
ols_step_both_p(modelawal, details = TRUE)


modelTerpilih <- lm(currentm~days+previous+protein+i79, data = d)
ols_regress(currentm~days+previous+protein+i79, data = d)
ols_plot_resid_fit(modelTerpilih)
plot(modelTerpilih)


### Heteroscedasticity ###

# Goldfeld-Quandt Test
gqtest(modelTerpilih)

# Breusch Pagan Test
bptest(modelTerpilih)
ols_test_breusch_pagan(modelTerpilih) # Use fitted values 
ols_test_breusch_pagan(modelTerpilih, rhs= TRUE) # Use independent variables
ols_test_breusch_pagan(modelTerpilih, rhs= TRUE, multiple = TRUE) # Use independent variables of the model and perform multiple tests


# F Test (Under the assumption that the errors are independent and identically distributed (i.i.d.))
ols_test_f(modelTerpilih) # Use fitted values
ols_test_f(modelTerpilih, rhs = TRUE) # Use independent variables

# Remedy (Weight Least Square)

## If the residuals vs fitted values plot has a megaphone shape
wght <- 1 / lm(abs(modelTerpilih$residuals) ~ modelTerpilih$fitted.values)$fitted.values^2
newModel <- lm(currentm~days+previous+protein+i79, data = d, weights = wght)

## If the residuals vs fitted values plot has an upward trend
wght <- 1 / lm(modelTerpilih$residuals^2 ~ modelTerpilih$fitted.values)$fitted.values
newModel <- lm(currentm~days+previous+protein+i79, data = d, weights = wght)

View(d)
varfunc <- lm(log(modelTerpilih$residuals^2)~log(days)+log(previous)+log(protein), data = d)
varfunc <- exp(varfunc$fitted.values)


newModel <- lm(currentm~days+previous+protein+i79, data = d, weights = 1/sqrt(varfunc))
ols_plot_resid_fit(newModel)
bptest(newModel)
newModel
modelTerpilih


ols_test_breusch_pagan(newModel, rhs= TRUE)

### Multicollinearity ###

# VIF 
ols_vif_tol(modelTerpilih)

# Remedy
# Hapus Variabel yang memiliki VIF Besar


### Normality ###

# QQ Plot
ols_plot_resid_qq(modelTerpilih)

# Normality Test
ols_test_normality(modelTerpilih)
lillie.test(modelTerpilih$residuals)

### Auto Correlation ###

# Durbin Wutson Test
dwtest(modelTerpilih)
durbinWatsonTest(modelTerpilih, max.lag = 1)

# Breusch Godfrey Test
bgtest(modelTerpilih)

# Remedy
cochrane.orcutt(modelTerpilih)

