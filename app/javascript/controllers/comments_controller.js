import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  clear(){
    console.log(this);
    this.element.reset();
  }
}