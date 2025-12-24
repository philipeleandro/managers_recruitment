import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["candidateForm"]


  showForm() {
    this.candidateFormTarget.classList.toggle("hidden")

    let containHiden = this.candidateFormTarget.classList.contains("hidden")
    let button = document.getElementById('new-candidate-button')


    if (containHiden) {
      button.innerText = "Adicionar Candidato"
    } else {
      button.innerText = "Recolher"
    }

  }
}
