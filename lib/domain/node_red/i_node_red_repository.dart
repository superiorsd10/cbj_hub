/// Class to define all Node RED repo functions
abstract class INodeRedRepository {
  /// Function to create new scene in Node-RED
  Future<void> createNewScene(String label, String jsonOfNodes);
}
