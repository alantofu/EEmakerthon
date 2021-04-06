import requests
from datetime import date, timedelta
from bs4 import BeautifulSoup
import firebase_admin
from firebase_admin import credentials
import re

startdate = date(2021, 4, 6)   # start date
enddate = date(2021, 4, 7)   # end date
malaymonth = ["januari", "februari", "mac", "april", "may", "jun","julai","ogos","september","oktober","november","disember"]
delta = enddate - startdate
for i in range(delta.days + 1):
    x = startdate + timedelta(days=i)
    value = str(x.month) if len(str(x.month))>1 else "0" +str(x.month)
    url = "https://kpkesihatan.com/"+x.strftime("%Y")+"/"+ value +"/"+x.strftime("%d")+"/kenyataan-akhbar-kpk-"+str(x.day)+"-"+malaymonth[x.month-1]+"-"+x.strftime("%Y")+"-situasi-semasa-jangkitan-penyakit-coronavirus-2019-covid-19-di-malaysia/"
    response = requests.get(url)
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
    