# kb_distance -------------------------------------------------------------

#' @title The Degree Of Separation Between Named Authors
#'
#' @description Returns a numeric value that represents the degrees of
#'     separation between the two named authors that were provided to
#'     \code{kevinbacran::kb_pair()}. This value is the number of edges, or
#'     packages, required to link those two authors by the shortest route. The
#'     value is analagous to the 'Kevin Bacon Number' or 'Erdos Number'.
#' @param pair_graph A tidygraph object of CRAN authors/packages created with
#'     \code{kb_pair()}
#' @importFrom dplyr as_tibble summarise pull
#' @importFrom tidygraph activate
#' @export
#' @return A single numeric value
#' @examples
#' \dontrun{
#' separation <- kb_distance(pair_graph)
#' print(separation)
#' }

kb_distance <- function(pair_graph) {

  # if(class(tidy_graph) == "tbl_graph") {
  #   stop("The tidy_graph argument should be a tbl_graph object\n",
  #        "You have provided an object of class ", class(tidy_graph)[1])
  # }

  # Get the number of connections between them
  distance <- pair_graph %>%
    activate(edges) %>%
    as_tibble() %>%
    summarise(n()) %>%
    pull()

  # Spit it out
  return(distance)

}

# kb_plot -----------------------------------------------------------------

#' @title Simple Plot Of Shortest Distance Between CRAN Authors
#'
#' @description Returns a ggplot2 object that represents the degrees of
#'     separation between the two named authors that were provided to
#'     \code{kevinbacran::kb_pair()}. The two named authors are terminal nodes.
#'     Intermediate nodes represent intermediate authors that link via edges
#'     that represent a package that the authors collaborated on.
#' @param pair_graph A tidygraph object of CRAN authors/packages created with
#'     \code{kb_pair()}
#' @import ggraph
#' @importFrom ggplot2 aes unit
#' @export
#' @return A ggraph plot
#' @examples
#' \dontrun{
#'  <- kb_plot(pair_graph)
#' print(separation)
#' }

kb_plot <- function(pair_graph) {

  # if(class(tidy_graph) == "tbl_graph") {
  #   stop("The tidy_graph argument should be a tbl_graph object\n",
  #        "You have provided an object of class ", class(tidy_graph)[1])
  # }

  plot <- pair_graph %>%
    ggraph(layout = "nicely") +
    geom_edge_fan(
      aes(
        label = paste0("{", package, "}"),
        family = "mono"
      ),
      edge_colour = "grey90",
      label_colour = "grey50",
      angle_calc = "none"
    ) +
    geom_node_point() +
    geom_node_text(
      aes(label = name),
      repel = TRUE,
      family = "sans"
    ) +
    theme_graph()

  return(plot)

}
