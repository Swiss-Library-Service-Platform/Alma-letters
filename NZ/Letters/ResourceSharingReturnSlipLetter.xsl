<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP version 07/2022
    04/2022 - added delivery and sender addresses
    04/2022 - no logo, destination library on top
    04/2022 - hide issue field
    04/2022 - hide sincerely
    05/2022 - sender address as one line; formatted receiver address position with div
    06/2022 - letter types; logo, address and texts shown only for ILL
    07/2022 - request type does not print if pod_id is empty
    10/2022 - added template SLSP-greeting-ILL
    11/2022 - added cid prefix for barcode image
    02/2023 - added pod name
    05/2023 - adapted bottom margin and font size of address to better fit envelope window
    05/2024 - added library code from field Alternate Symbol
    -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:include href="header.xsl"/>
	<xsl:include href="senderReceiver.xsl"/>
	<xsl:include href="mailReason.xsl"/>
	<xsl:include href="footer.xsl"/>
	<xsl:include href="style.xsl"/>
	<xsl:include href="recordTitle.xsl"/>

    <!-- insert transit header without logo -->
    <xsl:template name="head-letterName-only-return-slip">
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
                        <xsl:value-of select="notification_data/partner_name" /> [<xsl:value-of select="notification_data/alternate_symbol" />]
                    </span>
                </td>
            </tr>
            <tr>
                <td>
                    <h1><xsl:value-of select="/notification_data/general_data/subject"/></h1>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- Template to return type of the request
	Possible request types:
		- ILL
		- Rapido
			- Personal Delivery
			- SLSP or local courier-->
    <xsl:template name="request-type">
        <xsl:for-each select="/notification_data/request">
            <xsl:choose>
                <xsl:when test="app_indicator = 'ALMA' and pod_name = ''">ILL</xsl:when><!-- ILL -->
                <xsl:when test="app_indicator = 'NGRS'"><!-- Rapido -->
                    <xsl:choose>    
                        <!-- Rapido personal delivery -->
                        <xsl:when test="contains(/notification_data/pod_name, 'Home Delivery')">Personal Delivery</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="normalize-space(/notification_data/pod_name)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <!-- Transit header with logo and without print date-->
    <xsl:template name="head-letterName-logo">
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
    </xsl:template>

    <!-- Special senderReceiver to extract the Rapido partner information -->
    <xsl:template name="RAPIDO-senderReceiver-returnslip">
        <table width="100%">
            <tr>
                <!-- Sender -->
                <td width="50%" align="left" valign="top" style="padding: 10mm 10mm 10mm 10mm;">
                    <xsl:for-each select="/notification_data/library">
                        <table>
                            <xsl:attribute name="style">
                                font-size: 9pt;
                                <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                            </xsl:attribute>
                            <xsl:if test="string-length(address/line1)!=0">
                                <tr><td><xsl:value-of select="address/line1"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line2)!=0">
                                <tr><td><xsl:value-of select="address/line2"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line3)!=0">
                                <tr><td><xsl:value-of select="address/line3"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line4)!=0">
                                <tr><td><xsl:value-of select="address/line4"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line5)!=0">
                                <tr><td><xsl:value-of select="address/line5"/></td></tr>
                            </xsl:if>
                            <tr><td><xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></td></tr>
                            <xsl:if test="address/country != ''">
                                <tr><td><xsl:value-of select="address/country_display"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(phone/phone)!=0">
                                <tr><td><xsl:value-of select="phone/phone"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(email/email)!=0">
                                <tr><td><xsl:value-of select="email/email"/></td></tr>
                            </xsl:if>
                        </table>
                    </xsl:for-each>
                </td>
                <!-- Receiver -->
                <td width="50%" align="left" style="padding: 10mm 10mm 10mm 15mm; vertical-align: top;">
                    <table cellspacing="0" cellpadding="0" border="0">
                        <xsl:attribute name="style">
                            font-weight: 600;font-size: 10pt;
                            <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                        </xsl:attribute>
                        <xsl:for-each select="/notification_data/partner_address">
                            <xsl:if test="string-length(line1)!=0">
                                <tr><td><xsl:value-of select="line1"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line2)!=0">
                                <tr><td><xsl:value-of select="line2"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line3)!=0">
                                <tr><td><xsl:value-of select="line3"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line4)!=0">
                                <tr><td><xsl:value-of select="line4"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line5)!=0">
                                <tr><td><xsl:value-of select="line5"/></td></tr>
                            </xsl:if>
                            <xsl:if test="postal_code != '' or city != ''">
                                <tr><td>
                                    <xsl:if test="postal_code != ''">
                                        <xsl:value-of select="postal_code"/>&#160;
                                    </xsl:if>
                                    <xsl:if test="city != ''">
                                        <xsl:value-of select="city"/>
                                    </xsl:if>
                                </td></tr>
                            </xsl:if>
                            <xsl:if test="country_display != ''">
                                <tr><td><xsl:value-of select="country_display"/></td></tr>
                            </xsl:if>
                        </xsl:for-each>
                    </table>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- Special senderReceiver to extract the Rapido partner information
        Delivery on the left side -->
    <xsl:template name="RAPIDO-senderReceiver-returnslip-reversed">
        <table width="100%">
            <tr>
                <!-- Receiver -->
                <td width="50%" align="left" style="padding: 10mm 5mm 10mm 10mm;vertical-align: top;">
                    <table cellspacing="0" cellpadding="0" border="0">
                        <xsl:attribute name="style">
                            font-weight: 600;font-size: 10pt;
                            <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                        </xsl:attribute>
                        <xsl:for-each select="/notification_data/partner_address">
                            <xsl:if test="string-length(line1)!=0">
                                <tr><td><xsl:value-of select="line1"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line2)!=0">
                                <tr><td><xsl:value-of select="line2"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line3)!=0">
                                <tr><td><xsl:value-of select="line3"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line4)!=0">
                                <tr><td><xsl:value-of select="line4"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line5)!=0">
                                <tr><td><xsl:value-of select="line5"/></td></tr>
                            </xsl:if>
                            <xsl:if test="postal_code != '' or city != ''">
                                <tr><td>
                                    <xsl:if test="postal_code != ''">
                                        <xsl:value-of select="postal_code"/>&#160;
                                    </xsl:if>
                                    <xsl:if test="city != ''">
                                        <xsl:value-of select="city"/>
                                    </xsl:if>
                                </td></tr>
                            </xsl:if>
                            <xsl:if test="country_display != ''">
                                <tr><td><xsl:value-of select="country_display"/></td></tr>
                            </xsl:if>
                        </xsl:for-each>
                    </table>
                </td>
                <!-- Sender -->
                <td width="50%" align="left" valign="top" style="padding: 10mm 10mm 10mm 15mm;vertical-align: top;">
                    <xsl:for-each select="/notification_data/library">
                        <table>
                            <xsl:attribute name="style">
                                font-size: 9pt;
                                <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                            </xsl:attribute>
                            <xsl:if test="string-length(address/line1)!=0">
                                <tr><td><xsl:value-of select="address/line1"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line2)!=0">
                                <tr><td><xsl:value-of select="address/line2"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line3)!=0">
                                <tr><td><xsl:value-of select="address/line3"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line4)!=0">
                                <tr><td><xsl:value-of select="address/line4"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line5)!=0">
                                <tr><td><xsl:value-of select="address/line5"/></td></tr>
                            </xsl:if>
                            <tr><td><xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></td></tr>
                            <xsl:if test="address/country != ''">
                                <tr><td><xsl:value-of select="address/country_display"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(phone/phone)!=0">
                                <tr><td><xsl:value-of select="phone/phone"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(email/email)!=0">
                                <tr><td><xsl:value-of select="email/email"/></td></tr>
                            </xsl:if>
                        </table>
                    </xsl:for-each>
                </td>
            </tr>
        </table>
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

				<xsl:call-template name="generalStyle"/>
			</head>
			<body>
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss"/>
				</xsl:attribute>

				<div class="messageArea" style="clear: both;">
					<div class="messageBody">
                        <xsl:variable name="requestType">
                            <xsl:call-template name="request-type" />
                        </xsl:variable>
                        <xsl:choose>
                            <!-- ILL -->
                            <xsl:when test="$requestType = 'ILL'">
                                <xsl:call-template name="head-letterName-logo"/>
                                <xsl:call-template name="RAPIDO-senderReceiver-returnslip"/>
                            </xsl:when>
                            <!-- SLSP Courier, Local couriers, Personal Delivery -->
                            <xsl:otherwise>
                                <xsl:call-template name="head-letterName-only-return-slip"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
                            <!-- SLSP: show return text for ILL -->
                            <xsl:if test="$requestType = 'ILL'">
                                <tr>
                                    <td>
                                        <xsl:call-template name="SLSP-greeting-ILL" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        @@returned@@
                                    </td>
                                </tr>
                            </xsl:if>
                            <!-- SLSP: do not show from and request type for ILL -->
                            <xsl:if test="$requestType != 'ILL'">
                                <tr>
                                    <td style="padding-bottom: 10px">
                                        <strong><xsl:call-template name="SLSP-multilingual">
                                                <xsl:with-param name="en" select="'From'"/>
                                                <xsl:with-param name="fr">
                                                    <![CDATA[Depuis]]>
                                                </xsl:with-param>
                                                <xsl:with-param name="it" select="'Da'"/>
                                                <xsl:with-param name="de" select="'Von'"/>
                                            </xsl:call-template>: </strong>
                                        <!-- Sender library and IZ -->
                                        <xsl:value-of select="/notification_data/organization_unit/name"/> - <xsl:value-of select="/notification_data/library/name"/>
                                        <br/>
                                        <xsl:call-template name="request-type"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <tr>
								<td style="padding-bottom: 10px">
                                    <strong>@@request_id@@:</strong><br />
                                    <img>
                                        <xsl:attribute name="src">cid:externalId.png</xsl:attribute>
										<xsl:attribute name="alt"><xsl:value-of select="notification_data/request/external_request_id"/></xsl:attribute>
                                    </img>
                                </td>
							</tr>
                            <tr>
								<td style="padding-bottom: 10px">
									<strong>@@required_return_date@@: </strong><xsl:value-of select="notification_data/request/due_date"/><br />
                                    <strong>@@arrival_date@@: </strong><xsl:value-of select="notification_data/request/item_arrival_date"/><br />
                                    <strong><xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Print date'"/>
											<xsl:with-param name="fr">
                                                <![CDATA[Date d'impression]]>
                                            </xsl:with-param>
											<xsl:with-param name="it" select="'Data stampa'"/>
											<xsl:with-param name="de" select="'Druckdatum'"/>
										</xsl:call-template>: </strong><xsl:value-of select="notification_data/general_data/current_date"/>&#160;<xsl:value-of select="substring(/notification_data/general_data/current_time, 1, 5)"/>
                                    <xsl:if test="notification_data/note_to_partner != ''">
                                        <br />
                                        <strong>@@note_to_partner@@: </strong>
                                        <xsl:value-of select="notification_data/note_to_partner"/>
                                    </xsl:if>
								</td>
							</tr>
							<xsl:if test="notification_data/request/return_info !=''">
								<tr>
									<td style="padding-bottom: 10px">
										<xsl:value-of select="notification_data/request/return_info"/>
									</td>
								</tr>
							</xsl:if>
                            <xsl:for-each select="notification_data/request/display">
                                <tr>
                                    <td style="padding-bottom: 10px">
                                        <strong><xsl:value-of select="title"/></strong>
                                        <xsl:if test="author != ''">
                                            <br />
                                            <xsl:value-of select="author"/>
                                        </xsl:if>
                                        <xsl:if test="place_of_publication != '' and publisher != '' and publication_date != ''">
                                            <br /><xsl:value-of select="place_of_publication"/>:&#160;<xsl:value-of select="publisher"/>,&#160;<xsl:value-of select="publication_date"/>
                                        </xsl:if>
                                    </td>
                                </tr>
                                
                                <xsl:if test="journal_title != ''">
                                    <tr>
                                        <td style="padding-bottom: 10px">
                                            <strong>@@journal_title@@: </strong>
                                            <xsl:value-of select="journal_title"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="volume != ''">
                                    <tr>
                                        <td style="padding-bottom: 10px">
                                            <strong>@@volume@@: </strong>
                                            <xsl:value-of select="volume"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:if test="$requestType = 'ILL'">
                                <tr>
                                    <td>
                                        @@signature@@
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <xsl:value-of select="notification_data/library/name"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td><br/><i>powered by SLSP</i></td>
                                </tr>
                            </xsl:if>                            
						</table>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
