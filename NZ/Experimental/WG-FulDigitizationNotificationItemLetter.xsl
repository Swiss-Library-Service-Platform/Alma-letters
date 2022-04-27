<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 05/2022 -->
<!-- Dependance:
		recordTitle - SLSP-multilingual, SLSP-userAccount
		style - generalStyle, bodyStyleCss
		header - head
		senderReceiver - senderReceiver
		-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="footer.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="recordTitle.xsl" />
	<xsl:variable name="conta1">0</xsl:variable>
	<xsl:variable name="stepType" select="/notification_data/request/work_flow_entity/step_type" />
	<xsl:variable name="externalRequestId" select="/notification_data/external_request_id" />
	<xsl:variable name="externalSystem" select="/notification_data/external_system" />
	<xsl:variable name="isDeposit" select="/notification_data/request/deposit_indicator" />
	<xsl:variable name="isDigitalDocDelivery" select="/notification_data/digital_document_delivery" />

<!-- template to show link to SLSP fees info page
	The lang parameter for URL is used from the user preferred language
	Depends on:
		recordTitle - SLSP-multilingual
	USAGE: <xsl:call-template name="pricing-swisscovery"/>
	 -->
	<xsl:template name="pricing-swisscovery">
		<xsl:call-template name="SLSP-multilingual">
			<xsl:with-param name="en" select="'For general information about pricing for delivery please see: '"/>
			<!-- Adaptation to include single quote in "n'ont" in the text -->
			<xsl:with-param name="fr">
				<![CDATA[Pour des informations générales sur la tarification de la livraison, veuillez consulter: ]]>
			</xsl:with-param>
			<xsl:with-param name="it" select="'Per informazioni generali sulle tariffe si prega di consultare: '"/>
			<xsl:with-param name="de" select="'Allgemeine Informationen zu den Preisen für die Lieferung finden Sie unter: '"/>
		</xsl:call-template>
		<a>
			<xsl:attribute name="href">https://slsp.ch/<xsl:value-of select="/notification_data/receivers/receiver/preferred_language"/>/fees</xsl:attribute>
			<xsl:attribute name="target">
				_blank
			</xsl:attribute>
			<xsl:call-template name="SLSP-multilingual">
				<xsl:with-param name="en" select="'https://slsp.ch/en/fees'"/>
				<xsl:with-param name="fr" select="'https://slsp.ch/fr/fees'"/>
				<xsl:with-param name="it" select="'https://slsp.ch/it/fees'"/>
				<xsl:with-param name="de" select="'https://slsp.ch/de/fees'"/>
			</xsl:call-template>
		</a>
	</xsl:template>

	<xsl:template match="/">
	<html>
		<head>
		<xsl:call-template name="generalStyle" />
		</head>
		<body>
		<xsl:attribute name="style">
			<xsl:call-template name="bodyStyleCss" />
			<!-- style.xsl -->
		</xsl:attribute>
		<xsl:call-template name="head" />
		<!-- header.xsl -->
		<br />
		<xsl:call-template name="senderReceiver" />
		<!-- SenderReceiver.xsl -->
		<div class="messageArea">
			<div class="messageBody">
				<table cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>
							<xsl:call-template name="SLSP-multilingual">
								<xsl:with-param name="en" select="'Hello'"/>
								<xsl:with-param name="fr" select="'Bonjour,'"/>
								<xsl:with-param name="it" select="'Buongiorno,'"/>
								<xsl:with-param name="de" select="'Guten Tag'"/>
							</xsl:call-template>
						</td>
					</tr>
					<tr>
						<td>
							@@your_request@@
						</td>
					</tr>
					<tr>
						<td>
							<!-- If this is Deposit then make the title clickable -->
							<xsl:choose>
								<xsl:when test="$isDeposit='true'">
									<a>
									<xsl:attribute name="href">
										<xsl:value-of select="notification_data/item_url" />
									</xsl:attribute>
									<strong><xsl:value-of select="notification_data/phys_item_display/title" disable-output-escaping="yes"/></strong>
									</a>
								</xsl:when>
								<xsl:otherwise>
									<strong><xsl:value-of select="notification_data/phys_item_display/title" disable-output-escaping="yes"/></strong>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="notification_data/phys_item_display/author !=''">
								<br/><xsl:value-of select="notification_data/phys_item_display/author"/>
							</xsl:if>
							<xsl:if test="notification_data/phys_item_display/imprint !=''">
								<br/>
								<span class="recordImprint">
									<xsl:value-of select="notification_data/phys_item_display/publication_place"/>:&#160;<xsl:value-of select="notification_data/phys_item_display/publisher"/>,&#160;<xsl:value-of select="notification_data/phys_item_display/publication_date"/>
								</span>
							</xsl:if>
							<xsl:if test="notification_data/phys_item_display/issue_level_description !='' and notification_data/phys_item_display/issue_level_description != 'Vol.' and notification_data/phys_item_display/issue_level_description != '_'">
								<br />
								<xsl:call-template name="SLSP-multilingual">
									<xsl:with-param name="en" select="'Description'"/>
									<xsl:with-param name="fr" select="'Description'"/>
									<xsl:with-param name="it" select="'Descrizione'"/>
									<xsl:with-param name="de" select="'Beschreibung'"/>
								</xsl:call-template>: <xsl:value-of select="notification_data/phys_item_display/issue_level_description"/>
							</xsl:if>
							<xsl:if test="notification_data/request/chapter_article_title !=''">
								<br />
								<xsl:call-template name="SLSP-multilingual">
									<xsl:with-param name="en" select="'Article / Chapter'"/>
									<xsl:with-param name="fr" select="'Article / Chapitre'"/>
									<xsl:with-param name="it" select="'Articolo / Capitolo'"/>
									<xsl:with-param name="de" select="'Artikel / Kapitel'"/>
								</xsl:call-template>: <xsl:value-of select="notification_data/request/chapter_article_title" />
							</xsl:if>
							<xsl:if test="notification_data/request/pages !=''">
								<br />
								<xsl:call-template name="SLSP-multilingual">
									<xsl:with-param name="en" select="'Pages'"/>
									<xsl:with-param name="fr" select="'Pages'"/>
									<xsl:with-param name="it" select="'Pagine'"/>
									<xsl:with-param name="de" select="'Seiten'"/>
								</xsl:call-template>: <xsl:value-of select="/notification_data/request/pages" />
							</xsl:if>
							<xsl:if test="notification_data/request/note !=''">
								<br />
								<xsl:call-template name="SLSP-multilingual">
									<xsl:with-param name="en" select="'Request note'"/>
									<xsl:with-param name="fr" select="'Note de demande	'"/>
									<xsl:with-param name="it" select="'Nota di richiesta'"/>
									<xsl:with-param name="de" select="'Bestell-Notiz'"/>
								</xsl:call-template>: <xsl:value-of select="/notification_data/request/note" />
							</xsl:if>
						</td>
					</tr>
					<xsl:if test="$isDigitalDocDelivery='true' or $isDeposit='false'"> <!-- DOCUMENT DELIVERY -->
						<tr>
							<td>
							<xsl:if test="not(/notification_data/url_list[string])">
								@@request_type_digitization@@ 
								<br/>
							</xsl:if>
							<xsl:if test="/notification_data/url_list[string]">
								@@attached_are_the_urls@@ <br/>
								<xsl:for-each select="/notification_data/attachments_list/attachments">
								<xsl:if test="url">
									<a>
									<xsl:attribute name="href">
										<xsl:value-of select="url" />
									</xsl:attribute>
									<xsl:value-of select="url" />
									</a>
									<xsl:if test="string-length(notes)!=0">
									(<xsl:value-of select="notes"/>)
									</xsl:if>
									<br/>
								</xsl:if>
								</xsl:for-each>
							</xsl:if>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<td>
							<xsl:call-template name="SLSP-userAccount"/>
						</td>
					</tr>
					<tr>
						<td>
							<xsl:call-template name="pricing-swisscovery"/>
						</td>
					</tr>
					<tr>
						<td>@@sincerely@@ <br/>
							<xsl:value-of select="notification_data/organization_unit/name" />
						</td>
					</tr>
					<tr>
						<td><br/><i>powered by SLSP</i></td>
					</tr>
				</table>
			</div>
		</div>
		</body>
	</html>
	</xsl:template>
</xsl:stylesheet>