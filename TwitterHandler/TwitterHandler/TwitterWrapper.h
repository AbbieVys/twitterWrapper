//
//  TwitterWrapper.h
//  TwitterIntegration
//  Created by Abbie on 4/9/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
// Copyright (c) 2015 Codelynks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterWrapper : NSObject
+ (TwitterWrapper *)standardWrapper;
-(void)initialisingTwitterIntegrationWithConsumerKey:(NSString *)consumerKey andConsumerSecretKey:(NSString *)secretKey;
-(void)getBasicInfoOfuserID:(NSString *)userId WithSuccessBlock:(void(^)(id responseObject))success failureBlock:(void(^)(NSError *error))failure;
-(void)getUserDetailsWithSuccessBlock:(void(^)(id responseObject))success failureBlock:(void(^)(NSError *error))failure;
-(void)getFollowersListOfUserWithSuccessBlock:(void(^)(id responseObject))success failureBlock:(void(^)(NSError *error))failure;
-(void)postTweetWithString:(NSString *)tweetString withStatusBlock:(void(^)(bool result,NSString *description))status;
-(void)userLogOut;
@end
