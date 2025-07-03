//
//  MessagesViewController.swift
//  EmotionsWheel MessagesExtension
//
//  Created by Nathan Thurber on 28/6/25.
//

import UIKit
import Messages
import SwiftUI

// MARK: - Codable Data Models for Messages

struct EmotionMessageData: Codable {
    let type: String
    let name: String
    let emoji: String
    let colorHex: String
    let overallFeeling: Int
    let thought: String?
}

struct LoveYouMoreMessageData: Codable {
    let type: String
    let message: String
}

struct FeelingRequestMessageData: Codable {
    let type: String
    let message: String
}

class MessagesViewController: MSMessagesAppViewController {
    
    private var emotionWheelHostingController: UIHostingController<EmotionWheelView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSendEmotionNotification(_:)),
            name: Notification.Name("SendEmotionMessage"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSendLoveYouMoreNotification(_:)),
            name: Notification.Name("SendLoveYouMore"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSendFeelingRequestNotification(_:)),
            name: Notification.Name("SendFeelingRequest"),
            object: nil
        )
        
        setupEmotionWheel()
    }

    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        if emotionWheelHostingController == nil {
            setupEmotionWheel()
        }
    }

    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        super.didTransition(to: presentationStyle)
        // Automatically transition to expanded style for better UX
        if presentationStyle == .compact {
            requestPresentationStyle(.expanded)
        }
    }

    override func didSelect(_ message: MSMessage, conversation: MSConversation) {
        super.didSelect(message, conversation: conversation)
        
        requestPresentationStyle(.expanded)
        
        guard let url = message.url,
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            print("Selected message has no URL or query items.")
            return
        }
        
        if let typeItem = queryItems.first(where: { $0.name == "type" })?.value {
            switch typeItem {
            case "emotion":
                if let dataString = queryItems.first(where: { $0.name == "data" })?.value,
                   let decodedData = Data(base64Encoded: dataString),
                   let emotionData = try? JSONDecoder().decode(EmotionMessageData.self, from: decodedData) {
                    print("User selected emotion: \(emotionData.name) \(emotionData.emoji), Overall: \(emotionData.overallFeeling)%, Thought: \(emotionData.thought ?? "N/A")")
                    
                    // maybe save viewstate if user wants to reopen and edit
                } else {
                    print("Failed to decode EmotionMessageData.")
                }
            case "loveyoumore":
                if let dataString = queryItems.first(where: { $0.name == "data" })?.value,
                   let decodedData = Data(base64Encoded: dataString),
                   let loveYouMoreData = try? JSONDecoder().decode(LoveYouMoreMessageData.self, from: decodedData) {
                    print("User selected 'I love you more' message: \(loveYouMoreData.message)")
                } else {
                    print("Failed to decode LoveYouMoreMessageData.")
                }
            default:
                print("Unknown message type selected.")
            }
        }
    }

    // MARK: - Private Methods
    
    private func setupEmotionWheel() {
        cleanupChildViewControllers()
        
        let emotionWheelView = EmotionWheelView()
        let hostingController = UIHostingController(rootView: emotionWheelView)
        
        hostingController.view.backgroundColor = .clear
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
        emotionWheelHostingController = hostingController
    }
    
    private func cleanupChildViewControllers() {
        children.forEach { child in
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        emotionWheelHostingController = nil
    }

    // MARK: - Notification Handlers (from SwiftUI)
    
    @objc private func handleSendEmotionNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let name = userInfo["name"] as? String,
              let emoji = userInfo["emoji"] as? String,
              let colorHex = userInfo["colorHex"] as? String,
              let overallFeeling = userInfo["overallFeeling"] as? Int,
              let thought = userInfo["thought"] as? String,
              let conversation = activeConversation else {
            print("Error: Could not get emotion data or active conversation from notification.")
            return
        }

        let emotionData = EmotionMessageData(
            type: "emotion",
            name: name,
            emoji: emoji,
            colorHex: colorHex,
            overallFeeling: overallFeeling,
            thought: thought.isEmpty ? nil : thought
        )
        
        sendDetailedEmotionMessage(emotionData, in: conversation)
    }
    
    @objc private func handleSendLoveYouMoreNotification(_ notification: Notification) {
        guard let conversation = activeConversation else {
            print("Error: Could not get active conversation for 'I love you more' message.")
            return
        }
        
        let loveYouMoreData = LoveYouMoreMessageData(type: "loveyoumore", message: "I love you more.")
        sendLoveYouMoreMessage(loveYouMoreData, in: conversation)
    }
    
    @objc private func handleSendFeelingRequestNotification(_ notification: Notification) {
        guard let conversation = activeConversation else {
            print("Error: Could not get active conversation for 'Feeling Request'")
            return
        }
        
        let feelingRequestData = FeelingRequestMessageData(type: "feelingrequest", message: "How are you feeling?")
        sendFeelingRequestMessage(feelingRequestData, in: conversation)
    }

    // MARK: - Message Sending Logic

    private func sendDetailedEmotionMessage(_ emotionData: EmotionMessageData, in conversation: MSConversation) {
        let layout = MSMessageTemplateLayout()
                
        layout.caption = "I'm feeling \(emotionData.name.lowercased())"
        
        var subcaptionText = "Overall, I'm feeling around \(emotionData.overallFeeling)/100\n"
        
        subcaptionText += emotionData.thought ?? "Tap to share how you're feeling!"
        
        layout.subcaption = subcaptionText
        
        if let color = Color(hex: emotionData.colorHex) {
            layout.image = createColorSwatchImage(color: color.opacity(0.8), size: CGSize(width: 300, height: 300))
            layout.imageTitle = emotionData.emoji
        }
                
        let message = MSMessage()
        message.layout = layout
        
        if let encodedData = try? JSONEncoder().encode(emotionData),
           let dataString = encodedData.base64EncodedString().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            var components = URLComponents()
            components.queryItems = [
                URLQueryItem(name: "type", value: "emotion"),
                URLQueryItem(name: "data", value: dataString)
            ]
            message.url = components.url
        } else {
            print("Failed to encode EmotionMessageData for URL.")
        }
        
        insertAndSend(message: message, in: conversation)
    }
    
    private func sendLoveYouMoreMessage(_ loveYouMoreData: LoveYouMoreMessageData, in conversation: MSConversation) {
        let layout = MSMessageTemplateLayout()
        layout.caption = loveYouMoreData.message
        layout.subcaption = "Proof I love you more"
        
        layout.image = createHeartImage(
            colors: [
                UIColor(Color(hue: 0.9, saturation: 0.8, brightness: 0.9)),
                UIColor(Color(hue: 0.95, saturation: 0.9, brightness: 0.8))
            ],
            size: CGSize(width: 100, height: 100)
        )
        
        let message = MSMessage()
        message.layout = layout
        
        if let encodedData = try? JSONEncoder().encode(loveYouMoreData),
           let dataString = encodedData.base64EncodedString().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            var components = URLComponents()
            components.queryItems = [
                URLQueryItem(name: "type", value: loveYouMoreData.type),
                URLQueryItem(name: "data", value: dataString)
            ]
            message.url = components.url
        } else {
            print("Failed to encode LoveYouMoreMessageData for URL.")
        }
        
        insertAndSend(message: message, in: conversation)
    }
    
    private func sendFeelingRequestMessage(_ feelingRequestData: FeelingRequestMessageData, in conversation: MSConversation) {
        let layout = MSMessageTemplateLayout()
        layout.caption = feelingRequestData.message
        layout.subcaption = "How have you been feeling recently?"
                
        let message = MSMessage()
        message.layout = layout
        
        if let encodedData = try? JSONEncoder().encode(feelingRequestData),
           let dataString = encodedData.base64EncodedString().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            var components = URLComponents()
            components.queryItems = [
                URLQueryItem(name: "type", value: feelingRequestData.type),
                URLQueryItem(name: "data", value: dataString)
            ]
            message.url = components.url
        } else {
            print("Failed to encode FeelingRequestData for URL.")
        }
        
        insertAndSend(message: message, in: conversation)
    }

    private func insertAndSend(message: MSMessage, in conversation: MSConversation) {
        provideFeedbackForSending()
        
        conversation.insert(message) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error sending message: \(error.localizedDescription)")
                    self?.handleSendError(error)
                } else {
                    print("Successfully sent message.")
                    self?.handleSuccessfulSend()
                }
            }
        }
    }
    
    private func provideFeedbackForSending() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
    
    private func handleSuccessfulSend() {
        dismiss()
    }
    
    private func handleSendError(_ error: Error) {
        print("Failed to send message: \(error)")
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.error)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Image Rendering Helpers
    
    private func createColorSwatchImage(color: Color, size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            UIColor(color).setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    private func createHeartImage(colors: [UIColor], size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: size)
            let path = UIBezierPath()
            
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addCurve(to: CGPoint(x: rect.minX, y: rect.midY * 0.9),
                          controlPoint1: CGPoint(x: rect.midX - rect.width * 0.4, y: rect.maxY * 0.8),
                          controlPoint2: CGPoint(x: rect.minX, y: rect.maxY * 0.6))
            path.addCurve(to: CGPoint(x: rect.midX, y: rect.minY + rect.height * 0.3),
                          controlPoint1: CGPoint(x: rect.minX, y: rect.midY * 0.4),
                          controlPoint2: CGPoint(x: rect.midX - rect.width * 0.2, y: rect.minY + rect.height * 0.1))
            path.addCurve(to: CGPoint(x: rect.maxX, y: rect.midY * 0.9),
                          controlPoint1: CGPoint(x: rect.midX + rect.width * 0.2, y: rect.minY + rect.height * 0.1),
                          controlPoint2: CGPoint(x: rect.maxX, y: rect.midY * 0.4))
            path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                          controlPoint1: CGPoint(x: rect.maxX, y: rect.maxY * 0.6),
                          controlPoint2: CGPoint(x: rect.midX + rect.width * 0.4, y: rect.maxY * 0.8))
            path.close()
            
            context.cgContext.addPath(path.cgPath)
            context.cgContext.clip()

            guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                            colors: colors.map { $0.cgColor } as CFArray,
                                            locations: [0, 1]) else { return }
            
            context.cgContext.drawLinearGradient(gradient,
                                                 start: CGPoint(x: rect.midX, y: rect.minY),
                                                 end: CGPoint(x: rect.midX, y: rect.maxY),
                                                 options: [])
        }
    }
}

// MARK: - Color Extension for Hex String

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    var toHex: String? {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
}
