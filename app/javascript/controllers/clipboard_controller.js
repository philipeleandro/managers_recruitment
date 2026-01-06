import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static values = { text: String }

  copy(event) {
    event.preventDefault()
    const button = this.element;
    const originalText = button.innerText;

    navigator.clipboard.writeText(this.textValue).then(() => {
      button.innerText = "Copiado!";
      setTimeout(() => {
        button.innerText = originalText;
      }, 2000);
    }).catch(err => {
      console.error("Failed to copy text: ", err);
      button.innerText = "Falhou!";
      setTimeout(() => {
        button.innerText = originalText;
      }, 2000);
    });
  }
}