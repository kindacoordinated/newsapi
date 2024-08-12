library(httr2)

req <- request("https://newsapi.org/v2/everything") |>
    req_url_query(
        q = '`"data science"`',
        from = Sys.Date() - 1,
        pageSize = 10,
        apiKey = Sys.getenv("NEWS_API_KEY")
    )

# Perform the request
resp <- req_perform(req)

# Parse the response as JSON
news_data <- resp_body_json(resp)

# Create the output file path
output_dir <- "data"
if (!dir.exists(output_dir)) {
    dir.create(output_dir)
}

# Create the file name based on the current date
output_file <- file.path(output_dir, paste0(Sys.Date(), ".json"))

# Write the parsed JSON data to a file
write_json(news_data, output_file, pretty = TRUE)

# Print a message to confirm the output
cat("News data saved to:", output_file, "\n")
