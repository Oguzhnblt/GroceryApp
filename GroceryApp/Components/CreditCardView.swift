import SwiftUI

struct CreditCardView: View {
    var body: some View {
        VStack {
            // Kartın üst kısmındaki çip
            HStack {
                Image(systemName: "rectangle.grid.1x2.fill")
                    .resizable()
                    .frame(width: 50, height: 40)
                    .foregroundColor(.yellow)
                Spacer()
            }
            .padding(.top, 20)
            .padding(.leading, 20)

            Spacer()

            // Kart Numarası
            HStack(spacing: 10) {
                ForEach(0..<4) { _ in
                    Text("****")
                        .font(.title)
                        .foregroundColor(.white)
                }
                Text("5807")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 10)

            // Kart Sahibi ve Son Kullanma Tarihi
            HStack {
                VStack(alignment: .leading) {
                    Text("Card Holder")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("Ingrid Hitchens")
                        .font(.title2)
                        .foregroundColor(.white)
                }

                Spacer()

                VStack(alignment: .leading) {
                    Text("Expires")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("07/24")
                        .font(.title2)
                        .foregroundColor(.white)
                }

                Spacer()

                VStack(alignment: .leading) {
                    Text("CVV")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("017")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(width: 350, height: 200)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

#Preview {
    CreditCardView()
}
