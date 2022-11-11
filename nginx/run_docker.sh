docker kill $(docker ps -q)

docker build -t my-nginx-test .

dir_name=`pwd`

docker run -d  \
-p 8088:8088 \
my-nginx-test


docker ps 

echo "curl http://localhost:8088/debug?a=d1234 -d 'test debug'"
echo ""
curl -v -H "X-EVENT-TYPE: testEvent1" http://localhost:8088/debug?a=d1234 -d '=== test debug body ==='

echo ""
echo "curl http://localhost:8088/test?a=t1234 -d 'test test'"
curl -v -H "X-EVENT-TYPE: testEvent2"  http://localhost:8088/test?a=t1234 -d '=== test test body ==='
echo ""