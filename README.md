Role Name
=========

Setup postfix to send via mail relay, for example Amazon SES.

Requirements
------------

If the chosen mail relay option is to use Amazon AWS SES, create a IAM user 
policy "AmazonSesSendingAccess-[username]" for the user, e.g.

    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "ses:SendEmail",
                    "ses:SendRawEmail"
                ],
                "Resource": "*"
            }
        ]
    }

Role Variables
--------------

Available variables are listed below, along with default values (see 
`defaults/main.yml`):

    postfix_relay_enabled: True
   
By default, the postfix configuration is enabled, so skip set to `False`. 
    
    postfix_relay_server: ""

Postfix relay server hostname, e.g. "email-smtp.region.amazonaws.com".

    postfix_relay_port: 587
    
Postfix relay server port.
    
    postfix_mydomain: ""    
    
Postfix `mydomain` value.

    postfix_relay_user: ""
    
Set postfix relay user.
    
    
    postfix_relay_password: ""
    
Set the relay server password.

    postfix_relay_secret_key: "secret-key-here"
    
Generate the relay password from specified AWS Secret Key. Or, manually populate 
the `postfix_relay_password` value by converting an existing AWS Secret Key to 
an Amazon SES SMTP password using the included bash script:

    ./scripts/aws-ses-smtp-password.sh secret-key-here

Dependencies
------------

None.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      become: yes
      vars_files:
        - vars/main.yml
      roles:
        - memiah.aws-cli

*Inside `vars/main.yml`*:

    postfix_relay_user: "user_here"
    postfix_relay_password: "password_here"
    postfix_relay_server: "email-smtp.region.amazonaws.com"

License
-------

MIT / BSD

Author Information
------------------

This role was created in 2016 by [Memiah Limited](https://github.com/memiah).
