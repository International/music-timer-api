rails g model user email:string encrypted_password:string salt:string first_name:string last_name:string profile_image_url:string facebook_id:string country_reference_id:integer state_reference_id:integer city_reference_id:integer

rails g model country name:string
rails g model state name:string
rails g model city name:string

rails g model piece title:string description:string user_id:integer

rails g model practice name:string seconds:decimal state:integer recorded_at:timestamp piece_id:integer

rails g model goal time_unit:integer unit_value:decimal piece_id:integer user_id:integer

rails g model session user_id:integer token:string


# rails d model user
# rails d model country
# rails d model state
# rails d model city
# rails d model piece
# rails d model practice
# rails d model goal
# rails d model session
