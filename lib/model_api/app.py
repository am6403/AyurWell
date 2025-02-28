import pickle
import numpy as np # type: ignore
from flask import Flask, request, jsonify # type: ignore
from flask_cors import CORS   # type: ignore

app = Flask(__name__)
CORS(app)  

# Load the model
with open("xgboost_models.pkl", "rb") as f:
    model = pickle.load(f)

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()
        
        features = np.array(data["features"]).reshape(1, -1)
        if features.shape[1] != 25:
            return jsonify({"error": "Expected 25 features, got " + str(features.shape[1])}), 400

        # Make prediction
        prediction = model.predict(features)

        # Debug: Print the prediction
        print(f"Received Input: {features.tolist()} → Prediction: {prediction[0]}")

        return jsonify({"dosha": int(prediction[0])})
    except Exception as e:
        print(f"Error during prediction: {e}")
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
