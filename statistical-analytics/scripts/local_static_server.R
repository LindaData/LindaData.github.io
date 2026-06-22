#!/usr/bin/env Rscript

# Preview the static hub locally without Ruby/Jekyll:
# Rscript statistical-analytics/scripts/local_static_server.R 8123

args <- commandArgs(trailingOnly = TRUE)
port <- if (length(args) >= 1) as.integer(args[[1]]) else 8123L
root <- normalizePath(if (length(args) >= 2) args[[2]] else ".", winslash = "/", mustWork = TRUE)

if (!requireNamespace("httpuv", quietly = TRUE)) {
  stop("Install the httpuv package to use this local preview server: install.packages('httpuv')", call. = FALSE)
}

content_type <- function(path) {
  ext <- tolower(tools::file_ext(path))
  switch(
    ext,
    "html" = "text/html; charset=utf-8",
    "css" = "text/css; charset=utf-8",
    "js" = "application/javascript; charset=utf-8",
    "json" = "application/json; charset=utf-8",
    "csv" = "text/csv; charset=utf-8",
    "png" = "image/png",
    "jpg" = "image/jpeg",
    "jpeg" = "image/jpeg",
    "gif" = "image/gif",
    "svg" = "image/svg+xml",
    "R" = "text/plain; charset=utf-8",
    "r" = "text/plain; charset=utf-8",
    "py" = "text/plain; charset=utf-8",
    "sql" = "text/plain; charset=utf-8",
    "md" = "text/markdown; charset=utf-8",
    "application/octet-stream"
  )
}

not_found <- function() {
  list(status = 404L, headers = list("Content-Type" = "text/plain; charset=utf-8"), body = "Not found")
}

app <- list(
  call = function(req) {
    request_path <- URLdecode(req$PATH_INFO)
    request_path <- sub("^/+", "", request_path)
    if (!nzchar(request_path)) {
      request_path <- "index.html"
    }

    candidate <- normalizePath(file.path(root, request_path), winslash = "/", mustWork = FALSE)
    if (dir.exists(candidate)) {
      candidate <- normalizePath(file.path(candidate, "index.html"), winslash = "/", mustWork = FALSE)
    }

    if (!startsWith(candidate, root) || !file.exists(candidate) || dir.exists(candidate)) {
      return(not_found())
    }

    list(
      status = 200L,
      headers = list("Content-Type" = content_type(candidate)),
      body = readBin(candidate, what = "raw", n = file.info(candidate)$size)
    )
  }
)

message("Serving ", root, " at http://127.0.0.1:", port)
httpuv::runServer("127.0.0.1", port, app)
