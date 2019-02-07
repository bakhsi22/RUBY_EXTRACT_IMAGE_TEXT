# free api for converting images to text. Register [here](http://space.us11.list-manage1.com/subscribe?u=ce17e59f5b68a2fd3542801fd&id=252aee70a1) for free api key.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ocr_space'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ocr_space

## Instantiate OcrSpace resource with apikey

```ruby
require 'ocr_space'

resource = OcrSpace::Resource.new(apikey: "YOUR API KEY")
#By default it picks up ocr_api_key='YOUR API KEY' from your env variables
```


#COMMAND LINE INTERFACE 

You can run ocr_space through shell to get quick result from a image using filepath or url

```
$ ocrspace /Users/suyesh/Desktop/nicola_tesla.jpg

=> If you want to find the secrets of the universe, think in terms of energy, frequency and vibration. AZ QUOTES

```

