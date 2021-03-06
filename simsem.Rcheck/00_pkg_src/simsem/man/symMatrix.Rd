\name{symMatrix}
\alias{symMatrix}
\title{
	Create symmetric simMatrix that save free parameters and starting values, as well as fixed values
}
\description{
	Create \code{SymMatrix} object that save free parameters and starting values, as well as fixed values. This will be used for model specification later, such as for factor residual correlation matrix or measurement error correlation matrix.
}
\usage{
symMatrix(free = NULL, value = NULL)
}
\arguments{
  \item{free}{
	Symmetric matrix of free parameters. Use \code{NA} to specify free parameters. Use number as fixed value (including zero). The input matrix need to be symmetric matrix. If this argument is not specified, the information from the \code{value} argument is used. The positions in the \code{value} argument that are 0 or "" are fixed parameters as 0. The positions with 1 are fixed parameters as 1. The other positions are free parameters.
}
  \item{value}{
	Starting values. Can be either one element or matrix with the same dimension as free parameter matrix. Each element can be numbers (in either \code{as.numeric} or \code{as.character} format) or the name of distribution object \code{\linkS4class{VirtualDist}}.
}
}
\value{
	\code{SymMatrix} object that will be used for model specification later.
}
\author{
    Sunthud Pornprasertmanit (University of Kansas; \email{psunthud@ku.edu})
}
\seealso{
	See \code{\linkS4class{VirtualDist}} for the resulting object. See \code{\link{simMatrix}} for creating simMatrix and \code{\link{simVector}} for simVector.
}
\examples{
latent.cor <- matrix(NA, 3, 3)
diag(latent.cor) <- 1
RPH <- symMatrix(latent.cor, 0.5)

u46 <- simUnif(0.4, 0.6)
factor.cor <- matrix(NA, 4, 4)
diag(factor.cor) <- 1
factor.cor.start <- matrix("u46", 4, 4)
factor.cor.start[1, 2] <- factor.cor.start[2, 1] <- "0.5"
RPS <- symMatrix(factor.cor, factor.cor.start)

start <- diag(4)
start[1, 2] <- 0.5
start[2, 1] <- 0.5
ST <- symMatrix(value=start)
}
