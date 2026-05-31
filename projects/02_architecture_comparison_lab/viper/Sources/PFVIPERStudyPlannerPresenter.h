#import <Foundation/Foundation.h>
#import "PFVIPERStudyPlannerInteractor.h"
#import "PFVIPERStudyPlannerRouter.h"
#import "PFVIPERStudyPlannerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFVIPERStudyPlannerPresenter : NSObject
@property (nonatomic, weak) id<PFVIPERStudyPlannerView> view;
@property (nonatomic, strong) PFVIPERStudyPlannerInteractor *interactor;
@property (nonatomic, strong) PFVIPERStudyPlannerRouter *router;

- (instancetype)initWithView:(id<PFVIPERStudyPlannerView>)view
                  interactor:(PFVIPERStudyPlannerInteractor *)interactor
                      router:(PFVIPERStudyPlannerRouter *)router;
- (void)bootstrap;
- (void)addTaskWithTitle:(NSString *)title
                   notes:(NSString *)notes
                    tags:(NSArray<NSString *> *)tags
                priority:(NSInteger)priority
        estimatedMinutes:(NSInteger)estimatedMinutes;
- (void)markTaskBlockedAtIndex:(NSUInteger)index;
- (void)markTaskDoneAtIndex:(NSUInteger)index;
- (void)showTasksFilteredByTag:(nullable NSString *)tag;
- (void)showPrioritySortedTasks;
- (void)saveAndReload;
@end

NS_ASSUME_NONNULL_END
