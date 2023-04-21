/****************************************************************************
 **
 ** Copyright (C) 2014 - 2016 Jolla Ltd.
 ** Copyright (C) 2020 Open Mobile Platform LLC.
 **
 ****************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.TextLinking 1.0
import "shared"

SocialMediaFeedItem {
    id: item

    contentHeight: Math.max(content.height, avatar.height) + Theme.paddingMedium * 3
    width: parent.width
    avatarSource: model.avatar


    Column {
        id: content
        x: item.avatar.width + Theme.paddingMedium
        y: item.topMargin
        width: parent.width - x - Theme.horizontalPageMargin

        Label {
            width: parent.width
            truncationMode: TruncationMode.Fade
            text: model.name
            textFormat: Text.PlainText
        }

        Label {
            id: notificationType
            width: parent.width
            truncationMode: TruncationMode.Fade
            opacity: .6
            text: item.notificationTypeText(model.type)
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.primaryColor
            visible: text !== ""
            textFormat: Text.PlainText
        }

        //Text {
        //    width: parent.width
        //    maximumLineCount: 1
        //    elide: Text.ElideRight
        //    wrapMode: Text.Wrap
        //    color: Theme.highlightColor
        //    font.pixelSize: Theme.fontSizeSmall
        //    text: item.formattedTime
        //}

        Column {
            width: parent.width
            visible: item.isRepost
            spacing: Theme.paddingSmall

            Item {
                width: 1
                height: Theme.paddingLarge
            }

            Item {
                width: 1
                height: Theme.paddingSmall
            }

        }
    }

    function notificationTypeText(notificationType) {
        if (notificationType !== "") {
            switch (notificationType) {
            case "issue":
                return "Issue"
            }
            return "Notification"
        }
        return ""
    }
}
