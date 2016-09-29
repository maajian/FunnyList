//
//  LeftViewController.m
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/18.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "LeftViewController.h"
#import "TuijianViewController.h"
#import "BaseNavController.h"
#import "DuanziViewController.h"
#define kCurrentRow @"kCurrentRow"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITableView *_tableView;
    NSArray *_data;
    NSArray *_imageData;
    UIPickerView *_pickerFontView;
    NSArray *_fontArray;
    UIPickerView *_pickerScrollView;
    NSArray *_scrollArray;
    BOOL flag1;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag1 = NO;
    [self createTableView];
    _data = @[@"精彩推荐",@"正文字体",@"滑动方式"];
    _imageData = @[@"settings_theme_icon",@"icon_fontsize",@"Rate@2x"];
    _fontArray = @[@"最小",@"较小",@"中等",@"较大",@"最大"];
    _scrollArray = @[@"默认",@"同步",@"旋转",@"3D",@"平移"];
    // Do any additional setup after loading the view.
}
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, 35, 55, 55)];
    [cell addSubview:label];
    label.text = _data[indexPath.row];
        label.font = [UIFont systemFontOfSize:13.5];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 10, 30, 30)];
    imgView.image = [UIImage imageNamed:_imageData[indexPath.row]];
    [cell addSubview:imgView];
    }
    if (indexPath.row==0) {
        UIImageView *newImgView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 5,35, 35)];
        [cell addSubview:newImgView];
        newImgView.image = [UIImage imageNamed:@"top_new@2x"];
        
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 100;

    }
    else if (indexPath.row==1)
    {
        return 100;
    }
   
    else if (indexPath.row==2)

    {
        return 100;
    }
    return 0;
}
 -(void)viewWillAppear:(BOOL)animated
{
    NSString *stringNum = [[NSUserDefaults standardUserDefaults]objectForKey:kCurrentRow];
    NSInteger num = [stringNum integerValue];
    [_pickerScrollView selectRow:num inComponent:0 animated:YES];
    MMExampleDrawerVisualStateManager *mmd = [MMExampleDrawerVisualStateManager sharedManager];
    mmd.leftDrawerAnimationType = num;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        TuijianViewController *tuijian = [[TuijianViewController alloc]init];
        UINavigationController *navi = [[BaseNavController alloc]initWithRootViewController:tuijian];
        [self presentViewController:navi animated:YES completion:nil];
        
    }
    if (indexPath.row==1) {
       
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            nil;
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        
        
        _pickerFontView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 263, 216)];
        
        _pickerFontView.showsSelectionIndicator = YES;
        _pickerFontView.delegate = self;
        _pickerFontView.dataSource = self;
        _pickerFontView.tag = 1001;
        NSString *stringFont =  [[NSUserDefaults standardUserDefaults]objectForKey:kCurrentFont];
        NSInteger fontNum = [stringFont integerValue];
        [_pickerFontView selectRow:fontNum inComponent:0 animated:nil];
        
        [alert.view addSubview:_pickerFontView];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    if (indexPath.row==2) {
        
        UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert2 addAction:cancelAction2];
        [alert2 addAction:okAction2];
        
        
        _pickerScrollView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 263, 216)];
//        [_pickerScrollView selectRow:5 inComponent:1 animated:YES];
        _pickerScrollView.showsSelectionIndicator = YES;
        _pickerScrollView.delegate = self;
        _pickerScrollView.dataSource = self;
        _pickerScrollView.tag = 1001;
        
        NSString *stringNum = [[NSUserDefaults standardUserDefaults]objectForKey:kCurrentRow];
        NSInteger num = [stringNum integerValue];
        [_pickerScrollView selectRow:num inComponent:0 animated:YES];
 
        [alert2.view addSubview:_pickerScrollView];
        
        [self presentViewController:alert2 animated:YES completion:nil];
        

    }
    [_tableView reloadData];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:_pickerFontView]) {
        return _fontArray.count;
    }
    if ([pickerView isEqual:_pickerScrollView]) {
        return _scrollArray.count;
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED
{
    if ([pickerView isEqual:_pickerFontView]) {
        return 80;
    }
    if ([pickerView isEqual:_pickerScrollView]) {
        return 100;
    }
    return 0;

}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return 25;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  
    if ([pickerView isEqual:_pickerFontView]) {
        return [_fontArray objectAtIndex:row];
    }
    if ([pickerView isEqual:_pickerScrollView]) {
        return [_scrollArray objectAtIndex:row];
    }
    return 0;

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:_pickerScrollView]) {
        MMExampleDrawerVisualStateManager *mmd = [MMExampleDrawerVisualStateManager sharedManager];
        mmd.leftDrawerAnimationType = row;
        NSString *num = [NSString stringWithFormat:@"%li",row];
        NSLog(@"num = %@",num);
        [[NSUserDefaults standardUserDefaults]setObject:num forKey:kCurrentRow];

    }
    if ([pickerView isEqual:_pickerFontView]) {
        NSString *fontNum = [NSString stringWithFormat:@"%li",row];
        NSLog(@"fontNum = %@",fontNum);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:fontNum forKey:@"fontChange"];
        [[NSNotificationCenter defaultCenter]postNotificationName:kFontChangeNoti object:nil userInfo:dic];
        
        [[NSUserDefaults standardUserDefaults]setObject:fontNum forKey:kCurrentFont];
        
    }
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
