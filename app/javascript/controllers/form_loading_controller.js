import { Controller } from "@hotwired/stimulus"

// フォーム送信時のローディング制御（二重送信防止）
export default class extends Controller {
  static targets = ["submitButton"]

  connect() {
    this.element.addEventListener("submit", this.handleSubmit.bind(this))
  }

  disconnect() {
    this.element.removeEventListener("submit", this.handleSubmit.bind(this))
  }

  handleSubmit() {
    if (!this.hasSubmitButtonTarget) return

    const btn = this.submitButtonTarget
    btn.disabled = true
    btn.classList.add("btn-submit--loading")

    // ボタンテキストをスピナー付きに変更
    btn.dataset.originalText = btn.value
    btn.value = "送信中..."
  }
}