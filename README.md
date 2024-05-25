1. install docker on your redhat jenkins instance:
sudo yum install docker
-------------------------

Ensure Docker Pipeline Plugin is Installed
First, ensure that the Docker Pipeline Plugin is installed in your Jenkins instance. You can do this by:

1. Going to Manage Jenkins > Manage Plugins.
2. Searching for the Docker Pipeline plugin under the Available tab.
3. Installing it if it’s not already installed.

___________________
#Add jenkins to the docker group
sudo groupadd docker
sudo usermod -aG docker jenkins
