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
        console.error('Error fetching person details:', error);
      });
  }

  displayDetails(person) {
    const detailsContainer = document.getElementById("details-view");

    detailsContainer.innerHTML = `
      <h2>${person.name}</h2>
      <p><strong>Gender:</strong> ${person.gender}</p>
      <p><strong>Birth Year:</strong> ${person.birth_year}</p>
      <p><strong>Height:</strong> ${person.height} cm</p>
      <p><strong>Mass:</strong> ${person.mass} kg</p>
    `;

    document.body.appendChild(detailsContainer);
  }
}
