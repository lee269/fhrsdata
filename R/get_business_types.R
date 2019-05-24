#' Get business types
#'
#' Fetches the list of business types in the FHRS
#'
#' `get_business_types` makes an API call that returns the business types that
#' can be found in the FHRS, and their code, which can be used to filter other
#' API calls. It takes no parameters.
#'
#' @return A tibble of business types and their codes
#'
#' @examples get_business_types()
#'
#' @export
#'
get_business_types <- function() {
  getbtype <- httr::GET("api.ratings.food.gov.uk/BusinessTypes", httr::add_headers('x-api-version' = 2))
  httr::content(getbtype, "text") %>%
    jsonlite::fromJSON() %>%
    .$businessTypes %>%
    tibble::as_tibble() %>%
    dplyr::filter(BusinessTypeId != -1) %>%
    dplyr::select(1:2)
}

