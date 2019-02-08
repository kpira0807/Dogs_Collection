import UIKit

struct DogCollectionModel {
    let name: String
    let image: UIImage
    
    init(with dognew: Dog){
        name = dognew.title
        image = dognew.image
    }
}

class DogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageDogCollection: UIImageView!
    @IBOutlet weak var textDogCollection: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageDogCollection.layer.cornerRadius = 10
        imageDogCollection.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageDogCollection.image = nil
        textDogCollection.text = nil
    }
    
    func setup(with viewModel: DogCollectionModel){
        imageDogCollection.image = viewModel.image
        textDogCollection.text = viewModel.name
    }
}
