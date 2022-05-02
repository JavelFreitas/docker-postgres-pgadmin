CREATE TABLE IF NOT EXISTS docker_test(
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL
)

SELECT * FROM docker_test

INSERT INTO docker_test (user_id, username) VALUES (1, 'matheus');

SELECT * FROM docker_test

-- Compose down on containers, then up

SELECT * FROM docker_test

-- Should maintain data if using volumes from docker-compose.yml