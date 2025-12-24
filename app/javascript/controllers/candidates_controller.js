import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["candidateRow", "filterButton", "emptyState", "table"]

  connect() {
    this.addHoverEffect()
  }

  addHoverEffect() {
    this.candidateRowTargets.forEach((row) => {
      row.addEventListener("mouseenter", () => {
        row.classList.add("bg-slate-50")
      })
      row.addEventListener("mouseleave", () => {
        row.classList.remove("bg-slate-50")
      })
    })
  }

  filterByStatus(event) {
    const status = event.currentTarget.dataset.status
    const url = status ? `/candidates?status=${status}` : "/candidates"
    window.location.href = url
  }

  deleteCandidate(event) {
    event.preventDefault()
    if (confirm("Are you sure you want to delete this candidate?")) {
      event.target.closest("form").submit()
    }
  }
}
