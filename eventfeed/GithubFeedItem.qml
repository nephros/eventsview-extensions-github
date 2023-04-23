/****************************************************************************
 **
 ** Copyright (C) 2014 - 2016 Jolla Ltd.
 ** Copyright (C) 2020 Open Mobile Platform LLC.
 ** Copyright (C) 2023 Peter G.
 **
 ****************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.TextLinking 1.0
import org.nemomobile.socialcache 1.0
import "shared"

SocialMediaFeedItem {
    id: item

    contentHeight: Math.max(content.height, avatar.height) + Theme.paddingMedium * 3
    width: parent.width
    avatarSource: Qt.resolvedUrl(model.avatar)
    fallbackAvatarSource: Qt.resolvedUrl(model.avatar)
    downloader: SocialImageCache{}
    // input for formattedTime
    timestamp: model.createdTime

    Column {
        id: content
        x: item.avatar.width + Theme.paddingMedium
        y: item.topMargin
        width: parent.width - x - Theme.horizontalPageMargin

        Label {
            width: parent.width
            truncationMode: TruncationMode.Fade
            elide: Text.ElideRight
            maximumLineCount: 2
            wrapMode: Text.Wrap
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.primaryColor
            textFormat: Text.PlainText
            text: model.title
        }

        Label {
            width: parent.width
            truncationMode: TruncationMode.Fade
            textFormat: Text.PlainText
            text: model.name
        }

        Label { id: notificationFrom
            width: parent.width
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.primaryColor
            visible: text !== ""
            textFormat: Text.PlainText
            text: model.from
        }
        Label { id: notificationRepo
            width: parent.width
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.primaryColor
            visible: text !== ""
            textFormat: Text.PlainText
            text: model.repo
        }
        Label { id: notificationType
            width: parent.width
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.primaryColor
            visible: text !== ""
            textFormat: Text.PlainText
            text: model.type
        }

        Label {
            width: parent.width
            maximumLineCount: 1
            elide: Text.ElideRight
            wrapMode: Text.Wrap
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeExtraSmall
            text: (item.formattedTime) ? item.formattedTime : model.createdTime
        }
    }

}
