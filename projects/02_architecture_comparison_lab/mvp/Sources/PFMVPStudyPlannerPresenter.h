#import <Foundation/Foundation.h>
#import "PFMVPStudyPlannerView.h"
#import "PFMVPStudyTaskStore.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFMVPStudyPlannerPresenter : NSObject
@property (nonatomic, weak) id<PFMVPStudyPlannerView> view;
@property (nonatomic, strong) PFMVPStudyTaskStore *store;
@property (nonatomic, copy) NSArray<PFMVPStudyTask *> *tasks;

- (instancetype)initWithView:(id<PFMVPStudyPlannerView>)view
                       store:(PFMVPStudyTaskStore *)store;
- (void)bootstrap;
- (void)addTaskWithTitle:(NSString *)title
                   notes:(NSString *)notes
                    tags:(NSArray<NSString *> *)tags
                priority:(NSInteger)priority
        estimatedMinutes:(NSInteger)estimatedMinutes;
- (void)markTaskBlockedAtIndex:(NSUInteger)index;
- (void)markTaskDoneAtIndex:(NSUInteger)index;
- (void)showTasksFilteredByTag:(nullable NSString *)tag title:(NSString *)title;
- (void)showPrioritySortedTasksWithTitle:(NSString *)title;
- (void)saveAndReload;
@end

NS_ASSUME_NONNULL_END
