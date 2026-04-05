//
//  MessageListModel.m
//  UserMessage
//
//  Created by 李标 on 2022/11/21.
//

#import "MessageListModel.h"

@implementation MessageListModelRes

- (NSDictionary *)hj_setupObjectClassInArray {
	return @{
		@"data" : [Message class],
	};
}

@end


@implementation Message


@end


