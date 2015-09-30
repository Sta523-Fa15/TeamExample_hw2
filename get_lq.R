dir.create("data/lq/main/",recursive = TRUE, showWarnings = FALSE)

base_url = "http://www.lq.com"
page = "/en/findandbook/hotel-listings.html"

download.file(paste(base_url,page,sep=""),
              destfile = "data/lq/main/listings.html")

library(rvest)

file = read_html("data/lq/main/listings.html")

hotel_url = html_nodes(file,"#hotelListing .col-sm-12 a") %>% 
            html_attr("href") %>%
            .[!is.na(.)] %>%
            paste0(base_url, .) %>%
            head(n=5)

for(url in hotel_url)
{
  download.file(url, destfile=paste0("data/lq/",basename(url)))
}