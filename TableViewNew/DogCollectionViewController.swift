import UIKit

private let reuseIdentifier = "CollectionCell"

class DogCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var dogs = [
        Dog(title: "Corgi", text: "The Welsh Corgi, sometimes known as just a Corgi is a small type of herding dog that originated in Wales, United Kingdom. Two separate breeds are recognized: the Pembroke Welsh Corgi and the Cardigan Welsh Corgi. In 1925 the first Welsh Corgi was bred. Historically, the Pembroke has been attributed to the influx of dogs alongside Flemish weavers from around the 10th century, while the Cardigan is attributed to the dogs brought with Norse settlers, in particular a common ancestor of the Swedish Vallhund. A certain degree of interbreeding between the two types has been suggested to explain the similarities between the two.",  image: #imageLiteral(resourceName: "Corgi"), type: .medium, old: .centenarians),
        Dog(title: "Haski", text: "The general name for a sled-type of dog used in northern regions, differentiated from other sled-dog types by their fast pulling style. They are an ever-changing cross-breed of the fastest dogs.", image: #imageLiteral(resourceName: "Haski"), type: .max, old: .average),
        Dog(title: "Pug", text: "The Pug is a breed of dog with physically distinctive features of a wrinkly, short-muzzled face, and curled tail. The breed has a fine, glossy coat that comes in a variety of colours, most often fawn or black, and a compact square body with well-developed muscles.", image: #imageLiteral(resourceName: "Pug"), type: .mini, old: .centenarians),
        Dog(title: "Pit Bull", text: "Pit bull is the common name for a type of dog descended from bulldogs and terriers. Formal breeds often considered to be of the pit bull type include the American Pit Bull Terrier, American Staffordshire Terrier, American Bully, and Staffordshire Bull Terrier.", image: #imageLiteral(resourceName: "Pit"), type: .medium, old: .few),
        Dog(title: "Malamute", text: "The Malamute has been identified as a basal breed that predates the emergence of the modern breeds in the 19th Century. A study in 2013 showed that the Alaskan Malamute has a similar east Asian origin to, but is not clearly related to, the Greenland Dog and the Canadian Eskimo Dog, but contains a possible admixture of the Siberian Husky.", image: #imageLiteral(resourceName: "Malamute"), type: .max, old: .few),
        ]
    var dogViewModel: [DogCollectionModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogViewModel = dogs.map {DogCollectionModel.init(with: $0)}
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dogViewModel.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as?   DogCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = dogViewModel[indexPath.row]
        cell.setup(with: viewModel)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionDetail" {
            guard let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) else { return }
            let collectionDog = dogs[indexPath.row]
            if let detailCollectionVC: DetailCollectionVC = segue.destination as? DetailCollectionVC {
                detailCollectionVC.collectionDog = collectionDog
            }
        } else if segue.identifier == "addcollection" {
            let navControllerCollection = segue.destination as? UINavigationController
            let addNewCollection = navControllerCollection?.topViewController as? CollectionTableViewController
            addNewCollection?.delegate = self as? AddDogCollectionDelegate
        }
    }
    func adddogcollection(with breedDogCollection: Dog){
        dogs.append(breedDogCollection)
        self.collectionView.reloadData()
    }
}


class DetailCollectionVC: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailTextCollection: UITextView!
    
    var collectionDog: Dog?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        detailImage.layer.cornerRadius = 10
        detailImage.layer.masksToBounds = true
        guard let collectionDog = collectionDog else { return }
        title = collectionDog.title
        detailImage.image   = collectionDog.image
        detailLabel.text = "Average weight of dogs: \(collectionDog.type.weight) Average age of dogs: \(collectionDog.old.name)"
        detailTextCollection.text = collectionDog.text
    }
}
