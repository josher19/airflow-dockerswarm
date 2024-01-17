pod=$(docker ps -l -f name=airflow_pod --format '{{.ID}}')
operator="${1:-example_dockerswarm_operator.py}"
docker cp "${operator}" "${pod}:/root/airflow/dags/${operator}" && echo "Copied file. UI = http://localhost:18080"
