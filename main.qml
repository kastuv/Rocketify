import QtQuick
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Rocketify")

    Rectangle
    {
        id: rectangle;
        height: 100;
        width: 100;
        color: "red";

        x: (parent.width-width)/2
        y: (parent.height-height)/2;
        //focus here is important in a sence that it allows the system to notice the keys events when we press one
        focus: true

        Keys.onPressed:
        {
            if(event.key === Qt.Key_Left)
            {
                rectangle.x -= 10;
            }
            else if(event.key === Qt.Key_Right)
            {
                rectangle.x += 10;
            }
        }
    }

        // Item {
        //         focus: true
        //         Keys.onPressed: {
        //             // This captures key events at the window level if needed
        //         }
        //     }
}
