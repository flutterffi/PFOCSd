#import "PFExercise.h"

@implementation PFExercise

+ (nullable instancetype)exerciseFromDictionary:(NSDictionary<NSString *, id> *)dictionary
                                          error:(NSError **)error {
    NSString *title = dictionary[@"title"];
    NSNumber *minutes = dictionary[@"estimatedMinutes"];
    NSString *level = dictionary[@"level"];
    NSString *notes = dictionary[@"notes"];

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
    if ([notes isKindOfClass:[NSString class]]) {
        exercise.notes = notes;
    }
    return exercise;
}

- (NSString *)summary {
    NSString *notesSummary = self.notes.length > 0 ? self.notes : @"no notes yet";
    return [NSString stringWithFormat:@"%@ | %ld min | %@ | %@",
            self.title,
            (long)self.estimatedMinutes,
            self.level,
            notesSummary];
}

@end
