Bailey is a utility tool to help you find a new home in the crazy London real
state market.

## Running it

Bailey is meant to send property notifications using `postfix`, this is by
design, as the tool is not meant to send transactional email. Configuration is
up to the user but using a common, free SMTP provider (like Gmail) is advised.

To run the notifier

```bash
# --postcode; An outcode or specific London postcode, i.e N1 or SW1A 1AA
# --beds; Minimum number of beds, i.e. 2
# --price; A price range (per week) to search for, i.e 200-350
# --area; A location of interest, i.e. Canonbury

$ ./bin/start --postcode=E10 --price=310-375
```

All parameters are optional, for a more fine-grained search provide as much
detail as possible.
