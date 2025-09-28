# YouApp
this for technically challange flutter
- Create the Flutter app based on design.
- Implement GetX in Flutter or Implement routes.
- Writing unit tests, widget tests & integration tests.
- Usage of good design patterns & architecture patterns.
- Build and Connect with API


## GetX Clean Architecture

A Flutter project demonstrating Clean Architecture using GetX and MVVM, adhering to SOLID principles.

## 📌 Overview
This project follows a structured approach to building scalable Flutter applications with GetX for state management and dependency injection. It implements Clean Architecture to separate concerns and improve maintainability.

## 🚀 Features
- **GetX for State Management**
- **MVVM Architecture**
- **Dio for API Calls**
- **Interceptor for API Authorization**
- **Caching with DioCacheInterceptor**
- **Shared Preferences for Local Storage**
- **SOLID Principles Implementation**

## 📂 Project Structure
```
lib/
│
├── common/                # Shared utilities, themes, constants
│
├── app/
│   ├── exceptions/        # Custom exception handling
│   ├── global_widgets/    # Reusable UI components
│   ├── middlewares/       # Route guards and middlewares
│   ├── models/            # Entity definitions (business models)
│   ├── modules/           # Feature-based segregation
│   │   ├── auth/
│   │   │   ├── bindings/      # Dependency bindings
│   │   │   ├── controllers/   # State management using GetX
│   │   │   ├── services/      # Business logic and use cases
│   │   │   ├── views/         # UI components
│   │   │   ├── widgets/       # Reusable widgets on module level
│   │   ├── dashboard/
│   │   ├── root/          # Root navigation & app entry point
│   ├── providers/         # API services and data sources
│   ├── routes/            # Navigation and route management
│   ├── services/          # Global services (e.g., Auth, Storage)
│
├── main.dart              # Application entry point
```

# BUT I REFACTOR INTO Domain-Driven
Clean Architecture with GetX (DDD-style), adhering strictly to SOLID principles and testability. A Flutter project implementing Clean Architecture with GetX, following SOLID and Onion principles (Domain-Driven), with clear separation of Data, Domain, and Presentation layers.

# BIG THANKS FOR
i have research and exploring for clean architecture thats using getx so i found this starterpack. i know `get init` but there is also dont have service or infra on generate and i think this potential also for making a bash script for generate base on this pattern style.

## 📝 Article Reference
For a detailed explanation, check out the Medium article: [Implementing Clean Architecture with GetX and MVVM in Flutter](https://medium.com/@manikhan53/implementing-clean-architecture-with-getx-and-mvvm-in-flutter-adhering-to-solid-principles-8487994b993a).

---

now the structure is
```
📦lib
 ┣ 📂app
 ┃ ┣ 📂exceptions
 ┃ ┣ 📂global_widgets
 ┃ ┣ 📂middlewares
 ┃ ┣ 📂models
 ┃ ┣ 📂modules
 ┃ ┃ ┣ 📂auth
 ┃ ┃ ┃ ┣ 📂bindings
 ┃ ┃ ┃ ┃ ┗ 📜auth_binding.dart
 ┃ ┃ ┃ ┣ 📂data
 ┃ ┃ ┃ ┃ ┣ 📂datasources
 ┃ ┃ ┃ ┃ ┃ ┗ 📜auth_remote_datasource.dart
 ┃ ┃ ┃ ┃ ┣ 📂dto
 ┃ ┃ ┃ ┃ ┃ ┣ 📜login_result_dto.dart
 ┃ ┃ ┃ ┃ ┃ ┗ 📜register_result_dto.dart
 ┃ ┃ ┃ ┃ ┣ 📂payload
 ┃ ┃ ┃ ┃ ┃ ┣ 📜login_payload.dart
 ┃ ┃ ┃ ┃ ┃ ┗ 📜register_payload.dart
 ┃ ┃ ┃ ┃ ┗ 📂repositories
 ┃ ┃ ┃ ┃ ┃ ┗ 📜auth_repository_impl.dart
 ┃ ┃ ┃ ┣ 📂domain
 ┃ ┃ ┃ ┃ ┣ 📂entities
 ┃ ┃ ┃ ┃ ┣ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📂usecase
 ┃ ┃ ┃ ┗ 📂presentation
 ┃ ┃ ┃ ┃ ┣ 📂controllers
 ┃ ┃ ┃ ┃ ┗ 📂views
 ┃ ┣ 📂providers
 ┃ ┣ 📂routes
 ┃ ┣ 📂services
 ┣ 📂common
 ┗ 📜main.dart
 ```


---

## 🔄 Alur Data (contoh login flow)

```
[ UI Layer ]               [ Domain Layer ]                [ Data Layer ]              [ External ]
┌───────────────┐        ┌──────────────────┐           ┌─────────────────┐        ┌───────────────┐
│ LoginView     │        │ LoginUseCase     │           │ AuthRepository  │        │ API / Storage │
│ (presentation)│◀──────▶│ (business logic) │◀────────▶│ Impl            │◀──────▶│ (Dio / DB)    │
└───────────────┘        └──────────────────┘           └─────────────────┘        └───────────────┘
        ▲                          ▲                           ▲
        │                          │                           │
        │                          │                           │
┌───────────────┐        ┌──────────────────┐           ┌─────────────────┐
│ LoginController│        │ AuthRepository   │           │ DataSources     │
│ (GetX State)   │◀──────▶│ (interface)      │◀────────▶│ Remote/Local    │
└───────────────┘        └──────────────────┘           └─────────────────┘
```

---

### 📌 Penjelasan Flow

1. **User input di UI**

   * User isi email & password di `LoginView`.
   * `LoginController` (state management) handle event tombol login.

2. **Controller memanggil UseCase**

   * `controller.login()` → panggil `LoginUseCase.execute(LoginPayload)`.

3. **UseCase panggil Repository Interface**

   * `LoginUseCase` butuh kontrak dari `AuthRepository`.
   * Interface ini ada di **domain/repositories/**.

4. **Repository Impl (Data Layer)**

   * `AuthRepositoryImpl` (di `data/repositories/`) implement interface tadi.
   * Dia yang menentukan data diambil dari **RemoteDataSource** (API) atau **LocalDataSource** (cache).

5. **Datasource**

   * `AuthRemoteDataSource` → call API pakai `DioProvider`.
   * `AuthLocalDataSource` → simpan ambil token di `SharedPreferences/Hive`.

6. **Balik ke atas**

   * Response API → diubah ke **DTO** → di-mapping ke **Entity**.
   * Entity dikirim ke UseCase → Controller → update `Rx<User>` → UI otomatis refresh (`Obx`).

---

### 🧩 Layer Responsibility

* **UI (Presentation)** = Tampilan & interaksi user.
* **Controller (GetX)** = State & event handler.
* **Domain (Entities & UseCase)** = Business logic murni.
* **Repository Interface** = Kontrak data.
* **Repository Impl** = Bridge antara Domain ↔ Data.
* **DataSource** = Tempat asli ambil data (API, DB, cache).

---

```
flowchart TD
    A[LoginView<br>(UI Layer)] --> B[LoginController<br>(GetX State)]
    B --> C[LoginUseCase<br>(Domain)]
    C --> D[AuthRepository<br>(Interface)]
    D --> E[AuthRepositoryImpl<br>(Data Layer)]
    E --> F1[AuthRemoteDataSource<br>(API)]
    E --> F2[AuthLocalDataSource<br>(Storage)]
    F1 --> G[External API<br>(Dio/HTTP)]
    F2 --> H[Local Storage<br>(SharedPref/Hive)]

    %% Return flow
    G --> F1
    H --> F2
    F1 --> E
    F2 --> E
    E --> D
    D --> C
    C --> B
    B --> A
```