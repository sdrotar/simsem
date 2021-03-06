\name{simSetSEM}
\alias{simSetSEM}
\title{
	Create a set of matrices of parameter and parameter values to generate and analyze data that belongs to SEM model
}
\description{
	This function will create set of matrices of free parameters and parameter values that belongs to full SEM model. The requirement is to specify factor residual correlation  or covariance matrix, regression coefficient matrix, factor loading matrix, and measurement error correlation or covariance matrix.	
}
\usage{
simSetSEM(..., exo = FALSE)
}
\arguments{
  \item{\dots}{
	Each element of model specification, as described in \code{Details}
}
  \item{exo}{
	specify \code{TRUE} if users wish to specify both exogenous and endogenous indicators.
}
}
\details{
	The matrices and vectors in the endogenous side are
	\itemize{
		\item \code{LY} for factor loading matrix from endogenous factors to Y indicators (need to be \code{\linkS4class{SimMatrix}} object). 
		\item \code{TE} for measurement error covariance matrix among Y indicators (need to be \code{\linkS4class{SymMatrix}} object).
		\item \code{RTE} for measurement error correlation matrix among Y indicators (need to be \code{\linkS4class{SymMatrix}} object).
		\item \code{BE} for regression coefficient matrix among endogenous factors (need to be \code{\linkS4class{SimMatrix}} object). 
		\item \code{PS} for residual covariance matrix among endogenous factors (need to be \code{\linkS4class{SymMatrix}} object).
		\item \code{RPS} for residual correlation matrix among endogenous factors (need to be \code{\linkS4class{SymMatrix}} object).
		\item \code{VTE} for measurement error variance of Y indicators (need to be \code{\linkS4class{SimVector}} object).
		\item \code{VY} for total variance of Y indicators (need to be \code{\linkS4class{SimVector}} object). NOTE: Either measurement error variance or indicator variance is specified. Both cannot be simultaneously specified.
		\item \code{TY} for measurement intercepts of Y indicators. (need to be \code{\linkS4class{SimVector}} object).
		\item \code{MY} for overall Y indicator means. (need to be \code{\linkS4class{SimVector}} object). NOTE: Either measurement intercept of indicator mean can be specified. Both cannot be specified simultaneously.
		\item \code{VPS} for residual variance of endogenous factors (need to be \code{\linkS4class{SimVector}} object).
		\item \code{VE} for total endogenous factor variance (need to be \code{\linkS4class{SimVector}} object). NOTE: Either total endogenous factor variance or residual endogenous factor variance is specified. Both cannot be simultaneously specified.
		\item \code{AL} for endogenous factor intercept (need to be \code{\linkS4class{SimVector}} object).
		\item \code{ME} for total mean of endogenous factors (need to be \code{\linkS4class{SimVector}} object). NOTE: Either endogenous factor intercept or total mean of endogenous factor is specified. Both cannot be simultaneously specified.
	}
	There are four required matrices for the specification in the endogenous side only: LY, RTE (or TE), BE, and RPS (or PS). 
	If users need to specify exogenous variable too (\code{"exo=TRUE"}), these matrices and vectors are available: 
	\itemize{
		\item \code{LX} for factor loading matrix from exogenous factors to X indicators (need to be \code{\linkS4class{SimMatrix}} object). 
		\item \code{TD} for measurement error covariance matrix among X indicators (need to be \code{\linkS4class{SymMatrix}} object).
		\item \code{RTD} for measurement error correlation matrix among X indicators (need to be \code{\linkS4class{SymMatrix}} object).
		\item \code{GA} for regression coefficient matrix among exogenous factors (need to be \code{\linkS4class{SimMatrix}} object). 
		\item \code{PH} for residual covariance matrix among exogenous factors (need to be \code{\linkS4class{SymMatrix}} object).
		\item \code{RPH} for residual correlation matrix among exogenous factors (need to be \code{\linkS4class{SymMatrix}} object).
		\item \code{VTD} for measurement error variance of X indicators (need to be \code{\linkS4class{SimVector}} object).
		\item \code{VX} for total variance of X indicators (need to be \code{\linkS4class{SimVector}} object). NOTE: Either measurement error variance or indicator variance is specified. Both cannot be simultaneously specified.
		\item \code{TX} for measurement intercepts of Y indicators. (need to be \code{\linkS4class{SimVector}} object).
		\item \code{MX} for overall Y indicator means. (need to be \code{\linkS4class{SimVector}} object). NOTE: Either measurement intercept of indicator mean can be specified. Both cannot be specified simultaneously.
		\item \code{VPH} or \code{VK} for total exogenous factor variance (need to be \code{\linkS4class{SimVector}} object).
		\item \code{KA} or \code{MK} for total mean of exogenous factors (need to be \code{\linkS4class{SimVector}} object).
		\item \code{TH} for measurement error covariance between X measurement error and Y measurement error.
		\item \code{RTH} for measurement error correlation between X measurement error and Y measurement error.
	}
	There are eight required matrices for the specification in both exogenous and endogenous sides: LY, RTE (or TE), BE, RPS (or PS), LX, RTD (or TD), GA, and RPH (or PH). 
	If users specify the correlation/variance format (instead of the covariance format), the default specifications are
	\enumerate{
		\item All indicator variances are equal to 1. Measurement error variances are automatically implied from total indicator variances.
		\item All measurement error variances are free parameters.
		\item All indicator means are equal to 0. Indicator intercepts are automatically implied from indicator means.
		\item All indicator intercepts are free parameters.
		\item All factor variances are equal to 1.
		\item All factor variances are fixed.
		\item All factor means are equal to 0.
		\item All factor means are fixed.
	}
}
\value{
	\code{\linkS4class{SimSet}} object that represents the SEM object. This will be used for specifying data or analysis models later.
}
\author{
    Sunthud Pornprasertmanit (University of Kansas; \email{psunthud@ku.edu})
}
\seealso{
	\itemize{
		\item See class \code{\linkS4class{SimSet}} for simResult details. 
		\item See \code{\linkS4class{SimMatrix}}, \code{\linkS4class{SymMatrix}}, or \code{\linkS4class{SimVector}} for input details.
		\item Use \code{\link{simSetCFA}} to specify CFA model and use \code{\link{simSetPath}} to specify path analysis model.
	}
}
\examples{
u35 <- simUnif(0.3, 0.5)
u68 <- simUnif(0.6, 0.8)
n65 <- simNorm(0.6, 0.05)
loading <- matrix(0, 8, 3)
loading[1:3, 1] <- NA
loading[4:6, 2] <- NA
loading[7:8, 3] <- NA
loading.start <- matrix("", 8, 3)
loading.start[1:3, 1] <- 0.7
loading.start[4:6, 2] <- 0.7
loading.start[7:8, 3] <- "u68"
LY <- simMatrix(loading, loading.start)

RTE <- symMatrix(diag(8))

factor.cor <- diag(3)
factor.cor[1, 2] <- factor.cor[2, 1] <- NA
RPS <- symMatrix(factor.cor, 0.5)

path <- matrix(0, 3, 3)
path[3, 1:2] <- NA
path.start <- matrix(0, 3, 3)
path.start[3, 1] <- "n65"
path.start[3, 2] <- "u35"
BE <- simMatrix(path, path.start)

SEM.model <- simSetSEM(BE=BE, LY=LY, RPS=RPS, RTE=RTE)

loading.X <- matrix(0, 6, 2)
loading.X[1:3, 1] <- NA
loading.X[4:6, 2] <- NA
LX <- simMatrix(loading.X, 0.7)

loading.Y <- matrix(NA, 2, 1)
LY <- simMatrix(loading.Y, "u68")

RTD <- symMatrix(diag(6))

RTE <- symMatrix(diag(2))

factor.K.cor <- matrix(NA, 2, 2)
diag(factor.K.cor) <- 1
RPH <- symMatrix(factor.K.cor, 0.5)

RPS <- symMatrix(as.matrix(1))

path.GA <- matrix(NA, 1, 2)
path.GA.start <- matrix(c("n65", "u35"), ncol=2)
GA <- simMatrix(path.GA, path.GA.start)

BE <- simMatrix(as.matrix(0))

SEM.Exo.model <- simSetSEM(GA=GA, BE=BE, LX=LX, LY=LY, RPH=RPH, RPS=RPS, RTD=RTD, RTE=RTE, exo=TRUE)
}
