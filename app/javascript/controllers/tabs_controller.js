import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content"];

  show(event) {
    event.preventDefault();
    const selected = event.currentTarget.dataset.tab;

    this.element.querySelectorAll("nav a").forEach((tab) => {
      const isActive = tab.dataset.tab === selected;
      tab.classList.toggle("border-b-2", isActive);
      tab.classList.toggle("border-[#793c85]", isActive);
      tab.classList.toggle("text-gray-700", isActive);
      tab.classList.toggle("text-gray-500", !isActive);
    });

    this.contentTargets.forEach((content) => {
      content.classList.toggle("hidden", content.dataset.tab !== selected);
    });
  }
}
