docker build -t my-nginx-fluent-bit .

dir_name=`pwd`

docker run -d \
-p 8088:8088 \
-p 2020:2020 \
-v $dir_name/data/fluentbit:/var/log/fluentbit \
-v $dir_name/data/nginx:/var/log/nginx \
 my-nginx-fluent-bit
