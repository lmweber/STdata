#' Load data
#' 
#' Function to load data objects from STexampleData package
#' 
#' Function to load data objects from Dropbox links (until package is moved to
#' Bioconductor's ExperimentHub).
#' 
#' 
#' @param dataset_name Name of dataset. Currently accepts "Visium_humanDLPFC", 
#'   "Visium_mouseCoronal", or "seqFISH_mouseEmbryo".
#' 
#' @param path Directory to save temporary files. Default = "tmp".
#' 
#' @param delete Whether to delete temporary files. Default = TRUE.
#' 
#' 
#' @return SpatialExperiment object
#' 
#' 
#' @importFrom utils download.file
#' 
#' @export
#' 
#' @examples
#' #spe <- load_data("Visium_humanDLPFC")
#' #spe <- load_data("Visium_mouseCoronal")
#' #spe <- load_data("seqFISH_mouseEmbryo")
#' 
load_data <- function(dataset_name, path = "tmp", delete = TRUE) {
  
  match.arg(dataset_name, choices = c("Visium_humanDLPFC", "Visium_mouseCoronal", "seqFISH_mouseEmbryo"))
  
  # note: change "dl=0" to "dl=1" in link from Dropbox website to enable downloading
  if (dataset_name == "Visium_humanDLPFC") {
    url <- "https://www.dropbox.com/s/u7ramj36ech7bwu/Visium_humanDLPFC.RData?dl=1"
  } else if (dataset_name == "Visium_mouseCoronal") {
    url <- "https://www.dropbox.com/s/ilh0yk5n74ovbyu/Visium_mouseCoronal.RData?dl=1"
  } else if (dataset_name == "seqFISH_mouseEmbryo") {
    url <- "https://www.dropbox.com/s/ajr6zli8d1o0fv8/seqFISH_mouseEmbryo.RData?dl=1"
  }
  
  fn <- file.path(path, gsub("\\?.*$", "", basename(url)))
  
  dir.create(path)
  download.file(url, fn, mode = "wb")
  load(fn)
  
  if (delete) {
    unlink(path, recursive = TRUE)
  }
  
  spe
}

