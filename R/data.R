#' Package-Author Tidygraph From A CRAN Database Snapshot
#'
#' A tidygraph object of all package-author relationships as captured on 28
#' February 2019. Extracted using the \code{kevinbacran::kb_combos()} function.
#' Intended as an example for testing the other functions in the package.
#'
#' @format A large tbl_graph (16924 nodes, 99568 edges, 10 elements, 5.8 Mb)
#' \describe{
#'   \item{Nodes}{package authors}
#'   \item{Edges}{package names}
#'}
#'
#' @docType data
#'
#' @usage data(cran_graph)
#'
#' @source \url{https://cran.r-project.org/}
"cran_graph"
