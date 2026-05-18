install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(ggplot2)

data(ToothGrowth)

str(ToothGrowth)
head(ToothGrowth, 10)
summary(ToothGrowth)

# Mean, Median, SD of tooth length
mean_len <- mean(ToothGrowth$len)
median_len <- median(ToothGrowth$len)
sd_len <- sd(ToothGrowth$len)
cat("Mean tooth length:", mean_len, "/n")
cat("Median:", median_len, "/n")
cat("SD:", sd_len, "/n")

# Summary by vitamin type
by(ToothGrowth$len, ToothGrowth$supp, summary)

# frequency table of dose levels
table(ToothGrowth$dose)

# Histogram of tooth length
hist(ToothGrowth$len,
     main = "Distribution of tooth length",
     xlab = "Length",
     col = "blue",
     border = "white")
# Boxplot by supplement type
boxplot(len ~ supp,
        data = ToothGrowth,
        main = "comparison of tooth length by vitamin type",
        xlab = "supplement type", ylab = "tooth length",
        col = c("orange", "green"))
# probability example:
dose1_data <- subset(ToothGrowth, dose == 1)
prob_gt20 <- sum(dose1_data$len > 20 / nrow(dose1_data))
cat("probability of length > 20 at 1 mg dose:", prob_gt20, "/n")

# simulation of sampling distribution
set.seed(123)
sample_means <- replicate(1000, mean(sample(ToothGrowth$len, size = 30, replace = TRUE)))
hist(sample_means,
     main = "distribution of sample_means",
     xlab = "mean tooth length",
     col = "coral")
abline(v = mean(sample_means), col = "blue", lwd = 2)

# seprate data in 2 groups
oj <- ToothGrowth$len[ToothGrowth$supp == "OJ"]
vc <- ToothGrowth$len[ToothGrowth$supp == "VC"]

#two-sample t-test
t_test_result <- t.test(oj, vc, alternative = "two.sided", var.equal = FALSE)
print(t_test_result)

# 95% confidence interval for the defference in means 
t_test_result$conf.int

# save test summary to txt file
sink("t_test_summaary.txt")
cat("results of t-test comparing OJ and VC:/n")
print(t_test_result)
sink()

# save plots as png file
png("histogram_len.png")
hist(ToothGrowth$len, col = "blue", main = "Distribution of tooth length")
dev.off()

png("boxplot_supp.png")
boxplot(len ~ supp, data = ToothGrowth, col = c("orange", "green"))
dev.off(
  
cat("project completed successfully./n")
  