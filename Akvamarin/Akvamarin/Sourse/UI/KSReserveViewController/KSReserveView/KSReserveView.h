//
//  KSReserveView.h
//  Akvamarin
//
//  Created by KulikovS on 25.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSView.h"

@interface KSReserveView : KSView
@property (nonatomic, strong) IBOutlet UIScrollView  *scrollView;
@property (nonatomic, strong) IBOutlet UIControl     *controlView;

@property (nonatomic, strong) IBOutlet UIDatePicker  *startTimePicker;
@property (nonatomic, strong) IBOutlet UIDatePicker  *endTimePicker;
@property (nonatomic, strong) IBOutlet UIDatePicker  *datePicker;

@property (nonatomic, strong)          UITextField   *activeField;
@property (nonatomic, strong) IBOutlet UITextField   *nameField;
@property (nonatomic, strong) IBOutlet UITextField   *phoneNumberField;
@property (nonatomic, strong) IBOutlet UITextField   *emailField;

@property (nonatomic, strong) IBOutlet UIButton      *sendMailButton;



@end
