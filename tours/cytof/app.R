library(iSEE)

tour_steps <- read.delim("tour.txt", header = TRUE, as.is = TRUE, sep = ";")
bcrxl <- readRDS("sce.rds")

# Reset the path to the HDF5 file relative to the container
path(assay(bcrxl, "exprs")) <- file.path(getwd(), "sce.h5")

## Set up panels (6 feature assay plots)
fd <- featAssayPlotDefaults(bcrxl, 6)

initialPanels = DataFrame(
    Name = c(sprintf("Feature assay plot %i", seq(1, nrow(fd), 1))),
    Width = 4)

## Appearance
fd$VisualBoxOpen <- c(TRUE, FALSE, FALSE, FALSE, FALSE, TRUE)
fd$DataBoxOpen <- c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE)
fd$SelectBoxOpen <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE)
fd$VisualChoices <- lapply(seq_len(nrow(fd)), function(i) list("Color", "Points"))

## X-axis
fd$XAxis <- rep(c("Column data", "Feature name", "Column data"), c(3, 2, 1))
fd$XAxisColData <- rep(c("sample_id", "group_id"), c(5, 1))
fd$XAxisFeatName <- match(c("", "", "", "CD3", "IgM", ""), rownames(bcrxl))

## Y-axis
fd$YAxisFeatName <- match(c("BC2", "BC4", "BC6", "CD20", "CD45", "pS6"), rownames(bcrxl))

## Coloring
fd$ColorBy <- c(rep("Column data", 3), "None", "None", "Column data")
fd$ColorByColData <- c(rep("sample_id", 3), rep("group_id", 3))

## Downsampling
fd$Downsample <- TRUE
fd$SampleRes <- 200

## Point selection
fd$SelectByPlot <- c("", "", "", "", "Feature assay plot 4", "Feature assay plot 5")
fd$SelectEffect <- "Restrict"
fd$BrushData <- list(NULL, NULL, NULL,
                     list(xmin = -3.2643893296676, xmax = 6.2505437028317, ymin = 3.9638278603138, ymax = 6.6394433908566, mapping = list(x = "X", y = "Y"), domain = list(left = -3.77917836650223, right = 8.80210985412216, bottom = -3.47327157913897, top = 7.12045292443739), range = list(left = 44.2370906464041, right = 209.520547945205, bottom = 374.038986186765, top = 21.6559662590161), log = list(x = NULL, y = NULL), direction = "xy", brushId = "featAssayPlot4_Brush", outputId = "featAssayPlot4"),
                     list(xmin = -1.3837629808554, xmax = 1.6091336966254, ymin = 0.38148152957448, ymax = 7.4740835739801, mapping = list(x = "X", y = "Y"), domain = list(left = -3.80032310964924, right = 9.1168276366504, bottom = 0.248462505430422, top = 7.95803222728227), range = list(left = 32.5671687714041, right = 209.520547945205, bottom = 374.038986186765, top = 24.0290131340161), log = list(x = NULL, y = NULL), direction = "xy", brushId = "featAssayPlot5_Brush", outputId = "featAssayPlot5"),
                     NULL)

iSEE(bcrxl, tour = tour_steps,
     redDimArgs = NULL, colDataArgs = NULL,
     featAssayArgs = fd,
     rowStatArgs = NULL, rowDataArgs = NULL, heatMapArgs = NULL,
     redDimMax = 0, colDataMax = 0,
     featAssayMax = nrow(fd),
     rowStatMax = 0, rowDataMax = 0, heatMapMax = 0,
     initialPanels = initialPanels,
     appTitle = "Analyzing mass cytometry data with complex gating schemes")
