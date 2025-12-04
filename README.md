# slack_clone_project

A real-time, single-page Slack-style communication platform built with Rails 8, Turbo, Stimulus, ActionCable, and Tailwind CSS. Users can join public channels, participate in conversations, create private channels, manage members, and experience seamless real-time updates — all without full page reloads.

---

## 🚀 Features
### 🔸 Channels

- Public channels: visible to all users.

- Private channels: visible only to their members.
#### Users can:

- View all public channels

- View private channels they belong to

- Create new channels (creator becomes the admin)

#### Admins can:

- Delete the channel

- Add or remove members

- Edit channel settings (inside a modal)

### 🔸 Real-time Messaging

- Messages broadcast using ActionCable

- All users in the channel see updates instantly

- Only the last 10 messages load initially

- Older messages load automatically when scrolling up (infinite scroll)

- Rich text editor for composing messages

- File uploads inside channels already implemented

### 🔸 Single Page UI

- Entire app runs on one page

- Modals, forms, interactions → handled via Turbo Frames & Turbo Streams

- Fast UX similar to Slack

### 🔸 Members & Roles

- Two roles: admin and member

#### Admins can:

- Add members

- Remove members (except the creator)

- Edit channel details

#### Channel modal shows:

- Creator

- All members

- Admin-only actions

### 🔸 Authentication

- Implemented using Devise

---

## 🛠 Tech Stack
Component	Version / Tool
- Ruby	3.3.1
- Rails	8.1.1
- Database	SQLite
- Frontend	Tailwind CSS
- Real-time	ActionCable
- SPA Behavior	Turbo + Stimulus
- Auth	Devise

---

## 📦 Installation & Setup
### 1️⃣ Clone the repo
```sh
git clone https://github.com/Samah-Elkeneb/slack_clone_project.git
cd slack_clone_project
```

### 2️⃣ Install dependencies
```sh
bundle install
```

### 3️⃣ Setup the database
```sh
bin/rails db:setup
```

### 4️⃣ Install JS dependencies
```sh
bin/importmap:install
```

(If you're using Tailwind via Rails 8 default, no extra setup needed.)

---

### 5️⃣ Start the server
```sh
bin/rails server
```

#### Visit at:
http://localhost:3000

---

## 🧪 Running Tests
```sh
bundle exec rspec
```
---

## 📁 Project Structure

- app/

 - channels/ — ActionCable channels

 - controllers/ — Rails controllers (Turbo-powered)

 - views/ — Turbo Frames, Streams, Partials, Modals

 - models/ — User, Channel, Membership, Message

 - javascript/

   - controllers/ — Stimulus controllers

---

## 🎯 Current Limitations

- Direct messages (DMs) not implemented yet

- Only two roles (admin / member)

- SQLite used for development

---

## 🗺 Roadmap / Future Features

- Direct messaging between users

- Channel search

- User presence (online/offline)

- Notifications and mentions

---

## 🎥 Demo

A demo video will be added soon.

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you’d like to modify.

---

## 📄 License

This project is released under the MIT License.
