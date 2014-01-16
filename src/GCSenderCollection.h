//
//  SenderCollection.h
//  SenderCollection
//
//  Created by Eloi Guzmán on 09/05/13.
//  Copyright (c) 2013 Eloi Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum GCSenderCollectionOptions
{
    GCSenderCollectionOptionsDefault = 0x00,
    GCSenderCollectionOptionsWeakReferences = 0x01,
    GCSenderCollectionOptionsThreadSafe = 0x02,
    GCSenderCollectionOptionsMediumCapacity = 0x04,
    GCSenderCollectionOptionsHugeCapacity = 0x08
}GCSenderCollectionOptions;

@interface GCSenderCollection : NSObject
{
    NSMapTable * _senderCollection;
    NSRecursiveLock * _lock;
}

-(id)initWithOptions:(GCSenderCollectionOptions)options;
-(id)initWithWeakReferences;
-(void)addSender:(NSObject*)sender forKeyObject:(NSObject*)keyObject;
-(void)setSender:(NSObject*)sender forKeyObject:(NSObject*)keyObject;
-(id)getSenderForKeyObject:(NSObject*)keyObject deleteEntry:(BOOL)deleteEntry;
-(id)getSenderForKeyObject:(NSObject*)keyObject;
-(NSArray *)allSenders;
-(NSArray *)allKeyObjects;
-(NSEnumerator*)keysEnumerator;
-(NSEnumerator*)sendersEnumerator;
-(NSUInteger)count;
-(void)deleteAllSenders;
-(NSDictionary*)dictionary;

@end
