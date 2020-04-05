apt-get install cwebp
apt-get install  optipng
apt-get install jpegoptim 

cp /home/dsonnet/'Patch for Magento 2.3.3 And Above.zip' ./www/patch.zip
cp /home/dsonnet/'Porto Theme.zip'  ./www/porto.zip

cd /var/www/B2C-Mangento/www

unzip -o porto.zip

unzip -o patch.zip

rm -Rf /var/www/B2C-Mangento/www/app/code/Mageplaza/Core

php bin/magento setup:upgrade
chown -R www-data:www-data ./*

