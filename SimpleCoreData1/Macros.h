//
//  Macros.h
//  SimpleCoreData1
//
//  Created by mtaniuchi on 12/12/25.
//  Copyright (c) 2012年 Tiesfeed Software JP. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//#undef DEBUG

// ここから下は編集しないでください
#pragma mark -
#pragma mark NSNumber
#define NUMBER_WITH_INT(n) [NSNumber numberWithInt:n]
#define NUMBER_WITH_DBL(n) [NSNumber numberWithDouble:n]
#define NUMBER_WITH_BOOL(n) [NSNumber numberWithBool:n]

#pragma mark -
#pragma mark for debug
#ifdef DEBUG 
#define LOG(...)    NSLog(__VA_ARGS__);
#define START(name) LOG(@"=== %s start ===", #name); CFAbsoluteTime name##_startTime = CFAbsoluteTimeGetCurrent();
#define END(name)   LOG(@"=== %s: %f sec ===",#name, CFAbsoluteTimeGetCurrent() - name##_startTime);
#define FUNC()  LOG(@"%i:%s", __LINE__, __func__);
#define FUNCS(str)  LOG(@"%i:%s %s", __LINE__, __func__, #str);
#else
#define LOG(...)		;
#define START(name)		;
#define END(name)		;
#define FUNC()      ;
#define FUNCS(str)      ;
#endif

#endif