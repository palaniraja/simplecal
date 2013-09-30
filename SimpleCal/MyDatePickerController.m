    //
//  MyDatePickerController.m
//  CN
//  Created by Palaniraja on 24/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyDatePickerController.h"


@implementation MyDatePickerController

@synthesize selectDate, delegate;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
	    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(close)];
    cancelButton.tag = 13;
    self.navigationItem.leftBarButtonItem = cancelButton;
//    [cancelButton release];
    
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"Ok" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed)];
    okButton.tag = 12;
    self.navigationItem.rightBarButtonItem = okButton;
//    [okButton release];

    
	//datePicker.
	if (selectDate) {
        datePicker.date = selectDate;
    }else{
        datePicker.date = [NSDate date];
    }
	
}

- (IBAction)doneButtonPressed
{
	
	NSDate  *date = datePicker.date;
//	
//	[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
//	
//    NSString *selectedDate = [[NSString alloc] init];
//    selectedDate = [dateFormatter stringFromDate:date];
    [delegate selectedDate:date];
    
}


- (IBAction)close{
    [delegate cancelDateSelection];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
