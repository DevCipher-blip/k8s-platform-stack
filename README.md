# Rails order management API

## The application implemented here

The checkout contains a Rails order-management API. Its customer, product, and order resources are separated into controllers, models, policies, serializers, and parameter-validation services. Start with [the API controllers](app/controllers/api/v1/) and [the domain models](app/models/).

The repository name refers to a platform stack, while the committed implementation is the Rails application and its development configuration. Kubernetes manifests are not included in this checkout. Deployment packaging and cluster operations should be presented separately from the API behavior demonstrated here.

## README
### OMS API

#### Development Setup
- Ruby version 2.7.1
- Rails version 6.0.4
#### System Level Dependencies:
- PostgreSQL 14.1
#### Project Level Dependencies
- bundle install
#### Setting up the Database
```
rails db:create
```
```
rails db:migrate
```
```
rails db:seed
```
#### Start the Rails Server
```
rails server
```
#### Running Tests
```
bundle exec rspec
```
