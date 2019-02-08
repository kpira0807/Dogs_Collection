import UIKit
import QuartzCore

protocol DogDescription {
    var description: String { get }
}

struct Dog {
    var title: String
    var text: String
    var image: UIImage
    var type: DogSize
    var old: DogOld
    
    enum DogSize: DogDescription {
        case medium, max, mini
        
        var size: String {
            switch self {
            case .medium: return "Medium dog"
            case .max: return "Max dog"
            case .mini: return "Mini dog"
            }
        }
        
        var weight: String {
            switch self {
            case .mini: return "less 10 kg"
            case .max: return "more 25 kg"
            case .medium: return "10 - 25 kg"
            }
        }
        
        var description: String {
            return weight
        }
        static var all: [DogSize] = [.medium, .max, .mini]
        
    }
    
    enum DogOld: DogDescription {
        case centenarians, average, few
        
        var name: String {
            switch self {
            case .centenarians : return "more 14 years"
            case .average: return "10 - 14 years"
            case .few: return "less 10 years"
            }
        }
        
        var description: String {
            return name
        }
        
        static var all: [DogOld] = [.centenarians, .average, .few]
    }
}
class ListTVC: UITableViewController, AddNewDogDelegate {
    
    
    private var dogs = [
        Dog(title: "Corgi", text: "The Welsh Corgi, sometimes known as just a Corgi is a small type of herding dog that originated in Wales, United Kingdom. Two separate breeds are recognized: the Pembroke Welsh Corgi and the Cardigan Welsh Corgi. In 1925 the first Welsh Corgi was bred. Historically, the Pembroke has been attributed to the influx of dogs alongside Flemish weavers from around the 10th century, while the Cardigan is attributed to the dogs brought with Norse settlers, in particular a common ancestor of the Swedish Vallhund. A certain degree of interbreeding between the two types has been suggested to explain the similarities between the two.",  image: #imageLiteral(resourceName: "Corgi"), type: .medium, old: .centenarians),
        Dog(title: "Haski", text: "The general name for a sled-type of dog used in northern regions, differentiated from other sled-dog types by their fast pulling style. They are an ever-changing cross-breed of the fastest dogs.", image: #imageLiteral(resourceName: "Haski"), type: .max, old: .average),
        Dog(title: "Pug", text: "The Pug is a breed of dog with physically distinctive features of a wrinkly, short-muzzled face, and curled tail. The breed has a fine, glossy coat that comes in a variety of colours, most often fawn or black, and a compact square body with well-developed muscles.", image: #imageLiteral(resourceName: "Pug"), type: .mini, old: .centenarians),
        Dog(title: "Pit Bull", text: "Pit bull is the common name for a type of dog descended from bulldogs and terriers. Formal breeds often considered to be of the pit bull type include the American Pit Bull Terrier, American Staffordshire Terrier, American Bully, and Staffordshire Bull Terrier.", image: #imageLiteral(resourceName: "Pit"), type: .medium, old: .few),
        Dog(title: "Malamute", text: "The Malamute has been identified as a basal breed that predates the emergence of the modern breeds in the 19th Century. A study in 2013 showed that the Alaskan Malamute has a similar east Asian origin to, but is not clearly related to, the Greenland Dog and the Canadian Eskimo Dog, but contains a possible admixture of the Siberian Husky.", image: #imageLiteral(resourceName: "Malamute"), type: .max, old: .few),
        ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            as! MyViewCell
        let dog = dogs[indexPath.row]
        cell.titlecell?.text = dog.title
        cell.textcell?.text = dog.type.size
        cell.imagecell?.image = dog.image
        cell.aboutdog?.text = dog.text
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetail" {
            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else { return }
            let dog = dogs[indexPath.row]
            if let detailVC: DetailVC = segue.destination as? DetailVC {
                detailVC.dog = dog
            }
        } else if segue.identifier == "newBreedAdd" {
            let navController = segue.destination as? UINavigationController
            let addNewBreed = navController?.topViewController as? AddNewDog
            addNewBreed?.delegate = self
        }
    }
    
    func addnewdog(with breedNewDog: Dog) {
        dogs.append(breedNewDog)
        self.tableView.reloadData()
    }
    
    //кнопка удаления ячейки любым человеком
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.dogs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

class DetailVC: UIViewController {
    
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textViewInfo: UITextView!
    
    var dog: Dog?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        imageViewPhoto.layer.cornerRadius = 10
        imageViewPhoto.layer.masksToBounds = true
        guard let dog = dog else { return }
        title = dog.title
        imageViewPhoto.image   = dog.image
        labelTitle.text        = "Average weight of dogs: \(dog.type.weight) Average age of dogs: \(dog.old.name)"
        textViewInfo.text      = dog.text;
    }
    
}
