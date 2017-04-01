# Courtesy of Thomas Lumley via https://gist.github.com/tslumley/6029f786c19c2218859e6c478d1dcb99
# a<-as.bentime("16:45:00")
# b<-as.bentime("9:20:00")
# a
# b
# a+b
# a-b
# (a+b)-b

"+.bentime"<-function(e1,e2){
    e<-list(hour=e1$hour+e2$hour,min=e1$min+e2$min,sec=e1$sec+e2$sec)
    sec_overflow<-e$sec>60L
    e$sec<-e$sec %% 60L
    e$min<-e$min+sec_overflow
    min_overflow<-e$min>60L
    e$hour<-e$hour+min_overflow
    e$min<-e$min %% 60L
    class(e)<-"bentime"
    e
}

"-.bentime"<-function(e1,e2){
    e<-list(hour=e1$hour-e2$hour,min=e1$min-e2$min,sec=e1$sec-e2$sec)
    sec_overflow<-e$sec<0L
    e$sec<-e$sec %% 60L
    e$min<-as.integer(e$min-sec_overflow)
    min_overflow<-e$min< 0L
    e$hour<-as.integer(e$hour-min_overflow)
    e$min<-e$min %% 60L
    class(e)<-"bentime"
    e
}


bentime<-function(hour,min,sec){
    rval<-list(hour,min,sec)
    class(rval)<-"bentime"
}

print.bentime<-function(x,...) cat(paste(x$hour, formatC(x$min,width=2,digits=0,flag=0), formatC(x$sec,width=2,digits=0,flag=0),sep=":"))

as.bentime <-function(x,...) UseMethod("as.bentime")

as.bentime.POSIXlt<-function(x,...){
    rval<-unclass(x)[c("hour","min","sec")]
    class(rval)<-"bentime"
    rval
}

as.bentime.character<-function(x,...){
    y<-as.POSIXlt(x,format="%H:%M:%S")
    as.bentime(y)
}

