# MushEngine

A Flutter project for the Multimedia Information Retrieval and Computer Vision Project.\
Requirements:
- Flutter v2.5.3
- Dart sdk: ">=2.11.0 <3.0.0" (without null-safety)

## Project Structure
The Flutter project has the following structure:
- repository: classes that perform http requests to the backend
- model: model classes used in the app (query results)
- widgets: classes regarding the graphical repeatable components in the app
- pages: classes regarding the pages of the app

## How to use this app?

The App functionalities are very basic and intended for educational purposes.\
We start from the home screen, which allows us to select an image from the gallery or from
the camera.\
We can upload an image and the app will classify the mushroom in one of the most common mushroom classes, showing also a list of similar mushrooms with their class and relevancy score.
