for i in `seq 1 100000`
do 
 echo $i
 curl -XPOST http://localhost:8088/log -d "$i - this a test log from curl, this a test log from curl, this a test log from curl, this a test log from curl, this a test log from curl, this a test log from curl!"
done 
