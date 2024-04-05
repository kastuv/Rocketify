import QtQuick
import QtQuick.Controls
import com.linked 1.0

Window {
    id: game
    width: 3024
    height: 1964
    visible: true
    title: qsTr("Rocketify")

    LinkedListWrapper {
        id: linkedListWrapper
    }

    Text {
        id: scoreText
        text: "Score: " + linkedListWrapper.score
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

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
                if (player.x - 15 >= 0)
                    player.x -= 15;
            } else if (key === Qt.Key_Right) {
                if (player.x + player.width + 15 <= game.width)
                    player.x += 15;
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
        interval: 800
        running: true
        repeat: true
        onTriggered: {
            moveEnemies();
            createEnemy();
            checkGameOver();
        }
    }

    Timer {
        id: enemyMove
        interval: 2000
        running: true
        repeat: true
    }

    Rectangle {
        id: gameOverBox
        width: parent.width
        height: parent.height
        color: "black"
        opacity: gameOver ? 0.8 : 0

        Text {
            id: gameOverText
            text: "Game Over! Score: " + linkedListWrapper.score
            color: "white"
            font.pixelSize: 50
            anchors.centerIn: parent
        }

        Button {
            id: restartButton
            text: "Restart"
            onClicked: restartGame()
            anchors.top: gameOverText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    property bool gameOver: false
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
            bullet.y -= 10;
            if (bullet.y < 0) {
                bullet.destroy();
                bullets.splice(i, 1);
            } else {
                checkBulletCollision(bullet);
            }
        }
    }

    function createEnemy() {
        var enemyDensity = linkedListWrapper.score < 50 ? 0.3 : (linkedListWrapper.score < 100 ? 0.4 : 0.6);

        if (Math.random() < enemyDensity) {
            var enemyComponent = 'import QtQuick 2.0\nRectangle { id: enemyrect; height: 50; width: 50; color: "blue" }';
            var enemy = Qt.createQmlObject(enemyComponent, game);
            enemy.x = Math.random() * (game.width - enemy.width);
            enemy.y = -enemy.height;
            enemies.push(enemy);
        }
    }

    function moveEnemies() {
        var fallingSpeed = linkedListWrapper.score < 50 ? 5 : (linkedListWrapper.score < 100 ? 10 : 15);
        for (var i = 0; i < enemies.length; ++i) {
            var enemy = enemies[i];
            enemy.y += fallingSpeed;

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
                linkedListWrapper.increaseScore(5);
                break;
            }
        }
    }

    function checkGameOver() {
        for (var i = 0; i < enemies.length; ++i) {
            var enemy = enemies[i];
            if (enemy.y + enemy.height >= game.height) {
                gameOver = true;
                stopGame();
                break;
            }
        }
    }

    function stopGame() {
        bulletTime.stop();
        enemyTimer.stop();
        enemyMove.stop();
    }

    function restartGame() {
        gameOver = false;
        scoreText.text = "Score: 0";
        gameOverBox.opacity = 0;

        for (var i = 0; i < bullets.length; ++i) {
            bullets[i].destroy();
        }
        bullets = [];

        for (var j = 0; j < enemies.length; ++j) {
            enemies[j].destroy();
        }
        enemies = [];

        Qt.createComponent("main.qml").createObject(game, {"x": game.x, "y": game.y});
    }
}
