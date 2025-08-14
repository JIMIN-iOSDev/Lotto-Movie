//
//  ResultViewModel.swift
//  0723HW
//
//  Created by 서지민 on 8/13/25.
//

import Foundation

class ResultViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        var text = Observable("")
        var indexpath = Observable(())
    }
    
    struct Output {
        var totalText = Observable("")
        var verticalReload = Observable(())
        var scrollToTop = Observable(())
        var horizontalReload = Observable(())
    }
    
    var list: [ShopList] = []
    var horizontalList: [ShopList] = []
    var currentPage = 0
    var isEnd = false
    
    private let numberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    init() {
        
        input = Input()
        output = Output()
        
        input.text.bind { _ in
            self.callRequest(query: self.input.text.value, currentPage: 0)
        }
        
        input.indexpath.bind { _ in
            print("inputIndexpath callRequest")
            self.callRequest(query: self.input.text.value, currentPage: 0)
        }
    }
    
    private func callRequest(query: String, currentPage: Int) {
        NetworkManager.shared.callRequest(api: .shop(query: query, currentPage: currentPage), type: Shop.self) { value in
            DispatchQueue.main.async {
                self.output.totalText.value = "\(self.numberFormatter.string(for: value.total) ?? "0") 개의 검색 결과"
                
                self.list.append(contentsOf: value.items)
                self.output.verticalReload.value = ()
                
                if self.currentPage == 0 && value.items.count != 0 {
                    self.output.scrollToTop.value = ()
                }
                
                if ((self.currentPage + 1) * 30) < value.total {
                    self.isEnd = false
                } else {
                    self.isEnd = true
                }
                
                self.horizontalList.append(contentsOf: value.items)
                self.output.horizontalReload.value = ()
            }
        } fail: {
            print("실패")
        }
    }
}
