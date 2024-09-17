# nvimDocker
## Docker Usage
***build docker image***  
sudo docker build -t <image_name> <path_to_Dockerfile>  
***build docker image without cache***  
sudo docker build --no-cache -t <image_name> <path_to_Dockerfile>  
***Start docker image as background***  
sudo docker run -d <image_name>  
***Use bash inside of docker***  
sudo docker exec -it <docker_hash> /bin/bash  
***kill docker instance***   
sudo docker kill <container_id>  
***List all docker instances***  
sudo docker ps -a  
