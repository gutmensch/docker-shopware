# 6.4.1+ causes
# https://forum.shopware.com/t/malformed-utf-8-characters-bei-sync-api-nach-update-auf-6-4-1-0/88421/7
FROM shyim/shopware:6.4.0

COPY LigoShopThemeV1/ /var/www/html/custom/plugins/LigoShopThemeV1/
COPY SangrossAdapter/ /var/www/html/custom/plugins/SangrossAdapter/

RUN chown -R 1000:1000 /var/www/html/custom/plugins/*

# disable admin worker triggered by user => move to cron scheduled tasks
# https://docs.shopware.com/en/shopware-6-en/tutorials-und-faq/deactivate-the-admin-worker#:~:text=To%20disable%20the%20admin%20worker,false%20%22%20and%20save%20the%20file.
COPY shopware.yaml /var/www/html/config/packages/
RUN echo -e "\n[program:cron]\ncommand=crond -f -d 8\nautostart=true\nautorestart=true\nstderr_logfile=/dev/stderr\nstdout_logfile=/dev/stdout\n" >> /etc/supervisord.conf \
  && echo "*/5 * * * *	/var/www/html/bin/console messenger:consume default --time-limit=295" > /var/spool/cron/crontabs/root \
  && echo "*/10 * * * *	/var/www/html/bin/console scheduled-task:run --time-limit=295" >> /var/spool/cron/crontabs/root

# Add repository
# RUN jq '.repositories += [{"type": "composer","url": "https://packages.friendsofshopware.com/","options": {"http": {"header": ["Token: MyToken"]}}}]' /var/www/html/composer.json > /var/www/html/composer2.json && \
#  cp composer2.json composer.json && \
#  chown 1000:1000 composer.json

#RUN sudo -u www-data composer require store.shopware.com/swagcmsextensions
