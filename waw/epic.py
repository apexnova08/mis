import sys
import os

import connector
import gui
import PySide6

import PySide6.QtWidgets
import PySide6.QtCore
from PySide6.QtQml import QQmlApplicationEngine

if __name__ == "__main__":
    PySide6.QtCore.QCoreApplication.setAttribute(PySide6.QtCore.Qt.AA_UseOpenGLES)
    app = PySide6.QtWidgets.QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    windLogin = gui.Backend()
    engine.rootContext().setContextProperty("backend", windLogin)

    engine.load(os.path.join(os.path.dirname(__file__), "qml/app.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())