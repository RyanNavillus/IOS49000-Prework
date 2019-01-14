# Pre-work - *Name of App Here*

**Name of your app** is a tip calculator application for iOS.

Submitted by: **Your Name Here**

Time spent: **X** hours spent in total

## User Stories

The following **required** functionality is complete:

* [ ] User can enter a bill amount, choose a tip percentage, and see the tip and total values.

The following **optional** features are implemented:
* [√] Settings page to change the default tip percentage.
* [√] UI animations
* [√] Remembering the bill amount across app restarts (if <10mins)
* [√] Using locale-specific currency and currency thousands separators.
* [√] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [√] Light/Dark Mode
- [√] Change tip amounts in segmented control
- [√] Input sanitization (All inputs must be valid numbers)

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

Creating a textfield using a number formatter is very difficult, since you have to prevent the user from editing the commas or currency symbols. I'm not sure if there is a built in way to accomplish this, but it seemed like it required a lot of string manipulation with a ton of edge cases. Ultimately, I chose to only format the outputs and the placeholder. I thought this made the calculator more intuitive.

Also, Light and Dark mode took a lot of work. I think that in the future, it would make sense to subclass all UI elements so that they each handle their own theme colors.

## License

    Copyright [2019] [Ryan Sullivan]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
