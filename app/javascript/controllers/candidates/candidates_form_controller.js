import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["candidateForm"]

  showForm() {
    this.candidateFormTarget.classList.toggle("hidden")
    this.updateButtonText()
  }

  forceOpen() {
    this.candidateFormTarget.classList.remove("hidden")
    window.scrollTo({ top: 0, behavior: 'smooth' })
    this.updateButtonText()
  }

  hideForm() {
    if (!this.candidateFormTarget.classList.contains("hidden")) {
      this.candidateFormTarget.classList.add("hidden")
      this.updateButtonText()
    }
  }

  updateButtonText() {
    let form = this.candidateFormTarget
    let button = document.getElementById('new-candidate-button')


    if (!button) return

    if (form.classList.contains("hidden")) {
      button.innerText = "Adicionar Candidato"
    } else {
      button.innerText = "Recolher"
    }
  }

  onPostSuccess(event) {
    if (event.detail.success) {
      const tableFrame = document.getElementById("candidates_list")

      if (tableFrame) {
        tableFrame.src = window.location.href
      }

      event.target.reset()
      this.hideForm()
    }
  }
}
