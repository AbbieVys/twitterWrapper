//
//  ProfileViewController.m
//  TwitterIntegration
//  Created by Abbie on 4/9/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
//

#import "ProfileViewController.h"
#import "FollowersViewController.h"
#import <TwitterKit/TwitterKit.h>
#import <TWitterHandler/TwitterWrapper.h>

@interface ProfileViewController ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) NSMutableDictionary *user;
@property (nonatomic, strong) UILabel *friendsCountLabel;
@property (nonatomic, strong) UILabel *followersCountLabel;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UIButton *showFollowersButton;
@property (nonatomic, strong) UIButton *tweetButton;
@property (nonatomic, strong) UIButton *logoutButton;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initialisation];
    NSLog(@"User:%@",self.userDetails);
   // NSLog(@"USer Details:%@",[self.user valueForKey:@"name"]);
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
   
    [self customisation];
    [self addSubViews];
}

-(void)initialisation{
    self.user = [[NSMutableDictionary alloc]init];
    self.profileImageView = [[UIImageView alloc]init];
    self.nameLabel = [[UILabel alloc] init];
    self.locationLabel = [[UILabel alloc] init];
    self.followersCountLabel = [[UILabel alloc] init];
    self.friendsCountLabel = [[UILabel alloc] init];
    self.showFollowersButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tweetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
}

-(void)customisation{
    self.profileImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.userDetails profileImageLargeURL]]]];
    self.nameLabel.text = [NSString stringWithFormat:@"Name: %@",[self.userDetails name]];
    [self.showFollowersButton setTitle:@"Show Followers" forState:UIControlStateNormal];
    [self.showFollowersButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.showFollowersButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.showFollowersButton.layer.borderWidth = 1;
    [self.showFollowersButton addTarget:self action:@selector(showFollowersButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.logoutButton addTarget:self action:@selector(logOutButtonClick :) forControlEvents:UIControlEventTouchUpInside];
    [self.logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [self.logoutButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.logoutButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.logoutButton.layer.borderWidth = 1;
    [self.tweetButton setTitle:@"Tweet" forState:UIControlStateNormal];
    [self.tweetButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.tweetButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.tweetButton.layer.borderWidth = 1;
    [self.tweetButton addTarget:self action:@selector(tweetButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self callingUserDetailApi];
    
}

-(void)viewWillLayoutSubviews{
    self.profileImageView.frame = CGRectMake(self.view.frame.size.width/2-50, 100, 100, 100);
    self.nameLabel.frame = CGRectMake(self.view.frame.size.width/2-100, 210, 200, 30);
    self.locationLabel.frame = CGRectMake(self.view.frame.size.width/2-100, 240, 200, 30);
    self.followersCountLabel.frame = CGRectMake(self.view.frame.size.width/2-100, 270, 200, 30);
    self.friendsCountLabel.frame = CGRectMake(self.view.frame.size.width/2-100, 300, 200, 30);
    self.showFollowersButton.frame = CGRectMake(self.view.frame.size.width/2-100, 340, 200, 30);
    self.logoutButton.frame = CGRectMake(self.view.frame.size.width/2-100, 380, 200, 30);
    self.tweetButton.frame = CGRectMake(self.view.frame.size.width/2-100, 420, 200, 30);
    
}

-(void)addSubViews{
    [self.view addSubview:self.profileImageView];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.locationLabel];
    [self.view addSubview:self.followersCountLabel];
    [self.view addSubview:self.friendsCountLabel];
    [self.view addSubview:self.showFollowersButton];
    [self.view addSubview:self.logoutButton];
    [self.view addSubview:self.tweetButton];
}

#pragma mark - Calling User Detail API

-(void)callingUserDetailApi{
    [[TwitterWrapper standardWrapper] getUserDetailsWithSuccessBlock:^(id responseObject) {
        NSLog(@"REsponse Object:%@",responseObject);
        self.user = [responseObject valueForKey:@"user"];
        
        self.locationLabel.text = [NSString stringWithFormat:@"Location: %@",[[self.user valueForKey:@"location"] objectAtIndex:0]];
        self.followersCountLabel.text = [NSString stringWithFormat:@"Followers Count: %@",[[self.user valueForKey:@"followers_count"] objectAtIndex:0]];
        self.friendsCountLabel.text = [NSString stringWithFormat:@"Friends Count: %@",[[self.user valueForKey:@"friends_count"] objectAtIndex:0]];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error:%@",error);
    }];
}

#pragma mark - Followers Button Click

-(void)showFollowersButtonClick:(id)sender{
    FollowersViewController *followersViewController = [[FollowersViewController alloc]init];
    [self.navigationController pushViewController:followersViewController animated:YES];
}

#pragma mark - logOut Button Click

-(void)logOutButtonClick:(id)sender{
    [[TwitterWrapper standardWrapper]userLogOut];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Tweet Button Action

-(void)tweetButtonClick:(id)sender{
    [[TwitterWrapper standardWrapper] postTweetWithString:@"Hi.." withStatusBlock:^(bool result, NSString *description) {
        if(result){
            NSLog(@"Description:%@",description);
        }
        else{
            NSLog(@"Description:%@",description);
        }
    }];
    }
@end
