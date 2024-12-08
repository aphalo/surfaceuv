% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/suv-read-omuvdb-nc4.R
\name{sUV_read_OMUVBd_nc4}
\alias{sUV_read_OMUVBd_nc4}
\alias{sUV_vars_OMUVBd_nc4}
\alias{sUV_grid_OMUVBd_nc4}
\alias{sUV_date_OMUVBd_nc4}
\title{OMI/Aura Surface UV gridded subsets}
\usage{
sUV_read_OMUVBd_nc4(
  files,
  vars.to.read = NULL,
  fill = NA_real_,
  verbose = interactive()
)

sUV_vars_OMUVBd_nc4(files, set.oper = "intersect")

sUV_grid_OMUVBd_nc4(files, expand = FALSE)

sUV_date_OMUVBd_nc4(files, use.names = length(files > 1))
}
\arguments{
\item{files}{character A vector of file names, no other limitation in length
than available memory to hold the data.}

\item{vars.to.read}{character A vector of variable names. If \code{NULL} all the
variables present in the first file are read.}

\item{fill}{numeric The R value used to replace the fill value used in the
file, which is retrieved from the file metadata, and also used to fill
missing variables.}

\item{verbose}{logical Flag indicating if progress, and time and size of the
returned object should be printed.}

\item{set.oper}{character One of \code{"intersect"}, or \code{"union"}.}

\item{expand}{logical Flag indicating whether to return ranges or a
full grid.}

\item{use.names}{logical. Should names be added to the returned vector?}
}
\value{
Function \code{sUV_read_OMUVBd_nc4()} returns a data frame with columns
named \code{"Date"}, \code{"Longitude"}, \code{"Latitude"}, and the data variables with
their original names. The data variables have their metadata stored as R
attributes. \code{sUV_vars_OMUVBd_nc4()} returns a \code{character} vector of
variable names, \code{sUV_grid_OMUVBd_nc4()} returns a data frame with two
numeric variables, \code{Longitude} and \code{Latitude}, with two rows or an expanded
grid depending on the argument passed to \code{expand}, while
\code{sUV_date_OMUVBd_nc4()} returns a, by default named, vector of class
\code{Date}, with file names as names.
}
\description{
Import \strong{gridded} "Surface UV" data released by FMI/NASA
from \strong{NetCDF4} files downloaded from the NASA EARTHDATA server.
}
\details{
Function \code{sUV_read_OMUVBd_nc4()} can be used to read the data stored
in a file, either in full or selected variables. Query functions
\code{sUV_vars_OMUVBd_nc4()}, \code{sUV_grid_OMUVBd_nc4()} and
\code{sUV_date_OMUVBd_nc4()} extract the names of the variables, the range of
the grid and the dates of measurements much more efficiently than by using
\code{sUV_read_OMUVBd_nc4()}. The dates are decoded from the file names,
expecting these to be those set by the data provider. The grid is expected
to be identical in all files that are imported in a call to
\code{sUV_read_OMUVBd_nc4()}, and grid subsetting is currently not supported. If
not all the files named in the argument to \code{files} are accessible, an error
is triggered early. If the files differ in the grid, an error is triggered
when reading the first mismatching file. Missing variables named in
\code{vars.to.read} if detected when reading the first file, are filled with the
\code{fill} value, otherwise they trigger an error when an attempt is made to
read them.
}
\note{
The constraint on the consistency among all files to be read allows
very fast reading into a single data frame. If the files differ in the grid
or set of variables, this function can be used to read the files
individually into separate data frames. These data frames can later be
row-bound together.

This function's performance is fast as long as there is enough RAM
available to hold the data frame and the files are read from a reasonably
fast SSD. The example data included in the package are only for Spain and
five summer days. They are used in examples and automated tests.
}
\examples{
# find location of one example file
path.to.files <-
   system.file("extdata",
               package = "surfaceuv", mustWork = TRUE)

file.names <- list.files(path.to.files, pattern = "*.nc4$", full.names = TRUE)
one.file.name <- file.names[1]

# available variables
sUV_vars_OMUVBd_nc4(one.file.name)

# available grid
sUV_grid_OMUVBd_nc4(one.file.name)
sUV_grid_OMUVBd_nc4(one.file.name, expand = TRUE)

# decode date from file name
sUV_date_OMUVBd_nc4(one.file.name)
sUV_date_OMUVBd_nc4(one.file.name, use.names = FALSE)

# read all variables
midsummer_spain.tb <- sUV_read_OMUVBd_nc4(one.file.name)
dim(midsummer_spain.tb)
summary(midsummer_spain.tb)

# read only UVindex
midsummer_spain_daily.tb <-
  sUV_read_OMUVBd_nc4(one.file.name,
                    vars.to.read = "UVindex")
dim(midsummer_spain_daily.tb)
summary(midsummer_spain_daily.tb)

# read multiple files

sUV_vars_OMUVBd_nc4(file.names)

sUV_grid_OMUVBd_nc4(file.names)
sUV_grid_OMUVBd_nc4(file.names, expand = TRUE)

sUV_date_OMUVBd_nc4(file.names)
sUV_date_OMUVBd_nc4(file.names, use.names = FALSE)

summer_3days_spain.tb <- sUV_read_OMUVBd_nc4(file.names)
dim(summer_3days_spain.tb)
summary(summer_3days_spain.tb)

}
\references{
Jari Hovila, Antti Arola, and Johanna Tamminen (2013), OMI/Aura Surface UVB
Irradiance and Erythemal Dose Daily L3 Global Gridded 1.0 degree x 1.0 degree
V3, NASA Goddard Space Flight Center, Goddard Earth Sciences Data and
Information Services Center (GES DISC).
}
\seealso{
\code{\link[=sUV_read_OMUVBd_he5]{sUV_read_OMUVBd_he5()}} supporting the same Surface UV data as
stored in the original HDF5 files with a global geographic scope.
}
