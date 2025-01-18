import SwiftUI
import RichText

struct RichTextView: View {
    @State var html = ""
    
    var body: some View {
       ScrollView{
            RichText(html: html)
                .lineHeight(170)
                .colorScheme(.auto)
                .linkColor(light: Color.accentColor, dark: Color.accentColor)
                .colorPreference(forceColor: .onlyLinks)
                .linkOpenType(.SFSafariView())
                .transition(.easeIn)
        }
    }
}

struct RichText_Test_Previews: PreviewProvider {
    static var previews: some View {
        RichTextView()
    }
}
