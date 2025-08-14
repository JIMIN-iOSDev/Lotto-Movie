//
//  ShopViewModel.swift
//  0723HW
//
//  Created by Jimin on 8/13/25.
//

import Foundation

class ShopViewModel {
    
    var navigation: ((ResultViewController) -> Void)?
    var clearSearchText: (() -> Void)?
    var endEditing: (() -> Void)?
    
    func searchButtonTapped(text: String?) {
        guard let text = text, text.count > 1 else {
            print("글자 수가 2미만 입니다")
            return
        }
        
        let vc = navigationResultVC(text: text)
        navigation?(vc)
        clearSearchText?()
        endEditing?()
    }
    
    private func navigationResultVC(text: String) -> ResultViewController {
        let vc = ResultViewController()
        vc.viewModel.input.text.value = text
        vc.viewModel.list.removeAll()
        vc.viewModel.currentPage = 0
        return vc   // 데이터를 설정한 VC
    }
}
