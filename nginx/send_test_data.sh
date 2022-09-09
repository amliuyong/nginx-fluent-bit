for i in `seq 1 100000`
do 
 echo $i
 curl -XPOST http://localhost:8089/log -d "$i - $(date -u "+%FT%T") this a test log from curl, this a test log from curl, this a test log from curl, this a test log from curl, this a test log from curl, this a test log from curl!"
done 
