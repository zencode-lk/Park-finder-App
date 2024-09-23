
import cv2
import os
import time
import easyocr
import pymongo
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from datetime import datetime, timedelta  # Import datetime module

# MongoDB connection setup
uri = "mongodb+srv://vidundesu:ANmyfBkf2Fnlnngj@parkfinder.jdubhbw.mongodb.net/?retryWrites=true&w=majority&appName=parkFinder"
client = MongoClient(uri, server_api=ServerApi('1'))

# MongoDB database and collection
db = client['parkFinderDb']
collection = db['parkingEvents']

# Function to log data to MongoDB
def log_to_mongodb(data):
    try:
        collection.insert_one(data)
        print(f"Logged to MongoDB: {data}")
    except Exception as e:
        print(f"Failed to log to MongoDB: {e}")

#E:\Pthon projects\Number-Plate\model\haarcascade_russian_plate_number.xml

#harcascade = "model/haarcascade_russian_plate_number.xml"
harcascade = "E:/Pthon projects/Number-Plate/model/haarcascade_russian_plate_number.xml"


cap = cv2.VideoCapture(0)

cap.set(3, 1920)  # width
cap.set(4, 1080)  # height

min_area = 500
capture_count = 0
last_plate_time = 0
last_plate = None   
sentPlate = None 

reader = easyocr.Reader(['en'])

# Ensure the plates directory exists
if not os.path.exists('plates'):
    os.makedirs('plates')

def ocr_image(image_path):
    result = reader.readtext(image_path)
    detected_text = [item[1] for item in result]
    return detected_text

cv2.namedWindow("Result", cv2.WINDOW_NORMAL)

while True:
    success, img = cap.read()

    plate_cascade = cv2.CascadeClassifier(harcascade)
    img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    plates = plate_cascade.detectMultiScale(img_gray, 1.1, 4)

    current_time = time.time()
    plate_detected = False

    for (x, y, w, h) in plates:
        area = w * h

        if area > min_area:
            plate_detected = True
            cv2.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 2)
            cv2.putText(img, "Number Plate", (x, y - 5), cv2.FONT_HERSHEY_COMPLEX_SMALL, 1, (255, 0, 255), 2)

            img_roi = img[y: y + h, x: x + w]
            cv2.imshow("ROI", img_roi)
            time.sleep(2)

            if capture_count < 2 and (current_time - last_plate_time > 1):
                image_path = f"plates/scanned_img_{current_time}.jpg"
                cv2.imwrite(image_path, img_roi)
                capture_count += 1
                last_plate_time = current_time

                # OCR result
                ocr_result = ocr_image(image_path)
                print(f"Detected Number plate : {ocr_result}")


                if ocr_result:
                    detected_data = {
                        "number_plate": ocr_result[0],
                        "detected_time": datetime.fromtimestamp(current_time).strftime('%Y-%m-%d %H:%M:%S'),
                        "detected_timestamp": current_time,  # Unix timestamp for duration calculation
                        "camera_location": "Slot_A"  # Adjust this as needed
                    }
                    log_to_mongodb(detected_data)
                    sentPlate = ocr_result[0]
                    last_plate = detected_data

    # Check for undetected plate
    if not plate_detected and last_plate is not None and last_plate['number_plate'] == sentPlate:
        if current_time - last_plate_time > 5:
            print(f"Undetected Number plate: {last_plate['number_plate']}, {current_time}")

            duration_seconds = current_time - last_plate["detected_timestamp"]
            duration_readable = str(timedelta(seconds=duration_seconds))

            undetected_number = {
                "number_plate": last_plate['number_plate'],
                "undetected_time": datetime.fromtimestamp(current_time).strftime('%Y-%m-%d %H:%M:%S'),
                "duration": duration_readable,
                "camera_location": "Slot_A"
            }

            log_to_mongodb(undetected_number)

            capture_count = 0
            last_plate = None
            sentPlate = None



    cv2.imshow("Result", img)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
