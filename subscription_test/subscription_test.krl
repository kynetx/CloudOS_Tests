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

        strip_rids = [
            "a169x625.prod",
            "a169x664.prod",
            "a169x676.prod",
            "a169x667.prod",
            "a16x161.prod",
            "a41x178.prod",
            "a169x672.prod",
            "a169x669.prod",
            "a169x727.prod",
            "a169x695.prod",
            "b177052x7.prod"
        ];

        system_apps = [
            "a169x625.prod",  // CloudOS Service
            "b501810x2.prod"  // This ruleset
        ];


        pico_factory = function(pico_namespace, pico_type, password) {

            pico_uuid = random:uuid();
            pico = CloudOS:cloudCreate("#{pico_namespace.uc()}_#{pico_type.uc()}_#{pico_uuid}", password);
            pico_auth_channel = pico{"token"};
            pico_remove_rulesets = CloudOS:rulesetRemoveChild(strip_rids, pico_auth_channel);
            pico_install_rulesets = CloudOS:rulesetAddChild(system_apps, pico_auth_channel);
            
            {
                "authChannel": pico_auth_channel,
                "uuid": pico_uuid,
                "status": pico{"status"},
                "msg": pico{"msg"}
            }
        };
    }

    rule start_engine {
        select when test run_subscription_gymnastics
        pre {
            pico_1 = pico_factory("Test", "SubscrptionDummy", "");
            pico_2 = pico_factory("Test", "SubscriptionDummy", "");
            pico_1_cid = {
                "cid": pico_1{"authChannel"}
            };
        }

        {
            // send off the event into the first pico
            event:send(pico_1_cid, "cloudos", "subscribe")
                with attrs = {
                    "channelName": "TestSubscriptionChannel",
                    "namespace": "Test",
                    "relationship": "test-test",
                    "targetChannel": pico_2{"authChannel"}
                };
        }

        fired {
            app:testsRun += 1 from 0;
            log "AKO SAYS:";
            log pico_1.encode();
            log pico_2.encode();
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
            noop();
        }

        fired {
            log "AKO SAYS:";
            log subs.encode();
        }
    }
}
