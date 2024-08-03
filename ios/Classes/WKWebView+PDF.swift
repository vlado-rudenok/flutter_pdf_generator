import WebKit

extension WKWebView {
    
    func exportAsPdfFromWebView(
        savedPath: String, 
        format: Dictionary<String, Double>,
        margins: Dictionary<String, Double>,
        footerText: String?,
        headerText: String?) -> String? {

        let width = CGFloat(format["width"] ?? 8.27).toPixel()
        let height = CGFloat(format["height"] ?? 11.27).toPixel()

        let top = margins["top"] ?? 0.0
        let left = margins["left"] ?? 0.0
        let bottom = margins["bottom"] ?? 0.0
        let right = margins["right"] ?? 0.0
        

        let page = CGRect(x: 0, y: 0, width: width, height: height )
        let printable = page.insetBy(dx: 0, dy: 0)
        let render = CustomPrintPageRenderer(headerText: headerText, footerText: footerText)
        let formatter = self.viewPrintFormatter()
        formatter.perPageContentInsets = UIEdgeInsets(
            top: height * top, 
            left: width * left, 
            bottom: height * bottom, 
            right: width * right)
        
        render.addPrintFormatter(formatter, startingAtPageAt: 0)
        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
        let pdfData = render.generatePdfData()
        let path = self.saveWebViewPdf(data: pdfData, savedPath: savedPath)
        return path
    }
    
    func saveWebViewPdf(data: NSMutableData, savedPath: String) -> String? {
        if let url = URL.init(string: savedPath), data.write(toFile: savedPath, atomically: true) {
            return url.path
        } else {
            return nil
        }
    }
}

extension CGFloat{
    func toPixel() -> CGFloat {
        if(self>0){
            return self * 96
        }
        return 0
    }
}