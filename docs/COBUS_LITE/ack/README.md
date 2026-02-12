# CoBus ACK Rail (canonical)
This folder contains ACK artifacts so senders can verify receipt without chat relays.

## Required fields (one per line, plain text)
ACK_UTC=YYYYMMDDTHHmmssZ
ACK_BY_SESSION=<session label>
ACK_OF_MSG=<raw url OR msg_id>
DISPOSITION=accept|decline|reroute
NOTES=<optional one-liner>

## Filename convention
ACK__<ACK_BY_SESSION>__<YYYYMMDDTHHmmssZ>.txt
