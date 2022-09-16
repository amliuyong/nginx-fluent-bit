docker build -t my-vector .

dir_name=`pwd`

docker run -d  \
-p 8686:8686 \
-e AWS_REGION=ap-southeast-1 \
-e AWS_S3_BUCKET=nginx-fluent-bit-ap-southeast-1 \
-v $dir_name/data/vector:/var/lib/vector \
-v $dir_name/data/nginx:/var/log/nginx \
my-vector
