docker run --name shuces-db-homework -e POSTGRES_PASSWORD=password -e POSTGRES_USER=zhou -e POSTGRES_DB=homework \
-p 0.0.0.0:25432:5432 -d postgres:11