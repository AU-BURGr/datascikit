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

install.packages(c("RProtoBuf","RCurl")) # 
library(RProtoBuf)
library(RCurl)
?RProtoBuf
vignette( "RProtoBuf", package = "RProtoBuf" )


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



gtfs_rt_feed <- "https://gtfsrt.api.translink.com.au/Feed/SEQ"
url_con <- url(gtfs_rt_feed)
readProtoFiles(gtfs_rt_feed)

message <- new( transit_realtime.VehiclePosition )

transit_realtime.VehiclePosition$position

fd <- transit_realtime.VehiclePosition$fileDescriptor()
