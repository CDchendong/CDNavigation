//
//  ViewController.m
//  CDNavigation
//
//  Created by CDchen on 2017/10/10.
//  Copyright © 2017年 CDchen. All rights reserved.
//

#import "ViewController.h"
#define KWidth [[UIScreen mainScreen] bounds].size.width
#define KHeight [[UIScreen mainScreen] bounds].size.height
#define HeadHeight 164

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     CGRect orginYframe;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *titleLB;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWidth, KHeight) style:UITableViewStylePlain];
        _tableView.rowHeight = 60;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self InitView];
}

- (void)InitView
{
    _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
    _bgImage.image = [UIImage imageNamed:@"1111"];
    _bgImage.frame = CGRectMake(0, 0, KWidth, KHeight);
    orginYframe = _bgImage.frame;
    [self.view addSubview:_bgImage];
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 64)];
    _headView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self.view addSubview:_headView];

    _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KWidth, 40)];
    _titleLB.text=@"测试一下";
    _titleLB.textColor = [UIColor redColor];
    _titleLB.textAlignment = 1;
    [_headView addSubview:_titleLB];
    [self.view addSubview:self.tableView];

    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, HeadHeight)];
    headview.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = headview;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text =@"测试一下";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY < HeadHeight)
    {
        _titleLB.textColor = [UIColor blueColor];
        _headView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:offSetY/HeadHeight];
    }
    else
    {
        _titleLB.textColor = [UIColor redColor];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    if (offSetY > 0)
    {
        _bgImage.frame = ({
            CGRect frame = _bgImage.frame;
            frame.origin.y = orginYframe.origin.y - offSetY;
            frame;
        });
    }
    else
    {
       _bgImage.frame = ({
        CGRect frame = _bgImage.frame;
        frame.size.width =orginYframe.size.height -offSetY;
        frame.size.height = orginYframe.size.height *frame.size.width/ orginYframe.size.width;
        frame.origin.x = -(frame.size.width - orginYframe.size.width)/2;
        frame;
    });
    }
    if (offSetY ==0)
    {
        _titleLB.textColor = [UIColor redColor];
    }
}

@end
