import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  showDetails(event) {
    const url = event.currentTarget.dataset.url;

    fetch(url)
      .then(response => response.json())
      .then(data => {
        this.displayDetails(data);
      })
      .catch(error => {
        console.error('Error fetching vehicle details:', error);
      });
  }

  displayDetails(vehicle) {
    const detailsContainer = document.getElementById("details-view");

    detailsContainer.innerHTML = `
      <h2>${vehicle.name}</h2>
      <p><strong>Model:</strong> ${vehicle.model}</p>
      <p><strong>Manufacturer:</strong> ${vehicle.manufacturer}</p>
      <p><strong>Crew:</strong> ${vehicle.crew}</p>
      <p><strong>Passengers:</strong> ${vehicle.passengers}</p>
    `;

    document.body.appendChild(detailsContainer);
  }
}
