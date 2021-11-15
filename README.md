# BLENDR

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Blendr is an app that allows a user to view a feed of nearby restaurants and favorite them. The favorited restaurants will be sorted in a list. This list can be filtered depending on the type of food the user is hungry for. Users may also see reviews of other users and chat with them and may potentially become a food Tinder app.

### App Evaluation
- **Category:** Food 
- **Mobile:** The app would be developed for mobile users, but could potentially be used on a computer.
- **Story:** Gives user a feed of restaurants in the area. Allows user to favorite restaurants and look at reviews of other users too. Users can choose to chat with other reviewers to gain more insight about a particular restaurant too.
- **Market:** Any person could choose to use this app, especially those who have a difficult time deciding on where they/their group wants to eat. 
- **Habit:** This can be used as little or as often as somebody would like. 
- **Scope:** First we would start with allowing users to favorite restaurants, then it could evolve to a food-review app that allows reviewers to chat with each other. This app could have potential collaborations with UberEats in the future.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can register and log in.
* User can see a list of restaurants and favorite restaurants.
* User can see the list of restaurants favorited.
* User can update their profile.

**Optional Nice-to-have Stories**

* User can leave a review.
* User can add filter to restaurants.
* User can chat with another person who left a review.
* User can follow another user.
* User can look at the map view for restaurants.

### 2. Screen Archetypes

* Login/Register
   * User can register/login.
* Restaurants Stream (Home Screen)
   * User can see a list of restaurants and favorite restaurants.
* Favorites Stream (Favorite Tab)
   * User can see the list of restaurants favorited.
* Profile
   * User can update their profile.

Optional:
* Detailed Restaurants Stream
   * User can see details of a particular restaurant.
* Chat Screen
   * User can chat with another person who left a review.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Tab
* Favorites Tab
* Profile Tab

Optional:
* Chat Tab
* Settings Tab

**Flow Navigation** (Screen to Screen)

* Log-in -> Directs to Home Tab
* Home Tab -> (Optional) Jumps to Detailed Restaurants.

## Wireframes
![](https://i.imgur.com/Z9kIbER.jpg)

### [BONUS] Digital Wireframes & Mockups
![](https://i.imgur.com/KNJrSWH.png)

### [BONUS] Interactive Prototype
![](https://i.imgur.com/qg8bApp.gif)


## Schema 
[This section will be completed in Unit 9]
### Models

## Restaurants
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | restaurantID | String | the name of the restaurant being shown |
   | miles    | Number   | number of miles that the restaurant is from the user |
   | restImage | File | the image of the restaurant in the feed |
   
## Favorites
  | Property      | Type     | Description |
  | ------------- | -------- | ------------|
  | favoritedOn     | DateTime | date when a restaurant is favorited |
  | restaurantID | String | the name of the restaurant being shown |
  | restImage | File | the image of the restaurant in the feed |
  
## Profile
  | Property      | Type     | Description |
  | ------------- | -------- | ------------|
  | profilePic         | File     | image that user picks as their account photo |
  | user        | Pointer to User| the person who is using the app |
  | email | String   | the email that the user uses to log in with |
  | joinedAt     | DateTime | date when user makes their account |
  
## Reviews
  | Property      | Type     | Description |
  | ------------- | -------- | ------------|
  | caption       | String   | caption by  the author |
  | profilePic         | File     | image that user picks as their account photo |
  | reviewId      | String   | unique id for the person who wrote the review |

### Networking
#### List of network requests by screen
   - Home Feed Screen
      - (Read/GET) Query all posts where user views a list of restaurants
      - (Create/POST) Create a new like(favorite) on a restaurant.
   - Favorites Screen
      - (Read/GET) Query all restaurants user favorited
        ```swift
         let query = PFQuery(className:"Restaurant")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "favoritedAt")
         query.findObjectsInBackground { (favorites: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let favorites = favorites {
               print("Successfully retrieved \(favorites.count) favorites.")
            }
         }
         ```
      - (Delete) Delete a favorited restaurant
   - Profile Screen
      - (Read/GET) Query logged in user object
      - (Create/POST) Register new user
#### [OPTIONAL:] Existing API Endpoints
##### An API Of Ice And Fire
- Base URL - [http://www.anapioficeandfire.com/api](http://www.anapioficeandfire.com/api)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /characters | get all characters
    `GET`    | /characters/?name=name | return specific character by name
    `GET`    | /houses   | get all houses
    `GET`    | /houses/?name=name | return specific house by name

##### Game of Thrones API
- Base URL - [https://api.got.show/api](https://api.got.show/api)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /cities | gets all cities
    `GET`    | /cities/byId/:id | gets specific city by :id
    `GET`    | /continents | gets all continents
    `GET`    | /continents/byId/:id | gets specific continent by :id
    `GET`    | /regions | gets all regions
    `GET`    | /regions/byId/:id | gets specific region by :id
    `GET`    | /characters/paths/:name | gets a character's path with a given name
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
