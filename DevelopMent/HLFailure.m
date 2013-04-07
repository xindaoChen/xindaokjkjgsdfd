//
//  HLFailure.m
//  HLDeferred
//
//  Copyright 2011 HeavyLifters Network Ltd.. All rights reserved.
//  See included LICENSE file (MIT) for licensing information.
//

#import "HLFailure.h"

@implementation HLFailure

- (id) initWithValue: (id)v
{
	self = [super init];
	if (self) {
		value_ = v;
	}
	return self;
}

- (id) init
{
	self = [self initWithValue: nil];
	return self;
}

- (void) dealloc
{
    value_ = nil;
}

+ (HLFailure *) wrap: (id)v
{
	return [[[self class] alloc] initWithValue:v];
}

- (id) value { return value_; }

@end
