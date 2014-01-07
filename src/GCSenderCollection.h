//
//  SenderCollection.h
//  SenderCollection
//
//  Created by Eloi Guzmán on 09/05/13.
//  Copyright (c) 2013 Eloi Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCSenderCollection : NSObject
{
    NSMapTable * _senderCollection;
}

-(id)initWithWeakReferences;
-(void)addSender:(NSObject*)sender forKeyObject:(NSObject*)keyObject;
-(NSObject*)getSenderWithKeyObject:(NSObject*)keyObject deleteEntry:(BOOL)deleteEntry;
-(NSArray *)allSenders;
-(NSArray *)allKeyObjects;
-(NSEnumerator*)keysEnumerator;
-(NSEnumerator*)sendersEnumerator;
-(NSUInteger)count;
-(void)deleteAllSenders;

@end
