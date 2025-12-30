import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["companyRow", "filterButton", "emptyState", "table"]

  connect() {
    this.addHoverEffect()
  }

  addHoverEffect() {
    this.companyRowTargets.forEach((row) => {
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
    const url = status ? `/companies?status=${status}` : "/companies"
    const frame = document.getElementById("companies_list")
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

  filterByData(event) {
    const data = event.currentTarget.dataset.value
    const url = new URL(window.location.href)
    url.searchParams.set('tab', data)
    const frame = document.getElementById("show_companies_list")
    frame.src = url

    this.updateActiveFilterButton(event.currentTarget)
  }

  deleteCompany(event) {
    event.preventDefault()
    if (confirm("Are you sure you want to delete this company?")) {
      event.target.closest("form").submit()
    }
  }
}
