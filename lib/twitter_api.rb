require 'rubygems'
# require 'net/http'
# require 'httpclient'
require 'uri'
require 'oauth'
# require 'curb'

class TwitterApi
  def statuses_update(username, password, message, lat, long)
    # The twitter API address
    host = 'api.twitter.com'
    path = '/1/statuses/update.json'
    params = "status=" + URI.encode(message) + "&lat=" + lat.to_s + "&long=" + long.to_s
    puts params
  end
end

twitter  = TwitterApi.new
twitter.statuses_update('snus', 'millmilk', 'test', nil, nil)

# <?php
# 
# ////////////////////////
# // Twitter Basic Methods
# ////////////////////////
# 
# class TwitterMethods{
#   // Tweet with Twitter API
#   function statuses_update($username, $password, $message, $lat = null, $long = null){
#     // The twitter API address
#     $url = 'http://api.twitter.com/1/statuses/update.json';
#     $params = "status=". rawurlencode($message) . "&lat=" . $lat . "&long=" . $long;
# 
#     // Set up and execute the curl process
#     $result = $this->curl_post($username, $password, $url, $params);
#     $json_res = json_decode($result);
# 
#     // check for success or failure
#     if ($json_res) {
#         echo $message;
#     } else {
#         echo "Oops! Failed to tweet...";
#     }
#     return $json_res;
#   }
# 
#   // Sends a new direct message ($recipient_user can be eithre of screen_name and user_id)
#   function direct_messages_new($username, $password, $recipient_user, $message){
#     // The twitter API address
#     $url = 'http://api.twitter.com/1/direct_messages/new.json';
#     $params = "user=" . $recipient_user . "&text=" . rawurlencode($message);
# 
#     // Set up and execute the curl process
#     $result = $this->curl_post($username, $password, $url, $params);
# 
#     // check for success or failure
#     if (!empty($result)) {
#         echo $message;
#     } else {
#         echo "Oops! Failed to tweet...";
#     }
#   }
# 
#   function user_timeline($username = null, $password = null, $count = null){
#     $url = "http://api.twitter.com/1/statuses/user_timeline.json";
#     $screen_name_params = "?screen_name=" . $username;
# 
#     if($count){
#       $count_params = "&count=" . $count;
#     } else {
#       $count_params = "";
#     }
# 
#     $curl_res = $this->curl_get($username, $password, $url . $screen_name_params . $count_params);
#     $result = json_decode($curl_res);
#     if(!empty($result)){
#       return $result[0];
#     } else {
#       return null;
#     }
#   }
# 
#   function curl_post($username, $password, $url, $params = null){
#     // Create the connection handle
#     $curl_handle = curl_init();
#     // Set cURL options
#     curl_setopt($curl_handle, CURLOPT_HTTPHEADER, array('Expect:')); // The expectation given in the Expect request-header field only allow the 100-continue expectation
#     curl_setopt($curl_handle, CURLOPT_URL, $url); // URL to connect to
#     // curl_setopt($curl_handle, CURLOPT_GET, 1); // Use GET method
#     curl_setopt($curl_handle, CURLOPT_POST, 1); // Use POST method
#     curl_setopt($curl_handle, CURLOPT_POSTFIELDS, $params);
#     curl_setopt($curl_handle, CURLOPT_HTTPAUTH, CURLAUTH_BASIC); // Use basic authentication
#     curl_setopt($curl_handle, CURLOPT_USERPWD, "$username:$password"); // Set u/p
#     curl_setopt($curl_handle, CURLOPT_SSL_VERIFYPEER, false); // Do not check SSL certificate (but use SSL of course), live dangerously!
#     curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1); // Return the result as string
#     curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, 2);
#     $result = curl_exec($curl_handle);
#     // close cURL resource. It's like shutting down the water when you're brushing your teeth.
#     curl_close($curl_handle);
#     return $result;
#   }
# 
#   function curl_get($username, $password, $url){
#     // Create the connection handle
#     $curl_handle = curl_init();
#     // Set cURL options
#     curl_setopt($curl_handle, CURLOPT_URL, $url); // URL to connect to
#     curl_setopt($curl_handle, CURLOPT_HTTPGET, 1); // Use GET method
#     // curl_setopt($curl_handle, CURLOPT_POST, 1); // Use POST method
#     // curl_setopt($curl_handle, CURLOPT_POSTFIELDS, $params);
#     curl_setopt($curl_handle, CURLOPT_HTTPAUTH, CURLAUTH_BASIC); // Use basic authentication
#     curl_setopt($curl_handle, CURLOPT_USERPWD, "$username:$password"); // Set u/p
#     curl_setopt($curl_handle, CURLOPT_SSL_VERIFYPEER, false); // Do not check SSL certificate (but use SSL of course), live dangerously!
#     curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1); // Return the result as string
#     curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, 2);
#     $result = curl_exec($curl_handle);
#     // close cURL resource. It's like shutting down the water when you're brushing your teeth.
#     curl_close($curl_handle);
#     return $result;
#   }
# 
#   // Shorten an url with TinyURL
#   function get_tiny_url($url) {
#     $tinyurl_api_url= "http://tinyurl.com/api-create.php?url=";
#     $params = $url;
#     $context = stream_context_create(
#       array(
#         "http" => array(
#           "method" => "GET"
#         )
#       )
#     );
#     $tinyurl = file_get_contents($tinyurl_api_url.$params , false, $context);
#     return $tinyurl;
#   }
# 
#   // Shorten an url with bit.ly
#   function get_bitly_url($url) {
#     $bitly_api_url = "http://api.bit.ly/shorten?version=2.0.1";
#     $login = "&login=snusmumrik";
#     $api_key = "&apiKey=R_bb6eff44e09e72ef7f82c6fa9852e08c";
#     $long_url = "&longUrl=" . $url;
#     $context = stream_context_create(
#       array(
#         "http" => array(
#           "method" => "GET"
#         )
#       )
#     );
#     $bitly_url = file_get_contents($bitly_api_url . $login . $api_key . $long_url, false, $context);
#     return $bytly_url;
#   }
# 
# function get_geo_code($location, $vague_flg = false){
#   $geocoding_url = "http://maps.google.com/maps/geo?sensor=false&key=ABQIAAAA0_nNOQcrMzHmHeLxXKGrPxR6knQxbFjd-_so9nkzoqF49jgnyBT2BA4m0bXcwE1-XqQnciQRadf_yQ&sensor=false&output=json&q=";
#   $result = $this->curl_post(null, null, $geocoding_url . urlencode($location));
#   // debug
#   // var_dump($result);
#   $parsed_res = json_decode($result);
#   $coordinates = array($parsed_res->Placemark[0]->Point->coordinates[1], $parsed_res->Placemark[0]->Point->coordinates[0]);
#   // Slightly change the coordinates params
#   if($vague_flg){
#     foreach($coordinates as $key => $value){
#       $coordinates[$key] = $value  + mt_rand(-100, 100) / 100000;
#     }
#   }
#   return $coordinates;
# }
# 
# ?>