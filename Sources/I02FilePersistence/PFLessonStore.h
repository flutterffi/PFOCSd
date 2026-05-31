#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFLessonStore : NSObject
- (NSArray<NSDictionary<NSString *, id> *> *)defaultLessons;
- (nullable NSString *)saveLessons:(NSArray<NSDictionary<NSString *, id> *> *)lessons
                             error:(NSError **)error;
- (nullable NSArray<NSDictionary<NSString *, id> *> *)loadLessonsFromPath:(NSString *)path
                                                                     error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
