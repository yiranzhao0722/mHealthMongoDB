library(rmongodb)
library(chron) # NOTE: you don't need this for Mongo; it's for the sensor readings plot

# connect to mongodb server on host and connect to db
mongo = mongo.create(host="MONGODB_HOST",db="DATABASE_NAME")

if (mongo.is.connected(mongo)) {
  
  # this sets up the query (there are other "buffer.append…" functions
  today = format(Sys.time(), "%Y-%m-%d")
  buf = mongo.bson.buffer.create()
  mongo.bson.buffer.append.string(buf,"date",today)
  query = mongo.bson.from.buffer(buf)
  
  # run the query and get total results & the starting db cursor  
  todays.readings.count = mongo.count(mongo,"solar.readings",query)
  todays.readings.cursor = mongo.find(mongo,"solar.readings",query)
  
  # setup some vectors to hold our results  
  time = vector("character",todays.readings.count)
  lux = vector("numeric",todays.readings.count)
  full = vector("numeric",todays.readings.count)
  IR = vector("numeric",todays.readings.count)
  
  i = 1
  
  # iterate over the results with the cursor    
  while (mongo.cursor.next(todays.readings.cursor)) {
    
    # get the values of the current record
    cval = mongo.cursor.value(todays.readings.cursor)
    
    # split it out into our vectors    
    time[i] = mongo.bson.value(cval,"time")
    full[i] = mongo.bson.value(cval,"Full")
    lux[i] = mongo.bson.value(cval,"Lux")
    IR[i] = mongo.bson.value(cval,"IR")
    
    i = i + 1
    
  }
  
  # packages all our values up into a data frame  
  df = as.data.frame(list(time=time,full=full,lux=lux,IR=IR))
  
  # (for my wx data, I need 'time' as an actual time value)  
  df$Time = times(df$time)
  df$time = NULL
  
  par(mfrow=c(3,1))
  plot(df$full~df$Time,type="l",col="blue",lwd="1",xlab="",ylab="Full Spectrum",main=paste(today," Solar Radiation Readings"))
  plot(df$lux~df$Time,type="l",col="blue",lwd="1",xlab="",ylab="Lux (calculated)")
  plot(df$IR~df$Time,type="l",col="blue",lwd="1",xlab="Time",ylab="IR")
  par(mfrow=c(1,1))