# WordPress (FPM) on Docker with Nginx

Notes:
- Uses the FPM version of WordPress (v5-fpm)
- Uses MySQL as the database (v8)
- Uses Nginx as the web server (v1)
the versions above can be adjusted by editing the `env.template` file

### Host requirements

Git, Docker and Docker Compose are required on the host to run this code

- Install Docker Engine: [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)
- Install Docker Compose: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

## Configuration

Default configuration values are stored in the `env.template` file, edit it before deploying!

## Deployment

Clone repository && then `cd` into it && the containers can be brought up using the supplied `start_wordpress.sh`

```
git clone https://github.com/sidorkinandrew/genesis_devops.git && cd ./genesis_devops && ./start_wordpress.sh
```

Note: the script will rename the `env.template` to `.env` file,
please edit the env.template before deployment.

The success of the deployment can be verified by navigating to `http://localhost` in a browser (in case you have GUI on the host)
or by using curl in a terminal window - 

```
curl -L http://localhost
```

Altenatively, any text-based web browser can be used, for ex. `lynx http://localhost`


## Teardown

For a complete teardown all containers must be stopped and removed along with the volumes and network that were created for the application containers

Commands

```console
docker-compose down --remove-orphans
docker-compose stop
docker-compose rm -fv
docker-network rm wp-wordpress
# removal calls may require sudo rights depending on file permissions
rm -rf ./wordpress
rm -rf ./dbdata
rm -rf ./logs
```

## References

- the docker-compose yaml is based on a community supported reporsitory here - [wordpress-nginx-docker](https://github.com/mjstealey/wordpress-nginx-docker)
- WordPress Docker images: [https://hub.docker.com/_/wordpress/](https://hub.docker.com/_/wordpress/)
- MySQL Docker images: [https://hub.docker.com/_/mysql](https://hub.docker.com/_/mysql)
- Nginx Docker images: [https://hub.docker.com/_/nginx/](https://hub.docker.com/_/nginx/)

---

## Notes

### Error establishing database connection

This can happen when the `wordpress` container attempts to reach the `database` container prior to it being ready for a connection.

This will sometimes resolve itself once the database fully spins up, but generally it's advised to start the database first and ensure it's created all of its user and wordpress tables and then start the WordPress service.

### Port Mapping

Neither the **wordpress** container nor the **database** container have publicly exposed ports. They are running on the host using a docker defined network which provides the containers with access to each others ports, but not from the host.
