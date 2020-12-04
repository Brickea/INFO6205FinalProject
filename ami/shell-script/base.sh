# wait for 
while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done

# sudo apt --fix-broken install
# sudo apt-get upgrade -y
sudo apt-get update -y

# install java jdk
sudo apt-get install -y default-jdk

# install aws cli
sudo apt-get install -y awscli

echo "*********************intalling CodeDeploy*********************"
sudo apt-get install ruby -y
# cd /home/ec2-user
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ~/install
sudo ./install auto

sudo service codedeploy-agent start
sudo service codedeploy-agent status
echo "*********************install CodeDeploy finish*********************"


# isntall CloudWatch
# echo "*********************installing CloudWatch*********************"
# sudo wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
# sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
# echo "*********************install CloudWatch finish*********************"

# install maven 
# sudo apt-get install -y maven

# install mysql
# sudo apt-get install -y mysql-server