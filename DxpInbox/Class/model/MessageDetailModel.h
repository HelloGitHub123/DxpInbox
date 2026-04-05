//
//  MessageDetailModel.h
//  UserMessage
//
//  Created by 李标 on 2022/11/22.
//  Check message details 查询消息详情

#import <Foundation/Foundation.h>
#import "UMHJHttpModel.h"

@class MessageDetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface MessageDetailModelRes : UMHJHttpModel

@property (nonatomic, strong) MessageDetailModel *data;
@end



@interface MessageDetailModel : UMHJHttpModel

@property (nonatomic, copy) NSString *messageId;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *receiveTime;
@property (nonatomic, copy) NSString *messageType;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *content;
@end

NS_ASSUME_NONNULL_END
