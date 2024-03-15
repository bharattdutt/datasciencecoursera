# Create a special matrix object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
  # Initialize the inverse matrix to NULL
  inv <- NULL

  # Define a function to set the matrix
  set <- function(y) {
    x <<- y
    inv <<- NULL  # Invalidate the cache when the matrix is set
  }

  # Define a function to get the matrix
  get <- function() x

  # Define a function to set the inverse matrix
  setInverse <- function(inverse) inv <<- inverse

  # Define a function to get the inverse matrix
  getInverse <- function() inv

  # Return a list of functions
  list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}

# Compute the inverse of a matrix, caching the result
cacheSolve <- function(x, ...) {
  # Retrieve the cached inverse if available
  inv <- x$getInverse()

  # If the inverse is not cached, compute it and cache the result
  if (is.null(inv)) {
    mat <- x$get()
    inv <- solve(mat, ...)
    x$setInverse(inv)
  } else {
    # If the inverse is cached, print a message indicating that cached data is used
    message("Getting cached data")
  }

  # Return the inverse matrix
  inv
}

