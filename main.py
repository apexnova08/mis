import sys
import os
import psutil

import gui

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

def LaunchApp():
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    windLogin = gui.Backend()
    engine.rootContext().setContextProperty("backend", windLogin)

    engine.load(os.path.join(os.path.dirname(__file__), "qml/app.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())

def AlreadyRunning():
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    engine.load(os.path.join(os.path.dirname(__file__), "qml/alreadyRunning.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())

if __name__ == "__main__":
    x = 0
    for i in psutil.process_iter():
        if ("main.exe" == i.name()):
            x = x + 1
    if (x <= 1):
        gui.Daily()
        LaunchApp()
    else:
        AlreadyRunning()