import QtQuick
import QtQuick.Controls

Window {
    id: game
    width: 3024
    height: 1964
    visible: true
    title: qsTr("Rocketify")

    Rectangle {
        id: player
        height: 50
        width: 50
        color: "red"

        x: (parent.width - width) / 2
        y: parent.height - height
        focus: true

        Keys.onPressed: {
            let key = event.key;
            if (key === Qt.Key_Left) {
                player.x -= 10;
            } else if (key === Qt.Key_Right) {
                player.x += 10;
            } else if (key === Qt.Key_Space) {
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

    Timer {
        id: enemyTimer
        interval: 800 // Adjust this for enemy falling speed
        running: true
        repeat: true
        onTriggered: {

            moveEnemies();
        }
    }

    Timer
    {
        id: enemyMove
        interval: 2000
        running: true
        repeat: true
        onTriggered:
        {
            createEnemy();
        }
    }

    property var bullets: []
    property var enemies: []

    function fireBullet() {
        var bulletComponent = 'import QtQuick 2.0\nRectangle { id: bulletrect; height: 10; width: 5; color: "black" }';
        var bullet = Qt.createQmlObject(bulletComponent, game);
        bullet.x = player.x + (player.width - bullet.width) / 2;
        bullet.y = player.y - 20;
        bullets.push(bullet);
    }

    function moveBullet() {
        for (var i = 0; i < bullets.length; ++i) {
            var bullet = bullets[i];
            bullet.y -= 5;
            if (bullet.y < 0) {
                bullet.destroy();
                bullets.splice(i, 1);
            } else {
                checkBulletCollision(bullet);
            }
        }
    }

    function createEnemy() {
        var enemyComponent = 'import QtQuick 2.0\nRectangle { id: enemyrect; height: 50; width: 50; color: "blue" }';
        var enemy = Qt.createQmlObject(enemyComponent, game);
        enemy.x = Math.random() * (game.width - enemy.width);
        enemy.y = -enemy.height;
        enemies.push(enemy);
    }

    function moveEnemies() {
        for (var i = 0; i < enemies.length; ++i) {
            var enemy = enemies[i];
            enemy.y += 5; // Adjust this for enemy falling speed
            if (enemy.y > game.height) {
                enemy.destroy();
                enemies.splice(i, 1);
            }
        }
    }

    function checkBulletCollision(bullet) {
        for (var i = 0; i < enemies.length; ++i) {
            var enemy = enemies[i];
            if (bullet.x >= enemy.x && bullet.x <= enemy.x + enemy.width &&
                bullet.y >= enemy.y && bullet.y <= enemy.y + enemy.height) {
                bullet.destroy();
                bullets.splice(bullets.indexOf(bullet), 1);
                enemy.destroy();
                enemies.splice(i, 1);
                console.log("Bullet hit enemy!");
                break
            }
        }
    }
}
