<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized 02/2025

    Dependance:
        header.xsl - head
        senderReceiver.xsl - senderReceiver
        style - bodyStyleCss, generalStyle, mainTableStyleCss
        recordTitle - SLSP-greeting
 -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:include href="header.xsl" />
    <xsl:include href="senderReceiver.xsl" />
    <xsl:include href="mailReason.xsl" />
    <xsl:include href="footer.xsl" />
    <xsl:include href="style.xsl" />
    <xsl:include href="recordTitle.xsl" />

<!-- Prints the IZ message stored in label 'department' for the language of the letter.
		If value in the label is empty or with value "blank" does not print anything.
		The label can contain also HTML markup such as links or formatting.
		Usage:
			1. Configure the label department with text in all languages.
			2. <<already done by SLSP in this letter>>Insert the template: <xsl:call-template name="SLSP-IZMessage"/> -->
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

<!-- Template to output the delivery address only, on the right side -->
<xsl:template name="senderReceiver-receiver-only">
	<table cellspacing="0" border="0" width="100%">
		<tr>
			<td width="50%"  align="left"></td>
			<td width="50%" align="left" style="padding: 10mm 10mm 10mm 15mm;">
				<table cellspacing="0" cellpadding="0" border="0">
					<xsl:attribute name="style">
						font-weight: 600;font-size: 10pt;
						<xsl:call-template name="listStyleCss" />
						<!-- style.xsl -->
					</xsl:attribute>
					<tr>
						<td>
							<xsl:value-of select="/notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="/notification_data/user_for_printing/last_name"/>
						</td>
					</tr>
					<xsl:if test="string-length(/notification_data/user_for_printing/address1)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address1"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address2)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address2"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address3)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address3"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address4)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address4"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address5)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address5"/>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<td>
							<xsl:value-of select="/notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="/notification_data/user_for_printing/city"/>
						</td>
					</tr>
					<!-- There is a known bug when there is no country chosen for the user. this change in the letter component called "SenderReceiver.xsl" will do the trick -->
					<tr>
						<td>
							<xsl:choose>
								<xsl:when test="/notification_data/user_for_printing/country = 'Null'">
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:when test="/notification_data/user_for_printing/country = 'CHE'">
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/notification_data/user_for_printing/country"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</xsl:template>

<!-- Template to print only delivery address only, on right side -->
<xsl:template name="senderReceiver-receiver-only-reversed">
	<table cellspacing="0" border="0" width="100%">
		<tr>
			<td width="50%"  align="left" style="padding: 10mm 10mm 10mm 10mm;">
				<table cellspacing="0" cellpadding="0" border="0">
					<xsl:attribute name="style">
						font-weight: 600;font-size: 10pt;
						<xsl:call-template name="listStyleCss" />
						<!-- style.xsl -->
					</xsl:attribute>
					<tr>
						<td>
							<xsl:value-of select="/notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="/notification_data/user_for_printing/last_name"/>
						</td>
					</tr>
					<xsl:if test="string-length(/notification_data/user_for_printing/address1)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address1"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address2)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address2"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address3)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address3"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address4)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address4"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address5)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address5"/>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<td>
							<xsl:value-of select="/notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="/notification_data/user_for_printing/city"/>
						</td>
					</tr>
					<!-- There is a known bug when there is no country chosen for the user. this change in the letter component called "SenderReceiver.xsl" will do the trick -->
					<tr>
						<td>
							<xsl:choose>
								<xsl:when test="/notification_data/user_for_printing/country = 'Null'">
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:when test="/notification_data/user_for_printing/country = 'CHE'">
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/notification_data/user_for_printing/country"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</table>
			</td>
			<td width="50%" align="left" ></td>
		</tr>
	</table>
	<br />
	<br />
</xsl:template>

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
                    <xsl:call-template name="bodyStyleCss" />;font-size: 100%;
                </xsl:attribute>

                <xsl:call-template name="head" /><!-- header.xsl -->
                <!-- Show patron address only for special cases - user group 92 -->
                <xsl:if test="notification_data/user_for_printing/user_group = '92'">
                    <xsl:call-template name="senderReceiver-receiver-only" />
                </xsl:if>
                <br />
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
                        <xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                            <xsl:with-param name="en" select="'User ID'"/>
                            <xsl:with-param name="fr" select="'ID utilisateur'"/>
                            <xsl:with-param name="it" select="'ID utente'"/>
                            <xsl:with-param name="de" select="'Benutzer-ID'"/>
                        </xsl:call-template>:&#160;<xsl:choose>
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
                        <br/>
                    </p>
                </div>
                <br />


                <div class="messageArea">
                    <div class="messageBody">
                        <p>
                            <xsl:call-template name="SLSP-greeting" />
                        </p>
                        <p>
                            @@message@@
                        </p>
                        <table cellpadding="5" class="listing" width="100%">
                            <xsl:attribute name="style">
                                <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
                            </xsl:attribute>
                            <tr>
                                <th>@@title@@</th>
                                <th>@@due_date@@</th>
                                <th>@@library@@</th>
                            </tr>

                            <xsl:for-each select="notification_data/item_loans/item_loan">
                                <tr>
                                    <td>
                                        <xsl:value-of select="substring(title, 0, 70)"/>
                                        <xsl:if test="string-length(title) > 70">...</xsl:if>
                                        <br />
                                        <xsl:if test="author != ''">
                                            <xsl:value-of select="author"/>
                                            <br />
                                        </xsl:if>
                                        <strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                                            <xsl:with-param name="en" select="'Barcode'"/>
                                            <xsl:with-param name="fr" select="'Code-barres'"/>
                                            <xsl:with-param name="it" select="'Barcode'"/>
                                            <xsl:with-param name="de" select="'Strichcode'"/>
                                        </xsl:call-template>:</strong>&#160;<xsl:value-of select="barcode"/>
                                        <xsl:choose>
                                            <xsl:when test="physical_item/temporary_physical_location_in_use = 'true'
                                            and item_loan/physical_item/temporary_call_number != ''">
                                                <br />
                                                <strong>@@call_number@@: </strong><xsl:value-of select="item_loan/physical_item/temporary_call_number"/>
                                            </xsl:when>
                                            <xsl:when test="physical_item/display_alternative_call_number != ''">
                                                <br />
                                                <strong>@@call_number@@: </strong><xsl:value-of select="physical_item/display_alternative_call_number"/>
                                            </xsl:when>
                                            <xsl:when test="physical_item/call_number != ''">
                                                <br />
                                                <strong>@@call_number@@: </strong><xsl:value-of select="physical_item/call_number"/>
                                            </xsl:when>
                                        </xsl:choose>
                                        <xsl:if test="description !='' and description != 'Vol.' and description != '_'">
                                            <br />
                                            <strong>@@description@@: </strong>
                                            <xsl:value-of select="description"/>
                                        </xsl:if>
                                    </td>
                                    <td><xsl:value-of select="due_date"/></td>
                                    <td><xsl:value-of select="library_name"/></td>
                                </tr>
                            </xsl:for-each>

                        </table>
                        <p>
                            <xsl:call-template name="SLSP-IZMessage"/>
                        </p>
                        <p>
                            <xsl:call-template name="SLSP-userAccount"/>
                        </p>
                        <p>
                            <br />@@sincerely@@
                        </p>
                        <p>
                            <xsl:value-of select="/notification_data/organization_unit/name" />
                        </p>
                        <p>
                            <br /><i>powered by SLSP</i>
                        </p>
                    </div>
                </div>

                <!-- footer.xsl -->
                <!-- <xsl:call-template name="lastFooter" /> -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
