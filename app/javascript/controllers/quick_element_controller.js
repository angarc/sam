import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [ 'elementTemplate', 'elementsContainer', 'formContainer' ]

  addElementForm(event) {
    event.preventDefault()
    this.formContainerTarget.innerHTML += this.elementTemplateTarget.innerHTML
  }

  removeElementForm(event) {
    event.preventDefault()
    let item = event.target.closest('.card')
    item.style.display = 'none'
  }

  clearElementForm(event) {
    let item = event.target.closest('.card')
    item.style.display = 'none'
  }
}
