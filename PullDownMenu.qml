import QtQuick 2.0

Rectangle{
    id:pullDowm

    property string colorPropertyBlack: "#8e8a8e"
    property string colorPropertyRed: "white"
    property string colorPropertyGreen: "white"
    property string colorPropertyBlue: "white"

    property int slideX: 0
    property int slideStartY: 0
    property int slideEndY: 0

    property alias secondButton: secondButton
    property alias thirdButton: thirdButton
    property alias fourthButton: fourthButton
    property alias fifthButton: fifthButton

    property string textFifth: textFifth
    property string textFourth: testFourth
    property string textThird: thirdFirst
    property string textSecond: textSecond
    property string textFirst: textFirst

    border.color: "black"
    border.width: 1
    Rectangle{
        id:first
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height/5
        color:"black"
        border.color: firstButton.pressed?"white":"black"
        border.width: 2
        TextComponent{
            anchors.fill: parent
            textComponent:textFirst
        }
        MouseArea{
            id:firstButton
            anchors.fill: parent
            onClicked: pullDowm.state=(pullDowm.state==="State2")?"State1":"State2"
        }
    }
    Rectangle{
        id:second
        anchors.bottom: first.top
        width: parent.width
        height: parent.height/5
        color: colorPropertyBlack
        border.color: "black"
        border.width: 1
        Text {
            text: textSecond
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pixelSize: 20
            font.family: "Microsoft New Tai Lue"
            font.bold: true
            anchors.fill: parent
        }
        MouseArea{
            id:secondButton
            anchors.fill: parent
            onClicked: {
                if(colorPropertyBlack==="white")
                {
                    colorPropertyBlack="#8e8a8e"
                    colorPropertyRed="white"
                    colorPropertyGreen="white"
                    colorPropertyBlue="white"
                }
                else if(colorPropertyRed==="white"|| colorPropertyGreen==="white"||colorPropertyBlue==="white"){
                    colorPropertyBlack="#8e8a8e"
                }
                else {
                    colorPropertyBlack="white"
                }
            }
        }
    }
    Rectangle{
        id:third
        border.color: "black"
        border.width: 1
        anchors.bottom: second.top
        width: parent.width
        height: parent.height/5
        color:colorPropertyRed
        Text {
            text: textThird
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pixelSize: 20
            font.family: "Microsoft New Tai Lue"
            font.bold: true
            anchors.fill: parent
        }
        MouseArea{
            id:thirdButton
            anchors.fill: parent
            onClicked: {
                if(colorPropertyRed==="white")
                {
                    colorPropertyBlack="white"
                    colorPropertyRed="#8e8a8e"
                    colorPropertyGreen="white"
                    colorPropertyBlue="white"
                }else if(colorPropertyBlack==="white"|| colorPropertyGreen==="white"||colorPropertyBlue==="white"){
                    colorPropertyRed="#8e8a8e"
                }
                else {
                    colorPropertyRed="white"
                }
            }
        }
    }
    Rectangle{
        id:fourth
        border.color: "black"
        border.width: 1
        anchors.bottom: third.top
        width: parent.width
        height: parent.height/5
        color: colorPropertyGreen
        Text {
            text:textFourth
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pixelSize: 20
            font.family: "Microsoft New Tai Lue"
            font.bold: true
            anchors.fill: parent
        }
        MouseArea{
            id:fourthButton
            anchors.fill: parent
            onClicked: {
                if(colorPropertyGreen==="white")
                {
                    colorPropertyBlack="white"
                    colorPropertyRed="white"
                    colorPropertyGreen="#8e8a8e"
                    colorPropertyBlue="white"
                }else if(colorPropertyBlack==="white"|| colorPropertyBlue==="white"||colorPropertyRed==="white"){
                    colorPropertyGreen="#8e8a8e"
                }else {
                    colorPropertyGreen="white"
                }
            }
        }
    }
    Rectangle{
        id:fifth
        border.color: "black"
        border.width: 1
        anchors.bottom: fourth.top
        width: parent.width
        height: parent.height/5
        color: colorPropertyBlue
        Text {
            text:textFifth
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pixelSize: 20
            font.family: "Microsoft New Tai Lue"
            font.bold: true
            anchors.fill: parent
        }
        MouseArea{
            id:fifthButton
            anchors.fill: parent
            onClicked: {
                if(colorPropertyBlue==="white")
                {
                    colorPropertyBlack="white"
                    colorPropertyRed="white"
                    colorPropertyGreen="white"
                    colorPropertyBlue="#8e8a8e"
                }else if(colorPropertyBlack==="white"|| colorPropertyGreen==="white"||colorPropertyRed==="white"){
                    colorPropertyBlue="#8e8a8e"
                }
                else {
                    colorPropertyBlue="white"
                }
            }
        }
    }

    states:[
        State{
            name:"State1"
            PropertyChanges {
                target: pullDowm
                x: slideX
                y:slideStartY
            }
        },
        State{
            name:"State2"
            PropertyChanges {
                target: pullDowm
                x:slideX
                y:slideEndY
            }
        }
    ]
    transitions:
        Transition {
        from: "*"
        to: "*"
        PropertyAnimation{
            target: pullDowm
            properties: "x,y"
            easing.type:Easing.Linear
            duration:300
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
