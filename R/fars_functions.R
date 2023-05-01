#  ----------------------------------------------------------------------------
#  COURSERA: Building R Packages
#  Week 4: Peer-graded Assignment
#  File: fars_functions.R
#  (c) 2022-2023 - Byron Mattingly
#  GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#  ---------------------------------------------------------------------------

#' @title fars_read - Read FARS .csv file into a data frame
#'
#' @description
#' This function reads a (compressed) csv file containing data from the US National
#' Highway Traffic Safety Administration's Fatality Analysis Reporting System into
#' a data frame. See also:
#' \itemize{
#'   \item{\url{https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars}}
#'   \item{\url{https://en.wikipedia.org/wiki/Fatality_Analysis_Reporting_System}}
#' }
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
#' @param filename The name of data file as a character string
#'
#' @return A data frame containing the data read from the csv file, or an error
#'         if the file does not exists.
#'
#' @examples
#' library(dplyr)
#' library(readr)
#' yr <- 2015
#' data <- yr %>%
#'   make_filename %>%
#'   fars_read
#' head(data)
#' @note To generate file name use: \code{\link{make_filename}}
#' @export
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}

#' make_filename - Make a compressed bz2 filename for a given year
#'
#' Make a (.csv) data filename for a given \code{year}
#' Note: This function does not check if the file is available.
#'
#' @param year A string or an integer with the input \code{year}
#'
#' @return This function returns the data filename as a string for a given year
#'
#' @examples
#' \dontrun{
#' make_filename(2013)
#' make_filename("2014")
#' make_filename(year = 2015)
#' }
#' @seealso \link{fars_read}
#'
#' @export
make_filename <- function(year) {
  year <- as.integer(year)
        system.file("extdata",
                    sprintf("accident_%d.csv.bz2", year),
                    package = "fars",
                    mustWork = TRUE)
}

#' fars_read_years - Read fars datafiles for a given list of years
#'
#' This function is used by \code{fars_summarize_years}
#'
#' @param years The years of the accidents as a list or vector of integers
#'
#' @importFrom dplyr mutate select
#' @importFrom magrittr "%>%"
#
#' @return The accidents for given years sorted by month as list of data frames
#'     with integers and numeric elements. Returns NULL (and a warning) if the
#'     \code{year} is not a valid year in the dataset
#'
#' @seealso \link{fars_read}
#' @seealso \link{make_filename}
#' @seealso \link{fars_summarize_years}
#'
#' @examples
#' \dontrun{
#' fars_read_years(2013)
#' fars_read_years("2014")
#' fars_read_years(c(2013,2014))
#' fars_read_years(years = 2013:2015)
#' fars_read_years(years = list(2013,2014,2015))
#' }
#'
#' @export
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>%
        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}

#' fars_summarize_years - Summarize the number of accidents per month by years
#'
#' This function summarizes yearly accidents data, by year and counts the number
#' of reports per month
#'
#' @param years A list of years (strings)
#'
#' @return A dataframe summary table that contains the number of accidents grouped
#'    by year and month of the given list of years
#'
#' @importFrom dplyr bind_rows
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom tidyr spread
#' @importFrom magrittr "%>%"
#' @importFrom dplyr n
#'
#' @seealso \link{fars_read_years}
#'
#' @examples
#' \dontrun{
#' plot(fars_summarize_years(2013))
#' fars_summarize_years("2014")
#' fars_summarize_years(c(2013,2014))
#' fars_summarize_years(2013:2015)
#' fars_summarize_years(list(2013, 2014, 2015))
#' }
#'
#' @export
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by(.data$year, .data$MONTH) %>%
    dplyr::summarize(n = dplyr::n()) %>%
    tidyr::spread(.data$year, .data$n)
}

#' fars_map_state - Create a map to display accidents by state and year
#'
#' Displays a map of the reported accidents in the selected state for a given year
#' If the \code{state.num} is invalid the function shows an error
#'
#' @param state.num The state index as an integer
#' @param year      A string, or an integer, with the input \code{year}
#'
#' @importFrom maps map
#' @importFrom dplyr filter
#' @importFrom graphics points
#'
#' @return This function shows a geographical map of the state with each point
#'      representing individual travel accidents for a given year
#'
#' @seealso \link{fars_read}
#' @seealso \link{make_filename}
#'
#' @examples
#' \dontrun{
#' fars_map_state(state.num = 10, year = 2013)
#' fars_map_state(49, 2015)
#' fars_map_state("1",2014)
#' }
#'
#' @export
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
