#' Get establishments
#'
#' Fetches a list of establishments
#'
#' `get_establishments` makes an API call that returns all establishments, with
#' the ability to filter by name, local authority and business type.
#'
#' @param name A string to search for within the business name
#' @param la The ID of the required local authority (as returned from `get_authorities()`)
#' @param type The code of the required business type (as returned from `get_business_types()`)
#' @param condensed By default the function returns a selection of variables: to return
#' everything in the API call, set this to FALSE
#'
#' @return A tibble containing all businesses that meet the specified criteria
#'
#' @examples
#' \dontrun{
#' library(dplyr)
#' # A list of all restaurants in Aberdeen
#' # Find the code for Aberdeen
#' get_authorities() %>%
#'   filter(grepl("Aberdeen", name))
#' # Find the code for restaurants
#' get_business_types()
#' # Perform establishment search
#' get_establishments(la = 197, type = 1)
#'
#' # A list of all businesses containing the words "pret a manger" in Birmingham
#' # Find out the code for Birmingham
#' get_authorities() %>%
#'   filter(grepl("Birmingham", name))
#' # Perform establishment search
#' get_establishments(name = "pret a manger", la = 374)
#' }
#'
#'
#' @export
#'
get_establishments <- function(name = NULL, la = NULL, type = NULL, condensed = TRUE) {
  name <- gsub(" ", "%20", name)
  query <- paste0("api.ratings.food.gov.uk/Establishments?name=",name,"&businessTypeId=",type,"&localAuthorityId=",la)
  pages <- getpages(query)
  if(pages == 0) {
    return("No results")
  } else if(pages == 1) {
    httr::GET(query, httr::add_headers('x-api-version' = 2)) %>%
      httr::content("text") %>%
      jsonlite::fromJSON() %>%
      .$establishments %>%
      jsonlite::flatten() %>%
      tibble::as_tibble() %>%
      tabletidy(., condensed)
  } else if(pages > 1) {
    getpage <- function(n) {
      url <- paste0(query,"&pageNumber=",n)
      httr::GET(url, httr::add_headers('x-api-version' = 2)) %>%
        httr::content("text") %>%
        jsonlite::fromJSON() %>%
        .$establishments %>%
        jsonlite::flatten() %>%
        tibble::as_tibble()
    }
    lapply(1:pages, getpage) %>%
     do.call(rbind,.) %>%
      tabletidy(., condensed)
  }
}
