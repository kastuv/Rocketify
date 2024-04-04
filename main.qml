import QtQuick
import QtQuick.Controls

Window {
    id: game
    width: 640
    height: 480
    visible: true
    title: qsTr("Rocketify")

    Rectangle {
        id: rectangle;
        height: 100;
        width: 100;
        color: "red";

        x: (parent.width-width)/2
        y: (parent.height-height)/2;
        focus: true

        Keys.onPressed: {
            let key = event.key;
            if(key === Qt.Key_Left) {
                rectangle.x -= 10;
            } else if(key === Qt.Key_Right) {
                rectangle.x += 10;
            } else if(key === Qt.Key_Up) {
                rectangle.y -= 10;
            } else if(key === Qt.Key_Down) {
                rectangle.y += 10;
            } else if(key === Qt.Key_Space) {
                fireBullet();
            }
        }
    }

    Timer {
        id: bulletTime
        interval: 30
        repeat: true
        running: true
        onTriggered: moveBullet()
    }

    property var bullets: []

    function fireBullet() {
        var bulletComponent = 'import QtQuick 2.0\nRectangle { id: bulletrect; height: 50; width: 10; color: "black" }';
        var bullet = Qt.createQmlObject(bulletComponent, game);
        bullet.x = rectangle.x + (rectangle.width - bullet.width) / 2;
        bullet.y = rectangle.y - 10;
        bullets.push(bullet);
    }

    function moveBullet() {
        for (var i = 0; i < bullets.length; ++i) {
            var bullet = bullets[i];
            bullet.y -= 5;
            if (bullet.y < 0) {
                bullet.destroy();
                bullets.splice(i, 1);
            }
        }
    }
}
