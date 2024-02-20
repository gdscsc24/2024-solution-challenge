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

###  Text Sentimental Classification using MobileBert

This project aims to classify text sentiments using MobileBERT, a lightweight version of the BERT model optimized for mobile devices. We leverage MediaPipe Model Maker, a tool for customizing existing machine learning models to suit our specific data and applications.

#### Overview

This model is trained to classify emotions based on user-provided emotion diaries as input. The sentiment classification task involves predicting the emotional tone or sentiment conveyed in the text, which can be valuable for various applications such as sentiment analysis in social media, customer feedback analysis, and mood tracking.

#### Dataset

The model is trained on a custom dataset consisting of emotion diary entries collected from diverse sources. Each entry is associated with a particular emotion label, allowing the model to learn to associate text patterns with specific emotional states. The dataset is preprocessed and formatted to suit the input requirements of the MobileBERT model.

#### Model Architecture

MobileBERT is chosen as the underlying architecture due to its lightweight nature, making it suitable for deployment on resource-constrained devices such as mobile phones. It retains the effectiveness of the original BERT model while achieving faster inference times and reduced memory footprint.

#### Training Process

The model is trained using a combination of labeled emotion diary data and transfer learning techniques. We fine-tune the pre-trained MobileBERT model on our emotion classification task, adjusting its parameters to optimize performance on our specific dataset. The training process involves iteratively updating the model's weights using gradient descent optimization methods while monitoring performance metrics on validation data to prevent overfitting.

#### Evaluation Metrics

The performance of the trained model is evaluated using standard evaluation metrics such as accuracy, precision, recall, and F1 score on a held-out validation set. These metrics provide insights into the model's ability to correctly classify emotions in unseen data and its overall effectiveness in capturing different emotional nuances present in the text.

#### Conversion to TFLITE
To deploy the sentiment classification model on resource-constrained devices such as mobile phones or edge devices, we convert the trained model to TensorFlow Lite (TFLite) format. TFLite provides efficient execution of machine learning models on edge devices with low latency and reduced memory footprint.
