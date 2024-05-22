import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ContentView: View {
    @State var furnitureName: String
    var furnitureScale: Float
    var isWallDecoration: Bool
    var category: String // Tambahkan parameter kategori
    

    
    @State private var statusText: String = "Identifying Area"
    @State private var isCatalogOpen: Bool = false
    @State private var displayedModel: String = "" // Default model yang ditampilkan


    var body: some View {
        ZStack {
            ARViewContainer(furnitureName: $furnitureName, furnitureScale: furnitureScale, isWallDecoration: isWallDecoration, statusText: $statusText, displayedModel: $displayedModel)
                .edgesIgnoringSafeArea(.all)
            
            Text(statusText)
                .font(.headline)
                .padding()
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
                .padding()
                .position(x: UIScreen.main.bounds.width / 2, y: 50)
            
            if isCatalogOpen {
                            // Sediakan parameter kategori saat membuat instance CatalogView
                            CatalogView(isOpen: $isCatalogOpen, onSelectModel: { selectedModel in
                                // Tambahkan logika untuk menambahkan model terpilih ke ARView
                                print("Selected model: \(selectedModel)")
                                displayedModel = selectedModel
                                furnitureName = displayedModel
                                print("selected model furniturename: \(furnitureName)")
                            }, category: category) // Tambahkan parameter kategori
                            .edgesIgnoringSafeArea(.all)
                        }
                        Button(action: {
                            isCatalogOpen.toggle()
                        }) {
                            Text("Open Catalog")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .position(x: 100, y: UIScreen.main.bounds.height - 150)
                    }
                }
            }

struct ARViewContainer: UIViewRepresentable {
    @Binding var furnitureName: String // Ubah menjadi Binding
    var furnitureScale: Float
    var isWallDecoration: Bool
    @Binding var statusText: String
    @Binding var displayedModel: String // Tambahkan Binding untuk model yang ditampilkan


    class Coordinator: NSObject, UIGestureRecognizerDelegate, ARSessionDelegate {
        var arView: ARView?
        var modelEntity: ModelEntity?
        var focusEntity: FocusEntity?
        var furnitureName: String
        var furnitureScale: Float
        var isWallDecoration: Bool
        @Binding var statusText: String
        var detectedPlaneCount: Int = 0

        init(furnitureName: String, furnitureScale: Float, isWallDecoration: Bool, statusText: Binding<String>) {
            self.furnitureName = furnitureName
            self.furnitureScale = furnitureScale
            self.isWallDecoration = isWallDecoration
            self._statusText = statusText
        }

        @objc func addObject() {
            guard let arView = arView else { return }

            // Load the USDZ model
            guard let modelEntity = try? Entity.loadModel(named: furnitureName) else {
                fatalError("Unable to load model named \(furnitureName)")
            }

            // Set model scale
            modelEntity.scale = SIMD3<Float>(furnitureScale, furnitureScale, furnitureScale)

            // Store the model entity for later use
            self.modelEntity = modelEntity

            // Place the model at the current focus entity position
            if let focusEntity = focusEntity {
                placeModel(at: focusEntity.position(relativeTo: nil))
            }
        }

        @objc func rotateObjectRight() {
            rotateObject(by: 10)
        }

        @objc func rotateObjectLeft() {
            rotateObject(by: -30)
        }

        func rotateObject(by degrees: Float) {
            guard let modelEntity = modelEntity else { return }
            let radians = degrees * (Float.pi / 180)
            modelEntity.transform.rotation *= simd_quatf(angle: radians, axis: [0, 1, 0])
        }

        func setupGestures() {
            guard let arView = arView else { return }

            // Tap Gesture
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            arView.addGestureRecognizer(tapGesture)

            // Pan Gesture
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            arView.addGestureRecognizer(panGesture)
        }

        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let arView = arView, let modelEntity = modelEntity else { return }

            let tapLocation = gesture.location(in: arView)
            let query: ARRaycastQuery?
            if isWallDecoration {
                query = arView.makeRaycastQuery(from: tapLocation, allowing: .existingPlaneGeometry, alignment: .vertical)
            } else {
                query = arView.makeRaycastQuery(from: tapLocation, allowing: .existingPlaneGeometry, alignment: .horizontal)
            }

            guard let raycastQuery = query else { return }
            let results = arView.session.raycast(raycastQuery)
            if let firstResult = results.first {
                let worldTransform = firstResult.worldTransform
                let position = SIMD3<Float>(worldTransform.columns.3.x, worldTransform.columns.3.y, worldTransform.columns.3.z)
                placeModel(at: position)
            }
        }

        func placeModel(at position: SIMD3<Float>) {
            guard let arView = arView, let modelEntity = modelEntity else { return }

            // Remove previous anchor if any
            if let previousAnchor = arView.scene.anchors.first(where: { $0.children.contains(modelEntity) }) {
                arView.scene.removeAnchor(previousAnchor)
            }

            // Create a new anchor and add the model entity
            let anchor = AnchorEntity(world: position)
            anchor.addChild(modelEntity)
            arView.scene.addAnchor(anchor)
        }

        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let arView = arView, let modelEntity = modelEntity else { return }

            let translation = gesture.translation(in: arView)
            let rotation = Float(translation.x) * 0.01 // Adjust rotation speed as needed

            if gesture.state == .changed {
                modelEntity.transform.rotation *= simd_quatf(angle: rotation, axis: [0, 1, 0])
            }

            gesture.setTranslation(.zero, in: arView)
        }

        // ARSessionDelegate method to track added anchors
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                if anchor is ARPlaneAnchor {
                    DispatchQueue.main.async {
                        self.detectedPlaneCount += 1
                        self.statusText = "Ready to Use"
                    }
                }
            }
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            // You can add any additional logic here if needed
        }

        func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
            for anchor in anchors {
                if anchor is ARPlaneAnchor {
                    DispatchQueue.main.async {
                        self.detectedPlaneCount -= 1
                        if self.detectedPlaneCount == 0 {
                            self.statusText = "Identifying Area"
                        }
                    }
                }
            }
        }
        
        func session(_ session: ARSession, didFailWithError error: Error) {
            DispatchQueue.main.async {
                self.statusText = "Identifying Area"
            }
        }
        
        func sessionWasInterrupted(_ session: ARSession) {
            DispatchQueue.main.async {
                self.statusText = "Identifying Area"
            }
        }
        
        func sessionInterruptionEnded(_ session: ARSession) {
            DispatchQueue.main.async {
                self.statusText = "Identifying Area"
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(furnitureName: furnitureName, furnitureScale: furnitureScale, isWallDecoration: isWallDecoration, statusText: $statusText)
    }

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        context.coordinator.arView = arView
        arView.session.delegate = context.coordinator

        // Run the AR session with plane detection
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = isWallDecoration ? [.vertical] : [.horizontal]
        arView.session.run(configuration)

        // Initialize FocusEntity
        let focusEntity = FocusEntity(on: arView, style: .classic(color: .yellow))
        context.coordinator.focusEntity = focusEntity

        // Add the buttons to the ARView
        let addButton = UIButton(type: .system)
        addButton.setTitle("Place Object", for: .normal)
        addButton.backgroundColor = .white
        addButton.setTitleColor(.black, for: .normal)
        addButton.addTarget(context.coordinator, action: #selector(Coordinator.addObject), for: .touchUpInside)
        addButton.layer.cornerRadius = 10
        addButton.clipsToBounds = true

        let rotateRightButton = UIButton(type: .system)
        rotateRightButton.setTitle("➡️", for: .normal)
        rotateRightButton.backgroundColor = .white
        rotateRightButton.setTitleColor(.black, for: .normal)
        rotateRightButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateObjectRight), for: .touchUpInside)
        rotateRightButton.layer.cornerRadius = 10
        rotateRightButton.clipsToBounds = true

        let rotateLeftButton = UIButton(type: .system)
        rotateLeftButton.setTitle("⬅️", for: .normal)
        rotateLeftButton.backgroundColor = .white
        rotateLeftButton.setTitleColor(.black, for: .normal)
        rotateLeftButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateObjectLeft), for: .touchUpInside)
        rotateLeftButton.layer.cornerRadius = 10
        rotateLeftButton.clipsToBounds = true

        // Position the buttons in ARView
        addButton.translatesAutoresizingMaskIntoConstraints = false
        rotateRightButton.translatesAutoresizingMaskIntoConstraints = false
        rotateLeftButton.translatesAutoresizingMaskIntoConstraints = false

        arView.addSubview(addButton)
        arView.addSubview(rotateRightButton)
        arView.addSubview(rotateLeftButton)

        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: arView.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: arView.bottomAnchor, constant: -50),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.heightAnchor.constraint(equalToConstant: 50),

            rotateRightButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            rotateRightButton.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 20),
            rotateRightButton.widthAnchor.constraint(equalToConstant: 50),
            rotateRightButton.heightAnchor.constraint(equalToConstant: 50),

            rotateLeftButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            rotateLeftButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -20),
            rotateLeftButton.widthAnchor.constraint(equalToConstant: 50),
            rotateLeftButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        context.coordinator.setupGestures()

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

#Preview {
    ContentView(furnitureName: "Wooden_Chair", furnitureScale: 0.0095, isWallDecoration: false, category: "chair")
}
