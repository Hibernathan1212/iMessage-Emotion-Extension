//
//  EmotionWheelView.swift
//  EmotionsWheel
//
//  Created by Nathan Thurber on 28/6/25.
//

import SwiftUI

// MARK: - Data Models

struct EmotionCategory: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let color: Color
    let colorHex: String
    let secondaryEmotions: [EmotionItem]
}

struct EmotionItem: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let color: Color
    let colorHex: String
    let tertiaryEmotions: [String]
}

// MARK: - Theme & Data

struct EmotionData {
    static let categories: [EmotionCategory] = [
        EmotionCategory(
            name: "Happy",
            emoji: "😄",
            color: Color(hue: 0.15, saturation: 0.8, brightness: 0.9),
            colorHex: Color(hue: 0.15, saturation: 0.8, brightness: 0.9).toHex!,
            secondaryEmotions: [
                EmotionItem(
                    name: "Playful",
                    emoji: "🥳",
                    color: Color(hue: 0.13, saturation: 0.75, brightness: 0.95),
                    colorHex: Color(hue: 0.13, saturation: 0.75, brightness: 0.95).toHex!,
                    tertiaryEmotions: ["Aroused", "Cheeky"]
                ),
                EmotionItem(
                    name: "Content",
                    emoji: "😊",
                    color: Color(hue: 0.17, saturation: 0.7, brightness: 0.88),
                    colorHex: Color(hue: 0.17, saturation: 0.7, brightness: 0.88).toHex!,
                    tertiaryEmotions: ["Free", "Joyful"]
                ),
                EmotionItem(
                    name: "Interested",
                    emoji: "🤔",
                    color: Color(hue: 0.16, saturation: 0.65, brightness: 0.85),
                    colorHex: Color(hue: 0.16, saturation: 0.65, brightness: 0.85).toHex!,
                    tertiaryEmotions: ["Curious", "Inquisitive"]
                ),
                EmotionItem(
                    name: "Proud",
                    emoji: "🤩",
                    color: Color(hue: 0.14, saturation: 0.78, brightness: 0.92),
                    colorHex: Color(hue: 0.14, saturation: 0.78, brightness: 0.92).toHex!,
                    tertiaryEmotions: ["Successful", "Confident"]
                ),
                EmotionItem(
                    name: "Accepted",
                    emoji: "🤗",
                    color: Color(hue: 0.18, saturation: 0.68, brightness: 0.87),
                    colorHex: Color(hue: 0.18, saturation: 0.68, brightness: 0.87).toHex!,
                    tertiaryEmotions: ["Respectful", "Valued"]
                ),
                EmotionItem(
                    name: "Powerful",
                    emoji: "💪",
                    color: Color(hue: 0.12, saturation: 0.85, brightness: 0.9),
                    colorHex: Color(hue: 0.12, saturation: 0.85, brightness: 0.9).toHex!,
                    tertiaryEmotions: ["Courageous", "Creative"]
                ),
                EmotionItem(
                    name: "Peaceful",
                    emoji: "🧘‍♀️",
                    color: Color(hue: 0.19, saturation: 0.6, brightness: 0.82),
                    colorHex: Color(hue: 0.19, saturation: 0.6, brightness: 0.82).toHex!,
                    tertiaryEmotions: ["Loving", "Thankful"]
                ),
                EmotionItem(
                    name: "Trusting",
                    emoji: "🤝",
                    color: Color(hue: 0.17, saturation: 0.7, brightness: 0.8),
                    colorHex: Color(hue: 0.17, saturation: 0.7, brightness: 0.8).toHex!,
                    tertiaryEmotions: ["Sensitive", "Intimate"]
                ),
                EmotionItem(
                    name: "Optimistic",
                    emoji: "✨",
                    color: Color(hue: 0.14, saturation: 0.82, brightness: 0.93),
                    colorHex: Color(hue: 0.14, saturation: 0.82, brightness: 0.93).toHex!,
                    tertiaryEmotions: ["Hopeful", "Inspired"]
                ),
            ]
            ),
            EmotionCategory(
                name: "Sad",
                emoji: "😞",
                color: Color(hue: 0.6, saturation: 0.7, brightness: 0.6),
                colorHex: Color(hue: 0.6, saturation: 0.7, brightness: 0.6).toHex!,
                secondaryEmotions: [
                    EmotionItem(
                        name: "Lonely",
                        emoji: "😔",
                        color: Color(hue: 0.58, saturation: 0.65, brightness: 0.55),
                        colorHex: Color(hue: 0.58, saturation: 0.65, brightness: 0.55).toHex!,
                        tertiaryEmotions: ["Isolated", "Abandoned"]
                    ),
                    EmotionItem(
                        name: "Vulnerable",
                        emoji: "🥺",
                        color: Color(hue: 0.62, saturation: 0.75, brightness: 0.62),
                        colorHex: Color(hue: 0.62, saturation: 0.75, brightness: 0.62).toHex!,
                        tertiaryEmotions: ["Victimized", "Fragile"]
                    ),
                    EmotionItem(
                        name: "Despair",
                        emoji: "😩",
                        color: Color(hue: 0.61, saturation: 0.8, brightness: 0.5),
                        colorHex: Color(hue: 0.61, saturation: 0.8, brightness: 0.5).toHex!,
                        tertiaryEmotions: ["Grief", "Powerless"]
                    ),
                    EmotionItem(
                        name: "Guilty",
                        emoji: "😥",
                        color: Color(hue: 0.59, saturation: 0.7, brightness: 0.58),
                        colorHex: Color(hue: 0.59, saturation: 0.7, brightness: 0.58).toHex!,
                        tertiaryEmotions: ["Ashamed", "Resourceful"]
                    ),
                    EmotionItem(
                        name: "Depressed",
                        emoji: "😔",
                        color: Color(hue: 0.63, saturation: 0.85, brightness: 0.45),
                        colorHex: Color(hue: 0.63, saturation: 0.85, brightness: 0.45).toHex!,
                        tertiaryEmotions: ["Empty", "Inferior"]
                    ),
                    EmotionItem(
                        name: "Hurt",
                        emoji: "💔",
                        color: Color(hue: 0.64, saturation: 0.9, brightness: 0.4),
                        colorHex: Color(hue: 0.64, saturation: 0.9, brightness: 0.4).toHex!,
                        tertiaryEmotions: ["Disappointed", "Embarrassed"]
                    )
                ]
            ),
            EmotionCategory(
                name: "Disgusted",
                emoji: "🤢",
                color: Color(hue: 0.0, saturation: 0.0, brightness: 0.5),
                colorHex: Color(hue: 0.0, saturation: 0.0, brightness: 0.5).toHex!,
                secondaryEmotions: [
                    EmotionItem(
                        name: "Repelled",
                        emoji: "🙄",
                        color: Color(hue: 0.0, saturation: 0.0, brightness: 0.6),
                        colorHex: Color(hue: 0.0, saturation: 0.0, brightness: 0.6).toHex!,
                        tertiaryEmotions: ["Hesitant", "Horrified"]
                    ),
                    EmotionItem(
                        name: "Awful",
                        emoji: "🤮",
                        color: Color(hue: 0.0, saturation: 0.0, brightness: 0.4),
                        colorHex: Color(hue: 0.0, saturation: 0.0, brightness: 0.4).toHex!,
                        tertiaryEmotions: ["Detestable", "Nauseated"]
                    ),
                    EmotionItem(
                        name: "Disappointed",
                        emoji: "😒",
                        color: Color(hue: 0.0, saturation: 0.0, brightness: 0.55),
                        colorHex: Color(hue: 0.0, saturation: 0.0, brightness: 0.55).toHex!,
                        tertiaryEmotions: ["Revolted", "Appalled"]
                    ),
                    EmotionItem(
                        name: "Disapproving",
                        emoji: "😤",
                        color: Color(hue: 0.0, saturation: 0.0, brightness: 0.48),
                        colorHex: Color(hue: 0.0, saturation: 0.0, brightness: 0.48).toHex!,
                        tertiaryEmotions: ["Embarrassed", "Judgmental"]
                    )
                ]
            ),
            EmotionCategory(
                name: "Angry",
                emoji: "😡",
                color: Color(hue: 0.0, saturation: 0.8, brightness: 0.7),
                colorHex: Color(hue: 0.0, saturation: 0.8, brightness: 0.7).toHex!,
                secondaryEmotions: [
                    EmotionItem(
                        name: "Critical",
                        emoji: "😠",
                        color: Color(hue: 0.01, saturation: 0.75, brightness: 0.65),
                        colorHex: Color(hue: 0.01, saturation: 0.75, brightness: 0.65).toHex!,
                        tertiaryEmotions: ["Dismissive", "Skeptical"]
                    ),
                    EmotionItem(
                        name: "Distant",
                        emoji: "😒",
                        color: Color(hue: 0.02, saturation: 0.7, brightness: 0.6),
                        colorHex: Color(hue: 0.02, saturation: 0.7, brightness: 0.6).toHex!,
                        tertiaryEmotions: ["Numb", "Withdrawn"]
                    ),
                    EmotionItem(
                        name: "Frustrated",
                        emoji: "😤",
                        color: Color(hue: 0.99, saturation: 0.85, brightness: 0.72),
                        colorHex: Color(hue: 0.99, saturation: 0.85, brightness: 0.72).toHex!,
                        tertiaryEmotions: ["Annoyed", "Infuriated"]
                    ),
                    EmotionItem(
                        name: "Aggressive",
                        emoji: "💢",
                        color: Color(hue: 0.0, saturation: 0.9, brightness: 0.5),
                        colorHex: Color(hue: 0.0, saturation: 0.9, brightness: 0.5).toHex!,
                        tertiaryEmotions: ["Provoked", "Hostile"]
                    ),
                    EmotionItem(
                        name: "Mad",
                        emoji: "🤬",
                        color: Color(hue: 0.98, saturation: 0.95, brightness: 0.4),
                        colorHex: Color(hue: 0.98, saturation: 0.95, brightness: 0.4).toHex!,
                        tertiaryEmotions: ["Furious", "Jealous"]
                    ),
                    EmotionItem(
                        name: "Bitter",
                        emoji: "😬",
                        color: Color(hue: 0.03, saturation: 0.8, brightness: 0.68),
                        colorHex: Color(hue: 0.03, saturation: 0.8, brightness: 0.68).toHex!,
                        tertiaryEmotions: ["Indignant", "Violated"]
                    ),
                    EmotionItem(
                        name: "Humiliated",
                        emoji: "🤦‍♀️",
                        color: Color(hue: 0.01, saturation: 0.7, brightness: 0.7),
                        colorHex: Color(hue: 0.01, saturation: 0.7, brightness: 0.7).toHex!,
                        tertiaryEmotions: ["Disrespected", "Ridiculed"]
                    ),
                    EmotionItem(
                        name: "Let down",
                        emoji: "💔",
                        color: Color(hue: 0.02, saturation: 0.65, brightness: 0.75),
                        colorHex: Color(hue: 0.02, saturation: 0.65, brightness: 0.75).toHex!,
                        tertiaryEmotions: ["Betrayed", "Resentful"]
                    )
                ]
            ),
            EmotionCategory(
                name: "Fearful",
                emoji: "😨",
                color: Color(hue: 0.08, saturation: 0.8, brightness: 0.8),
                colorHex: Color(hue: 0.08, saturation: 0.8, brightness: 0.8).toHex!,
                secondaryEmotions: [
                    EmotionItem(
                        name: "Threatened",
                        emoji: "😨",
                        color: Color(hue: 0.07, saturation: 0.75, brightness: 0.75),
                        colorHex: Color(hue: 0.07, saturation: 0.75, brightness: 0.75).toHex!,
                        tertiaryEmotions: ["Nervous", "Exposed"]
                    ),
                    EmotionItem(
                        name: "Rejected",
                        emoji: "🙅‍♂️",
                        color: Color(hue: 0.09, saturation: 0.85, brightness: 0.7),
                        colorHex: Color(hue: 0.09, saturation: 0.85, brightness: 0.7).toHex!,
                        tertiaryEmotions: ["Excluded", "Persecuted"]
                    ),
                    EmotionItem(
                        name: "Weak",
                        emoji: "😔",
                        color: Color(hue: 0.06, saturation: 0.7, brightness: 0.82),
                        colorHex: Color(hue: 0.06, saturation: 0.7, brightness: 0.82).toHex!,
                        tertiaryEmotions: ["Worthless", "Insignificant"]
                    ),
                    EmotionItem(
                        name: "Insecure",
                        emoji: "😥",
                        color: Color(hue: 0.08, saturation: 0.78, brightness: 0.78),
                        colorHex: Color(hue: 0.08, saturation: 0.78, brightness: 0.78).toHex!,
                        tertiaryEmotions: ["Inadequate", "Inferior"]
                    ),
                    EmotionItem(
                        name: "Anxious",
                        emoji: " 😟",
                        color: Color(hue: 0.1, saturation: 0.9, brightness: 0.6),
                        colorHex: Color(hue: 0.1, saturation: 0.9, brightness: 0.6).toHex!,
                        tertiaryEmotions: ["Overwhelmed", "Worried"]
                    ),
                    EmotionItem(
                        name: "Scared",
                        emoji: " 😱",
                        color: Color(hue: 0.07, saturation: 0.82, brightness: 0.72),
                        colorHex: Color(hue: 0.07, saturation: 0.82, brightness: 0.72).toHex!,
                        tertiaryEmotions: ["Helpless", "Frightened"]
                    )
                ]
            ),
            EmotionCategory(
                name: "Bad",
                emoji: "😬",
                color: Color(hue: 0.35, saturation: 0.6, brightness: 0.7),
                colorHex: Color(hue: 0.35, saturation: 0.6, brightness: 0.7).toHex!,
                secondaryEmotions: [
                    EmotionItem(
                        name: "Bored",
                        emoji: "😑",
                        color: Color(hue: 0.33, saturation: 0.5, brightness: 0.75),
                        colorHex: Color(hue: 0.33, saturation: 0.5, brightness: 0.75).toHex!,
                        tertiaryEmotions: ["Indifferent", "Apathetic"]
                    ),
                    EmotionItem(
                        name: "Busy",
                        emoji: "😩",
                        color: Color(hue: 0.37, saturation: 0.65, brightness: 0.65),
                        colorHex: Color(hue: 0.37, saturation: 0.65, brightness: 0.65).toHex!,
                        tertiaryEmotions: ["Pressured", "Rushed"]
                    ),
                    EmotionItem(
                        name: "Stressed",
                        emoji: "😫",
                        color: Color(hue: 0.34, saturation: 0.7, brightness: 0.58),
                        colorHex: Color(hue: 0.34, saturation: 0.7, brightness: 0.58).toHex!,
                        tertiaryEmotions: ["Overwhelmed", "Out of control"]
                    ),
                    EmotionItem(
                        name: "Tired",
                        emoji: "😴",
                        color: Color(hue: 0.36, saturation: 0.68, brightness: 0.62),
                        colorHex: Color(hue: 0.36, saturation: 0.68, brightness: 0.62).toHex!,
                        tertiaryEmotions: ["Sleepy", "Unfocused"]
                    )
                ]
            ),
        ]
}

// MARK: - Main View

struct EmotionWheelView: View {
    @State private var currentLayer: Int = 1
    @State private var selectedCategory: EmotionCategory?
    @State private var selectedEmotion: EmotionItem?
    @State private var selectedSpecific: String?
    
    @State private var overallFeeling: Double = 50.0
    @State private var emotionNote: String = ""
    @State private var sendButtonScale: CGFloat = 1.0

    @FocusState private var isNoteFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            progressView
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    switch currentLayer {
                    case 1:
                        primaryEmotionsView
                    case 2:
                        secondaryEmotionsView
                    case 3:
                        specificEmotionsView
                    default:
                        EmptyView()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            
            Spacer()
            
            bottomActionsView
        }
        .background(
            LinearGradient(
                colors: [Color(.systemBackground), Color(.secondarySystemBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
    
    // MARK: - Header
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("How are you feeling?")
                .font(.system(.title2, design: .rounded, weight: .semibold))
                .foregroundColor(.primary)
            
            if currentLayer > 1 {
                Text(getCurrentPrompt())
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
    }
    
    // MARK: - Progress View
    
    private var progressView: some View {
        HStack(spacing: 8) {
            ForEach(1...3, id: \.self) { step in
                Circle()
                    .fill(step <= currentLayer ? Color.accentColor : Color(.tertiaryLabel))
                    .frame(width: 8, height: 8)
                    .scaleEffect(step == currentLayer ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: currentLayer)
            }
        }
        .padding(.vertical, 16)
    }
    
    // MARK: - Primary Emotions
    
    private var primaryEmotionsView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
            ForEach(EmotionData.categories, id: \.id) { category in
                EmotionCard(
                    title: category.name,
                    emoji: category.emoji,
                    color: category.color,
                    isSelected: selectedCategory?.id == category.id
                ) {
                    selectCategory(category)
                }
            }
        }
    }
    
    // MARK: - Secondary Emotions
    
    private var secondaryEmotionsView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 1), spacing: 12) {
            if let category = selectedCategory {
                ForEach(category.secondaryEmotions, id: \.id) { emotion in
                    EmotionRow(
                        title: emotion.name,
                        emoji: emotion.emoji,
                        color: emotion.color,
                        isSelected: selectedEmotion?.id == emotion.id
                    ) {
                        selectEmotion(emotion)
                    }
                }
            }
        }
    }
    
    // MARK: - Specific Emotions
    
    private var specificEmotionsView: some View {
        VStack {
            VStack(spacing: 12) {
                Text(selectedSpecific ?? selectedEmotion?.name ?? "")
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
            }
            .padding(.bottom, 16)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                if let emotion = selectedEmotion {
                    ForEach(emotion.tertiaryEmotions, id: \.self) { specific in
                        SmallEmotionCard(
                            title: specific,
                            color: emotion.color,
                            isSelected: selectedSpecific == specific
                        ) {
                            selectSpecific(specific)
                        }
                    }
                }
            }
            .padding(.bottom, 16)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Overall feeling")
                        .font(.system(.headline, design: .rounded, weight: .medium))
                    
                    Spacer()
                    
                    Text("\(Int(overallFeeling))/100")
                        .font(.system(.subheadline, design: .rounded, weight: .medium))
                        .foregroundColor(colorFromValue(overallFeeling))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background((colorFromValue(overallFeeling)).opacity(0.15))
                        .cornerRadius(8)
                }
                
                Slider(value: $overallFeeling, in: 1...100, step: 1)
//                    .tint(selectedEmotion?.color ?? selectedCategory?.color ?? .secondary)
                    .tint(colorFromValue(overallFeeling))
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Add a note (optional)")
                    .font(.system(.headline, design: .rounded, weight: .medium))
                
                TextField("What's on your mind?", text: $emotionNote, axis: .vertical)
                    .lineLimit(3...5)
                    .textFieldStyle(.roundedBorder)
                    .focused($isNoteFieldFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button("Done") {
                                isNoteFieldFocused = false
                            }
                        }
                    }
            }
        }
    }
    
    func colorFromValue(_ value: Double) -> Color {
        let clampedValue = min(max(value, 0), 100)
        let red = 1.0 - (clampedValue / 100.0)
        let green = clampedValue / 100.0
        return Color(red: red, green: green, blue: 0)
    }
    
    // MARK: - Bottom Actions
    
    private var bottomActionsView: some View {
        VStack(spacing: 12) {
            if currentLayer >= 2 {
                Button("Share This Feeling") {
                    currentLayer == 2 ? goForward() : shareEmotion()
                    
                }
                .buttonStyle(selectedEmotion == nil ? PrimaryButtonStyle(color: .gray) : PrimaryButtonStyle(color: selectedEmotion?.color ?? selectedCategory?.color ?? .accentColor))
                .disabled(selectedCategory == nil)
                .scaleEffect(sendButtonScale)
                .pressEffect(scale: $sendButtonScale)
            } else {
                Button(selectedCategory == nil ? "Select an Emotion to Continue" : "Continue") {
                    goForward()
                }
                .buttonStyle(selectedCategory == nil ? PrimaryButtonStyle(color: .gray) : PrimaryButtonStyle(color: selectedCategory!.color))
                .disabled(selectedCategory == nil)
                
                HStack {
                    Button("❤️") {
                        sendLoveYouMore()
                    }
                    .buttonStyle(PrimaryButtonStyle(color: .pink))
                    
                    Button("Request") {
                        requestFeeling()
                    }
                    .buttonStyle(PrimaryButtonStyle(color: .blue))
                }
            }
            
            HStack {
                if currentLayer > 1 {
                    Button("Back") {
                        goBack()
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
                
                Spacer()
                
                if currentLayer == 2 && selectedEmotion != nil {
                    Button("Next") {
                        goForward()
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    
    // MARK: - Helper Methods
    
    private func selectCategory(_ category: EmotionCategory) {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
        
        withAnimation(.easeInOut(duration: 0.3)) {
            if selectedCategory?.id == category.id {
                selectedCategory = nil
                selectedEmotion = nil
                selectedSpecific = nil
            } else {
                selectedCategory = category
                selectedEmotion = nil
                selectedSpecific = nil
            }
        }
    }
    
    private func selectEmotion(_ emotion: EmotionItem) {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
        
        withAnimation(.easeInOut(duration: 0.3)) {
            if selectedEmotion?.id == emotion.id {
                selectedEmotion = nil
                selectedSpecific = nil
            } else {
                selectedEmotion = emotion
                selectedSpecific = nil
            }
        }
    }
    
    private func selectSpecific(_ specific: String) {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
        
        withAnimation(.easeInOut(duration: 0.3)) {
            if selectedSpecific == specific {
                selectedSpecific = nil
            } else {
                selectedSpecific = specific
            }
        }
    }
    
    private func goForward() {
        if currentLayer == 1 && selectedCategory == nil { return }
        if currentLayer == 2 && selectedEmotion == nil { return }
        
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
        
        withAnimation(.easeInOut(duration: 0.4)) {
            currentLayer += 1
        }
    }
    
    private func goBack() {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
        
        withAnimation(.easeInOut(duration: 0.4)) {
            if currentLayer > 1 {
                currentLayer -= 1
                if currentLayer == 1 {
                    selectedEmotion = nil
                    selectedSpecific = nil
                } else if currentLayer == 2 {
                    selectedSpecific = nil
                }
            }
        }
    }
    
    private func getCurrentPrompt() -> String {
        switch currentLayer {
        case 2:
            return "What kind of \(selectedCategory?.name.lowercased() ?? "emotion")?"
        case 3:
            return "More specifically, are you feeling..."
        default:
            return ""
        }
    }
    
    private func getFullEmotionString() -> String {
        if let specific = selectedSpecific {
            return specific
        } else if let emotion = selectedEmotion {
            return emotion.name
        } else if let category = selectedCategory {
            return category.name
        }
        return "Unknown Emotion"
    }
    
    private func shareEmotion() {
        let impact = UIImpactFeedbackGenerator(style: .heavy)
        impact.impactOccurred()
        
        let emotionName = getFullEmotionString()
        let emoji = selectedEmotion?.emoji ?? selectedCategory?.emoji ?? "😊"
        let colorHex = selectedEmotion?.color.toHex ?? selectedCategory?.color.toHex ?? Color.blue.toHex!
        
        NotificationCenter.default.post(
            name: Notification.Name("SendEmotionMessage"),
            object: nil, 
            userInfo: [
                "name": emotionName,
                "emoji": emoji,
                "colorHex": colorHex,
                "overallFeeling": Int(overallFeeling),
                "thought": emotionNote
            ]
        )
        
        resetSelection()
    }
    
    private func sendLoveYouMore() {
        let impact = UIImpactFeedbackGenerator(style: .heavy)
        impact.impactOccurred()
        
        NotificationCenter.default.post(
            name: Notification.Name("SendLoveYouMore"),
            object: nil
        )
        
        resetSelection()
    }
    
    private func requestFeeling() {
        let impact = UIImpactFeedbackGenerator(style: .heavy)
        impact.impactOccurred()
        
        // Post notification to MessagesViewController to send "I love you more"
        NotificationCenter.default.post(
            name: Notification.Name("SendFeelingRequest"),
            object: nil
        )
        
        resetSelection()
    }
    
    private func resetSelection() {
        withAnimation(.easeInOut(duration: 0.4)) {
            currentLayer = 1
            selectedCategory = nil
            selectedEmotion = nil
            selectedSpecific = nil
            overallFeeling = 5.0
            emotionNote = ""
        }
    }
}

// MARK: - UI Components

struct EmotionCard: View {
    let title: String
    let emoji: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Text(emoji)
                    .font(.system(size: 40))
                
                Text(title)
                    .font(.system(.headline, design: .rounded, weight: .medium))
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? color.opacity(0.15) : Color(.secondarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? color : Color.clear, lineWidth: 2)
                    )
            )
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

struct EmotionRow: View {
    let title: String
    let emoji: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Text(emoji)
                    .font(.system(size: 28))
                
                Text(title)
                    .font(.system(.headline, design: .rounded, weight: .medium))
                    .foregroundColor(.primary)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(color)
                        .font(.title3)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? color.opacity(0.1) : Color(.secondarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? color : Color.clear, lineWidth: 1.5)
                    )
            )
        }
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

struct SmallEmotionCard: View {
    let title: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(.subheadline, design: .rounded, weight: .medium))
                .foregroundColor(isSelected ? .white : .primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? color : Color(.secondarySystemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(color.opacity(0.3), lineWidth: 1)
                        )
                )
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

// MARK: - Button Styles

struct PrimaryButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline, design: .rounded, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(color)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline, design: .rounded, weight: .medium))
            .foregroundColor(.primary)
            .frame(height: 44)
            .padding(.horizontal, 24)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Press Effect Extension

struct PressEffect: ViewModifier {
    @Binding var scale: CGFloat
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                withAnimation(.easeInOut(duration: 0.1)) {
                    scale = pressing ? 0.98 : 1.0
                }
            }, perform: {})
    }
}

extension View {
    func pressEffect(scale: Binding<CGFloat>) -> some View {
        modifier(PressEffect(scale: scale))
    }
}

#Preview {
    EmotionWheelView()
}
