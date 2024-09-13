# Developer's Guide

This document explains the architecture, design decisions, and key concepts behind the Star Wars API Explorer project. It's intended for developers who want to understand how the application is structured and how to contribute to or extend its functionality.

## Architecture Overview

The Star Wars API Explorer is a **Ruby on Rails** application that interacts with the [Star Wars API](https://swapi.dev) (SWAPI) to display data about films, people, and vehicles. The application is structured following the **MVC (Model-View-Controller)** pattern, which organizes the code into three interconnected components:

1. **Models**: While we don't use traditional Rails models that map to a database, we treat external API data as a kind of "model" that can be interacted with.
2. **Controllers**: Responsible for handling API requests, caching, and rendering views.
3. **Views**: Present the data in a structured and user-friendly way, linking related objects and showing details of films, people, and vehicles.

### Key Technologies Used

- **Ruby on Rails**: The main framework used to build the application.
- **HTTParty**: A Ruby gem used to interact with the SWAPI, sending HTTP requests and parsing the response.
- **Redis**: Used as a caching layer to store API responses and reduce redundant API calls, improving performance.
- **Turbo (Optional)**: Handles page loading and transitions, enhancing the user experience with faster responses and minimal page reloads.
- **Tailwind CSS** (or custom CSS): Initially used for styling, but the solution may include custom CSS classes for responsiveness and design.

---

## Main Components

### 1. API Interaction via **StarWarsApiService**

The application interacts with SWAPI through a service layer (`StarWarsApiService`). Instead of placing API calls directly in the controllers, this service centralizes the logic for interacting with the external API.

#### Example API Call in the Service

```ruby
class StarWarsApiService
  include HTTParty
  base_uri 'https://swapi.dev/api/'

  def self.get_film(film_id)
    get("/films/#{film_id}").parsed_response
  end

  def self.get_person(person_id)
    get("/people/#{person_id}").parsed_response
  end
  # Similar methods for vehicles, etc.
end
```

This allows us to:
- **Encapsulate API logic** in a single place.
- **Handle errors and retries** in the future if needed.
- **Refactor easily** if SWAPI changes or if we switch to a different API.

### 2. Caching with Redis

To reduce load on the Star Wars API and improve performance, we cache API responses using Redis. We cache the **entire response object** for each film, person, or vehicle, so the full data can be used in various contexts (like links or detail pages).

#### Example of Caching in a Controller

```ruby
class StarWarsController < ApplicationController
  def show_film
    film_id = params[:id]
    
    @film = Rails.cache.fetch("film_#{film_id}", expires_in: 12.hours) do
      StarWarsApiService.get_film(film_id)["result"]["properties"]
    end

    render "star_wars/show_film"
  end
end
```

- **Key**: The cache key is generated dynamically (e.g., `"film_#{film_id}"`) to ensure unique keys for each object.
- **Expiration**: Cached data expires after 12 hours by default, ensuring it's relatively fresh without overloading the API.

### 3. Views and Links Between Related Objects

The views are structured to display related objects (e.g., a film's characters or a person's films) as **clickable links**. The relevant objects are fetched and cached, and their names (or titles) are used as link text.

#### Example of Rendering Related Objects in the View

```ruby
<h3>Characters</h3>
<ul>
  <% @characters.each do |character| %>
    <% character_id = character["url"].split("/").last %>
    <li><%= link_to character["name"], person_path(character_id) %></li>
  <% end %>
</ul>
```

### 4. Loading Spinner for Data Fetching

A **loading spinner** is shown when navigating to details pages (e.g., clicking on a film or person) to indicate that the API request is in progress.

- The spinner is shown using JavaScript that listens for clicks on specific links (with a `data-show-spinner="true"` attribute).

```javascript
document.querySelectorAll('a[data-show-spinner="true"]').forEach(function(link) {
  link.addEventListener('click', function() {
    const modal = document.getElementById("loading-modal");
    if (modal) {
      modal.style.display = "flex";  // Show the modal spinner
    }
  });
});
```

---

## Key Design Decisions

### 1. **Service Layer for API Interaction**
   - We abstracted the API logic into a service layer (`StarWarsApiService`) to keep the controllers clean and focused on handling requests, caching, and rendering views. This separation of concerns makes the code easier to maintain and extend.

### 2. **Caching with Redis**
   - By caching full objects (films, people, vehicles), we avoid excessive API calls and reduce loading times for frequently accessed data. We use **Rails.cache** with Redis as the store, and cache keys are dynamically generated based on the object type and ID (e.g., `film_1`, `person_2`).
   
### 3. **Dynamic Links Between Related Objects**
   - Each details view links to related objects, and we dynamically fetch the relevant data (e.g., character names for a film). This ensures that the data displayed is always up-to-date and correctly linked across views.

### 4. **Error Handling**
   - Currently, error handling is minimal (e.g., logging failures when API requests fail), but the design allows for more robust error handling in the future (e.g., retry logic, fallback responses).

---

## Extending the Application

### Adding New Resources (e.g., Planets, Starships)
1. **API Service**: Add a new method in `StarWarsApiService` to fetch the new resource.
2. **Controller**: Create a new action in the controller to handle the request and cache the response.
3. **View**: Add a new view to render the data, and ensure related objects (e.g., people, vehicles) are linked correctly.
4. **Routes**: Define routes for the new resource in `config/routes.rb`.

---

## Conclusion

This application follows a clean and modular architecture, separating concerns between API interaction, caching, and presentation. The service layer and caching mechanisms ensure the application is performant and scalable, while the clear MVC structure makes it easy to extend with new features and resources.

For any contributions or questions, please refer to the main [README](../README.md) for setup instructions and guidelines.
