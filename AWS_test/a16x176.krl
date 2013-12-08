ruleset a16x176 {
  meta {
    name "AWSS3 Module Test"
    description <<
Test the AWS module, a41x174
    >>
    author "Phil Windley"
    logging on
    
    key aws {
       "AWSAccessKey": "0GEYA8DTVCB3XHM819R2",
       "AWSSecretKey": "I4TrjKcflLnchhsEzjlNju/s9EHiqdOScbyqGgn+"
    }
    
     // key aws {
     //   "AWSAccessKey": "AKIAJLEPWJXPO5F6KVYA",
     //   "AWSSecretKey": "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"
     // }
     
    use module a41x174 alias AWSS3
      with AWSKeys = keys:aws()
  }

  global {

    test_img = <<
data:image/png;base64,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
	>>;

      S3Bucket = "k_s3_test";
      thisRID = meta:rid();


      makeItemName   = function(name, extension) {
         "#{thisRID}/#{name}.#{extension}";
      };



      imgValue  = this2that:base642string(AWSS3:getValue(test_img)) ;
      imgType   = AWSS3:getType(test_img) ;
      imgExtension = "img";


      stringValue = "Now is the time for all good men to come to the aid of their country!"
      stringType = "text/plain";
      stringExtension = "txt";

      // change string to img to try images (comparison not working)
      itemValue = stringValue;
      itemType = stringType;
      itemExtension = stringExtension;


  }

  rule store_item {
    select when test store_item
    pre {

      //requestTime = time:strftime(time:now({"tz" : "Europe/London"}), "%a, %d %b %Y %T GMT");
      requestTime = time:strftime(time:now({"tz" : "Europe/London"}), "%a, %d %b %Y %T %z");

      item_id  = math:random(99999999);
      itemName   = makeItemName(item_id, itemExtension);
      itemURL    = AWSS3:makeAwsUrl(S3Bucket,itemName);


      values = {
        'type' : 'UPLOAD',
        'item_id': item_id,
	'itemURL' : itemURL,
	'itemType': itemType,
 	'requestTime' : requestTime
      };
    }

    {
       AWSS3:upload(S3Bucket, itemName, itemValue) setting (response)
         with object_type = itemType;
       send_directive("test initiation")
    	 with content = values.encode();
    }
    always {
       raise explicit event store_item_complete
         with item_id = item_id;
       log "Seeing " + values.encode();
    }   
  }


  rule compare_item {
   select when explicit store_item_complete
   pre {
      test_desc = <<
Checks to see that the item stored in store_item was really stored
>>;

      item_id = event:attr("item_id");
      itemName   = makeItemName(item_id, itemExtension);
      itemURL    = AWSS3:makeAwsUrl(S3Bucket,itemName);

      values = {
	'itemURL' : itemURL,
        'status': 'success',
	'test_descriptions' : test_desc
      };

      getItemValue = http:get(itemURL).pick("$.content");
    }

    if(getItemValue eq itemValue) then
       send_directive("test compare success for #{item_id}")
    	 with content = values.encode();
    fired {
      log "Retrieved value equals sent value";
      raise system event test_success with
        timestamp = time:now() and
        test_desc = test_tesc and
        name = meta:rulesetName();
      raise explicit event delete_item with
        item_id = item_id
    } else {
      log "Value mismatch";
      raise system event test_failure with
        timestamp = time:now() and
        test_desc = test_tesc and
        name = meta:rulesetName();
    }      

  }

  rule delete_item {
    select when test delete_item
             or explicit delete_item
    pre {

      item_id = event:attr("item_id");
      itemName   = makeItemName(item_id, itemExtension);
      itemURL    = AWSS3:makeAwsUrl(S3Bucket,itemName);

      requestTime = time:strftime(time:now({"tz" : "Europe/London"}), "%a, %d %b %Y %T %z");

      values = {
        'type' : 'DELETE',
        'item_id': item_id,
	'itemURL' : itemURL,
	'itemType': itemType,
 	'requestTime' : requestTime
      };
    }

    {
       AWSS3:del(S3Bucket, itemName) setting (response)
         with object_type = itemType;
       send_directive("delete item #{item_id} from Amazon S3")
    	 with content = values.put({'response': response}).encode();
    }
    always {
       raise explicit event delete_item_complete with
         item_id = item_id;
       log "Seeing " + values.encode();
    }   
  }
  
  rule check_item_delete {
    select when explicit delete_item_complete
    pre {
      test_desc = <<
Checks to see that the item deleted in delete_item really got deleted
>>;

      item_id = event:attr("item_id");
      itemName   = makeItemName(item_id, itemExtension);
      itemURL    = AWSS3:makeAwsUrl(S3Bucket,itemName);

      itemStatusCode = http:get(itemURL).pick("$.status_code");

      values = {
	'itemURL' : itemURL,
	'operation' : 'check item deleted',
        'status_code' : itemStatusCode,
	'test_descriptions' : test_desc
      };

    }

    if(itemStatusCode eq "403") then
       send_directive("test delete success for #{item_id}")
    	 with content = values.encode();
    fired {
      log "Item not found; delete succeeded";
      raise system event test_success with
        timestamp = time:now() and
        test_desc = test_tesc and
        name = meta:rulesetName();
    } else {
      log "Value mismatch";
      raise system event test_failure with
        timestamp = time:now() and
        test_desc = test_tesc and
        name = meta:rulesetName();
    }      

  }

}