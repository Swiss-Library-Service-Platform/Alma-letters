<?xml version="1.0" encoding="utf-8"?>
<!--
    IZ Customization: Print delivery address if available in any loan on the receipt

    WG: Letters 05/2022
	12/2022 Added SLSP greeting template
	05/2023 Added IZ message template -->
<!-- Dependance:
		recordTitle - SLSP-multilingual, SLSP-userAccount, SLSP-IZMessage
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

<!-- Prints the IZ message stored in label 'department' for the language of the letter.
		If value in the label is empty or with value "blank" does not print anything.
		The label can contain also HTML markup such as links or formatting.
		Warning: the label 'department' has to be available in the letter for this template to work	
		Usage:
			1. Configure the label department with text in all languages.
			2. Insert the template: <xsl:call-template name="IZMessage"/> -->
<xsl:template name="SLSP-IZMessage">
	<xsl:variable name="notice">@@department@@</xsl:variable>
	<xsl:if test="$notice != '' and $notice != 'blank'">
		<strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
			<xsl:with-param name="en" select="'Notice of the library'"/>
			<xsl:with-param name="fr" select="'Avis de la bibliothèque'"/>
			<xsl:with-param name="it" select="'Comunicazione della biblioteca'"/>
			<xsl:with-param name="de" select="'Notiz der Bibliothek'"/>
		</xsl:call-template>:</strong>&#160;<xsl:value-of select="$notice" disable-output-escaping="yes" />
	</xsl:if>
</xsl:template>

<!-- Address template printing delivery address on the right side
	The sender address is with smaller font and the delivery address is bold
    Adapted for this letter to print delivery address from the loan -->
<xsl:template name="senderReceiver-personal-delivery-right">
    <table cellspacing="0" border="0" width="100%">
        <tr>
            <!-- sender -->
            <td width="50%" align="left" style="padding: 10mm 10mm 10mm 10mm;">
                <xsl:for-each select="/notification_data/organization_unit/address">
                    <table>
                    <xsl:attribute name="style">
                        font-size: 9pt;
                        <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                    </xsl:attribute>
                        <tr><td><xsl:value-of select="line1"/></td></tr>
                        <tr><td><xsl:value-of select="line2"/></td></tr>
                        <xsl:if test="string-length(line3)!=0">
                            <tr><td><xsl:value-of select="line3"/></td></tr>
                        </xsl:if>
                        <xsl:if test="string-length(line4)!=0">
                            <tr><td><xsl:value-of select="line4"/></td></tr>
                        </xsl:if>
                        <xsl:if test="string-length(line5)!=0">
                            <tr><td><xsl:value-of select="line5"/></td></tr>
                        </xsl:if>
                        <tr><td><xsl:value-of select="postal_code"/>&#160;<xsl:value-of select="city"/></td></tr>
                        <xsl:if test="../phone/phone!=''">  
                            <tr><td><xsl:value-of select="../phone/phone"/></td></tr> 
                        </xsl:if>
                        <xsl:if test="../email/email!=''">
                            <tr><td><xsl:value-of select="../email/email"/></td></tr> 
                        </xsl:if>
                    </table>
                </xsl:for-each>
            </td>
            <!-- receiver -->
            <td width="50%"  align="left" style="padding: 10mm 10mm 10mm 15mm; vertical-align: top;">
                <xsl:choose>
                    <xsl:when test="notification_data/user_for_printing">
                        <xsl:variable name="deliveryAddressRaw" select="notification_data/items/item_loan/delivery_address[.!='']"/>   
                        <table cellspacing="0" cellpadding="0" border="0">
                            <xsl:attribute name="style">
                                font-weight: 600;font-size: 10pt;
                                <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                            </xsl:attribute>
                            <tr>
                                <td>
                                    <xsl:if test="notification_data/user_for_printing/first_name != ''">
                                        <xsl:value-of select="notification_data/user_for_printing/first_name"/>&#160;</xsl:if><xsl:value-of select="notification_data/user_for_printing/last_name"/>
                                </td>
                            </tr>
                            <xsl:if test="count(str:tokenize($deliveryAddressRaw,'&#10;'))>4">
                            <tr>
                                <td>
                                    <xsl:value-of select="str:tokenize($deliveryAddressRaw,'&#10;')[2]"/>
                                </td>
                            </tr>
                            </xsl:if>
                            <xsl:if test="count(str:tokenize($deliveryAddressRaw,'&#10;'))>5">
                            <tr>
                                <td>
                                    <xsl:value-of select="str:tokenize($deliveryAddressRaw,'&#10;')[3]"/>
                                </td>
                            </tr>
                            </xsl:if>
                            <xsl:if test="count(str:tokenize($deliveryAddressRaw,'&#10;'))>6">
                            <tr>
                                <td>
                                    <xsl:value-of select="str:tokenize($deliveryAddressRaw,'&#10;')[4]"/>
                                </td>
                            </tr>
                            </xsl:if>
                            <xsl:if test="count(str:tokenize($deliveryAddressRaw,'&#10;'))>7">
                            <tr>
                                <td>
                                    <xsl:value-of select="str:tokenize($deliveryAddressRaw,'&#10;')[5]"/>
                                </td>
                            </tr>
                            </xsl:if>
                            <tr>
                                <td>
                                    <xsl:variable name="number_code" select="count(str:tokenize($deliveryAddressRaw,'&#10;'))-1" />
                                    <xsl:variable name="number_city" select="count(str:tokenize($deliveryAddressRaw,'&#10;'))-2" />
                                    <xsl:value-of select="str:tokenize($deliveryAddressRaw,'&#10;')[$number_code]"/><xsl:value-of select="str:tokenize($deliveryAddressRaw,'&#10;')[$number_city]"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <xsl:variable name="number_country" select="count(str:tokenize($deliveryAddressRaw,'&#10;'))" />
                                    <xsl:if test="str:tokenize($deliveryAddressRaw,'&#10;')[$number_country]!=' CHE'">
                                        <xsl:value-of select="str:tokenize($deliveryAddressRaw,'&#10;')[$number_country]"/>
                                    </xsl:if>
                                </td>
                            </tr>
                        </table>
                    </xsl:when>
                    <xsl:when test="notification_data/receivers/receiver/user">
                        <xsl:for-each select="notification_data/receivers/receiver/user">
                            <table>
                            <xsl:attribute name="style">
                                font-weight: 600;font-size: 10pt;
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
    <br />
    <br />
</xsl:template>

	<xsl:template match="/">
	<html>
		<head>
			<xsl:call-template name="generalStyle" />
		</head>
		<body>
		<xsl:attribute name="style">
			<xsl:call-template name="bodyStyleCss" />
		</xsl:attribute>

		<xsl:call-template name="head" />
        <!-- returns false when all delivery_address elements are empty, true if there is at least one loan with delivery address -->
        <xsl:if test="not(notification_data/items/item_loan/delivery_address[not(.!='')])">
            <!-- <xsl:value-of select="notification_data/items/item_loan/delivery_address[.!='']"/> -->
            <xsl:call-template name="senderReceiver-personal-delivery-right"/>
        </xsl:if>
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
						<xsl:call-template name="SLSP-greeting" />
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
									</tr>
								</xsl:for-each>
							</table>
							<br />
						</td>
					</tr>
				</xsl:for-each>
				<tr>
					<td>
						<xsl:call-template name="SLSP-IZMessage"/>
					</td>
				</tr>
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
