# libKitten
Collection of image and color calculations

## Installation
1. Download the latest `deb` from the [releases](https://github.com/Traurige/libKitten/releases)
2. Install libKitten

## Compatibility
iPhone, iPad and iPod running iOS/iPadOS 12 or later

# Developers

## Installing Into Theos:
Compile the project and everything will happen automatically

## Compiling
  - [Theos](https://theos.dev/) is required to compile the project
  - You may want to edit the root `Makefile` to use your Theos SDK and toolchain

## Importing Into Your Project:
1. Import the library in your header or main file `#import <Kitten/libKitten.h>`
2. Add the library to your Makefile `TWEAK_NAME_LIBRARIES = kitten`
3. Make libKitten a dependency of your tweak in your control file `Depends: dev.traurige.libkitten`<br>

## Usage:
Available methods are:

```objc
+ (UIColor *)backgroundColor:(UIImage *)image;
+ (UIColor *)primaryColor:(UIImage *)image;
+ (UIColor *)secondaryColor:(UIImage *)image;
+ (BOOL)isDarkImage:(UIImage *)image;
+ (BOOL)isDarkColor:(UIColor *)color;
```

They can all be used the same way: `[libKitten backgroundColor:[UIImage ...]];`

## Objective-C Example

```objc
#import <Kitten/libKitten.h>

void (* orig_someMethod)(SomeClass* self, SEL _cmd);
void override_someMethod(SomeClass* self, SEL _cmd) {
    orig_someMethod(self, _cmd);

    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    [label setText:@"Some text"];
    [label setTextColor:[libKitten secondaryColor:[UIImage imageWithContentsOfFile:IMAGE_PATH]]];
    [self addSubview:label];
}

__attribute__((constructor)) static void initialize() {
    MSHookMessageEx(NSClassFromString(@"SomeClass"), @selector(someMethod), (IMP)&override_someMethod, (IMP *)&orig_someMethod);
}
```

## Swift Example

```swift
import libKitten

class SomeHook: ClassHook<Superclass> {
    static let targetName = "TargetClass"

    func someMethod() {
        orig.someMethod()

        let label: UILabel = UILabel(frame: CGRectMake(200, 200, 200, 200));
        label.text = "Some text"

        guard let image = UIImage(contentsOfFile: IMAGE_PATH) else { return }
        label.textColor = libKitten.primaryColor(image)

        target.addSubview(label)
    }
}
```

## License
[MIT](https://github.com/Traurige/libKitten/blob/main/LICENSE)
