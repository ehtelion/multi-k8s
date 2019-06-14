docker build -t ehtelion/multi-client:latest -t ehtelion/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ehtelion/multi-server:latest -t ehtelion/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ehtelion/multi-worker:latest -t ehtelion/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ehtelion/multi-client:latest
docker push ehtelion/multi-client:$SHA
docker push ehtelion/multi-server:latest
docker push ehtelion/multi-server:$SHA
docker push ehtelion/multi-worker:latest
docker push ehtelion/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ehtelion/multi-server:$SHA
kubectl set image deployments/client-deployment client=ehtelion/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ehtelion/multi-worker:$SHA