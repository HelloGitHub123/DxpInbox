//
//  MessageViewControllerWrapper.swift
//  DxpInbox
//
//  Created by 李标 on 2025/11/6.
//

import UIKit

public class MessageViewControllerWrapper {

	private weak var navigationController: UINavigationController?

	public init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	/// 展示 SDK ViewController
	/// - Parameters:
	///   - config: 配置参数
	///   - animated: 是否动画
	public func showMessageViewController(animated: Bool = true) {
		guard let navigationController = navigationController else {
			print("Navigation controller is nil")
			return
		}
		
		let messageVC = MessageListViewController()
		
		// 配置 SDK ViewController
//		configure(messageVC)
		
//		configure(messageVC)
		
		// 设置转场代理（如果需要自定义转场）
//		setupTransition(for: sdkVC)
		
		navigationController.pushViewController(messageVC, animated: animated)
	}
	
	
//	private func configure(_ viewController: MessageListViewController) {
//		// 根据配置设置 SDK ViewController 的属性
//		viewController.title = config.title
//		viewController.themeColor = config.themeColor
//		
//		// 设置回调
//		viewController.onCompletion = { [weak self] result in
//			self?.handleCompletion(result: result)
//		}
//	}
	
//	private func handleCompletion(result: Any?) {
//		// 处理 SDK ViewController 完成后的回调
//		print("SDK ViewController completed with result: \(String(describing: result))")
//	}
	
	
}
