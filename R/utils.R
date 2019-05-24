## HELPER FUNCTIONS NOT FOR EXPORT

# Get number of pages an API query will return

getpages <- function(query) {
  getpages <- httr::GET(query, httr::add_headers('x-api-version' = 2))
  httr::content(getpages, "text") %>%
    jsonlite::fromJSON() %>%
    .$meta %>%
    .$totalPages
}

# FHRS table tidying function

tabletidy <- function(table, condensed = TRUE) {
  if(condensed == FALSE) {
    return(table)
  } else {
    table %>%
      dplyr::select(FHRSID, BusinessName, BusinessType, AddressLine1:PostCode,
                    RatingValue, RatingDate, LocalAuthorityName, SchemeType,
                    lat = geocode.latitude, long = geocode.longitude)
  }
}
