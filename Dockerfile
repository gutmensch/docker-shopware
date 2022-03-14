# 6.4.1+ causes
# https://forum.shopware.com/t/malformed-utf-8-characters-bei-sync-api-nach-update-auf-6-4-1-0/88421/7
FROM shyim/shopware:6.4.0

COPY LigoShopThemeV1/ /var/www/html/custom/plugins/LigoShopThemeV1/
COPY SangrossAdapter/ /var/www/html/custom/plugins/SangrossAdapter/

RUN chown -R 1000:1000 /var/www/html/custom/plugins/*

# Add repository
# RUN jq '.repositories += [{"type": "composer","url": "https://packages.friendsofshopware.com/","options": {"http": {"header": ["Token: MyToken"]}}}]' /var/www/html/composer.json > /var/www/html/composer2.json && \
#  cp composer2.json composer.json && \
#  chown 1000:1000 composer.json

#RUN sudo -u www-data composer require store.shopware.com/swagcmsextensions
