class CustomPrintPageRenderer: UIPrintPageRenderer {
    
    var headerHeightValue: CGFloat
    var footerHeightValue: CGFloat

    let headerText: String?
    let footerText: String?

    init(headerText: String?, footerText: String?, headerHeightValue: CGFloat = 50.0, footerHeightValue: CGFloat = 50.0) {
        self.headerText = headerText
        self.footerText = footerText
        self.headerHeightValue = headerText != nil ? headerHeightValue : 0
        self.footerHeightValue = footerText != nil ? footerHeightValue : 0
    }
    
    override var headerHeight: CGFloat {
        get {
            headerHeightValue
        }
        set {
            headerHeightValue = newValue
        }
    }
    
    override var footerHeight: CGFloat {
        get {
            footerHeightValue
        }
        set {
            footerHeightValue = newValue
        }
    }
    override func drawHeaderForPage(at pageIndex: Int, in headerRect: CGRect) {
        guard let headerText else {
            super.drawHeaderForPage(at: pageIndex, in: headerRect)
            return
        }

        // Create paragraph style with center alignment and truncating tail
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.gray,
            .paragraphStyle: paragraphStyle
        ]

        // Calculate the size of the text
        let textSize = headerText.size(withAttributes: attributes)

        // Add padding (20px on both sides)
        let horizontalPadding: CGFloat = 20

        // Calculate the drawing rectangle centered within the headerRect with padding
        let textRect = CGRect(
            x: headerRect.origin.x + horizontalPadding,
            y: headerRect.midY - (textSize.height / 2),
            width: headerRect.width - 2 * horizontalPadding,
            height: textSize.height
        ).integral // Ensures the rectangle uses whole numbers for coordinates and size

        // Convert headerText to NSString to use draw method
        let nsHeaderText = headerText as NSString

        // Draw the text in the centered rect with truncation
        nsHeaderText.draw(in: textRect, withAttributes: attributes)
    }

    override func drawFooterForPage(at pageIndex: Int, in footerRect: CGRect) {
        guard let footerText else {
            super.drawFooterForPage(at: pageIndex, in: footerRect)
            return
        }
        let text = "\(footerText) \(pageIndex + 1)"
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]

        let textSize = text.size(withAttributes: attributes)
        let textRect = CGRect(x: footerRect.midX - textSize.width / 2, y: footerRect.midY - textSize.height / 2, width: textSize.width, height: textSize.height)

        text.draw(in: textRect, withAttributes: attributes)
    }

    func generatePdfData() -> NSMutableData {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, self.paperRect, nil)
        self.prepare(forDrawingPages: NSMakeRange(0, self.numberOfPages))
        let printRect = UIGraphicsGetPDFContextBounds()
        for pdfPage in 0..<self.numberOfPages {
            UIGraphicsBeginPDFPage()
            self.drawPage(at: pdfPage, in: printRect)
        }
        UIGraphicsEndPDFContext();
        return pdfData
    }
}