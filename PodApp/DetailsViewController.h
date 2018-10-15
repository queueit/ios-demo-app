#import "QueueITEngine.h"
#import <UIKit/UIKit.h>
#import "Product.h"

@interface DetailsViewController : UIViewController<QueuePassedDelegate, QueueViewWillOpenDelegate, QueueDisabledDelegate, QueueITUnavailableDelegate, QueueUserExitedDelegate>

@property (nonatomic, strong) Product* product;

@end
