docker build -t my-nginx-cron .

dir_name=`pwd`

docker run -d  \
-p 8089:8088 \
-e AWS_INSTANCE_ID=testid123 \
-v $dir_name/data/nginx:/var/log/nginx \
my-nginx-cron