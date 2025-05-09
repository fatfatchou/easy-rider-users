# Easy Rider - User

A Flutter-based location-tracking project simulating a ride-hailing feature. This app displays real-time nearby drivers using Firebase Geofire, fetches the user’s current location, and draws routes between origin and destination using Mapbox Directions API — all managed with the BLoC state management pattern and Clean Architecture.

## 📱 Features

- 📍 Get user’s real-time location.
- 🚗 Track and update nearby drivers within a 10km radius.
- 📡 Real-time location updates (enter, exit, move) using Geofire.
- 🗺️ Draw routes from origin to destination using Mapbox Directions.
- 🎯 Calculate and display center of polyline for smooth camera animation.
- 🧠 Modular architecture using Clean Architecture principles.
- ⚙️ Robust state management using Flutter BLoC.

## 🧱 Architecture

This project follows **Clean Architecture**:

- **Presentation Layer**: BLoC (Business Logic Component) for managing state.
- **Domain Layer**: UseCases and Entities for business logic.
- **Data Layer**: Repositories, Firebase, Mapbox API handling.
