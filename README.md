# to_do_app

core dart, stateful stateless, async-await, try-catch, null-safety, api(GET-POST)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project Structure

lib/
├── core/                          
│ ├── constants/                 
│ ├── di/                       
│ ├── error/                     
│ ├── network/                  
│ ├── service/                  
│ ├── utils/                     
│ ├── validate/                     
│
├── features/                      
│ ├── todos/
│ │ ├── data/
│ │ │ ├── datasources/       
│ │ │ │ ├── remote/       
│ │ │ │ └── local/         
│ │ │ ├── models/           
│ │ │ ├── mappers/          
│ │ │ └── repositories/     
│ │ │
│ │ ├── domain/
│ │ │ ├── entities/          
│ │ │ ├── repositories/      
│ │ │ └── usecases/        
│ │ │
│ │ ├── presentation/
│ │ │ ├── viewmodels/       
│ │ │ ├── pages/             
│ │ │ └── widgets/      
│
├── app.dart                       
└── main.dart                      