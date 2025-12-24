import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  connect() {
    this.updateActiveLink()
    document.addEventListener("turbo:load", () => {
      this.updateActiveLink()
    })
  }

  updateActiveLink() {
    const currentPath = window.location.pathname

    this.linkTargets.forEach(link => {
      const linkPath = new URL(link.href).pathname
      const isActive = linkPath === currentPath

      if (isActive) {
        link.classList.add("border-b-2")
        link.classList.add("border-blue-600")
      } else {
        link.classList.remove("border-b-2")
        link.classList.remove("border-blue-600")
      }
    })
  }
}
