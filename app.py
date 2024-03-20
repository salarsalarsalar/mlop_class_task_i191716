from flask import Flask, request, jsonify
import pickle
import numpy as np

app = Flask(__name__)

# Load the trained model
with open('model.pkl', 'rb') as model_file:
    model = pickle.load(model_file)

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get data from request
        data = request.get_json()

        # Convert data to numpy array
        features = np.array(data['features']).reshape(1, -1)

        # Make prediction
        prediction = model.predict(features)

        # Return prediction as JSON
        return jsonify({'prediction': prediction[0]}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True)
