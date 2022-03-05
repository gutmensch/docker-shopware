FROM shyim/shopware:6.4.8

COPY LigoShopThemeV1/ /var/www/html/custom/plugins/LigoShopThemeV1/
COPY SangrossAdapter/ /var/www/html/custom/plugins/SangrossAdapter/

RUN chown -R 1000:1000 /var/www/html/custom/plugins/*

# Add repository
# RUN jq '.repositories += [{"type": "composer","url": "https://packages.friendsofshopware.com/","options": {"http": {"header": ["Token: MyToken"]}}}]' /var/www/html/composer.json > /var/www/html/composer2.json && \
#  cp composer2.json composer.json && \
#  chown 1000:1000 composer.json

#RUN sudo -u www-data composer require store.shopware.com/swagcmsextensions
