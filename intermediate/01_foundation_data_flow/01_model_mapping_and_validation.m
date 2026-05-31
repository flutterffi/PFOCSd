#import <Foundation/Foundation.h>

@interface PFExercise : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger estimatedMinutes;
@property (nonatomic, copy) NSString *level;
+ (nullable instancetype)exerciseFromDictionary:(NSDictionary<NSString *, id> *)dictionary
                                          error:(NSError **)error;
@end

@implementation PFExercise

+ (nullable instancetype)exerciseFromDictionary:(NSDictionary<NSString *, id> *)dictionary
                                          error:(NSError **)error {
    NSString *title = dictionary[@"title"];
    NSNumber *minutes = dictionary[@"estimatedMinutes"];
    NSString *level = dictionary[@"level"];

    if (title.length == 0 || minutes.integerValue <= 0 || level.length == 0) {
        if (error != nil) {
            *error = [NSError errorWithDomain:@"com.pfocsd.mapping"
                                         code:2001
                                     userInfo:@{NSLocalizedDescriptionKey: @"payload is missing required fields"}];
        }
        return nil;
    }

    PFExercise *exercise = [[PFExercise alloc] init];
    exercise.title = title;
    exercise.estimatedMinutes = minutes.integerValue;
    exercise.level = level;
    return exercise;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDictionary<NSString *, id> *payload = @{
            @"title": @"KVC model mapping",
            @"estimatedMinutes": @25,
            @"level": @"intermediate"
        };

        NSError *error = nil;
        PFExercise *exercise = [PFExercise exerciseFromDictionary:payload error:&error];
        NSLog(@"exercise -> %@ | %ld | %@", exercise.title, (long)exercise.estimatedMinutes, exercise.level);
        NSLog(@"error -> %@", error);
    }
    return 0;
}
