require_relative 'lib'

food = ['apples', 'rhubarb', 'pumpkin', 'grapefruit', 'mulberry', 'rosemary', 'mint', 'lilly pilly']
location1 = ['behind the', 'next to the', 'around the', 'in front of the']
location2 = ['fence', 'grass', 'pavement', 'wall', 'driveway', 'zebra crossing', 'intersection', 'traffic lights']

6.times do

    run_sql(
    "INSERT INTO food (food_type, image_url, location_description) VALUES ($1, $2, $3);",
    [
        "#{food.sample}",
        'https://via.placeholder.com/300',
        "#{location1.sample} #{location2.sample}"
    ]
    )

end