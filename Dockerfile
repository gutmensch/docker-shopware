FROM shyim/shopware:6.2.3

COPY SwagLigo2022Theme/ /var/www/html/custom/plugins/SwagLigo2022Theme/

RUN chown -R 1000:1000 /var/www/html/custom/plugins/SwagLigo2022Theme

# Add repository
# RUN jq '.repositories += [{"type": "composer","url": "https://packages.friendsofshopware.com/","options": {"http": {"header": ["Token: MyToken"]}}}]' /var/www/html/composer.json > /var/www/html/composer2.json && \
#  cp composer2.json composer.json && \
#  chown 1000:1000 composer.json

#RUN sudo -u www-data composer require store.shopware.com/swagcmsextensions
