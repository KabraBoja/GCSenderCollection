//
//  SenderCollection.m
//  SenderCollection
//
//  Created by Eloi Guzmán on 09/05/13.
//  Copyright (c) 2013 Eloi Guzmán. All rights reserved.
//

#import "GCSenderCollection.h"

@implementation GCSenderCollection

- (id)init
{
    self = [super init];
    if (self) {
        _senderCollection = [[NSMapTable alloc]initWithKeyOptions:NSMapTableStrongMemory | NSMapTableCopyIn valueOptions:NSMapTableStrongMemory capacity:100];
    }
    return self;
}

- (id)initWithWeakReferences
{
    self = [super init];
    if (self) {
        _senderCollection = [[NSMapTable alloc]initWithKeyOptions:NSMapTableStrongMemory | NSMapTableCopyIn valueOptions:NSMapTableWeakMemory capacity:100];
    }
    return self;
}

-(void)addSender:(NSObject*)sender forKeyObject:(NSObject*)keyObject
{
    NSString * key = (NSString*)keyObject;
    if (![keyObject isKindOfClass:NSString.class]) {
        key = [NSString stringWithFormat:@"%d",[keyObject hash]];
    }
    [_senderCollection setObject:sender forKey:key];
}


-(NSObject*)getSenderWithKeyObject:(NSObject*)keyObject deleteEntry:(BOOL)deleteEntry
{
    NSString * key = (NSString*)keyObject;
    if (![keyObject isKindOfClass:NSString.class]) {
        key = [NSString stringWithFormat:@"%d",[keyObject hash]];
    }
    
    NSObject * senderObject = [_senderCollection objectForKey:key];
    if (deleteEntry && senderObject) {
        [_senderCollection removeObjectForKey:key];
    }
    return senderObject;
}

-(NSArray *)allKeyObjects
{
    return self.keysEnumerator.allObjects;
}

-(NSArray *)allSenders
{
    return self.sendersEnumerator.allObjects;
}

-(NSEnumerator *)keysEnumerator
{
    return _senderCollection.keyEnumerator;
}

-(NSEnumerator *)sendersEnumerator
{
    return _senderCollection.objectEnumerator;
}

-(NSUInteger)count
{
    return _senderCollection.count;
}

-(void)deleteAllSenders
{
    [_senderCollection removeAllObjects];
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
