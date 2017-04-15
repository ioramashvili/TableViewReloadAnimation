import Foundation
import UIKit

extension UITableView {
    
    enum AnimationType {
        case simple(duration: TimeInterval, direction: Direction, constantDelay: TimeInterval)
        case spring(duration: TimeInterval, damping: CGFloat, velocity: CGFloat, direction: Direction, constantDelay: TimeInterval)
        
        func animate(tableView: UITableView, reversed: Bool = false, completion: (() -> Void)? = nil) {
            var duration: TimeInterval!
            var damping: CGFloat = 1
            var velocity: CGFloat = 0
            var constantDelay: TimeInterval!
            var direction: Direction!
            
            switch self {
            case .simple(let _duration, let _direction, let _constantDelay):
                duration = _duration
                direction = _direction
                constantDelay = _constantDelay
            case .spring(let _duration, let _damping, let _velocity, let _direction, let _constantDelay):
                duration = _duration
                damping = _damping
                velocity = _velocity
                direction = _direction
                constantDelay = _constantDelay
            }
            
            let visibleCells = tableView.visibleCells
            let visibleCellsCount = Double(visibleCells.count)
            
            let cells = direction.reverse(for: reversed ? visibleCells.reversed() : visibleCells)
            cells.enumerated().forEach { item in
                let delay: TimeInterval = duration / visibleCellsCount * Double(item.offset) + Double(item.offset) * constantDelay
                direction.startValues(tableView: tableView, for: item.element)
                
                UIView.animate(
                    withDuration: duration,
                    delay: delay,
                    usingSpringWithDamping: damping,
                    initialSpringVelocity: velocity,
                    options: .curveEaseInOut,
                    animations: {
                        direction.endValues(tableView: tableView, for: item.element)
                }, completion: { finished in
                    completion?()
                })
                
                print(duration, delay)
            }

        }
    }
    
    enum Direction {
        case left(useCellsFrame: Bool)
        case top(useCellsFrame: Bool)
        case right(useCellsFrame: Bool)
        case bottom(useCellsFrame: Bool)
        case rotation(angle: Double)
        
        
        // For testing only
        init?(rawValue: Int, useCellsFrame: Bool) {
            switch rawValue {
            case 0:
                self = Direction.left(useCellsFrame: useCellsFrame)
            case 1:
                self = Direction.top(useCellsFrame: useCellsFrame)
            case 2:
                self = Direction.right(useCellsFrame: useCellsFrame)
            case 3:
                self = Direction.bottom(useCellsFrame: useCellsFrame)
            case 4:
                self = Direction.rotation(angle: Double.pi / 2)
            default:
                return nil
            }
        }
        
        func startValues(tableView: UITableView, for cell: UITableViewCell) {
            cell.alpha = 0
            switch self {
            case .left(let useCellsFrame):
                cell.frame.origin.x += useCellsFrame ? cell.frame.width : tableView.frame.width
            case .top(let useCellsFrame):
                cell.frame.origin.y += useCellsFrame ? cell.frame.height : tableView.frame.height
            case .right(let useCellsFrame):
                cell.frame.origin.x -= useCellsFrame ? cell.frame.width : tableView.frame.width
            case .bottom(let useCellsFrame):
                cell.frame.origin.y -= useCellsFrame ? cell.frame.height : tableView.frame.height
            case .rotation(let angle):
                cell.transform = CGAffineTransform(rotationAngle: -CGFloat(angle))
            }
        }
        
        func endValues(tableView: UITableView, for cell: UITableViewCell) {
            cell.alpha = 1
            switch self {
            case .left(let useCellsFrame):
                cell.frame.origin.x -= useCellsFrame ? cell.frame.width : tableView.frame.width
            case .top(let useCellsFrame):
                cell.frame.origin.y -= useCellsFrame ? cell.frame.height : tableView.frame.height
            case .right(let useCellsFrame):
                cell.frame.origin.x += useCellsFrame ? cell.frame.width : tableView.frame.width
            case .bottom(let useCellsFrame):
                cell.frame.origin.y += useCellsFrame ? cell.frame.height : tableView.frame.height
            case .rotation(_):
                cell.transform = .identity
            }
        }
        
        func reverse(for cells: [UITableViewCell]) -> [UITableViewCell] {
            switch self {
            case .bottom(_):
                return cells.reversed()
            default:
                return cells
            }
        }
    }
    
    func reloadData(with animation: AnimationType, reversed: Bool = false) {
        reloadData()
        animation.animate(tableView: self, reversed: reversed)
    }
}
