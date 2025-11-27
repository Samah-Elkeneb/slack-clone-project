import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["box"];

  connect() {
    this.loading = false;

    if (this.hasBoxTarget) {
      this.scrollToBottom();
      this.initializeScroll();
    }

    document.addEventListener("turbo:load", () => {
      if (this.hasBoxTarget) {
        this.scrollToBottom();
        this.initializeScroll();
      }
    });

    document.addEventListener("turbo:frame-load", (event) => {
      if (event.target.querySelector('[data-controller="infinite"]')) {
        this.scrollToBottom();
        this.initializeScroll();
      }
    });
  }

  initializeScroll() {
    if (this._scrollInitialized) return;
    this._scrollInitialized = true;

    this.boxTarget.addEventListener("scroll", () => this.onScroll());
  }

  scrollToBottom() {
    this.boxTarget.scrollTop = this.boxTarget.scrollHeight;
  }

  onScroll() {
    if (this.loading) return;

    if (this.boxTarget.scrollTop < 80) {
      this.loadOlderMessages();
    }
  }

  loadOlderMessages() {
    if (!this.boxTarget.firstElementChild) return;

    this.loading = true;

    const first = this.boxTarget.firstElementChild;
    const beforeId = first.id.replace("message_", "");
    const url = `${this.boxTarget.dataset.loadMoreUrl}?before_id=${beforeId}`;

    const oldScrollHeight = this.boxTarget.scrollHeight;
    const oldScrollTop = this.boxTarget.scrollTop;

    fetch(url, {
      headers: { Accept: "text/vnd.turbo-stream.html" },
    })
      .then((r) => r.text())
      .then((html) => {
        // Render Turbo Stream
        Turbo.renderStreamMessage(html);

        requestAnimationFrame(() => {
          const newScrollHeight = this.boxTarget.scrollHeight;
          this.boxTarget.scrollTop =
            oldScrollTop + (newScrollHeight - oldScrollHeight);
        });
      })
      .finally(() => {
        this.loading = false;
      });
  }
}
