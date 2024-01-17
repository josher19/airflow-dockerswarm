# Airflow in Docker Swarm

## Quick Start

Take a look at these commands:

- [start.sh](./start.sh) -- start docker swarm
- [deploy.sh](./deploy.sh) -- start airflow and postgres
- [add_dag.sh](./add_dag.sh) -- add job to the DAG
- [shutdown.sh](./shutdown.sh) -- shut it all down

## Start Docker Swarm

`docker node ls || docker swarm init`

## Deploy Airflow

```
docker stack deploy --compose-file stack.yml airflow
```

You may need to wait a few minutes for Airflow to start.
Once it is started, you will be able to see it a http://localhost:18080

## Get you Docker Instance ID

Any of these should work:

```
docker service ls

docker ps -l -f name=airflow_pod --format '{{.ID}}'

./airflow_pod_id.sh

```

## Copy Docker Swarm Operator to DAG

Upload your new operators to the airflow/dags directory in the airflow_pod.

```
pod=$(docker ps -l -f name=airflow_pod --format '{{.ID}}')
docker cp example_dockerswarm_operator.py ${pod}:/root/airflow/dags/example_dockerswarmoperator.py
```

## Confirm DAG is running

This example runs every 15 minutes and sleeps for 45 seconds.

You should be able to see it in the Airflow UI at: http://localhost:18080
You can also re-run it and that a new service shows up in `docker service ls`

## Shutting Down

```
docker stack rm airflow
docker service ls
docker swarm leave --force
```

Should get output something like:

> Removing service airflow_pod
> Removing service airflow_postgres
> Removing network airflow_default

> ID        NAME      MODE      REPLICAS   IMAGE     PORTS

> Node left the swarm.
