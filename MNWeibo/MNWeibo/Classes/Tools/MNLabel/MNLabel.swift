//
//  MNLabel.swift
//  MNWeibo
//
//  Created by miniLV on 2019/6/20.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

@objc
public protocol MNLabelDelegate: NSObjectProtocol {
    /// 选中链接文本
    ///
    /// - parameter label: label
    /// - parameter text:  选中的文本
    @objc optional func labelDidSelectedLinkText(label: MNLabel, text: String)
}

public class MNLabel: UILabel {

    public var linkTextColor = UIColor.init(rgb: 0x647cad)
    public var selectedBackgroudColor = UIColor.lightGray
    public weak var delegate: MNLabelDelegate?
    
    // MARK: - override properties
    override public var text: String? {
        didSet {
            updateTextStorage()
        }
    }
    
    override public var attributedText: NSAttributedString? {
        didSet {
            updateTextStorage()
        }
    }
    
    override public var font: UIFont! {
        didSet {
            updateTextStorage()
        }
    }
    
    override public var textColor: UIColor! {
        didSet {
            updateTextStorage()
        }
    }
    
    // MARK: - upadte text storage and redraw text
    private func updateTextStorage() {
        if attributedText == nil {
            return
        }

        let attrStringM = addLineBreak(attributedText!)
        regexLinkRanges(attrStringM)
        addLinkAttribute(attrStringM)
        
        textStorage.setAttributedString(attrStringM)
        
        setNeedsDisplay()
    }
    
    public override func drawText(in rect: CGRect) {
        let range = glyphsRange()
        let offset = glyphsOffset(range)

        layoutManager.drawBackground(forGlyphRange: range, at: offset)
        layoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint.zero)
    }
    
    private func glyphsRange() -> NSRange {
        return NSRange(location: 0, length: textStorage.length)
    }
    
    private func glyphsOffset(_ range: NSRange) -> CGPoint {
        let rect = layoutManager.boundingRect(forGlyphRange: range, in: textContainer)
        let height = (bounds.height - rect.height) * 0.5
        
        return CGPoint(x: 0, y: height)
    }
    
    private func modifySelectedAttribute(_ isSet: Bool) {
        if selectedRange == nil {
            return
        }
        
        var attributes = textStorage.attributes(at: 0, effectiveRange: nil)
        attributes[NSAttributedString.Key.foregroundColor] = linkTextColor
        let range = selectedRange!
        
        if isSet {
            attributes[NSAttributedString.Key.backgroundColor] = selectedBackgroudColor
        } else {
            attributes[NSAttributedString.Key.backgroundColor] = UIColor.clear
            selectedRange = nil
        }
        
        textStorage.addAttributes(attributes, range: range)
        
        setNeedsDisplay()
    }
    
    private func linkRangeAtLocation(_ location: CGPoint) -> NSRange? {
        if textStorage.length == 0 {
            return nil
        }
        
        let offset = glyphsOffset(glyphsRange())
        let point = CGPoint(x: offset.x + location.x, y: offset.y + location.y)
        let index = layoutManager.glyphIndex(for: point, in: textContainer)
        
        for range in linkRanges {
            if index >= range.location && index <= range.location + range.length {
                return range
            }
        }
        
        return nil
    }
    
    // MARK: - init functions
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareLabel()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        prepareLabel()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        textContainer.size = bounds.size
    }
    
    private func prepareLabel() {
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        textContainer.lineFragmentPadding = 0
        isUserInteractionEnabled = true
    }
    
    // MARK: lazy properties
    private lazy var linkRanges = [NSRange]()
    private var selectedRange: NSRange?
    private lazy var textStorage = NSTextStorage()
    private lazy var layoutManager = NSLayoutManager()
    private lazy var textContainer = NSTextContainer()
}

//MARK: - Touch Event
extension MNLabel{
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        
        selectedRange = linkRangeAtLocation(location)
        modifySelectedAttribute(true)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        
        if let range = linkRangeAtLocation(location) {
            if !(range.location == selectedRange?.location && range.length == selectedRange?.length) {
                modifySelectedAttribute(false)
                selectedRange = range
                modifySelectedAttribute(true)
            }
        } else {
            modifySelectedAttribute(false)
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if selectedRange != nil {
            let text = (textStorage.string as NSString).substring(with: selectedRange!)
            delegate?.labelDidSelectedLinkText?(label: self, text: text)
            
            let when = DispatchTime.now() + Double(Int64(0.25 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.modifySelectedAttribute(false)
            }
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        modifySelectedAttribute(false)
    }
}

//MARK: - Link attribute
private extension MNLabel{
    
    func addLinkAttribute(_ attrStringM: NSMutableAttributedString) {
        if attrStringM.length == 0 {
            return
        }
        
        var range = NSRange(location: 0, length: 0)
        var attributes = attrStringM.attributes(at: 0, effectiveRange: &range)
        
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        attrStringM.addAttributes(attributes, range: range)
        
        attributes[NSAttributedString.Key.foregroundColor] = linkTextColor
        
        for range in linkRanges {
            attrStringM.setAttributes(attributes, range: range)
        }
    }
    
    func regexLinkRanges(_ attrString: NSAttributedString) {
        linkRanges.removeAll()
        
        //FIXME: regexRange
        /// use regex check all link ranges
        let patterns = ["[a-zA-Z]*://[a-zA-Z0-9/\\.]*", //url
            "#.*?#",//话题
            "@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*"]//@xxx
        let regexRange = NSRange(location: 0, length: attrString.string.count)
        for pattern in patterns {
            let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.dotMatchesLineSeparators)
            let results = regex.matches(in: attrString.string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: regexRange)
            
            for range in results {
                linkRanges.append(range.range(at: 0))
            }
        }
    }
    
    /// add line break mode
    private func addLineBreak(_ attrString: NSAttributedString) -> NSMutableAttributedString {
        let attrStringM = NSMutableAttributedString(attributedString: attrString)
        
        if attrStringM.length == 0 {
            return attrStringM
        }
        
        var range = NSRange(location: 0, length: 0)
        var attributes = attrStringM.attributes(at: 0, effectiveRange: &range)
        var paragraphStyle = attributes[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle
        
        if paragraphStyle != nil {
            paragraphStyle!.lineBreakMode = NSLineBreakMode.byWordWrapping
        } else {
            // iOS 8.0 can not get the paragraphStyle directly
            paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle!.lineBreakMode = NSLineBreakMode.byWordWrapping
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
            
            attrStringM.setAttributes(attributes, range: range)
        }
        
        return attrStringM
    }
}
