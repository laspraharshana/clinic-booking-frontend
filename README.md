<div align="center">

# 🏥 Clinic Booking — Frontend

**A Flutter mobile client for browsing doctors, booking appointments, and managing visits.**

[![Flutter](https://img.shields.io/badge/Flutter-Dart%20%5E3.8.1-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/State-Riverpod%20^3.0.2-1B1B1B?logo=flutter)](https://riverpod.dev)
[![Firebase Auth](https://img.shields.io/badge/Auth-Firebase-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com/products/auth)
[![License](https://img.shields.io/badge/License-Unspecified-lightgrey)](#-license)

</div>

---

## 📖 Overview

This repository is the **front-end client** for a clinic appointment booking system. It's built with Flutter and talks to the [`clinic-booking-mobile-app`](https://github.com/laspraharshana/clinic-booking-mobile-app) backend API for data and business logic.

## ✨ Features

- 🔐 **Patient authentication** via Firebase Auth
- 👩‍⚕️ **Browse doctors** and view their available appointment slots
- 📅 **Book appointments** and manage existing bookings
- 🕓 **View upcoming and past appointments**
- ⚡ **State management** with Riverpod

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart SDK `^3.8.1`) |
| State management | `flutter_riverpod ^3.0.2` |
| Networking | `dio ^5.9.0` |
| Auth | `firebase_auth ^6.0.2`, `firebase_core ^4.1.0` |
| Other | `fl_chart`, `shared_preferences`, `intl` |
| Platforms | Android · iOS · Web · Windows · macOS · Linux |

## 📁 Project Structure

```
lib/
├── app.dart                      # Root App (MaterialApp + routes + HomePage)
├── main.dart                     # Entrypoint; initializes Firebase then runs App
├── core/
│   ├── config/
│   │   └── app_config.dart       # API base URL via --dart-define
│   ├── network/
│   │   └── dio_client.dart       # Dio instance with Firebase Auth token
│   └── widgets/
│       └── async_value_widget.dart  # Helper for AsyncValue
└── features/
    ├── auth/
    │   ├── models/
    │   ├── controllers/
    │   └── views/
    ├── doctors/
    │   ├── models/                # doctor.dart, slot.dart
    │   ├── controllers/           # doctors_controller.dart
    │   └── views/                 # doctors_list_view.dart, doctor_slots_view.dart
    ├── booking/
    │   ├── models/
    │   ├── controllers/
    │   └── views/
    └── appointments/
        ├── models/
        ├── controllers/
        └── views/

test/
└── widget_test.dart               # Smoke test that pumps App
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (compatible with Dart `^3.8.1`)
- A configured Firebase project with Firebase Auth enabled
- The [backend API](https://github.com/laspraharshana/clinic-booking-mobile-app) running and reachable

### Setup

**1. Clone the repository**
```bash
git clone https://github.com/laspraharshana/clinic-booking-frontend.git
cd clinic-booking-frontend
```

**2. Install dependencies**
```bash
flutter pub get
```

**3. Add your Firebase configuration**

Add `google-services.json` (Android), `GoogleService-Info.plist` (iOS), and any other platform config files required by your Firebase project.

**4. Run the app**, pointing it at your backend API:
```bash
flutter run --dart-define=API_BASE_URL=http://localhost:8080
```

### Running Tests

```bash
flutter test
```

## 👥 Collaborators

| Name | GitHub | Role |
|---|---|---|
| laspraharshana | [@laspraharshana](https://github.com/laspraharshana) | Backend Developer |
| Dimesha Adikari | [@dimesha12](https://github.com/dimesha12) | Frontend Developer |
| Kavindi Chamika | [@Kv23-corder](https://github.com/Kv23-corder) | Frontend Developer |
| lakminiweb | [@lakminiweb](https://github.com/lakminiweb) | Frontend Developer |
| Sanoj Dayarathna | [@Sanoj5c](https://github.com/Sanoj5c) | Frontend Developer |
| Kosala Pushpakumara | [@KosalaCodes](https://github.com/KosalaCodes) | Backend Developer |


## 🔗 Related Repository

- **Backend API:** [clinic-booking-mobile-app](https://github.com/laspraharshana/clinic-booking-mobile-app)
