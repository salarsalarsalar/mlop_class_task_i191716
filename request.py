import requests

# Data for prediction
data = {'features': [1, 2, 3, 4, 5]}  # Example features

# Send POST request to the Flask endpoint
response = requests.post('http://127.0.0.1:5000/predict', json=data)

# Print prediction
print(response.json())
