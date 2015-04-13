//
//  TwitterButtonView.m
//  TwitterIntegration
//  Created by Abbie on 4/9/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
//

#import "TwitterButtonView.h"
#import "TwitterWrapper.h"
#import <TwitterKit/TwitterKit.h>

@interface TwitterButtonView()
@property (nonatomic, strong) TWTRLogInButton *logInButton;
@end
@implementation TwitterButtonView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.logInButton =  [TWTRLogInButton
                                     buttonWithLogInCompletion:
                                     ^(TWTRSession* session, NSError* error) {
                                         if (session) {
                                             [[TwitterWrapper standardWrapper] getBasicInfoOfuserID:[session userID] WithSuccessBlock:^(id responseObject) {
                                                 if(self.twitterButtonViewDelegate &&[self.twitterButtonViewDelegate respondsToSelector:@selector(twitterLogInDelegateWithUserDetails:)]){
                                                     [self.twitterButtonViewDelegate twitterLogInDelegateWithUserDetails:responseObject];
                                                 }
                                             } failureBlock:^(NSError *error) {
                                                 NSLog(@"Error:%@",error);
                                             }];
                                             
                                             
                                             NSLog(@"signed in as%@", [session userName]);
                                         } else {
                                             NSLog(@"error: %@", [error localizedDescription]);
                                         }
                                     }];
 [self addSubViews];
}

-(void)layoutSubviews{
   self.logInButton.frame = self.bounds;
    
}

-(void)addSubViews{
    [self addSubview:self.logInButton];
}

@end
