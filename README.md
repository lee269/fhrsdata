# fhrsdata

## Why make an R package for FHRS data?

The FHRS is currently published as open data, in the form of individual XML files
for each local authority, or available through our API. Neither of those are a
totally straightforward way to get the data you want.

Enter `fhrsdata`. This package wraps useful API calls in R functions, which can
be customised via the functions' parameters, to provide data extracts for a
range of scenarios.

## Installing the package

```r
#install devtools if necessary
#install.packages("devtools")
devtools::install_github("helen-food/fhrsdata")
```

## Fetching establishments

The function `get_establishments()` calls
upon the API to return a tibble of establishments from the FHRS. Calling this 
function with no arguments would return every establishment in the FHRS - OK if 
this is really what you want, but it will take a long time.

Alternatively, you can customise your API call with the optional arguments.

The `name` argument takes a string (e.g. "pret a manger") and searches for 
business names that contain that string.

The `type` argument allows you to restrict your search to a particular 
business type. The list of businesses in the FHRS can be returned using the 
`get_business_types()` function. This will also return the corresponding code 
for each business type. For example, the code for business type 
'Restaurant/Cafe/Canteen' is 1, so to search for all establishments of this type, 
you would use:

```r
get_establishments(type = 1)
```

The `la` argument to `get_establishments()` allows you to restrict your search 
to a particular local authority. To get the list of authorities in the FHRS, 
use the `get_authorities()` function. Again it is the authority ID number not 
the name that is required. Say you wanted to return all restaurants in Aberdeen. 
You can find the code for Aberdeen using:

```r
get_athorities() %>% 
  filter(grepl("Aberdeen", Name))
```

This would reveal the relevant ID number to be 197. The the establishments call 
would be made as follows:

```r
get_establishments(type = 1, la = 197)
```


## Work in progress

This package is heavily under construction and is liable to break. Further functions 
will be added to the package. 

To make suggestions for future functions, or
bug reports, please submit an [issue](https://github.com/helen-food/fhrsdata/issues).
Other feedback welcome to helen.graham@food.gov.uk.
