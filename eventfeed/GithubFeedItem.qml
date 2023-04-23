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

    property string contextId: model.url ? "#" + model.url.substr(model.url.lastIndexOf("/") + 1) : ""

    Text { id: reasonIcon
        anchors.left: item.avatar.left
        anchors.bottom: item.avatar.bottom
        visible: text !== ""
        font.pixelSize: Theme.fontSizeExtraSmall
        text: {
            switch (model.reason) {
            /*
             * assign   You were assigned to the issue.
             * author   You created the thread.
             * comment  You commented on the thread.
             * ci_activity  A GitHub Actions workflow run that you triggered was completed.
             * invitation   You accepted an invitation to contribute to the repository.
             * manual   You subscribed to the thread (via an issue or pull request).
             * mention  You were specifically @mentioned in the content.
             * review_requested You, or a team you're a member of, were requested to review a pull request.
             * security_alert   GitHub discovered a security vulnerability in your repository.
             * state_change You changed the thread state (for example, closing an issue or merging a pull request).
             * subscribed   You're watching the repository.
             * team_mention You were on a team that was mentioned.
             */
                case "assign":           return '🎯'; break
                case "comment":          return '💬'; break
                case "mention":          return '✋'; break
                case "team_mention":     return '🙌'; break
                case "review_requested": return '👀'; break
                default: return ""
            }
            color: (Theme.colorScheme === Theme.LightOnDark) ? Theme.lightPrimaryColor : Theme.darkPrimaryColor
        }
        Rectangle { z: typeIcon.z -1 ; anchors.fill: parent; radius: width/2; opacity: 0.8; color: (Theme.colorScheme === Theme.LightOnDark) ? Theme.darkSecondaryColor : Theme.lightSecondaryColor  }
    }
    Image { id: typeIcon
        anchors.right: item.avatar.right
        anchors.bottom: item.avatar.bottom
        width: Theme.paddingLarge
        height: Theme.paddingLarge
        sourceSize.width: width
        sourceSize.height: height
        visible: source !== ""
        source: {
            switch (model.type) {
                case "Issue":             return 'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="darkgreen"   d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3Z"></path><path d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0ZM1.5 8a6.5 6.5 0 1 0 13 0 6.5 6.5 0 0 0-13 0Z"></path></svg>'; break
                case "PullRequest":       return 'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="darkgreen"   d="M1.5 3.25a2.25 2.25 0 1 1 3 2.122v5.256a2.251 2.251 0 1 1-1.5 0V5.372A2.25 2.25 0 0 1 1.5 3.25Zm5.677-.177L9.573.677A.25.25 0 0 1 10 .854V2.5h1A2.5 2.5 0 0 1 13.5 5v5.628a2.251 2.251 0 1 1-1.5 0V5a1 1 0 0 0-1-1h-1v1.646a.25.25 0 0 1-.427.177L7.177 3.427a.25.25 0 0 1 0-.354ZM3.75 2.5a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5Zm0 9.5a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5Zm8.25.75a.75.75 0 1 0 1.5 0 .75.75 0 0 0-1.5 0Z"></path></svg>'; break
                case "PullRequestClosed": return 'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="crimson"     d="M3.25 1A2.25 2.25 0 0 1 4 5.372v5.256a2.251 2.251 0 1 1-1.5 0V5.372A2.251 2.251 0 0 1 3.25 1Zm9.5 5.5a.75.75 0 0 1 .75.75v3.378a2.251 2.251 0 1 1-1.5 0V7.25a.75.75 0 0 1 .75-.75Zm-2.03-5.273a.75.75 0 0 1 1.06 0l.97.97.97-.97a.748.748 0 0 1 1.265.332.75.75 0 0 1-.205.729l-.97.97.97.97a.751.751 0 0 1-.018 1.042.751.751 0 0 1-1.042.018l-.97-.97-.97.97a.749.749 0 0 1-1.275-.326.749.749 0 0 1 .215-.734l.97-.97-.97-.97a.75.75 0 0 1 0-1.06ZM2.5 3.25a.75.75 0 1 0 1.5 0 .75.75 0 0 0-1.5 0ZM3.25 12a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5Zm9.5 0a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5Z"></path></svg>'; break
                case "Merge":             return 'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="darkmagenta" d="M5.45 5.154A4.25 4.25 0 0 0 9.25 7.5h1.378a2.251 2.251 0 1 1 0 1.5H9.25A5.734 5.734 0 0 1 5 7.123v3.505a2.25 2.25 0 1 1-1.5 0V5.372a2.25 2.25 0 1 1 1.95-.218ZM4.25 13.5a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm8.5-4.5a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM5 3.25a.75.75 0 1 0 0 .005V3.25Z"></path></svg>'; break
                case "Tag":               return 'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="dimgray"     d="M1 7.775V2.75C1 1.784 1.784 1 2.75 1h5.025c.464 0 .91.184 1.238.513l6.25 6.25a1.75 1.75 0 0 1 0 2.474l-5.026 5.026a1.75 1.75 0 0 1-2.474 0l-6.25-6.25A1.752 1.752 0 0 1 1 7.775Zm1.5 0c0 .066.026.13.073.177l6.25 6.25a.25.25 0 0 0 .354 0l5.025-5.025a.25.25 0 0 0 0-.354l-6.25-6.25a.25.25 0 0 0-.177-.073H2.75a.25.25 0 0 0-.25.25ZM6 5a1 1 0 1 1 0 2 1 1 0 0 1 0-2Z"></path></svg>'; break
                case "IssueClosed":       return 'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="darkgray"    d="M11.28 6.78a.75.75 0 0 0-1.06-1.06L7.25 8.69 5.78 7.22a.75.75 0 0 0-1.06 1.06l2 2a.75.75 0 0 0 1.06 0l3.5-3.5Z"></path><path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0Zm-1.5 0a6.5 6.5 0 1 0-13 0 6.5 6.5 0 0 0 13 0Z"></path></svg>'; break
                default: ""
            }
        }
        Rectangle { z: typeIcon.z -1 ; anchors.fill: parent; radius: width/2; opacity: 0.8; color: (Theme.colorScheme === Theme.LightOnDark) ? Theme.darkSecondaryColor : Theme.lightSecondaryColor  }
    }

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
            font.bold: model.unread
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

        Label { id: notificationType
            width: parent.width
            truncationMode: TruncationMode.Fade
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.primaryColor
            visible: text !== ""
            textFormat: Text.PlainText
            text: model.type + " " + item.contextId
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
