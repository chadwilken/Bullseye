# Bullseye

Bullseye helps you catch missing files in a specific Targer of your XCode Project. Don't let your app get to the store again with missing sources.

## Installation

Install it by executing

    gem install bullseye

## Usage

```sh
bullseye -p ~/Example.xcodeproj -t ExampleTarget -e "Pods,KIF,etc"

flags:
 -p, --project The path to the project
 -t, --target The name of the XCode Target you want to ensure all files are included in
 -e, --exclude Option list of directory names that you do not want to include when scanning the system for files
```

## TODO

- Add tests to the project
- Allow multiple targets

## Contributing

1. Fork it ( http://github.com/<my-github-username>/bullseye/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
