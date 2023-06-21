# paragony

Aplikacja wspomagająca planowanie budżetu domowego

## Start Steps

Before start project copy ```.env.default``` file and past with name ```.env``` in same folder.

Then you have to get anon key from https://app.supabase.com/project/woivvwosjzyyyveuzwuq/settings/api
in Project API key section and past into ```API_KEY``` variable

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Generate response DTO

To generate *.g.dart file to convert response DTO to domain you new to run this commend:
```flutter pub run build_runner build --delete-conflicting-outputs```
