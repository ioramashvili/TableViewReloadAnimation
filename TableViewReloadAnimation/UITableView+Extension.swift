import Foundation
import UIKit

extension UITableView {
    
    enum AnimationType {
        case frame(duration: TimeInterval, isSpring: Bool, direction: Direction, constantDelay: TimeInterval)
        
        func animate(tableView: UITableView, reversed: Bool = false, completion: (() -> Void)? = nil) {
            switch self {
            case .frame(let duration, let isSpring, let direction, let constantDelay):
                let visibleCells = tableView.visibleCells
                let visibleCellsCount = Double(visibleCells.count)
                
                let cells = direction.reverse(for: reversed ? visibleCells.reversed() : visibleCells)
                cells.enumerated().forEach { item in
                    let delay: TimeInterval = duration / visibleCellsCount * Double(item.offset) + Double(item.offset) * constantDelay
                    direction.startValues(tableView: tableView, for: item.element)
                    
                    UIView.animate(
                        withDuration: duration,
                        delay: delay,
                        usingSpringWithDamping: isSpring ? 0.65 : 1,
                        initialSpringVelocity: isSpring ? 1 : 0,
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
    }
    
    enum Direction {
        case left(useCellsFrame: Bool)
        case top(useCellsFrame: Bool)
        case right(useCellsFrame: Bool)
        case bottom(useCellsFrame: Bool)
        
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
    
    func animateWithFade(duration: TimeInterval, completion: (() -> Void)? = nil) {
        let visibleCellsCount = Double(visibleCells.count)
        visibleCells.enumerated().forEach { item in
            let delay: TimeInterval = duration / visibleCellsCount * Double(item.offset) + 0.07
            
            item.element.alpha = 0
            item.element.frame.origin.y += item.element.frame.height
            UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
                
                item.element.alpha = 1
                item.element.frame.origin.y -= item.element.frame.height
                
            }, completion: { finished in
                completion?()
            })
        }
    
    
        
//        for (index, cell) in self.visibleCells.enumerated() {
//            let delay: TimeInterval = duration / Double(visibleCells.count) * Double(index) + 0.07
//            
//            cell.alpha = 0
//            cell.frame.origin.y += 60
//            UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
//
//                cell.alpha = 1
//                cell.frame.origin.y -= 60
//
//            }, completion: { finished in
//                completion?()
//            })
        
            
            // bounce
            //            cell.alpha = 0
            //            cell.frame.origin.y += bounds.height
            //            UIView.animate(withDuration: duration, delay: animationDelay, usingSpringWithDamping: 0.65, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            //
            //                cell.alpha = 1
            //                cell.frame.origin.y -= self.bounds.height
            //
            //            }, completion: { finished in
            //                completion?()
            //            })
            
            //            cell.alpha = 0
            //            cell.frame.origin.x += cell.frame.width / 2
            //            UIView.animate(withDuration: duration, delay: animationDelay, options: .curveEaseOut, animations: {
            //
            //                cell.alpha = 1
            //                cell.frame.origin.x -= cell.frame.width / 2
            //
            //            }, completion: { finished in
            //                completion?()
            //            })
            
            //            let animationDelay: TimeInterval = duration / Double(visibleCells.count) * Double(index)
            //            cell.alpha = 0
            //            cell.frame.origin.y -= cell.frame.height
            //            cell.transform = CGAffineTransform(scaleX: 0.5, y: 1)
            //            UIView.animate(withDuration: duration, delay: animationDelay, options: .curveEaseOut, animations: {
            //
            //                cell.alpha = 1
            //                cell.frame.origin.y += cell.frame.height
            //                cell.transform = CGAffineTransform.identity
            //
            //            }, completion: { finished in
            //                completion?()
            //            })
        }
    }


