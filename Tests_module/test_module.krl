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

    succeeds = defaction(msg) {
      send_directive(msg)
    	 with status = "success" and
	      content = values.encode();
    }

    fails = defaction(msg) {
      send_directive(msg)
    	 with status = "failure" and
	      content = values.encode();
    }

    diag = defaction(msg) {
      send_directive(msg)
	with status = "diagnostic" and
	      content = values.encode();
    }

  }

}