ruleset  {
  meta {
    name "Test Functions and Actions"
    description <<
Functions and actions to make writing KRL tests easier
    >>
    author "Phil Windley"
    logging on

    provide succeeds, fails, diag
     
  }

  global {

    succeeds = defaction(msg, values) {
      send_directive(msg)
    	 with status = "success" and
	      content = values.encode();
    }

    fails = defaction(msg, values) {
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