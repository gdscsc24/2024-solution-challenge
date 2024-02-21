import os
import tensorflow as tf
from transformers import BertTokenizer
from mediapipe_model_maker import text_classifier
from mediapipe_model_maker import quantization

csv_params = text_classifier.CSVParams(
    text_column='Text', label_column='label')
train_data = text_classifier.Dataset.from_csv(
    filename="dataset/train.csv",
    csv_params=csv_params)
validation_data = text_classifier.Dataset.from_csv(
    filename="dataset/validation.csv",
    csv_params=csv_params)

supported_model = text_classifier.SupportedModels.MOBILEBERT_CLASSIFIER
hparams = text_classifier.BertHParams(epochs=2, batch_size=48, learning_rate=3e-5, export_dir="model")
options = text_classifier.TextClassifierOptions(supported_model=supported_model, hparams=hparams)

bert_model = text_classifier.TextClassifier.create(train_data, validation_data, options)

metrics = bert_model.evaluate(validation_data)
print(f'Test loss:{metrics[0]}, Test accuracy:{metrics[1]}')

quantization_config = quantization.QuantizationConfig.for_dynamic()
bert_model.export_model(quantization_config=quantization_config)
bert_model.export_labels(export_dir=options.hparams.export_dir)

interpreter = tf.lite.Interpreter(model_path="model/mobilebert.tflite")
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')

input_text = "I'm so sad"

tokens = tokenizer.encode_plus(
    input_text,
    add_special_tokens=True,
    max_length=128,
    pad_to_max_length=True,
    return_attention_mask=True,
    return_token_type_ids=True
)

input_ids = tokens['input_ids']
attention_mask = tokens['attention_mask']
token_type_ids = tokens['token_type_ids']

input_ids_tensor = tf.constant([input_ids], dtype=tf.int32)
attention_mask_tensor = tf.constant([attention_mask], dtype=tf.int32)
token_type_ids_tensor = tf.constant([token_type_ids], dtype=tf.int32)

interpreter.set_tensor(input_details[0]['index'], input_ids_tensor)
interpreter.set_tensor(input_details[1]['index'], attention_mask_tensor)
interpreter.set_tensor(input_details[2]['index'], token_type_ids_tensor)

interpreter.invoke()

tflite_output = interpreter.get_tensor(output_details[0]['index'])

print("Output:", tflite_output)