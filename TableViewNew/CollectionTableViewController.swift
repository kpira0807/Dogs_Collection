import UIKit
import os.log

protocol AddDogCollectionDelegate: class {
    func adddogcollection(with breedDogCollection: Dog)
}

class CollectionTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addDogsParams[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return addDogsParams.count 
    }
    
    @IBOutlet weak var addImageCollection: UIImageView!
    @IBOutlet weak var addTitleCollection: UITextField!
    @IBOutlet weak var addPickerCollection: UIPickerView!
    @IBOutlet weak var addPickerText: UILabel!
    @IBOutlet weak var addTextCollection: UITextView!
    
    var addDogsParams: [[DogDescription]] = [Dog.DogOld.all, Dog.DogSize.all]
    
    weak var delegate: AddDogCollectionDelegate? = nil
    
    private var addDogOld: Dog.DogOld? = Dog.DogOld.all.first
    private var addDogSize: Dog.DogSize? = Dog.DogSize.all.first
    
    @IBAction func cancelController(_ segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveDetailCollection(_ segue: UIButton) {
        
        guard let addAboutBreedText = addTextCollection.text,
            !addAboutBreedText.isEmpty,
            let addTitleText = addTitleCollection.text,
            let addOldNew = addDogOld,
            let addSizeNew = addDogSize,
            let addImageCollection = addImageCollection.image
            else {
                AlertError(with: ErrorMessege.cell)
                return
        }
        
        let breedDogCollection = Dog(title: addTitleText, text: addAboutBreedText, image: addImageCollection, type: addSizeNew, old: addOldNew)
        
        delegate?.adddogcollection(with: breedDogCollection)
        
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func AlertError(with type: ErrorMessege) {
        let myAlert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addPickerCollection.delegate = self
        addPickerCollection.dataSource = self
        addImageCollection.isUserInteractionEnabled = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return addDogsParams[component][row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        if let old = addDogsParams[component][row] as? Dog.DogOld {
            addDogOld = old
        } else if let size = addDogsParams[component][row] as? Dog.DogSize {
            addDogSize = size
        }
        addPickerText.text = """
        Average age of dogs: \(addDogOld?.name ?? "--"),
        Average weight of dogs: \(addDogSize?.weight ?? "--")
        """
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        guard let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        addImageCollection.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
