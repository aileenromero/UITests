#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MaterialAvailability.h"
#import "MDCAvailability.h"
#import "MaterialTypography.h"
#import "MDCFontScaler.h"
#import "MDCFontTextStyle.h"
#import "MDCTypography.h"
#import "UIFont+MaterialScalable.h"
#import "UIFont+MaterialSimpleEquality.h"
#import "UIFont+MaterialTypography.h"
#import "UIFontDescriptor+MaterialTypography.h"
#import "MaterialApplication.h"
#import "UIApplication+MDCAppExtensions.h"
#import "MaterialColor.h"
#import "UIColor+MaterialBlending.h"
#import "UIColor+MaterialDynamic.h"
#import "MaterialMath.h"
#import "MDCMath.h"
#import "MaterialColorScheme.h"
#import "MDCLegacyColorScheme.h"
#import "MDCLegacyTonalColorScheme.h"
#import "MDCLegacyTonalPalette.h"
#import "MDCSemanticColorScheme.h"
#import "MaterialTypographyScheme.h"
#import "MDCLegacyFontScheme.h"
#import "MDCTypographyScheme.h"
#import "MaterialTypographyScheme+BasicFontScheme.h"
#import "MDCBasicFontScheme.h"
#import "MaterialTypographyScheme+Scheming.h"
#import "MDCTypographyScheming.h"

FOUNDATION_EXPORT double MaterialComponentsVersionNumber;
FOUNDATION_EXPORT const unsigned char MaterialComponentsVersionString[];

