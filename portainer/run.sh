docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always --hostname flute -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/data:/data portainer/portainer-ce

