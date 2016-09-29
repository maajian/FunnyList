//
//  TuijianTableViewCell.m
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/18.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "TuijianTableViewCell.h"

@implementation TuijianTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
 -(void)setModel:(TuijianModel *)model
{
    _model = model;
    [_downLoad setImage:[UIImage imageNamed:@"download_selected_app"] forState:UIControlStateNormal];
    [_appImageView sd_setImageWithURL:_model.appIconURL];
    _appName.text = _model.name;
    self.textLabel1.text = _model.app_intro;
    CGFloat textHeight = [WXLabel getTextHeight:[UIFont systemFontOfSize:14].pointSize width:180 text:self.textLabel1.text linespace:3];
    self.textLabel1.frame = CGRectMake(75, 45, 180, textHeight);
}
- (WXLabel *)textLabel1
{
    if (_textLabel1 ==nil) {
        _textLabel1 = [[WXLabel alloc]initWithFrame:CGRectZero];
        _textLabel1.font = [UIFont systemFontOfSize:12];
        _textLabel1.numberOfLines = 0   ;
        _textLabel1.linespace = 3;
        [self.contentView addSubview:_textLabel1];
    }
    return _textLabel1;}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
