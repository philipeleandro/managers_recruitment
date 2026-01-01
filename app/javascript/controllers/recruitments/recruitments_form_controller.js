import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["recruitmentForm", "roleForm"]

  showForm() {
    this.recruitmentFormTarget.classList.toggle("hidden")
    this.updateButtonText()
  }

  forceOpen() {
    this.recruitmentFormTarget.classList.remove("hidden")
    window.scrollTo({ top: 0, behavior: 'smooth' })
    this.updateButtonText()
  }

  hideForm() {
    if (!this.recruitmentFormTarget.classList.contains("hidden")) {
      this.recruitmentFormTarget.classList.add("hidden")
      this.updateButtonText()
    }
  }

  updateButtonText() {
    let form = this.recruitmentFormTarget
    let button = document.getElementById('new-recruitment-button')


    if (!button) return

    if (form.classList.contains("hidden")) {
      button.innerText = "Criar Processo Seletivo"
    } else {
      button.innerText = "Recolher"
    }
  }

  onPostSuccess(event) {
    if (event.detail.success) {
      this.hideForm()

      const listFrame = document.getElementById("recruitment_list")

      if (listFrame) {
        listFrame.src = listFrame.src || window.location.href
      }
    }
  }
}
