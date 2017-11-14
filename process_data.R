library(dplyr)

bike <- read.csv("BP_Data.csv", stringsAsFactors = FALSE, strip.white = TRUE)
for(i in c("COGS", "Total.Margin", "Total.Rev")) {
  # i <- "COGS"
  bike[[i]] <- trimws(bike[[i]])
  bike[[i]] <- as.numeric(gsub("\\$|,", "", bike[[i]]))
  bike[[i]][is.na(bike[[i]])] <- 0
}
bike$Year <- as.factor(bike$Year)
bike$Month <- as.factor(bike$Month)

store <- bike %>%
  group_by(Year, Month) %>%
  summarize(Revenue = sum(Total.Rev),
            Cost_of_Goods_Sold = sum(COGS),
            Qty_Sold = sum(Sold),
            Comission = sum(Comission),
            Month_End_Inventory = sum(E_inv)) %>%
  ungroup()

category <- bike %>%
  group_by(Year, Month, Category) %>%
  summarize(Revenue = sum(Total.Rev),
            Cost_of_Goods_Sold = sum(COGS),
            Qty_Sold = sum(Sold),
            Comission = sum(Comission),
            Month_End_Inventory = sum(E_inv)) %>%
  ungroup()

type <- bike %>%
  group_by(Year, Month, Category, Type) %>%
  summarize(Revenue = sum(Total.Rev),
            Cost_of_Goods_Sold = sum(COGS),
            Qty_Sold = sum(Sold),
            Comission = sum(Comission),
            Month_End_Inventory = sum(E_inv)) %>%
  ungroup()

name <- bike %>%
  group_by(Year, Month, Category, Type, Brand.Item.Type) %>%
  rename(Name = Brand.Item.Type) %>%
  summarize(Revenue = sum(Total.Rev),
            Cost_of_Goods_Sold = sum(COGS),
            Qty_Sold = sum(Sold),
            Comission = sum(Comission),
            Month_End_Inventory = sum(E_inv)) %>%
  ungroup()
