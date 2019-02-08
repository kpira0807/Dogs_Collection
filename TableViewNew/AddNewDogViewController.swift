import UIKit
import os.log

protocol AddNewDogDelegate: class{
    func addnewdog(with breedNewDog: Dog)
}

class AddNewDog: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dogsParams[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dogsParams.count
    }
    
    @IBOutlet weak var aboutBreedTextField: UITextView!
    @IBOutlet weak var breedNewTextField: UITextField!
    @IBOutlet weak var dogSizePickerView: UIPickerView!
    @IBOutlet weak var imageForNewDog: UIImageView!
    @IBOutlet weak var labelForPickerView: UILabel!
    
    weak var delegate: AddNewDogDelegate? = nil
    private var dogOld: Dog.DogOld? = Dog.DogOld.all.first
    private var dogSize: Dog.DogSize? = Dog.DogSize.all.first
    
    @IBAction func cancelViewController(_ segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveDetail(_ segue: UIButton) {
        
        guard let aboutBreedText = aboutBreedTextField.text,
            !aboutBreedText.isEmpty,
            let breedNewText = breedNewTextField.text,
            let dogOldNew = dogOld,
            let dogSizeNew = dogSize,
            let imageNewBreed = imageForNewDog.image
            else {
                AlertError(with: ErrorMessege.cell)
                return
        }
        
        let breedNewDog = Dog(title: breedNewText, text: aboutBreedText, image: imageNewBreed, type: dogSizeNew, old: dogOldNew)
        
        delegate?.addnewdog(with: breedNewDog)
        
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func AlertError(with type: ErrorMessege) {
        let myAlert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    var dogsParams: [[DogDescription]] = [Dog.DogOld.all, Dog.DogSize.all]
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dogSizePickerView.delegate = self
        dogSizePickerView.dataSource = self
        imageForNewDog.isUserInteractionEnabled = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // что будет показывать колесо
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dogsParams[component][row].description
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25.0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        if let old = dogsParams[component][row] as? Dog.DogOld {
            dogOld = old
        } else if let size = dogsParams[component][row] as? Dog.DogSize {
            dogSize = size
        }
        labelForPickerView.text = """
        Average age of dogs: \(dogOld?.name ?? "--"),
        Average weight of dogs: \(dogSize?.weight ?? "--")
        """
    }
    // для фотографии
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        guard let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imageForNewDog.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectphoto(_ sender: UITapGestureRecognizer) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
