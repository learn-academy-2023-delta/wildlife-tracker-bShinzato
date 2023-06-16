# README

# Wildlife Tracker Challenge
The Forest Service is considering a proposal to place in conservancy a forest of virgin Douglas fir just outside of Portland, Oregon. Before they give the go ahead, they need to do an environmental impact study. They've asked you to build an API the rangers can use to report wildlife sightings.

# Story 1: In order to track wildlife sightings, as a user of the API, I need to manage animals.

Branch: animal-crud-actions ✅

Acceptance Criteria

- Create a resource for animal with the following information: common name and scientific binomial ✅
    $rails g resource Animal common_name:string scientific_binomial:string
    $rails db:migrate 

- Can see the data response of all the animals ✅
    In app/controllers/animals_controller.rb create new method index.

```ruby
    def index
        animals = Animal.all
        render json: animals
    end
```    
    Within postman in the url, localhost:3000/animals. GET

- Can create a new animal in the database ✅
    $rails c
    > Animal.create common_name:'Cat', scientific_binomial:'Felis Silvestris Catus'

```java
 [
    {
        "id": 1,
        "common_name": "Cat",
        "scientific_binomial": "Felis Silvestris Catus",
        "created_at": "2023-06-15T22:05:56.543Z",
        "updated_at": "2023-06-15T22:05:56.543Z"
    }
]
```

- Can update an existing animal in the database ✅

    In app/controllers/animals_controller.rb create new method update.

```ruby
    def update
        animal = Animal.update(animal_params)
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
        end
    end
```
    NEED TO AUTHENTICATE TOKEN!
    Go to app/controllers/application_controller.rb and paste this within the block.

```ruby
skip_before_action :verify_authenticity_token
```

    Within postman PATCH localhost:3000/animals/:id CLICK on raw and type the same syntax as postman with the given parameters to update the instance.

```java
{
common_name: "Cat",
scientific_binomial: "Felis Silvestris Catus"        
}
```   

- Can remove an animal entry in the database ✅

    Within Controller create new method destroy

``` ruby
    def destroy
        animal = Animal.find(params[:id])
        if animal.destroy
            render json: animal
        else 
            render json: animal.error
        end
    end
```

    W/I postman DELETE localhost:3000/animals/1
    CHECK: postman GET localhost:3000/animals
    to see if that instance was deleted.

# Story 2: In order to track wildlife sightings, as a user of the API, I need to manage animal sightings.

Branch: sighting-crud-actions ✅

Acceptance Criteria

- Create a resource for animal sightings with the following information: latitude, longitude, date ✅
- Hint: An animal has_many sightings (rails g resource Sighting animal_id:integer ...) ✅
- Hint: Date is written in Active Record as yyyy-mm-dd (“2022-07-28") ✅

    $rails g resource Sighting latitude:string longitude:string date:string animal_id:integer
    $rails db:migrate

    Within animal.rb has_many :sightings
    Within sighting.rb belongs_to :animal

- Can create a new animal sighting in the database ✅

    W/I sightings controller create a create method.

```ruby
def create
        sighting = Sighting.create(sighting_params)
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
          private
    def sighting_params
        params.require(:sighting).permit(:latitude, :longitude, :date, :animal_id)
    end
```
    W/I postman only pass the permitted parameters within the postman syntax with POST

```java
        "latitude": "at a latitude of 34° N",
        "longitude": "at a longitude of 4° E",
        "date": "2023-05-15",
        "animal_id": 3
```

- Can update an existing animal sighting in the database ✅

    Within sightings controller create a new method called update.

```ruby
    def update
        sighting = Sighting.find(params[:id])
        sighting.update(sighting_params)
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end
```

    Within postman only pass permitted parameters with postman syntax with PATCH. 
    Make sure you include which id you want within the url => localhost:3000/sightings/2

```java
{
        "latitude": "at a latitude of 32° N",
        "longitude": "at a longitude of 115° E",
        "date": "2023-05-15",
        "animal_id": 3
}
```

- Can remove an animal sighting in the database ✅

    Within sighting controller create a new method destroy.

```ruby
    def destroy
        animal = Animal.find(params[:id])
        if animal.destroy
            render json: animal
        else 
            render json: animal.error
        end
    end
```
    To check switch to GET and git rid of the /:id.

    Within Postman DELETE. remember the route is an /:id. Ensure to add a primary key.


# Story 3: In order to see the wildlife sightings, as a user of the API, I need to run reports on animal sightings.

Branch: animal-sightings-reports ✅

Acceptance Criteria

- Can see one animal with all its associated sightings ✅
- Hint: Checkout this example on how to include associated records ✅
    Created a new resource called Information with animal:references sighting:references
```ruby
class Animal < ApplicationRecord
    has_many :sightings, through: :information
    has_many :information
end
```
```ruby
class Sighting < ApplicationRecord
    # belongs_to :animal
    has_many :animals, through: :information
    has_many :information
end
```
```ruby
class Information < ApplicationRecord
  belongs_to :animal
  belongs_to :sighting
end
```
    Within db/migrate/seeds give examples to run the tests.

```ruby
animal_a = Animal.create(common_name: "Black-Capped Chickadee", scientific_binomial: "Poecile Atricapillus")
animal_b = Animal.create(common_name: "Grackle", scientific_binomial: "Quiscalus Quiscula")
animal_c = Animal.create(common_name: "Common Starling", scientific_binomial: "Sturnus Vulgaris")
animal_d = Animal.create(common_name: "Mourning Dove", scientific_binomial: "Zenaida Macroura")

sighting_a = Sighting.create(latitude: "40.730610", longitude: "-73.935242", date:"2023-06-11", animal_id: 1)
sighting_b = Sighting.create(latitude: "30.26715", longitude: "-97.74306", date:"2023-06-14", animal_id: 2)
sighting_c = Sighting.create(latitude: "45.512794", longitude: "-122.679565", date:"2023-06-17", animal_id: 3)

information_a = Information.create(animal: animal_a, sighting: sighting_b)
information_b = Information.create(animal: animal_b, sighting: sighting_a)
information_c = Information.create(animal: animal_c, sighting: sighting_a)
information_d = Information.create(animal: animal_d, sighting: sighting_c)
information_e = Information.create(animal: animal_a, sighting: sighting_b)
```
    Within postman use /information/1 to get all data of the given instance.
    Also can run rails db:reset if you mess up your seed db. Make you put in your info before running that command.

- Can see all the all sightings during a given time period✅
- Hint: Your controller can use a range to look like this:
- class SightingsController < ApplicationController
  def index
    sightings = Sighting.where(date: params[:start_date]..params[:end_date])
    render json: sightings
  end
end
- Hint: Be sure to add the start_date and end_date to what is permitted in your strong parameters method
- Hint: Utilize the params section in Postman to ease the developer experience
- Hint: Routes with params

```ruby
    def index
        sightings = Sighting.where(date: params[:start_date]..params[:end_date])
        render json: sightings
    end
```
    Within postman use PARAMS to set KEY: start date and end date. VALUE: yyyy-mm-dd. It will log all sightings in between the dates.
    localhost:3000/sightings?state_date=2023-05-01&end_date=2023-06-25



Stretch Challenges

Story 4: In order to see the wildlife sightings contain valid data, as a user of the API, I need to include proper specs.

Branch: animal-sightings-specs

Acceptance Criteria
Validations will require specs in spec/models and the controller methods will require specs in spec/requests.

Can see validation errors if an animal doesn't include a common name and scientific binomial
Can see validation errors if a sighting doesn't include latitude, longitude, or a date
Can see a validation error if an animal's common name exactly matches the scientific binomial
Can see a validation error if the animal's common name and scientific binomial are not unique
Can see a status code of 422 when a post request can not be completed because of validation errors
Hint: Handling Errors in an API Application the Rails Way
Story 5: In order to increase efficiency, as a user of the API, I need to add an animal and a sighting at the same time.

Branch: submit-animal-with-sightings

Acceptance Criteria

Can create new animal along with sighting data in a single API request
Hint: Look into accepts_nested_attributes_for