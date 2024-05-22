import SwiftUI

struct CatalogView: View {
    @Binding var isOpen: Bool
    var onSelectModel: (String) -> Void
    var category: String // Menambahkan parameter untuk kategori model
    
    var models: [String] {
        // Menyesuaikan daftar model berdasarkan kategori yang dipilih
        switch category {
        case "chair":
            return ["chair1", "chair2", "chair3", "chair4", "chair5"]
        case "table":
            return ["table1", "table2", "table3", "table4", "table5"]
        case "drawer":
            return ["drawer1", "drawer2", "drawer3", "drawer4", "drawer5"]
        case "wardrobe":
            return ["wardrobe1", "wardrobe2", "wardrobe3", "wardrobe4", "wardrobe5"]
        case "wallDecoration":
            return ["wall1", "wall2", "wall3", "wall4", "wall5"]
        default:
            return [] // Default kosong jika kategori tidak ditemukan
        }
    }
    
    var body: some View {
        VStack {
            Text("Select a model")
                .font(.headline)
                .padding()
            
            ScrollView {
                ForEach(models, id: \.self) { model in
                    Button(action: {
                        onSelectModel(model)
                        isOpen = false // Tutup katalog setelah memilih
                    }) {
                        Text(model)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .padding(5)
                }
            }
            .padding()
            
            Button(action: {
                isOpen = false // Tutup katalog tanpa memilih
            }) {
                Text("Close")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
