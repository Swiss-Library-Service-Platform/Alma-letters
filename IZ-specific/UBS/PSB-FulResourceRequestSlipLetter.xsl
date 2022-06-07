<?xml version="1.0" encoding="utf-8"?>
<!-- Ful Resource Request Slip Letter, UBS, 20210621 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl"/>
	<xsl:include href="senderReceiver.xsl"/>
	<xsl:include href="mailReason.xsl"/>
	<xsl:include href="footer.xsl"/>
	<xsl:include href="style.xsl"/>
	<xsl:include href="recordTitle.xsl"/>
	<xsl:template match="/">
		<xsl:variable name="ipol" select="notification_data/phys_item_display/available_items/available_item/item_policy"/>
		<xsl:variable name="ilib" select="notification_data/phys_item_display/available_items/available_item/library_code"/>
		<!-- -->
		<!--NO PRINT for notification_data/request_type = 'Patron digitization request', only for My BIB operating libraries & some of their item policies -->
		<!-- A100 -->
		<xsl:choose>
			<xsl:when test="($ilib='A100')	and ($ipol='01' or $ipol='06' or $ipol='63')">
				<xsl:if test="notification_data/request_type = 'Patron digitization request'">
					<xsl:message terminate="yes">this is mybib edoc request!</xsl:message>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- just do nothing -->
			</xsl:otherwise>
		</xsl:choose>
		<!-- A125 -->
		<!-- 		<xsl:choose>
			<xsl:when test="($ilib='A125') and ($ipol='01' or $ipol='02' or $ipol='06' or $ipol='62' or $ipol='63')">
				<xsl:if test="notification_data/request_type = 'Patron digitization request'">
					<xsl:message terminate="yes">this is a mybib edoc request!</xsl:message>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise> -->
		<!-- just do nothing -->
		<!-- 			</xsl:otherwise>
		</xsl:choose> -->
		<!-- A130 -->
		<xsl:choose>
			<xsl:when test="($ilib='A130')	and ($ipol='01' or $ipol='06' or $ipol='63')">
				<xsl:if test="notification_data/request_type = 'Patron digitization request'">
					<xsl:message terminate="yes">this is mybib edoc request!</xsl:message>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- just do nothing -->
			</xsl:otherwise>
		</xsl:choose>
		<!-- A140 -->
		<xsl:choose>
			<xsl:when test="($ilib='A140') and ($ipol='01' or $ipol='02' or $ipol='06' or $ipol='21' or $ipol='23' or $ipol='62' or $ipol='63')">
				<xsl:if test="notification_data/request_type = 'Patron digitization request'">
					<xsl:message terminate="yes">this is a mybib edoc request!</xsl:message>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- just do nothing -->
			</xsl:otherwise>
		</xsl:choose>
		<!-- -->
		<!-- -->
		<html>
			<head>
				<xsl:call-template name="generalStyle"/>
			</head>
			<body style="font-family:sans-serif">
				<div style="position:static; max-height: 290mm; max-width: 200mm; padding: 5mm;">
					<!-- -->
					<div id="top" style="position:absolute; top: 0; width: 100%;">
						<table>
							<tr>
								<xsl:value-of select="/notification_data/general_data/current_date"/>
							</tr>
							<tr>
								<h2>
									<xsl:value-of select="notification_data/user_for_printing/name"/>
									<br/>=> <xsl:value-of select="notification_data/destination"/>
								</h2>
							</tr>
						</table>
					</div>
					<!-- -->
					<div id="block1" style="position:relative; margin-top: 30mm; margin-bottom: 5mm;">
						<table cellspacing="0" cellpadding="5" border="0" width="100%" valign="top">
							<tr>
								<td width="55%" align="left" valign="top">
									<h3>
										<xsl:value-of select="/notification_data/phys_item_display/location_name"/>
									</h3>
									<h3>
										<xsl:choose>
											<xsl:when test="/notification_data/phys_item_display/display_alt_call_numbers !=''">
												<xsl:value-of select="/notification_data/phys_item_display/display_alt_call_numbers"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="/notification_data/phys_item_display/call_number"/>
											</xsl:otherwise>
										</xsl:choose>
										<br/>
									</h3>
									<xsl:if test="notification_data/phys_item_display/issue_level_description !=''">
										<xsl:value-of select="notification_data/phys_item_display/issue_level_description"/>
										<br/>
									</xsl:if>
									<xsl:if test="notification_data/request/manual_description != ''">
										<xsl:value-of select="notification_data/request/manual_description"/>
									</xsl:if>
								</td>
								<td width="5%"></td>
								<td width="40%" align="left" valign="top">
									<xsl:if test="/notification_data/phys_item_display/barcode !=''">
										<!-- 										<b>@@item_barcode@@ </b> Falls kein png, wird nur Bezeichnung als verwirrend empfunden, 3FBeschluss 20210429 ganz weglassen-->
										<br/>
										<br/>
										<img src="cid:item_id_barcode.png" alt="Item Barcode"/>
									</xsl:if>
								</td>
							</tr>
						</table>
						<p>
							<br/>
							<b>
								<xsl:value-of select="/notification_data/phys_item_display/author"/>
								<br/>
								<xsl:value-of select="/notification_data/phys_item_display/title"/>
								<br/>
								<xsl:value-of select="/notification_data/phys_item_display/imprint"/>
							</b>
						</p>
					</div>
					<!-- -->
					<div id="block2" style="position:relative; margin-top: 10mm; margin-bottom: 5mm;">
						<table cellspacing="0" cellpadding="5" border="0" width="100%" valign="top">
							<tr>
								<td width="55%" align="left" valign="top">
									<b>@@please_note@@</b>
									<br/>
									<br/>
									-&#160;<xsl:value-of select="/notification_data/request_type"/> => Item policy = <xsl:value-of select="$ipol"/>
									<br/>
									<br/>
									<xsl:if test="notification_data/phys_item_display/fulfillment_note != ''">
										-&#160;<xsl:value-of select="notification_data/phys_item_display/fulfillment_note"/>
										<br/>
									</xsl:if>
									<xsl:if test="notification_data/request/manual_description != ''">
										-&#160;<xsl:value-of select="notification_data/request/manual_description"/>
										<br/>
									</xsl:if>
									<xsl:if test="notification_data/request/system_notes != ''">
										-&#160;@@system_notes@@:&#160;<xsl:value-of select="notification_data/request/system_notes"/>
										<br/>
									</xsl:if>
									<xsl:if test="notification_data/request/note != ''">
										-&#160;@@request_note@@:&#160;<xsl:value-of select="notification_data/request/note"/>
									</xsl:if>
								</td>
								<td width="5%"></td>
								<td width="40%" align="left" valign="top">
									<b>@@request_id@@ </b>
									<br/>
									<br/>
									<img src="cid:request_id_barcode.png" alt="Request Barcode"/>
									<br/>
								</td>
							</tr>
						</table>
					</div>
					<!--  -->
					<div id="block3" style="position:relative; margin-top: 10mm; margin-bottom: 5mm;">
						<p>
							<xsl:text>Beleg Datum, Zeit:  </xsl:text>
							<xsl:value-of select="/notification_data/request/create_date"/>, <xsl:value-of select="substring(/notification_data/request/create_time,1,5)"/>
							<br/>
							<br/>
							<xsl:text>____  nicht am Standort   </xsl:text>
							<i>
								<xsl:value-of select="notification_data/phys_item_display/location_name"/>
							</i>
							<br/>
							<br/>
						</p>
						<table cellspacing="0" cellpadding="5" border="0" width="100%">
							<tr>
								<td width="55%" align="left" valign="top">
									<b>
										<xsl:value-of select="notification_data/user_for_printing/name"/>
									</b>
								</td>
								<td width="5%">
								</td>
								<td width="40%" align="left" valign="top">
									<xsl:for-each select="notification_data/user_for_printing/identifiers/code_value">
										<xsl:if test="code='02'">
											<b>
												<xsl:text>User Barcode</xsl:text>
											</b>
										</xsl:if>
									</xsl:for-each>
								</td>
							</tr>
							<tr>
								<td width="55%" align="left" valign="top">
									<p>
										<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value/value"/>&#160;&#160;<i>(PID)</i>
									</p>
									<p>
										<xsl:value-of select="/notification_data/user_for_printing/user_group"/>&#160;&#160;<i>(User Group Code)</i>
									</p>
								</td>
								<td width="5%">
								</td>
								<td width="40%" valign="top">
									<!-- Identifiers -->
									<xsl:variable name="uident1" select="notification_data/user_for_printing/identifiers/code_value/code[text()='03']/following-sibling::value"/>
									<xsl:variable name="uident2" select="notification_data/user_for_printing/identifiers/code_value/code[text()='01']/following-sibling::value"/>
									<xsl:variable name="uident3" select="notification_data/user_for_printing/identifiers/code_value/code[text()='02']/following-sibling::value"/>
									<!-- Ausgabe: Druck nur genau einmal, gemaess Reihenfolge oben. Fallback PID als HEX zu lang, waere analog ZBZ -> <xsl:variable name="uident4" select="notification_data/user_for_printing/identifiers/code_value/code[text()='Primary Identifier']/following-sibling::value"/> -->
									<xsl:choose>
										<xsl:when test="string-length(normalize-space($uident1)) != 0">
											<span style="font-family:'Libre Barcode 39 Text'; font-style:normal; font-size:24pt; line-height:48pt;">*<xsl:value-of select="$uident1"/>*</span>
										</xsl:when>
										<xsl:when test="string-length(normalize-space($uident2)) != 0">
											<span style="font-family:'Libre Barcode 39 Text'; font-style:normal; font-size:24pt; line-height:48pt;">*<xsl:value-of select="$uident2"/>*</span>
										</xsl:when>
										<xsl:when test="string-length(normalize-space($uident3)) != 0">
											<span style="font-family:'Libre Barcode 39 Text'; font-style:normal; font-size:24pt; line-height:48pt;">*<xsl:value-of select="$uident3"/>*</span>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>Kein Barcode (IZ/edu-ID/NZ) hinterlegt</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</table>
					</div>
					<!-- -->
					<div id="bottom" style="position: absolute; top:250mm; width: 100%;">
						<table>
							<tr>
								<xsl:value-of select="/notification_data/general_data/current_date"/>
							</tr>
							<tr>
								<h2>
									<xsl:value-of select="notification_data/user_for_printing/name"/>
									<br/>=> <xsl:value-of select="notification_data/destination"/>
								</h2>
							</tr>
						</table>
					</div>
				</div>
				<!-- -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>