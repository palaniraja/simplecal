//
//  MyDatePickerController.h
//  CN
//
//  Created by Palaniraja on 24/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDatePickerDelegate 

-(void) selectedDate:(NSDate *)date;
-(void) cancelDateSelection;

@end

@interface MyDatePickerController : UIViewController <UIPickerViewDelegate>{

	IBOutlet UIDatePicker *datePicker;
	UIViewController *parentViewCntler;
}

@property (nonatomic, retain) NSDate * selectDate;
@property(nonatomic, assign) id <MyDatePickerDelegate> delegate;

@end
