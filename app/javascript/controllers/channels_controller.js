import { Controller } from "@hotwired/stimulus"
import { createRoomSubscription } from "channels/chat_channel"

export default class extends Controller {
  static targets = ["link"]

  subscribe(event) {
    const link = event.currentTarget
    const room = link.dataset.room
    createRoomSubscription(room)
  }
}
