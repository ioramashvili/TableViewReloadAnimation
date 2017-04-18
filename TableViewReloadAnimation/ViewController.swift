import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var directionStackView: UIStackView!
    @IBOutlet var cellsOrderSwitch: UISwitch!
    var selectedDirection1: UITableView.Direction!
    var selectedDirection2: UITableView.Direction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        selectedDirection1 = UITableView.Direction.left(useCellsFrame: true)
        selectedDirection2 = UITableView.Direction.left(useCellsFrame: false)
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func selectDirection(_ sender: UIButton) {
        directionStackView.subviews.forEach {
            ($0 as? UIButton)?.backgroundColor = UIColor.white
        }
        
        sender.backgroundColor = UIColor.purple
        selectedDirection1 = UITableView.Direction(rawValue: sender.tag, useCellsFrame: true)!
        selectedDirection2 = UITableView.Direction(rawValue: sender.tag, useCellsFrame: false)!
        
        showHideDirectionStackView(sender)
    }
    
    @IBAction func showHideDirectionStackView(_ sender: Any) {
        UIView.animate(withDuration: 0.2) { 
            self.directionStackView.isHidden = !self.directionStackView.isHidden
        }
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        showHideDirectionStackView(sender)
    }
    
    @IBAction func anim1(_ sender: Any) {
        tableView.reloadData(with: .simple(duration: 0.45, direction: selectedDirection1, constantDelay: 0), reversed: !cellsOrderSwitch.isOn)
    }
    
    @IBAction func anim2(_ sender: Any) {
        tableView.reloadData(with: .simple(duration: 0.45, direction: selectedDirection2, constantDelay: 0), reversed: !cellsOrderSwitch.isOn)
    }
    
    @IBAction func spring1(_ sender: Any) {
        tableView.reloadData(with: .spring(duration: 0.45, damping: 0.75, velocity: 1, direction: selectedDirection1, constantDelay: 0), reversed: !cellsOrderSwitch.isOn)
    }
    
    @IBAction func spring2(_ sender: Any) {
        tableView.reloadData(with: .spring(duration: 0.45, damping: 0.75, velocity: 1, direction: selectedDirection2, constantDelay: 0), reversed: !cellsOrderSwitch.isOn)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UITableViewHeaderFooterView()
        v.contentView.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.6784313725, blue: 0.8196078431, alpha: 1)
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UITableViewHeaderFooterView()
        v.contentView.backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.7333333333, blue: 0.7058823529, alpha: 1)
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension Bool {
    static var random: Bool {
        return arc4random_uniform(2) == 0 ? true : false
    }
}
