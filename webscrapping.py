import requests
from datetime import date, timedelta
from bs4 import BeautifulSoup
import firebase_admin
from firebase_admin import credentials
import re
import os 

cred = credentials.Certificate(os.path.dirname(os.path.realpath(__file__))+"\covideemakerthon-firebase-adminsdk-dc85d-8b79d2065d.json")
firebase_admin.initialize_app(cred)
startdate = date(2021, 4, 5)   # start date
enddate = date(2021, 4, 6)   # end date
malaymonth = ["januari", "februari", "mac", "april", "may", "jun","julai","ogos","september","oktober","november","disember"]
delta = enddate - startdate
for i in range(delta.days + 1):
    x = startdate + timedelta(days=i)
    url = "https://kpkesihatan.com/"+x.strftime("%Y")+"/"+ str(x.month) +"/"+x.strftime("%d")+"/kenyataan-akhbar-kpk-"+str(x.day)+"-"+malaymonth[x.month-1]+"-"+x.strftime("%Y")+"-situasi-semasa-jangkitan-penyakit-coronavirus-2019-covid-19-di-malaysia/"
    response = requests.get(url)
    print(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    f = soup.findAll("figure",{"class":"wp-block-table"})
    t = f[1].find("table")
    db = [] # Create an empty place holder to save all the records(or rows)
    for row in t.findAll('tr'):
        col = row.findAll('td')
        rec = []
        for c in col:
            tempstring = c.text.replace("\xa0","").replace(",","").replace("*","")
            tempstring = re.sub(r'\([^)]*\)', '', tempstring)
            rec.append(tempstring)
        db.append(rec)



    