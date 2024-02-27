import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

import io
import tensorflow as tf
from openai import OpenAI
import numpy as np
from PIL import Image
# from google.cloud import secretmanager
# import logging
import base64

from flask import Flask, request, jsonify

# logging.basicConfig(filename='app.log', filemode='w', format='%(name)s - %(levelname)s - %(message)s', level=logging.INFO)

# def get_secret(project_id, secret_id, version_id="latest"):
#     # Create the Secret Manager client.
#     client = secretmanager.SecretManagerServiceClient()
#     # Build the resource.
#     name = f"projects/{project_id}/secrets/{secret_id}/versions/{version_id}"
#     # Access the secret.
#     response = client.access_secret_version(request={"name": name})
#     # Return the decoded payload.
#     return response.payload.data.decode('UTF-8')

class AIModel:
    def __init__(self, model_path):
        self.model_path = model_path
        self.interpreter = tf.lite.Interpreter(model_path=self.model_path)
        self.interpreter.allocate_tensors()
        self.input_details = self.interpreter.get_input_details()
        self.output_details = self.interpreter.get_output_details()

    def transform_image(self, pillow_image):
        # Ensure the input is not None
        if pillow_image is None:
            raise ValueError("The 'pillow_image' input should not be None")
        # Resize and preprocess the image
        target_size = (224, 224)
        pillow_image = pillow_image.resize(target_size)
        # Convert Pillow image to NumPy array
        img_array = tf.keras.preprocessing.image.img_to_array(pillow_image)
        # Expand dimensions to create a batch dimension
        img_array = np.expand_dims(img_array, axis=0)
        # Preprocess the image (normalize pixel values)
        img_array = (img_array / 127.5) - 1.0
        return img_array

    def predict(self, pillow_image):
        img_array = self.transform_image(pillow_image)
        self.interpreter.set_tensor(self.input_details[0]['index'], img_array)
        self.interpreter.invoke()
        output_data = self.interpreter.get_tensor(self.output_details[0]['index'])
        return output_data

main_model_path = 'model.tflite'
main_class_names = ['Electrical', 'Furniture', 'NoEvent', 'Outdoor', 'Pests', 'Plumbing','Room Damage']

model_dict = {
    'Electrical': {'model_path': 'Electrical.tflite', 'class_names': ['Air Conditioner', 'Fan', 'Lights']},
    'Furniture': {'model_path': 'Furniture.tflite', 'class_names': ['Cabinet', 'Chair', 'Table']},
    'Outdoor': {'model_path': 'Outdoor.tflite', 'class_names': ['Exposed Trash', 'Overgrown Greenery', 'Road Damage']},
    'Pests': {'model_path': 'Pests.tflite', 'class_names': ['Ants', 'Snake', 'Wasps']},
    'Plumbing': {'model_path': 'Plumbing.tflite', 'class_names': ['Pipes', 'Sink', 'Toilet']},
    'Room Damage': {'model_path': 'RoomDamage.tflite', 'class_names': ['Ceiling Damage', 'Floor Damage', 'Wall Damage']}
}

app = Flask(__name__)

@app.route("/get_class", methods=["GET", "POST"]) 
#if running on localhost use this url: http://127.0.0.1:5000/get_class
#receives one file type with key 'file'
def classify():
    if request.method == "POST":
        file = request.files.get('file')
        if file is None or file.filename == "":
            return jsonify({"error": "no file"})

        try:
            model = AIModel(main_model_path)
            image_bytes = file.read()
            pillow_img = Image.open(io.BytesIO(image_bytes))
            prediction = model.predict(pillow_img)
            predicted_class_index = np.argmax(prediction)
            # Use the index to get the predicted class name
            predicted_class = main_class_names[predicted_class_index]
            data = {"predicted class": predicted_class}
            return jsonify(data)
        except Exception as e:
            return jsonify({"error": str(e)})

    return "OK"

@app.route("/get_class_second", methods=["GET", "POST"])   
#if running on localhost use this url: http://127.0.0.1:5000/get_class_second
#receives one file type with key 'file'
def secondclassify():
    if request.method == "POST":
        file = request.files.get('file')
        if file is None or file.filename == "":
            return jsonify({"error": "no file"})

        try:
            model = AIModel(main_model_path)
            image_bytes = file.read()
            pillow_img = Image.open(io.BytesIO(image_bytes))
            prediction = model.predict(pillow_img)
            # Find the second-highest confidence
            sorted_indices = np.argsort(prediction[0])
            second_highest_class_index = sorted_indices[-2]
            second_highest_class = main_class_names[second_highest_class_index]

            data = {"second highest class": second_highest_class,}
            return jsonify(data)

        except Exception as e:
            return jsonify({"error": str(e)})

    return "OK"

@app.route("/get_subclass", methods=["GET", "POST"])   
#if running on localhost use this url: http://127.0.0.1:5000/get_subclass
#receives two inputs: one file type with key 'file' and one string type with key 'class_name'
def subclassify():
    if request.method == "POST":
        class_name = request.form.get('class_name')
        file = request.files.get('file')
        if file is None or file.filename == "":
            return jsonify({"error": "no file"})
        
        if class_name == 'NoEvent':
            return jsonify({"predicted class": "NoEvent"})

        try:
            model_path = model_dict[class_name]['model_path']
            class_names = model_dict[class_name]['class_names']
            model = AIModel(model_path)
            image_bytes = file.read()
            pillow_img = Image.open(io.BytesIO(image_bytes))
            prediction = model.predict(pillow_img)
            predicted_class_index = np.argmax(prediction)
            # Use the index to get the predicted class nam
            predicted_class = class_names[predicted_class_index]
            data = {"predicted class": predicted_class}
            return jsonify(data)

        except Exception as e:
            return jsonify({"error": str(e)})

    return "OK"

@app.route("/get_subclass_second", methods=["GET", "POST"])   
#if running on localhost use this url: http://127.0.0.1:5000/get_subclass_second
#receives two inputs: one file type with key 'file' and one string type with key 'class_name'
def secondsubclassify():
    if request.method == "POST":
        class_name = request.form.get('class_name')
        file = request.files.get('file')
        if file is None or file.filename == "":
            return jsonify({"error": "no file"})
        
        if class_name == 'NoEvent':
            return jsonify({"predicted class": "NoEvent"})

        try:
            model_path = model_dict[class_name]['model_path']
            class_names = model_dict[class_name]['class_names']
            model = AIModel(model_path)
            image_bytes = file.read()
            pillow_img = Image.open(io.BytesIO(image_bytes))
            prediction = model.predict(pillow_img)
            # Find the second-highest confidence
            sorted_indices = np.argsort(prediction[0])
            second_highest_class_index = sorted_indices[-2]
            second_highest_class = class_names[second_highest_class_index]

            data = {"second highest class": second_highest_class,}
            return jsonify(data)

        except Exception as e:
            return jsonify({"error": str(e)})

    return "OK"


@app.route("/get_desc", methods=["GET", "POST"]) 
#if running on localhost use this url: http://127.0.0.1:5000/get_desc
#receives one string type with key 'img_url'
def describe():
    if request.method == "POST":
        img_url = request.form.get('url')
        if img_url is None:
            return jsonify({"error": "no img received"})

        try:
            # OpenAI API Key 
            # open_api_key = get_secret('nottaproblem', 'OpenAI_Key')
            open_api_key = "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"
            
            # Initialize the OpenAI client with the API key
            client = OpenAI(api_key=open_api_key)
            # Optimized prompt for additional clarity and detail
            prompt_text = (
                    "A heavily damaged wall-mounted sink in a brick building with extensive wear and missing parts; likely necessitates complete replacement. Severity: High, due to potential water damage and unusability. Tasks: Shut off water supply, remove remnants, prepare wall for new installation, and install new sink with appropriate plumbing connections. Safety gear and cleanup crew recommended for debris removal and to ensure the area is secure for users post-repair."
                    "Take the above example as a guideline, you are a maintenance worker tasked with resolving an issue within a university campus where the problem can range from infrastructure issue to pest infestation issue or dangerous animals on the university."
                    " Please provide a detailed summary within 70 words maximum, focusing on crucial details such as the severity, and specific aspects of the reported issue."
            ) 
            # Create the payload for the completion request
            messages = [
                    {
                        "role": "user",
                        "content": [
                            {"type": "text", "text": prompt_text},
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:image/jpeg;base64,{img_url}",
                                "detail": "low",
                            },
                        }
                        ],
                    }
                ]
            # Make the request to the OpenAI API
            response = client.chat.completions.create(
                    model="gpt-4-vision-preview", messages=messages, max_tokens=300, n=1)
            # Send only the content of the first choice
            data = {"description": response.choices[0].message.content}
            return jsonify(data)
        except Exception as e:
            return jsonify({"error": str(e)})

    return "OK"


@app.route("/verify_unseen", methods=["GET", "POST"]) 
#if running on localhost use this url: http://127.0.0.1:5000/verify_unseen
#receives one file type with key 'img'
def verify():
    if request.method == "POST":
        file = request.files.get('file')
        if file is None:
            return jsonify({"error": "no img received"})

        try:
            # OpenAI API Key 
            open_api_key = get_secret('nottaproblem', 'OpenAI_Key')
            # Initialize the OpenAI client with the API key
            client = OpenAI(api_key=open_api_key)

            def encode_image(image_file):
                    return base64.b64encode(image_file.read()).decode('utf-8')
            base64_image = encode_image(file)

            # Optimized prompt for additional clarity and detail
            prompt_text = (
                    " If this image could be a suitable submission for a campus problem reporting system, send me back 'Yes',"
                    " if it is not appropriate as a submission for a campus reporting system and there are not any possible"
                    " issues with the image provided then send back 'No', send exactly the words described nothing more nothing less.")
            # Create the payload for the completion request
            messages = [
                    {
                        "role": "user",
                        "content": [
                            {"type": "text", "text": prompt_text},
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:image/jpeg;base64,{base64_image}",
                                "detail": "low",
                            },
                        }
                        ],
                    }
                ]
            # Make the request to the OpenAI API
            response = client.chat.completions.create(
                    model="gpt-4-vision-preview", messages=messages, max_tokens=300, n=1)
            # Send only the content of the first choice
            if response.choices[0].message.content == "Yes":
                return jsonify({"verified": True})
            elif response.choices[0].message.content == "No":
                return jsonify({"verified": False})
            else:
                return jsonify({"error": "Invalid check response"})
        except Exception as e:
            return jsonify({"error": str(e)})

    return "OK"

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')