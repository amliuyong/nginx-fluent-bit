sed -i "s/%%AWS_REGION%%/$AWS_REGION/g; s/%%AWS_S3_BUCKET%%/$AWS_S3_BUCKET/g; s/%%INPUT_FILE%%/$INPUT_FILE/g;" /etc/vector/vector.toml

/usr/local/bin/vector
