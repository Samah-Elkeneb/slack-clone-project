import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["frame"];

  connect() {
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape") this.close();
    });
  }

  open(event) {
    event.preventDefault();
    const url = event.currentTarget.href || event.currentTarget.dataset.url;
    fetch(url)
      .then((res) => res.text())
      .then((html) => {
        this.frameTarget.innerHTML += html;
      });
  }

  close() {
    this.frameTarget.remove();
  }

  backgroundClose(event) {
    if (event.target === event.currentTarget) {
      this.close();
    }
  }

  stop(event) {
    event.stopPropagation();
  }
}
