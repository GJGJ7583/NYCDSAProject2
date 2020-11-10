from coldsteel.items import ColdsteelItem
from scrapy import Spider, Request
import re




class ColdsteelSpider(Spider):
    name = 'coldsteel_spider'
    allowed_urls = ['https://www.coldsteel.com']
    start_urls = ['https://www.coldsteel.com/all-swords/?count=83']


    def parse(self, response):
        num_swords = int(len(response.xpath('//div[@class="product-list l-products grid-mode"]//div[@class="product-tile"]//a/@href').extract()))
        all_swords_urls = response.xpath('//div[@class="product-list l-products grid-mode"]//div[@class="product-tile"]//a/@href').extract()

        swords = []



        for i in range(num_swords):
            if i % 2 == 0:
                url = 'https://www.coldsteel.com' + all_swords_urls[i]
                swords.append(url)

        for sword in swords:
            yield Request(url=sword, callback=self.parse_sword)

    def parse_sword(self, response):
        name =  response.xpath('//h1[@class="font-product-title"]/text()')[0].extract()
        price = float(response.xpath('//span[@class="lbl-price"]/text()')[0].extract()[1:])
        weigh = response.xpath('//div[@class="html-wrapper fr-view"]/text()')[1].extract()[10:]
        blade_length = response.xpath('//div[@class="html-wrapper fr-view"]/text()')[3].extract()[16:]
        blade_steel =  response.xpath('//div[@class="html-wrapper fr-view"]/text()')[4].extract()[15:]
        handle_length = response.xpath('//div[@class="html-wrapper fr-view"]/text()')[5].extract()[26:]
        overall_length = response.xpath('//div[@class="html-wrapper fr-view"]/text()')[6].extract()[18:]


        item = ColdsteelItem()
        item['name'] = name
        item['price'] = price
        item['weigh'] = weigh
        item['blade_length'] = blade_length
        item['blade_steel'] = blade_steel
        item['handle_length'] = handle_length
        item['overall_length'] = overall_length

        yield item







