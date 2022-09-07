#!/bin/bash
function exitTrap(){
exitCode=$?
/opt/aws/bin/cfn-signal --stack uba-app-stack --resource dataingeststackASG36C9C217 --region us-east-1 -e $exitCode || echo 'Failed to send Cloudformation Signal'
}
trap exitTrap EXIT
sudo yum update -y
sudo yum upgrade -y
sudo echo "net.core.somaxconn = 32768" >> /etc/sysctl.conf
sudo echo "net.ipv4.tcp_max_syn_backlog = 32768" >> /etc/sysctl.conf
sudo echo "net.ipv4.ip_local_port_range = 1024 65535" >> /etc/sysctl.conf
sudo sysctl -p
sudo yum install docker -y
sudo systemctl start docker

sudo docker pull public.ecr.aws/aws-observability/aws-for-fluent-bit:stable
sudo docker run --name=aws-fluent-bit -itd public.ecr.aws/aws-observability/aws-for-fluent-bit:stable
sudo docker cp `docker ps -lq`:/fluent-bit /
sudo docker stop `docker ps -lq`
sudo docker rm `docker ps -lq`
sudo yum install -y jq

aws s3 cp s3://cdk-hnb659fds-assets-080766874269-us-east-1/05c6ce1675ff1369f85b68289c89f823acf2da09ba4847a99cb5683eab93e6fd.conf /tmp/td-agent-bit.conf
sed "s/MACRO_FLUENTBIT_LOG_LEVEL/info/g; s/MACRO_FLUENTBIT_OUTPUT_AWS_REGION/us-east-1/g; s/MACRO_FLUENTBIT_OUTPUT_KINESIS_STREAM/uba-app-stream/g; s/MACRO_KAFKA_BROKERS/MACRO_KAFKA_BROKERS/g; s/MACRO_FLUENTBIT_OUTPUT_KAFKA/uba-app-topic/g; s/MACRO_FLUENTBIT_OUTPUT_S3/uba-app-us-east-1-20220830150644/g;  s/#s3//g; " /tmp/td-agent-bit.conf > /fluent-bit/etc/fluent-bit.conf
sudo mkdir -p /var/log/fluentbit/


sudo amazon-linux-extras install nginx1 -y
aws s3 cp s3://cdk-hnb659fds-assets-080766874269-us-east-1/be75b35c77bfed6a97b251fa5dc99ad2d0742a71ceed435801a04c90cc1f5bc9.conf /tmp/nginx.conf
sed "s/MACRO_NGINX_HTTP_PORT/4891/g" /tmp/nginx.conf > /etc/nginx/nginx.conf


sudo rm /etc/logrotate.d/nginx
aws s3 cp s3://cdk-hnb659fds-assets-080766874269-us-east-1/1975a6315a21f10028ace24243c03a8bc254e484cebcf3b2947005df263d79ab.conf /etc/logrotate.d/nginx-logrotate.conf
sudo echo "# Run nginx logrotate once a minute." >> /etc/cron.d/nginx-logrotate-crond.conf
sudo echo "*/1 * * * * root /usr/sbin/logrotate /etc/logrotate.d/nginx-logrotate.conf" >> /etc/cron.d/nginx-logrotate-crond.conf


sudo echo "nohup /fluent-bit/bin/fluent-bit -e /fluent-bit/firehose.so -e /fluent-bit/cloudwatch.so -e /fluent-bit/kinesis.so -c /fluent-bit/etc/fluent-bit.conf &" >> /etc/rc.local
sudo chmod +x /etc/rc.d/rc.local
sudo systemctl enable nginx
sudo systemctl start nginx
sudo echo "systemctl start nginx..."
sudo echo $?
nohup /fluent-bit/bin/fluent-bit -e /fluent-bit/firehose.so -e /fluent-bit/cloudwatch.so -e /fluent-bit/kinesis.so -c /fluent-bit/etc/fluent-bit.conf &



sudo yum install java-1.8.0-openjdk-devel -y
cd /root/
wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz
tar -zvxf apache-maven-3.8.5-bin.tar.gz
mv apache-maven-3.8.5 /usr/local/maven
echo "export MAVEN_HOME=/usr/local/maven" >> /root/.bashrc
echo "export PATH=$PATH:/usr/local/maven/bin" >> /root/.bashrc
export MAVEN_OPTS="-Xms512m -Xmx1024m"
source /root/.bashrc
wget https://dlcdn.apache.org/flume/1.9.0/apache-flume-1.9.0-src.tar.gz
tar -zvxf apache-flume-1.9.0-src.tar.gz
cd apache-flume-1.9.0-src
aws s3 cp s3://cdk-hnb659fds-assets-080766874269-us-east-1/ebba7fdeddb7880986814d07484e5c5eb8d873dc728948cecc831e42cbd991c0.xml ./flume-ng-sinks/pom.xml
aws s3 cp s3://cdk-hnb659fds-assets-080766874269-us-east-1/c52f821fa4a6bd5a898181d9c13cfa1bd382e19b431b817aea03fdc0f6aed033.xml ./flume-ng-dist/pom.xml
mvn clean install -Drat.numUnapprovedLicenses=600 -DskipTests
cp -R /root/apache-flume-1.9.0-src/flume-ng-dist/target/apache-flume-1.9.0-bin/apache-flume-1.9.0-bin /root/
cd /root/apache-flume-1.9.0-bin/
aws s3 cp s3://cdk-hnb659fds-assets-080766874269-us-east-1/32f3bf7ce362498266e52049410d2537ae545ca4bc568ea5192137cd94913eb6.properties ./conf/uba-app-flume-conf.properties
sudo echo "bin/flume-ng agent --conf conf --conf-file conf/uba-app-flume-conf.properties --name a1 -Dflume.root.logger=ERROR,console -Dorg.apache.flume.log.printconfig=true -Dorg.apache.flume.log.rawdata=true" >> /etc/rc.local
nohup bin/flume-ng agent --conf conf --conf-file conf/uba-app-flume-conf.properties --name a1 -Dflume.root.logger=ERROR,console -Dorg.apache.flume.log.printconfig=true -Dorg.apache.flume.log.rawdata=true &