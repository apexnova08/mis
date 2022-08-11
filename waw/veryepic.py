import sys
import os

import connector
import gui
import PySide6

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

if __name__ == "__main__":
    os.environ["QT_QUICK_BACKEND"] = "software"
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    windLogin = gui.Backend()
    engine.rootContext().setContextProperty("backend", windLogin)

    engine.load(os.path.join(os.path.dirname(__file__), "qml/app.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())