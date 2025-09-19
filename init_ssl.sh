#!/bin/bash
set -e

DOMAIN="bi.aixii.com"
PROJECT_DIR="$(pwd)"

# 1. Create symlink for nginx
if [ ! -f "./nginx/sites-enabled/superset.conf" ]; then
  echo "[INFO] Creating symlink for nginx site..."
  ln -s ../sites-available/superset.conf ./nginx/sites-enabled/superset.conf
else
  echo "[INFO] Symlink already exists, skipping."
fi

# 2. First run certbot for getting SSL
echo "[INFO] Requesting SSL certificate for $DOMAIN ..."
docker compose run --rm certbot certonly --webroot -w /var/www/certbot -d $DOMAIN

# 3. Certificate check
if [ -f "./letsencrypt/live/$DOMAIN/fullchain.pem" ]; then
  echo "[INFO] Certificate successfully generated."
else
  echo "[ERROR] Certificate was not generated, check certbot logs."
  exit 1
fi

# 4. Restarting nginx
echo "[INFO] Restarting nginx..."
docker compose restart nginx

# 5. Adding cron for renew certificate
echo "[INFO] Adding cron job for auto renewal every 30 days..."
( crontab -l 2>/dev/null | grep -v "certbot certonly" ; echo "0 3 */30 * * cd $PROJECT_DIR && docker compose run --rm certbot certonly --webroot -w /var/www/certbot --quiet --agree-tos --keep-until-expiring --no-self-upgrade -d $DOMAIN && docker compose exec -T nginx nginx -s reload" ) | crontab -

echo "✅ SSL setup completed for $DOMAIN"
echo "🔄 Auto-renewal configured every 30 days at 03:00"
