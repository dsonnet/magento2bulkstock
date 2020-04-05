mysql  -h localhost -u dsonnet -pKd0Lf2X87IpbbOeC < core_config_data.sql

cd /var/www/B2C-Mangento/www

bin/magento maintenance:enable

php bin/magento setup:config:set --db-host=localhost --db-name=phygitailer --db-user=dsonnet --db-password=Kd0Lf2X87IpbbOeC -n

php bin/magento setup:config:set --backend-frontname="manadmin" -n

php bin/magento setup:store-config:set --base-url-secure="https://www.phygitailer.com" --base-url="http://www.phygitailer.com" -n
# web/secure/base_link_url
# mysql delete from core_config_data where path = 'web/secure/base_link_url' or path = 'web/unsecure/base_link_url';


composer remove magento/product-community-edition --no-update 
composer require magento/product-community-edition=2.3.4 --no-update 
composer update -n
rm -rf var/cache/* var/page_cache/* var/generation/*

redis-cli flushall

#php bin/magento setup:config:set --db-host=localhost --db-name=phygitailer --db-user=dsonnet --db-password=Kd0Lf2X87IpbbOeC --admin-firstname=David  --admin-lastname=Sonnet --admin-email=cldit@cld.be --admin-user=dsonnet --admin-password=2Y0x3dJuoK1# --language=en_US --currency=EUR --timezone=Europe/Brussels 

##--use-rewrites=1

#php bin/magento deploy:mode:set developer


php bin/magento module:disable Temando_Shipping  --clear-static-content

php bin/magento module:disable Zemez_PromoBanner  --clear-static-content

php bin/magento module:disable Zemez_Parallax --clear-static-content
php bin/magento module:disable Zemez_ProductLabels --clear-static-content
php bin/magento module:disable Zemez_SampleDataInstaller --clear-static-content


php bin/magento module:disable Magmodules_Channable  --clear-static-content

php bin/magento module:disable MageVision_AdminProductGridFilter  --clear-static-content

php bin/magento module:disable Dssdesign_Removemicrodata  --clear-static-content

php bin/magento module:disable Klarna_Kp  --clear-static-content

php bin/magento module:disable Klarna_Ordermanagement  --clear-static-content

php bin/magento module:disable Klarna_Core  --clear-static-content

php bin/magento module:disable MSP_ReCaptcha
php bin/magento module:disable Amazon_Payment
php bin/magento module:disable Amazon_Login
php bin/magento module:disable Amazon_Core
php bin/magento module:disable Dotdigitalgroup_Email
php bin/magento module:disable MSP_TwoFactorAuth
# php bin/magento module:disable Mageplaza_Core
php bin/magento module:disable Vertex_Tax

php bin/magento setup:upgrade

php bin/magento setup:di:compile

php bin/magento setup:static-content:deploy en_US fr_FR nl_NL -f

php bin/magento indexer:reindex

bin/magento cache:clean

php bin/magento cache:enable

chown -R www-data:www-data ./

php bin/magento admin:user:create --admin-user="dsonnet" --admin-password="rqvtvilla41" --admin-email="david@smartoys.be" --admin-firstname="David" --admin-lastname="Sonnet"
# php bin/magento admin:user:create --admin-user="dsonnet" --admin-password="rqvtvilla" --admin-email="david@cld.be" --admin-firstname="David" --admin-lastname="Sonnet"

bin/magento maintenance:disable
