import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    this.resultsTarget.innerHTML = ""
  }

  search() {
    const query = this.inputTarget.value

    if (query.length < 2) {
      this.resultsTarget.innerHTML = ""
      return
    }

    fetch(`/users/autocomplete?query=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(data => {
        this.resultsTarget.innerHTML = data.map(user => `
          <li class="px-2 py-1 hover:bg-gray-100 cursor-pointer">
            ${user.display_name} (@${user.username})
          </li>
        `).join("")
      })
  }
}