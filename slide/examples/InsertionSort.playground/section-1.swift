// Playground - noun: a place where people can play

import Cocoa
import XCPlayground

var data = [12, 53, 15, 68, 46, 7, 0, 7, 83, 78, 46, 44, 43, 8, 21, 42, 27, 88, 52, 85]

func visualize<T>(data: T[], identifier: String) {
    for x in data {
        XCPCaptureValue(identifier, x)
    }
}

func exchange<T>(data: T[], i: Int, j: Int) {
    let temp = data[i]
    data[i] = data[j]
    data[j] = temp
}

func swapLeft<T: Comparable>(data: T[], index: Int) {
    for i in reverse(1...index) {
        if data[i] < data[i - 1] {
            exchange(data, i, i - 1)
        } else {
            break
        }
    }
    visualize(data, "Iteration \(index)")
}

func isort<T: Comparable>(data: T[]) {
    for i in 1..data.count {
        swapLeft(data, i)
    }
}

isort(data)
data
