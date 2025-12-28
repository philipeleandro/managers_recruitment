import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { type: String }

  connect() {
    requestAnimationFrame(() => {
      this.element.classList.remove("opacity-0", "translate-y-[-20px]")
      this.element.classList.add("opacity-100", "translate-y-0")
    })

    if (this.typeValue === 'notice') {
      setTimeout(() => {
        this.dismiss()
      }, 5000)
    }
  }

  dismiss() {
    this.element.classList.remove("opacity-100", "translate-y-0")
    this.element.classList.add("opacity-0", "translate-y-[-20px]")

    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}
