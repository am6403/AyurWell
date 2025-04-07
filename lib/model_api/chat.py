
# #corrected one
# from flask import Flask, request, jsonify
# from flask_cors import CORS
# import nltk

# # Download necessary NLTK data files
# nltk.download('punkt')
# nltk.download('stopwords')

# app = Flask(__name__)
# CORS(app)  # Enable CORS to allow requests from the Flutter app

# # Define chatbot topics and their respective questions
# chatbot_topics = {
#     "App Features": [
#         "What is your name?",
#         "How can I book an appointment?",
#         "How can I reset my quiz result?",
#         "What is the purpose of this app?",
#         "How can I contact a doctor?",
#         "What is the Prakriti Quiz?",
#     ],
#     "Ayurveda Basics": [
#         "What is Ayurveda?",
#         "What are the types of doshas?",
#         "How can I find my dosha?",
#     ],
#     "Dosha Details": [
#         "What is Vata dosha?",
#         "What is Pitta dosha?",
#         "What is Kapha dosha?",
#     ],
#     "Remedies for Doshas": [
#         "What are some remedies for Vata dosha?",
#         "What are some remedies for Pitta dosha?",
#         "What are some remedies for Kapha dosha?",
#     ],
#     "Yoga Recommendations": [
#         "What yoga is suitable for Vata dosha?",
#         "What yoga is suitable for Pitta dosha?",
#         "What yoga is suitable for Kapha dosha?",
#     ],
#     "Diet Recommendations": [
#         "What diet is suitable for Vata dosha?",
#         "What diet is suitable for Pitta dosha?",
#         "What diet is suitable for Kapha dosha?",
#     ],
#     "Exercise Recommendations": [
#         "What exercise is suitable for Vata dosha?",
#         "What exercise is suitable for Pitta dosha?",
#         "What exercise is suitable for Kapha dosha?",
#     ],
#     "Doctor-Related Questions": [
#         "How many doctors are there in this app?",
#         "Name the doctors in this app?",
#         "Who are the doctors available?",
#         "Where can I find Doctor Durgesh?",
#         "Where can I find Doctor Devansh?",
#         "Where can I find Doctor Gairk?",
#     ],
#     "Additional Ayurveda Questions": [
#         "What are some common Ayurvedic herbs?",
#         "What is Panchakarma?",
#         "What is the role of meditation in Ayurveda?",
#     ],
# }

# # Define answers for each question
# chatbot_answers = {
#     "What is your name?": "I am AyurWell Chatbot, here to assist you!",
#     "How can I book an appointment?": "You can book an appointment by navigating to the 'Doctors' section.",
#     "How can I reset my quiz result?": "You can reset your quiz result by navigating to the Profile section and clicking 'Reset Quiz Result'.",
#     "What is the purpose of this app?": "This app helps you discover your Ayurvedic constitution, find remedies, and connect with doctors.",
#     "How can I contact a doctor?": "You can contact a doctor by navigating to the 'Doctors' section in the app.",
#     "What is the Prakriti Quiz?": "The Prakriti Quiz helps determine your Ayurvedic constitution (Vata, Pitta, or Kapha).",
#     "What is Ayurveda?": "Ayurveda is an ancient Indian system of medicine that promotes holistic health.",
#     "What are the types of doshas?": "The three doshas in Ayurveda are Vata, Pitta, and Kapha.",
#     "How can I find my dosha?": "You can find your dosha by taking the Prakriti Quiz in the app.",
#     "What is Vata dosha?": "Vata dosha governs movement in the body and is associated with air and space elements.",
#     "What is Pitta dosha?": "Pitta dosha governs digestion and metabolism and is associated with fire and water elements.",
#     "What is Kapha dosha?": "Kapha dosha governs structure and lubrication and is associated with earth and water elements.",
#     "What are some remedies for Vata dosha?": "For Vata dosha, warm and grounding foods, regular routines, and oil massages are recommended.",
#     "What are some remedies for Pitta dosha?": "For Pitta dosha, cooling foods, avoiding spicy meals, and practicing calming activities are recommended.",
#     "What are some remedies for Kapha dosha?": "For Kapha dosha, light and spicy foods, regular exercise, and avoiding heavy meals are recommended.",
#     "What yoga is suitable for Vata dosha?": "Gentle and grounding yoga poses like Child's Pose and Mountain Pose are suitable for Vata dosha.",
#     "What yoga is suitable for Pitta dosha?": "Cooling and calming yoga poses like Forward Fold and Moon Salutation are suitable for Pitta dosha.",
#     "What yoga is suitable for Kapha dosha?": "Energizing and stimulating yoga poses like Sun Salutation and Warrior Pose are suitable for Kapha dosha.",
#     "What diet is suitable for Vata dosha?": "For Vata dosha, eat warm, moist, and grounding foods like soups, stews, and cooked grains.",
#     "What diet is suitable for Pitta dosha?": "For Pitta dosha, eat cooling foods like cucumbers, melons, and leafy greens while avoiding spicy and oily foods.",
#     "What diet is suitable for Kapha dosha?": "For Kapha dosha, eat light, dry, and spicy foods like lentils, ginger, and chili peppers while avoiding heavy and oily foods.",
#     "What exercise is suitable for Vata dosha?": "Gentle and grounding exercises like walking, yoga, and tai chi are suitable for Vata dosha.",
#     "What exercise is suitable for Pitta dosha?": "Moderate and cooling exercises like swimming, cycling, and yoga are suitable for Pitta dosha.",
#     "What exercise is suitable for Kapha dosha?": "Energizing and stimulating exercises like running, aerobics, and strength training are suitable for Kapha dosha.",
#     "How many doctors are there in this app?": "There are 3 doctors in this app: Dr. Durgesh, Dr. Devansh, and Dr. Gairk.",
#     "Name the doctors in this app?": "The doctors in this app are Dr. Durgesh, Dr. Devansh, and Dr. Gairk.",
#     "Who are the doctors available?": "The available doctors are Dr. Durgesh, Dr. Devansh, and Dr. Gairk.",
#     "Where can I find Doctor Durgesh?": "You can find Dr. Durgesh at Durgasamy Clinic.",
#     "Where can I find Doctor Devansh?": "You can find Dr. Devansh at AyurWell Clinic.",
#     "Where can I find Doctor Gairk?": "You can find Dr. Gairk at AyushCare Clinic.",
#     "What are some common Ayurvedic herbs?": "Some common Ayurvedic herbs are Ashwagandha, Turmeric, Tulsi, and Triphala.",
#     "What is Panchakarma?": "Panchakarma is a detoxification process in Ayurveda that includes therapies like Vamana, Virechana, Basti, Nasya, and Raktamokshana.",
#     "What is the role of meditation in Ayurveda?": "Meditation helps balance the mind and body, reducing stress and promoting overall well-being in Ayurveda.",
# }

# @app.route('/topics', methods=['GET'])
# def get_topics():
#     """Return the list of topics."""
#     return jsonify({"topics": list(chatbot_topics.keys())})

# @app.route('/questions', methods=['POST'])
# def get_questions():
#     """Return the list of questions for a selected topic."""
#     data = request.get_json()
#     topic = data.get("topic", "")
#     questions = chatbot_topics.get(topic, [])
#     return jsonify({"questions": questions})

# @app.route('/answer', methods=['POST'])
# def get_answer():
#     """Return the answer for a selected question."""
#     data = request.get_json()
#     question = data.get("question", "").strip()

#     if question in chatbot_answers:
#         # If the question is in the predefined answers, return the answer
#         return jsonify({"response": chatbot_answers[question]})
#     else:
#         # Default response for unknown questions
#         return jsonify({"response": "I'm sorry, I don't understand that. Please ask a valid question."})

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=5000, debug=True)



from flask import Flask, request, jsonify
from flask_cors import CORS
import nltk
from nltk.chat.util import Chat, reflections
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
import string

# Download necessary NLTK data files
nltk.download('punkt')
nltk.download('stopwords')

app = Flask(__name__)
CORS(app)

# Define chatbot topics and their respective questions
chatbot_topics = {
    "App Features": [
        "what is your name?",
        "how can I book an appointment?",
        "how can I reset my quiz result?",
        "what is the purpose of this app?",
        "how can I contact a doctor?",
        "what is the Prakriti Quiz?",
    ],
    "Ayurveda Basics": [
        "what is Ayurveda?",
        "what are the types of doshas?",
        "how can I find my dosha?",
    ],
    "Dosha Details": [
        "what is Vata dosha?",
        "what is Pitta dosha?",
        "what is Kapha dosha?",
    ],
    "Remedies for Doshas": [
        "what are some remedies for Vata dosha?",
        "what are some remedies for Pitta dosha?",
        "what are some remedies for Kapha dosha?",
    ],
    "Yoga Recommendations": [
        "what yoga is suitable for Vata dosha?",
        "what yoga is suitable for Pitta dosha?",
        "what yoga is suitable for Kapha dosha?",
    ],
    "Diet Recommendations": [
        "what diet is suitable for Vata dosha?",
        "what diet is suitable for Pitta dosha?",
        "what diet is suitable for Kapha dosha?",
    ],
    "Exercise Recommendations": [
        "what exercise is suitable for Vata dosha?",
        "what exercise is suitable for Pitta dosha?",
        "what exercise is suitable for Kapha dosha?",
    ],
    "Doctor-Related Questions": [
        "how many doctors are there in this app?",
        "name the doctors in this app?",
        "who are the doctors available?",
        "where can I find doctor Durgesh?",
        "where can I find doctor Devansh?",
        "where can I find doctor Gairk?",
    ],
    "Additional Ayurveda Questions": [
        "what are some common Ayurvedic herbs?",
        "what is Panchakarma?",
        "what is the role of meditation in Ayurveda?",
    ],
}


chatbot_pairs = [
    (r"hi|hello|hey", [
        "Hello! Please choose a topic:\n"
        "1. App Features\n"
        "2. Ayurveda Basics\n"
        "3. Dosha Details\n"
        "4. Remedies for Doshas\n"
        "5. Yoga Recommendations\n"
        "6. Diet Recommendations\n"
        "7. Exercise Recommendations\n"
        "8. Doctor-Related Questions\n"
        "9. Additional Ayurveda Questions.\n"
    ]),
    (r"app features", [
        "Here are some questions you can ask:\n"
        "- What is your name?\n"
        "- How can I book an appointment?\n"
        "- How can I reset my quiz result?\n"
        "- What is the purpose of this app?\n"
        "- How can I contact a doctor?\n"
        "- What is the Prakriti Quiz?"
    ]),
    (r"what is your name", ["I am AyurWell Chatbot, here to assist you!"]),
(r"how can i book an appointment", [
    "You can book an appointment by navigating to the 'Doctors' section."
]),
(r"how can i reset my quiz result", [
    "You can reset your quiz result by navigating to the Profile section and clicking 'Reset Quiz Result'."
]),
(r"what is the purpose of this app", [
    "This app helps you discover your Ayurvedic constitution, find remedies, and connect with doctors."
]),
(r"how can i contact a doctor", [
    "You can contact a doctor by navigating to the 'Doctors' section in the app."
]),
(r"what is the prakriti quiz", [
    "The Prakriti Quiz helps determine your Ayurvedic constitution (Vata, Pitta, or Kapha)."
]),
(r"ayurveda basics", [
    "Here are some questions you can ask:\n"
    "- What is Ayurveda?\n"
    "- What are the types of doshas?\n"
    "- How can I find my dosha?"
]),
(r"what is ayurveda", [
    "Ayurveda is an ancient Indian system of medicine that promotes holistic health."
]),
(r"what are the types of doshas", [
    "The three doshas in Ayurveda are Vata, Pitta, and Kapha."
]),
(r"how can i find my dosha", [
    "You can find your dosha by taking the Prakriti Quiz in the app."
]),
(r"dosha details", [
    "Here are some questions you can ask:\n"
    "- What is Vata dosha?\n"
    "- What is Pitta dosha?\n"
    "- What is Kapha dosha?"
]),
(r"what is vata dosha", [
    "Vata dosha governs movement in the body and is associated with air and space elements."
]),
(r"what is pitta dosha", [
    "Pitta dosha governs digestion and metabolism and is associated with fire and water elements."
]),
(r"what is kapha dosha", [
    "Kapha dosha governs structure and lubrication and is associated with earth and water elements."
]),
(r"remedies for doshas", [
    "Here are some questions you can ask:\n"
    "- What are some remedies for Vata dosha?\n"
    "- What are some remedies for Pitta dosha?\n"
    "- What are some remedies for Kapha dosha?"
]),
(r"what are some remedies for vata dosha", [
    "For Vata dosha, warm and grounding foods, regular routines, and oil massages are recommended."
]),
(r"what are some remedies for pitta dosha", [
    "For Pitta dosha, cooling foods, avoiding spicy meals, and practicing calming activities are recommended."
]),
(r"what are some remedies for kapha dosha", [
    "For Kapha dosha, light and spicy foods, regular exercise, and avoiding heavy meals are recommended."
]),
(r"yoga recommendations", [
    "Here are some questions you can ask:\n"
    "- What yoga is suitable for Vata dosha?\n"
    "- What yoga is suitable for Pitta dosha?\n"
    "- What yoga is suitable for Kapha dosha?"
]),
(r"what yoga is suitable for vata dosha", [
    "Gentle and grounding yoga poses like Child's Pose and Mountain Pose are suitable for Vata dosha."
]),
(r"what yoga is suitable for pitta dosha", [
    "Cooling and calming yoga poses like Forward Fold and Moon Salutation are suitable for Pitta dosha."
]),
(r"what yoga is suitable for kapha dosha", [
    "Energizing and stimulating yoga poses like Sun Salutation and Warrior Pose are suitable for Kapha dosha."
]),
(r"diet recommendations", [
    "Here are some questions you can ask:\n"
    "- What diet is suitable for Vata dosha?\n"
    "- What diet is suitable for Pitta dosha?\n"
    "- What diet is suitable for Kapha dosha?"
]),
(r"what diet is suitable for vata dosha", [
    "For Vata dosha, eat warm, moist, and grounding foods like soups, stews, and cooked grains."
]),
(r"what diet is suitable for pitta dosha", [
    "For Pitta dosha, eat cooling foods like cucumbers, melons, and leafy greens while avoiding spicy and oily foods."
]),
(r"what diet is suitable for kapha dosha", [
    "For Kapha dosha, eat light, dry, and spicy foods like lentils, ginger, and chili peppers while avoiding heavy and oily foods."
]),
    (r"(.*)", ["I'm sorry, I didn't understand that. Could you rephrase?"]),
]

# Initialize the chatbot
chatbot = Chat(chatbot_pairs, reflections)

def preprocess_message(message):
    tokens = word_tokenize(message)
    tokens = [word.lower() for word in tokens]
    table = str.maketrans('', '', string.punctuation)
    tokens = [word.translate(table) for word in tokens]
    tokens = [word for word in tokens if word.isalpha()]
    return ' '.join(tokens)  # Return a cleaned string

@app.route('/chat', methods=['POST'])
def chat():
    try:
        data = request.get_json()
        user_message = data.get("message", "").lower()
        print(f"User message: {user_message}")  # Debug log

        processed_message = preprocess_message(user_message)
        print(f"Processed message: {processed_message}")  # Debug log

        response = chatbot.respond(processed_message)
        print(f"Chatbot response: {response}")  # Debug log

        if response is None:
            response = "I'm sorry, I didn't understand that. Could you rephrase?"

        return jsonify({"response": response})
    except Exception as e:
        print(f"Error during chatbot interaction: {e}")
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)