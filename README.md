# Urban Foraging

![Home Screen](/images/Homepage)

## Introduction
This project (https://floating-hollows-42882.herokuapp.com/) is the first step towards creating a functioning app for users to share their knowledge about publically accessible fruit trees, herbs, and vegetables in the Greater Sydney Area.

This has been an excellent exercise in creating a basic CRUD app. Constructing the app involved managing an HTTP server using the sinatra microframework, and an SQL database using PostgreSQL. The app also has a login feature complete with password encryption using bcrypt.  Currently, it is only a very rudimentary CRUD app, but it works smoothly.

## Technologies Used

* ruby
* sinatra
* PostgreSQL
* bcrypt
* heroku
* cloudinary
* css
* html

## Interesting Features
The app allows users to upload an image from their device, which is then stored on an S3 server using the Cloudinary API. This means that the app is a useful and easy method for users to quickly upload images of local foraging sites.

The app is also relatively responsive to different screen sizes, and should function quite well on smartphones.

## Future Features
There are a large number of features that I would like to add to this app to make it a more useful and complete product. These include:

### More Specific Locations
The food table needs to be expanded to include a column which specifies the subregion of Greater Sydney where the item is located. Furthermore, the "item location" could then be broken down into a two separate inputs - one more concrete ("Address") and the other allowing specific instructions ("Location Description"). This would make it easier to describe and locate foraging opportunities.

### Search Capabilities
With more specific locations in the database, users could then search for items in their local region of Sydney, and perhaps even by category ("Fruit", "Vegetable", "Herb", "Fungi")

### Comments
It would be wonderful to create a new table in the database which stored comments for each food item. Users could then interact with one another and provide updates as to the condition/availability of the food depicted in posts.

### Live Feed
The homepage could then become a live feed featuring "Trending Posts" (with recent comments) and "Recent Posts" which have just come online.

### Map
The medium term goal is to use the Google Maps API to create a map of foraging locations within Greater Sydney. Eventually, this could provide more or less the entire user interface for the app.  

## Future Code Improvements
The CSS file is a bit of a mess for this project, as my design lacked foresight and planning and was somewhat cobbled together on the fly. Despite the simple, plain, and consistent visual layout, there is a lot of needless repitition within the CSS file.
