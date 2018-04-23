//
//  FMPickerControl.m
//  Sample
//
//  Created by wjy on 2018/4/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMPickerControl.h"
#import "STPickerSingle.h"
#import "STPickerDate.h"
#import "STPickerArea.h"

@interface FMPickerControl ()<
    STPickerAreaDelegate,
    STPickerSingleDelegate,
    STPickerDateDelegate>

@end

@implementation FMPickerControl

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    if (textField == self.vc.textArea) {
        [self.vc.textArea resignFirstResponder];
        STPickerArea *pickerArea = [[STPickerArea alloc] init];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:STPickerContentModeBottom];
        [pickerArea show];
    }
    
    if (textField == self.vc.textSingle) {
        [self.vc.textSingle resignFirstResponder];
        
        NSMutableArray *arrayData = [NSMutableArray array];
        for (int i = 1; i < 1000; i++) {
            NSString *string = [NSString stringWithFormat:@"%d", i];
            [arrayData addObject:string];
        }
        
        STPickerSingle *pickerSingle = [[STPickerSingle alloc] init];
        [pickerSingle setArrayData:arrayData];
        [pickerSingle setTitle:@"请选择🙃"];
        [pickerSingle setTitleUnit:@"🙄"];
        [pickerSingle setContentMode:STPickerContentModeBottom];
        [pickerSingle setDelegate:self];
        [pickerSingle show];
    }
    
    if (textField == self.vc.textDate) {
        [self.vc.textDate resignFirstResponder];
        
        STPickerDate *pickerDate = [[STPickerDate alloc] init];
        [pickerDate setYearLeast:2000];
        [pickerDate setYearSum:50];
        [pickerDate setContentMode:STPickerContentModeBottom];
        [pickerDate setDelegate:self];
        [pickerDate show];
    }
}

#pragma mark - STPickerAreaDelegate
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    self.vc.textArea.text = text;
}

#pragma mark - STPickerSingleDelegate
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    NSString *text = [NSString stringWithFormat:@"%@ 🙃", selectedTitle];
    self.vc.textSingle.text = text;
}

#pragma mark - STPickerDateDelegate
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%zd年%zd月%zd日", year, month, day];
    self.vc.textDate.text = text;
}

@end
