
#import "Product.h"

@implementation Product

- (instancetype) instance:(NSString*)image title:(NSString*)title productDescription:(NSString*)productDesciption price:(float)price
{
    Product* product = [Product alloc];
    product.previewImage = image;
    product.title = title;
    product.productDescription = productDesciption;
    product.price = price;
    
    return product;
}

@end
