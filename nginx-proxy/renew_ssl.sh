#! /bin/bash

sed -i -r 's/(listen .*443)/\1;#/g; s/(ssl_(certificate|certificate_key|trusted_certificate) )/#;#\1/g' /etc/nginx/sites-enabled/erullmann.ca.conf

nginx -t && systemctl reload nginx

certbot certonly --webroot -d erullmann.ca -d www.erullmann.ca --email e.rullmann@gmail.com -w /storage/_letsencrypt -n --agree-tos --force-renewal

sed -i -r 's/#?;#//g' /etc/nginx/sites-enabled/erullmann.ca.conf

nginx -t && systemctl reload nginx

echo -e '#!/bin/bash\nnginx -t && systemctl reload nginx' | tee /etc/letsencrypt/renewal-hooks/post/nginx-reload.sh

chmod a+x /etc/letsencrypt/renewal-hooks/post/nginx-reload.sh