# Moodista
![Logo]('assets/images/loading_logo.png')
Moodista is a mental health self-care app for modern people.

 **Diary-based sentiment analysis** provides customized content.
Pursue healthy life and well-being for all age groups by supporting connections with communities and treatment centers.

## Members

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### How to learning the App?
- install Flutter and Simulator
- play 'flutter pub get' in terminal to install environments
- Start debugging in 'main.dart' file

## Front-End
### Tech Stack
- Futter : 3.16.9
- Dart : 3.2.6
- Google maps flutter : 2.5.3
- Google sign in : 6.2.1

### Architecture
'''    
app 
    ├── assets
    │   ├── fonts
    │   └── images
    │       
    ├── lib
    │   ├── constants
    │   ├── models
    │   ├── providers
    │   └── screens
    │       ├── auth
    │       ├── diary
    │       ├── likes
    │       ├── location
    │       ├── recommended 
    │       └── settings
    ├── widgets
    └── main

    
'''


    



## Back-End

## AI

### Model Architecture

This project aims to classify text sentiments using MobileBERT, a lightweight version of the BERT model optimized for mobile devices. We leverage MediaPipe Model Maker, a tool for customizing existing machine learning models to suit our specific data and applications. This customized model is trained to classify emotions based on user-provided emotion diaries as input. More information can be found on [the official page](https://developers.google.com/mediapipe/solutions/customization/text_classifier).

### Dataset

The model is trained on a custom dataset consisting of emotion entries collected from the Google AI GOEmotions dataset (GoEmotions). The GoEmotions consists of comments from Reddit users with labels of their emotional coloring. Each entry is associated with a particular emotion label (joy, sadness, fear, anxiety, ...), allowing the model to learn to associate text patterns with specific emotional states. The dataset is preprocessed and formatted to suit the input requirements of the MobileBERT model. You can download a raw dataset on [the Kaggle page](https://www.kaggle.com/datasets/shivamb/go-emotions-google-emotions-dataset).

### Deployment
To deploy the sentiment classification model on resource-constrained devices such as mobile phones or edge devices, we convert the trained model to TensorFlow Lite (TFLite) format. TFLite provides efficient execution of machine learning models on edge devices with low latency and reduced memory footprint.
