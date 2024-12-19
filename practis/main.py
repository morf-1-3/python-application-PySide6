import sys
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal,QTimer
import random
import requests
URL = "https://the-trivia-api.com/v2/questions?limit=1"

class Backend(QObject):    
    new_question = Signal(str, list)
    answered = Signal(bool,int)


    def __init__(self):
        super().__init__()
        self.correct_answer = None
        
        self.timer = QTimer()
        self.timer.timeout.connect(self.get_new_question)
        self.get_new_question()

    @Slot(str,int)
    def check_answer(self,answer_text:str, button_num:int):
        if answer_text == self.correct_answer:
            self.answered.emit(True,button_num)
        else:
            self.answered.emit(False,button_num)
        self.timer.start(1000)



    @Slot()
    def get_new_question(self):
        
        response = requests.request("GET",URL)
        data = response.json()
        question = data[0]
       
        question_text = question["question"]["text"]
        self.correct_answer = question["correctAnswer"]
        answers_list = question["incorrectAnswers"]
        answers_list.append(self.correct_answer)
        random.shuffle(answers_list)
        self.new_question.emit(question_text,answers_list)
        
        if self.timer.isActive():
            self.timer.stop()



def main():
        
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine() 

    backend = Backend()
    engine.rootContext().setContextProperty("backend",backend)

    engine.load("practis/main.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())


if __name__ == "__main__":
    main()


 