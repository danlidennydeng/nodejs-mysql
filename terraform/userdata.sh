#!/bin/bash
set -euxo pipefail

exec > >(tee /var/log/user-data.log | logger -t user-data ) 2>&1

apt update -y
apt install -y git curl netcat-openbsd

curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

npm install -g pm2

rm -rf /home/ubuntu/nodejs-mysql
git clone https://github.com/danlidennydeng/nodejs-mysql.git /home/ubuntu/nodejs-mysql

cat > /home/ubuntu/nodejs-mysql/.env <<EOF
DB_HOST=${db_host}
DB_USER=${db_user}
DB_PASS=${db_pass}
DB_NAME=${db_name}
TABLE_NAME=users
PORT=3000
DB_PORT=3306
EOF

cat > /home/ubuntu/deploy.sh <<'EOF'
#!/bin/bash
set -euxo pipefail

cd /home/ubuntu/nodejs-mysql
git pull origin main
npm install

pm2 delete nodejs-mysql || true
pm2 start server.js --name nodejs-mysql
pm2 save
EOF

chmod +x /home/ubuntu/deploy.sh
chown -R ubuntu:ubuntu /home/ubuntu/nodejs-mysql /home/ubuntu/deploy.sh

su - ubuntu -c "/home/ubuntu/deploy.sh"
#this is automatically running deploy.sh

#If you want to run deploy.sh manually without starting a new EC2, comment out above and user_data_replace_on_change = true in ec2.tf.

#then su - ubuntu -c "/home/ubuntu/deploy.sh" as soon as you have logged into the AWS EC2