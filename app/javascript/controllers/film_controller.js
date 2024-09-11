import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  showDetails(event) {
    const url = event.currentTarget.dataset.url;

    fetch(url)
      .then(response => response.json())
      .then(data => {
        console.log('API Response:', data);  // Log the response to inspect it
        this.displayDetails(data);    // Try to access 'result'
      })
      .catch(error => {
        console.error('Error fetching film details:', error);
      });
  }

  displayDetails(film) {
    const detailsContainer = document.getElementById("details-view");

    detailsContainer.innerHTML = `
      <h2>${film.title}</h2>
      <p><strong>Director:</strong> ${film.director}</p>
      <p><strong>Producer:</strong> ${film.producer}</p>
      <p><strong>Release Date:</strong> ${film.release_date}</p>
      <p><strong>Opening Crawl:</strong> ${film.opening_crawl}</p>
    `;

    document.body.appendChild(detailsContainer);
  }
}
