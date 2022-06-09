<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP version 05/2022
	04/2022 rapido: Added due date for requests other then Personal delivery
	04/2022 rapido: Request types
	05/2022 rapido: formatting as transit letter - address and logo shows up only for ILL and Personal delivery
	05/2022 rapido: Added note to partner and author
	05/2022 rapido: Added shipping cost for Personal Delivery
	05/2022 rapido: Added notice for Reading room Pod
	06/2022 rapido: fix receiver address country-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="counter" select="0"/>
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<xsl:template name="id-info">
	<xsl:param name="line"/>
	<xsl:variable name="first" select="substring-before($line,'//')"/>
	<xsl:variable name="rest" select="substring-after($line,'//')"/>
	<xsl:if test="$first = '' and $rest = '' ">
		<!--br/-->
	</xsl:if>
	<xsl:if test="$rest != ''">
		<xsl:value-of select="$rest"/>
		<br/>
	</xsl:if>
	<xsl:if test="$rest = ''">
		<xsl:value-of select="$line"/>
		<br/>
	</xsl:if>
</xsl:template>

<xsl:template name="id-info-hdr">
	<xsl:call-template name="id-info">
		<xsl:if test="notification_data/incoming_request/rapidr_external_request_id!=''">
			<xsl:with-param name="line" select="notification_data/incoming_request/external_request_id"/>
		</xsl:if>
		<xsl:if test="notification_data/incoming_request/rapidr_external_request_id=''">
			<xsl:with-param name="line" select="notification_data/incoming_request/external_request_id"/>
		</xsl:if>
		<xsl:with-param name="label" select="'Bibliographic Information:'"/>
	</xsl:call-template>
</xsl:template>

<!-- Transit header without logo and letter date-->
<xsl:template name="head-letterName-only">
	<xsl:variable name="requestType">
		<xsl:call-template name="request-type" />
	</xsl:variable>
	<table cellspacing="0" cellpadding="5" border="0">
        <!-- overloading the height parameter to overwrite the style -->
		<xsl:attribute name="style">
			<xsl:call-template name="headerTableStyleCss" />; height: 35mm;
		</xsl:attribute>
		<tr>
		<xsl:attribute name="style">
			<xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>
			<td>
				<span style="font-size: 160%; font-weight: bold">&#x21e8;
				<xsl:choose>
					<xsl:when test="$requestType = 'Personal Delivery'">
						<xsl:value-of select="$requestType" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="notification_data/partner_name" />
					</xsl:otherwise>
				</xsl:choose>
				</span>
			</td>
		</tr>
		<tr>
			<xsl:for-each select="notification_data/general_data">
				<td>
					<h1><xsl:value-of select="subject"/></h1>
				</td>
			</xsl:for-each>
		</tr>
	</table>
	
	<!-- <span style="background-color:#e9e9e9; width:100%; height:30px; line-height: 30px; margin: 0 15 5 0;" id="head-letter-name">
		<span style="font-size: 170%; vertical-align: middle; text-shadow:1px 1px 1px #fff;">@@letterName@@</span>
	</span> -->
</xsl:template>

<!-- Transit header with logo and without print date-->
<xsl:template name="head-letterName-logo">
	<xsl:variable name="requestType">
		<xsl:call-template name="request-type" />
	</xsl:variable>
	<table cellspacing="0" cellpadding="5" border="0">
        <!-- overloading the height parameter to overwrite the style -->
		<xsl:attribute name="style">
			<xsl:call-template name="headerTableStyleCss" />; height: 35mm;
		</xsl:attribute>
		<tr>
		<xsl:attribute name="style">
			<xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>
			<td>
				<div id="mailHeader">
					<div id="logoContainer" class="alignLeft">
						<!-- SLSP: fixed height of logo -->
						<img onerror="this.src='/infra/branding/logo/logo-email.png'" src="cid:logo.jpg" alt="logo" style="height:20mm"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<xsl:for-each select="notification_data/general_data">
				<td>
					<h1><xsl:value-of select="subject"/></h1>
				</td>
			</xsl:for-each>
		</tr>
	</table>
	
	<!-- <span style="background-color:#e9e9e9; width:100%; height:30px; line-height: 30px; margin: 0 15 5 0;" id="head-letter-name">
		<span style="font-size: 170%; vertical-align: middle; text-shadow:1px 1px 1px #fff;">@@letterName@@</span>
	</span> -->
</xsl:template>

<!-- Special senderReceiver to extract the Rapido partner information -->
<xsl:template name="senderReceiver-shippingSlip">
	<table width="100%">
		<tr>
			<!-- Sender -->
			<td width="50%" align="left" valign="top" style="padding: 10mm 10mm 10mm 10mm;">
				<xsl:for-each select="/notification_data/item/owning_library_details">
					<table>
						<xsl:attribute name="style">
							font-size: 80%;
							<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
						</xsl:attribute>
						<xsl:if test="string-length(address1)!=0">
							<tr><td><xsl:value-of select="address1"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address2)!=0">
							<tr><td><xsl:value-of select="address2"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address3)!=0">
							<tr><td><xsl:value-of select="address3"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address4)!=0">
							<tr><td><xsl:value-of select="address4"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address5)!=0">
							<tr><td><xsl:value-of select="address5"/></td></tr>
						</xsl:if>
						<tr><td><xsl:value-of select="/notification_data/item/owning_library_details/postal_code"/>&#160;<xsl:value-of select="/notification_data/item/owning_library_details/city"/></td></tr>
						<xsl:if test="country != ''">
							<tr><td><xsl:value-of select="country"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(phone)!=0">
							<tr><td><xsl:value-of select="phone"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(email)!=0">
							<tr><td><xsl:value-of select="email"/></td></tr>
						</xsl:if>
					</table>
				</xsl:for-each>
			</td>
			<!-- Receiver -->
			<td width="50%" align="left" style="padding: 10mm 10mm 10mm 15mm; vertical-align: top;">
				<table cellspacing="0" cellpadding="0" border="0">
					<xsl:attribute name="style">
						font-weight: 600;
						<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
					</xsl:attribute>
					<xsl:for-each select="/notification_data/partner_shipping_info_list/partner_shipping_info">
						<xsl:if test="/notification_data/incoming_request/rapido_delivery_option='homeDelivery' or /notification_data/incoming_request/rapido_delivery_option='officeDelivery'">
							<tr><td><xsl:value-of select="/notification_data/partner_name"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address1)!=0">
							<tr><td><xsl:value-of select="address1"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address2)!=0">
							<tr><td><xsl:value-of select="address2"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address3)!=0">
							<tr><td><xsl:value-of select="address3"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address4)!=0">
							<tr><td><xsl:value-of select="address4"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address5)!=0">
							<tr><td><xsl:value-of select="address5"/></td></tr>
						</xsl:if>
						<xsl:if test="postal_code != '' or city != ''">
							<tr><td>
								<xsl:if test="postal_code != ''">
									<xsl:value-of select="postal_code"/>
								</xsl:if>
								<xsl:if test="city != ''">
									&#160;<xsl:value-of select="city"/>
								</xsl:if>
							</td></tr>
						</xsl:if>
						<!-- <tr><td><xsl:value-of select="postal_code"/>&#160;<xsl:value-of select="city"/></td></tr> -->
						<xsl:if test="country != ''">
							<tr><td><xsl:value-of select="country"/></td></tr>
						</xsl:if>
					</xsl:for-each>
				</table>
			</td>
		</tr>
	</table>
</xsl:template>

<!-- Special senderReceiver to extract the Rapido partner information
	Delivery on the left side -->
<xsl:template name="senderReceiver-shippingSlip-reversed">
	<table width="100%">
		<tr>
			<!-- Receiver -->
			<td width="50%" align="left" style="padding: 10mm 10mm 10mm 20mm;vertical-align: top;">
				<table cellspacing="0" cellpadding="0" border="0">
					<xsl:attribute name="style">
						font-weight: 600;
					</xsl:attribute>
					<xsl:for-each select="/notification_data/partner_shipping_info_list/partner_shipping_info">
						<xsl:if test="/notification_data/incoming_request/rapido_delivery_option='homeDelivery' or /notification_data/incoming_request/rapido_delivery_option='officeDelivery'">
							<tr><td><xsl:value-of select="/notification_data/partner_name"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address1)!=0">
							<tr><td><xsl:value-of select="address1"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address2)!=0">
							<tr><td><xsl:value-of select="address2"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address3)!=0">
							<tr><td><xsl:value-of select="address3"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address4)!=0">
							<tr><td><xsl:value-of select="address4"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address5)!=0">
							<tr><td><xsl:value-of select="address5"/></td></tr>
						</xsl:if>
						<xsl:if test="postal_code != '' or city != ''">
							<tr><td>
								<xsl:if test="postal_code != ''">
									<xsl:value-of select="postal_code"/>
								</xsl:if>
								<xsl:if test="city != ''">
									&#160;<xsl:value-of select="city"/>
								</xsl:if>
							</td></tr>
						</xsl:if>
						<!-- <tr><td><xsl:value-of select="postal_code"/>&#160;<xsl:value-of select="city"/></td></tr> -->
						<xsl:if test="country != ''">
							<tr><td><xsl:value-of select="country"/></td></tr>
						</xsl:if>
					</xsl:for-each>
				</table>
			</td>
			<!-- Sender -->
			<td width="50%" align="left" valign="top" style="padding: 10mm 10mm 10mm 10mm;vertical-align: top;">
				<xsl:for-each select="/notification_data/item/owning_library_details">
					<table>
						<xsl:attribute name="style">
							font-size: 80%;
							<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
						</xsl:attribute>
						<xsl:if test="string-length(address1)!=0">
							<tr><td><xsl:value-of select="address1"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address2)!=0">
							<tr><td><xsl:value-of select="address2"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address3)!=0">
							<tr><td><xsl:value-of select="address3"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address4)!=0">
							<tr><td><xsl:value-of select="address4"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address5)!=0">
							<tr><td><xsl:value-of select="address5"/></td></tr>
						</xsl:if>
						<tr><td><xsl:value-of select="/notification_data/item/owning_library_details/postal_code"/>&#160;<xsl:value-of select="/notification_data/item/owning_library_details/city"/></td></tr>
						<xsl:if test="country != ''">
							<tr><td><xsl:value-of select="country"/></td></tr>
						</xsl:if>
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

<!-- Template to return type of the request
	Possible request types:
		- ILL
		- Rapido - Courier
		- Rapido - Home / Office Delivery -->
<xsl:template name="request-type">
	<xsl:for-each select="/notification_data/incoming_request">
		<xsl:choose>
			<xsl:when test="rapido_request='false'">ILL</xsl:when><!-- ILL -->
			<xsl:when test="rapido_request='true'"><!-- Rapido-->
				<!-- Courier / Local Courier -->
				<xsl:if test="rapido_delivery_option=''">SLSP Courier / Local Courier</xsl:if>
				<!-- Rapido personal deliery -->
				<xsl:if test="rapido_delivery_option='homeDelivery' or rapido_delivery_option='officeDelivery'">Personal Delivery</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:for-each>
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
			<div class="messageArea">
				<div class="messageBody">
					<xsl:variable name="requestType">
						<xsl:call-template name="request-type" />
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="$requestType = 'SLSP Courier / Local Courier'">
							<xsl:call-template name="head-letterName-only" />
						</xsl:when>
						<xsl:otherwise><!-- ILL and Personal delivery -->
							<xsl:call-template name="head-letterName-logo" />
							<xsl:call-template name="senderReceiver-shippingSlip" />
						</xsl:otherwise>
					</xsl:choose>
					<table cellspacing="0" cellpadding="5" border="0">
						<tr>
							<td>
								<strong>
									<xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'From'"/>
										<xsl:with-param name="fr" select="'De'"/>
										<xsl:with-param name="it" select="'Da'"/>
										<xsl:with-param name="de" select="'Von'"/>
									</xsl:call-template>: </strong>
								<xsl:value-of select="notification_data/organization_unit/name"/> - <xsl:value-of select="notification_data/item/library_name"/><br />
								<xsl:value-of select="notification_data/incoming_request/format"/> - <xsl:value-of select="$requestType"/>
								<!-- SLSP: Add reading room note if reading room pod id -->
								<!-- <xsl:if test="/notification_data/incoming_request/pod_id = '377067383680000041'">
									<br /><strong><xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Only for reading room'"/>
										<xsl:with-param name="fr" select="'Seulement en salle de lecture'"/>
										<xsl:with-param name="it" select="'Solo in sala lettura'"/>
										<xsl:with-param name="de" select="'Nur im Lesesaal'"/>
									</xsl:call-template></strong>
								</xsl:if> -->
							</td>
						</tr>
						<!-- Show externalID in ILL requests -->
						<xsl:if test="$requestType = 'ILL'">
							<tr>
								<td>
									<strong>@@my_id@@:</strong><br/>
									<img src="externalId.png" alt="externalId" />
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="notification_data/group_qualifier != ''" >
							<tr>
								<td>
									<strong>@@group_qualifier@@: </strong><br/>
									<img src="group_qualifier.png" alt="group_qualifier" />
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="notification_data/item">
							<tr>
								<td>
									<strong>@@item_barcode@@:</strong><br/>
									<img src="Barcode1.png" alt="Barcode1" />
								</td>
							</tr>
						</xsl:if>
						<tr>
							<td>
								<strong><xsl:call-template name="SLSP-multilingual">
									<xsl:with-param name="en" select="'Request date'"/>
									<xsl:with-param name="fr">
										<![CDATA[Date de la demande]]>
									</xsl:with-param>
									<xsl:with-param name="it" select="'Data richiesta'"/>
									<xsl:with-param name="de" select="'Bestelldatum'"/>
								</xsl:call-template>: </strong> <xsl:value-of select="notification_data/incoming_request/create_date"/>, <xsl:value-of select="substring(/notification_data/incoming_request/create_date_with_time_str,12,5)"/><br />
								<strong><xsl:call-template name="SLSP-multilingual">
									<xsl:with-param name="en" select="'Print date'"/>
									<xsl:with-param name="fr">
										<![CDATA[Date d'impression]]>
									</xsl:with-param>
									<xsl:with-param name="it" select="'Data stampa'"/>
									<xsl:with-param name="de" select="'Druckdatum'"/>
								</xsl:call-template>: </strong><xsl:value-of select="notification_data/general_data/current_date"/>&#160;<xsl:value-of select="substring(/notification_data/general_data/current_time, 1, 5)"/><br />
								<xsl:if test="$requestType != 'Personal Delivery'">
									<strong>
										<xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Due date'"/>
											<xsl:with-param name="fr" select="'Date de retour'"/>
											<xsl:with-param name="it" select="'Data di scadenza'"/>
											<xsl:with-param name="de" select="'Fälligkeitsdatum'"/>
										</xsl:call-template>: </strong>
									<xsl:choose>
										<xsl:when test="notification_data/incoming_request/due_date != ''">
											<xsl:value-of select="notification_data/incoming_request/due_date"/>
										</xsl:when>
										<xsl:otherwise>
											&#8212;
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
							</td>
						</tr>
						<xsl:if test="notification_data/incoming_request/note != ''" >
							<tr>
								<td>
									<b>@@request_note@@: </b>
									<xsl:value-of select="notification_data/incoming_request/note"/>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="notification_data/incoming_request/note_to_partner != ''" >
							<tr>
								<td>
									<b>@@note@@: </b>
									<xsl:value-of select="notification_data/incoming_request/note_to_partner"/>
								</td>
							</tr>
						</xsl:if>
						<tr>
							<td>
								<span style="font-size: 120%; font-weight: bold">
									<xsl:value-of select="substring(notification_data/metadata/title, 0, 100)" disable-output-escaping="yes"/>
									<xsl:if test="string-length(notification_data/metadata/title) > 100">...</xsl:if></span><br />
								<xsl:choose>
									<xsl:when test="notification_data/metadata/author != ''">
										<xsl:value-of select="notification_data/metadata/author"/><br />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="notification_data/metadata/additional_person_name"/><br />
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="notification_data/item/material_type != ''">
									<xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Material Type'"/>
											<xsl:with-param name="fr">
											<![CDATA[Type de matériel]]>
											</xsl:with-param>
											<xsl:with-param name="it" select="'Tipo di materiale'"/>
											<xsl:with-param name="de" select="'Materialart'"/>
										</xsl:call-template>: <xsl:value-of select="notification_data/item/material_type" /> <br />
								</xsl:if>
								<xsl:if test="notification_data/metadata/volume != ''">
									@@volume@@: <xsl:value-of select="notification_data/metadata/volume"/><br />
								</xsl:if>
								<xsl:if test="notification_data/metadata/issue != ''">
									@@issue@@: <xsl:value-of select="notification_data/metadata/issue"/><br />
								</xsl:if>
								<xsl:value-of select="notification_data/item/owning_library_name"/> | 
								<xsl:value-of select="notification_data/item/call_number"/>
								<xsl:if test="$requestType = 'Personal Delivery' and notification_data/incoming_request/shipping_cost/sum != ''">
									<br /><strong>
										<xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Shipping cost'"/>
											<xsl:with-param name="fr">
											<![CDATA[Frais d'expédition]]>
											</xsl:with-param>
											<xsl:with-param name="it" select="'Costo di spedizione'"/>
											<xsl:with-param name="de" select="'Versandkosten'"/>
										</xsl:call-template>: </strong><xsl:value-of select="/notification_data/incoming_request/shipping_cost/currency"/>&#160;<xsl:value-of select="/notification_data/incoming_request/shipping_cost/sum"/>
								</xsl:if>
							</td>
						</tr>
						<!-- <tr>
							<td>
								<b>@@borrower_reference@@: </b>
								<xsl:call-template name="id-info-hdr"/>
							</td>
						</tr> -->
						<!-- <xsl:if test="notification_data/qualifier != ''" >
							<tr>
								<td>
									<b>@@qualifier@@: </b>
									<img src="qualifier.png" alt="qualifier" />
								</td>
							</tr>
						</xsl:if> -->
						
						<!-- <tr>
							<td>
								<b>@@format@@: </b>
								<xsl:value-of select="notification_data/incoming_request/format"/>
							</td>
						</tr> -->
						<tr>
							<td>
							<span style="font-size: 120%; font-weight: bold">@@borrower_reference@@</span>
							</td>
						</tr>
						<xsl:if test="notification_data/incoming_request/requester_email" >
							<tr>
								<td>
									<xsl:value-of select="/notification_data/partner_name"/><br />
									<xsl:value-of select="notification_data/incoming_request/requester_email"/>
								</td>
							</tr>
						</xsl:if>
					</table>
				</div>
			</div>
			<!-- <xsl:call-template name="lastFooter" /> -->
			<!-- footer.xsl -->
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>