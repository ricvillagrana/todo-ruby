# Todo App
## Installation
For isntallation run these commands:
```
bundle install

yarn install 

rails db:create 
rails db:migrate
rails db:seed
```
## Enviroment variables you will need
In ```/config/application.rb:22``` set your gmail:
```
user_name: '<YOUR USERNAME>@gmail.com',
```
and allow access for *less secure apps* [here](https://myaccount.google.com/u/1/lesssecureapps?)
### Exporting variables
Also you will need to set your gmail password in the *enviroment variables*:
```
export GMAIL_PASSWORD=<YOUR PASSWORD>
```
## Running the app
Now you can run the app:
```
rails s
```
