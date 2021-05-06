//
//  NegativeEmotion.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 03/05/21.
//

import Foundation

extension NegativeEmotion {
    static func initData() {
        var negativeEmotionTemp: NegativeEmotion
        var tempAction: Action
        
//        1st data
        negativeEmotionTemp = DataManager.shared.addNegativeEmotion(name: "Anxious", image: "anxiety", desc: "Anxiety is your body’s natural response to stress. It’s a feeling of fear or apprehension about what’s to come. The first day of school, going to a job interview, or giving a speech may cause most people to feel fearful and nervous.\n\nBut if your feelings of anxiety are extreme, last for longer than six months, and are interfering with your life, you may have an anxiety disorder\n\nSymptoms of general anxiety include:\n- increased heart rate\n- rapid breathing\n- restlessness\n- trouble concentrating\n- difficulty falling asleep\n\nLifestyle changes can be an effective way to relive some of the stress and anxiety you may cope with every day. Most of the natural “remedies” consist of caring for your body, participating in healthy activities, and eliminating unhealthy ones.")
        
        tempAction = DataManager.shared.addAction(title: "Meditation", negativeEmotion: negativeEmotionTemp)
        tempAction = DataManager.shared.addAction(title: "Gardening", negativeEmotion: negativeEmotionTemp)
        

//        2nd data
        negativeEmotionTemp = DataManager.shared.addNegativeEmotion(name: "Sad", image: "sad", desc: "Sadness is one of the seven universal emotions experienced by everyone around the world resulting from the loss of someone or something important. What causes us sadness varies greatly based on personal and cultural notions of loss. While sadness is often considered a “negative” emotion, it serves an important role in signaling a need to receive help or comfort.\n\nSadness describes the range, or family, of emotional states we can experience containing everything from mild disappointment to extreme despair and anguish.\n\nSadness can also be experienced along with other emotions, such as:\n- Anger (e.g., having a loved one abandon you)\n- Fear (e.g., that we will not be able to cope or move on with life)\n- Joy (e.g., reminiscing about time spent with the lost person or thing; pleasure from the comfort provided by others)\nThe key difference between mood and emotion is duration, or how long it lasts. Sadness is one of the longer-lasting emotions and often cycles through periods of protest, resignation, and helplessness. It’s important to note, however, that sadness is different from depression, which is a common but serious psychological disorder described by recurrent, persistent, and intense feelings of sadness and hopelessness that interfere with daily living.")
        
        tempAction = DataManager.shared.addAction(title: "Write in a journal", negativeEmotion: negativeEmotionTemp)
        tempAction = DataManager.shared.addAction(title: "Listen favorite song", negativeEmotion: negativeEmotionTemp)
        
//        3rd data
        negativeEmotionTemp = DataManager.shared.addNegativeEmotion(name: "Overthink", image: "overthink", desc: "Overthinking is simply what its name suggests – thinking too much. Overthinking is going over the same thought again and again, analysing the simplest of situations or events until all sense of proportion has gone. The overthinking brain cannot translate these thoughts into actions or positive outcomes, so therefore creates feelings of stress and anxiety.\n\nLike many traits of anxiety and depression, overthinking actually comes from one of our primitive preservation instincts.\n\nThe primitive mind will always see things from the worst possible perspective. This is because the brain is being hyper-vigilant, trying to keep us alive – there’s no sense in being optimistic about those sabre-toothed tigers I’ve mentioned before!\n\nThe intellectual brain will tell us that no way will we lose our job because we called our boss by the wrong name. However, people prone to rumination are responding in that primitive fight-or-flight mode, where focusing on worst-case scenarios is more likely to keep us alive. Overthinking and anxiety work together, exacerbating the feelings of stress and helplessness.")
        
        tempAction = DataManager.shared.addAction(title: "Breath Meditation", negativeEmotion: negativeEmotionTemp)
        tempAction = DataManager.shared.addAction(title: "Eat Chocolate", negativeEmotion: negativeEmotionTemp)

//        4th data
        negativeEmotionTemp = DataManager.shared.addNegativeEmotion(name: "Exhausted", image: "exhausted", desc: "Exhausted is defined as drained of one's physical or mental resources; very tired")
        
        tempAction = DataManager.shared.addAction(title: "Drink more water", negativeEmotion: negativeEmotionTemp)
        tempAction = DataManager.shared.addAction(title: "Sleep well", negativeEmotion: negativeEmotionTemp)
        
        print(tempAction)
    }
}
