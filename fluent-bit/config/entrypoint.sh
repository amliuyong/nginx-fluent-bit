

echo -n "AWS for Fluent Bit Container Image Version "
cat /AWS_FOR_FLUENT_BIT_VERSION

sed -i "s/%%AWS_REGION%%/$AWS_REGION/g; s/%%AWS_S3_BUCKET%%/$AWS_S3_BUCKET/g; s/%%INPUT_FILE%%/$INPUT_FILE/g;" /fluent-bit/etc/fluent-bit.conf
exec /fluent-bit/bin/fluent-bit -e /fluent-bit/firehose.so -e /fluent-bit/cloudwatch.so -e /fluent-bit/kinesis.so -c /fluent-bit/etc/fluent-bit.conf
