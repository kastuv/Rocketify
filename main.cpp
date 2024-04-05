#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "linkedListWrapper.h"

// QObject game;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    LinkedListWrapper linkedListWrapper;
    QQmlApplicationEngine engine;
    qmlRegisterType<LinkedListWrapper>("com.linked", 1, 0, "LinkedListWrapper");
    engine.rootContext()->setContextProperty("linkedListWrapper", &linkedListWrapper);

    const QUrl url(u"qrc:/Rocketify/main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
