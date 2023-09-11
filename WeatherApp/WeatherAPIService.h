//
//  WeatherAPIService.h
//  WeatherApp
//
//  Created by soujanya Balusu on 11/09/23.
//

#ifndef WeatherAPIService_h
#define WeatherAPIService_h


#endif /* WeatherAPIService_h */

#import <Foundation/Foundation.h>

@interface WeatherAPIService : NSObject

- (void)fetchWeatherDataForUrl:(NSString *)forUrl completion:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))completion;

@end
