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

    readonly property var ghTypeIcon: {
       "Issue":             'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="darkgreen"   d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3Z"></path><path fill="darkgreen" d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0ZM1.5 8a6.5 6.5 0 1 0 13 0 6.5 6.5 0 0 0-13 0Z"></path></svg>',
       "PullRequest":       'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="darkgreen"   d="M1.5 3.25a2.25 2.25 0 1 1 3 2.122v5.256a2.251 2.251 0 1 1-1.5 0V5.372A2.25 2.25 0 0 1 1.5 3.25Zm5.677-.177L9.573.677A.25.25 0 0 1 10 .854V2.5h1A2.5 2.5 0 0 1 13.5 5v5.628a2.251 2.251 0 1 1-1.5 0V5a1 1 0 0 0-1-1h-1v1.646a.25.25 0 0 1-.427.177L7.177 3.427a.25.25 0 0 1 0-.354ZM3.75 2.5a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5Zm0 9.5a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5Zm8.25.75a.75.75 0 1 0 1.5 0 .75.75 0 0 0-1.5 0Z"></path></svg>',
       "PullRequestClosed": 'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="crimson"     d="M3.25 1A2.25 2.25 0 0 1 4 5.372v5.256a2.251 2.251 0 1 1-1.5 0V5.372A2.251 2.251 0 0 1 3.25 1Zm9.5 5.5a.75.75 0 0 1 .75.75v3.378a2.251 2.251 0 1 1-1.5 0V7.25a.75.75 0 0 1 .75-.75Zm-2.03-5.273a.75.75 0 0 1 1.06 0l.97.97.97-.97a.748.748 0 0 1 1.265.332.75.75 0 0 1-.205.729l-.97.97.97.97a.751.751 0 0 1-.018 1.042.751.751 0 0 1-1.042.018l-.97-.97-.97.97a.749.749 0 0 1-1.275-.326.749.749 0 0 1 .215-.734l.97-.97-.97-.97a.75.75 0 0 1 0-1.06ZM2.5 3.25a.75.75 0 1 0 1.5 0 .75.75 0 0 0-1.5 0ZM3.25 12a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5Zm9.5 0a.75.75 0 1 0 0 1.5.75.75 0 0 0 0-1.5Z"></path></svg>',
       "Merge":             'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="darkmagenta" d="M5.45 5.154A4.25 4.25 0 0 0 9.25 7.5h1.378a2.251 2.251 0 1 1 0 1.5H9.25A5.734 5.734 0 0 1 5 7.123v3.505a2.25 2.25 0 1 1-1.5 0V5.372a2.25 2.25 0 1 1 1.95-.218ZM4.25 13.5a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm8.5-4.5a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5ZM5 3.25a.75.75 0 1 0 0 .005V3.25Z"></path></svg>',
       "Tag":               'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="dimgray"     d="M1 7.775V2.75C1 1.784 1.784 1 2.75 1h5.025c.464 0 .91.184 1.238.513l6.25 6.25a1.75 1.75 0 0 1 0 2.474l-5.026 5.026a1.75 1.75 0 0 1-2.474 0l-6.25-6.25A1.752 1.752 0 0 1 1 7.775Zm1.5 0c0 .066.026.13.073.177l6.25 6.25a.25.25 0 0 0 .354 0l5.025-5.025a.25.25 0 0 0 0-.354l-6.25-6.25a.25.25 0 0 0-.177-.073H2.75a.25.25 0 0 0-.25.25ZM6 5a1 1 0 1 1 0 2 1 1 0 0 1 0-2Z"></path></svg>',
       "IssueClosed":       'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill="darkgray"    d="M11.28 6.78a.75.75 0 0 0-1.06-1.06L7.25 8.69 5.78 7.22a.75.75 0 0 0-1.06 1.06l2 2a.75.75 0 0 0 1.06 0l3.5-3.5Z"></path><path fill="darkgray" d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0Zm-1.5 0a6.5 6.5 0 1 0-13 0 6.5 6.5 0 0 0 13 0Z"></path></svg>',
       "Repository":        'data:image/svg+xml;utf8,<svg viewBox="0 0 16 16" version="1.1" width="16" height="16"                   ><path fill="dimgray"     d="M2 2.5A2.5 2.5 0 0 1 4.5 0h8.75a.75.75 0 0 1 .75.75v12.5a.75.75 0 0 1-.75.75h-2.5a.75.75 0 0 1 0-1.5h1.75v-2h-8a1 1 0 0 0-.714 1.7.75.75 0 1 1-1.072 1.05A2.495 2.495 0 0 1 2 11.5Zm10.5-1h-8a1 1 0 0 0-1 1v6.708A2.486 2.486 0 0 1 4.5 9h8ZM5 12.25a.25.25 0 0 1 .25-.25h3.5a.25.25 0 0 1 .25.25v3.25a.25.25 0 0 1-.4.2l-1.45-1.087a.249.249 0 0 0-.3 0L5.4 15.7a.25.25 0 0 1-.4-.2Z"></path></svg>',
    }
    readonly property var ghReasonText: {
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
        "assign":           '🎯',
        "comment":          '💬',
        "mention":          '✋',
        "team_mention":     '🙌',
        "review_requested": '👀'
    }

    contentHeight: Math.max(content.height, avatar.height) + Theme.paddingMedium * 3
    width: parent.width
    downloader: SocialImageCache{}
    // avatarSource causes the downloader to fetch the image, which doesn't work with a SVG path.
    // as we want the SVG path, lets set this to something that fails, and use the fallback to get our image.
    avatarSource: "http://localhost/noimage" //Qt.resolvedUrl(model.avatar)
    fallbackAvatarSource: ghTypeIcon[model.type] || ""

    avatar.opacity: Theme.opacityHigh

    // input for formattedTime
    timestamp: model.timestamp

    property string contextId: model.url ? "#" + model.url.substr(model.url.lastIndexOf("/") + 1) : ""

    // avatars are public, so we don't need imageDownloader.
    // Use it as an image under fallbackAvatarSource
    Image { id: avatarUnderlay
        anchors.fill: item.avatar
        anchors.centerIn: item.avatar
        z: avatar.z - 1
        sourceSize.width:  width
        sourceSize.height: height
        visible: source !== ""
        smooth: false
        source: model.avatar
    }
    Rectangle { id: reasonIndicator
        anchors.right: item.avatar.right
        anchors.bottom: item.avatar.bottom
        width:  avatar.width/3
        height: avatar.height/3
        radius: width/2
        visible: reasonIcon.text !== ""
        color: (Theme.colorScheme === Theme.LightOnDark) ? Theme.darkSecondaryColor : Theme.lightSecondaryColor
        Text { id: reasonIcon
            anchors.centerIn: parent
            anchors.fill: parent
            visible: text !== ""
            font.pixelSize: parent.height // dynamic font size ;)
            color: (Theme.colorScheme === Theme.LightOnDark) ? Theme.lightPrimaryColor : Theme.darkPrimaryColor
            text: ghReasonText[model.reason] || ""
        }
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
