//
//  DDGMacros.m
//  DDG Library
//
//  Created by Andrew Donoho on 2009/05/23.
//  Copyright 2009-2012 Donoho Design Group, L.L.C. All rights reserved.
//

/*
 
 The below license is the new BSD license with the OSI recommended 
 personalizations.
 <http://www.opensource.org/licenses/bsd-license.php>
 
 Copyright (C) 2009-2012 Donoho Design Group, LLC. All Rights Reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:
 
 * Redistributions of source code must retain the above copyright notice,
 this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of Andrew W. Donoho nor Donoho Design Group, L.L.C.
 may be used to endorse or promote products derived from this software
 without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY DONOHO DESIGN GROUP, L.L.C. "AS IS" AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

#import <Foundation/Foundation.h>

#import "DDGMacros.h"

#ifdef TESTFLIGHT
// Use the TestFlight folks' logging system.

#import "TestFlight.h"

#define NSLog  TFLog
#define NSLogv TFLogv

#endif

// Miscellaneous Constants
NSString *const kEmptyString  = @"";
NSString *const kOKButton     = @"OK";
NSString *const kNoButton     = @"No";
NSString *const kYesButton    = @"Yes";
NSString *const kCancelButton = @"Cancel";
NSString *const kTrue         = @"true";
NSString *const kFalse        = @"false";
const NSTimeInterval kDefaultDuration = 0.25;

void _DDGTrace(const char *name, int line) {
	
	NSLog(@"%s (%d)", name, line);
	
} // void _DDGTrace()


void _DDGDesc(const char *name, int line, id object) {
	
	if (object) {
		
        NSLog(@"%s (%d)\nDescription: %@", name, line, object);
	} 
	else {
		
		NSLog(@"%s (%d)", name, line);
	}
	
} // _DDGDesc()


//
// _DDGLog allows us to catch log statements and insert other useful runtime information.
// Use the DDGLog() macro instead of this function. It allows per line and function logging.
//
void _DDGLog(const char *name, int line, NSString *format, ...) {
	
	if (format) {
		
		NSMutableString *logString = [NSMutableString stringWithFormat: @"%s (%d) \n\t", name, line];
		
		// Make a new format string.
		[logString appendString: format];
		format = logString;
		
		va_list argp;
		va_start(argp, format);
        
		NSLogv(format, argp);
		
		va_end(argp);
	} 
	else {
		
		NSLog(@"%s (%d)", name, line);
	}
	
} // _DDGLog()


void _logViews(UIView *parent);
void _logViews(UIView *parent) {
	
	NSLog(@"\n\tParent Class: %@; Subviews: %d\n---------", 
          NSStringFromClass(parent.class), parent.subviews.count);
	
	for (UIView *v in parent.subviews) {
		
        NSLog(@"\n\tClass:  %@\n\tFrame:  %@\n\tBounds: %@", 
              NSStringFromClass( v.class), 
              NSStringFromCGRect(v.frame), 
              NSStringFromCGRect(v.bounds));
		
		_logViews(v); // Print the subviews.
	}
	
} // _logViews()


void _logSubviews(const char *name, int line, UIView *parent) {
	
	NSLog(@"%s (%d)\n", name, line);
	if (parent) {
		
		_logViews(parent);
	}
	
} // _logSubviews()


NSUInteger _countViews(UIView *parent);
NSUInteger _countViews(UIView *parent) {
	
	if (parent.subviews.count) {
		
		NSUInteger count = 0;

		for (UIView *v in parent.subviews) {
			
			count += _countViews(v);
		}
		return count;
	}
	else {
		
		return 1;
	}
	
} // countViews_()


NSUInteger _countSubviews(const char *name, int line, UIView *parent) {
	
	if (parent) {
		
		return _countViews(parent);
	}
	return 0;
	
} // _countSubviews()


void _DDGDebugger(const char *name, int line) {
	
	NSLog(@"%s (%d)", name, line);
	
} // _DDGDebugger()


uint8_t htoc(char h) {
	
	switch (h) {
			
		case '0': return 0x0; break;
		case '1': return 0x1; break;
		case '2': return 0x2; break;
		case '3': return 0x3; break;
		case '4': return 0x4; break;
		case '5': return 0x5; break;
		case '6': return 0x6; break;
		case '7': return 0x7; break;
		case '8': return 0x8; break;
		case '9': return 0x9; break;
		case 'a': return 0xa; break;
		case 'b': return 0xb; break;
		case 'c': return 0xc; break;
		case 'd': return 0xd; break;
		case 'e': return 0xe; break;
		case 'f': return 0xf; break;
		case 'A': return 0xa; break;
		case 'B': return 0xb; break;
		case 'C': return 0xc; break;
		case 'D': return 0xd; break;
		case 'E': return 0xe; break;
		case 'F': return 0xf; break;
		default:  return 0xff;
	}
	
} // htoc


char ctoh(uint8_t c) {
	
	switch (c) {
			
		case 0x0: return '0'; break;
		case 0x1: return '1'; break;
		case 0x2: return '2'; break;
		case 0x3: return '3'; break;
		case 0x4: return '4'; break;
		case 0x5: return '5'; break;
		case 0x6: return '6'; break;
		case 0x7: return '7'; break;
		case 0x8: return '8'; break;
		case 0x9: return '9'; break;
		case 0xa: return 'a'; break;
		case 0xb: return 'b'; break;
		case 0xc: return 'c'; break;
		case 0xd: return 'd'; break;
		case 0xe: return 'e'; break;
		case 0xf: return 'f'; break;
		default:  return 0xff;
	}
	
} // ctoh


//@implementation Macros
//
//@end
