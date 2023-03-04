# devops101
devops101
## About

This project is the example of ci/cd ready to production.

- **Runs on AWS:** 
- **IaC with Terraform:** 
- **CI/CD with Jenkins:** 
- **Revers proxy by Nginx Proxy Manager:** 
- **Static site generators with Hugo:** 

## Jenkins free style script
```
docker build -t myblog .

[ "$(docker ps -a | grep myblog)" ] && docker stop myblog | docker wait myblog

docker run -d --rm --network proxy_default --name myblog myblog
```
### Environment
#### https://nunocoracao.com/posts/202206-homepage-guide/
#### https://favicon.io/
#### https://hub.docker.com/r/klakegg/hugo
#### https://www.kentoseth.com/posts/2022/may/28/hugo-fix-git-bug-when-installing-a-repo-with-a-theme/
