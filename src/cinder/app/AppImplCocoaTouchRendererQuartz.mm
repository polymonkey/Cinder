/*
 Copyright (c) 2010, The Barbarian Group
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that
 the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and
	the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and
	the following disclaimer in the documentation and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
 WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
*/

#import "cinder/app/AppImplCocoaTouchRendererQuartz.h"
#import <QuartzCore/QuartzCore.h>
#include "cinder/cocoa/CinderCocoa.h"

@implementation AppImplCocoaTouchRendererQuartz

- (id)initWithFrame:(CGRect)frame cinderView:(UIView*)aCinderView app:(cinder::app::App*)aApp
{
	self = [super init];
	app = aApp;
	
	view = aCinderView;
	currentRef = nil;
	
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (UIView*)view
{
	return view;
}

- (UIImage*)getContents:(cinder::Area)area
{
	::UIGraphicsBeginImageContext( cinder::cocoa::createCgSize( area.getSize() ) );
	CALayer *layer = view.layer;
	[layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = ::UIGraphicsGetImageFromCurrentImageContext();
	::UIGraphicsEndImageContext();
	return viewImage;
}

- (void)makeCurrentContext
{
	currentRef = UIGraphicsGetCurrentContext();
	CGContextRetain( currentRef );
}

- (void)flushBuffer
{
	CGContextRelease( currentRef );
}

- (void)defaultResize
{
}

- (CGContextRef)getCGContextRef
{
	return currentRef;
}

- (BOOL)isFlipped
{
	return YES;
}

@end
