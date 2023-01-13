import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<ContentStore>
    
    var body: some View {
        WithViewStore(store) { contentStore in
            VStack {
                Button {
                    print("push")
                    contentStore.send(.push)
                } label: {
                    Text("push")
                }
                Button {
                    print("modal")
                    contentStore.send(.modal)
                } label: {
                    Text("modal")
                }
                Button {
                    print("moveToRandom")
                    contentStore.send(.random)
                } label: {
                    Text("random")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: ContentStore.State(),
                reducer: ContentStore()
            )
        )
    }
}
