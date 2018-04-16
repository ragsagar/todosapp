## Setting up local development

* Ruby version 2.5.1


* Create postgres database

        $ sudo -u postgres createuser todouser
        $ sudo -u postgres createdb tododb
        $ sudo -u postgres psql
        psql=# alter user todouser with encrypted password '****';
        psql=# grant all privileges on database tododb to todouser;
        
* Load the required environment variables

        export TODOAPP_DATABASE=tododb
        export TODOAPP_USER=todouser
        export TODOAPP_TESTDB=todotestdb
        export TODOAPP_PASSWORD="****"

* How to run the test suite

        bundle exec rspec

* To deploy to heroku:

        git push heroku master
        
        
## Api Documentation

#### Basic authentication

Following authorization header should be passed for basic authentication:

    Authorization: Basic dG9kb2FwcDpheW1jb21tZXJjZQ=="

#### Create a new todo list.

    POST /api/v1/todos/
    Body: { "title": <title>, "created_by": <user_id> }
    Headers: {"Authorization": "Basic <Token>" }
    Response status code 201

eg:

    curl -X POST \
      http://aymapp.herokuapp.com/api/v1/todos/ \
      -H 'Authorization: Basic dG9kb2FwcDpheW1jb21tZXJjZQ==' \
      -H 'Cache-Control: no-cache' \
      -H 'Content-Type: application/json' \
      -d '{
    	"title": "Setup heroku.",
    	"created_by": "1"
    
      }'
      
#### List all existing todo lists.

    GET /api/v1/todos/
    Headers: {"Authorization": "Basic <Token>"}
    Response status code 200
    
eg:

    curl -X GET \
      http://aymapp.herokuapp.com/api/v1/todos/ \
      -H 'Authorization: Basic dG9kb2FwcDpheW1jb21tZXJjZQ==' \
      -H 'Cache-Control: no-cache'
      
#### Update an existing todo list.

    PUT /api/v1/todos/:id
    Headers: {"Authorization": "Basic <Token>"}
    Response status code 204
    
eg

    curl -X PUT \
      http://aymapp.herokuapp.com/api/v1/todos/5 \
      -H 'Authorization: Basic dG9kb2FwcDpheW1jb21tZXJjZQ==' \
      -H 'Cache-Control: no-cache' \
      -H 'Content-Type: application/json' \
      -d '{
    	"title": "What to cook today?"
    }'
    
#### Delete a todo list.
    
    DELETE /api/v1/todos/:id
    Headers: {"Authorization": "Basic <Token>"}
    Response status code 204

eg:
    
    curl -X DELETE \
      http://aymapp.herokuapp.com/api/v1/todos/5 \
      -H 'Authorization: Basic dG9kb2FwcDpheW1jb21tZXJjZQ==' \
      -H 'Cache-Control: no-cache' \
      -H 'Postman-Token: 0a7aae4b-ae9e-6404-6eca-5313e2fdc788'
    
#### Add items to the todo list

    POST /api/v1/todos/:id/items/
    Body: { "name": "Item name", "done": <true or false> }
    Response status code 201
    
eg

    curl -X POST \
      http://aymapp.herokuapp.com/api/v1/todos/4/items/ \
      -H 'Authorization: Basic dG9kb2FwcDpheW1jb21tZXJjZQ==' \
      -H 'Cache-Control: no-cache' \
      -H 'Content-Type: application/json' \
      -d '{
        "name": "Init git repo.",
        "done": false
    }'
    
#### List items in the todo list

    GET /api/v1/todos/:id/items/
    Headers: { "Authorization": "Basic <Token>"}
    Response Status code 200
    
eg

    curl -X GET \
      http://aymapp.herokuapp.com/api/v1/todos/4/items/ \
      -H 'Authorization: Basic dG9kb2FwcDpheW1jb21tZXJjZQ==' \
      -H 'Cache-Control: no-cache' \
      -H 'Content-Type: application/json' \
      -d '{
        "name": "Init git repo.",
        "done": false
    }'
    
#### Update items in the todo list

    PUT /api/v1/todos/:todo_id/items/:item_id
    Headers: { "Authorization": "Basic <Token>"}
    Body: { "name": "Name to update", done": <true or false> }
    Response status code 204
  
 eg
    
    curl -X PUT \
      http://aymapp.herokuapp.com/api/v1/todos/4/items/3 \
      -H 'Authorization: Basic dG9kb2FwcDpheW1jb21tZXJjZQ==' \
      -H 'Cache-Control: no-cache' \
      -H 'Content-Type: application/json' \
      -d '{
        "name": "Setup git repo.",
        "done": true
    }' 
    
#### Remove an item in todo list


    DELETE /api/v1/todos/:todo_id/items/:item_id
    Headers: { "Authorization": "Basic <Token>"}
    Response status code 204
    
eg

    curl -X DELETE \
      http://aymapp.herokuapp.com/api/v1/todos/4/items/3 \
      -H 'Authorization: Basic dG9kb2FwcDpheW1jb21tZXJjZQ==' \
      -H 'Cache-Control: no-cache'
