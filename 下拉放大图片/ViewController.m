//
//  ViewController.m
//  下拉放大图片
//
//  Created by 舒通 on 2018/5/8.
//  Copyright © 2018年 舒通. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)  UITableView *tableView;

@end

static NSString *identifier = @"cellID";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

#pragma mark  < tableview data > -- shutong
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"index == %ld",indexPath.row];
    return cell;
}

#pragma mark  < scrollview delegate > -- shutong
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    HeaderView *headView = (HeaderView *)self.tableView.tableHeaderView;
    [headView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
}

#pragma mark  < create UI > -- shutong
- (void)createUI
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.tableHeaderView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 200)];
    
}

#pragma mark  < setter / getter > -- shutong
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 100;
        self.view = _tableView;
    }
    return _tableView;
}

@end
