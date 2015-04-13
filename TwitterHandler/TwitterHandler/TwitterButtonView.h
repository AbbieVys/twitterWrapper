//
//  TwitterButtonView.h
//  TwitterIntegration
//  Created by Abbie on 4/9/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol TwitterButtonViewDelegate;
@interface TwitterButtonView : UIView
@property (nonatomic, assign) id<TwitterButtonViewDelegate>twitterButtonViewDelegate;
@end
@protocol TwitterButtonViewDelegate <NSObject>

-(void)twitterLogInDelegateWithUserDetails:(id)userDetails;

@end
