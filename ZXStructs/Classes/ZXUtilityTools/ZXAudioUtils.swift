//
//  ZXAudioUtils.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import AudioToolbox

public class ZXAudioUtils: NSObject {

    public class func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }

    public class func play(forResource resouce:String?,ofType type:String?) {
        if let file = Bundle.main.path(forResource: resouce, ofType: type) {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(URL.init(fileURLWithPath: file) as CFURL, &soundId)
            self.play(withId: soundId)
        }
    }
    
    public class func play(withId id: SystemSoundID) {
        AudioServicesPlaySystemSound(id)
    }
    
    
}
