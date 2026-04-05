//
//  MessageLogic.h
//  UserMessage
//
//  Created by 李标 on 2022/11/21.
//  Message Management 消息管理

#import <Foundation/Foundation.h>
#import "UnreadMessageModel.h"
#import "MessageListModel.h"
#import "MessageDetailModel.h"
#import "MarkMessageReadModel.h"
#import "MarkAllMessagesReadModel.h"
#import "DeleteMessageModel.h"
#import "DeleteAllMessageModel.h"

// Request unread messages
typedef void(^UnreadMessageBlock)(UnreadMessageModelRes *unreadMessageModelRes, NSString *errorMsg);

// List of request messages
typedef void(^MessageListBlock)(MessageListModelRes *messageListModel, NSString *errorMsg);

// Request Message Details
typedef void(^MessageDetailBlock)(MessageDetailModelRes *messageDetailModelRes, NSString *errorMsg);

// Set messages to be read
typedef void(^MarkMessageReadBlock)(MarkMessageReadModelRes *markMessageReadModel, NSString *errorMsg);

// Set all messages to be read
//typedef void(^MarkAllMessagesReadBlock)(MarkAllMessagesReadModel *markAllMessagesReadModel, NSString *errorMsg);

// Delete individual messages
typedef void(^DeleteMessageBlock)(DeleteMessageModelRes *deleteMessageModel, NSString *errorMsg);

// Delete all individual messages
//typedef void(^DeleteAllMessageBlock)(DeleteAllMessageModel *deleteAllMessageModel, NSString *errorMsg);


NS_ASSUME_NONNULL_BEGIN
@interface MessageLogic : NSObject

#pragma mark -- 未读数量
/// eg: Request unread messages
/// @param unreadMessageBlock Return data callback
- (void)requestUnreadMessageWithBlock:(UnreadMessageBlock)unreadMessageBlock;

/// eg:Request unread messages
/// @param prefix Set the prefix for the number
/// @param subsId User's unique identifier
/// @param serviceNumber  User's number
/// @param unreadMessageBlock Return data callback
- (void)requestUnreadMessageWithBlockWithPrefix:(NSString *)prefix subsId:(NSInteger)subsId serviceNumber:(NSString *)serviceNumber block:(UnreadMessageBlock)unreadMessageBlock;

#pragma mark -- 消息列表
/// eg: List of request messages
/// @param messageListBlock Return data callback
- (void)requestMessageListByPageInfoWithBlock:(MessageListBlock)messageListBlock;

/// eg: List of request messages
/// @param pageIndex  Indicates the index of the page when retrieving paginated data, starting from 1.
/// @param pageSize Indicates the index of the page when retrieving paginated data, starting from 1.
/// @param messageTypes W:Warning (default:默认值)   I:Important   P:Promotion   M: Generic notification
/// @param subsId  The unique identifier for the subscriber.
/// @param prefix The unique identifier for the subscriber.
/// @param serviceNumber The service number associated with the subscriber.
/// @param messageListBlock Return data callback
- (void)requestMessageListByPageInfoWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize messageTypes:(NSString *)messageTypes subsId:(NSInteger)subsId prefix:(NSString *)prefix serviceNumber:(NSString *)serviceNumber block:(MessageListBlock)messageListBlock;

#pragma mark -- 消息详情
/// eg: Request Message Details
/// @param messageId Single message id
/// @param messageDetailBlock Return data callback
- (void)requestMessageDetailByMessageId:(NSString *)messageId block:(MessageDetailBlock)messageDetailBlock;

#pragma mark -- 设置消息已读
// Set messages to be read
- (void)requestMessageSetReadByMessageIds:(NSArray *)messageIds block:(MarkMessageReadBlock)markMessageReadBlock;

/// eg: Set messages to be read
/// @param messageIds  A set of message ids
/// @param prefix Set the prefix for the number
/// @param subsId User's unique identifier
/// @param serviceNumber  User's number
/// @param markMessageReadBlock Return data callback
- (void)requestMessageSetReadByMessageIds:(NSArray *)messageIds subsId:(NSInteger)subsId prefix:(NSString *)prefix serviceNumber:(NSString *)serviceNumber block:(MarkMessageReadBlock)markMessageReadBlock;

#pragma mark -- 删除消息
/// eg:Delete individual messages
/// @param messageIds  A set of message ids
/// @param deleteMessageBlock Return data callback
- (void)requestDeleteMessageByMessageIds:(NSArray *)messageIds block:(DeleteMessageBlock)deleteMessageBlock;

/// eg:Delete individual messages
/// @param messageIds  A set of message ids
/// @param prefix Set the prefix for the number
/// @param subsId User's unique identifier
/// @param serviceNumber  User's number
/// @param deleteMessageBlock Return data callback
- (void)requestDeleteMessageByMessageIds:(NSArray *)messageIds subsId:(NSInteger)subsId prefix:(NSString *)prefix serviceNumber:(NSString *)serviceNumber block:(DeleteMessageBlock)deleteMessageBlock;

/// Set the prefix for the number
@property (nonatomic, copy) NSString *prefix;

/// Set the number of information per page
@property (nonatomic, assign) NSInteger pageSize;

/// Set the current page number
@property (nonatomic, assign) NSInteger currentPage;

// W:Warning(default)  I:Important  P:Promotion  M:Generic notification
@property (nonatomic, copy) NSString *msgType;

// subsId
@property (nonatomic, assign) NSInteger subsId;

// serviceNumber
@property (nonatomic, copy) NSString *serviceNumber;

/// eg:Set all messages to be read
/// @param markAllMessagesReadBlock Return data callback
//- (void)requestMessageSetAllReadWithBlock:(MarkAllMessagesReadBlock)markAllMessagesReadBlock;

/// eg:Delete all individual messages
/// @param deleteAllMessageBlock Return data callback
//- (void)requestDeleteAllMessageWithBlock:(DeleteAllMessageBlock)deleteAllMessageBlock;

/// eg:Set request token
/// @param token Unique identification
- (void)setHttpRequestToken:(NSString *)token;

/// Pull up to refresh
//- (void)refreshMessageList;

/// Pull down to load
//- (void)loadMorMessageList;

/// Get the current page number
- (NSInteger)getCurrentPageNumber;

/// Get the current page size
- (void)getCurrentPageSizeWithCompletion:(void (^)(NSString *pageSize, NSString *errorMsg))completion;

// State分为A未读和R已读
//@property (nonatomic, copy) NSString *states;
//@property (nonatomic, copy) void (^refresMessage)(NSMutableArray<Message *> *modelList);
@end

NS_ASSUME_NONNULL_END
