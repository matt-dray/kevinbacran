#' Package-Author tidygraph from a CRAN database snapshot
#'
#' A tidygraph object of all package-author relationships as captured on 26
#' February 2019. Extracted using the \code{kevinbacran::kb_combos()} function.
#'
#' @format A large tbl_graph (16911 nodes, 99542 edges, 10 elements, 5.8 Mb)
#' \describe{
#'   \item{Nodes}{package authors}
#'   \item{Edges}{package names}
#'}
#'
#' @docType data
#'
#' @usage data(cran_pkg_data)
#'
#' @source \url{https://cran.r-project.org/}
"cran_pkg_graph"
