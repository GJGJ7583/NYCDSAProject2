library(tidyr)

# Modify data from Coldsteel website
coldsteel <- read.csv('coldsteel.csv')
head(coldsteel)
coldsteel
names(coldsteel)
# Extract digits from blade length and handle length
coldsteel$blade_length
coldsteel$blade_length <-
  as.numeric(gsub("[^\\d]+", "", coldsteel$blade_length, perl = TRUE))
coldsteel$handle_length
coldsteel$handle_length <-
  as.numeric(gsub("[^\\d]+", "", coldsteel$handle_length, perl = TRUE))

# Grade steel for Damascus and other
coldsteel$blade_steel
coldsteel$blade_steel <-
  ifelse(
    coldsteel$blade_steel == "Damascus",
    1,
    ifelse (coldsteel$blade_steel == "amascus", 1, 2)
  )
coldsteel$blade_steel

# Extract digits from overall length of swords
coldsteel$overall_length <-
  as.numeric(gsub("[^\\d]+", "", coldsteel$overall_length, perl = TRUE))
coldsteel$overall_length

typeof(coldsteel$price)

# Extract digits from weigh of swords
coldsteel$weigh <-
  as.numeric(gsub("[^\\d]+", "", coldsteel$weigh, perl = TRUE))
coldsteel$weigh

# Create data frame coldsteel_clean to have only complete rows
coldsteel_clean <- coldsteel[complete.cases(coldsteel),]
dim(coldsteel_clean)

typeof(coldsteel$overall_length)

# Clean blade length, handle length, overall length, and weigh to receive actual size and weight of swords
coldsteel_clean$blade_length <- ifelse(
  coldsteel_clean$blade_length < 100,
  coldsteel_clean$blade_length,
  as.integer(coldsteel_clean$blade_length / 100) + ifelse(
    coldsteel_clean$blade_length %% 100 == 14,
    0.25,
    ifelse(
      coldsteel_clean$blade_length %% 100 == 34,
      0.75,
      ifelse(
        coldsteel_clean$blade_length %% 100 == 38,
        0.375,
        ifelse(coldsteel_clean$blade_length %% 100 == 12, 0.5, 0.875)
      )
    )
  )
)
coldsteel_clean$blade_length
coldsteel_clean$handle_length <- ifelse(
  coldsteel_clean$handle_length < 100,
  coldsteel_clean$handle_length,
  as.integer(coldsteel_clean$handle_length / 100) + ifelse(
    coldsteel_clean$handle_length %% 100 == 14,
    0.25,
    ifelse(
      coldsteel_clean$handle_length %% 100 == 34,
      0.75,
      ifelse(
        coldsteel_clean$handle_length %% 100 == 38,
        0.375,
        ifelse(
          coldsteel_clean$handle_length %% 100 == 12,
          0.5,
          ifelse(
            coldsteel_clean$handle_length %% 100 == 58,
            0.625,
            ifelse(coldsteel_clean$handle_length %% 100 == 18, 0.125, 0.65)
          )
        )
      )
    )
  )
)
coldsteel_clean$handle_length
coldsteel_clean$overall_length  <- ifelse(
  coldsteel_clean$overall_length < 100,
  coldsteel_clean$overall_length,
  as.integer(coldsteel_clean$overall_length / 100) + ifelse(
    coldsteel_clean$overall_length %% 100 == 14,
    0.25,
    ifelse(
      coldsteel_clean$overall_length %% 100 == 34,
      0.75,
      ifelse(
        coldsteel_clean$overall_length %% 100 == 38,
        0.375,
        ifelse(
          coldsteel_clean$overall_length %% 100 == 12,
          0.5,
          ifelse(coldsteel_clean$overall_length %% 100 == 58,
                 0.625, 0.825)
        )
      )
    )
  )
)
coldsteel_clean$overall_length
head(coldsteel_clean)
coldsteel_clean$weigh[29] = 346
coldsteel_clean$weigh <-
  ifelse(coldsteel_clean$weigh < 100,
         coldsteel_clean$weigh,
         coldsteel_clean$weigh / 10)
coldsteel_clean$weigh

# Grade swords as katana and other
coldsteel_clean$katana <- ifelse(coldsteel_clean$katana == 1, 1, 2)
coldsteel_clean$katana
coldsteel_clean$blade_steel <-
  as.factor(coldsteel_clean$blade_steel)
coldsteel_clean$katana <- as.factor(coldsteel_clean$katana)
coldsteel_clean$blade_steel
coldsteel_clean$katana
typeof(coldsteel_clean$katana)
coldsteel_clean

# Modify data from Valiantarmoury website
valiantarmoury <- read.csv('valiantarmoury.csv')
head(valiantarmoury)

# Extract digits from blade length, handle length, overall length, and weigh of swords
valiantarmoury$blade_length <-
  as.numeric(gsub("[^\\d]+", "", valiantarmoury$blade_length, perl = TRUE))
valiantarmoury$blade_length
valiantarmoury$handle_length <-
  as.numeric(gsub("[^\\d]+", "", valiantarmoury$handle_length, perl = TRUE))
valiantarmoury$handle_length
valiantarmoury$overall_length <-
  as.numeric(gsub("[^\\d]+", "", valiantarmoury$overall_length, perl = TRUE))
valiantarmoury$overall_length
valiantarmoury$weigh <-
  as.numeric(gsub("[^\\d]+", "", valiantarmoury$weigh, perl = TRUE))
valiantarmoury$weigh

# Clean variable name
valiantarmoury$name
valiantarmoury$name[8] <-
  'VA-101-Craftsman Series - The Noble Medieval Sword'
valiantarmoury$name <- sub('.*- ', '', valiantarmoury$name)

# Create data frame valiantarmoury_clean for further analysis
valiantarmoury_clean <- valiantarmoury

# Create a new variable katana that shows that valiantarmoury_clean doesn't have katana
valiantarmoury_clean$katana <- 2
valiantarmoury_clean$katana
coldsteel_clean$blade_steel

# Grade steel as 6150
valiantarmoury_clean$blade_steel <- 3
head(valiantarmoury_clean)
valiantarmoury_clean$price <- valiantarmoury$price

# Clean price to receive numeric double
sub('.*$', '', valiantarmoury_clean$price)
typeof(valiantarmoury_clean$price)
valiantarmoury_clean$price <-
  as.numeric(gsub('[$,]', '', valiantarmoury_clean$price))

# Modify data frame to have only complete rows
valiantarmoury_clean <-
  valiantarmoury_clean[complete.cases(valiantarmoury_clean),]

# Clean blade length, handle length, overall length, and weigh to receive actual size and weight of swords
valiantarmoury_clean$blade_length
valiantarmoury_clean$blade_length <- ifelse(
  valiantarmoury_clean$blade_length < 100,
  valiantarmoury_clean$blade_length,
  as.integer(valiantarmoury_clean$blade_length / 100) + ifelse(
    valiantarmoury_clean$blade_length %% 100 == 14,
    0.25,
    ifelse(
      valiantarmoury_clean$blade_length %% 100 == 12,
      0.5,
      ifelse(valiantarmoury_clean$blade_length %% 100 == 34,
             0.75, 0.875)
    )
  )
)
valiantarmoury_clean$blade_length
valiantarmoury_clean$handle_length
valiantarmoury_clean$handle_length <- ifelse(
  valiantarmoury_clean$handle_length < 100,
  valiantarmoury_clean$handle_length,
  as.integer(valiantarmoury_clean$handle_length / 100) + ifelse(
    valiantarmoury_clean$handle_length %% 100 == 14,
    0.25,
    ifelse(
      valiantarmoury_clean$handle_length %% 100 == 12,
      0.5,
      ifelse(
        valiantarmoury_clean$handle_length %% 100 == 34,
        0.75,
        ifelse(valiantarmoury_clean$handle_length %% 100 == 18,
               0.125, 0.55)
      )
    )
  )
)
valiantarmoury_clean$handle_length
valiantarmoury_clean$overall_length
valiantarmoury_clean$overall_length  <- ifelse(
  valiantarmoury_clean$overall_length < 100,
  valiantarmoury_clean$overall_length,
  as.integer(valiantarmoury_clean$overall_length / 100) + ifelse(
    valiantarmoury_clean$overall_length %% 100 == 12,
    0.5,
    ifelse(
      valiantarmoury_clean$overall_length %% 100 == 38,
      0.375,
      ifelse(valiantarmoury_clean$overall_length %% 100 == 34,
             0.75, 0.55)
    )
  )
)
valiantarmoury_clean$overall_length
valiantarmoury_clean$weigh
valiantarmoury_clean$weigh <-
  ifelse(
    valiantarmoury_clean$weigh < 100,
    as.integer(valiantarmoury_clean$weigh / 10) + valiantarmoury_clean$weigh %% 10 / 10,
    as.integer(valiantarmoury_clean$weigh / 100) + valiantarmoury_clean$weigh %% 100 / 100
  )
valiantarmoury_clean$weigh
valiantarmoury_clean <-
  valiantarmoury_clean[complete.cases(valiantarmoury_clean),]
valiantarmoury_clean
valiantarmoury_clean <-
  valiantarmoury_clean[valiantarmoury_clean$weigh < 100, ]
coldsteel_clean

coldsteel_clean$weigh = round(coldsteel_clean$weigh / 16, digits = 2)
coldsteel_clean$weigh

valiantarmoury_clean
coldsteel_clean$blade_steel <-
  as.numeric(coldsteel_clean$blade_steel)


# Row bind two data frames and create new data frame swords_clean
# Save swords_clean into folder
swords_clean <- rbind(coldsteel_clean, valiantarmoury_clean)
swords_clean
write.csv(swords_clean, "swords.csv", row.names = FALSE)

# Extract newly created data frame for firther analysis
swords_new <- read.csv("swords.csv")
swords_new

# Create a new variable blade_overall that measures part of blade length in overall length
swords_new$blade_overall = swords_new$blade_length / swords_new$overall_length
swords_new <- swords_new[swords_new$blade_overall < 1, ]
swords_new

# # Save swords_new into folder
write.csv(swords_new, "swords_new.csv", row.names = FALSE)


library(tidyverse)

names(swords_new)

# Steel type box plot
ggplot(swords_new, aes(as.factor(blade_steel), price)) + geom_boxplot()

# Katana or not box plot
ggplot(swords_new, aes(as.factor(katana), price)) + geom_boxplot()

# Relationship between blade length and price
ggplot(swords_new, aes(blade_length, price)) + geom_point() + geom_smooth(method =
                                                                            lm)
# Relationship between blade overall and price
ggplot(swords_new, aes(blade_overall, price)) + geom_point() + geom_smooth(method =
                                                                             lm)
# Relationship between overall length and price
ggplot(swords_new, aes(overall_length, price)) + geom_point() + geom_smooth(method =
                                                                              lm)

# Relationship between handle length and price
ggplot(swords_new, aes(handle_length, price)) + geom_point() + geom_smooth(method =
                                                                             lm)
# Relationship between weigh and price
ggplot(swords_new, aes(weigh, price)) + geom_point() + geom_smooth(method =
                                                                     lm)
library(PerformanceAnalytics)
names(swords_new)

# Correlation charts among variables used in regression analysis
cor_variables_num <- swords_new[, c(6, 1, 7, 9)]
cor_variables_all <- swords_new[, c(6, 2, 1, 7, 8, 9)]
chart.Correlation(cor_variables_num, histogram = TRUE, pch = 19)
chart.Correlation(cor_variables_all, histogram = TRUE, pch = 19)

model_short <-
  lm(
    swords_new$price ~ swords_new$blade_length + swords_new$weigh + swords_new$blade_overall
  )
summary(model_short)
model_all <-
  lm(
    swords_new$price ~ swords_new$blade_length + swords_new$weigh + swords_new$blade_overall + swords_new$blade_steel + swords_new$katana
  )
summary(model_all)
