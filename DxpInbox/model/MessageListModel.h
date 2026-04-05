//
//  MessageListModel.h
//  UserMessage
//
//  Created by 李标 on 2022/11/21.
//  Message List 消息列表

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UMHJHttpModel.h"

@class Message;

NS_ASSUME_NONNULL_BEGIN

@interface MessageListModelRes : UMHJHttpModel

@property (nonatomic, copy) NSString *totalCount;
@property (nonatomic, copy) NSString *totalPages;
@property (nonatomic, copy) NSString *pageSize;
@property (nonatomic, copy) NSString *pageIndex;
@property (nonatomic, strong) NSMutableArray <Message *>*data;
@end



@interface Message : UMHJHttpModel

@property (nonatomic, copy) NSString *messageId;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *receiveTime;
@property (nonatomic, copy) NSString *messageType;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, assign) BOOL unread;
@property (nonatomic, copy) NSString *content;


//  Whether to select(Multiple choice) 是否选择(多选)
@property (nonatomic, assign) BOOL isSelected;
// model cell 高度
//- (CGFloat)getCellHeight;
@property (nonatomic, assign) CGFloat imgHeight;

//- (NSDictionary *)toDictionary;
@end




NS_ASSUME_NONNULL_END
