//
//  KSReserveView.h
//  Akvamarin
//
//  Created by KulikovS on 25.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSView.h"

@interface KSReserveView : KSView
@property (nonatomic, strong) IBOutlet UIDatePicker  *startTime;
@property (nonatomic, strong) IBOutlet UIDatePicker  *endTime;
@property (nonatomic, strong) IBOutlet UIDatePicker  *date;

@property (nonatomic, strong) IBOutlet UITextField   *name;
@property (nonatomic, strong) IBOutlet UITextField   *telephonNumber;
@property (nonatomic, strong) IBOutlet UITextField   *email;

@property (nonatomic, strong) IBOutlet UIButton      *sendMail;



@end
