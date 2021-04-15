import requests
from datetime import date, timedelta
from bs4 import BeautifulSoup
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import re
import os 
import json

# cred = credentials.Certificate(os.path.dirname(os.path.realpath(__file__))+"\covideemakerthon-firebase-adminsdk-dc85d-8b79d2065d.json")
# firebase_admin.initialize_app(cred, {
#     'databaseURL': 'https://covideemakerthon-default-rtdb.firebaseio.com/'
# })
cred = credentials.Certificate(os.path.dirname(os.path.realpath(__file__))+"\e-makerthon-68e65-firebase-adminsdk-4xcqw-8ebcc43b83.json")
firebase_admin.initialize_app(cred)
d_store = firestore.client()
startdate = date(2021, 1, 5)   # start date
enddate = date(2021, 4, 6)   # end date
malaymonth = ["januari", "februari", "mac", "april", "may", "jun","julai","ogos","september","oktober","november","disember"]
delta = enddate - startdate
for i in range(delta.days + 1):
    x = startdate + timedelta(days=i)
    try:
        url = "https://kpkesihatan.com/"+x.strftime("%Y")+"/"+ str(x.month) +"/"+x.strftime("%d")+"/kenyataan-akhbar-kpk-"+str(x.day)+"-"+malaymonth[x.month-1]+"-"+x.strftime("%Y")+"-situasi-semasa-jangkitan-penyakit-coronavirus-2019-covid-19-di-malaysia/"
        response = requests.get(url)
        if "200" in str(response):
            soup = BeautifulSoup(response.text, 'html.parser')
            f = soup.findAll("figure",{"class":"wp-block-table"})
            if len(f)>1:
                t = f[1].find("table")
                field = []
                test = t.findAll('tr')
                database = {}
                col = test[0].findAll('td')
                for c in col:
                    tempstring = c.text.replace("\xa0","").replace(",","").replace("*","")
                    tempstring = tempstring.replace("$","").replace("#","").strip().replace(" ","_")
                    tempstring = re.sub(r'\([^)]*\)', '', tempstring)
                    field.append(tempstring)
                test.pop(0)
                for row in test:
                    col = row.findAll('td')
                    datum = {}
                    numberdata = {}
                    rec = []
                    i=0
                    currentstate = ""
                    for c in col:
                        tempstring = c.text.replace("\xa0","").replace(",","").replace("*","").strip().replace(" ","_")
                        tempstring = re.sub(r'\([^)]*\)', '', tempstring)
                        tempstring = tempstring.rstrip("_")
                        print(tempstring)
                        if i == 0:
                            currentstate = tempstring
                        else:
                            numberdata[field[i]] = tempstring
                        i=i+1
                    database[currentstate] = numberdata
                #ref = db.reference("/"+x.strftime("%Y")+"-"+ str(x.month) +"-"+x.strftime("%d")+"/")
                d_store.collection("CovidNumbersPerState").document(x.strftime("%Y")+"-"+ str(x.month) +"-"+x.strftime("%d")).set(json.loads(json.dumps(database)))
                #ref.set()
            else:
                print("no table is found")
    except Exception as e:
        print(x.strftime("%Y")+"-"+ str(x.month) +"-"+x.strftime("%d"))
        print(str(e))




    