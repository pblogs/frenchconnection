[![Code Climate](https://codeclimate.com/repos/5480807a69568040da000005/badges/e983a328555515b381da/gpa.svg)](https://codeclimate.com/repos/5480807a69568040da000005/feed)
## Alliero.orwapp.com

This app is used to keep track of `HoursSpent`.
Project leaders [1] create projects. A `Project` consist of one or more `Tasks`.
Each task can be delegated to one or more workers [2]. These workers report `HoursSpent` on the tasks they are given.
Reports are created by `ExcelController`. It's not really Excel files, but HTML pages transformed to PDF with PDFKit.
These reports are used by our customer to generate invoices.

[1] Users with 'project_leader' role.
[2] Users with 'worker' role.


## Start the app

### Install Docker and docker-compose

* https://docs.docker.com/installation
* https://docs.docker.com/compose/install/

```
docker-compose build # Only required the first time.
docker-compose up -d
docker-compose run app rake db:create db:migrate db:seed RAILS_ENV=development
docker-compose run app rake db:create db:migrate RAILS_ENV=test
```


## Customer spesific variables
We have several customers that uses this codebase. Each has its own instance running at Heroku. To keep things separted we use ENV-vars.

POST_ADDRESS_AREA:   0484 Oslo
POST_ADDRESS_NAME:   Alliero AS
POST_ADDRESS_STREET: Pb 4681 Nydalen
VISIT_ADDRESS_AREA:   0484 Oslo
VISIT_ADDRESS_NAME:   Alliero AS
VISIT_ADDRESS_STREET: Nydalsveien 30 B
EMAIL: post@alliero.no
FAX:   23 26 54 01
PHONE: 23 26 54 00
SHORT_NAME='alliero-orwapp' # Used for FOG bucket, Github-name


## Style Guide
Please follow our [Style Guide](https://github.com/stabenfeldt/alliero-orwapp/wiki/Style-guide)

## The Orwapp cloud

![The architecture](http://www.gliffy.com/go/publish/image/6487189/L.png)


## Models and relationships
![](https://github.com/stabenfeldt/alliero-orwapp/wiki/Style-guide)

Install graphviz to get the dot and neat utilities:
```
brew install graphviz
```

Add the railroady gem to your bundle:

```
group :development, :test do
    gem 'railroady'
end
```

    Run bundle install to install railroady:
```
    bundle install
    Run from the command line:
```
    railroady -o models.dot -M
```
    Then process the .dot file as an image, and voila!
```
    dot -Tpng models.dot > models.png
```



