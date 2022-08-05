<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP version 07/2022
		07/2022 - added Hello
		07/2022 - loans by library
		07/2022 - layout as overdue letter -->
<!-- Dependance:
		header - head
		senderReceiver - senderReceiver
		style - generalStyle, bodyStyleCss, mainTableStyleCss
		recordTitle - SLSP-multilingual -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<xsl:template match="/">
<html>
	<xsl:if test="notification_data/languages/string">
		<xsl:attribute name="lang">
			<xsl:value-of select="notification_data/languages/string"/>
		</xsl:attribute>
	</xsl:if>
	<head>
		<title>
			<xsl:value-of select="notification_data/general_data/subject"/>
		</title>
		<xsl:call-template name="generalStyle" />
	</head>
	<body>
		<xsl:attribute name="style">
			<xsl:call-template name="bodyStyleCss" />;font-size: 100%;<!-- style.xsl -->
		</xsl:attribute>

		<xsl:call-template name="head" /><!-- header.xsl -->
		<xsl:if test="notification_data/user_for_printing/user_group = '92' or notification_data/notification_type = 'OverdueNotificationType4'">
			<xsl:call-template name="senderReceiver" />
		</xsl:if>
		<div id="user-additional-info" align="left">
			<p>
				<!-- set the Barcode NZ, if there are more then only first one is returned -->
				<xsl:variable name="NZ_barcode">
					<xsl:value-of select="notification_data/user_for_printing/identifiers/code_value[code='02']/value"/>
				</xsl:variable>
				<!-- set the Barcode edu-ID, if there are more then only first one is returned -->
				<xsl:variable name="edu-id_barcode">
					<xsl:value-of select="notification_data/user_for_printing/identifiers/code_value[code='01']/value"/>
				</xsl:variable>
				<xsl:value-of select="notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="notification_data/user_for_printing/last_name"/><br />
				<xsl:call-template name="SLSP-multilingual">
					<xsl:with-param name="en" select="'User ID'"/>
					<xsl:with-param name="fr" select="'ID utilisateur'"/>
					<xsl:with-param name="it" select="'ID utente'"/>
					<xsl:with-param name="de" select="'Benutzer-ID'"/>
				</xsl:call-template>:
				<xsl:choose>
					<xsl:when test="$edu-id_barcode != ''">
						<xsl:value-of select="$edu-id_barcode"/><br />
					</xsl:when>
					<xsl:when test="$NZ_barcode != ''">
						<xsl:value-of select="$NZ_barcode"/><br />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="notification_data/user_for_printing/identifiers/code_value[code='Primary Identifier']/value"/>
					</xsl:otherwise>
				</xsl:choose>
			</p>
		</div>
		<p>
			<xsl:call-template name="SLSP-multilingual">
				<xsl:with-param name="en" select="'Hello'"/>
				<xsl:with-param name="fr" select="'Bonjour'"/>
				<xsl:with-param name="it" select="'Buongiorno,'"/>
				<xsl:with-param name="de" select="'Guten Tag'"/>
			</xsl:call-template>
		</p>
		<p>
			<xsl:if test="notification_data/short_loans='true'">
				<strong>@@short_loans_message@@</strong>
			</xsl:if>
			<xsl:if test="notification_data/short_loans='false'">
				<strong>@@message@@</strong>
			</xsl:if>
		</p>
		<table cellpadding="5" width="100%">
			<xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
				<tr>
					<td>
						<table cellpadding="5" class="listing">
							<xsl:attribute name="style">
								<xsl:call-template name="mainTableStyleCss" />
							</xsl:attribute>
							<thead>
								<tr align="left" bgcolor="#f5f5f5">
									<td colspan="3">
										<h3>
											<xsl:value-of select="organization_unit/name" />
										</h3>
										<xsl:if test="organization_unit/address/line1 != ''">
											<xsl:value-of select="organization_unit/address/line1"/>,
										</xsl:if>
										<xsl:if test="organization_unit/address/line2 != ''">
											<xsl:value-of select="organization_unit/address/line2"/>,
										</xsl:if>
										<xsl:if test="organization_unit/address/line3 != ''">
											<xsl:value-of select="organization_unit/address/line3"/>,
										</xsl:if>
										<xsl:if test="organization_unit/address/line4 != ''">
											<xsl:value-of select="organization_unit/address/line4"/>,
										</xsl:if>
										<xsl:if test="organization_unit/address/postal_code != '' or organization_unit/address/city != ''">
											<xsl:value-of select="organization_unit/address/postal_code"/>&#160;<xsl:value-of select="organization_unit/address/city"/>
											<br/>
										</xsl:if>
										<xsl:if test="organization_unit/phone/phone != ''">
											<xsl:value-of select="organization_unit/phone/phone"/>
											<br/>
										</xsl:if>
										<xsl:if test="organization_unit/email/email != ''">
											<xsl:value-of select="organization_unit/email/email"/>
										</xsl:if>
									</td>
								</tr>
								<tr align="left">
									<th>
										@@title@@
									</th>
									<th>
										@@loans@@
									</th>
									<th>
										@@due_date@@
									</th>
								</tr>
							</thead>
							<tbody>
								<xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display">
									<tr>
										<td>
											<xsl:value-of select="substring(item_loan/title, 0, 70)"/>
											<xsl:if test="string-length(item_loan/title) > 70">...</xsl:if>
											<br />
											<strong><xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Barcode'"/>
												<xsl:with-param name="fr" select="'Code-barres'"/>
												<xsl:with-param name="it" select="'Barcode'"/>
												<xsl:with-param name="de" select="'Strichcode'"/>
											</xsl:call-template>: </strong><xsl:value-of select="item_loan/barcode"/>
											<br />
											<strong>@@call_number@@: </strong>
											<xsl:choose>
												<xsl:when test="physical_item_display_for_printing/display_alt_call_numbers != ''">
													<xsl:value-of select="physical_item_display_for_printing/display_alt_call_numbers"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="physical_item_display_for_printing/call_number"/>
												</xsl:otherwise>
											</xsl:choose>
											<br />
											<xsl:if test="physical_item_display_for_printing/issue_level_description !='' and physical_item_display_for_printing/issue_level_description != 'Vol.' and physical_item_display_for_printing/issue_level_description != '_'">
												<strong>@@description@@: </strong>
												<xsl:value-of select="physical_item_display_for_printing/issue_level_description"/>
											</xsl:if>
										</td>
										<td>
											<xsl:value-of select="item_loan/loan_date"/>
										</td>
										<td>
											<xsl:value-of select="item_loan/due_date"/>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<br />
		<p>
			<xsl:call-template name="SLSP-userAccount"/>
		</p>
		
		<p>
			@@additional_info_1@@
		</p>
		<p>
		@@additional_info_2@@
		</p>
		<br />
		<p>
			@@sincerely@@
		</p>
		<p>
			<xsl:value-of select="notification_data/organization_unit/name" />
		</p>
		<p>
			<i>powered by SLSP</i>
		</p>
		<!-- footer.xsl -->
		<!-- <xsl:call-template name="lastFooter" /> -->
	</body>
</html>
</xsl:template>
</xsl:stylesheet>
