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
}
