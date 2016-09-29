//
//  MarkViewController.m
//  搞笑排行榜
//
//  Created by 叶英杰 on 9/21/16.
//  Copyright © 2016 叶英杰. All rights reserved.
//

#import "MarkViewController.h"
#import "DataModel.h"
#import "CoreDataManager.h"
@interface MarkViewController ()<UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_resultsController;
    NSArray *_dataArray;
    NSPredicate *_predicate;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedCtrl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *edit;



@end

@implementation MarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self createFetchResultController];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    [_segmentedCtrl addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)segmentedAction:(UISegmentedControl *)seg{
    NSLog(@"%li",seg.selectedSegmentIndex);
    
    NSInteger indext = seg.selectedSegmentIndex;
    
    switch (indext) {
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
//查询数据库数据
- (void)fetchData{
    
    NSManagedObjectContext *context = [[CoreDataManager shareManager]managedObjectContext];
    //创建查询请求对象
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"DataModel"];
    
    
    
    //设置查询条件

    request.predicate = _predicate;
    
    
    
    //执行查询请求
    NSError *error;
    _dataArray = [context  executeFetchRequest:request error:&error];
    
    [_tableView reloadData];
    
    
    
}







- (void)createFetchResultController{
    //创建查询请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DataModel"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"iD" ascending:NO];
    request.sortDescriptors = @[sort];
    
    //创建查询结果控制器
    NSManagedObjectContext *context = [[CoreDataManager shareManager]managedObjectContext];
    _resultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    _resultsController.delegate = self;
    [_resultsController performFetch:NULL];
    
    
    
    
}

 #pragma mark - tableview datasoure

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    //获取分组对象
//    id<NSFetchedResultsSectionInfo> sectionObject = _resultsController.sections[section];
//    
//    return sectionObject.numberOfObjects;

    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
//    id<NSFetchedResultsSectionInfo> sectionObj = _resultsController.sections[indexPath.section];
//    NSArray *objs = sectionObj.objects;
//    
//    DataModel *model = objs[indexPath.row];
//    
//    cell.textLabel.text = model.title;
//    cell.textLabel.numberOfLines = 0;
//    return cell;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    DataModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.numberOfLines = 0;
    return cell;
    
    
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *attributes = @{ NSFontAttributeName : kTextFont};
//    id<NSFetchedResultsSectionInfo> sectionObj = _resultsController.sections[indexPath.section];
//    NSArray *objs = sectionObj.objects;
    
    DataModel *model = _dataArray[indexPath.row];
    CGRect rect = [model.title boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil];
    CGFloat height = rect.size.height;
    
    return height;
}





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
