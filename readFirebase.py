import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from datetime import date, timedelta
import os 
import json

cred = credentials.Certificate(os.path.dirname(os.path.realpath(__file__))+"\covideemakerthon-firebase-adminsdk-dc85d-8b79d2065d.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://covideemakerthon-default-rtdb.firebaseio.com/'
})
startdate = date(2021, 4, 5)   # start date
enddate = date(2021, 4, 6)   # end date
delta = enddate - startdate
for i in range(delta.days + 1):
    x = startdate + timedelta(days=i)
    ref = db.reference("/"+x.strftime("%Y")+"-"+ str(x.month) +"-"+x.strftime("%d")+"/")
    data  = json.loads(ref.get())
    for states in data:
        for numberdata in states['NEGERI']
            print(numberdata[])
    #print(data[1]['NEGERI'])