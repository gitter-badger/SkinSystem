# "apt-get update && apt-get install curl -y && curl -s https://raw.githubusercontent.com/riflowth/SkinSystem/master/installscripts/UbuntuInstall.sh | bash -s"
# This script installs apache, php, git, curl, overrides the default apache webpage, and creates mysql databases+user.
echo "installing skinsystem (mysql, apache2, php, git)"
apt-get update
apt-get install mysql-server apache2 libapache2-mod-php php-curl php-mysql php-gd git -y
cd /var/www
git clone https://github.com/riflowth/SkinSystem
rm -rf SkinSystem/.git
rm -rf SkinSystem/.gitignore
rm -rf SkinSystem/*.md
mv html html.backup$(date -I)
mv SkinSystem html
chmod 775 -R /var/www/html && chown -R www-data:www-data /var/www/html
pw=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')
echo "Creating MySQL user skinsystem:$pw"
echo "CREATE USER 'skinsystem'@'localhost' IDENTIFIED BY '$pw'; \
CREATE DATABASE skinsrestorer; \
GRANT ALL PRIVILEGES ON skinsrestorer . * TO 'skinsystem'@'localhost'; \
CREATE DATABASE authme; \
GRANT ALL PRIVILEGES ON authme . * TO 'skinsystem'@'localhost';" | mysql && echo "MySQL user skinsystem:$pw was created"
echo "Have a nice day, remember to save your credentials!"
read -n 1 -s -r -p "Press any key to continue"
echo ""
clear