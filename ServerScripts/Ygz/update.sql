use phygitailer;
CREATE USER 'app'@'%' IDENTIFIED BY 'm8M2G1MqSNVhA2m9';
GRANT ALL PRIVILEGES ON *.* TO 'app'@'%';
drop view inventory_stock_1;
ALTER TABLE email_template ADD is_legacy boolean NOT NULL default false;
delete from temando_product_attribute_mapping;
FLUSH PRIVILEGES;
