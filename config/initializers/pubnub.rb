# pubnub.rb
# pubnub config

$pubnub = Pubnub.new(
    "pub-ba837647-7bb6-4c75-8214-4a3762a9b9be",  ## PUBLISH_KEY
    "sub-179bd6a8-4bae-11e1-a0b6-d9a5c160b4b9",  ## SUBSCRIBE_KEY
    "sec-8a56197f-2e14-4147-acf5-a5e99f0ef689",      ## SECRET_KEY
    false    ## SSL_ON?
)