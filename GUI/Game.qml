import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    property int mines: parseInt(choice.mines)
    property int rows: parseInt(choice.rows)
    property int columns: parseInt(choice.columns)
    property int remFlags: parseInt(choice.mines)
    property string colorOne: "#0B0CA5"
    property string colorTwo: "#147116"
    property string colorThree: "#A92322"
    property string colorFour: "#080846"
    property string colorFive: "#4D1514"
    property string colorSix: "#1F7373"
    property string colorSeven: "#000000"
    property string colorEight: "#808080"
    property string backgroundColorPressed: "#D1D1D1"
    property string backgroundColorNotPressed: "#F4F4F4"
    property int m: 0
    property int n: 0
    SecondCounter{
        id: secondCounter
    }

//    property string rows:console.log(easybutton.rows)
//    property string collums:console.log(easybutton.colums)

    id: rectID
    height: parent.height
    width: parent.width
    visible: true
    color: "#303030"
    //NameInputWindow{
        //visible: true
    //}
    AndroidToolbar{
        id: toolbar_game
        BackButton{
            id: backButton
            onClicked:{
                gridid.moves=0
                stack.pop(stack.get(0))
            }
        }
        Rectangle{
            border.color: parent.color
            border.width: parent.height*0.03
            radius: 6
            color: "#303030"
            anchors.left: backButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: height*1.4
            Text{
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.7
                text: remFlags.toString()
                color: "white"
                font.family: "droid-sans-mono"
            }
        }
        Button{
            id: resetButton
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height
            width: height
            anchors.margins: width*0.05


            Text{
                id: resetText
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height
                text: "😏"
                font.pixelSize: parent.height*0.75
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked:{
                for (m = 0; m < gridid.rows; m++) {
                    for (n = 0; n < gridid.columns; n++) {
                        repeaterId.itemAt(m*columns+n).reset();
                    }
                }
                gridid.moves=0
                secondCounter.seconds = 0;
                secondCounter.start();
                mineField.initField(columns, rows, mines);
                resetText.text = "😏";
                remFlags = mines;
            }

        }
        Rectangle{
            border.color: parent.color
            border.width: parent.height*0.03
            radius: 6
            color: "#303030"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: backButton.width
            width: height*1.4
            Text{
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.7
                text: secondCounter.seconds
                color: "white"
                font.family: "droid-sans-mono"
            }
        }
    }

    ScrollView {
        anchors.top: toolbar_game.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: parent.width*0.01
        Grid{
            property int moves: 0
            id: gridid
            anchors.top: parent.top
            spacing: parent.width*0.001
            columns: rectID.columns
            rows: rectID.rows
            Repeater{
                id: repeaterId
                model:gridid.rows*gridid.columns
                onItemAdded:{
                    itemAt(index).x_position = index/gridid.columns
                    itemAt(index).y_position = index % gridid.columns
                }
                CellBlock{
                }
            }
        }
    }
}
