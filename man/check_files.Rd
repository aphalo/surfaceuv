% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{check_files}
\alias{check_files}
\title{Check files}
\usage{
check_files(files, name.pattern = NULL)
}
\arguments{
\item{files}{character A vector of file names, no other limitation in length
than available memory to hold the data.}

\item{name.pattern}{character A vector of accepted file name patterns, used
as pattern in a call to \code{\link[=grepl]{grepl()}} If \code{NULL} the test is skipped, if
match fails, a warning is issued.}
}
\value{
A \code{character} vector with one or more paths to files as members.
}
\description{
Internal utility function used to check that file names passed
as argument are valid.
}
\details{
Accepts a \code{character} vector or a list of \code{character} vectors,
returning always a \code{character} vector. The character strings are assumed to
be paths to files. If the files pointed at cannot be accessed, and error is
triggered. If the files exist, but one or more do not match the expected
\code{name.pattern} a warning is triggered.
}
