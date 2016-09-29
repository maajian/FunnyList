//
//  BaseCell.m
//  搞笑排行榜
//
//  Created by 叶英杰 on 9/13/16.
//  Copyright © 2016 叶英杰. All rights reserved.
//

#import "BaseCell.h"
#import "UIImage+MultiFormat.h"
#import "PlayViewController.h"
#import "CoreDataManager.h"
#import "DataModel.h"
#import "ScModel.h"
#define ksZan @"ksZan"
#import "ShareView.h"
#import "UIView+TYAlertView.h"

@interface BaseCell ()

{
//    NSInteger number;
    NSInteger zanflag;
    BOOL markFlag;
    NSMutableDictionary *dic;
    NSString *fileName;
    NSManagedObjectContext *_context;
    UITabBarController *tab;
    NSInteger a;
    
    
}

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *markButton;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UIButton *transpond;

@property (strong,nonatomic)NSMutableArray *imagesArray;

@property (strong, nonatomic) UIButton *button;



@end
@implementation BaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    // Initialization code
}
//- (instancetype)init
//{self = [super init];
//    if (self) {
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(catch:) name:kPhoto object:nil];
//
//    }
//    return self;
//}
//- (void)catch:(NSNotification *)noti
//{
//    NSArray *array = noti.userInfo[@"123"];
//    NSLog(@"array= %@",array);
//}
- (IBAction)markAction:(UIButton*)sender {
    NSLog(@"bool = %i",markFlag);
    UITableView *tableView = (UITableView *)self.superview.superview;
    a =  [tableView indexPathForCell:self].row ;   //获得点击的cell的indexpath的row
    NSLog(@"model=%@",_model);
    
    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UITabBarController class]]) {
            
            tab = (UITabBarController *)nextResponder;
            NSLog(@"tab.selectedIndex = %li",tab.selectedIndex);
            break;
        }
        
        nextResponder = nextResponder.nextResponder;
        
    }    //判断点击的viewcontroller是哪个
    markFlag = !markFlag;
    if (markFlag==NO) {
        [_markButton setBackgroundImage:[UIImage imageNamed:@"biaoqian"] forState:UIControlStateNormal];
       
    }
    if (markFlag == YES) {
        [_markButton setBackgroundImage:[UIImage imageNamed:@"biaoqian_sel"] forState:UIControlStateNormal];
        BaseCell *cell = (BaseCell *)sender.superview.superview;
        _context = [[CoreDataManager shareManager]managedObjectContext];
        ScModel *d = [NSEntityDescription insertNewObjectForEntityForName:@"ScModel" inManagedObjectContext:_context];
        d.iD = cell.model.ID;
        d.title = cell.model.title;
        d.cate_id = cell.model.cate_id;
        d.timeStr = [NSString stringWithFormat:@"添加时间:%@",cell.model.timeStr];
        d.isShoucan = @(1);
        [[CoreDataManager shareManager]saveContext];
//        NSLog(@"%@", [[CoreDataManager shareManager]applicationDocumentsDirectory]);

       
    }
   
    markFlag = NO;
    
    

}


- (IBAction)transpondAction:(UIButton *)sender {
    ShareView *shareView = [ShareView createViewFromNib];
    
    // use UIView Category
    [shareView showInWindow];
    
    
    

}

- (IBAction)favAction:(UIButton *)sender {
    sender.selected = ! sender.selected;
    
    sender.selected ? [sender setBackgroundImage:[UIImage imageNamed:@"video_favo"] forState:UIControlStateNormal] : [sender setBackgroundImage:[UIImage imageNamed:@"video_favo_already"] forState:UIControlStateNormal];
    BaseCell *cell = (BaseCell *)sender.superview.superview;
    NSManagedObjectContext *context = [[CoreDataManager shareManager]managedObjectContext];
    DataModel *d = [NSEntityDescription insertNewObjectForEntityForName:@"DataModel" inManagedObjectContext:context];
    d.iD = cell.model.ID;
    d.title = cell.model.title;
    d.cate_id = cell.model.cate_id;
    
    [[CoreDataManager shareManager]saveContext];
    NSLog(@"%@", [[CoreDataManager shareManager]applicationDocumentsDirectory]);
}

- (IBAction)zanButtonAction:(id)sender {
    [_zanButton setImage:[UIImage imageNamed:@"dianzaned"] forState:UIControlStateNormal];

    NSInteger i =[_zanButton.titleLabel.text integerValue];
    i= i+1;
    if (zanflag==0) {
            [_zanButton setTitle:[NSString stringWithFormat:@"%li",i] forState:UIControlStateNormal];
    }

    if ([_zanButton respondsToSelector:@selector(setTitle:forState:)]) {
        zanflag++;
    }
    if (zanflag==1) {
        [_zanButton setImage:[UIImage imageNamed:@"dianzaned"] forState:UIControlStateNormal];
    }
    if (zanflag>=2) {
        [_zanButton setImage:[UIImage imageNamed:@"dianzaned"] forState:UIControlStateNormal];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你已经赞👍过了" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        UIResponder *nextResponder = self.nextResponder;
        while (nextResponder) {
                    if ([nextResponder isKindOfClass:[UIViewController class]]) {
                     
                        
                     UIViewController *vc = (UIViewController *)nextResponder;
                        [vc presentViewController:alert animated:YES completion:nil];
                        break;
                    }

            nextResponder = nextResponder.nextResponder;
         
   
    }
        


  
//        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:kZanCount];
        
    }

}




- (void)setModel:(BaseModel *)model{

     markFlag = NO;
    if (markFlag==NO) {
        [_markButton setBackgroundImage:[UIImage imageNamed:@"biaoqian"] forState:UIControlStateNormal];
        
    }

    zanflag = 0;
    _model = model;
//    NSDictionary *dic1 = [NSDictionary dictionaryWithContentsOfFile:fileName];
//    NSLog(@"dic1=%@",dic1);
    
    
    
    
    _timeLabel.text = _model.timeStr;

    [_zanButton setTitle:[NSString stringWithFormat:@"%li", _model.zan_num] forState:UIControlStateNormal];

    
    //-----------------------正文-----------------------------
    self.baseTextLabel.text = _model.title;
    
    NSDictionary *attributes = @{ NSFontAttributeName : _baseTextLabel.font};
    
    CGRect rect = [_model.title boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil];
  
    
    CGFloat height = rect.size.height+25;
    
    
    self.baseTextLabel.frame = CGRectMake(10, 40, kScreenWidth - 20, height);
    
    //-----------------------图片-----------------------------
    if (_model.pic) {
        
        if (_model.web_url) {
            
            UIImage *img = [UIImage sd_imageWithData:[NSData dataWithContentsOfURL:_model.pic]];
            
            [self.button setBackgroundImage:img forState:UIControlStateNormal];
            self.button.frame = CGRectMake(kScreenWidth / 3, CGRectGetMaxY(self.baseTextLabel.frame) + 10, kScreenWidth / 3, 100);
            
            
        }else{
            [self.imgView sd_setImageWithURL:_model.pic];
            
            self.imgView.frame = CGRectMake(10, CGRectGetMaxY(self.baseTextLabel.frame) + 10, kScreenWidth, _model.pic_h);
            
        }
        
 
       
    }
    
    
}


- (FontLabel *)baseTextLabel{
    
    if (_baseTextLabel == nil) {
        _baseTextLabel = [[FontLabel alloc]initWithFrame:CGRectZero];
        _baseTextLabel.numberOfLines = 0; //设置为0 则自动换行
//        number = _baseTextLabel.num;

        
        [self.contentView addSubview:_baseTextLabel];
    }
    
    return _baseTextLabel;
    
}





- (UIButton *)button{
    if (_button == nil) {
        _button = [[UIButton alloc]initWithFrame:CGRectZero];
        [_button setImage:[UIImage imageNamed:@"playVideo"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
        
        
    }
    
    
    return _button;
}


- (void)buttonAction{
    
    
    
    
    PlayViewController *ctrl = [[PlayViewController alloc]init];
    UIResponder *next = self.nextResponder;
    while (1) {
        if ([next isKindOfClass:[UIViewController class]]) {
            break;
        }
        next = next.nextResponder;
    }
    
    
    UIViewController *viewCtrl = (UIViewController *)next;
    [viewCtrl setHidesBottomBarWhenPushed:YES];
    [viewCtrl.navigationController pushViewController:ctrl animated:YES];
    
    NSDictionary *dic1 = @{@"mp4_url" : _model.mp4_url,
                          @"web_url" : _model.web_url};
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"play" object:nil userInfo:dic1];
    
    
    [viewCtrl setHidesBottomBarWhenPushed:NO];
    
    
    
    
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_imgView];
  
//        [_imgView addGestureRecognizer:tap];
    }
    
    return _imgView;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
