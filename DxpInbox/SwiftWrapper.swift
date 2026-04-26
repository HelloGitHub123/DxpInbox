//
//  SwiftWrapper.swift
//  DxpInbox
//
//  Created by 李标 on 2025/10/27.
//

import Foundation

@objc public class SwiftWrapper: NSObject {
	
	// 创建实例
	private let objcInstance = MessageLogic()
	
	// 包装方法 -- 请求未读消息
//	@objc public func requestUnreadMessage(completion: @escaping (String, String) -> Void) {
//		objcInstance.requestUnreadMessage { (model, errorMsg) in
//			if model?.resultCode == "200" {
//				let unreadCount = model?.data.unreadCount ?? ""
//				completion(unreadCount, "")
//			} else {
//				completion("",errorMsg ?? "")
//			}
//		}
//	}
	
	// 包装方法 -- 请求未读消息
	@objc public func requestUnreadMessageWithBlockWithPrefix(prefix:String, subsId:Int, serviceNumber:String, completion: @escaping (String, String) -> Void) {
		objcInstance.requestUnreadMessageWithBlock(withPrefix: prefix, subsId: subsId, serviceNumber: serviceNumber) { (model, errorMsg) in
			if model?.resultCode == "0" {
				let unreadCount = model?.data.unreadCount ?? ""
				completion(unreadCount, "")
			} else {
				completion("-1",errorMsg ?? "")
			}
		}
	}
	
	// 包装方法 -- 请求消息列表
	@objc public func requestMessageListWithPageIndex(pageIndex:Int, pageSize:Int, messageTypes:String, subsId:Int, prefix:String, serviceNumber:String, completion:@escaping (MessageListModelRes?, String) -> Void) {
		
		objcInstance.requestMessageListByPageInfo(withPageIndex: pageIndex, pageSize: pageSize, messageTypes: messageTypes, subsId: subsId, prefix: prefix, serviceNumber: serviceNumber) { (model, errorMsg) in
			if model?.resultCode == "0" {
				completion(model, "")
			} else {
				completion(nil, errorMsg ?? "")
			}
			
		}
	}
	
	// 消息详情
	@objc public func requestMessageDetailByMessageId(messageId:String, completion: @escaping (MessageDetailModelRes?, String) -> Void) {
		objcInstance.requestMessageDetail(byMessageId: messageId) { (model, errorMsg) in
			
			if model?.resultCode == "0" {
				completion(model, "")
			} else {
				completion(nil, errorMsg ?? "")
			}
			
		}
	}
	
	// 设置已读  50109 MarkMessageReadModelRes
	@objc public func requestMessageSetReadByMessageIds(messageIds:Array<String>, subsId:Int, prefix:String, serviceNumber:String, completion: @escaping (MarkMessageReadModelRes?, String) -> Void) {
		objcInstance.requestMessageSetRead(byMessageIds: messageIds, subsId: subsId, prefix: prefix, serviceNumber: serviceNumber) { (model, errorMsg) in
			
			if model?.resultCode == "0" {
				completion(model, "")
			} else {
				completion(nil, errorMsg ?? "")
			}
		}
	}
	
	
	// 删除消息 requestDeleteMessageByMessageIds
	@objc public func requestDeleteMessageByMessageIds(messageIds:Array<String>, subsId:Int, prefix:String, serviceNumber:String, completion: @escaping (DeleteMessageModelRes?, String) -> Void) {
		
		objcInstance.requestDeleteMessage(byMessageIds: messageIds, subsId: subsId, prefix: prefix, serviceNumber: serviceNumber) { (model, errorMsg) in
			
			if model?.resultCode == "0" {
				completion(model, "")
			} else {
				completion(nil, errorMsg ?? "")
			}
		}
	}
	
	
	
	
	
	
}
