import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["recruitmentForm", "roleForm"]

  // Recruitment form methods
  showRecruitmentForm() {
    this.hideRoleForm()
    this.recruitmentFormTarget.classList.toggle("hidden")
    this.updateRecruitmentButtonText()
  }

  forceOpenRecruitmentForm() {
    this.hideRoleForm()
    this.recruitmentFormTarget.classList.remove("hidden")
    window.scrollTo({ top: 0, behavior: 'smooth' })
    this.updateRecruitmentButtonText()
  }

  hideRecruitmentForm() {
    if (this.hasRecruitmentFormTarget && !this.recruitmentFormTarget.classList.contains("hidden")) {
      this.recruitmentFormTarget.classList.add("hidden")
      this.updateRecruitmentButtonText()
    }
  }

  updateRecruitmentButtonText() {
    let form = this.recruitmentFormTarget
    let button = document.getElementById('new-recruitment-button')

    if (!button) return

    if (form.classList.contains("hidden")) {
      button.innerText = "Criar Processo Seletivo"
    } else {
      button.innerText = "Recolher"
    }
  }

  onRecruitmentPostSuccess(event) {
    if (event.detail.success) {
      this.hideRecruitmentForm()
      const listFrame = document.getElementById("recruitment_list")
      if (listFrame) {
        listFrame.src = listFrame.src || window.location.href
      }
    }
  }

  // Role form methods
  showRoleForm() {
    this.hideRecruitmentForm()
    this.roleFormTarget.classList.toggle("hidden")
    this.updateRoleButtonText()
  }

  forceOpenRoleForm() {
    this.hideRecruitmentForm()
    this.roleFormTarget.classList.remove("hidden")
    window.scrollTo({ top: 0, behavior: 'smooth' })
    this.updateRoleButtonText()
  }

  hideRoleForm() {
    if (this.hasRoleFormTarget && !this.roleFormTarget.classList.contains("hidden")) {
      this.roleFormTarget.classList.add("hidden")
      this.updateRoleButtonText()
    }
  }

  updateRoleButtonText() {
    if (!this.hasRoleFormTarget) return

    let form = this.roleFormTarget
    let button = document.getElementById('new-role-button')

    if (!button) return

    if (form.classList.contains("hidden")) {
      button.innerText = "Criar Vaga"
    } else {
      button.innerText = "Recolher"
    }
  }

  onRolePostSuccess(event) {
    if (event.detail.success) {
      const tableFrame = document.getElementById("roles_list")

      if (tableFrame) {
        tableFrame.src = window.location.href
      }

      event.target.reset()
      this.hideRoleForm()
    }
  }
}