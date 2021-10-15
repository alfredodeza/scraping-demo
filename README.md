# scraping-demo
Demo for scraping using scrapy, parsing a real website, extracting key information that is not available through an API and using SQL to query it later.

Install _requirements.txt_ in a virtual environment

```
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install -r requirements.txt
```

Get started with scrapy: https://docs.scrapy.org/en/latest/intro/tutorial.html

```
$ scrapy startproject cve
$ scrapy genspider exploit cve.mitre.org
```

```
$ scrapy shell http://cve.mitre.org/data/refs/refmap/source-EXPLOIT-DB.html
>>> response.url
'http://cve.mitre.org/data/refs/refmap/source-EXPLOIT-DB.html'
>>> response.css
<bound method TextResponse.css of <200 http://cve.mitre.org/data/refs/refmap/source-EXPLOIT-DB.html>>
>>> response.xpath('//table')
[<Selector xpath='//table' data='<table style="width:100%;border-colla...'>, <Selector xpath='//table' data='<table style="text-align:right"><tr><...'>, <Selector xpath='//table' data='<table cellpadding="2" cellspacing="2...'>, <Selector xpath='//table' data='<table cellpadding="2" cellspacing="2...'>, <Selector xpath='//table' data='<table>\n                <tr>\n        ...'>]
>>> len(response.xpath('//table'))
5
>>> response.css('table')
[<Selector xpath='descendant-or-self::table' data='<table style="width:100%;border-colla...'>, <Selector xpath='descendant-or-self::table' data='<table style="text-align:right"><tr><...'>, <Selector xpath='descendant-or-self::table' data='<table cellpadding="2" cellspacing="2...'>, <Selector xpath='descendant-or-self::table' data='<table cellpadding="2" cellspacing="2...'>, <Selector xpath='descendant-or-self::table' data='<table>\n                <tr>\n        ...'>]
>>> len(response.css('table'))
5
```

Find the biggest table:

```
>>> for table in response.css('table'):
...     if len(table.xpath('tr')) >10:
...         print(table)
```

Or:

```
>>> len(response.css('table'))
5
>>> len(response.xpath('//table'))
5
>>> len(response.css('table')[0].xpath('tr'))
3
>>> len(response.css('table')[1].xpath('tr'))
3
>>> len(response.css('table')[2].xpath('tr'))
4
>>> len(response.css('table')[3].xpath('tr'))
10839

```

```
>>> row = data[0]
>>> print(row.getall()[0])
<tr>
<td>EXPLOIT-DB:10102</td>
<td> <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2009-4186">CVE-2009-4186</a>
</td>
</tr>
```

Get the value of href using xpath:

```
>>> row.xpath('td//a/@href')[0].extract()
'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2009-4186'
```

There is no need for the href though because all CVEs have the same URL construction.
