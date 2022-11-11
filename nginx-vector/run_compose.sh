AWS_INSTANCE_ID=$(curl --silent 169.254.169.254/latest/meta-data/instance-id)
AWS_REGION=$(curl --silent http://169.254.169.254/latest/meta-data/placement/region)
AWS_S3_BUCKET=nginx-fluent-bit-ap-southeast-1
AWS_S3_PEFIX=vector-data-test/%Y-%m-%d

echo AWS_INSTANCE_ID: $AWS_INSTANCE_ID
echo AWS_REGION: $AWS_REGION
echo AWS_S3_BUCKET: $AWS_S3_BUCKET
echo AWS_S3_PEFIX: $AWS_S3_PEFIX

docker-compose up -f docker-compose.yaml
