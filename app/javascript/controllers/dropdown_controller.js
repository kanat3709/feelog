// app/javascript/controllers/dropdown_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this._outsideClick = this._handleOutsideClick.bind(this)
    document.addEventListener("click", this._outsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this._outsideClick)
  }

  toggle(event) {
    event.stopPropagation()
    const isOpen = this.menuTarget.classList.toggle("dropdown-menu--open")
    event.currentTarget.setAttribute("aria-expanded", isOpen)
  }

  close() {
    this.menuTarget.classList.remove("dropdown-menu--open")
    this.element.querySelector("[aria-expanded]")?.setAttribute("aria-expanded", "false")
  }

  _handleOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }
}