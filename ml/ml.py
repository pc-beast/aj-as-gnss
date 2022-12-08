import numpy as np
import os
import scipy.io
import scipy
import tensorflow as tf
from tensorflow import keras


DATASET_PATH = 'D:/dataset'
x_t_path  = DATASET_PATH + '/x_t'
r_t_path = DATASET_PATH + '/r_t'
r_s_path = DATASET_PATH + '/r_s'
a_authentic_path = DATASET_PATH + '/amplitudes_authentic'
doa_authentic_path = DATASET_PATH + '/doa_authentic'
doa_jamming_path = DATASET_PATH + '/doa_jamming'
doa_spoofed_path = DATASET_PATH + '/doa_spoofed'
NUM_SAMPLES = 250

# get the authentic, spoofed and jammed signals from r_t
def get_r_t():
    r_t = []
    for i in range(1, NUM_SAMPLES+1):
        SAMPLE_PATH = r_t_path + '/' + str(i) + '.mat'
        r_t.append(scipy.io.loadmat(SAMPLE_PATH)['r_t'])
    return r_t

# get the original signals from x_t
def get_x_t():
    x_t = []
    for i in range(1, NUM_SAMPLES+1):
        SAMPLE_PATH = x_t_path + '/' + str(i) + '.mat'
        x_t.append(scipy.io.loadmat(SAMPLE_PATH)['x_t'])
    return x_t

# get the doa_spoofed
def get_doa_spoofed():
    doa_spoofed = []
    for i in range(1, NUM_SAMPLES+1):
        SAMPLE_PATH = doa_spoofed_path + '/' + str(i) + '.mat'
        doa_spoofed.append(scipy.io.loadmat(SAMPLE_PATH)['doa_spoofed'])
    return doa_spoofed

# get the doa_jamming
def get_doa_jamming():
    doa_jamming = []
    for i in range(1, NUM_SAMPLES+1):
        SAMPLE_PATH = doa_jamming_path + '/' + str(i) + '.mat'
        doa_jamming.append(scipy.io.loadmat(SAMPLE_PATH)['doa_jamming'])
    return doa_jamming

# get the doa_authentic
def get_doa_authentic():
    doa_authentic = []
    for i in range(1, NUM_SAMPLES+1):
        SAMPLE_PATH = doa_authentic_path + '/' + str(i) + '.mat'
        doa_authentic.append(scipy.io.loadmat(SAMPLE_PATH)['doa_authentic'])
    return doa_authentic

# get the amplitudes_authentic
def get_amplitudes_authentic():
    amplitudes_authentic = []
    for i in range(1, NUM_SAMPLES+1):
        SAMPLE_PATH = a_authentic_path + '/' + str(i) + '.mat'
        amplitudes_authentic.append(scipy.io.loadmat(SAMPLE_PATH)['amplitudes_authentic'])
    return amplitudes_authentic

# get the r_s
def get_r_s():
    r_s = []
    for i in range(1, NUM_SAMPLES+1):
        SAMPLE_PATH = r_s_path + '/' + str(i) + '.mat'
        r_s.append(scipy.io.loadmat(SAMPLE_PATH)['r_s'])
    return r_s


def get_data():
    r_t = get_r_t()
    # x_t = get_x_t()
    doa_spoofed = get_doa_spoofed()
    doa_jamming = get_doa_jamming()
    doa_authentic = get_doa_authentic()
    amplitudes_authentic = get_amplitudes_authentic()
    # r_s = get_r_s()
    return r_t, doa_spoofed, doa_jamming, doa_authentic, amplitudes_authentic

# split the data into training and testing
def split_data(r_t, y):
    x_train, x_test = r_t[:200], r_t[200:]
    y_train, y_test = y[:200], y[200:]
    return x_train, x_test, y_train, y_test
    


# define a CNN model that takes in the r_t and y_train
# each r_t is of shape (10, 38363)
# each y_train is of shape (13, 1)
def get_model():
    model = keras.Sequential(
    model.compile(optimizer='adam',
                  loss='sparse_categorical_crossentropy',
                  metrics=['accuracy'])
    return model


    


r_t, doa_spoofed, doa_jamming, doa_authentic, amplitudes_authentic = get_data()
print(r_t[0].shape)
print(doa_spoofed[0].shape)
print(doa_jamming[0].shape)
print(doa_authentic[0].shape)
print(amplitudes_authentic[0].shape)

# combine doa_spoofed, doa_jamming, doa_authentic, amplitudes_authentic into one array
y = []
for i in range(len(doa_spoofed)):
    y.append(doa_spoofed[i])
for i in range(len(doa_jamming)):
    y.append(doa_jamming[i])
for i in range(len(doa_authentic)):
    y.append(doa_authentic[i])
for i in range(len(amplitudes_authentic)):
    y.append(amplitudes_authentic[i])

# split the data into training and testing
x_train, x_test, y_train, y_test = split_data(r_t, y)

model = get_model()
model.fit(x_train, y_train, epochs=10)

test_loss, test_acc = model.evaluate(x_test, y_test, verbose=2)
print('\nTest accuracy:', test_acc)

model.save('model.h5')




