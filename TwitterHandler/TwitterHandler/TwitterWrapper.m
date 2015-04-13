//
//  TwitterWrapper.m
//  TwitterIntegration
//  Created by Abbie on 4/9/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
//

#import <Fabric/Fabric.h>
#import "TwitterWrapper.h"
#import <TwitterKit/TwitterKit.h>

@implementation TwitterWrapper
+ (TwitterWrapper *)standardWrapper {
    static TwitterWrapper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - Twitter Initialsation

-(void)initialisingTwitterIntegrationWithConsumerKey:(NSString *)consumerKey andConsumerSecretKey:(NSString *)secretKey{
    [[Twitter sharedInstance] startWithConsumerKey:@"uVTWdmZp0KDMKYa1UtcO9mIVY"
                                    consumerSecret:@"TqHiXmHUR0WaHiUAzuDWMVO74Ou74MfZVzUXG6OyzgUGYtXurJ"];
    [Fabric with:@[TwitterKit]];

}

#pragma mark - Method for getting User Basic Info

-(void)getBasicInfoOfuserID:(NSString *)userId WithSuccessBlock:(void(^)(id responseObject))success failureBlock:(void(^)(NSError *error))failure{
        [[[Twitter sharedInstance] APIClient] loadUserWithID:userId
                                                  completion:^(TWTRUser *user,
                                                            NSError *error)
         {
             if(!error){
                 success(user);
             }
             else{
                 failure(error);
             }
         }];

}

#pragma mark - Method for getting User Details

-(void)getUserDetailsWithSuccessBlock:(void(^)(id responseObject))success failureBlock:(void(^)(NSError *error))failure{
    NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
    //NSDictionary *params = @{@"id" : @"20"};
    NSError *clientError;
    NSURLRequest *request = [[[Twitter sharedInstance] APIClient]
                             URLRequestWithMethod:@"GET"
                             URL:statusesShowEndpoint
                             parameters:nil
                             error:&clientError];
    
    if (request) {
        [[[Twitter sharedInstance] APIClient]
         sendTwitterRequest:request
         completion:^(NSURLResponse *response,
                      NSData *data,
                      NSError *connectionError) {
             if (data) {
                 // handle the response data e.g.
                 NSError *jsonError;
                 NSDictionary *json = [NSJSONSerialization
                                       JSONObjectWithData:data
                                       options:0
                                       error:&jsonError];
                 success(json);
             }
             else {
                 failure(connectionError);
                 NSLog(@"Error: %@", connectionError);
             }
         }];
    }
    else {
        failure(clientError);
    }
}


#pragma mark - Method for Getting User Followers List

-(void)getFollowersListOfUserWithSuccessBlock:(void(^)(id responseObject))success failureBlock:(void(^)(NSError *error))failure{
    NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/followers/list.json";
    //NSDictionary *params = @{@"id" : @"20"};
    NSError *clientError;
    NSURLRequest *request = [[[Twitter sharedInstance] APIClient]
                             URLRequestWithMethod:@"GET"
                             URL:statusesShowEndpoint
                             parameters:nil
                             error:&clientError];
    
    if (request) {
        [[[Twitter sharedInstance] APIClient]
         sendTwitterRequest:request
         completion:^(NSURLResponse *response,
                      NSData *data,
                      NSError *connectionError) {
             if (data) {
                 // handle the response data e.g.
                 NSError *jsonError;
                 NSDictionary *json = [NSJSONSerialization
                                       JSONObjectWithData:data
                                       options:0
                                       error:&jsonError];
                 success(json);
             }
             else {
                 failure(connectionError);
                 NSLog(@"Error: %@", connectionError);
             }
         }];
    }
    else {
        failure(clientError);
    }

}

#pragma mark - Method For Compose Tweet

-(void)postTweetWithString:(NSString *)tweetString withStatusBlock:(void(^)(bool result,NSString *description))status{
    TWTRComposer *composer = [[TWTRComposer alloc] init];
    
    [composer setText:tweetString];
    [composer setImage:[UIImage imageNamed:@"fabric"]];
    
    [composer showWithCompletion:^(TWTRComposerResult result) {
        if (result == TWTRComposerResultCancelled) {
            status(NO,@"Tweet Request Cancelled");
        }
        else {
            status(YES,@"Tweet Sent Successfully");
        }
    }];

}

#pragma mark - Method For LogOut

-(void)userLogOut{
    [[Twitter sharedInstance]logOut];
}

@end
