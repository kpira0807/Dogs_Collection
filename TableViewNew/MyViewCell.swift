import UIKit

class MyViewCell: UITableViewCell {
    
    @IBOutlet weak var aboutdog: UILabel!
    @IBOutlet weak var textcell: UILabel!
    @IBOutlet weak var titlecell: UILabel!
    @IBOutlet weak var imagecell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagecell.layer.cornerRadius = 10
        imagecell.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
