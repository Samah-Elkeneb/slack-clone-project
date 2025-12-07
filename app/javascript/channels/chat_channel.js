import consumer from "channels/consumer";

function isSubscribed(roomName) {
  return consumer.subscriptions.subscriptions.some((sub) => {
    const params = JSON.parse(sub.identifier);
    return params.channel === "ChatChannel" && params.room === roomName;
  });
}
function createRoomSubscription(roomName) {
  if (isSubscribed(roomName)) {
    return;
  }

  consumer.subscriptions.create(
    { channel: "ChatChannel", room: roomName },
    {
      received(html) {
        document.getElementById("no-messages-div")?.remove();
        document
          .getElementById("chat-box")
          .insertAdjacentHTML("beforeend", html);

        document.querySelector("trix-editor").editor.loadHTML("");
      },
    }
  );
}

export { createRoomSubscription };
