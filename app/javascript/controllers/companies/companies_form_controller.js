import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["companyForm"]

  showForm() {
    this.companyFormTarget.classList.toggle("hidden")
    this.updateButtonText()
  }

  forceOpen() {
    this.companyFormTarget.classList.remove("hidden")
    window.scrollTo({ top: 0, behavior: 'smooth' })
    this.updateButtonText()
  }

  hideForm() {
    if (!this.companyFormTarget.classList.contains("hidden")) {
      this.companyFormTarget.classList.add("hidden")
      this.updateButtonText()
    }
  }

  updateButtonText() {
    let form = this.companyFormTarget
    let button = document.getElementById('new-company-button')


    if (!button) return

    if (form.classList.contains("hidden")) {
      button.innerText = "Adicionar Empresa"
    } else {
      button.innerText = "Recolher"
    }
  }

  onPostSuccess(event) {
    if (event.detail.success) {
      const tableFrame = document.getElementById("companies_list")

      if (tableFrame) {
        tableFrame.src = window.location.href
      }

      event.target.reset()
      this.hideForm()
    }
  }
}
