##
## script to create (or start) codebook
## read variables from data file
##  inspired by TA David Hood in Forum
##

wd <- "~/Documents/datasciencecoursera/GettingCleaningData/project/"

dataLoc <- paste(wd,"UCI HAR Dataset/", sep = "")
setwd(dataLoc)

data <- read.table("../part5Data.txt", header = TRUE, check.names = FALSE)

descrip <- colnames(data)

explanation <- descrip 

codebook <- paste("* ",descrip,"\n", "  a number - the mean value of this variable grouped by Activity and Subject","\n") 
write.table(codebook, "../codebook_basis.md", quote = FALSE, row.names = FALSE, col.names = FALSE)