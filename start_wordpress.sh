echo "[Setting up the environment]"
mv -f env.template .env
source .env
echo "[Pulling docker images]"
sudo docker-compose pull
echo "[Starting up DB]"
sudo docker-compose up -d database
sleep 20
echo "[Starting wordpress with Nginx]"
sudo docker-compose up -d wordpress nginx
echo "Done!"
echo "WordPress should be available at http://localhost"
echo "use curl -L http://localhost or lynx http://localhost"