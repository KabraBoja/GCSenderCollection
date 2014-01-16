//
//  SenderCollection.m
//  SenderCollection
//
//  Created by Eloi Guzmán on 09/05/13.
//  Copyright (c) 2013 Eloi Guzmán. All rights reserved.
//

#import "GCSenderCollection.h"

@implementation GCSenderCollection

-(id)initWithOptions:(GCSenderCollectionOptions)options
{
    self = [super init];
    if (self) {
        _lock = nil;
        _senderCollection = nil;
        
        //Deal with options
        NSPointerFunctionsOptions memoryOption = NSMapTableStrongMemory;
        if (options & GCSenderCollectionOptionsWeakReferences) {
            memoryOption = NSMapTableWeakMemory;
        }
        
        if (options & GCSenderCollectionOptionsThreadSafe) {
            _lock = [[NSRecursiveLock alloc]init];
        }

        NSUInteger capacity = 32;
        if (options & GCSenderCollectionOptionsMediumCapacity) {
            capacity = 256;
        }
        
        if (options & GCSenderCollectionOptionsHugeCapacity) {
            capacity = 1024;
        }
        
        _senderCollection = [[NSMapTable alloc]initWithKeyOptions:NSMapTableStrongMemory | NSMapTableCopyIn valueOptions:memoryOption capacity:capacity];
    }
    return self;
}

- (id)init
{
    self = [self initWithOptions:GCSenderCollectionOptionsDefault];
    if (self) {
        
    }
    return self;
}

- (id)initWithWeakReferences
{
    self = [self initWithOptions:GCSenderCollectionOptionsWeakReferences];
    if (self) {
        
    }
    return self;
}

-(void)addSender:(NSObject*)sender forKeyObject:(NSObject*)keyObject
{
    NSString * key = (NSString*)keyObject;
    if (![keyObject isKindOfClass:NSString.class]) {
        key = [NSString stringWithFormat:@"%d",[keyObject hash]];
    }
    [_lock lock];
    [_senderCollection setObject:sender forKey:key];
    [_lock unlock];
}

-(void)setSender:(NSObject*)sender forKeyObject:(NSObject*)keyObject
{
    [_lock lock];
    [self addSender:sender forKeyObject:keyObject];
    [_lock unlock];
}

-(id)getSenderForKeyObject:(NSObject*)keyObject
{
    return [self getSenderForKeyObject:keyObject deleteEntry:NO];
}

-(NSObject*)getSenderForKeyObject:(NSObject*)keyObject deleteEntry:(BOOL)deleteEntry
{
    NSString * key = (NSString*)keyObject;
    if (![keyObject isKindOfClass:NSString.class]) {
        key = [NSString stringWithFormat:@"%d",[keyObject hash]];
    }
    
    [_lock lock];
    NSObject * senderObject = [_senderCollection objectForKey:key];
    if (deleteEntry && senderObject) {
        [_senderCollection removeObjectForKey:key];
    }
    [_lock unlock];
    
    return senderObject;
}

-(NSArray *)allKeyObjects
{
    [_lock lock];
    NSArray * res = self.keysEnumerator.allObjects;
    [_lock unlock];
    return res;
}

-(NSArray *)allSenders
{
    [_lock lock];
    NSArray * res = self.sendersEnumerator.allObjects;
    [_lock unlock];
    return res;
}

-(NSEnumerator *)keysEnumerator
{
    [_lock lock];
    NSEnumerator * e = _senderCollection.keyEnumerator;
    [_lock unlock];
    return e;
}

-(NSEnumerator *)sendersEnumerator
{
    [_lock lock];
    NSEnumerator * e = _senderCollection.objectEnumerator;
    [_lock unlock];
    return e;

}

-(NSUInteger)count
{
    [_lock lock];
    NSUInteger count = _senderCollection.count;
    [_lock unlock];
    return count;

}

-(NSDictionary*)dictionary
{
    [_lock lock];
    NSDictionary * r = [_senderCollection dictionaryRepresentation];
    [_lock unlock];
    return r;
}

-(void)deleteAllSenders
{
    [_lock lock];
    [_senderCollection removeAllObjects];
    [_lock unlock];
}

-(void)dealloc
{
    [_senderCollection removeAllObjects];
    _senderCollection = nil;
}

-(NSString *)description
{
    return [_senderCollection description];
}



@end
