import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView() {
                    HStack(alignment: .center) {
                        Text("Aired today")
                            .font(.title2)
                            .bold()
                            .padding(.leading)
                        Spacer()
                    }.padding(.top)
                    

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<10) { _ in
                                VStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 100, height: 150)
                                        .foregroundColor(.gray)
                                    Text("Show's name")
                                        .font(.caption)
                                }
                            }
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
            .navigationTitle("TVMaze")
            .navigationBarItems(trailing: Image(systemName: "magnifyingglass"))
        }
    }
}

#Preview {
    HomeView()
}
