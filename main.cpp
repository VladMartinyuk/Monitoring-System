#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSqlDatabase>
#include <QSqlError>
#include "user.h"
#include "bloksmodel.h"
#include "dronsmodel.h"
#include "historytimemodel.h"
#include "networkmanager.h"
#include "selecteddronmodel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("/home/zhuhmek/dataBases/myDB.db");

    if(db.open())
    {
        qDebug() << "db open!";
    }
    else {
        qDebug() << "error connection to Db!" << db.lastError().text();
    }

    User *user = new User(&db);
    BloksModel * blocksModel = new BloksModel;
    DronsModel * dronsModel = new DronsModel;
    SelectedDronModel *selectedDronModel = new SelectedDronModel;
    HistoryTimeModel * historyModel = new HistoryTimeModel(selectedDronModel);


    NetworkManager::getInstance();
    NetworkManager::getInstance()->connectToHost();
    NetworkManager::getInstance()->registerObj(dronsModel);
    NetworkManager::getInstance()->registerObj(historyModel);

    engine.rootContext()->setContextProperty("user",user);
    engine.rootContext()->setContextProperty("blocksModel", blocksModel);
    engine.rootContext()->setContextProperty("dronsModel", dronsModel);
    engine.rootContext()->setContextProperty("historyModel", historyModel);
    engine.rootContext()->setContextProperty("selectedDronModel", selectedDronModel);


    engine.load(url);

    return app.exec();
}
