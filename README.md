# chronograph-macos
Mac client for chronograph

## Development Requirements
- Xcode 11.7

## Setup
- clone this repository
- install [cocoapods](https://cocoapods.org/)
- run `pod install`
- open `chronograph.xcworkspace` in XCode
- Run the application (Cmd+r)

## Running tests
`xcodebuild clean test -workspace chronograph.xcworkspace -scheme chronograph -destination "platform=macOS,arch=x86_64"`

## How to add configuration
Configuration is exposed through the `Config` class and defined using build variables. Refer to [this](https://medium.com/@hassanahmedkhan/defining-your-own-settings-in-xcode-build-settings-1bd71539ea4f) to add a new configuration variable.
