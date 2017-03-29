#' Data to pass to stan function in Practical 1.
#'
#' A data set containing the list to pass as the data argument to the stan function
#' in Practical 1.
#'
#' @name practical1_data
#' @docType data
#' @usage data(practical1_data)
#' @return A list with 9 named elements:
#' \describe{
#' \item{y}{The response variable (API scores).}
#' \item{N}{The sample size.}
#' \item{K}{The number of explanatory variables, plus one.}
#' \item{X}{The design matrix.}
#' \item{x_pred}{The explanatory variables for predicting an extra school.}
#' \item{m_beta}{The prior means for beta.}
#' \item{s_beta}{The prior standard deviations for beta.}
#' \item{m_sigma_sq}{The prior mean for log(sigma_sq).}
#' \item{s_sigma_sq}{The prior standard deviations for log(sigma_sq).}}
#' @keywords datasets
#' @examples
#' data(practical1_data)
#' str(practical1_data)
NULL
