//
//  FollowersViewController.m
//  TwitterIntegration
//  Created by Abbie on 4/9/15.
//  Copyright (c) 2015 Abbie. All rights reserved.
//
#import "FollowersViewController.h"
#import <TwitterHandler/TwitterWrapper.h>

@interface FollowersViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *followersTableView;
@property (nonatomic, strong) NSArray *followersArray;
@end

@implementation FollowersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialisation];
    [self customisation];
    [self addSubViews];
    // Do any additional setup after loading the view.
}

-(void)initialisation{
    self.followersTableView = [[UITableView alloc]init];
    self.followersTableView.dataSource = self;
    self.followersTableView.delegate = self;
}

-(void)customisation{
    [[TwitterWrapper standardWrapper]getFollowersListOfUserWithSuccessBlock:^(id responseObject) {
        self.followersArray = [responseObject valueForKey:@"users"];
        [self.followersTableView reloadData];
    } failureBlock:^(NSError *error) {
    }];
    
}

-(void)addSubViews{
    [self.view addSubview:self.followersTableView];
}

-(void)viewWillLayoutSubviews{
    self.followersTableView.frame = self.view.bounds;
}
#pragma mark - Table view Datasources

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.followersArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
   // NSLog(@"Folloer image:%@",[[self.followersArray objectAtIndex:indexPath.row] valueForKey:@"profile_image_url"]);
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.followersArray objectAtIndex:indexPath.row] valueForKey:@"profile_image_url"]]]];
    cell.textLabel.text = [[self.followersArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}
@end
