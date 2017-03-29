#' Survival times with right-censoring.
#'
#' A data set containing the survival or right-censoring times of 148 renal
#' patients following a kidney transplant.
#'
#' @name renal
#' @docType data
#' @usage data(renal)
#' @return A data frame with 148 rows and 3 variables. The data frame contains
#' the following columns:
#' \describe{
#' \item{t}{The survival or censoring time, in months, of the patient.}
#' \item{status}{A factor with two levels, 0 and 1, where 0 indicates that the
#' patient's survival time was right-censored and 1 indicates that it was observed.}
#' \item{x}{The total number of HLA-B or DR antigen mismatches between the kindey
#' donor and recipient.}}
#' @source The data set is taken from Henderson and Milner (1981).
#' @references
#' \insertRef{HM91}{jrRstan}
#' @keywords datasets
#' @examples
#' data(renal)
#' head(renal)
NULL
