//
//  SynthesizeSingleton.h
//
//  Created by Matt Gallagher on 20/10/08.
//

#define SYNTHESIZE_SINGLETON_FOR_CLASS(klass)\
\
static klass *shared##klass = nil;\
\
+ (klass *)shared##klass {\
\
@synchronized(self) {\
if (shared##klass == nil) {\
shared##klass = [[super allocWithZone:nil] init];\
}\
}\
\
return shared##klass;\
}\
\
+ (id)allocWithZone:(NSZone *)zone {\
\
return [[self shared##klass] retain];\
}\
\
- (id)copyWithZone:(NSZone *)zone {\
\
return self;\
}\
\
- (id)retain {\
\
return self;\
}\
\
- (NSUInteger)retainCount {\
\
return NSUIntegerMax;\
}\
\
- (void)release {\
\
}\
\
- (id)autorelease {\
\
return self;\
}
