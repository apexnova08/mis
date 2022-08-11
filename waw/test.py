
import psutil
  
# check if chrome is open
print("main.exe" in (i.name() for i in psutil.process_iter()))
'''for i in psutil.process_iter():
    print(i.name())'''