import Foundation
import UIKit
import MobileCoreServices

class ImagePickerViewController: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var imagePickerController: UIImagePickerController?
    private var imageCompletionHandler: ((String?) -> Void)?
    private var videoCompletionHandler: ((String?) -> Void)?
    
    func pickImageFromGallery(completion: @escaping (String?) -> Void) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            completion(nil)
            return
        }
        
        imagePickerController = UIImagePickerController()
        imagePickerController?.sourceType = .photoLibrary
        imagePickerController?.delegate = self
        imagePickerController?.mediaTypes = [kUTTypeImage as String]
        
        imageCompletionHandler = completion
        
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self.imagePickerController!, animated: true, completion: nil)
        }
    }
    
    func pickVideoFromGallery(completion: @escaping (String?) -> Void) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            completion(nil)
            return
        }
        
        imagePickerController = UIImagePickerController()
        imagePickerController?.sourceType = .photoLibrary
        imagePickerController?.delegate = self
        imagePickerController?.mediaTypes = [kUTTypeMovie as String]
        
        videoCompletionHandler = completion
        
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self.imagePickerController!, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            let imagePath = saveImageToDocumentsDirectory(image: image)
            imageCompletionHandler?(imagePath)
        }
        
        if let videoURL = info[.mediaURL] as? URL {
            let videoPath = saveVideoToDocumentsDirectory(videoURL: videoURL)
            videoCompletionHandler?(videoPath)
        }
        
        imagePickerController = nil
        imageCompletionHandler = nil
        videoCompletionHandler = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
        imageCompletionHandler?(nil)
        videoCompletionHandler?(nil)
        
        imagePickerController = nil
        imageCompletionHandler = nil
        videoCompletionHandler = nil
    }
    
    private func saveImageToDocumentsDirectory(image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return nil
        }
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".jpg"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try imageData.write(to: fileURL)
            return fileURL.path
        } catch {
            return nil
        }
    }
    
    private func saveVideoToDocumentsDirectory(videoURL: URL) -> String? {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".mp4"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try fileManager.copyItem(at: videoURL, to: fileURL)
            return fileURL.path
        } catch {
            return nil
        }
    }
}
