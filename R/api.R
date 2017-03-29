#' Academic Performance Index (API) data.
#'
#' API test scores and demographic data for a simple random sample of 200 schools
#' in California from the year 2000.
#'
#' @name api
#' @docType data
#' @usage data(api)
#' @return A data frame with 200 rows and 6 variables. The data frame contains
#' the following columns:
#' \describe{
#' \item{api}{API score.}
#' \item{meals}{Percentage of students eligible for subsidized meals.}
#' \item{not.hsg}{Percentage of parents who are not high-school graduates.}
#' \item{ell}{Percentage of students who are ``English Language Learners''.}
#' \item{enroll}{Number of students enrolled at the school.}
#' \item{stype}{A factor with three levels, \code{E}, \code{M} and \code{H},
#' indicating whether the school is an Elementary school, Middle school or
#' High school.}}
#' @source The API website, including the original data files
#' are at \url{http://api.cde.ca.gov}.
#' @keywords datasets
#' @examples
#' data(api)
#' head(api)
NULL
