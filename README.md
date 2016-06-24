Postfix Mail Relay
==================

Setup postfix to send via a mail relay, for example Amazon SES.

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

    postfix_myhostname: False

The myhostname parameter specifies the internet hostname of this
mail system. The default is to use the fully-qualified domain name
from gethostname(). $myhostname is used as a default value for many
other configuration parameters.

    postfix_mydomain: False

The mydomain parameter specifies the local internet domain name.
The default is to use $myhostname minus the first component.
$mydomain is used as a default value for many other configuration
parameters.

    postfix_myorigin: False

The myorigin parameter specifies the domain that locally-posted
mail appears to come from. The default is to append $myhostname,
which is fine for small sites.  If you run a domain with multiple
machines, you should (1) change this to $mydomain and (2) set up
a domain-wide alias database that aliases each user to
user@that.users.mailhost.

For the sake of consistency between sender and recipient addresses,
myorigin also specifies the default domain name that is appended
to recipient addresses that have no @domain part.

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
        - memiah.mail-relay

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
