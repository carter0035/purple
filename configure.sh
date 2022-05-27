unzip /PurpleProfessional/PurpleProfessional.zip -d /PurpleProfessional
unzip /mqev/mqev.zip -d /mqev
rm -rf /PurpleProfessional/PurpleProfessional.zip
rm -rf /mqev/mqev.zip
cat << EOF > /mqev/config1.json
{
 "inbounds": [
    {
      "port": 23323,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "$APP_ID",
            "alterId": 0
          }
        ],
        "disableInsecureEncryption": true
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "$APP_PATH"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF
chmod +x /mqev/mqev
envsubst '\$APP_ID,\$APP_PATH' < /mqev/config1.json > /mqev/config.json
/mqev/mqev -config /mqev/config.json &
echo /PurpleProfessional/page.html
cat /PurpleProfessional/page.html
rm -rf /etc/nginx/sites-enabled/default
/bin/bash -c "envsubst '\$PORT,\$APP_PATH' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'
