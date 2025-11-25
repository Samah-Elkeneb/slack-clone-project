import consumer from "channels/consumer"

function isSubscribed(roomName) {
  return consumer.subscriptions.subscriptions.some(sub => {
    const params = JSON.parse(sub.identifier)
    return params.channel === "ChatChannel" && params.room === roomName
  })
}
function createRoomSubscription(roomName) {
  if (isSubscribed(roomName)) {
    console.log(`Already subscribed to ${roomName}`);
    return;
  }

  consumer.subscriptions.create(
    { channel: "ChatChannel", room: roomName },
      {
        received(data) {
          this.appendLine(data);
        },

        appendLine(data) {
          const html = this.createLine(data);
          const chatBox = document.getElementById("chat-box");
          chatBox.insertAdjacentHTML("beforeend", html);
      },

      createLine(data) {
        return `
          <article class="mb-4">
            <div class="flex items-baseline gap-3">
              <div class="h-8 w-8 rounded-full bg-slate-300 flex items-center justify-center text-sm font-medium">
                ${data["user_name"]}
              </div>
              <div>
                <div class="text-sm font-medium">
                  ${data["user_email"]}
                  <span class="text-xs text-slate-400 ml-2">
                    ${data["created_at"]}
                  </span>
                </div>

                <div class="mt-1 text-sm text-slate-700">${data["body"]}</div>
              </div>
            </div>
          </article>
        `;
      }
    }
  );
}

export { createRoomSubscription }
