//
//  UIImage+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 05/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    /**
     Returns true if the image has an alpha layer.
     Returns `nil` if unable to determine.
     - Note: Based on [this](https://github.com/mbcharbonneau/UIImage-Categories/blob/master/UIImage%2BAlpha.m) snippet.
     */
    var hasAlpha: Bool? {
        guard let cgImage = cgImage else { return nil }
        let alphaInfo = cgImage.alphaInfo
        let first = alphaInfo == .first
        let last = alphaInfo == .last
        let premultipliedFirst = alphaInfo == .premultipliedFirst
        let premultipliedLast = alphaInfo == .premultipliedLast
        let alphaOnly = alphaInfo == .alphaOnly
        return first || last || premultipliedFirst || premultipliedLast || alphaOnly
    }

    /**
     Returns scaled UIImage with given ratio.
     - parameter ratio: scale ratio
     - returns: Optional scaled UIImage
     - Note: See also [http://nshipster.com/image-resizing/](http://nshipster.com/image-resizing/).
     */
    func scaledImage(ratio: CGFloat) -> UIImage? {
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let drawRect = CGRect(origin: CGPoint.zero, size: newSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0); defer { UIGraphicsEndImageContext() }
        draw(in: drawRect)
        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(renderingMode)
    }

    /**
     Returns scaled UIImage with given width.
     - parameter width: new width
     - returns: Optional scaled UIImage
     - Note: See also [http://nshipster.com/image-resizing/](http://nshipster.com/image-resizing/).
     */
    func scaledImage(width: CGFloat) -> UIImage? {
        let widthToHeightRatio = size.width / size.height
        let newSize = CGSize(width: width, height: width / widthToHeightRatio)
        let drawRect = CGRect(origin: CGPoint.zero, size: newSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0); defer { UIGraphicsEndImageContext() }
        draw(in: drawRect)
        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(renderingMode)
    }
}
