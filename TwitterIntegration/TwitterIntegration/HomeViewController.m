//
//  ViewController.m
//  TwitterIntegration
//  Created by Abbie on 4/9/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
//
#import <TwitterHandler/TwitterButtonView.h>
#import "HomeViewController.h"
#import "ProfileViewController.h"



@interface HomeViewController ()<TwitterButtonViewDelegate>
@property (nonatomic, strong) TwitterButtonView *twitterButtonView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self addSubViews];
        self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)initialisation{
    self.twitterButtonView = [[TwitterButtonView alloc]init];
    self.twitterButtonView.twitterButtonViewDelegate = self;
}


-(void)addSubViews{
    [self.view addSubview:self.twitterButtonView];
}

-(void)viewWillLayoutSubviews{
    self.twitterButtonView.frame = CGRectMake(self.view.frame.size.width/2 -100, self.view.frame.size.height/2-30, 200, 30);
}

#pragma mark - Twitter button Delegate

-(void)twitterLogInDelegateWithUserDetails:(id)userDetails{
    NSLog(@"User Details:%@",userDetails);
    ProfileViewController *profileViewController = [[ProfileViewController alloc]init];
    profileViewController.userDetails = userDetails;
    [self.navigationController pushViewController:profileViewController animated:YES];
}
@end
