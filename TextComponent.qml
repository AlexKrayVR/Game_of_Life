import QtQuick 2.0

Text {
    property string textComponent: ""
    anchors.fill: parent
    text: textComponent
    color: "white"
    font.pixelSize: 20
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    font.family: "Microsoft New Tai Lue"
    font.bold: true
}
