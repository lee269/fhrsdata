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
devtools::install_github("helen-food/fhrsdata", quiet = TRUE)
```

## Fetching establishments

There are three main functions. `get_establishments()` calls
upon the API to return a tibble of establishments from the FHRS. This call 
can be customised to a business name, local authority or business type with 
the `name`, `la` and `type` arguments respectively. 

Although name can be specified using a string, local authority and business 
type require the correct codes. To see a list of business types and their 
associated codes, use `get_business_types()`, and to see a list of local 
authorities and their IDs, use `get_authorities()`.

A vignette walking through the use of these functions can be obtained using:

```r
browseVignettes("fhrsdata")
```

## Work in progress

Further functions will be developed. To make suggestions for future functions, or
bug reports, please submit an [issue](https://github.com/helen-food/fhrsdata/issues).
Other feedback welcome to helen.graham@food.gov.uk.
