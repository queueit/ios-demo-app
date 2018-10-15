#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, strong) NSString* previewImage;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* productDescription;
@property (assign) float price;


- (instancetype) instance:(NSString*)image title:(NSString*)title productDescription:(NSString*)itemDesciption price:(float)price;

@end
