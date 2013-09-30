//
//  SCMonthGridView.m
//  SimpleCal
//
//  Created by Palani raja on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SCMonthGridView.h"


@interface SCMonthGridView (PrivateMethods)
- (void)setupCustomInitialisation;
@end


@implementation SCMonthGridView

@synthesize horizontalLines=_horizontalLines;
@synthesize verticalLines=_verticalLines;
@synthesize lineWidth=_lineWidth;
@synthesize lineColor=_lineColor;
@synthesize outerBorder=_outerBorder;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCustomInitialisation];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super initWithCoder:decoder]) {
		[self setupCustomInitialisation];
	}
	return self;
}

#pragma mark - 
- (void)setupCustomInitialisation {
	self.rows             = 8;
	self.columns          = 8;
	self.lineWidth        = 1;
	self.horizontalLines  = YES;
	self.verticalLines    = YES;
	self.outerBorder      = YES;
	self.lineColor        = [UIColor lightGrayColor]; // retain
}

- (void)setRows:(unsigned int)rows {
	_rows = rows;
	if (_rows > 0) {
		_cellHeight = self.bounds.size.height / _rows;
	} else {
		_cellHeight = 0;
	}
}

- (void)setColumns:(unsigned int)columns {
	_columns = columns;
	if (_columns > 0) {
		_cellWidth = self.bounds.size.width  / _columns;
	} else {
		_cellWidth = 0;
	}
}

- (unsigned int)rows {
	return _rows;
}

- (unsigned int)columns {
	return _columns;
}

- (CGFloat)cellWidth {
	return _cellWidth;
}

- (CGFloat)cellHeight {
	return _cellHeight;
}

#pragma mark -

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (!(_columns > 0 && _rows > 0)) {
		// Nothing to draw
		return;
	}
	
	register unsigned int i;
	CGFloat x, y;
	
	const CGContextRef c          = UIGraphicsGetCurrentContext();
	const CGFloat      lineMiddle = _lineWidth / 2.f;
	
	CGContextSetStrokeColorWithColor(c, [_lineColor CGColor]);
	CGContextSetLineWidth(c, _lineWidth);
	
	CGContextBeginPath(c); {
		x = CGRectGetMinX(rect);
		y = CGRectGetMinY(rect);
		
		for (i=0; i <= _rows && _horizontalLines; i++) {
			if (i == 0) {
				y += lineMiddle;
				if (!_outerBorder) goto NEXT_ROW;
			} else if (i == _rows) {
				y = CGRectGetMaxY(rect) - lineMiddle;
				if (!_outerBorder) goto NEXT_ROW;
			}
			
			CGContextMoveToPoint(c, x, y);
			CGContextAddLineToPoint(c, self.bounds.size.width, y);
			/*
             //def: none ; 30 min line
             
             CGContextSetStrokeColorWithColor(c, [[UIColor redColor] CGColor]);
             CGContextSetLineWidth(c, 0.5);
             
             CGContextMoveToPoint(c, x, y/2);
             CGContextAddLineToPoint(c, self.bounds.size.width, y/2);
             
             CGContextClosePath(c);
             CGContextSaveGState(c);
             CGContextDrawPath(c, kCGPathFillStroke);
             
             CGContextSetStrokeColorWithColor(c, [_lineColor CGColor]);
             CGContextSetLineWidth(c, _lineWidth);
             */
			
		NEXT_ROW:
			y += _cellHeight;
		}
		
		x = CGRectGetMinX(rect);
		y = CGRectGetMinY(rect);
		
		for (i=0; i <= _columns && _verticalLines; i++) {
			if (i == 0) {
				x += lineMiddle;
				if (!_outerBorder) goto NEXT_COLUMN;
			} else if (i == _columns) {
				x = CGRectGetMaxX(rect) - lineMiddle;
				if (!_outerBorder) goto NEXT_COLUMN;
			}
            
			CGContextMoveToPoint(c, x, y);
			CGContextAddLineToPoint(c, x, self.bounds.size.height);
			
		NEXT_COLUMN:
			x += _cellWidth;
		}
	}
	
	CGContextClosePath(c);
	CGContextSaveGState(c);
	CGContextDrawPath(c, kCGPathFillStroke);
	CGContextRestoreGState(c);
	
	//draw line inbetween
}


@end
