#1. Install packages and load  libraries
install.packages(c("dplyr", "lubridate", "ggplot2"))
library(dplyr)
library(lubridate)
library(ggplot2)
# 2.import data set and explore the data
data <- read.csv("rfm_data.csv")
head(data)
summary(data)
glimpse(data)

#3. Data wrangling
# change invoice date from character and remove time
data$InvoiceDate <- mdy_hm(data$InvoiceDate)
data$InvoiceDate <- as.Date(data$InvoiceDate)
glimpse(data)
# create new variable Total Price and  remove missing values
data$TotalPrice <- data$Quantity * data$UnitPrice
sum(is.na(data))
colSums(is.na(data))
data[!complete.cases(data), ]
data_clean <- na.omit(data)
# remove cancelled orders

data_clean <- data_clean %>%
  filter(!grepl("C", InvoiceNo) | is.na(InvoiceNo))
summary(data_clean)
# 4. RFM Analysis
#extract the latest date and add 5days to create a safe cutoff date after latest transaction

max(data_clean$InvoiceDate, na.rm = TRUE)
today_date <- as.Date("2011-12-14")
write.csv(data_clean, "kpi_data.csv", row.names = FALSE)

rfm <- data_clean %>%
  group_by(CustomerID) %>%
  summarise(
    Recency = as.numeric(today_date - max(InvoiceDate, na.rm = TRUE)),
       Frequency = n_distinct(InvoiceNo),
    Monetary = sum(TotalPrice, na.rm = TRUE)
  )
names(data)
names(rfm)
# 5. create rfm scores
rfm <- rfm %>%
  mutate(
    R_score = ntile(-Recency, 5),   
    F_score = ntile(Frequency, 5),
    M_score = ntile(Monetary, 5)
  )
# create combined rfm segment
rfm <- rfm %>%
  mutate(
    RFM_Score = paste0(R_score, F_score, M_score)
  )
# customer classification
rfm <- rfm %>%
  mutate(
    Segment = case_when(
      R_score >= 4 & F_score >= 4 & M_score >= 4 ~ "Champions",
      R_score >= 3 & F_score >= 3 ~ "Loyal Customers",
      R_score >= 4 & F_score <= 2 ~ "New Customers",
      R_score <= 2 & F_score >= 4 ~ "At Risk",
      R_score <= 2 & F_score <= 2 ~ "Lost",
      TRUE ~ "Others"
    )
  )
# 8 explore the segments
rfm %>%
  count(Segment) %>%
  arrange(desc(n))
# 9. visualisation
ggplot(rfm, aes(x = Segment)) +
  geom_bar(fill = "blue") +
  theme_minimal() +
  coord_flip() +
  labs(title = "Customer Segments (RFM Analysis)")
# rfm heatmap style view

ggplot(rfm, aes(x = Recency, y = Frequency, size = Monetary, color = Segment)) +
  geom_point(alpha = 0.7) +
  theme_minimal() +
  labs(title = "RFM Customer Distribution by Segment",
       x = "Recency (days)",
       y = "Frequency",
       color = "Customer Segment",
       size = "Monetary Value")
write.csv(rfm, "rfm_output.csv", row.names = FALSE)
