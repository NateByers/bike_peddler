library(dplyr)
library(ggplot2)

bike <- read.csv("BP_Data.csv", stringsAsFactors = FALSE, strip.white = TRUE)
for(i in c("COGS", "Total.Margin", "Total.Rev")) {
  # i <- "COGS"
  bike[[i]] <- trimws(bike[[i]])
  bike[[i]] <- as.numeric(gsub("\\$|,", "", bike[[i]]))
  bike[[i]][is.na(bike[[i]])] <- 0
}


type <- bike %>%
  group_by(Year, Month, Category, Type) %>%
  summarize(Revenue = sum(Total.Rev),
            Cost_of_Goods_Sold = sum(COGS),
            Qty_Sold = sum(Sold),
            Comission = sum(Comission),
            Month_End_Inventory = sum(E_inv)) %>%
  ungroup()

lm_fit <- lm(Revenue ~ Category + Type + Qty_Sold, data = type)

boot_type <- type %>%
  dplyr::select(Category, Type, Qty_Sold) %>%
  sample_n(10000, replace = TRUE)
boot_type$Revenue <- predict(lm_fit, boot_type)

get_revenue_prediction <- function(dat, input_data_frame) {
  # dat <- boot_type
  
  percentiles <- dat %>%
    dplyr::group_by(Category, Type) %>%
    dplyr::mutate(percentile = ntile(Qty_Sold, 10)) %>%
    dplyr::group_by(Category, Type, percentile) %>%
    dplyr::mutate(min = min(Qty_Sold), max = max(Qty_Sold)) %>%
    dplyr::left_join(input_data_frame, c("Category", "Type")) %>%
    dplyr::filter(max >= input & min < input) %>%
    dplyr::ungroup()
  
  percentiles
}

min_max <- type %>%
  dplyr::group_by(Category, Type) %>%
  dplyr::summarize(min = min(Qty_Sold),  median = median(Qty_Sold),
                   max = max(Qty_Sold)) %>%
  as.data.frame()

get_min <- function(cat, type, dat = mm) {
  # cat <- "Acessories"; type <- "Clothes"; dat <- min_max
  dat %>% 
    dplyr::filter(Category == cat, Type == type) %>%
    dplyr::pull(min)
}


get_max <- function(cat, type, dat = min_max) {
  
  dat %>% 
    dplyr::filter(Category == cat, Type == type) %>%
    dplyr::pull(max)
}

get_median <- get_median <- function(cat, type, dat = min_max) {
  dat %>% 
    dplyr::filter(Category == cat, Type == type) %>%
    dplyr::pull(median)
}


  
