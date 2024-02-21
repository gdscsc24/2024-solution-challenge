# 2024 Solution Challenge : Moodista ☕️

> GDSC GIST
>
> 2024.1.16 ~ 2024.2.21
>
> [Dev Log](https://gossamer-galaxy-3c3.notion.site/1be5d86e385746ca92b0c123db5f6fec?v=66e6b96703324838812d111df1860a57&pvs=4)

<div align="center">
  <img src="assets/images/loading_logo.png" alt="Logo" width="250"/>
</div>

<br>

## Project Introduction

Moodista is a mental health self-care app for modern people.

Diary-based sentiment analysis provides you with customized contents!

Pursue healthy life and well-being for all age groups by supporting connections with communities and treatment centers. 

<br>

## Members

| Team Member   | Role           |
|---------------|----------------|
| Lee Jaehee    | AI / Design    |
| Ji Yuna       | Front-end      |
| Choi Wonhyeok | Back-end       |
| Jeon Wooseok  | AI             |

<br>

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

<br>

### Implementation of App
- install Flutter and Simulator
- play 'flutter pub get' in terminal to install environments
- Start debugging in 'main.dart' file

<div align="center">
  <img src="assets/images/moodista_video.gif" alt="Logo" width="250"/>
</div>

<br>

## Front-End

### Tech Stack
- flutter : 3.16.9
- dart : 3.2.6
- google maps flutter : 2.5.3
- google sign in : 6.2.1
- intl : 0.18.1
- firebase_core : 2.24.2
- firebase_auth : 4.16.0
- cloud_firestore : 4.14.0

### Hierarchy

```
app
├── assets
│ ├── fonts
│ └── images
├── lib
│ ├── constants
│ ├── models
│ ├── providers
│ ├── screens
│ ├── auth
│ ├── diary
│ ├── likes
│ ├── location
│ ├── recommended
│ └── settings
└── widgets
```

## Back-End

The user authentication system provided by firebase allows users to log in using email and Google login. The user's email information and the data to be searched based on the model's results were stored in the firestore. All the data that the user records on a daily basis is collected and managed using firestore.

To deploy the function and apply it to the app, we used Google cloud function. After using Bert Model to make it lightweight with tflite model, we imported the user's text from firestore and put it as the input of the function, and made it so that the app receives the result in json format. As a result, the app stores the information in firestore and uses it to recommend videos in the future.

<br>

## AI

### Tech Stack
- transformers : 4.35.2
- tensorflow : 2.15.0
- mediapipe-model-maker : 0.2.1.3

### Hierarchy

```
ai
├── dataset
│ ├── train.csv
│ └── validation.csv
├── model
│ └── mobilebert.tflite
└── mobilebert.py            # Main code
```

### Model Architecture

Moodista employs MobileBERT, a lightweight version of the BERT model optimized for mobile devices, for text sentiment classification. We utilize MediaPipe Model Maker to customize the model, tailoring it to our specific data and applications.

### Dataset

The model is trained on emotion entries collected from the GoEmotions dataset, consisting of comments from Reddit users labeled with emotions like joy, sadness, fear, and anxiety. The dataset is preprocessed and formatted to suit the input requirements of the MobileBERT model.

### Deployment

The sentiment classification model is deployed on resource-constrained devices such as mobile phones or edge devices using TensorFlow Lite (TFLite) format, ensuring efficient execution with low latency and reduced memory footprint.

For more information on customizing models and datasets, refer to the [online documentation](https://developers.google.com/mediapipe/solutions/customization/text_classifier) and [Kaggle page](https://www.kaggle.com/datasets/shivamb/go-emotions-google-emotions-dataset).
