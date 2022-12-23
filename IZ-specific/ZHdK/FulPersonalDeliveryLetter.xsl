<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 12/2021 -->
<!-- Dependance:
		recordTitle - SLSP-multilingual, SLSP-userAccount
		style - bodyStyleCss, listStyleCss
		header - head
		-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="footer.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="recordTitle.xsl" />

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

	<!-- Address template printing delivery address on the right side
	The sender address is with smaller font and the delivery address is bold -->
	<xsl:template name="senderReceiver-personal-delivery-right">
		<table cellspacing="0" border="0" width="100%">
			<tr>
				<!-- sender -->
				<td width="50%" align="left" style="padding: 10mm 10mm 10mm 10mm;">
					<xsl:for-each select="/notification_data/phys_item_display/owning_library_details">
						<table>
						<xsl:attribute name="style">
							font-size: 80%;
							<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
						</xsl:attribute>
							<tr><td><xsl:value-of select="address1"/></td></tr>
							<tr><td><xsl:value-of select="address2"/></td></tr>
							<xsl:if test="string-length(address3)!=0">
								<tr><td><xsl:value-of select="address3"/></td></tr>
							</xsl:if>
							<xsl:if test="string-length(address4)!=0">
								<tr><td><xsl:value-of select="address4"/></td></tr>
							</xsl:if>
							<xsl:if test="string-length(address5)!=0">
								<tr><td><xsl:value-of select="address5"/></td></tr>
							</xsl:if>
							<tr><td><xsl:value-of select="postal_code"/>&#160;<xsl:value-of select="city"/></td></tr>
							<xsl:if test="string-length(phone)!=0">  
								<tr><td><xsl:value-of select="phone"/></td></tr> 
							</xsl:if>
							<xsl:if test="string-length(email)!=0">
								<tr><td><xsl:value-of select="email"/></td></tr> 
							</xsl:if>
						</table>
					</xsl:for-each>
				</td>
				<!-- receiver -->
				<td width="50%"  align="left" style="padding: 10mm 10mm 10mm 15mm; vertical-align: top;">
					<xsl:choose>
						<xsl:when test="notification_data/user_for_printing">
							<table cellspacing="0" cellpadding="0" border="0">
								<xsl:attribute name="style">
									font-weight: 600;
									<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
								</xsl:attribute>
								<tr>
									<td>
										<xsl:if test="notification_data/user_for_printing/first_name != ''">
											<xsl:value-of select="notification_data/user_for_printing/first_name"/>&#160;</xsl:if><xsl:value-of select="notification_data/user_for_printing/last_name"/>
									</td>
								</tr>
								<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>4">
								<tr>
									<td>
										<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[2]"/>
									</td>
								</tr>
								</xsl:if>
								<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>5">
								<tr>
									<td>
										<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[3]"/>
									</td>
								</tr>
								</xsl:if>
								<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>6">
								<tr>
									<td>
										<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[4]"/>
									</td>
								</tr>
								</xsl:if>
								<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>7">
								<tr>
									<td>
										<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[5]"/>
									</td>
								</tr>
								</xsl:if>
								<tr>
									<td>
										<xsl:variable name="number_code" select="count(str:tokenize(notification_data/delivery_address,'&#10;'))-1" />
										<xsl:variable name="number_city" select="count(str:tokenize(notification_data/delivery_address,'&#10;'))-2" />
										<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[$number_code]"/><xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[$number_city]"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:variable name="number_country" select="count(str:tokenize(notification_data/delivery_address,'&#10;'))" />
										<xsl:if test="str:tokenize(notification_data/delivery_address,'&#10;')[$number_country]!=' CHE'">
											<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[$number_country]"/>
										</xsl:if>
									</td>
								</tr>
							</table>
						</xsl:when>
						<xsl:when test="notification_data/receivers/receiver/user">
							<xsl:for-each select="notification_data/receivers/receiver/user">
								<table>
								<xsl:attribute name="style">
									<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
								</xsl:attribute>
									<tr>
										<td>
											<xsl:if test="first_name != ''"><xsl:value-of select="first_name"/>&#160;</xsl:if><xsl:value-of select="last_name"/>
										</td>
									</tr>
									<tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
									<tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
									<xsl:if test="string-length(user_address_list/user_address/line3)!=0">
										<tr><td><xsl:value-of select="user_address_list/user_address/line3"/></td></tr>
									</xsl:if>
									<xsl:if test="string-length(user_address_list/user_address/line4)!=0">
									<tr><td><xsl:value-of select="user_address_list/user_address/line4"/></td></tr>
									</xsl:if>
									<tr><td>
										<xsl:value-of select="user_address_list/user_address/postal_code"/>&#160;<xsl:value-of select="user_address_list/user_address/city"/>
									</td></tr>
									<tr><td>
										<xsl:choose>
											<xsl:when test="user_address_list/user_address/country = 'Null'">
											<xsl:text> </xsl:text>
											</xsl:when>
											<xsl:when test="user_address_list/user_address/country = 'CHE'">
											<xsl:text> </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												&#160;<xsl:value-of select="user_address_list/user_address/country"/>
											</xsl:otherwise>
										</xsl:choose>
									</td></tr>
								</table>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</table>
	</xsl:template>

	<!-- Address template printing delivery address on the left side
	The sender address is with smaller font and the delivery address is bold -->
	<xsl:template name="senderReceiver-personal-delivery-left">
		<table cellspacing="0" border="0" width="100%">
			<tr>
				<!-- receiver -->
				<td width="50%"  align="left" style="padding: 10mm 10mm 10mm 10mm; vertical-align: top;">
					<xsl:choose>
						<xsl:when test="notification_data/user_for_printing">
							<table cellspacing="0" cellpadding="0" border="0">
								<xsl:attribute name="style">
									font-weight: 600;
									<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
								</xsl:attribute>
								<tr>
									<td>
										<xsl:if test="notification_data/user_for_printing/first_name != ''">
											<xsl:value-of select="notification_data/user_for_printing/first_name"/>&#160;</xsl:if><xsl:value-of select="notification_data/user_for_printing/last_name"/>
									</td>
								</tr>
								<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>4">
								<tr>
									<td>
										<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[2]"/>
									</td>
								</tr>
								</xsl:if>
								<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>5">
								<tr>
									<td>
										<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[3]"/>
									</td>
								</tr>
								</xsl:if>
								<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>6">
								<tr>
									<td>
										<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[4]"/>
									</td>
								</tr>
								</xsl:if>
								<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>7">
								<tr>
									<td>
										<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[5]"/>
									</td>
								</tr>
								</xsl:if>
								<tr>
									<td>
										<xsl:variable name="number_code" select="count(str:tokenize(notification_data/delivery_address,'&#10;'))-1" />
										<xsl:variable name="number_city" select="count(str:tokenize(notification_data/delivery_address,'&#10;'))-2" />
										<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[$number_code]"/><xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[$number_city]"/>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:variable name="number_country" select="count(str:tokenize(notification_data/delivery_address,'&#10;'))" />
										<xsl:if test="str:tokenize(notification_data/delivery_address,'&#10;')[$number_country]!=' CHE'">
											<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[$number_country]"/>
										</xsl:if>
									</td>
								</tr>
							</table>
						</xsl:when>
						<xsl:when test="notification_data/receivers/receiver/user">
							<xsl:for-each select="notification_data/receivers/receiver/user">
								<table>
								<xsl:attribute name="style">
									<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
								</xsl:attribute>
									<tr>
										<td>
											<xsl:if test="first_name != ''"><xsl:value-of select="first_name"/>&#160;</xsl:if><xsl:value-of select="last_name"/>
										</td>
									</tr>
									<tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
									<tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
									<xsl:if test="string-length(user_address_list/user_address/line3)!=0">
										<tr><td><xsl:value-of select="user_address_list/user_address/line3"/></td></tr>
									</xsl:if>
									<xsl:if test="string-length(user_address_list/user_address/line4)!=0">
									<tr><td><xsl:value-of select="user_address_list/user_address/line4"/></td></tr>
									</xsl:if>
									<tr><td>
										<xsl:value-of select="user_address_list/user_address/postal_code"/>&#160;<xsl:value-of select="user_address_list/user_address/city"/>
									</td></tr>
									<tr><td>
										<xsl:choose>
											<xsl:when test="user_address_list/user_address/country = 'Null'">
											<xsl:text> </xsl:text>
											</xsl:when>
											<xsl:when test="user_address_list/user_address/country = 'CHE'">
											<xsl:text> </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												&#160;<xsl:value-of select="user_address_list/user_address/country"/>
											</xsl:otherwise>
										</xsl:choose>
									</td></tr>
								</table>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</td>
				<!-- sender -->
				<td width="50%" align="left" style="padding: 10mm 10mm 10mm 15mm;">
					<xsl:for-each select="/notification_data/phys_item_display/owning_library_details">
						<table>
						<xsl:attribute name="style">
							font-size: 80%;
							<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
						</xsl:attribute>
							<tr><td><xsl:value-of select="address1"/></td></tr>
							<tr><td><xsl:value-of select="address2"/></td></tr>
							<xsl:if test="string-length(address3)!=0">
								<tr><td><xsl:value-of select="address3"/></td></tr>
							</xsl:if>
							<xsl:if test="string-length(address4)!=0">
								<tr><td><xsl:value-of select="address4"/></td></tr>
							</xsl:if>
							<xsl:if test="string-length(address5)!=0">
								<tr><td><xsl:value-of select="address5"/></td></tr>
							</xsl:if>
							<tr><td><xsl:value-of select="postal_code"/>&#160;<xsl:value-of select="city"/></td></tr>
							<xsl:if test="string-length(phone)!=0">  
								<tr><td><xsl:value-of select="phone"/></td></tr> 
							</xsl:if>
							<xsl:if test="string-length(email)!=0">
								<tr><td><xsl:value-of select="email"/></td></tr> 
							</xsl:if>
						</table>
					</xsl:for-each>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template match="/">
		<html>
			<head>
				<xsl:call-template name="generalStyle" />
			</head>
			<body>
				<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
				<xsl:call-template name="head" /> <!-- header.xsl -->
				<div class="messageArea">
					<div class="messageBody">
						<xsl:call-template name="senderReceiver-personal-delivery-left" />
						<br/>
						<br/>
						<table cellspacing="0" cellpadding="5" border="0">
							<tr>
								<td>
									<xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Hello'"/>
										<xsl:with-param name="fr" select="'Bonjour'"/>
										<xsl:with-param name="it" select="'Buongiorno,'"/>
										<xsl:with-param name="de" select="'Guten Tag'"/>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td>
									@@we_sent@@
								</td>
							</tr>
							<!-- <tr>
								<td>
									@@following_details@@ <xsl:value-of select="/notification_data/request/create_date"/>:
								</td>
							</tr> -->
							<tr>
								<td>
									<strong><xsl:value-of select="notification_data/phys_item_display/title" disable-output-escaping="yes"/></strong><br />
									<xsl:value-of select="notification_data/phys_item_display/author"/><br />
									<xsl:value-of select="notification_data/phys_item_display/publication_place"/>:&#160;<xsl:value-of select="notification_data/phys_item_display/publisher"/>,&#160;<xsl:value-of select="notification_data/phys_item_display/publication_date"/><br />
								</td>
							</tr>
							<tr>
								<td>
									<strong><xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Library'"/>
										<xsl:with-param name="fr" select="'Bibliothèque'"/>
										<xsl:with-param name="it" select="'Biblioteca'"/>
										<xsl:with-param name="de" select="'Bibliothek'"/>
									</xsl:call-template>: </strong><xsl:value-of select="/notification_data/phys_item_display/owning_library_name" /> | 
									<xsl:choose>
										<xsl:when test="notification_data/phys_item_display/display_alt_call_numbers != ''">
											<xsl:value-of select="notification_data/phys_item_display/display_alt_call_numbers"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="notification_data/phys_item_display/call_number"/>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<!-- <tr>
								<td>
									<b>@@delivered_to@@: </b>
									<xsl:variable name="deliveryAddressRaw" select="substring-after(notification_data/delivery_address,':')"/>
									<xsl:variable name="length" select="string-length($deliveryAddressRaw)-3"/>
									<xsl:variable name="deliveryAddressComma" select="translate($deliveryAddressRaw, '&#10;', ', ')" />
									<xsl:value-of select="substring($deliveryAddressComma, 2, $length)"/>
								</td>
							</tr> -->	
							<tr>
								<td>
									<b><xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Request date'"/>
										<xsl:with-param name="fr" select="'Date de la demande'"/>
										<xsl:with-param name="it" select="'Data richiesta'"/>
										<xsl:with-param name="de" select="'Bestelldatum'"/>
									</xsl:call-template>: </b><xsl:value-of select="/notification_data/request/create_date" />
								</td>
							</tr>
							<tr>
								<td>
									<b>@@due_date@@: </b><xsl:value-of select="substring(notification_data/due_date,1,10)" />
								</td>
							</tr>
							<!-- Request note -->
							<xsl:if test="/notification_data/request/note != ''">
								<tr>
									<td>
										<b><xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Request note'"/>
											<xsl:with-param name="fr" select="'Note de demande'"/>
											<xsl:with-param name="it" select="'Nota di richiesta'"/>
											<xsl:with-param name="de" select="'Notiz zur Bestellung'"/>
										</xsl:call-template>: </b><xsl:value-of select="/notification_data/request/note" />
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
								<td><br />
								@@sincerely@@<br/>
									<xsl:value-of select="/notification_data/phys_item_display/owning_library_name" />
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
