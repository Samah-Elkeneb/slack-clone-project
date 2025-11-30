import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["frame"];

  open(event) {
    event.preventDefault();
    const url = event.currentTarget.href || event.currentTarget.dataset.url;
    fetch(url)
      .then((res) => res.text())
      .then((html) => {
        this.frameTarget.innerHTML += html;
      });
  }
  //   open(event) {
  //     event.preventDefault();
  //     const url = event.currentTarget.href || event.currentTarget.dataset.url;
  //     const wrapper = this.frameTarget.querySelector("#modal-wrapper");

  //     fetch(url)
  //       .then((res) => res.text())
  //       .then((html) => {
  //         wrapper.innerHTML = html; // ضع المحتوى داخل wrapper
  //         this.frameTarget.classList.remove("hidden"); // إظهار المودال
  //       });
  //   }

  close() {
    const modalFrame = this.frameTarget.querySelector("#modal_frame");
    console.log(modalFrame);
    console.log(this.frameTarget);
    if (modalFrame) modalFrame.innerHTML = "";
    const modalContent = this.frameTarget.querySelector("#modal-content");
    console.log(modalContent);
    if (modalContent) modalContent.innerHTML = "";
    this.frameTarget.innerHTML = "";
    console.log(this.frameTarget);
    this.frameTarget.classList.add("hidden");
  }
}
