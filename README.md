# Chat system 


### Notes for Reviewers
* there is a postman collection for this project you can use
to test the API
* There was a problem with the connection between the app and the rabbitmq docker container. so I commented th code to avoid docker compose failing (I tried many times to fix the connection problem but I think I need another eye to look at the configurations).



## How I approached the challenge

### I decided to make the challenge in a few steps.
* First, I made the application with rails and mysql databae.
* Then, I made the REST API with rails without handling the race condition.
* Then, I handled the race condition.
* Then, I integrated Elasticsearch to add search functionality
* Lastly, I integrated RabbitMQ in creating the message
s
### Handling the race condition
As the system will be distributed and runs on multiple servers, and I want to prevent the problem from the root (the db), so I decided to look for a solution that locks the db row from other operations, I found an abstraction for that in the `ActiveRecord` that uses `SELECT FOR UPDATE` to lock the row.

### Integrating Elasticsearch
I want to allow partial matching of the body, so I decided to not use wildcards and regex indexes. Instead, I used ngrams filtering.

### Integrating RabbitMQ
I decided to use RabbitMQ to send the message to the queue. then read from the queue and persist the message to the database.

