from valiantarmoury.items import ValiantarmouryItem
from scrapy import Spider, Request
import re
import math


class valiantarmourySpider(Spider):
    name = 'valiantarmoury_spider'
    allowed_urls = ['https://www.valiant-armoury.com']
    start_urls = ['https://www.valiant-armoury.com/collections/the-craftsman-series']


    def parse(self, response):

        result_urls = [f'https://www.valiant-armoury.com/collections/the-craftsman-series?page={i+1}' for i in range(3)]
        
        for result_url in result_urls:
            yield Request(url=result_url, callback=self.parse_page)

    def parse_page(self, response):
        product_urls = response.xpath('//div[@class="card-list grid"]//a/@href').extract()

        product_urls = ['https://www.valiant-armoury.com' + url for url in product_urls]

        for url in product_urls:
            yield Request(url=url, callback=self.parse_sword)

    def parse_sword(self, response):
        name =  response.xpath('//h1[@class="product__title h2 text-center"]/text()')[0].extract()
        price = response.xpath('//div[@class="product__content-header"]//p[@class="product__price text-center "]//span[@class="product__current-price"]/text()')[0].extract()
       
        try:

            weigh = response.xpath('//div[@class="product__content-main"]//div[@class="product__description rte"]/p[4]/text()')[5].extract()

        except:

            weigh = 'NA'

        # weigh = response.xpath('//div[@class="product__content-main"]//div[@class="product__description rte"]/p[4]/text()')[5].extract()
        blade_length = response.xpath('//div[@class="product__content-main"]//div[@class="product__description rte"]/p[4]/text()')[1].extract() 
        handle_length = response.xpath('//div[@class="product__content-main"]//div[@class="product__description rte"]/p[4]/text()')[2].extract()
        overall_length = response.xpath('//div[@class="product__content-main"]//div[@class="product__description rte"]/p[4]/text()')[0].extract()


        item = ValiantarmouryItem()
        item['name'] = name
        item['price'] = price
        item['weigh'] = weigh
        item['blade_length'] = blade_length
        item['blade_steel'] = 6150
        item['handle_length'] = handle_length
        item['overall_length'] = overall_length

        yield item

