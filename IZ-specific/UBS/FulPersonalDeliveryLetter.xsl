<?xml version="1.0" encoding="utf-8"?>
<!-- Ful Personal Delivery Letter, UBS, 20201207 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">
	<xsl:include href="header.xsl"/>
	<xsl:include href="senderReceiver.xsl"/>
	<xsl:include href="mailReason.xsl"/>
	<xsl:include href="footer.xsl"/>
	<xsl:include href="style.xsl"/>
	<xsl:include href="recordTitle.xsl"/>
	<xsl:template match="/">
		<html>
			<head>
				<xsl:call-template name="generalStyle"/>
			</head>
			<body style="font-family:sans-serif">
				<!-- Style Anweisung für body ev. nötig, weil Anpassung style.xsl durch IZ von SLSP noch offen, 20200929 -->
				<div style="max-height: 285mm; max-width: 200mm; padding: 5mm;">
					<div class="messageArea">
						<div class="messageBody">
							<div id="top" style="position:relative; margin-top: 10mm; margin-bottom: 10mm;">
								<table width="100%">
									<tr>
										<td width="40%" align="left" valign="top">
											<i>
												<xsl:text>Absender:</xsl:text>
												<br/>
												<xsl:value-of select="/notification_data/phys_item_display/owning_library_details/address1"/>
												<br/>
												<xsl:value-of select="/notification_data/phys_item_display/owning_library_details/address2"/>
												<br/>
												<xsl:if test="string-length(notification_data/phys_item_display/owning_library_details/address3)!=0">
													<xsl:value-of select="notification_data/phys_item_display/owning_library_details/address3"/>
													<br/>
												</xsl:if>
												<xsl:if test="string-length(notification_data/phys_item_display/owning_library_details/address4)!=0">
													<xsl:value-of select="notification_data/phys_item_display/owning_library_details/address4"/>
													<br/>
												</xsl:if>
												<xsl:if test="string-length(notification_data/phys_item_display/owning_library_details/address5)!=0">
													<xsl:value-of select="notification_data/phys_item_display/owning_library_details/address5"/>
													<br/>
												</xsl:if>
												<xsl:value-of select="notification_data/phys_item_display/owning_library_details/postal_code"/>&#160;<xsl:value-of select="notification_data/phys_item_display/owning_library_details/city"/>
												<br/>
												<xsl:value-of select="notification_data/phys_item_display/owning_library_details/country_display"/>
											</i>
										</td>
										<td width="25%" align="center">
											<p>&#160; </p>
										</td>
										<td width="35%" align="left">
											<b>
												<xsl:value-of select="notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="notification_data/user_for_printing/last_name"/>
												<br/>
												<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>4">
													<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[2]"/>
													<br/>
												</xsl:if>
												<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>5">
													<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[3]"/>
													<br/>
												</xsl:if>
												<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>6">
													<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[4]"/>
													<br/>
												</xsl:if>
												<xsl:if test="count(str:tokenize(notification_data/delivery_address,'&#10;'))>7">
													<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[5]"/>
													<br/>
												</xsl:if>
												<xsl:variable name="number_code" select="count(str:tokenize(notification_data/delivery_address,'&#10;'))-1"/>
												<xsl:variable name="number_city" select="count(str:tokenize(notification_data/delivery_address,'&#10;'))-2"/>
												<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[$number_code]"/>&#160;
												<xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[$number_city]"/>
											</b>
										</td>
									</tr>
								</table>
							</div>
							<!-- -->
							<div id="middle" style="position:relative; margin-top: 60mm; margin-bottom: 10mm;">
								<xsl:value-of select="notification_data/general_data/current_date"/>
								<p>&#160; </p>
								<b>@@letterName@@</b>
								<p>&#160; </p>
								@@we_sent@@
								<p>&#160; </p>
								<b>@@following_details@@ <xsl:value-of select="notification_data/request/create_date"/>
								</b>
								<p>
									<xsl:value-of select="notification_data/phys_item_display/title"/>
									<br/>
									<xsl:value-of select="notification_data/phys_item_display/author"/>
									<br/>
									<xsl:value-of select="notification_data/phys_item_display/imprint"/>
								</p>
								<p>
									<xsl:value-of select="//notification_data/phys_item_display/call_number"/>&#160;|&#160;<xsl:value-of select="/notification_data/phys_item_display/location_name"/>&#160;|&#160;<xsl:value-of select="/notification_data/phys_item_display/library_name"/>
								</p>
								<p>&#160; </p>
								<p>
									<b>@@due_date@@: <xsl:value-of select="substring(notification_data/due_date,1,10)"/>
									</b>
								</p>
								<p>&#160; </p>
								<p>@@sincerely@@</p>
								<p>
									<xsl:value-of select="/notification_data/phys_item_display/owning_library_details/name"/>
								</p>
							</div>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>