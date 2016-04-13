// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.1 clang-703.0.29)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIButton;
@class UITextField;
@class UITextView;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC4Echo22AddQuoteViewController")
@interface AddQuoteViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextView * _Null_unspecified quoteTextView;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified authorTextLabel;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)viewQuoteButtonTapped:(UIButton * _Nonnull)sender;
- (BOOL)textFieldShouldReturn:(UITextField * _Nonnull)textField;
- (void)setupView;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIWindow;
@class UIApplication;
@class NSObject;

SWIFT_CLASS("_TtC4Echo11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary * _Nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UISwipeGestureRecognizer;
@class UISlider;
@class UITapGestureRecognizer;
@class UIView;
@class UITouch;
@class UIEvent;
@class UIPickerView;
@class UIImageView;
@class UILabel;
@class NSLayoutConstraint;

SWIFT_CLASS("_TtC4Echo18EchoViewController")
@interface EchoViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified bottomBoxSquareButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified bottomTextEditBoxButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified bottomTextEditButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified bottomShareButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified topBoxSquareButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified topTextEditBoxButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified topTextEditButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified topShareButton;
@property (nonatomic, weak) IBOutlet UIPickerView * _Null_unspecified topPickerView;
@property (nonatomic, weak) IBOutlet UIPickerView * _Null_unspecified bottomPickerView;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified topJunkBarView;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified junkBarView;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified backgroundImage;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified quoteLabel;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified quoteView;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified drawerView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified drawerYConstraint;
@property (nonatomic, weak) IBOutlet UIView * _Null_unspecified topDrawerView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified topDrawerYConstraint;
@property (nonatomic, weak) IBOutlet UISlider * _Null_unspecified widthSlider;
@property (nonatomic, weak) IBOutlet UISlider * _Null_unspecified heightSlider;
@property (nonatomic, weak) IBOutlet UISlider * _Null_unspecified junkSlider;
@property (nonatomic, weak) IBOutlet UISlider * _Null_unspecified topWidthSlider;
@property (nonatomic, weak) IBOutlet UISlider * _Null_unspecified topHeightSlider;
@property (nonatomic, weak) IBOutlet UISlider * _Null_unspecified topJunkSlider;
@property (nonatomic, weak) IBOutlet UISlider * _Null_unspecified topFontSizeSlider;
@property (nonatomic, weak) IBOutlet UISlider * _Null_unspecified bottomFontSizeSlider;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified topJunkbarYConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified junkbarYConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified bottomPickerViewYConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified topPickerViewYConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified quoteLabelHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified quoteLabelWidth;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified quoteViewHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified quoteViewWidth;
@property (nonatomic) double currentFontSize;
@property (nonatomic, readonly) CGFloat quoteViewLocation;
@property (nonatomic) BOOL isInButton;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull fontNames;
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (void)setUpView;
- (void)firstLoad;
- (IBAction)viewScaleButtonTapped:(UIButton * _Nonnull)sender;
- (IBAction)textScaleButtonTapped:(UIButton * _Nonnull)sender;
- (IBAction)textFontButtonTapped:(UIButton * _Nonnull)sender;
- (IBAction)shareJunkButtonTapped:(UIButton * _Nonnull)sender;
- (void)moveDrawersBasedOnView;
- (void)toggleDrawer;
- (void)togglePickerView;
- (void)toggleJunkView;
- (void)hideJunkView;
- (void)hideDrawers;
- (void)hidePickerViews;
- (IBAction)forwardSwipeGestureFired:(UISwipeGestureRecognizer * _Nonnull)sender;
- (IBAction)backwardSwipeGestureFired:(UISwipeGestureRecognizer * _Nonnull)sender;
- (IBAction)forwardSwipeQuoteFired:(UISwipeGestureRecognizer * _Nonnull)sender;
- (IBAction)bakcwardSwipeQuoteFired:(UISwipeGestureRecognizer * _Nonnull)sender;
- (IBAction)topFontSizeSliderFired:(UISlider * _Nonnull)sender;
- (IBAction)bottomFontSizeSliderFired:(UISlider * _Nonnull)sender;
- (IBAction)widthSliderChanged:(UISlider * _Nonnull)sender;
- (IBAction)topWidthSlider:(UISlider * _Nonnull)sender;
- (IBAction)heightSliderChanged:(UISlider * _Nonnull)sender;
- (IBAction)topHeightSlider:(UISlider * _Nonnull)sender;
- (IBAction)junkSliderChanged:(UISlider * _Nonnull)sender;
- (IBAction)topJunkSlider:(UISlider * _Nonnull)sender;
- (IBAction)toggleViewModeInQuoteView:(UITapGestureRecognizer * _Nonnull)sender;
- (IBAction)toggleDrawer:(UITapGestureRecognizer * _Nonnull)sender;
- (void)layoutViewBasedOnEditMode;
- (void)layoutViewBasedOnViewMode;
- (UIView * _Nonnull)returnObjectForManipulation;
- (void)updateSlidersWithView:(UIView * _Nonnull)view;
- (void)touchesBegan:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)touchesMoved:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)updateViewConstraints;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface EchoViewController (SWIFT_EXTENSION(Echo))
- (void)displayActivityController;
@end


@interface EchoViewController (SWIFT_EXTENSION(Echo))
- (void)setUpSWView;
@end


@interface EchoViewController (SWIFT_EXTENSION(Echo)) <UIPickerViewDelegate, UIPickerViewDataSource>
- (NSInteger)pickerView:(UIPickerView * _Nonnull)pickerView numberOfRowsInComponent:(NSInteger)component;
- (UIView * _Nonnull)pickerView:(UIPickerView * _Nonnull)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView * _Nullable)view;
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView * _Nonnull)pickerView;
- (void)pickerView:(UIPickerView * _Nonnull)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end

@class UIImage;

SWIFT_CLASS("_TtC4Echo13ImageUitilies")
@interface ImageUitilies : NSObject
+ (UIImage * _Nonnull)cropToSquareWithImage:(UIImage * _Nonnull)originalImage;
+ (UIImage * _Nullable)createImageWithViewOnTopWithBackgroundImage:(UIImageView * _Nonnull)image view:(UIView * _Nonnull)view;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIColor;

@interface UIImage (SWIFT_EXTENSION(Echo))
- (UIImage * _Nonnull)imageWithColor:(UIColor * _Nonnull)color1;
@end


@interface UIImageView (SWIFT_EXTENSION(Echo))
- (void)downloadImageFromLink:(NSString * _Nonnull)link contentMode:(UIViewContentMode)contentMode;
@end

#pragma clang diagnostic pop
