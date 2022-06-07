<?xml version="1.0" encoding="utf-8"?>
<!-- Resource Sharing Shipping Slip Letter, UBS, 20210225, with courtesy of Brigitte Sacker, UZB -->
<!-- Noetige Anpassungen fuer Druckausgabe in transparenten Klebeumschlag. Kosmetische Anpassungen fuer mehrsprachige Ausgabe, Umnutzug von Label Cc und Bcc -->
<!-- ACHTUNG: fuer Versand von physischen Monografien, q&d. Artikelbestellungen weren via Mybib abgewickelt, A100 einzige RS-Nutzer in Alma. Falls weitere Partner ohne Mybib oder Neulösung Mybib fuer Versand von Artikelbestellungen weitere Anpassungen noetig!!! Stand/Auskunft Brigitte Sprimgmann, 20210301 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">
	<xsl:include href="header.xsl"/>
	<xsl:include href="senderReceiver.xsl"/>
	<xsl:include href="mailReason.xsl"/>
	<xsl:include href="footer.xsl"/>
	<xsl:include href="style.xsl"/>
	<xsl:include href="recordTitle.xsl"/>
	<!-- -->
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
			<xsl:with-param name="line" select="notification_data/incoming_request/external_request_id"/>
			<xsl:with-param name="label" select="'Bibliographic Information:'"/>
		</xsl:call-template>
	</xsl:template>
	<!-- -->
	<xsl:template match="/">
		<html>
			<head>
				<xsl:call-template name="generalStyle"/>
			</head>
			<body style="font-family:sans-serif">
				<!-- Style Anweisung fuer body ev. noetig, weil Anpassung style.xsl durch IZ von SLSP noch offen, 20200929 -->
				<div style="max-height: 285mm; max-width: 200mm; padding: 5mm;">
					<div class="messageArea">
						<div class="messageBody">
							<!-- Adressblock -->
							<div id="top" style="position:relative; margin-top: 10mm; margin-bottom: 10mm;">
								<table width="100%">
									<tr>
										<td width="40%" align="left" valign="top">
											<i>
												<xsl:text>Absender:</xsl:text>
												<br/>
												<xsl:value-of select="/notification_data/item/owning_library_details/address1"/>
												<br/>
												<xsl:value-of select="/notification_data/item/owning_library_details/address2"/>
												<br/>
												<xsl:if test="string-length(notification_data/item/owning_library_details/address3)!=0">
													<xsl:value-of select="notification_data/item/owning_library_details/address3"/>
													<br/>
												</xsl:if>
												<xsl:if test="string-length(notification_data/item/owning_library_details/address4)!=0">
													<xsl:value-of select="notification_data/item/owning_library_details/address4"/>
													<br/>
												</xsl:if>
												<xsl:if test="string-length(notification_data/item/owning_library_details/address5)!=0">
													<xsl:value-of select="notification_data/item/owning_library_details/address5"/>
													<br/>
												</xsl:if>
												<xsl:value-of select="/notification_data/item/owning_library_details/postal_code"/>&#160;<xsl:value-of select="/notification_data/item/owning_library_details/city"/>
												<br/>
												<xsl:value-of select="notification_data/phys_item_display/owning_library_details/country_display"/>
											</i>
										</td>
										<td width="15%" align="center">
											<p>&#160; </p>
										</td>
										<td width="35%" align="left">
											<b>
												<xsl:value-of select="/notification_data/partner_shipping_info_list/partner_shipping_info/address1"/>
												<br/>
												<xsl:value-of select="/notification_data/partner_shipping_info_list/partner_shipping_info/address2"/>
												<br/>
												<xsl:if test="string-length(notification_data/partner_shipping_info_list/partner_shipping_info/address3)!=0">
													<xsl:value-of select="notification_data/partner_shipping_info_list/partner_shipping_info/address3"/>
													<br/>
												</xsl:if>
												<xsl:if test="string-length(notification_data/partner_shipping_info_list/partner_shipping_info/address4)!=0">
													<xsl:value-of select="notification_data/partner_shipping_info_list/partner_shipping_info/address4"/>
													<br/>
												</xsl:if>
												<xsl:if test="string-length(notification_data/partner_shipping_info_list/partner_shipping_info/address5)!=0">
													<xsl:value-of select="notification_data/partner_shipping_info_list/partner_shipping_info/address5"/>
													<br/>
												</xsl:if>
												<xsl:value-of select="notification_data/partner_shipping_info_list/partner_shipping_info/postal_code"/>&#160;<xsl:value-of select="notification_data/partner_shipping_info_list/partner_shipping_info/city"/>
												<br/>
												<br/>
												<xsl:value-of select="notification_data/partner_shipping_info_list/partner_shipping_info/country"/>
											</b>
										</td>
									</tr>
								</table>
							</div>
							<!-- Inhalt -->
							<div id="middle" style="position:relative; margin-top: 40mm; margin-bottom: 10mm;">
								<xsl:value-of select="notification_data/general_data/current_date"/>
								<p>&#160; </p>
								<b>@@letterName@@</b>
								<p>&#160; </p>
<!-- 								<p>
									<b>@@my_id@@: </b>
									<img src="externalId.png" alt="externalId"/>
								</p> -->
								<p>
									<p>
										<b>@@borrower_reference@@: </b>
										<xsl:call-template name="id-info-hdr"/>
									</p>
									<p>
										<b>@@title@@: </b>
										<xsl:value-of select="notification_data/metadata/title"/>
									</p>
									<p>
										<b>@@author@@: </b>
										<xsl:value-of select="/notification_data/item/author"/>
									</p>
									<p>
										<b>@@call_number@@: </b>
										<xsl:value-of select="notification_data/item/call_number"/>
									</p>
									<p>
										<!-- Zweckentfremdung Label @@Cc@@. Label fuer Ausgabe Due Date fehlt. Alma sieht default ev. anderes Attribut fuer diese Angabe vor? -->
										<b>@@Cc@@: </b>
										<xsl:value-of select="/notification_data/incoming_request/due_date"/>
									</p>
									<p>
										<b>@@note@@: </b>
										<xsl:value-of select="/notification_data/note_to_partner"/>
									</p>
									<!-- Abschluss mit Grussformel, Zweckentfremdung con @@Bcc@@, da Label Sincerly fehlt -->
									<p>&#160; </p>
									<p>@@Bcc@@</p>
									<p>
										<xsl:value-of select="/notification_data/phys_item_display/owning_library_details/name"/>
										<br/>
										<xsl:value-of select="/notification_data/item/owning_library_details/address1"/>
										<br/>
										<xsl:value-of select="/notification_data/item/owning_library_details/address2"/>
										<br/>
										<xsl:value-of select="/notification_data/item/owning_library_details/email"/>
									</p>
								</p>
							</div>
							<!-- -->
							<!-- -->
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
