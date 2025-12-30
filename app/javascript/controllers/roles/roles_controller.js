import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["roleRow", "filterButton", "emptyState", "table"]

  connect() {
    this.addHoverEffect()
  }

  addHoverEffect() {
    this.roleRowTargets.forEach((row) => {
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
    const url = status ? `/roles?status=${status}` : "/roles"
    const frame = document.getElementById("roles_list")
    frame.src = url

    this.updateActiveFilterButton(event.currentTarget)
  }

  updateActiveFilterButton(clickedButton) {
    this.filterButtonTargets.forEach(btn => {
      btn.classList.remove("bg-blue-600", "text-white", "hover:bg-blue-700")
      btn.classList.add("text-slate-600", "hover:bg-slate-100")
    })
    clickedButton.classList.remove("text-slate-600", "hover:bg-slate-100")
    clickedButton.classList.add("bg-blue-600", "text-white", "hover:bg-blue-700")
  }

  deleteRole(event) {
    event.preventDefault()
    if (confirm("Are you sure you want to delete this role?")) {
      event.target.closest("form").submit()
    }
  }
}
