//
//  NetAPIClientWrapper.swift
//  DxpInbox
//
//  Created by 李标 on 2025/10/27.
//

import Foundation

@objc public class NetAPIClientWrapper: NSObject {
	
	// 单例实例 对外
	@objc public static let shared = NetAPIClientWrapper()
	
	// 对内
	private let objcInstance = UMDMNetAPIClient.shared()
	
	public override init() {
		super.init()
	}
	
	// 包装属性
	@objc public var baseUrl: String {
		get { return objcInstance?.baseUrl ?? "" }
		set { objcInstance?.baseUrl = newValue ?? "" }
	}
	
	// 包装方法
	@objc public func setRequestToken(_token:String) -> Void {
		 objcInstance?.setRequestToken(_token)
	}
	
}
