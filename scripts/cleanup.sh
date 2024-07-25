# remove docker volumes
docker system prune --volumes

# remove docker images
docker image prune

# remove log files
rm -rf ./log/*.log
