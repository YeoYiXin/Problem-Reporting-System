import os
import numpy as np
# import matplotlib.pyplot as plt
import tensorflow as tf
from keras.preprocessing.image import ImageDataGenerator
from keras.applications.mobilenet_v2 import MobileNetV2

"""divide dataset into train, test, valid"""


"""data preprocessing"""
img_shape = (224, 224, 3) #input requirement for mobilenetv2
batch_size = 50 #batch size for training - important factor when it comes to overfitting
#Define image data generator to augment data for the dataset
dataset_scale = ImageDataGenerator(rescale=1./255, rotation_range=20, width_shift_range=0.2, height_shift_range=0.2, horizontal_flip=True)
base_path = 'venv/Datasets3/' #path to dataset
train_data_dir = os.path.join(base_path, 'train') #path to training data
test_data_dir = os.path.join(base_path, 'test') #path to testing data
valid_data_dir = os.path.join(base_path, 'valid') #path to validation data

train_generator = dataset_scale.flow_from_directory(train_data_dir, target_size=img_shape[:2], batch_size=batch_size, class_mode='categorical')
test_generator = dataset_scale.flow_from_directory(test_data_dir, target_size=img_shape[:2], batch_size=batch_size, class_mode='categorical')
valid_generator = dataset_scale.flow_from_directory(valid_data_dir, target_size=img_shape[:2], batch_size=batch_size, class_mode='categorical', shuffle=False)

"""initialise model"""
base_mobilenetv2 = MobileNetV2(weights="imagenet", include_top=False, input_shape=img_shape) #instantiate model

base_mobilenetv2.trainable = False #to prevent retraining of weights of trained model
#base_mobilenetv2.summary() #print model summary
global_average_layer = tf.keras.layers.GlobalAveragePooling2D() #global average pooling layer

"""compile model"""
x = base_mobilenetv2.output
x = global_average_layer(x)
x = tf.keras.layers.Dense(4, activation='softmax')(x) # 4 output nodes for 4 classes
model = tf.keras.models.Model(inputs=base_mobilenetv2.input, outputs=x)
model.compile(optimizer=tf.keras.optimizers.Adam(lr=0.0001), loss='categorical_crossentropy', metrics=['accuracy'])

"""fit model"""
history = model.fit(
    train_generator,
    steps_per_epoch=train_generator.n // batch_size,
    epochs=5,  
    callbacks=[tf.keras.callbacks.EarlyStopping(monitor='val_loss', patience=5, restore_best_weights=True)],
    validation_data=valid_generator,
    validation_steps=valid_generator.n // batch_size
)

"""test model"""
test_loss, test_accuracy = model.evaluate(test_generator, steps=test_generator.n // batch_size)
print(f'Test accuracy: {test_accuracy:.4f}')
valid_loss, valid_accuracy = model.evaluate(valid_generator, steps=valid_generator.n // batch_size)
print(f'Validation accuracy: {valid_accuracy:.4f}')

"""predict model"""
class_names = ['cracks','garbage', 'no_event', 'snake']

# Load the image
img = tf.keras.preprocessing.image.load_img(
    'venv/Datasets3/predict3.jpeg', target_size=img_shape[:2]
)

# Convert the image to a numpy array
img_array = tf.keras.preprocessing.image.img_to_array(img)
print("img_array:" + str(img_array.shape))
# Expand the dimensions of the image to match the input shape of the model
img_array = tf.expand_dims(img_array, 0)

# Normalize the image
img_array /= 255.

# Make a prediction
predictions = model.predict(img_array)
print("Predictions"+str(predictions))

# Get the index of the predicted class
predicted_index = np.argmax(predictions[0])
print("Index Predictions"+str(predicted_index))
# Get the predicted class name
predicted_class = class_names[predicted_index]

print(f'Predicted class: {predicted_class}')

"""model accuracy analysis - train, valid, with actual dataset"""


