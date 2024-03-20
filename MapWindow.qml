import QtQuick 2.15
import QtQuick.Controls 2.5
import QtPositioning 5.8
import QtLocation 5.9
import QtQuick.Window 2.3
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.3

Window {
    id: map_wnd
    width: 1024
    height: 800
    visible: false
    title: qsTr("")

    color: "#A4A4A4"

    property bool devisesFlag: false
    property bool dronsFlag: false
    property bool selectedPathFlag: false
    property bool dronsPolyneViewFlag: true
    property string deviseShowButText: "Показать список устройств"
    property string dronsShowButText: "Показать список дронов"

    Connections {
        target: blocksModel
        function onNewMapCenter(newLat, newLong)
        {
            map.center = QtPositioning.coordinate(newLat, newLong)
        }
    }

    Connections {
        target: dronsModel
        function onNewMapCenter(newMap_lat, newMap_long)
        {
            map.center = QtPositioning.coordinate(newMap_lat, newMap_long)
        }
    }

    Connections {
        target: historyModel
        function onStateChanged(state)
        {
            dronsPolyneViewFlag = state
        }
    }

    Connections {
        target: historyModel
        function onChangeModelPath()
        {
            console.log("qml123123")
            dronsPolyneViewFlag = false
            selectedPathFlag = true
        }
    }

    Connections {
        target: user
        function onGetUserData(user_name,user_lastName,user_surName)
        {
            if(user_name !== "")
            {
                profile_wnd.userName = user_name
            }
            if(user_lastName !== "")
            {
                profile_wnd.userLastName = user_lastName
            }
            if(user_surName !== "")
            {
                profile_wnd.userSureName = user_surName
            }
            map_wnd.hide()
            menu.close()
            profile_wnd.show()
        }
    }

    Plugin {
        id: map_plugin
        name: "osm"
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: map_plugin
        center: QtPositioning.coordinate(51.6720400, 39.1843000)
        zoomLevel: 14

        MapItemView {
            id: blocks_view
            model: blocksModel
            delegate: block_delegate
        }

        MapItemView {
            id: radius_view
            model: blocksModel
            delegate: radiusView_delegate
        }

        MapItemView {
            id: drons_view
            model: dronsModel
            delegate: dron_delegate
        }

        MapItemView {
            id: polyneDronsView
            model: historyModel
            visible: dronsPolyneViewFlag
            delegate: dote_delegate
        }

        MapItemView {
            id: selectedDronPathView
            model: selectedDronModel
            visible: selectedPathFlag
            delegate: dote_delegate
        }
    }

    Component {
        id: dote_delegate
        MapQuickItem {
            id: doteOnMap
            anchorPoint.x: img.width/4
            anchorPoint.y: img.height
            coordinate: QtPositioning.coordinate(trackedDron_lat, trackedDron_long)
            sourceItem: Item {
                width: 10
                height: 10
                Image {
                    id: img
                    height: 10
                    width: 10
                    source: "qrc:/images/dote.png"
                }
                Popup {
                    id: dotePopup
                    x: parent.width-4;
                    y: parent.y+4
                    width: 175
                    height: 100
                    background: Rectangle {
                        width: parent.width
                        height: parent.height
                        radius: 20
                        layer.enabled: true
                        layer.effect: DropShadow {
                            radius: 8
                            samples: 16
                            color: "#80000000"
                        }
                    }
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 5
                        Label {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            text: "дата: "+trackedDron_date+""
                        }
                        Label {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            text: "время: "+trackedDron_time+""
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        dotePopup.open()
                    }
                }
            }
        }
    }

    Component {
        id: block_delegate
        MapQuickItem {
            id: block
            anchorPoint.x: img.width/4
            anchorPoint.y: img.height
            coordinate: QtPositioning.coordinate(latitude_block, longitude_block)
            sourceItem: Item {
                width: 40
                height: 40
                Image {
                    id: img
                    height: 40
                    width: 40
                    source: "qrc:/images/block"
                }
                Label {
                    text: block_name
                    font.pixelSize: 16
                    anchors.horizontalCenter: img.horizontalCenter
                    y: img.y + 35
                }
            }
        }
    }

    Component {
        id: dron_delegate
        MapQuickItem {
            id: dron
            anchorPoint.x: imgDron.width / 4
            anchorPoint.y: imgDron.height
            coordinate: QtPositioning.coordinate(dron_latitude, dron_longitude)
            sourceItem: Item {
                id: dron_item
                width: 40
                height: 40
                Image {
                    id: imgDron
                    height: 40
                    width: 40
                    source: "qrc:/images/bpla.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked:  {
                            dron_poup.open()
                            //historyModel.getPathOfCurrentDron(dronIdtxt.text)
                            historyModel.setDronId(dronIdtxt.text)
                            historyModel.upFlag()
                        }
                    }
                }
                Label {
                    id: dronIdtxt
                    text: dron_id
                    visible: false
                }
                Popup {
                    id: dron_poup
                    x: parent.width-4;
                    y: parent.y+4
                    width: 150
                    height: 150
                    onClosed: {
                        historyModel.downFLag()
                        dronsPolyneViewFlag = true
                        selectedPathFlag = false
                    }
                    background: Rectangle {
                        width: parent.width
                        height: parent.height
                        radius: 20
                        layer.enabled: true
                        layer.effect: DropShadow {
                            radius: 8
                            samples: 16
                            color: "#80000000"
                        }
                    }
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 3
                        Label {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            text: "name: "+dron_name+""
                        }
                        Label {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            text: "latitude: "+dron_latitude+""
                        }
                        Label {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            text: "longitude: "+dron_longitude+""
                        }
                        Label {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            text: "type: "+dron_type+""
                        }
                    }
                }
            }
        }
    }

    Component {
        id: radiusView_delegate
        MapCircle {
            id: radius
            center: QtPositioning.coordinate(latitude_block, longitude_block)
            radius: block_radView
            color: "green"
            opacity: 0.3
        }
    }

    Label {
        id: showDrons_lbl
        text: dronsShowButText
        color: "white"
        style: Text.Outline
        styleColor: "black"
        anchors.top: parent.top
        anchors.topMargin: 95
        anchors.right: parent.right
        anchors.rightMargin: 10
        font.pixelSize: 22
        MouseArea {
            id: showDrons_button
            anchors.fill: parent
            onClicked: {
                if(!dronsFlag)
                {
                    dronsFlag = true
                    dronsShowButText = "Скрыть список дронов"
                }
                else
                {
                    dronsFlag = false
                    dronsShowButText = "Показать список дронов"
                }
            }
        }
    }
    Rectangle {
        width: showDrons_lbl.width
        height: 2
        color: "black"
        anchors.left: showDrons_lbl.left
        anchors.top: showDrons_lbl.top
        anchors.topMargin: 25
    }

    Rectangle {
        height: parent.height - 150
        width: 150
        color: "#7109AA"
        radius: 22
        visible: dronsFlag
        border.color: "black"
        anchors.right: parent.right
        anchors.rightMargin:  10
        anchors.top: showDrons_lbl.top
        anchors.topMargin: 35
        Label {
            text: "Дроны:"
            style: Text.Outline
            styleColor: "black"
            font.pixelSize: 20
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            anchors.topMargin: 5
        }
        ListView {
            id: list_drons
            anchors.top: parent.top
            anchors.topMargin: 45
            anchors.left: parent.left
            anchors.leftMargin: 12.5
            width: 125
            height: parent.height - 10
            clip: true
            spacing: 5
            model: dronsModel
            delegate: Rectangle {
                width: parent.width
                height: 45
                radius: 22
                color: dron_but.pressed ? "grey" : "white"
                border.color: "black"
                Text {
                    anchors.centerIn: parent
                    text: dron_name
                }
                MouseArea {
                    id: dron_but
                    anchors.fill: parent
                    cursorShape: Qt.OpenHandCursor
                    onClicked:  {
                        dronsModel.trackDron(dron_name)
                    }
                }
            }
        }
    }

    Label {
        id: showDevises_lbl
        text: deviseShowButText
        color: "white"
        style: Text.Outline
        styleColor: "black"
        anchors.top: parent.top
        anchors.topMargin: 95
        anchors.left: parent.left
        anchors.leftMargin: 10
        font.pixelSize: 22
        MouseArea {
            id: showDevises_button
            anchors.fill: parent
            onClicked: {
                if(!devisesFlag)
                {
                    devisesFlag = true
                    deviseShowButText = "Скрыть список устройств"
                }
                else
                {
                    devisesFlag = false
                    deviseShowButText = "Показать список устройств"
                }
            }
        }
    }
    Rectangle {
        width: showDevises_lbl.width
        height: 2
        color: "black"
        anchors.left: showDevises_lbl.left
        anchors.top: showDevises_lbl.top
        anchors.topMargin: 25
    }

    Rectangle {
        height: parent.height - 150
        width: 150
        visible: devisesFlag
        color: "#7109AA"
        radius: 22
        border.color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: showDevises_lbl.top
        anchors.topMargin: 35
        Label {
            id: label_devise
            text: "Устройства:"
            font.pixelSize: 18
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            style: Text.Outline
            styleColor: "black"
        }
        ListView {
            id: list_devises
            clip: true
            anchors.top: parent.top
            anchors.topMargin: 45
            anchors.left: parent.left
            anchors.leftMargin: 12.5
            width: 125
            height: parent.height - 10
            spacing: 5
            model: blocksModel
            delegate: Rectangle {
                width: parent.width
                height: 45
                radius: 22
                color: block_but.pressed ? "grey" : "white"
                border.color: "black"
                Text {
                    anchors.centerIn: parent
                    text: block_name
                }
                MouseArea {
                    id: block_but
                    anchors.fill: parent
                    cursorShape: Qt.OpenHandCursor
                    onClicked: {
                        blocksModel.trackBlock(block_name)
                    }
                }
            }

        }
    }


    Rectangle {
        id: shapka
        anchors.top: parent.top
        width: parent.width
        height: 90
        color: "#A4A4A4"

        ComboBox {
            id: combo
            width: 250
            height: 50
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 10
            model: [ "Отображать точки", "Не отображать точки"]
            onActivated:  {
                historyModel.getViewState(combo.model[combo.currentIndex])
            }
        }

        Label {
            text: "Система мониторинга"
            anchors.centerIn: parent
            color: "white"
            style: Text.Outline
            styleColor: "black"
            font.pixelSize: 30
        }
        Item {
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 20
            width: 160
            height: 70
            Rectangle {
                anchors.fill: parent
                color: "transparent"
            }
            Image {
                id: imgMenu
                anchors.left: parent.left
                width: 70
                height: 70
                source: "qrc:/images/menu.png"
            }
            Label {
                text: "Menu"
                font.pixelSize: 32
                color: "white"
                style: Text.Outline
                styleColor: "black"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea {
                id: menu_but
                anchors.fill: parent
                onClicked: {
                    menu.y = shapka.y + shapka.height
                    menu.x = parent.x - 5
                    menu.open()
                }
            }
        }
    }

    Menu {
        id: menu
        contentItem:  Rectangle {
            anchors.fill: parent
            border.color: "black"
        }
        ColumnLayout {
            anchors.fill: parent
            spacing: 1
            MenuItem {
                Layout.fillHeight: true
                Layout.fillWidth: true
                contentItem: Rectangle {
                    anchors.fill: parent
                    border.color: "black"
                    border.width: 2
                    color: "#A4A4A4"
                    Label {
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 18
                        style: Text.Outline
                        styleColor: "black"
                        text: "Профиль"
                    }
                    MouseArea {
                        id: profile_menuBut
                        anchors.fill: parent
                        onClicked: {
                            user.getUserProileData()
                        }
                    }
                }
            }
            MenuItem {
                Layout.fillHeight: true
                Layout.fillWidth: true
                contentItem: Rectangle {
                    anchors.fill: parent
                    border.color: "black"
                    border.width: 2
                    color: "#A4A4A4"
                    Label {
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 18
                        style: Text.Outline
                        styleColor: "black"
                        text: "История"
                    }
                    MouseArea {
                        id: hostoryDrons_menuBut
                        anchors.fill: parent
                        onClicked: {
                            map_wnd.hide()
                            menu.close()
                            historyFlyesWnd.show()
                        }
                    }
                }
            }
        }
    }

    UserProfileWnd {
        id: profile_wnd
        onBackToMap: {
            profile_wnd.close()
            map_wnd.show()
        }
    }

    HistoryDronsFlyesWnd {
        id: historyFlyesWnd
        onBackButClicked: {
            historyFlyesWnd.close()
            map_wnd.show()
        }
    }

}
