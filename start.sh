docker node ls || docker swarm init
docker stack deploy --compose-file stack.yml airflow
docker service ls
./airflow_pod_id.sh
