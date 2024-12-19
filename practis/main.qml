import QtQuick 6.8
import QtQuick.Controls 6.8

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Application"
    color: "#FAFAD2"

    Column{
        spacing: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Label{
            id: question
            anchors.horizontalCenter: parent.horizontalCenter

            color: "#191970"
            text: ""
           
            font.pixelSize: 24
            font.bold: true
            width: 500
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Row{
            spacing: 20

            anchors.horizontalCenter: parent.horizontalCenter
            Button{
                id: button1
                text: ""
                font.pixelSize: 28
                onClicked: backend.check_answer(button1.text, 1)
                background:Rectangle{
                    color: "#000"
                }
                
                
            }

            Button{
                id: button2
                text: ""
                font.pixelSize: 28
                onClicked: backend.check_answer(button2.text, 2)
                background:Rectangle{
                    color: "#000"
                }
                
            }
        }
        Row{
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            Button{
                id: button3
                text: ""
                font.pixelSize: 28
                onClicked: backend.check_answer(button3.text, 3)
                background:Rectangle{
                    color: "#000" 
                }           
                
            }

            Button{
                id: button4
                text: ""
                font.pixelSize: 28
                onClicked: backend.check_answer(button4.text, 4)
                background:Rectangle{
                    color: "#000" 
                }   
            }
        }

    }

    Component.onCompleted:{
        backend.new_question.connect(onNewQuestion)
        backend.get_new_question()
        backend.answered.connect(onAnswered)
    }
    
    function onAnswered(isRight, buttonNum){
        if (buttonNum == 1){
            if (isRight){
                button1.background.color = "green"
            }else{
                button1.background.color = "red"
            }
        }
        if (buttonNum == 2){
            if (isRight){
                button2.background.color = "green"
            }else{
                button2.background.color = "red"
            }
        }
        if (buttonNum == 3){
            if (isRight){
                button3.background.color = "green"
            }else{
                button3.background.color = "red"
            }
        }
        if (buttonNum == 4){
            if (isRight){
                button4.background.color = "green"
            }else{
                button4.background.color = "red"
            }
        }
    }

    function onNewQuestion(questionText,answersList){
        button1.background.color = "#FFF5EE"
        button2.background.color = "#FFF5EE"
        button3.background.color = "#FFF5EE"
        button4.background.color = "#FFF5EE"
        question.text = questionText
        button1.text = answersList[0]
        button2.text = answersList[1]
        button3.text = answersList[2]
        button4.text = answersList[3]
    }
}


