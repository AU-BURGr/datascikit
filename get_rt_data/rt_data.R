# git clone https://github.com/google/protobuf.git
# sudo ./configure
# sudo make check
# sudo make install
# protoc --version
# or
# install.packages(c("devtools")) # 
# devtools::git
#
# or for Ubu/Deb:
# sudo apt-get install libprotobuf-dev protobuf-compiler
# and Fedora/CentOS:
# protobuf-devel protobuf-compiler are needed
# 
# https://cran.r-project.org/web/packages/RProtoBuf/index.html
# https://cran.r-project.org/web/packages/RProtoBuf/vignettes/RProtoBuf-intro.pdf
install.packages(c("RProtoBuf","RCurl")) # 
library(RProtoBuf)
library(RCurl)
?RProtoBuf
# vignette( "RProtoBuf", package = "RProtoBuf" )


protofile_url <- "https://developers.google.com/transit/gtfs-realtime/gtfs-realtime.proto"
if(url.exists(protofile_url)) {
  protfile <- getURL(protofile_url, write = basicTextGatherer())
} else {
  error("gtfs proto file cannot be found here:", protofile_url)
  
}

tf <- tempfile("protofile")
writeLines(protfile,tf)

readProtoFiles( tf )   # dynamiclly compiles the prot format from the temporary file
ls( "RProtoBuf:DescriptorPool" )  # lists what buffers are possibly available


gtfs_rt_feed <- "https://gtfsrt.api.translink.com.au/Feed/SEQ"   # this is the data file on the server
SEQ_data <- getURLContent(gtfs_rt_feed, binary=T) # this downloads the data file
tf1 <- tempfile()                                 # Create a temp file to write data to
writeBin(as.raw(SEQ_data),tf1)                    # write the data to temp file as binary data
con <- file( tf1, open = "rb" )                   # Create a connection to the binary file on disk


message <- read(transit_realtime.VehiclePosition,con)     # Read te protobuf proto file defined data 
writeLines( transit_realtime.VehiclePosition$toString() ) # describe the data
writeLines( as.character( message ) )    # print the data
# (as.character( message ))
message[[2]]
list_messages <- as.list(message[[1]])                    # Convert the data to a list
print(as.character(list_messages))
sapply( message, function(p) print(p) )

rm(all_messages)

message <- read(transit_realtime.VehiclePosition,con)     # Read te protobuf proto file defined data 
writeLines( transit_realtime.Position$toString() )  # describe the data
writeLines( as.character( message ) )
message$fetch("latitude",1)
str(message)
str(message)
has(message, name="latitude")
writeLines(as.character(message$latitude))

message <- read(transit_realtime.VehiclePosition,con)     # Read te protobuf proto file defined data 
writeLines( transit_realtime.VehiclePosition$toString() )  # describe the data
str(message)
all_messages <- as.list(message)        # Convert the data to a list
message[["timestamp"]]
id <- message[[ 1 ]]
id <- message[[ 2 ]]$latitude
id <- message[[2]][[ "latitude" ]]
writeLines(transit_realtime.VehiclePosition$toString())
writeLines(transit_realtime.Position$toString())


close(con)


