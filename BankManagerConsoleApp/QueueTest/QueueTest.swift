//
//  QueueTest.swift
//  QueueTest
//
//  Created by 둘리 on 2024/01/25.
//

import XCTest
@testable import BankManagerConsoleApp

final class QueueTests: XCTestCase {
    typealias List = LinkedList<Int>
    
    var sut: Queue<Int>!

    override func setUpWithError() throws {
        sut = Queue(queue: List())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_queue에값이없을떄_peek호출시_nil을반환한다() {
        //given

        //when
        let result = sut.peek()
        //then
        XCTAssertNil(result)
    }

    func test_queue에값이1과2가있을때_clear호출시_빈배열true를반환한다() {
        //given
        sut.enqueue(element: 1)
        sut.enqueue(element: 2)
        //when
        sut.clear()
        //then
        XCTAssertTrue(sut.isEmpty())
    }

    func test_queue에1과2가있을때_첫번째로1을반환하고마지막으로2를반환한다() {
        //given
        let first = 1
        let second = 2
        //when
        sut.enqueue(element: first)
        sut.enqueue(element: second)
        //then
        XCTAssertEqual(try sut.dequeue(), first)
        XCTAssertEqual(try sut.dequeue(), second)
    }

    func test_queue에1과2가있을때_dequeue호출했을때_첫번쨰값인2가반환된다() {
        //given
        let firstElement = 2
        let secondElement = 1
        let secondNode = Node(data: secondElement)
        let firstNode = Node(data: firstElement, next: secondNode)
        let list = List(head: firstNode, tail: secondNode)
        sut = Queue(queue: list)
        
        do {
            //when
            let result = try sut.dequeue()
            //then
            XCTAssertEqual(result, firstElement)
        } catch {
           print("error")
        }
    }
    
    func test_queue에1과2와3이있을때_remove호출하여_두번째값인2를빼내면2가반환한다() {
        //given
        sut.enqueue(element: 1)
        sut.enqueue(element: 2)
        sut.enqueue(element: 3)
        //when
        let removeElement = sut.queue.remove(index: 1)
        //then
        XCTAssertEqual(removeElement, 2)
    }
}
