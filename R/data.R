#' Package-Author tidygraph from a CRAN database snapshot
#'
#' A tidygraph object of all package-author relationships as captured on 27
#' February 2019. Extracted using the \code{kevinbacran::kb_combos()} function.
#' Intended as an example for testing the other functions in the package.
#'
#' @format A large tbl_graph (16915 nodes, 99560 edges, 10 elements, 5.8 Mb)
#' \describe{
#'   \item{Nodes}{package authors}
#'   \item{Edges}{package names}
#'}
#'
#' @docType data
#'
#' @usage data(cran_pkg_graph)
#'
#' @source \url{https://cran.r-project.org/}
"cran_pkg_graph"
