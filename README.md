# UVObot

[![Code Climate](https://codeclimate.com/github/slovensko-digital/uvobot/badges/gpa.svg)](https://codeclimate.com/github/slovensko-digital/uvobot) [![Test Coverage](https://codeclimate.com/github/slovensko-digital/uvobot/badges/coverage.svg)](https://codeclimate.com/github/slovensko-digital/uvobot/coverage) [![Dependency Status](https://gemnasium.com/slovensko-digital/uvobot.svg)](https://gemnasium.com/slovensko-digital/uvobot)


Notifikácie pre chat www.slack.com a www.discourse.org fórum z Úradu pre verejné obstarávanie o obstarávaniach v IT sektore.

## Nasadenie cez Docker

Build docker obrazu pomocou `docker build -t my_uvobot .`. Pri spustení kontajnera je potrebné mať nastavené env `RAILS_ENV=production`.

Slack a Discourse integrácie sa nastavujú cez `UVOBOT_SLACK_WEBHOOK` a `DISCOURSE_URL`, `DISCOURSE_API_KEY`, `DISCOURSE_USER` a `DISCOURSE_TARGET_CATEGORY`. Intregrácie, pre ktoré nie sú nastavené envs, sa nevykonajú a uvobot vypíše nájdené výsledky iba do konzoly.

Čas spustenia `15:00` je možné upraviť v `config/clock.rb`.
