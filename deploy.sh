### Build images using production Dockerfile
# Specify muliple tags

GIT_SHA=$(git rev-parse HEAD)
# Build static-website image
docker build -t vagdevik/static-website-k8s:$GIT_SHA .

### Push images

# Push sha tag images to docker hub
docker push vagdevik/static-website-k8s:$GIT_SHA

### Deploy

# Apply k8s config
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/

# Update the deployment image
kubectl set image deployment.apps/static-web-deployment -n=sample days-app-container=vagdevik/static-website-k8s:$GIT_SHA
