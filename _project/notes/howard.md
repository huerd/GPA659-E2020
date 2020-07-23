L2 - Loss
Bias
Label/Unlabeled
Feature
Noise
Weights
Learning Rate
Hyperparameters tuning - dependent on your data!
Batch Size
Epoch
Oscillations in learning rates
rmse [Root Mean Square Error (]
synthetic features
Correlation Matrix - indicates when attribute raw values relate to another -+0
Generalization
	- Overfitting
	- Data Splitting
	- training set
	- test set
	- validation set
Feature engineering
	Raw data
	Feature Vector
	Vocabulary
	OOV (out of vocab bucket)
	Encoding
		One hot
		multi hot
	Sparse/Dense Representations
Scaling
NaN [not a number]
Binning
Scrubbing
Feature cross
Stochastic Gradient Descent
Generalization Curve L2 regularlization
Lambda/Regularlization rate
Logistic Regression/Sigmoid function

Classification
	Threshold
	Confusion Matrix
	Acurracy
	Precision
	Recall
Receiver Operating Chracter Curve (ROC Curve)
AUC (Area under Curve)
Prediction Bias
Calibration Layer
L1 regularlization (regularlization for sparsity)

Neural Networks
Hidden layers
Activation function
	Sigmoid
	Rectified Linear Unit Relu
Training NN
	Backpropogation failure cases
		Vanishing gradients
		Exploding gradients	
		Dead ReLU
		Dropout Regularlization
One Vs All (Sigmoid)
Softmax
	Full vs Candidate

=======
Video 1 : What is a neural network https://www.youtube.com/watch?v=aircAruvnKk
1. understanding what basic neural networks are (multi layer perceptron)
	- example: detecting what number is written on a square (0-9)
	- first layer: each neuron holds a value from 0 to 1 (the number is its activation)
	- Hidden layers
		- edges
		- subcomponents (for example, a number 9 has a 1 and a top circle)
		- ? how does one activation layer affect the next one?
			- weights are used to detect the edges
			- a sigmoid function does this (weight and biases)
	- Last layer: **probability** of 0-1 of what the number of 0-9 was written.
	- ReLU is used now for activation function as opposed to sigmoid
	- What is learning : used to find the weights and biases
1. convolutional networks (for images)
Video 2: Gradient Descent : how NN learn : https://www.youtube.com/watch?v=IHZwWFHWa-w
- backpropagation
- cost of a difference
- we want to minimize the cost function
Video 3: what is backpropagation doing : https://www.youtube.com/watch?v=Ilg3gGewQ5U&list=PLZHQObOWTQDNU6R1_67000Dx_ZCJB-3pi&index=3
- used to calculate the gradient vector of our neural network
- three things we can change the chance of activation : bias, weights and previous function
- backpropagation is the algorithm to determine how a training example would nudge the weight and biases, in terms of relative proportional to those changes causes most rapid decrease to cost.
- mini batches and weights? to make it more effective
video 4 : backprop math : https://www.youtube.com/watch?v=tIeHLnjs5U8&list=PLZHQObOWTQDNU6R1_67000Dx_ZCJB-3pi&index=4
-

Tensorflow videos series
 Part 1 : https://www.youtube.com/watch?v=KNAWp2S3w94
 - neural networks are good for image to pixels
	- there are limitations : images had to be perfectly centered, etc
 - CNNS are good for features
	- it's used to first used to filter before training the NN
	- after filtering, the features within the images could come to the front and used to identity
	- pooling
		- the filters would then combine the results and group them, filtering it down to a subset and pick the largest
		- the image is reduced (ex from  4x4 down to 2x2, features are maintained)
		- this is called FEATURE EXTRACTION


=================================================
Localization is finding where in the image a certain object is, described by a bounding box. .
Classification is describing what the object in the image is. 
====================================
"MobileNets, a class of efficient models, are based on depthwise separable convolutions. This gives the model a chance to reduce the number of parameters required for convolutional operations thus reducing the size of the model!"
======================================
Over the course of multiple layers, it gradually builds up abstractions: first it detects edges, then it uses those edges to detect textures, the textures to detect patterns, and the patterns to detect parts of objects
============================

# Implementation

## Tools and frameworks
* Tensorflow
* Keras
* matplotlib (pyplot)