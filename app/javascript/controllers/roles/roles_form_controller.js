import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["roleForm"]

  showForm() {
    this.roleFormTarget.classList.toggle("hidden")
    this.updateButtonText()
  }

  forceOpen() {
    this.roleFormTarget.classList.remove("hidden")
    window.scrollTo({ top: 0, behavior: 'smooth' })
    this.updateButtonText()
  }

  hideForm() {
    if (!this.roleFormTarget.classList.contains("hidden")) {
      this.roleFormTarget.classList.add("hidden")
      this.updateButtonText()
    }
  }

  updateButtonText() {
    let form = this.roleFormTarget
    let button = document.getElementById('new-role-button')


    if (!button) return

    if (form.classList.contains("hidden")) {
      button.innerText = "Criar Vaga"
    } else {
      button.innerText = "Recolher"
    }
  }

  onPostSuccess(event) {
    if (event.detail.success) {
      const tableFrame = document.getElementById("roles_list")

      if (tableFrame) {
        tableFrame.src = window.location.href
      }

      event.target.reset()
      this.hideForm()
    }
  }
}
