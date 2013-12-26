ruleset test_module {
  meta {
    name "Test Functions and Actions"
    description <<
Functions and actions to make writing KRL tests easier
>>
    author "Phil Windley"
    logging on
    provides succeeds, fails, diag
  }

  global {

    succeeds = defaction(msg, values) {
      send_directive(msg)
    	 with status = "success" and
	      details = values.encode();
    }

    fails = defaction(msg, values) {
      send_directive(msg)
    	 with status = "failure" and
	      details = values.encode();
    }

    diag = defaction(msg, values) {
      send_directive(msg)
	with status = "diagnostic" and
	      details = values.encode();
    }

  }

  rule see_success {
    select when test succeeds

    send_directive(event:attr("test_desc"))
         with status = "success" and
	      timestamp = time:now() and
	      rule = meta:callingRID() + ":" + event:attr("rulename") and
              msg = event:attr("msg") and
	      details = values.encode();
  }

  rule see_failure {
    select when test fails

    send_directive(event:attr("test_desc"))
         with status = "failure" and
	      timestamp = time:now() and
	      rule = meta:callingRID() + ":" + event:attr("rulename") and
              msg = event:attr("msg") and
	      details = values.encode();
  }

}