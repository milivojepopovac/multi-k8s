docker build -t milivojepopovac/multi-client:latest -t milivojepopovac/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t milivojepopovac/multi-server:latest -t milivojepopovac/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t milivojepopovac/multi-worker:latest -t milivojepopovac/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push milivojepopovac/multi-client:latest
docker push milivojepopovac/multi-server:latest
docker push milivojepopovac/multi-worker:latest

docker push milivojepopovac/multi-client:$SHA
docker push milivojepopovac/multi-server:$SHA
docker push milivojepopovac/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=milivojepopovac/multi-server:$SHA
kubectl set image deployments/client-deployment client=milivojepopovac/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=milivojepopovac/multi-worker:$SHA 