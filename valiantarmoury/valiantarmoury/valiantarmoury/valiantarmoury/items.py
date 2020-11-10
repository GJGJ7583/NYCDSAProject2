# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class ValiantarmouryItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    name = scrapy.Field()
    price = scrapy.Field()
    weigh = scrapy.Field()
    blade_length = scrapy.Field()
    blade_steel = scrapy.Field()
    handle_length = scrapy.Field()
    overall_length = scrapy.Field()
