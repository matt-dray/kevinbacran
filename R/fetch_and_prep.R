# kb_combos ---------------------------------------------------------------

#' @title Fetch CRAN Authors And Create Tidygraph
#'
#' @description Fetches CRAN package data, cleans author names, creates a tidy
#'     tibble of each package-author combination and turns this into a tidygraph
#'     object. Nodes are authors and edges are packages they collaborate on.
#' @importFrom cranly clean_CRAN_db
#' @import dplyr
#' @importFrom purrr map
#' @importFrom tidygraph as_tbl_graph
#' @importFrom tidyr unnest
#' @export
#' @return A tidygraph object with classes 'tbl_graph' and 'igraph'.
#' @examples
#' \dontrun{
#' cran_graph <- kb_combos()
#' print(cran_graph)
#' }

kb_combos <- function() {

  cat("\nFetching CRAN data and tibblifying...\n")

  # Get data and arrange into tibble
  # Tidy tibble of each package-author combination
  cran_tidy <- tools::CRAN_package_db() %>%
    clean_CRAN_db() %>%
    as_tibble() %>%
    select(package, author) %>%
    unnest()

  cat("\nGetting combinations of authors per package...\n")

  # Get author combos per package
  # Tibble of V1 (node from) and V2 (node to) combinations per package
  cran_combos <- cran_tidy %>%
    group_by(package) %>%
    filter(n() > 1) %>%  # ignore solo authors
    ungroup() %>%
    left_join(x = ., y = ., by = "package") %>%
    filter(author.y > author.x) %>%
    select(author.x, author.y, package)

  cat("\nCreating tidy graph object from combinations...\n")

  # To tidygraph object
  cran_graph <- as_tbl_graph(cran_combos, directed = FALSE) %>%
    mutate(number = row_number())

  cat("\nDone!\n")

  # Spit it out
  return(cran_graph)

}

# kb_pair -----------------------------------------------------------------

#' @title Get Author-Package Network For Two Named Authors
#'
#' @description Finds one of the possible shortest paths between two named
#'     authors from CRAN. This is possible by searching the tidygraph object of
#'     all CRAN's package-author relationships created with
#'     \code{kevinbacran::kb_combos()}. Outputs a tidygraph object that's a
#'     subset of the full CRAN tidygraph. This output contains only the named
#'     authors and the authors and packages that link them together.
#' @param tidy_graph A tidygraph object of CRAN authors/packages created with
#'     \code{kb_combos()}
#' @param name_a A character string of a CRAN author's name (one of two)
#' @param name_b A character string of a CRAN author's name (two of two)
#' @import dplyr
#' @importFrom tidygraph convert to_shortest_path
#' @export
#' @return A tidygraph object with classes 'tbl_graph' and 'igraph'.
#' @examples
#' \dontrun{
#' pair_graph <- kb_pair(cran_graph, "Garrett Grolemund", "Yihui Xie")
#' print(pair_graph)
#' }

kb_pair <- function(tidy_graph, name_a, name_b = "Hadley Wickham") {

  # if(class(tidy_graph) == "tbl_graph") {
  #   stop("The tidy_graph argument should be a tbl_graph object\n",
  #        "You have provided an object of class ", class(tidy_graph)[1])
  # }

  if(!is.character(name_a)) {
    stop("The name_a argument should be a character string\n",
         "You have provided an object of class ", class(name_a)[1])
  }

  if(!is.character(name_b)) {
    stop("The name_b argument should be a character string\n",
         "You have provided an object of class ", class(name_b)[1])
  }

  node_from <- tidy_graph %>%
    as_tibble() %>%
    filter(name == name_a) %>%
    pull(number)

  node_to <- tidy_graph %>%
    as_tibble() %>%
    filter(name == name_b) %>%
    pull(number)

  # Limit the network to the authors specified in to_name and from_name
  short_graph <- tidy_graph %>%
    convert(to_shortest_path, from = node_from, to = node_to)

  # Spit it out
  return(short_graph)

}
