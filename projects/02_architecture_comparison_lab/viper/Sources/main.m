#import <Foundation/Foundation.h>
#import "PFVIPERStudyPlannerInteractor.h"
#import "PFVIPERStudyPlannerPresenter.h"
#import "PFVIPERStudyPlannerRouter.h"
#import "PFVIPERStudyPlannerView.h"

int main(void) {
    @autoreleasepool {
        PFVIPERConsoleView *view = [[PFVIPERConsoleView alloc] init];
        PFVIPERStudyPlannerInteractor *interactor =
            [[PFVIPERStudyPlannerInteractor alloc] initWithStore:[[PFVIPERStudyTaskStore alloc] init]];
        PFVIPERStudyPlannerRouter *router = [[PFVIPERStudyPlannerRouter alloc] init];
        PFVIPERStudyPlannerPresenter *presenter =
            [[PFVIPERStudyPlannerPresenter alloc] initWithView:view
                                                    interactor:interactor
                                                        router:router];

        [presenter bootstrap];
        [presenter addTaskWithTitle:@"Compare VIPER with MVP"
                              notes:@"notice where routing and persistence messages live"
                               tags:@[@"architecture", @"comparison"]
                   estimatedMinutes:40];
        [presenter markTaskDoneAtIndex:0];
        [presenter showTasksFilteredByTag:@"architecture"];
        [presenter saveAndReload];
        [presenter showTasksFilteredByTag:nil];

        // Practice idea: extract line formatting into a dedicated presenter view model builder.
    }
    return 0;
}
