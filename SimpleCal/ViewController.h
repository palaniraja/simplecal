//
//  ViewController.h
//  SimpleCal
//
//  Created by Palani raja on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCMonthGridView.h"
#import "NSDate+TKCategory.h"
#import "MyDatePickerController.h"

@interface ViewController : UIViewController<MyDatePickerDelegate>{
    int noOfWeeks;
    int daysPerWeek;
    NSDate *theDate;
    UIPopoverController *popover;
}

@property (weak, nonatomic) IBOutlet SCMonthGridView *monthView;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *mondayLabel;
@property (weak, nonatomic) IBOutlet UILabel *tuesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *wednesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *thursdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *fridayLabel;
@property (weak, nonatomic) IBOutlet UILabel *saturdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *sundayLabel;


-(void)setupGrid;
-(void)fillDaysinGrid;

-(void)presentDatePicker:(id)sender;

-(void) updateCalendar;
- (IBAction)infoTapped:(id)sender;

@end
