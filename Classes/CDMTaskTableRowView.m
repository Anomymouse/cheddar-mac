//
//  CDMTaskTableRowView.m
//  Cheddar for Mac
//
//  Created by Sam Soffes on 8/3/12.
//  Copyright (c) 2012 Nothing Magical. All rights reserved.
//

#import "CDMTaskTableRowView.h"

@interface CDMTaskTableRowView ()
@property (nonatomic, strong) NSColorList *colorList;
@end

@implementation CDMTaskTableRowView {
    NSTrackingArea *_trackingArea;
}

@synthesize colorList = _colorList;

- (id)initWithFrame:(NSRect)frameRect {
	if ((self = [super initWithFrame:frameRect])) {
		self.colorList = [[NSColorList alloc] initWithName:NSStringFromClass([self class])];
		
		NSColorSpace *sRGB = [NSColorSpace sRGBColorSpace];
		
		CGFloat components[] = { 240 / 255.0, 240 / 255.0, 240 / 255.0, 1.0 };
		[self.colorList setColor:[NSColor colorWithColorSpace:sRGB components:components count:4] forKey:@"border"];
	}
	return self;
}


- (void)drawBackgroundInRect:(NSRect)dirtyRect {
	CGRect rect = self.bounds;
	
	[[NSColor whiteColor] setFill];
	[NSBezierPath fillRect:rect];
	
	CGRect separatorRect = rect;
	separatorRect.origin.y = separatorRect.size.height - 1.0f;
	separatorRect.size.height = 1.0f;
	
	[[self.colorList colorWithKey:@"border"] set];
	[NSBezierPath fillRect:separatorRect];
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    if (_trackingArea) { [self removeTrackingArea:_trackingArea]; }
	NSTrackingAreaOptions options = (NSTrackingMouseEnteredAndExited | NSTrackingActiveInKeyWindow);
	_trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:options owner:self userInfo:nil];
	[self addTrackingArea:_trackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    NSView *view = [self viewAtColumn:0];
    [view mouseEntered:theEvent];
}

- (void)mouseExited:(NSEvent *)theEvent {
    NSView *view = [self viewAtColumn:0];
    [view mouseExited:theEvent];
}
@end
