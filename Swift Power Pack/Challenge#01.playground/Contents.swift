import UIKit

/// Hackign with swift guidebook Challenge 1
///
/// Fizz Buzz problem solver
/// - Parameter number: input number to test for
/// - Returns: "Fizz buzz" if evenly divisible by 3 and 5, "Fizz" if only 3, "Buzz" is only 5, the number otherwise
func fizzbuzz(number: Int) -> String {
    if number % 3 == 0 && number % 5 == 0 {
        return "Fizz Buzz"
    } else if number % 3 == 0 {
        return "Fizz"
    } else if number % 5 == 0 {
        return "Buzz"
    } else {
        return String(number)
    }
}

fizzbuzz(number: 3)
fizzbuzz(number: 5)
fizzbuzz(number: 15)
fizzbuzz(number: 16)
