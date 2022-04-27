<?xml version="1.0" encoding="utf-8"?>
<!-- WG: Letters 05/2022 -->
<!-- Dependance:
		recordTitle - SLSP-multilingual, SLSP-userAccount
		style - generalStyle, bodyStyleCss, mainTableStyleCss
		header - head
		-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">

	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="footer.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="recordTitle.xsl" />

	<xsl:template match="/">
	<html>
		<head>
			<xsl:call-template name="generalStyle" />
		</head>
		<body>
		<xsl:attribute name="style">
			<xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
		</xsl:attribute>

		<xsl:call-template name="head" /><!-- header.xsl -->
		<!-- <xsl:call-template name="senderReceiver" />  --><!-- SenderReceiver.xsl -->
		<div class="messageArea">
		<div class="messageBody">
			<table cellspacing="0" cellpadding="5" border="0">
				<xsl:for-each select="/notification_data/user_for_printing">
					<tr>
						<td>
							<br />
							<xsl:value-of select="first_name"/>&#160;<xsl:value-of select="last_name"/><br />
							<!-- set the barcode values in variables -->
							<!-- set the Barcode NZ, if there are more then only first one is returned -->
							<xsl:variable name="NZ_barcode">
								<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='02']/value"/>
							</xsl:variable>
							<!-- set the Barcode edu-ID, if there are more then only first one is returned -->
							<xsl:variable name="edu-id_barcode">
								<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='01']/value"/>
							</xsl:variable>
							<!-- set the Barcode IZ, if there are more then only first one is returned -->
							<xsl:variable name="IZ_barcode">
								<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='03']/value"/>
							</xsl:variable>
							<!-- set the barcode values in variables -->

							<xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
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
								<xsl:when test="$IZ_barcode != ''">
									<xsl:value-of select="$IZ_barcode"/><br />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='Primary Identifier']/value"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</xsl:for-each>
				<tr>
					<td>
						<br />
						@@dear@@
					</td>
				</tr>
				<tr>
					<td>
						<h>@@inform_loaned_items@@</h>
					</td>
				</tr>
				<xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
					<tr>
						<td>
							<table cellpadding="5" class="listing">
							<xsl:attribute name="style">
								<xsl:call-template name="mainTableStyleCss" />
							</xsl:attribute>
								<tr align="left" bgcolor="#f5f5f5">
									<td>
										<h3>
											<xsl:value-of select="organization_unit/name" />
										</h3>
										<!-- <xsl:if test="organization_unit/address/line1 != ''">
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
										</xsl:if> -->
										<xsl:if test="organization_unit/phone/phone != ''">
											<xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Tel'"/>
											<xsl:with-param name="fr" select="'Tel '"/>
											<xsl:with-param name="it" select="'Tel'"/>
											<xsl:with-param name="de" select="'Tel'"/>
											</xsl:call-template>: <xsl:value-of select="organization_unit/phone/phone"/>
											<br/>
										</xsl:if>
										<xsl:if test="organization_unit/email/email != ''">
											<xsl:value-of select="organization_unit/email/email"/>
										</xsl:if>
									</td>
								</tr>
								<!-- <tr align="left">
									<th>@@title@@</th>
									<th>@@author@@</th>
									<th>@@loan_date@@</th>
									<th>@@due_date@@</th>
									<th>@@library@@</th>
									<th>@@description@@</th>
								</tr> -->

								<xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display">
									<tr>
										<td>
											<strong><xsl:value-of select="substring(item_loan/title, 0, 80)"/><xsl:if test="string-length(item_loan/title) > 80">...</xsl:if></strong>
											<br />
											<xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Barcode'"/>
											<xsl:with-param name="fr" select="'Code-barres'"/>
											<xsl:with-param name="it" select="'Barcode'"/>
											<xsl:with-param name="de" select="'Strichcode'"/>
											</xsl:call-template>: <xsl:value-of select="item_loan/barcode"/>
											<br />
											<xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Call Number'"/>
											<xsl:with-param name="fr" select="'Cote'"/>
											<xsl:with-param name="it" select="'Segnatura'"/>
											<xsl:with-param name="de" select="'Signatur'"/>
											</xsl:call-template>: 
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
												@@description@@: <xsl:value-of select="physical_item_display_for_printing/issue_level_description"/><br />
											</xsl:if>
											<strong>@@loan_date@@: </strong><xsl:value-of select="item_loan/loan_date"/><br />
											<strong>@@due_date@@: </strong><xsl:value-of select="item_loan/due_date"/>
										</td>
										<!-- <td><xsl:value-of select="item_loan/loan_date"/></td>
										<td><xsl:value-of select="item_loan/due_date"/></td> -->
										<!-- <td><xsl:value-of select="item_loan/new_due_date_str"/></td> -->
									</tr>
								</xsl:for-each>
							</table>
							<br />
						</td>
					</tr>
					<!-- <hr/><br/> -->
				</xsl:for-each>
				<tr>
					<td>
						<xsl:call-template name="SLSP-userAccount"/><br />
					</td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="5" border="0">
				<tr><td><br />@@sincerely@@</td></tr>
				<tr><td><br /><xsl:value-of select="notification_data/organization_unit/name" /></td></tr>
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
