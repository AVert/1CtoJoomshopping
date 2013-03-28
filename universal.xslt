<xsl:stylesheet version = '1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<!-- Question mailto: svitix av-av gmail.com	-->
<!-- Выводим информацию в текстовом виде -->
<xsl:output method="text" encoding="utf-8" indent="no"/>
	
	<!-- Удаляем лишнее: пробел (#x20), возврат каретки (#xD), перевод строки (#xA), знак табуляции (#x9) -->
	<xsl:strip-space elements="*"/>
	
	<!--Путь к файлу с ценами -->
	<xsl:variable name="file_offers" select="document('offers.xml')"></xsl:variable>
	<!-- document('/var/smb/i-shop/tyres/1cbitrix/offers.xml') -->
	
	<!-- тип розничной цены -->
	<xsl:variable name="price1" select="$file_offers/КоммерческаяИнформация/ПакетПредложений/ТипыЦен/ТипЦены[Наименование='Розничная']/Ид"></xsl:variable>
	
	<!-- тип специальной цены -->
	<xsl:variable name="price2" select="$file_offers/КоммерческаяИнформация/ПакетПредложений/ТипыЦен/ТипЦены[Наименование=' Ярмарка']/Ид"></xsl:variable>

	<xsl:template match="/">
		 <xsl:for-each select="//Товар">
			<!-- запоминаем для быстродействия -->
			<xsl:variable name="id" select="Ид"></xsl:variable>			 
		 
			<!-- поле product_id -->
			<xsl:value-of select="$id"/>
			<xsl:text>###</xsl:text>
			
			<!-- поле product_categ -->
			<xsl:value-of select="Группы/Ид"/>
			<xsl:text>###</xsl:text>
			
			<!-- поле product_quantity product_price product_price2-->
			<xsl:call-template name="dumpOffers">
				<xsl:with-param name="linktooffers" select="$file_offers/КоммерческаяИнформация/ПакетПредложений/Предложения/Предложение[Ид=$id]" />
			</xsl:call-template>
			
			<!-- поле product_name   -->
			<xsl:value-of select="ЗначенияРеквизитов/ЗначениеРеквизита[Наименование='Полное наименование']/Значение"/>
			<xsl:text>###</xsl:text>
			
			<!-- поле product_sinonym   -->
			<xsl:value-of select="Наименование"/>
			<xsl:text>###</xsl:text>
	
			<!-- поле product_desc  
			<xsl:value-of select="Описание"/>
			<xsl:text>###</xsl:text>
			 -->

			<!-- Поле Картинка product_image-->
			<xsl:value-of select="Картинка"/>
		
<xsl:text>
</xsl:text>
			
			</xsl:for-each>
	</xsl:template>
	
	
		<!-- Обработка файла  $file_offers -->
	<xsl:template name="dumpOffers">
		<xsl:param name="linktooffers" />
		<xsl:value-of select="$linktooffers/Количество" />
		<xsl:text>###</xsl:text>
		<xsl:value-of select="$linktooffers/Цены/Цена[ИдТипаЦены=$price1]/ЦенаЗаЕдиницу"/>
		<xsl:text>###</xsl:text>
		<xsl:value-of select="$linktooffers/Цены/Цена[ИдТипаЦены=$price2]/ЦенаЗаЕдиницу"/>		
		<xsl:text>###</xsl:text>
	</xsl:template>



  </xsl:stylesheet>