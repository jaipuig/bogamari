/**
 * Copyright 2009
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "QRUIAppDelegate.h"
#import "ViewController.h"


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation QRUIAppDelegate


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidFinishLaunching:(UIApplication *)application {
  _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

	ViewController* controller = [[ViewController alloc] init];
	[_window addSubview:controller.view];
  [controller release];

  // Override point for customization after application launch
  [_window makeKeyAndVisible];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  [_window release];

  [super dealloc];
}


@end
