#' Rat tumour data.
#'
#' Proportion of rats with tumours in 71 different studies.
#'
#' @name rats
#' @docType data
#' @usage data(rats)
#' @return A data frame with 71 rows and 2 variables. The data frame contains
#' the following columns:
#' \describe{
#' \item{y}{Number of rats in study with a tumour.}
#' \item{n}{Total number of rats in study.}}
#' @source The data are taken from Table 5.1 of Gelman \emph{et al.} (2013) but
#' were originally reported in Tarone (1982).
#' @references
#' \insertRef{GCSDVR13}{jrRstan}
#'
#' \insertRef{Tar82}{jrRstan}
#' @keywords datasets
#' @examples
#' data(rats)
#' head(rats)
NULL
