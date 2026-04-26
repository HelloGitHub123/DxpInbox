//
//  MessageLogic.m
//  UserMessage
//
//  Created by 李标 on 2022/11/21.
//

#import "MessageLogic.h"
#import <DXPToolsLib/HJMBProgressHUD+Category.h>
#import <DXPToolsLib/SNAlertMessage.h>
#import "MessageViewModel.h"
#import "UMDMNetAPIClient.h"
#import "UMHJRequestProtocolForVM.h"
#import "MessageHeader.h"
#import "DXPHJToolsHeader.h"

@interface MessageLogic ()<UMHJVMRequestDelegate>

@property (nonatomic, strong) MessageViewModel *messageViewModel;
// 未读消息数量
@property (nonatomic, copy) UnreadMessageBlock unreadMessageBlock;
// 消息列表
@property (nonatomic, copy) MessageListBlock messageListBlock;
// 消息详情
@property (nonatomic, copy) MessageDetailBlock messageDetailBlock;
// 置消息已读
@property (nonatomic, copy) MarkMessageReadBlock markMessageReadBlock;
// 设置所有消息已读
//@property (nonatomic, copy) MarkAllMessagesReadBlock markAllMessagesReadBlock;
// 删除单个消息
@property (nonatomic, copy) DeleteMessageBlock deleteMessageBlock;
// 删除全部消息
//@property (nonatomic, copy) DeleteAllMessageBlock deleteAllMessageBlock;
@end

@implementation MessageLogic

- (instancetype)init {
	self = [super init];
    if (self) {
        self.pageSize = 6;
        self.currentPage = 1;
		self.msgType = @"";
		self.subsId = 0;
		self.serviceNumber = @"";
		self.prefix = @"";
    }
    return self;
}

#pragma mark -- setter && getter
- (void)setPrefix:(NSString *)prefix {
	_prefix = prefix;
}

- (void)setPageSize:(NSInteger)pageSize {
    _pageSize = pageSize;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
}

- (void)setMsgType:(NSString *)msgType {
	_msgType = msgType;
}

- (void)setSubsId:(NSInteger)subsId {
	_subsId = subsId;
}

- (void)setServiceNumber:(NSString *)serviceNumber {
	_serviceNumber = serviceNumber;
}

- (NSInteger)getCurrentPageNumber {
	return self.currentPage;
}

// 获取pageSize
- (void)getCurrentPageSizeWithCompletion:(void (^)(NSString *pageSize, NSString *errorMsg))completion {
	[self requestMessageListByPageInfoWithBlock:^(MessageListModelRes *messageListModel, NSString *errorMsg) {
		NSString *pageSize = messageListModel.pageSize;
		if (completion) {
			completion(pageSize, nil);
		}
	}];
}

/// eg:Set request token
- (void)setHttpRequestToken:(NSString *)token {
	[[UMDMNetAPIClient sharedClient] setRequestToken:token];
}

#pragma mark -- 未读数量
// Request unread messages
- (void)requestUnreadMessageWithBlock:(UnreadMessageBlock)unreadMessageBlock {
	
	self.unreadMessageBlock = unreadMessageBlock;
	[self requestUnreadMessageWithBlockWithPrefix:self.prefix subsId:self.subsId serviceNumber:self.serviceNumber block:unreadMessageBlock];
}

// Request unread messages
- (void)requestUnreadMessageWithBlockWithPrefix:(NSString *)prefix subsId:(NSInteger)subsId serviceNumber:(NSString *)serviceNumber block:(UnreadMessageBlock)unreadMessageBlock {
	
	NSDictionary *dic = @{@"subsId":@(subsId),@"prefix":prefix,@"serviceNumber":serviceNumber};
	self.unreadMessageBlock = unreadMessageBlock;
	[self.messageViewModel unreadMessageCount:dic];
}

#pragma mark -- 消息列表
// 消息列表
- (void)requestMessageListByPageInfoWithBlock:(MessageListBlock)messageListBlock {
	
	self.messageListBlock = messageListBlock;
	[self requestMessageListByPageInfoWithPageIndex:self.currentPage pageSize:self.pageSize messageTypes:self.msgType subsId:self.subsId prefix:self.prefix serviceNumber:self.serviceNumber block:messageListBlock];
}

// 消息列表
- (void)requestMessageListByPageInfoWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize messageTypes:(NSString *)messageTypes subsId:(NSInteger)subsId prefix:(NSString *)prefix serviceNumber:(NSString *)serviceNumber block:(MessageListBlock)messageListBlock {
	
	NSDictionary *dic = @{@"pageIndex":@(pageIndex),@"pageSize":@(pageSize),@"messageTypes":messageTypes,@"subsId":@(subsId),@"prefix":prefix,@"serviceNumber":serviceNumber};
	self.messageListBlock = messageListBlock;
	[self.messageViewModel messageList:dic];
}

#pragma mark -- 消息详情
// Request Message Details
- (void)requestMessageDetailByMessageId:(NSString *)messageId block:(MessageDetailBlock)messageDetailBlock {
	
	if (!messageId || [messageId isEqualToString:@""]) {
		return;
	}
	self.messageDetailBlock = messageDetailBlock;
	[self.messageViewModel messageDetailByMessageId:messageId];
}

#pragma mark -- 设置消息已读
// Set messages to be read
- (void)requestMessageSetReadByMessageIds:(NSArray *)messageIds block:(MarkMessageReadBlock)markMessageReadBlock {
	
	if (IsArrEmpty_tools(messageIds)) {
		return;
	}
	self.markMessageReadBlock = markMessageReadBlock;
	[self requestMessageSetReadByMessageIds:messageIds subsId:self.subsId prefix:self.prefix serviceNumber:self.serviceNumber block:markMessageReadBlock];
}

// Set messages to be read
- (void)requestMessageSetReadByMessageIds:(NSArray *)messageIds subsId:(NSInteger)subsId prefix:(NSString *)prefix serviceNumber:(NSString *)serviceNumber block:(MarkMessageReadBlock)markMessageReadBlock {
	
	if (IsArrEmpty_tools(messageIds)) {
		return;
	}
	
	NSDictionary *dic = @{};
	if (subsId > 0) {
		dic = @{@"messageIds":messageIds,@"subsId":@(subsId),@"prefix":prefix,@"serviceNumber":serviceNumber};
	} else {
		dic = @{@"messageIds":messageIds,@"prefix":prefix,@"serviceNumber":serviceNumber};
	}
	self.markMessageReadBlock = markMessageReadBlock;
	[self.messageViewModel markMessageReadByMessageId:dic];
}

#pragma mark -- 删除消息
// Delete individual messages
- (void)requestDeleteMessageByMessageIds:(NSArray *)messageIds block:(DeleteMessageBlock)deleteMessageBlock {
	if (IsArrEmpty_tools(messageIds)) {
		return;
	}
	self.deleteMessageBlock = deleteMessageBlock;
	[self requestDeleteMessageByMessageIds:messageIds subsId:self.subsId prefix:self.prefix serviceNumber:self.serviceNumber block:deleteMessageBlock];
}

// Delete individual messages
- (void)requestDeleteMessageByMessageIds:(NSArray *)messageIds subsId:(NSInteger)subsId prefix:(NSString *)prefix serviceNumber:(NSString *)serviceNumber block:(DeleteMessageBlock)deleteMessageBlock {
	
	if (IsArrEmpty_tools(messageIds)) {
		return;
	}
	NSDictionary *dic = @{@"messageIds":messageIds,@"subsId":@(subsId),@"prefix":prefix,@"serviceNumber":serviceNumber};
	self.deleteMessageBlock = deleteMessageBlock;
	[self.messageViewModel deleteMessageByMessageIds:dic];
}

#pragma mark -- other
// Pull up to refresh
//- (void)refreshMessageList {
//    self.currentPage = 1;
//	[self requestMessageListByPageInfoWithBlock:^(NSMutableArray<Message *> *modelList, NSString *errorMsg) {
//		if (self.refresMessage) {
//			self.refresMessage(modelList);
//		}
//	}];
//}

// Pull down to load
//- (void)loadMorMessageList{
//    ++self.currentPage;
//    [self requestMessageListByPageInfoWithBlock:^(MessageListModel *messageListModel, NSString *errorMsg) {
//        if (self.refresMessage) {
//            self.refresMessage(messageListModel);
//        }
//    }];
//}

// Set all messages to be read
//- (void)requestMessageSetAllReadWithBlock:(MarkAllMessagesReadBlock)markAllMessagesReadBlock {
//    self.markAllMessagesReadBlock = markAllMessagesReadBlock;
//    [self.messageViewModel markAllMessagesRead];
//}

/// eg:Delete all individual messages
//- (void)requestDeleteAllMessageWithBlock:(DeleteAllMessageBlock)deleteAllMessageBlock {
//    self.deleteAllMessageBlock = deleteAllMessageBlock;
//    [self.messageViewModel deleteAllMessage];
//}

#pragma mark - UMHJVMRequestDelegate
- (void)requestSuccess:(NSObject *)vm method:(NSString *)methodFlag {
	[SNAlertMessage hideLoading];
	// 未读数量
    if ([methodFlag isEqualToString:Url_Message_Unread]) {
		UnreadMessageModelRes *model = ((MessageViewModel *)vm).unreadMessageModelRes;
        if (self.unreadMessageBlock) {
            self.unreadMessageBlock(model, @"");
        }
    }
	// 消息列表
    if ([methodFlag isEqualToString:Url_Message_List]) {
		MessageListModelRes *listModel = ((MessageViewModel *)vm).messageListModelRes;
        if (self.messageListBlock) {
            self.messageListBlock(listModel, @"");
        }
    }
	// 消息详情
    if ([methodFlag isEqualToString:Url_Message_Detail]) {
		MessageDetailModelRes *model = ((MessageViewModel *)vm).messageDetailModelRes;
        if (self.messageDetailBlock) {
            self.messageDetailBlock(model, @"");
        }
    }
	// 设置已读
    if ([methodFlag isEqualToString:Url_Message_SetRead]) {
		MarkMessageReadModelRes *model = ((MessageViewModel *)vm).markMessageReadModelRes;
        if (self.markMessageReadBlock) {
            self.markMessageReadBlock(model, @"");
        }
    }
	// 删除消息
	if ([methodFlag isEqualToString:Url_Message_Delete]) {
		DeleteMessageModelRes *model = ((MessageViewModel *)vm).deleteMessageModelRes;
		if (self.deleteMessageBlock) {
			self.deleteMessageBlock(model, @"");
		}
	}
	
//    if ([methodFlag isEqualToString:Url_Message_SetAllRead]) {
//        MarkAllMessagesReadModel *model = ((MessageViewModel *)vm).markAllMessagesReadModelRes.data;
//        if (self.markAllMessagesReadBlock) {
//            self.markAllMessagesReadBlock(model, @"");
//        }
//    }
//    if ([methodFlag isEqualToString:Url_Message_DeleteAll]) {
//        DeleteAllMessageModel *model = ((MessageViewModel *)vm).deleteAllMessageModelRes.data;
//        if (self.deleteAllMessageBlock) {
//            self.deleteAllMessageBlock(model, @"");
//        }
//    }
}

- (void)requestFailure:(NSObject *)vm method:(NSString *)methodFlag {
    [SNAlertMessage hideLoading];
	// 未读数量
    if ([methodFlag isEqualToString:Url_Message_Unread]) {
        NSString *msg = ((MessageViewModel *)vm).unreadMessageModelRes.resultMsg;
        if (self.unreadMessageBlock) {
            self.unreadMessageBlock(nil, msg);
        }
    }
	// 消息列表
    if ([methodFlag isEqualToString:Url_Message_List]) {
        NSString *msg = ((MessageViewModel *)vm).messageListModelRes.resultMsg;
        if (self.messageListBlock) {
            self.messageListBlock(nil, msg);
        }
    }
	// 消息详情
    if ([methodFlag isEqualToString:Url_Message_Detail]) {
        NSString *msg = ((MessageViewModel *)vm).messageDetailModelRes.resultMsg;
        if (self.messageDetailBlock) {
            self.messageDetailBlock(nil, msg);
        }
    }
	// 设置已读
    if ([methodFlag isEqualToString:Url_Message_SetRead]) {
        NSString *msg = ((MessageViewModel *)vm).markMessageReadModelRes.resultMsg;
        if (self.markMessageReadBlock) {
            self.markMessageReadBlock(nil, msg);
        }
    }
	// 删除消息
	if ([methodFlag isEqualToString:Url_Message_Delete]) {
		NSString *msg = ((MessageViewModel *)vm).deleteMessageModelRes.resultMsg;
		if (self.deleteMessageBlock) {
			self.deleteMessageBlock(nil, msg);
		}
	}
//    if ([methodFlag isEqualToString:Url_Message_SetAllRead]) {
//        NSString *msg = ((MessageViewModel *)vm).markAllMessagesReadModelRes.resultMsg;
//        if (self.markAllMessagesReadBlock) {
//            self.markAllMessagesReadBlock(nil, msg);
//        }
//    }
//    if ([methodFlag isEqualToString:Url_Message_DeleteAll]) {
//        NSString *msg = ((MessageViewModel *)vm).deleteAllMessageModelRes.resultMsg;
//        if (self.deleteAllMessageBlock) {
//            self.deleteAllMessageBlock(nil, msg);
//        }
//    }
}

#pragma mark -- lazy load
- (MessageViewModel *)messageViewModel {
    if (!_messageViewModel) {
        _messageViewModel = [[MessageViewModel alloc] init];
        _messageViewModel.vDelegate = self;
    }
    return _messageViewModel;
}

@end
