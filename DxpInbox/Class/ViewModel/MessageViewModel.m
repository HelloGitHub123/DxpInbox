//
//  MessageViewModel.m
//  UserMessage
//
//  Created by 李标 on 2022/11/19.
//

#import "MessageViewModel.h"

@implementation MessageViewModel

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

/// eg:查询未读消息数量
- (void)unreadMessageCount:(NSDictionary *)dic {
    self.unreadMessageModelRes = [UnreadMessageModelRes new];
    [UnreadMessageModelRes getRequestActionByUrl:Url_Message_Unread paramDict:dic retunSelf:self retunObject:self.unreadMessageModelRes delegate:self.vDelegate method:Url_Message_Unread responseBlock:^(UnreadMessageModelRes *dataObj, id  _Nullable resp) {
        self.unreadMessageModelRes = dataObj;
    } error:^(UnreadMessageModelRes *dataObj, id  _Nullable resp) {
        self.unreadMessageModelRes = dataObj;
    }];
}

/// eg: 查询消息列表
- (void)messageList:(NSDictionary *)dic {
    if ([dic allKeys] == 0) {
        return;
    }
    self.messageListModelRes = [MessageListModelRes new];
    [MessageListModelRes getRequestActionByUrl:Url_Message_List paramDict:dic retunSelf:self retunObject:self.messageListModelRes delegate:self.vDelegate method:Url_Message_List responseBlock:^(MessageListModelRes *dataObj, id  _Nullable resp) {
        self.messageListModelRes = dataObj;
    } error:^(MessageListModelRes *dataObj, id  _Nullable resp) {
        self.messageListModelRes = dataObj;
    }];
}

/// eg: 消息详情
- (void)messageDetailByMessageId:(NSString *)messageId {
    // 入参
//    NSDictionary *dic = @{@"messageId":messageId};
    
	NSString *url = [NSString stringWithFormat:Url_Message_Detail,messageId];
	
    self.messageDetailModelRes = [MessageDetailModelRes new];
	[MessageDetailModelRes getRequestActionByUrl:url paramDict:@{} retunSelf:self retunObject:self.messageDetailModelRes delegate:self.vDelegate method:Url_Message_Detail responseBlock:^(MessageDetailModelRes *dataObj, id  _Nullable resp) {
        self.messageDetailModelRes = dataObj;
    } error:^(MessageDetailModelRes *dataObj, id  _Nullable resp) {
        self.messageDetailModelRes = dataObj;
    }];
}

/// eg: 设置单个消息已读
- (void)markMessageReadByMessageId:(NSDictionary *)dic {
    self.markMessageReadModelRes = [MarkMessageReadModelRes new];
    [MarkMessageReadModelRes postRequestActionByUrl:Url_Message_SetRead paramDict:dic retunSelf:self retunObject:self.markMessageReadModelRes delegate:self.vDelegate method:Url_Message_SetRead responseBlock:^(MarkMessageReadModelRes *dataObj, id  _Nullable resp) {
        self.markMessageReadModelRes = dataObj;
    } error:^(MarkMessageReadModelRes *dataObj, id  _Nullable resp) {
        self.markMessageReadModelRes = dataObj;
    }];
}

/// eg: 设置全部消息已读
//- (void)markAllMessagesRead {
//    self.markAllMessagesReadModelRes = [MarkAllMessagesReadModelRes new];
//    [MarkAllMessagesReadModelRes postRequestActionByUrl:Url_Message_SetAllRead paramDict:@{} retunSelf:self retunObject:self.markAllMessagesReadModelRes delegate:self.vDelegate method:Url_Message_SetAllRead responseBlock:^(MarkAllMessagesReadModelRes *dataObj, id  _Nullable resp) {
//        self.markAllMessagesReadModelRes = dataObj;
//    } error:^(MarkAllMessagesReadModelRes *dataObj, id  _Nullable resp) {
//        self.markAllMessagesReadModelRes = dataObj;
//    }];
//}

/// eg: 删除消息
- (void)deleteMessageByMessageIds:(NSDictionary *)dic {
	
    self.deleteMessageModelRes = [DeleteMessageModelRes new];
    [DeleteMessageModelRes deleteRequestActionByUrl:Url_Message_Delete paramDict:dic retunSelf:self retunObject:self.deleteMessageModelRes delegate:self.vDelegate method:Url_Message_Delete responseBlock:^(DeleteMessageModelRes *dataObj, id  _Nullable resp) {
        self.deleteMessageModelRes = dataObj;
    } error:^(DeleteMessageModelRes *dataObj, id  _Nullable resp) {
        self.deleteMessageModelRes = dataObj;
    }];
}

/// eg: 删除全部消息
//- (void)deleteAllMessage {
//    self.deleteAllMessageModelRes = [DeleteAllMessageModelRes new];
//    [DeleteAllMessageModelRes postRequestActionByUrl:Url_Message_DeleteAll paramDict:@{} retunSelf:self retunObject:self.deleteAllMessageModelRes delegate:self.vDelegate method:Url_Message_DeleteAll responseBlock:^(DeleteAllMessageModelRes *dataObj, id  _Nullable resp) {
//        self.deleteAllMessageModelRes = dataObj;
//    } error:^(DeleteAllMessageModelRes *dataObj, id  _Nullable resp) {
//        self.deleteAllMessageModelRes = dataObj;
//    }];
//}

@end
