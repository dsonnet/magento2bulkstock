#composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition phygitailer
cd phygitailer
#php bin/magento setup:install --backend-frontname="manadmin" --key="MNVEBrm4kcMKfgHrvtPZv6ML4fyeg2LE" --base-url="https://www.minibird.eu" --base-url-secure="https://www.minibird.eu" --db-host=192.168.81.56 --db-name=phygitailerV2 --db-user=app --db-password=m8M2G1MqSNVhA2m9 --admin-firstname=David  --admin-lastname=Sonnet --admin-email=cldit@cld.be --admin-user=dsonnet --admin-password=2Y0x3dJuoK1# --language=en_GB --currency=EUR --timezone=Europe/Brussels --use-rewrites=1

php bin/magento setup:store-config:set --use-secure-admin=1
php bin/magento setup:store-config:set --use-secure=1
php bin/magento setup:store-config:set --use-rewrites=0
php bin/magento config:set general/locale/code en_GB


cp /home/dsonnet/'Patch for Magento 2.3.3 And Above.zip' ./patch.zip
cp /home/dsonnet/'Porto Theme.zip'  ./porto.zip


unzip -o porto.zip

unzip -o patch.zip

# rm -Rf /var/www/B2C-Mangento/www/app/code/Mageplaza/Core

composer require akeneo/module-magento2-connector-community

php bin/magento module:enable Akeneo_Connector

composer require "smartoys/pim-connector @dev"

php bin/magento setup:db:status

php bin/magento setup:upgrade

php bin/magento setup:di:compile

php bin/magento setup:static-content:deploy nl_BE -f
php bin/magento setup:static-content:deploy fr_BE -f
php bin/magento setup:static-content:deploy de_DE -f
php bin/magento setup:static-content:deploy es_ES -f
php bin/magento setup:static-content:deploy it_IT -f
php bin/magento setup:static-content:deploy en_GB -f

php bin/magento indexer:reindex

bin/magento cache:clean

php bin/magento cache:flush

php bin/magento cache:enable



chown -R www-data:www-data ./*

