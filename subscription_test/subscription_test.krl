ruleset subscription_test {
    meta {
        name "Subscription Test"
        description <<
            a test harness for the CloudOS subscription architecture
        >>
        author "AKO"

        use module a169x625 alias CloudOS
    }

    global {

        system_apps = [
            "a169x625.prod"  // CloudOS Service
        ];


        pico_factory = function(pico_namespace, pico_type, password) {

            pico_uuid = random:uuid();
            pico = CloudOS:cloudCreate("#{pico_namespace.uc()}_#{pico_type.uc()}_#{pico_uuid}", password);
            pico_auth_channel = pico{"token"};
            pico_install_rulesets = CloudOS:rulesetAddChild(system_apps, pico_auth_channel);
            
            {
                "authChannel": pico_auth_channel,
                "uuid": pico_uuid
            }
        };
    }

    rule start_engine {
        select when test run_subscription_gymastics
        pre {
            pico_1 = pico_factory("Test", "SubscrptionDummy", "")
            pico_2 = pico_factory("Test", "SubscriptionDummy", "");
            pico_1_cid = {
                "cid": pico_1{"authChannel"}
            };
        }

        {
            event:send(pico_1_cid, "cloudos", "subscribe")
                with attrs = {
                    "channelName": "TestSubscriptionChannel",
                    "namespace": "Test",
                    "relationship": "test-test",
                    "targetChannel": pico_2{"authChannel"}
                };
        }

        fired {
            set app:testCount += 1;
        }
    }

    rule test_auto_subscription_approval {
        select when cloudos subscriptionRequestPending
            namespace re/test/i
        {
            noop();
        }

        fired {
            raise cloudos event subscriptionRequestApproved
                with eventChannel = event:attr("eventChannel")
                and  _api = "sky";
        }
    }

    rule test_confirm_subscriptions_exist {
        select when cloudos subscriptionAdded 
            namespace re/test/i
        pre {
            subs = CloudOS:getAllSubscriptions();
        }

        {
            send_directive("showTestSubscriptions")
                with subscriptions = subs;
        }
    }
}
