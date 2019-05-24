## ------------------------------------------------------------------------
install.packages("devtools")
devtools::install_github("helen-food/fhrsdata")


## ------------------------------------------------------------------------
library(fhrsdata)


## ------------------------------------------------------------------------
get_establishments(name = "red lion")


## ------------------------------------------------------------------------
library(dplyr)
get_establishments("red lion") %>% count(BusinessType)


## ------------------------------------------------------------------------
get_business_types()


## ------------------------------------------------------------------------
get_establishments(name = "red lion", type = 7843)


## ------------------------------------------------------------------------
get_establishments(name = "red lion", type = 7843) %>% 
  count(LocalAuthorityName) %>% 
  arrange(desc(n)) %>% 
  head()


## ------------------------------------------------------------------------
get_authorities(country = "Wales")


## ------------------------------------------------------------------------
get_establishments(name="red lion", type = 7843, la = 349)

