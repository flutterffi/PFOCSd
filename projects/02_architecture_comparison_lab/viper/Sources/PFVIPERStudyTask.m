#import "PFVIPERStudyTask.h"

NSString *PFVIPERStudyTaskStateLabel(PFVIPERStudyTaskState state) {
    switch (state) {
        case PFVIPERStudyTaskStateDone:
            return @"done";
        case PFVIPERStudyTaskStateBlocked:
            return @"blocked";
        case PFVIPERStudyTaskStateTodo:
        default:
            return @"todo";
    }
}

@implementation PFVIPERStudyTask

- (instancetype)initWithTitle:(NSString *)title
                        notes:(NSString *)notes
                         tags:(NSArray<NSString *> *)tags
                     priority:(NSInteger)priority
             estimatedMinutes:(NSInteger)estimatedMinutes
                        state:(PFVIPERStudyTaskState)state {
    self = [super init];
    if (self) {
        _title = [title copy];
        _notes = [notes copy];
        _tags = [tags copy];
        _priority = priority;
        _estimatedMinutes = estimatedMinutes;
        _state = state;
    }
    return self;
}

- (NSDictionary<NSString *, id> *)dictionaryRepresentation {
    return @{
        @"title": self.title,
        @"notes": self.notes,
        @"tags": self.tags,
        @"priority": @(self.priority),
        @"estimatedMinutes": @(self.estimatedMinutes),
        @"state": PFVIPERStudyTaskStateLabel(self.state),
    };
}

@end
