#' Get local authorities
#'
#' Fetches the list of authorities in the FHRS
#'
#' `get_authorities` makes an API call that returns the authorities that
#' submit data to the FHRS scheme, and their ID, which can be used to filter
#' other API calls. It takes an optional country parameter.
#'
#' @param country The country that the authority is located within, as a
#' character string: "England", "Wales", "Scotland" or "Northern Ireland".
#'
#' @return A tibble of authorities and their code, the number of
#' establishments they have, and for England or all authorities, their region.
#'
#' @examples
#' # Get all authorities in the FHRS
#' get_authorities()
#'
#' # Get all authorities in the FHRS in Scotland
#' get_authorities("Scotland")
#'
#' @export
#'
get_authorities <- function(country = NULL) {
  getbtype <- httr::GET("api.ratings.food.gov.uk/Authorities", httr::add_headers('x-api-version' = 2))
  la <- httr::content(getbtype, "text") %>%
    jsonlite::fromJSON() %>%
    .$authorities %>%
    tibble::as_tibble()
  if(is.null(country)){
    la %>%
      dplyr::select(LocalAuthorityId, Name, RegionName, EstablishmentCount)
  } else if(grepl("england", country, ignore.case = TRUE)) {
    la %>%
      dplyr::filter(RegionName != "Scotland" & RegionName != "Wales" & RegionName!= "Northern Ireland") %>%
      dplyr::select(LocalAuthorityId, Name, RegionName, EstablishmentCount)
  } else if(grepl("scotland", country, ignore.case = TRUE)) {
    la %>%
      dplyr::filter(RegionName == "Scotland") %>%
      dplyr::select(LocalAuthorityId, Name, EstablishmentCount)
  } else if(grepl("Wales", country, ignore.case = TRUE)) {
    la %>%
      dplyr::filter(RegionName == "Wales") %>%
      dplyr::select(LocalAuthorityId, Name, EstablishmentCount)
  } else if(grepl("Northern Ireland", country, ignore.case = TRUE)) {
    la %>%
      dplyr::filter(RegionName == "Northern Ireland") %>%
      dplyr::select(LocalAuthorityId, Name, EstablishmentCount)
  } else {
    stop("Country name not recognised")
  }
}
