import requests
from datetime import date, timedelta
from bs4 import BeautifulSoup
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import re
import os 
import json

cred = credentials.Certificate(os.path.dirname(os.path.realpath(__file__))+"\covideemakerthon-firebase-adminsdk-dc85d-8b79d2065d.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://covideemakerthon-default-rtdb.firebaseio.com/'
})
startdate = date(2021, 3, 5)   # start date
enddate = date(2021, 4, 6)   # end date
malaymonth = ["januari", "februari", "mac", "april", "may", "jun","julai","ogos","september","oktober","november","disember"]
delta = enddate - startdate
for i in range(delta.days + 1):
    x = startdate + timedelta(days=i)
    url = "https://kpkesihatan.com/"+x.strftime("%Y")+"/"+ str(x.month) +"/"+x.strftime("%d")+"/kenyataan-akhbar-kpk-"+str(x.day)+"-"+malaymonth[x.month-1]+"-"+x.strftime("%Y")+"-situasi-semasa-jangkitan-penyakit-coronavirus-2019-covid-19-di-malaysia/"
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    f = soup.findAll("figure",{"class":"wp-block-table"})
    t = f[1].find("table")
    field = []
    test = t.findAll('tr')
    col = test[0].findAll('td')
    for c in col:
        tempstring = c.text.replace("\xa0","").replace(",","").replace("*","")
        tempstring = re.sub(r'\([^)]*\)', '', tempstring)
        field.append(tempstring)
    database = [] 
    test.pop(0)
    negeri = []
    for row in test:
        col = row.findAll('td')
        datum = {}
        numberdata = {}
        rec = []
        i=0
        for c in col:
            tempstring = c.text.replace("\xa0","").replace(",","").replace("*","")
            tempstring = re.sub(r'\([^)]*\)', '', tempstring)
            if i == 0:
                datum[field[i]] = tempstring
            else:
                numberdata[field[i]] = tempstring
            i=i+1
        if datum:
            datum["NumberOfCase"]=numberdata
            database.append(datum)
    ref = db.reference("/"+x.strftime("%Y")+"-"+ str(x.month) +"-"+x.strftime("%d")+"/")
    ref.set(json.dumps(database))




    