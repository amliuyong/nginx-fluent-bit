echo -n "Start nginx"
/usr/sbin/nginx

echo -n "set crontab job"
/usr/bin/crontab /etc/cron.d/nginx-logrotate-crond.conf
/usr/sbin/crond -s

echo -n "AWS for Fluent Bit Container Image Version "
cat /AWS_FOR_FLUENT_BIT_VERSION
exec /fluent-bit/bin/fluent-bit -e /fluent-bit/firehose.so -e /fluent-bit/cloudwatch.so -e /fluent-bit/kinesis.so -c /fluent-bit/etc/fluent-bit.conf
