slack_clone_project

A real-time, single-page Slack-style communication platform built with Rails 8, Turbo, Stimulus, ActionCable, and Tailwind CSS.
Users can join public channels, participate in conversations, create private channels, manage members, and experience seamless real-time updates — all without full page reloads.

🚀 Features
🔸 Channels

Public channels: visible to all users.

Private channels: visible only to members.

Users can:

View all public channels.

View private channels they belong to.

Create new channels (creator becomes the channel admin).

Admins can:

Delete the channel.

Add/remove members.

Edit channel settings (from a modal).

🔸 Real-time Messaging

Messages broadcast via ActionCable.

All users in a channel see messages instantly.

Only the last 10 messages are loaded initially.

Automatic loading of older messages when scrolling up (infinite scroll).

Rich text editor for sending messages.

🔸 Single Page UI

Entire app runs on one main page.

Modals, forms, updates → handled with Turbo Frames & Turbo Streams.

Fast, smooth UX similar to Slack.

🔸 Members & Roles

Channel roles: admin, member.

Admins can:

Add members

Remove members (except the creator)

Edit channel details

Modal shows:

Channel creator

All members

Admin-only actions

🔸 Authentication

Implemented using Devise.

🛠 Tech Stack
Component	Version / Tool
Ruby	3.3.1
Rails	8.1.1
Database	SQLite
Frontend	Tailwind CSS
Real-time	ActionCable
SPA behavior	Turbo + Stimulus
Auth	Devise
📦 Installation & Setup
1. Clone the repo
git clone https://github.com/Samah-Elkeneb/slack_clone_project.git
cd slack_clone_project

2. Install dependencies
bundle install

3. Setup the database
bin/rails db:setup

4. Install JS dependencies (Tailwind, Stimulus, Turbo)
bin/importmap:install


(If you're using Tailwind via Rails 8 default, nothing else is required.)

5. Start the server
bin/rails server


Visit:
http://localhost:3000

🧪 Running Tests
bundle exec rspec

📁 Project Structure
app/
  channels/         # ActionCable channels
  controllers/      # Rails controllers (API-like, Turbo powered)
  views/            # Turbo Frames, Streams, Partials, Modals
  models/           # User, Channel, Membership, Message
  javascript/
    controllers/    # Stimulus controllers

🎯 Current Limitations

Direct messages (DMs) not implemented yet.

Only two roles: admin, member.

SQLite used for development.

🗺 Roadmap / Future Features

Direct messaging between users.

Channel search.

User presence (“online/offline”).

Channel notifications & mentions.

🎥 Demo

A demo video will be added soon.

🤝 Contributing

Pull requests are welcome.
For major changes, open an issue to discuss what you’d like to modify.

📄 License

This project is released under the MIT License.
