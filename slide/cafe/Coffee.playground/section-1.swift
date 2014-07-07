// 코멘트

import Cocoa

struct Customer {
    var 현금 : Int
    var 적립포인트 : Int
}

var 현구 = Customer(현금: 10000, 적립포인트: 0)
현구.현금 = 현구.현금 + 50000

func tax(price : Int) -> Int {
    return Int(0.1 * Float(price))
}

func earn(pay : Int) -> Int {
    return Int(0.02 * Float(pay))
}

let 아메리카노 = 4000
let 에스프레소 = 5000

let 금액 : Int = 2*아메리카노 + 3*에스프레소
let 부가세 : Int = tax(금액)
let 부가세포함가격 : Int = 금액 + 부가세

let 적립 = earn(부가세포함가격)

현구.현금 = 현구.현금 - 부가세포함가격
현구.적립포인트 = 현구.적립포인트 + 적립

println("현금:  \(현구.현금)")
println("적립포인트:  \(현구.적립포인트)")