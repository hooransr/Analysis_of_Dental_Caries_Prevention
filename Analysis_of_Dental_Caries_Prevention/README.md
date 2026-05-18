# ToothGrowth Data Analysis Using R

## Introduction

This project analyzes the built-in `ToothGrowth` dataset in R.
The aim is to study the effect of vitamin C supplements and dosage levels on tooth growth in guinea pigs.
The project includes data exploration, descriptive statistics, visualization, probability calculation, simulation, and hypothesis testing.

---

# Required Libraries

```r
library(dplyr)
library(ggplot2)
```

---

# Loading the Dataset

```r
data(ToothGrowth)
```

---

# Data Exploration

```r
str(ToothGrowth)

head(ToothGrowth, 10)

summary(ToothGrowth)
```

### Dataset Variables

* `len` → Tooth length
* `supp` → Supplement type (OJ or VC)
* `dose` → Dose amount in mg/day

---

# Descriptive Statistics

```r
mean_len <- mean(ToothGrowth$len)

median_len <- median(ToothGrowth$len)

sd_len <- sd(ToothGrowth$len)

cat("Mean tooth length:", mean_len, "\n")

cat("Median:", median_len, "\n")

cat("Standard Deviation:", sd_len, "\n")
```

This section calculates the mean, median, and standard deviation of tooth length.

---

# Summary by Supplement Type

```r
by(ToothGrowth$len, ToothGrowth$supp, summary)
```

This compares tooth length between the two supplement types:

* OJ (Orange Juice)
* VC (Vitamin C)

---

# Frequency Table of Dose Levels

```r
table(ToothGrowth$dose)
```

This table shows the number of observations for each dose level.

---

# Histogram of Tooth Length

```r
hist(ToothGrowth$len,
     main = "Distribution of Tooth Length",
     xlab = "Tooth Length",
     col = "blue",
     border = "white")
```

The histogram displays the distribution of tooth length values.

---

# Boxplot by Supplement Type

```r
boxplot(len ~ supp,
        data = ToothGrowth,
        main = "Comparison of Tooth Length by Supplement Type",
        xlab = "Supplement Type",
        ylab = "Tooth Length",
        col = c("orange", "green"))
```

The boxplot compares tooth length between OJ and VC groups.

---

# Probability Calculation

```r
dose1_data <- subset(ToothGrowth, dose == 1)

prob_gt20 <- sum(dose1_data$len > 20) / nrow(dose1_data)

cat("Probability of tooth length > 20 at 1 mg dose:",
    prob_gt20,
    "\n")
```

This section calculates the probability that tooth length is greater than 20 for guinea pigs receiving a 1 mg dose.

---

# Simulation of Sampling Distribution

```r
set.seed(123)

sample_means <- replicate(
  1000,
  mean(sample(ToothGrowth$len,
              size = 30,
              replace = TRUE))
)

hist(sample_means,
     main = "Distribution of Sample Means",
     xlab = "Mean Tooth Length",
     col = "coral")

abline(v = mean(sample_means),
       col = "blue",
       lwd = 2)
```

This simulation demonstrates the sampling distribution of sample means using bootstrap sampling.

---

# Separating Data into Two Groups

```r
oj <- ToothGrowth$len[ToothGrowth$supp == "OJ"]

vc <- ToothGrowth$len[ToothGrowth$supp == "VC"]
```

The data is divided into two groups based on supplement type.

---

# Two-Sample T-Test

```r
t_test_result <- t.test(
  oj,
  vc,
  alternative = "two.sided",
  var.equal = FALSE
)

print(t_test_result)
```

The t-test checks whether there is a significant difference between the mean tooth lengths of the OJ and VC groups.

---

# 95% Confidence Interval

```r
t_test_result$conf.int
```

This provides the 95% confidence interval for the difference in means.

---

# Saving T-Test Results to a Text File

```r
sink("t_test_summary.txt")

cat("Results of t-test comparing OJ and VC:\n")

print(t_test_result)

sink()
```

This saves the t-test output into a text file.

---

# Saving Plots as PNG Files

```r
png("histogram_len.png")

hist(ToothGrowth$len,
     col = "blue",
     main = "Distribution of Tooth Length")

dev.off()

png("boxplot_supp.png")

boxplot(len ~ supp,
        data = ToothGrowth,
        col = c("orange", "green"))

dev.off()
```

This section saves the histogram and boxplot as image files.

---

# Conclusion

The analysis shows that both supplement type and dosage level affect tooth growth in guinea pigs.
Descriptive statistics and visualizations help understand the distribution of the data, while the t-test evaluates the statistical difference between OJ and VC supplement groups.
This project demonstrates a complete basic statistical analysis workflow using R.
