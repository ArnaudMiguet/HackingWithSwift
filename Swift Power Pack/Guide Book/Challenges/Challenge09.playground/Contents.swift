import UIKit

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

extension Int {
    func times(_ closure: () -> Void) {
        guard self > 0 else { return }
        for _ in 0..<self {
            closure()
        }
    }
}

(-5).times { print("Hello!") }

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        for (index, itemIterated) in self.enumerated() {
            if item == itemIterated {
                self.remove(at: index)
                return
            }
        }
    }
}

var array = [1, 2, 3, 2, 5, 6]
array.remove(item: 7)
array.remove(item: 1)
array.remove(item: 2)
