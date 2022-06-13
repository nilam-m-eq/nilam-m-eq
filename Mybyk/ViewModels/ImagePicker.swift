//
//  ImagePicker.swift
//  Mybyk
//
//  Created by Parth Kapadia on 30/06/21.
//

import UIKit

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?,data: Data?)
  //  func ShowAlert(image: uialerv?)
}

class ImagePicker: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?,imagedata data: Data)
    {
        controller.dismiss(animated: true, completion: nil)
        
        let alrt = UIAlertController(title: "", message:"Are you sure you want to upload this file" , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.default) { alert in
            
        }
        let action1 = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { alert in
            
          //  self.del
            self.delegate?.didSelect(image: image, data: data)
        }
        alrt.addAction(action)
        alrt.addAction(action1)
        self.presentationController?.present(alrt, animated: true)
        
       // self.delegate.ShowAlert(alert: alrt)
        
    }
    
}
extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }

    func compress(to kb: Int, allowedMargin: CGFloat = 0.2) -> Data {
        let bytes = kb * 1024
        var compression: CGFloat = 1.0
        let step: CGFloat = 0.05
        var holderImage = self
        var complete = false
        while(!complete) {
            if let data = holderImage.jpegData(compressionQuality: 1.0) {
                let ratio = data.count / bytes
                if data.count < Int(CGFloat(bytes) * (1 + allowedMargin)) {
                    complete = true
                    return data
                } else {
                    let multiplier:CGFloat = CGFloat((ratio / 5) + 1)
                    compression -= (step * multiplier)
                }
            }
            
            guard let newImage = holderImage.resized(withPercentage: compression) else { break }
            holderImage = newImage
        }
        return Data()
    }
}
extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true)
      //  controller.dismiss(animated: true, completion: nil)
     //   let data = Data()
     //   self.pickerController(picker, didSelect: nil,imagedata:data)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
       /* guard let image = info[.editedImage] as? UIImage else
        {
            return self.pickerController(picker, didSelect: nil)
        }
        print(image.imageSize as Any)
        print(image.imageData?.count as Any)
        self.pickerController(picker, didSelect: image)
    }*/
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {return}
        
        print(mediaType)
        
        switch mediaType
        {
        case "public.movie":
           
            break
            
        case "public.image":
            // Handle Image here
            let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
           // let imageData =
            //UIImageJPEGRepresentation(tempImage, 0.2)
            
          /*  if let data:Data = tempImage.jpegData(compressionQuality: 1.0) {
                print(data.count)
                self.pickerController(picker, didSelect: tempImage,imagedata: data)
              
            }*/
            let data = tempImage.compress(to: 300)
            self.pickerController(picker, didSelect: tempImage,imagedata: data)
            
           /* if let data:Data = tempImage.pngData() {
                  print("DATA COUNT",data.count)
                  self.pickerController(picker, didSelect: tempImage,imagedata: data)
            }*/
          //  print(tempImage.imageSize ?? 0)
          //  print(tempImage.imageData?.count ?? 0)
            break
            
        default:
            break
        }
        //self.dismiss(animated: true, completion: nil)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}




