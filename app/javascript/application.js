// app/javascript/application.js

import "@hotwired/turbo-rails"
import "controllers"


document.addEventListener('DOMContentLoaded', function() {
    console.log("DOM fully loaded");
  
    // Attach click event to all links with `data-show-spinner="true"`
    document.querySelectorAll('a[data-show-spinner="true"]').forEach(function(link) {
      link.addEventListener('click', function() {
        const modal = document.getElementById("loading-modal");
        if (modal) {
          modal.style.display = "flex";  // Show the modal spinner
        }
      });
    });
  });
  
  // Hide the spinner when the page loads
  window.addEventListener('load', function() {
    const modal = document.getElementById("loading-modal");
    if (modal) {
      modal.style.display = "none";  // Hide the modal spinner when the page is fully loaded
    }
  });
  