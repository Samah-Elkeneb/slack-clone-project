import { Controller } from "@hotwired/stimulus";
import { createRoomSubscription } from "channels/chat_channel";

export default class extends Controller {
  static targets = ["link"];

  subscribe(event) {
    const link = event.currentTarget;
    const room = link.dataset.room;

    createRoomSubscription(room);

    this.setActiveChannel(link);
  }

  setActiveChannel(activeLink) {
    this.linkTargets.forEach((link) => {
      link.classList.remove("bg-gray-100", "font-medium");
    });

    activeLink.classList.add("bg-gray-100", "font-medium");
  }
}
