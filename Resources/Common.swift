//
//  Common.swift
//  Trela
//
//  Created by Kalissaac on 6/3/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import Foundation
import UIKit

func CGAffineTransformMakeDegreeRotation(_ rotation: CGFloat) -> CGAffineTransform {
    return CGAffineTransform(rotationAngle: rotation * CGFloat(Double.pi / 180))
}

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

func convertValue(_ value: CGFloat, r1Min: CGFloat, r1Max: CGFloat, r2Min: CGFloat, r2Max: CGFloat) -> CGFloat {
    let ratio = (r2Max - r2Min) / (r1Max - r1Min)
    return value * ratio + r2Min - r1Min * ratio
}

public let languageIDs = ["English (en)", "Español (es)", "Français (fr)", "Português (pt)", "Italiano (it)", "Deutsche (de)", "简体中文 (zh-Hans)", "中国传统的 (zh-Hant)", "Nederlands (nl)", "日本語 (ja)", "한국어 (ko)", "Tiếng Việt (vi)", "русский (ru)", "svensk (sv)", "dansk (da)", "suomalainen (fi)", "Norsk [bokmål] (nb)", "Türk (tr)", "ελληνικά (el)", "bahasa Indonesia (id)", "melayu (ms)", "ไทย (th)", "हिंदी (hi)"]

public let radiusIDs = ["1 mile", "2 miles","5 miles", "10 miles", "15 miles"]
