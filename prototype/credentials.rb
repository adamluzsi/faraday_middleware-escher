require 'escher-keypool'

ENV['KEY_POOL'] = '[{"keyId":"EscherExample","secret":"TheBeginningOfABeautifulFriendship","acceptOnly":0}]'
ENV['ESCHEREXAMPLE_KEYID'] = 'EscherExample'

CredentialScope = 'example/credential/scope'
AuthOptions = {}
ESCHER_KEY = {api_key_id: 'EscherExample', api_secret: 'TheBeginningOfABeautifulFriendship'}