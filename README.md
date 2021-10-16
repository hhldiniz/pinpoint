# Pinpoint Microframework

![master_status_check](https://github.com/github/docs/actions/workflows/main.yml/badge.svg?branch=master)

## What it is
Pinpoint is a microframework built on top of [shelf](https://pub.dev/packages/shelf). It enables you to make a more concise and organized backend application while provides you with some common utilities to use during development.

## Getting Started

### Building a 'Hello World' application

#### Initial project setup

1. Configure Dart SDK
Follow the official documentation for how to configure Dart SDK in your system. You can find it [here](https://dart.dev/get-dart)

2. Create a dart project:
```bash
dart create <your_project_name>
```
3. In your `main` function instantiate the `PinpointApp` class. This will be your interface with the framework core features.
```dart
PinpointApp app = PinpointApp()
```

#### Creating a Controller
Controllers are handlers for incoming requests. You have some abstract controllers in Pinpoint that provide basic functionalities for your app. Since we are just covering the basics in this first app, we are going to use the `BaseController` class. It's a bare-bones Controller that provides a blueprint to handle requests.
1. Create a file called 'hello_controller.dart' somewhere inside the 'lib' folder. Inside of it create a `HelloController` class and make it extend the `BaseController` abstract class.
2. BaseController (as any other Controller in Pinpoint) has 4 basic methods that represent HTTP verbs: `get`, `post`, `put` and `delete`. Since we are going for a 'get' request, override the `get` method. Don't forget to make it async since every request in Pinpoint Framework is asynchronous.
3. Inside `get` method return `Response.ok` static method with 'Hello World' string as it's parameter like so:
```dart
 @override
 Future<Response> get(Request request) async {
  return Response.ok('Hello World');
 }
```
After that our 'HelloController' class should be looking like this:
```dart
class HelloWorldController extends BaseController {
  HelloWorldController(String route) : super(route);

  @override
  Future<Response> get(Request request) async {
    return Response.ok("Hello World");
  }
}
```
#### Registering Controllers
1. After you create your Controller you have to register it in your PinpointApp instance to it be available for the framework to use. 
2. Go to your `main` method, where you first created an instance of `PinpointApp` and create an instance of `HelloController`. Pass as it's single parameter the route this Controller will be listening to. 
> Attention: You have to pass the route parameter with a leading '/' character.
4. Call `registerController()` method of `PinpointApp` with the instance of your freshly created `HelloController` class.
5. Now that you have everything wired up, you need to call `start()` method of your `PinpointApp` instance. This will start the service and begin to listen requests. Don't forget to mark your main function as 'async' and but 'await' before `start()` since we have async operations here.
6. Done! Now you just have to start your dart app as you would normally do. By calling `dart run my_dart_file.dart`.

> Check the source code for a folder called 'reference'. Here you will find a simple implementation of the Pinpoint Framework.
