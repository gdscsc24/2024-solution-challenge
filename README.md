# Moodista
<div align="center">
  <img src="assets/images/loading_logo.png" alt="Logo" width="200"/>
</div>

Moodista ☕️ is a mental health self-care app for modern people.

 **Diary-based sentiment analysis** provides you with customized contents 😊!
 
Pursue healthy life and well-being for all age groups 🌱 by supporting connections with communities and treatment centers. 

## Members

| Team Member   | Role           |
|---------------|----------------|
| Lee Jaehee    | AI / Design    |
| Ji Yuna       | Front-end      |
| Choi Wonhyeok | Back-end       |
| Jeon Wooseok  | AI             |

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Implementation of App
- install Flutter and Simulator
- play 'flutter pub get' in terminal to install environments
- Start debugging in 'main.dart' file

## Front-End
### Tech Stack
- Flutter : 3.16.9
- Dart : 3.2.6
- Google maps flutter : 2.5.3
- Google sign in : 6.2.1

### Architecture

app

├── assets

│ ├── fonts

│ └── images

├── lib

│ ├── constants

│ ├── models

│ ├── providers

│ └── screens

│ ├── auth

│ ├── diary

│ ├── likes

│ ├── location

│ ├── recommended

│ └── settings

└── widgets

## Back-End

## AI

### Model Architecture

Moodista employs MobileBERT, a lightweight version of the BERT model optimized for mobile devices, for text sentiment classification. We utilize MediaPipe Model Maker to customize the model, tailoring it to our specific data and applications.

### Dataset

The model is trained on emotion entries collected from the GoEmotions dataset, consisting of comments from Reddit users labeled with emotions like joy, sadness, fear, and anxiety. The dataset is preprocessed and formatted to suit the input requirements of the MobileBERT model.

### Deployment

The sentiment classification model is deployed on resource-constrained devices such as mobile phones or edge devices using TensorFlow Lite (TFLite) format, ensuring efficient execution with low latency and reduced memory footprint.

For more information on customizing models and datasets, refer to the [online documentation](https://developers.google.com/mediapipe/solutions/customization/text_classifier) and [Kaggle page](https://www.kaggle.com/datasets/shivamb/go-emotions-google-emotions-dataset).
