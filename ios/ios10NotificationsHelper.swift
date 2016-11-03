//
//  ios10NotificationsHelper.swift
//  Magnet
//
//  Created by Francisco Jordano on 03/11/2016.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import UserNotifications
import UserNotificationsUI

@available(iOS 10.0, *)
class ios10NotificationsHelper: NSObject, UNUserNotificationCenterDelegate {
  private static let CATEGORY = "magnet.notifications.category"
  
  func showRichNotification(urls: [String]) {
    let content = UNMutableNotificationContent()
    content.title = "Abandoned London Post Office Railway"
    content.subtitle = "by Atlas Obscura"
    content.body = "An unmanned underground railroad created to transport London’s mail beneath its congested streets ran for seven decades, until it was unceremoniously shut down and abandoned";
    content.categoryIdentifier = ios10NotificationsHelper.CATEGORY
    
    let originalUrl = "http://www.atlasobscura.com/places/abandoned-underground-post-office-railway"
//    let src = "https://www.flickr.com/photos/31363949@N02/27151290043"
//    let url: NSURL = (NSURL(string: src))!
    
//    do {
//      let attachment = try! UNNotificationAttachment(identifier: originalUrl, URL: url, options: nil)
//      content.attachments = [attachment]
//    } catch {
//      debugPrint("=================>> Attachment not loaded")
//    }
    
    let action1 = UNNotificationAction(identifier: "visit", title: "Visit", options: [])
    let action2 = UNNotificationAction(identifier: "dismiss", title: "Dismiss", options: [])
    let category = UNNotificationCategory(identifier: ios10NotificationsHelper.CATEGORY, actions: [action1, action2], intentIdentifiers: [], options: [])
    UNUserNotificationCenter.currentNotificationCenter().setNotificationCategories([category])
    
    let request = UNNotificationRequest(identifier: originalUrl, content: content, trigger: nil)
    UNUserNotificationCenter.currentNotificationCenter().removeAllDeliveredNotifications()
    UNUserNotificationCenter.currentNotificationCenter().addNotificationRequest(request, withCompletionHandler: nil)
    
    UNUserNotificationCenter.currentNotificationCenter().delegate = self
  }
  
  func userNotificationCenter(center: UNUserNotificationCenter, didReceiveNotificationResponse response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
    debugPrint("=======================>> after action \(response.actionIdentifier)")
  }
  
  func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
    debugPrint("=======================>> before show")
  }
  
}
