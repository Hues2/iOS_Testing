//
//  LocalNotifications.swift
//  TestingThings
//
//  Created by Greg Ross on 16/08/2022.
//

import SwiftUI
import UserNotifications
import CoreLocation


class NotificationManager{
    static let instance = NotificationManager()
    
    //MARK: - Get permissions from the user to send notifications
    func requestAuthorization(){
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error{
                print("\n \("ERROR: \(error)") \n")
            } else{
                print("\n \("SUCCESS") \n")
            }
        }
    }
    
    //MARK: - Schedule a notification
    func scheduleNotification(){
        
        // Create the content of the notification
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "This was so easy"
        content.sound = .default
        content.badge = 1
        
        
        // Create the desired trigger
        
        // TIME
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        
        // CALENDAR
        var dateComponents = DateComponents()
        dateComponents.hour = 20 // Hour in the day
        dateComponents.minute = 32 // Minute of the hour
        dateComponents.weekday = 2 // Number that represents the day in the week
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        // LOCATION
        let coordinates = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
        
        let region = CLCircularRegion(center: coordinates, radius: 100, identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let locationTrigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        
        
        // Create the request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: calendarTrigger)
        
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request)
    }
    
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}



struct LocalNotifications: View {
    var body: some View {
        VStack(spacing: 40){
            Button {
                NotificationManager.instance.requestAuthorization()
            } label: {
                Text("Request Permission")
            }
            
            Button {
                NotificationManager.instance.scheduleNotification()
            } label: {
                Text("Schedule Notification")
            }
            
            Button {
                NotificationManager.instance.cancelNotification()
            } label: {
                Text("Cancel Notification")
            }

        }
        .onAppear(){
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotifications_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotifications()
    }
}
