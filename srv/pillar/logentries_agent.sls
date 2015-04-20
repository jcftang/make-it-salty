# the keys in this example are purely here as an example
logentries_agent:
    account_key: 8cedbc1a-bd38-46ed-80a7-0bcb28ee3efe
    host_key: 8c2b2a66-68c7-46ab-9fbc-191b31ce2e20
    pull_server_side_config: False
    list:
        mysyslogset:
            path: /var/log/syslog
            token: 4e647fb3-5497-4b6a-ae35-1154cc9edff9
        mymaillogset:
            path: /var/log/mail.log
            dest: node0/syslog
