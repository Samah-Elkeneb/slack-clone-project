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
  setAttributes(el, fill, stroke) {
    if (el) {
      el.setAttribute("fill", fill);
      el.setAttribute("stroke", stroke);
    }
  }
  setActiveChannel(activeLink) {
    this.linkTargets.forEach((link) => {
      const svgs = link.parentElement.parentElement.querySelectorAll("svg");
      const channel_svg = svgs[0].querySelector("path");
      const remove_svg = svgs[1];
      this.setAttributes(channel_svg, "#d5c6db", "none");
      this.setAttributes(remove_svg, "none", "currentColor");

      link.classList.remove("text-[#340a38]");
      link.parentElement.parentElement.classList.remove("bg-[#f7eefe]");
      link.classList.add("text-[#d5c6db]");
      link.parentElement.parentElement.classList.add("hover:bg-[#5b3861]");
    });
    activeLink.classList.remove("text-[#d5c6db]");
    activeLink.classList.add("text-[#340a38]");
    activeLink.parentElement.parentElement.classList.add("bg-[#f7eefe]");
    activeLink.parentElement.parentElement.classList.remove(
      "hover:bg-[#5b3861]"
    );
    const svgs = activeLink.parentElement.parentElement.querySelectorAll("svg");
    const channel_svg = svgs[0].querySelector("path");
    const remove_svg = svgs[1];

    this.setAttributes(channel_svg, "#340a38", "#340a38");
    this.setAttributes(remove_svg, "#340a38", "#340a38");
  }
}
