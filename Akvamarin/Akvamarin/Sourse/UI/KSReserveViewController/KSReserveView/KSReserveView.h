//
//  KSReserveView.h
//  Akvamarin
//
//  Created by KulikovS on 25.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSView.h"

@interface KSReserveView : KSView
@property (nonatomic, strong) IBOutlet UIDatePicker  *startTimePicker;
@property (nonatomic, strong) IBOutlet UIDatePicker  *endTimePicker;
@property (nonatomic, strong) IBOutlet UIDatePicker  *datePicker;

//@property (nonatomic, strong) IBOutlet UITextField   *nameField;
//@property (nonatomic, strong) IBOutlet UITextField   *phoneNumberField;
//@property (nonatomic, strong) IBOutlet UITextField   *emailField;

@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *textFields;

@property (nonatomic, strong) IBOutlet UIButton      *sendMailButton;



@end
