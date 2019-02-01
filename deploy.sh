docker build -t sampalm/multi-client:latest -t sampalm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sampalm/multi-server:latest -t sampalm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sampalm/multi-worker:latest -t sampalm/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sampalm/multi-client:latest
docker push sampalm/multi-server:latest
docker push sampalm/multi-worker:latest

docker push sampalm/multi-client:$SHA
docker push sampalm/multi-server:$SHA
docker push sampalm/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sampalm/multi-server:$SHA
kubectl set image deployments/client-deployment client=sampalm/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sampalm/multi-worker:$SHA
