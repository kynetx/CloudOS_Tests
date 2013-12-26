ruleset  {
  meta {
    name "Test Functions and Actions"
    description <<
Functions and actions to make tests easier
    >>
    author "Phil Windley"
    logging on


    provides success, failure, diag
     
  }

  global {

    success = defaction(msg, values) {
      send_directive(msg)
    	 with status = "success" and
	      content = values.encode();
    }

    failure = defaction(msg, values) {
      send_directive(msg)
    	 with status = "failure" and
	      content = values.encode();
    }

    diag = defaction(msg, values) {
      send_directive(msg)
	with status = "diagnostic" and
	      content = values.encode();
    }

  }

}