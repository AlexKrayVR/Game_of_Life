import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12
import ModelWorld 1.0
Window {
    id:mainWindow
    visible: true
    width: 400
    height: 600
    title: qsTr("LG")
    property bool autoChecked: false

    ModelWorld{
        id:myModel
    }

    //size
    PullDownMenu{
        slideX:sizeMenu.x
        slideStartY:sizeMenu.y-sizeMenu.height*4
        slideEndY:sizeMenu.y
        x: sizeMenu.x
        y: sizeMenu.y-sizeMenu.height*4
        height: sizeMenu.height*5
        z:10
        width: sizeMenu.width

        secondButton.onClicked: myModel.setSize(10)
        thirdButton.onClicked: myModel.setSize(15)
        fourthButton.onClicked: myModel.setSize(20)
        fifthButton.onClicked: myModel.setSize(25)

        textFifth: "25X25"
        textFourth: "20X20"
        textThird: "15X15"
        textSecond: "10X10"
        textFirst: "Size"
    }
    //shape
    PullDownMenu{
        slideX:shapeMenu.x
        slideStartY:shapeMenu.y-shapeMenu.height*4
        slideEndY:shapeMenu.y
        x: shapeMenu.x
        y: shapeMenu.y-shapeMenu.height*4
        height: shapeMenu.height*5
        z:10
        width: shapeMenu.width

        secondButton.onClicked: root.delegate=squar
        thirdButton.onClicked: root.delegate=circle
        fourthButton.onClicked: root.delegate=triangle
        fifthButton.onClicked: root.delegate=star

        textFifth: "Star"
        textFourth: "Triangle"
        textThird: "Circle"
        textSecond: "Square"
        textFirst: "Shape"
    }
    //color
    PullDownMenu{
        slideX:colorButtonMenu.x
        slideStartY:colorButtonMenu.y-colorButtonMenu.height*4
        slideEndY:colorButtonMenu.y
        x: colorButtonMenu.x
        y: colorButtonMenu.y-colorButtonMenu.height*4
        height: colorButtonMenu.height*5
        antialiasing: true
        width: colorButtonMenu.width
        z:10
        secondButton.onClicked: myModel.secondColor="black"
        thirdButton.onClicked: myModel.secondColor="red"
        fourthButton.onClicked: myModel.secondColor="green"
        fifthButton.onClicked: myModel.secondColor="blue"
        textFifth: "Blue"
        textFourth: "Green"
        textThird: "Red"
        textSecond: "Black"
        textFirst: "Color"
    }

    //top menu
    Rectangle{
        id:topMenu
        anchors.top: parent.top
        width: parent.width
        height: parent.height/12
        Row{
            anchors.fill: parent
            Row{
                height: topMenu.height
                width: topMenu.width/3
                Rectangle{
                    height: parent.height
                    width: parent.width-areaGlider.width
                    color: "black"
                    TextComponent{
                        anchors.fill: parent
                        textComponent:"Game"
                    }
                }
                Rectangle{
                    id:areaGlider
                    height: parent.height
                    width: areaGlider.height
                    border.color: "black"
                    border.width: 3
                    Image {
                        id: glaider
                        anchors.centerIn: parent
                        height: parent.height-6
                        width: parent.height-6
                        source: "/Glider.svg.png"
                    }
                }

            }
            Rectangle{
                id:sizeMenu
                height: topMenu.height
                width: topMenu.width/6
                Text {
                    anchors.fill: parent
                    text: qsTr("Size")
                    color: "white"
                    fontSizeMode: Text.Fit
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Microsoft New Tai Lue"
                    font.bold: true
                }
            }
            Rectangle{
                id:shapeMenu
                height: topMenu.height
                width: topMenu.width/6
                color:"black"
                border.color: shapeButton.pressed?"white":"black"
                border.width: 2
                TextComponent{
                    anchors.fill: parent
                    textComponent:"Shape"
                }
                MouseArea{
                    anchors.fill: parent
                    id: shapeButton
                }
            }
            Rectangle{
                id:colorButtonMenu
                height: topMenu.height
                width: topMenu.width/6
            }
            Rectangle{
                height: topMenu.height
                width: topMenu.width/6
                color:"black"
                border.color: exitButton.pressed?"white":"black"
                border.width: 2
                TextComponent{
                    anchors.fill: parent
                    textComponent:"Exit"
                }
                MouseArea{
                    id:exitButton
                    anchors.fill: parent
                    onClicked:Qt.quit()
                }
            }
        }
    }

    //world
    Rectangle{
        width: mainWindow.width
        height: mainWindow.width
        border.color: "black"
        border.width: 1
        anchors.centerIn: parent
        GridView{
            id:root
            anchors.fill: parent
            width: parent.width-2
            height: parent.height-2
            interactive: false
            antialiasing: true
            model: myModel
            cellHeight:height/myModel.size
            cellWidth:width/myModel.size
            delegate: squar
        }
    }

    //cell in the form of a triangle
    Component{
        id: triangle
        Rectangle {
            id:triangleRect
            width: root.cellWidth
            height: root.cellHeight
            border.color: "black"
            border.width: 1
            MouseArea{
                anchors.fill:parent
                onClicked: {
                    root.currentIndex = model.index
                    myModel.changeCellByClick(root.currentIndex)
                }
            }
            Shape {
                antialiasing: true
                anchors.fill: parent
                ShapePath {
                    fillColor: model.color
                    startX: triangleRect.width/2; startY: 1
                    PathLine { x: triangleRect.width-2; y: triangleRect.width-2;  }
                    PathLine { x: 2; y:  triangleRect.width-2 }
                    PathLine { x: triangleRect.width/2; y: 1 }
                }
            }
        }
    }
    //cell in the form of a star
    Component{
        id: star
        Rectangle {
            id:starRect
            width: root.cellWidth
            height: root.cellHeight
            border.color: "black"
            border.width: 1
            color: "transparent"
            MouseArea{
                anchors.fill:parent
                onClicked: {
                    root.currentIndex = model.index
                    myModel.changeCellByClick(root.currentIndex)
                }
            }
            Shape {
                antialiasing: true
                anchors.fill: parent
                ShapePath {
                    strokeWidth: -1
                    fillRule: ShapePath.WindingFill
                    fillColor: model.color
                    startX: starRect.width/2;
                    startY: 2
                    PathLine {
                        x:starRect.width/2*0.59+starRect.width/2
                        y:starRect.width/2*0.81+starRect.width/2
                    }
                    PathLine {
                        x:starRect.width/2*0.05
                        y:starRect.width/2-starRect.width/2*0.3
                    }
                    PathLine {
                        x:starRect.width/2+starRect.width/2*0.95
                        y:starRect.width/2-starRect.width/2*0.3
                    }
                    PathLine {
                        x:starRect.width/2-starRect.width/2*0.59
                        y:starRect.width/2+starRect.width/2*0.81
                    }
                }
            }
        }

    }
    //cell in the form of a square
    Component {
        id: squar
        Rectangle{
            width: root.cellWidth
            height: root.cellHeight
            border.color: "black"
            border.width: 1
            color: model.color
            MouseArea{
                anchors.fill:parent
                onClicked: {
                    root.currentIndex = model.index
                    myModel.changeCellByClick(root.currentIndex)
                }
            }
        }
    }
    //cell in the form of a circle
    Component {
        id: circle
        Rectangle {
            id:cellRectangle
            width: root.cellWidth
            height: root.cellHeight
            border.color: "black"
            border.width: 1
            color: "transparent"
            Rectangle{
                anchors.centerIn: cellRectangle
                width: cellRectangle.width-5
                height: cellRectangle.height-5
                radius: height
                color: model.color
            }
            MouseArea{
                anchors.fill:parent
                onClicked: {
                    root.currentIndex = model.index
                    myModel.changeCellByClick(root.currentIndex)
                }
            }
        }
    }

    //bottom menu
    Rectangle{
        id:bottomMenu
        width: parent.width
        height: parent.height/12
        anchors.bottom: parent.bottom
        Row{
            anchors.fill: parent
            Rectangle{
                height: bottomMenu.height
                width: bottomMenu.width/4
                color:"black"
                border.color: stepButton.pressed?"white":"black"
                border.width: 2
                TextComponent{
                    anchors.fill: parent
                    textComponent:"Step"
                }
                MouseArea{
                    id: stepButton
                    anchors.fill: parent
                    onClicked: myModel.nextStep()
                }
            }
            Rectangle{
                height: bottomMenu.height
                width: bottomMenu.width/4
                color:"black"
                border.color: randomButton.pressed?"white":"black"
                border.width: 2

                TextComponent{
                    anchors.fill: parent
                    textComponent:"Random"
                }
                MouseArea{
                    id: randomButton
                    anchors.fill: parent
                    onClicked: myModel.randomStart()
                }
            }
            Rectangle{
                height: bottomMenu.height
                width: bottomMenu.width/4
                color:"black"
                border.color: autoButton.pressed?"white":"black"
                border.width: 2
                Timer {
                    id: timer
                    interval: 500
                    running: false
                    repeat: true
                    onTriggered: myModel.nextStep()
                }

                TextComponent{
                    anchors.fill: parent
                    textComponent:autoChecked ? "Stop": "Auto"
                }

                MouseArea{
                    id: autoButton
                    anchors.fill: parent
                    onClicked:{
                        timer.running = !timer.running
                        autoChecked=!autoChecked
                    }
                }
            }
            Rectangle{
                height: bottomMenu.height
                width: bottomMenu.width/4
                color:"black"
                border.color: clearButton.pressed?"white":"black"
                border.width: 2

                TextComponent{
                    anchors.fill: parent
                    textComponent:"Clear"
                }

                MouseArea{
                    id:clearButton
                    anchors.fill: parent
                    onClicked:myModel.clear()

                }
            }
        }
    }




}

