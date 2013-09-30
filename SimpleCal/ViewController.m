//
//  ViewController.m
//  SimpleCal
//
//  Created by Palani raja on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize monthView;
@synthesize monthLabel;
@synthesize mondayLabel;
@synthesize tuesdayLabel;
@synthesize wednesdayLabel;
@synthesize thursdayLabel;
@synthesize fridayLabel;
@synthesize saturdayLabel;
@synthesize sundayLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark -

- (void)viewDidUnload
{
    [self setMonthView:nil];
    [self setMonthLabel:nil];
    [self setMondayLabel:nil];
    [self setTuesdayLabel:nil];
    [self setWednesdayLabel:nil];
    [self setThursdayLabel:nil];
    [self setFridayLabel:nil];
    [self setSaturdayLabel:nil];
    [self setSundayLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    noOfWeeks = 6;  //defaulting it to max
    daysPerWeek = 7;    //let it be
    
    theDate = [[NSDate alloc] init];
    
//    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
//    [df1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    theDate = [df1 dateFromString:@"1985-11-01 00:00:00"];
//
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
//    [df setDateFormat:@"MMMM yyyy"];
//    monthLabel.text = [[df stringFromDate:theDate] uppercaseString];
    monthLabel.textColor = [UIColor colorWithRed:0.257 green:0.246 blue:0.219 alpha:1.000];

    monthLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *dbltapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetToCurrentDate:)];
    dbltapRecognizer.numberOfTapsRequired = 2;
	[monthLabel setUserInteractionEnabled:YES];
	[monthLabel addGestureRecognizer:dbltapRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentDatePicker:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [tapRecognizer requireGestureRecognizerToFail:dbltapRecognizer];
	[monthLabel setUserInteractionEnabled:YES];
	[monthLabel addGestureRecognizer:tapRecognizer];


    [self updateCalendar];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   
    
}

-(void)setupGrid{
    

//    theDate = [NSDate date];
    monthView.rows = noOfWeeks;
    monthView.columns = daysPerWeek;
//    monthView.lineColor = [UIColor whiteColor];
    monthView.lineColor = [UIColor colorWithRed:0.816 green:0.823 blue:0.823 alpha:1.000];
    
//    [UIColor colorWithRed:0.816 green:0.823 blue:0.823 alpha:1.000];
//    [UIColor colorWithRed:0.816 green:0.823 blue:0.823 alpha:1.000];
//    [UIColor colorWithRed:0.859 green:0.859 blue:0.859 alpha:1.000];
//    [UIColor lightGrayColor];
    
//    dark coffee color - [UIColor colorWithRed:0.257 green:0.246 blue:0.219 alpha:1.000];
//    bright color - [UIColor colorWithRed:0.995 green:0.300 blue:0.245 alpha:1.000]

    [monthView setNeedsDisplayInRect:monthView.bounds];
}

-(void)fillDaysinGrid{
    /*
     get current date
     get first of this month
     get weekday
     offset first row column
     if col is sunday paint red else coffee-brown
     if today fill bg / change label color
     
     remove all previous labels
     redraw new labels
     */
//    theDate = [NSDate date];
    
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.4f];
    [[monthView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [UIView commitAnimations];
    
    
    
    
    int r = 0, c = 0, n = 0;
    NSDate *firstofmonth, *firstofnextmonth;
    firstofmonth = [theDate firstOfMonth];
    firstofnextmonth = [[theDate nextMonth] firstOfMonth];
    
    n = [firstofmonth daysBetweenDate:firstofnextmonth];
//    int thisday = [theDate dateInformation].day;
    float paddingSpace = 3;
    
    DLog(@"Total no. of days: %d", n);
    DLog(@"Cellwidth:%f cellheight:%f", monthView.cellWidth, monthView.cellHeight);
    
    //offset to monday
    //1 - sunday, 
    c = [firstofmonth dateInformation].weekday;
    if (c==1) {
        c = 6;  //if sunday push it to last
    }else{
        c = c-2;    //else offset to monday
    }
    
    DLog(@"C: %d", c);
    
    for (int d=1; d<=n; d++) {
        
        UILabel *aday = [[UILabel alloc] init];
        aday.frame = CGRectMake((c*monthView.cellWidth)+paddingSpace, (r*monthView.cellHeight)+paddingSpace, monthView.cellWidth-(2*paddingSpace), monthView.cellHeight-(2*paddingSpace));
        DLog(@"Frame: %@", NSStringFromCGRect(aday.frame));
        aday.font = [UIFont boldSystemFontOfSize:88.0f];
        
        if (c == (daysPerWeek-1)) {
            //sunday
            aday.textColor = [UIColor colorWithRed:0.995 green:0.300 blue:0.245 alpha:1.000];
        }
//        else if(d == thisday){
//            //today
//            aday.textColor = [UIColor colorWithRed:0.222 green:0.517 blue:0.969 alpha:1.000];
////            aday.backgroundColor = [UIColor colorWithRed:0.980 green:0.919 blue:0.269 alpha:0.220];
//        }
        else{
            aday.textColor = [UIColor colorWithRed:0.257 green:0.246 blue:0.219 alpha:1.000];
        }
        aday.textAlignment = UITextAlignmentCenter;
//        aday.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.000 alpha:0.500];
        aday.text = [NSString stringWithFormat:@"%d", d];
        [monthView addSubview:aday];
        
        if (c == (daysPerWeek-1)) {
            c = 0;
            r++;
        }else{
            c++;
        }
        
        DLog(@"r: %d c:%d d:%d", r, c, d);
        
    }
    
       
}

#pragma mark -
-(void)presentDatePicker:(id)sender{
    hereiam
    MyDatePickerController *datepicker = [[MyDatePickerController alloc] init];
    datepicker.selectDate = theDate;
    datepicker.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:datepicker];
    
    popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    popover.popoverContentSize = CGSizeMake(320, 256);

    CGRect frame = [monthLabel frame];
    frame.size.width = 320;  //display the popover at 25% of month label
    
    [popover presentPopoverFromRect:frame
                             inView:self.view
           permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    
}



-(void)resetToCurrentDate:(id)sender{
    hereiam
    theDate = [NSDate date];   
    DLog(@"reset to date: %@", theDate);
    [self updateCalendar];
}

-(void) selectedDate:(NSDate *)date{
    hereiam
    if ([popover isPopoverVisible]) {
        [popover dismissPopoverAnimated:YES];
    }
    theDate = date;
    [self updateCalendar];
}

-(void) cancelDateSelection{
    //do nothing
    if ([popover isPopoverVisible]) {
        [popover dismissPopoverAnimated:YES];
    }
}

#pragma mark -
-(void) updateCalendar{
    hereiam
//    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
//    [df1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    theDate = [df1 dateFromString:@"1985-11-01 00:00:00"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"MMMM yyyy"];
    monthLabel.text = [[df stringFromDate:theDate] uppercaseString];
    
    NSArray *dates = [NSDate rangeOfDatesInMonthGrid:theDate startOnSunday:NO];
    int noDaysInRange = [[dates objectAtIndex:0] daysBetweenDate:[dates objectAtIndex:1]];
    //    NSLog(@"dates: %@", dates);
    
    //    NSLog(@"noDaysInRange %d", noDaysInRange);
    
    noOfWeeks = (int) ceil(noDaysInRange / 7.0);
    
    //    NSLog(@"noOfWeeks %d", noOfWeeks); 
    
    [self setupGrid];
    
     [self fillDaysinGrid];
}

- (IBAction)infoTapped:(id)sender {
}

@end
