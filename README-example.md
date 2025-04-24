# FoodFinder

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview
### Description
FoodFinder helps users discover and review local restaurants based on their location, preferences, and dietary restrictions. Users can search for restaurants nearby, view menus, and share their dining experiences with friends.

### App Evaluation
- **Category:** Food & Dining / Social
- **Mobile:** Uses location services, camera for food photos, and real-time notifications.
- **Story:** Helps users find restaurants that match their preferences and dietary needs.
- **Market:** Anyone who eats at restaurants - particularly useful for travelers and people with dietary restrictions.
- **Habit:** Weekly usage when deciding where to eat, with active users checking for new recommendations a few times per week.
- **Scope:** V1 focuses on restaurant discovery and reviews. Future versions could add reservation systems and social features.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can create a new account
* User can log in/out
* User can view a list of nearby restaurants
* User can search for restaurants by name or cuisine
* User can view restaurant details (hours, menu, location)
* User can leave ratings/reviews for restaurants
* User can view their profile with past reviews

**Optional Nice-to-have Stories**

* User can filter restaurants by dietary restrictions
* User can save favorite restaurants
* User can share restaurants via text/social media
* User can upload photos with their reviews
* User can follow friends to see their reviews

### 2. Screen Archetypes

- [x] Login/Registration Screen
   * User can create a new account
   * User can log in to existing account

- [x] Stream (Restaurant List)
   * User can view a list of nearby restaurants
   * User can search for restaurants

- [x] Detail (Restaurant Details)
   * User can view restaurant details
   * User can see menu items
   * User can view reviews
   * User can write a review

- [x] Profile
   * User can view their profile information
   * User can see their past reviews
   * User can edit their preferences

- [x] Creation (Write Review)
   * User can rate a restaurant
   * User can write review text
   * User can add photos (optional)

### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Restaurant Discovery
* Search
* Profile

**Flow Navigation** (Screen to Screen)
- [x] Login/Registration Screen
   * => Restaurant List

- [x] Restaurant List
   * => Restaurant Details
   * => Search Filter Modal

- [x] Restaurant Details
   * => Write Review Screen
   * => Map View

- [x] Profile
   * => Edit Profile
   * => Past Reviews List
   * => Settings

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups
[Digital wireframes would be placed here]

### [BONUS] Interactive Prototype
[Interactive prototype link would be placed here]

## Schema 

### Models

#### User
| Property     | Type     | Description |
| ------------ | -------- | ----------- |
| userId       | String   | unique identifier for the user |
| username     | String   | username for login |
| email        | String   | user's email address |
| profileImage | File     | user's profile image |
| createdAt    | DateTime | when user account was created |
| dietaryPrefs | Array    | array of dietary preferences |

#### Restaurant
| Property      | Type     | Description |
| ------------- | -------- | ----------- |
| restaurantId  | String   | unique identifier for the restaurant |
| name          | String   | name of the restaurant |
| location      | GeoPoint | geographical location |
| cuisine       | String   | type of cuisine |
| priceRange    | String   | price category ($, $$, $$$) |
| hours         | Object   | opening hours by day |
| imageUrl      | String   | main image of restaurant |
| averageRating | Number   | average user rating (1-5) |

#### Review
| Property    | Type     | Description |
| ----------- | -------- | ----------- |
| reviewId    | String   | unique identifier for the review |
| userId      | String   | ID of user who wrote the review |
| restaurantId| String   | ID of restaurant being reviewed |
| rating      | Number   | rating from 1-5 stars |
| text        | String   | review content |
| imageUrls   | Array    | array of food photo URLs |
| createdAt   | DateTime | when review was created |

### Networking

#### Basic Network Request Example

```swift
// Example: Fetching trending restaurants
func fetchTrendingRestaurants() {
    // Create URL for the trending restaurants endpoint
    let url = URL(string: "https://api.foodfinder.com/restaurants/trending")!
    
    // Create and run the task
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // Check if we have valid data
        guard let data = data else {
            print("No data received")
            return
        }
        
        do {
            // Decode the JSON data into our Restaurant model
            let restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
            
            // Update UI on main thread
            DispatchQueue.main.async {
                self.restaurants = restaurants
                self.tableView.reloadData()
            }
        } catch {
            print("Error decoding JSON")
        }
    }
    
    // Start the network request
    task.resume()
}
```

#### List of API Endpoints

##### FoodFinder API
- Base URL - [https://api.foodfinder.com](https://api.foodfinder.com)

| HTTP Verb | Endpoint | Description |
| --------- | -------- | ----------- |
| `POST`    | /users | Create a new user account |
| `POST`    | /login | Authenticate a user |
| `GET`     | /users/me | Get current user profile |
| `GET`     | /restaurants/trending | Get trending restaurants |
| `GET`     | /restaurants/nearby | Get nearby restaurants |
| `GET`     | /restaurants/{id} | Get specific restaurant details |
| `GET`     | /restaurants/{id}/reviews | Get reviews for a restaurant |
| `POST`    | /reviews | Create a new review |
