ruleset  {
  meta {
    name "Test Functions and Actions"
    description <<
Functions and actions to make tests easier
    >>
    author "Phil Windley"
    logging on

     
  }

  global {

    test_success = defaction(msg, values) {
      send_directive(msg)
    	 with status = "success" and
	      content = values.encode();
    }

    test_failure = defaction(msg, values) {
      send_directive(msg)
    	 with status = "failure" and
	      content = values.encode();
    }

  }

}