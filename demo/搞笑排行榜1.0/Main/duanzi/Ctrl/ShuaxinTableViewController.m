//
//  ShuaxinTableViewController.m
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/21.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "ShuaxinTableViewController.h"


#import "ScModel.h"
#import "CoreDataManager.h"
@interface ShuaxinTableViewController ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
{
     NSFetchedResultsController *_resultsController;
    UITableView *_tableView;
     NSArray *_dataArray;
    NSPredicate *_predicate;
    UITabBarController *tab;
    NSManagedObjectContext *context;
}
@end

@implementation ShuaxinTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    [self.navigationItem setHidesBackButton:YES  animated:YES];
    [self createleftButton];
    [self createrightButton];
    [self panduan];
    [self createFetchResultController];
    [self createTableView];
    
    
    self.title = @"书签记录";
}
- (void)panduan
{
    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITabBarController class]]) {
            
            tab = (UITabBarController *)nextResponder;
            NSLog(@"tab.selectedIndex = %li",tab.selectedIndex);
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }    //判断点击的viewcontroller是哪个
    switch (tab.selectedIndex) {
        case 0:
            _predicate = [NSPredicate predicateWithFormat:@"cate_id=6"];
            [self fetchData];
            
            break;
        case 1:
            _predicate = [NSPredicate predicateWithFormat:@"cate_id=9"];
            [self fetchData];
            
            
            break;
        case 2:
            _predicate = [NSPredicate predicateWithFormat:@"cate_id=7"];
            [self fetchData];
            
            
            break;
        case 3:
            _predicate = [NSPredicate predicateWithFormat:@"cate_id=16"];
            [self fetchData];
            
            
            break;
            
            
        default:
            break;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _predicate = [NSPredicate predicateWithFormat:@"cate_id=6"];
    [self fetchData];
    
   
}
- (void)fetchData{
    
     context = [[CoreDataManager shareManager]managedObjectContext];
    //创建查询请求对象
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"ScModel"];
    
    
    
    //设置查询条件
    
    request.predicate = _predicate;
    
    
    
    //执行查询请求
    NSError *error;
    _dataArray = [context  executeFetchRequest:request error:&error];
    
    [_tableView reloadData];
    
    
    
}
- (void)createFetchResultController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ScModel"];
    
     NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"iD" ascending:NO];
    request.sortDescriptors = @[sort1];
    context = [[CoreDataManager shareManager] managedObjectContext];

    _resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    //3.设置监听的代理  通过代理，能够获取到数据改变事件。
    _resultsController.delegate = self;
    
    //4.开始监听数据
    [_resultsController performFetch:nil];
    
}

- (void)createleftButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0,40, 30);
    [button setTitle:@"清空" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)createrightButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0,40, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)clean
{
    for (ScModel *user in _dataArray) {
        //删除对象
        [context deleteObject:user];
    }
    //保存context
    [context save:nil];
    
    NSMutableArray *array1 = [_dataArray mutableCopy];

    [array1 removeAllObjects];
    _dataArray = [array1 copy];
    [_tableView reloadData];                    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
  
    self.tabBarController.tabBar.hidden = NO;
}

- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" ];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    ScModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = model.timeStr;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScModel *model  =_dataArray[indexPath.row];
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:16]};
    
    CGRect rect = [model.title boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil];
    CGFloat height = rect.size.height+25;
    return height+40;
}
#pragma mark - delete
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     return    UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
 
}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//  
//    ScModel *stu = _dataArray[indexPath.row];
//    if (editingStyle ==UITableViewCellEditingStyleDelete)
//    {
//        
//       [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
////        for (ScModel *user in _dataArray) {
////            //删除对象
//            [context deleteObject:stu];
////        }
//        //保存context
//        [context save:nil];
//    [_tableView reloadData];
//        
//      
//}
//}
//- (void)controller:(NSFetchedResultsController *)controller
//   didChangeObject:(id)anObject
//       atIndexPath:(nullable NSIndexPath *)indexPath
//     forChangeType:(NSFetchedResultsChangeType)type
//      newIndexPath:(nullable NSIndexPath *)newIndexPath {
//    
//    //判断是插入数据，还是删除数据
//    switch (type) {
//        case NSFetchedResultsChangeInsert:
//        {
//            //插入一行单元格
//            [_tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            
//            break;
//        }
//        case NSFetchedResultsChangeDelete:
//        {
//            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//        }
//        case NSFetchedResultsChangeUpdate:
//        {
//            [_tableView reloadData];
//            break;
//        }
//        default:
//            break;
//    }
//    
//    
//}
//- (void)controller:(NSFetchedResultsController *)controller
//  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
//           atIndex:(NSUInteger)sectionIndex
//     forChangeType:(NSFetchedResultsChangeType)type {
//    
//    
//    //判断是插入数据，还是删除数据
//    switch (type) {
//        case NSFetchedResultsChangeInsert:
//        {
//            
//            NSIndexSet *set = [NSIndexSet indexSetWithIndex:sectionIndex];
//            [_tableView insertSections:set withRowAnimation:UITableViewRowAnimationFade];
//            break;
//        }
//        case NSFetchedResultsChangeDelete:
//        {
//            NSIndexSet *set = [NSIndexSet indexSetWithIndex:sectionIndex];
//            [_tableView deleteSections:set withRowAnimation:UITableViewRowAnimationFade];
//            break;
//        }
//        default:
//            break;
//    }
//    
//}
//
//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
//    //数据库中内容 将要开始改变
//    //表视图 开始刷新数据
//    [_tableView beginUpdates];
//}
//
//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    //数据库中内容 改变完成
//    //表视图 刷新结束
//    [_tableView endUpdates];
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
