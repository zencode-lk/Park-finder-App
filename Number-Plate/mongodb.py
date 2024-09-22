import pymongo
import json



from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi

uri = 'mongodb+srv://vidundesu:ANmyfBkf2Fnlnngj@parkfinder.jdubhbw.mongodb.net/parkFinderDb?retryWrites=true&w=majority&appName=parkFinder'

# Create a new client and connect to the server
client = MongoClient(uri, server_api=ServerApi('1'))

# Send a ping to confirm a successful connection
try:
    client.admin.command('ping')
    print("Pinged your deployment. You successfully connected to MongoDB!")
except Exception as e:
    print(e)

