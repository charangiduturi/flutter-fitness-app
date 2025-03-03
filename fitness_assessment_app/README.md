# Flutter Fitness Assessment App

Welcome to the Flutter Fitness Assessment App! This application allows users to input their physical details, calculate their Body Mass Index (BMI), and receive personalized fitness insights.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [BLoC Pattern Usage](#bloc-pattern-usage)
- [Challenges Faced](#challenges-faced)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [License](#license)

## Features

- **User Input**: Users can enter personal details such as height, weight, age, and gender.
- **BMI Calculation**: The app computes the BMI based on user inputs.
- **Fitness Insights**: Provides feedback and recommendations based on the calculated BMI.

## Architecture

This application follows the principles of Clean Architecture to ensure scalability, maintainability, and testability. The project is organized into the following layers:

1. **Presentation Layer**: Contains the UI components and widgets. This layer is responsible for displaying data and handling user interactions.

2. **Domain Layer**: Encapsulates the business logic. It includes entities and use cases that define the core functionalities of the app.

3. **Data Layer**: Manages data sources, including APIs, local databases, and repositories. This layer is responsible for data retrieval and storage.

The directory structure is as follows:

```
lib/
├── data/
│   ├── models/
│   ├── repositories/
│   └── data_sources/
├── domain/
│   ├── entities/
│   └── use_cases/
└── presentation/
    ├── blocs/
    ├── screens/
    └── widgets/
```

## BLoC Pattern Usage

The app utilizes the BLoC (Business Logic Component) pattern for state management, promoting a clear separation between business logic and UI components. The key components include:

- **Events**: Represent user actions or application triggers.
- **States**: Define the various states of the UI based on events.
- **BLoC**: Manages the mapping of events to states, handling the business logic accordingly.

For instance, when a user submits their physical details:

1. An `InputSubmitted` event is dispatched.
2. The `FitnessBloc` processes this event, calculates the BMI, and determines the appropriate fitness insights.
3. The UI updates based on the new state emitted by the `FitnessBloc`.

This approach ensures a predictable and testable flow of data within the application.

## Challenges Faced

During the development of this app, several challenges were encountered:

- **State Management**: Implementing the BLoC pattern required a deep understanding of reactive programming and stream management. Ensuring efficient state transitions and avoiding unnecessary rebuilds were crucial considerations.

- **Input Validation**: Handling various user inputs and validating them appropriately to prevent errors during BMI calculation.

- **Responsive Design**: Designing a user interface that adapts seamlessly to different screen sizes and orientations.

- **Performance Optimization**: Ensuring smooth performance, especially during data processing and state transitions, to provide a responsive user experience.

## Getting Started

To run this application locally, follow these steps:

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/charangiduturi/flutter-fitness-app.git
   cd flutter-fitness-app
   ```

2. **Install Dependencies**:

   Ensure you have Flutter installed. Then, run:

   ```bash
   flutter pub get
   ```

3. **Run the App**:

   Launch the application on an emulator or physical device:

   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! If you'd like to enhance the app or fix issues, please fork the repository and submit a pull request. Ensure that your code adheres to the project's coding standards and includes appropriate tests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
