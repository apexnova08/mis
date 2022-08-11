import mysql.connector
import sqlite3
import os
from datetime import date

#mycursor.execute("INSERT INTO mis.residents (resSName, resFName, resMName, resNameExt, resAge, resGender, resBirthDate, resBirthPlace, resCivilStatus, resCitizenship, resLot, resStreet, resHousehold, resPosition, resDateRegistered) VALUES ('epic', 'epic', 'epic', 'epic', '22', 'Male', '2022-4-21', 'Cavite', 'Single', 'Filipino', '225', 'Pangilinan', 'Palagud', 'Resident', '2020-10-21')")
#db.commit()


#mycursor.execute("SELECT * FROM residents")
#for x in mycursor:
#    print(x[1])

def login(username, password):
    return True

#def getResidents():
#    mycursor.execute("select * from residents")


#conn = sqlite3.connect("mis.db")
directory = os.getcwd() + "\mis\mis.db"
conn = sqlite3.connect(directory)
#print(directory)
    
d = date.today()
c = conn.cursor()
#c.execute("UPDATE activities SET aDate = '" + str(d) + "' WHERE aPK = " + str(1))
#c.execute("DELETE FROM complaints WHERE aresPK = 5")
#c.execute("INSERT INTO date_last (date) VALUES (2022-05-29)")
conn.commit()

'''c.execute("SELECT * FROM residents")
cursor = list(c)
c.execute("SELECT * FROM archived_residents")
for x in cursor:
    print(x)
print("very epic ||||||||||||")
for x in c:
    print(x)'''
#c.execute("SELECT * FROM residents")
#print(c.fetchall())
conn.close()