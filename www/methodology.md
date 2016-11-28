### Metodologie

#### Zdroje dat

Výsledky průzkumů jsou veřejně dostupnými výstupy jednotlivých agentur. Odkazy na původní umístění výsledků jednotlivých průzkumů jsou obsaženy v datovém souboru [`polls`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv). Je-li zde uvedena chybějící hodnota `NA`, výsledky průzkumu již nejsou na původním umístění k dispozici.

#### Autoři

Autory aplikace jsou [Kamil Gregor](https://twitter.com/kamilgregor) a [Petr Gongala](https://twitter.com/PetrGongala), absolventi Katedry politologie na Masarykově univerzitě v Brně a Katedry politologie a evropských studií na Univerzitě Palackého v Olomouci. Působí v organizaci [KohoVolit.eu](http://kohovolit.eu/).

#### Připomínky a upozornění na chyby

K aplikaci se můžete vyjádřit prostřednictvím tiketovacího systému na [GitHubu](https://github.com/kamilgregor1/eu_pollster/issues).

#### Data ke stažení

Data používaná aplikací si můžete stáhnout ve formátu CSV na [GitHubu](https://github.com/kamilgregor1/eu_pollster/tree/master/www).

#### Dokumentace dat

*Soubor:proměnná*|*Popis*
---|---
[`data`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/data.csv)|Výsledky volební průzkumů
[`polls`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Informace o volebních průzkumech
[`pollsters`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/pollsters.csv)|Informace o agenturách
[`psp_parties`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/psp_parties.csv)|Seznam politických stran, které se zobrazují v menu
[`psp_poll_types`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/psp_poll_types.csv)|Seznam druhů volebních průzkumů, které se zobrazují v menu
[`data:id`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/data.csv)|Identifikátor výsledku volebního průzkumu
[`data:poll_id`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/data.csv)|Identifikátor volebního průzkumu
[`data:question_id`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/data.csv)|Identifikátor typu otázky
[`data:option_id`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/data.csv)|Identifikátor odpovědi
[`data:count`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/data.csv)|Počet respondentů, kteří uvedli danou odpověď
[`data:percentage`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/data.csv)|Podíl respondentů, kteří uvedli danou odpověď
[`data:denominator`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/data.csv)|Základ podílu respondentů
[`data:denominator_estimate`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/data.csv)|Odhad základu podílu respondentů
[`data:done_by`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/data.csv)|Autor záznamu
[`data:notes`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/data.csv)|Poznámky
[`polls:id`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Identifikátor volebního průzkumu
[`polls:pollster_id`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Identifikátor agentury
[`polls:link`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Odkaz na výsledky volebního průzkumu
[`polls:start_date`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Datum začátku sběru odpovědi
[`polls:end_date`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Datum konce sběru odpovědí
[`polls:midpoint`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Datum středního dne sběru odpovědí
[`polls:published_date`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Datum zveřejnění volebního průzkumu
[`polls:population`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Věk respondentů
[`polls:sponsor`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Zadavatel volebního průzkumu
[`polls:sampling`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Metoda výběru respondentů do vzorku
[`polls:method`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Metoda sběru odpovědí
[`polls:sample`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Počet respondentů ve vzorku
[`polls:done_by`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Autor záznamu
[`polls:notes`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/polls.csv)|Poznámky
[`pollster:id`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/pollsters.csv)|Identifikátor agentury
[`pollster:name`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/pollsters.csv)|Název agentury
[`pollster:abbreviation`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/pollsters.csv)|Zkratka agentury
[`pollster:link`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/pollsters.csv)|Odkaz na webovou stránku agentury
[`pollster:done_by`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/pollsters.csv)|Autor záznamu
[`pollster:notes`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/pollsters.csv)|Poznámky
[`psp_parties:id`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/psp_parties.csv)|Identifikátor politické strany
[`psp_parties:name`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/psp_parties.csv)|Název politické strany
[`psp_parties:selected`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/psp_parties.csv)|Proměnná uvádí, zda daná politická strana bude v menu předem vybrána
[`psp_parties:color`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/psp_parties.csv)|HTML kod barvy politické strany
[`psp_poll_types:id`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/psp_poll_types.csv)|Identifikátor agentury
[`psp_poll_types:name`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/psp_poll_types.csv)|Název druhu volebního průzkumu
[`psp_poll_types:selected`](https://github.com/kamilgregor1/eu_pollster/blob/master/www/psp_poll_types.csv)|Proměnná uvádí, zda daný druh volebního průzkumu bude v menu předem vybráný

#### Zdrojový kód

Zdrojový kód aplikace je dostupný na [GitHubu](https://github.com/kamilgregor1/eu_pollster).

#### Licence a podmínky používání

Výsledky průzkumů jsou veřejnými výstupy jednotlivých agentur. Na výpočty na nich provedené, aplikaci a její zdrojový kód se vztahuje otevřená licence [CC-BY](https://creativecommons.org/licenses/by/2.0/) - lze je volně používat, a to i ke komerčním účelům, za podmínky uvedení autorství.